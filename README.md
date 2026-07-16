# macOS setup

Personal macOS configuration and a repeatable new-machine bootstrap.

## Fresh machine

Run the bootstrap directly from GitHub:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/dzh527/dotfiles/main/bootstrap.sh)
```

The script installs Apple Command Line Tools (when missing), Homebrew packages,
Oh My Zsh, links the dotfiles with GNU Stow, and applies a small set of macOS preferences. It
is safe to run repeatedly. Existing config files are moved to a timestamped
directory under `~/.dotfiles-backup` before links are created.

Preview all actions without making changes:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/dzh527/dotfiles/main/bootstrap.sh) --dry-run
```

If the repository is already cloned:

```bash
./bootstrap.sh
```

Useful options:

```text
--dry-run       Print actions without changing the machine
--skip-brew     Skip Homebrew and Brewfile installation
--skip-macos    Skip macOS defaults
```

Company enrollment, account sign-in, and SSH private-key restoration remain
manual by design. The script prints that checklist when it finishes.
