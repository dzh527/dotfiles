#!/usr/bin/env bash

set -Eeuo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/dzh527/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)}"
DRY_RUN=0
SKIP_BREW=0
SKIP_MACOS=0
DID_BACKUP=0

usage() {
  cat <<'EOF'
Usage: bootstrap.sh [options]

Set up a new macOS machine from this dotfiles repository.

Options:
  --dry-run       Print actions without changing the machine
  --skip-brew     Skip Homebrew and Brewfile installation
  --skip-macos    Skip macOS defaults
  -h, --help      Show this help

Environment:
  DOTFILES_REPO   Git repository to clone on a fresh machine
  DOTFILES_DIR    Checkout location (default: ~/dotfiles)
EOF
}

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mWarning:\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31mError:\033[0m %s\n' "$*" >&2; exit 1; }

run() {
  if (( DRY_RUN )); then
    printf '+ '
    printf '%q ' "$@"
    printf '\n'
  else
    "$@"
  fi
}

while (( $# )); do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --skip-brew) SKIP_BREW=1 ;;
    --skip-macos) SKIP_MACOS=1 ;;
    -h|--help) usage; exit 0 ;;
    *) die "Unknown option: $1" ;;
  esac
  shift
done

[[ "$(uname -s)" == "Darwin" ]] || die "This script only supports macOS."

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

ensure_command_line_tools() {
  if xcode-select -p >/dev/null 2>&1; then
    return
  fi

  warn "Apple Command Line Tools are not installed."
  if (( DRY_RUN )); then
    run xcode-select --install
    return
  fi
  xcode-select --install
  die "Finish the Command Line Tools installer, then run this script again."
}

ensure_dotfiles_checkout() {
  if [[ -f "$SCRIPT_DIR/Brewfile" && -d "$SCRIPT_DIR/.git" ]]; then
    DOTFILES_DIR="$SCRIPT_DIR"
    return
  fi

  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    log "Updating dotfiles"
    run git -C "$DOTFILES_DIR" pull --ff-only
  elif [[ -e "$DOTFILES_DIR" ]]; then
    die "$DOTFILES_DIR exists but is not a Git checkout. Move it or set DOTFILES_DIR."
  else
    log "Cloning dotfiles"
    run git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  fi
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  log "Installing Homebrew"
  if (( DRY_RUN )); then
    printf '+ Homebrew official installer\n'
    return
  fi
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    die "Homebrew installed, but brew is not on PATH."
  fi
}

install_packages() {
  log "Installing Homebrew packages and applications"
  run brew bundle --no-upgrade --file "$DOTFILES_DIR/Brewfile"
}

install_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    return
  fi

  log "Installing Oh My Zsh"
  run git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
}

backup_conflict() {
  local source="$1"
  local target="$2"

  # Existing links into this package are already owned by Stow.
  if [[ -e "$target" && "$target" -ef "$source" ]]; then
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    local relative_target="${target#"$HOME"/}"
    DID_BACKUP=1
    log "Backing up $target"
    run mkdir -p "$BACKUP_DIR/$(dirname "$relative_target")"
    run mv "$target" "$BACKUP_DIR/$relative_target"
  fi
}

stow_dotfiles() {
  command -v stow >/dev/null 2>&1 || die "GNU Stow is required. Run without --skip-brew first."

  log "Backing up files that conflict with the Stow package"

  local files=(
    .zshrc
    .zsh_aliases
    .zsh_functions
    .tmux.conf
    .aerospace.toml
    .gitconfig
  )
  local file
  for file in "${files[@]}"; do
    backup_conflict "$DOTFILES_DIR/$file" "$HOME/$file"
  done

  backup_conflict "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

  log "Linking dotfiles with GNU Stow"
  run stow \
    --restow \
    --dir "$DOTFILES_DIR" \
    --target "$HOME" \
    .
}

apply_macos_defaults() {
  log "Applying macOS defaults"

  run defaults write NSGlobalDomain KeyRepeat -int 2
  run defaults write NSGlobalDomain InitialKeyRepeat -int 15
  run defaults write com.apple.dock autohide -bool true

  if (( ! DRY_RUN )); then
    killall Dock >/dev/null 2>&1 || true
  fi
}

print_next_steps() {
  if (( DRY_RUN )); then
    log "Dry run complete; no changes were made"
  else
    log "Setup complete"
  fi
  cat <<'EOF'

Manual steps that intentionally remain:
  1. Sign in to App Store/iCloud and work applications.
  2. Install or enroll company-managed VPN and security software.
  3. Restore SSH keys securely, then run: ssh -T git@github.com
  4. Open installed GUI applications once and grant requested permissions.
  5. Restart the terminal (or run: exec zsh).
EOF

  if (( DID_BACKUP )); then
    if (( DRY_RUN )); then
      printf 'Existing files would be backed up to: %s\n' "$BACKUP_DIR"
    else
      printf 'Existing files were backed up to: %s\n' "$BACKUP_DIR"
    fi
  fi
}

main() {
  ensure_command_line_tools
  ensure_dotfiles_checkout

  if (( ! SKIP_BREW )); then
    ensure_homebrew
    install_packages
  fi

  install_oh_my_zsh
  stow_dotfiles

  if (( ! SKIP_MACOS )); then
    apply_macos_defaults
  fi

  print_next_steps
}

main
