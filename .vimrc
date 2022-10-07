set nocompatible               " be iMproved
filetype off                   " required!
" set rtp+=~/tools/powerline/powerline/bindings/vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
let g:vundle_default_git_proto='git'

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'majutsushi/tagbar'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}


call vundle#end()
" ==========================================================
" Shortcuts
" ==========================================================

" sudo write this
cmap W! w !sudo tee % >/dev/null

" Use par for prettier line formatting
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w72"

set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" don't bell or blink
set noerrorbells
set vb t_vb=

" ==========================================================
" Basic Settings
" ==========================================================
let mapleader=","             " change the leader to be a comma vs slash
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
set background=dark           " dark background
" colorscheme codedark
set number                    " Display line numbers
set relativenumber            " relative line numbering
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set mouse=a                   " allow mouse scroll

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move pcostast the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " Wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " an indent level is 4 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set formatoptions=tcroql    " Setting text and comment formatting to auto
" set textwidth=120            " Lines are automatically wrapped after 120 columns
set linespace=3             " The spacing between lines is a little roomier

"""" Reading/Writing
set autowrite               " Stop complaining about unsaved buffers
set autowriteall            " I'm serious...
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set nofoldenable            " Disable folding, because recently `zO` has been the command I use most frequently

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set laststatus=2            " Always show statusline, even if only 1 window.

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex
" set path+=**

" Don't create swapfiles
set noswapfile

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


autocmd FileType markdown setlocal syntax=off
autocmd FileType markdown setlocal wrap
autocmd FileType markdown setlocal cursorline&

" Allow for undo even after closing and re-opening a file
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" Make diffs *really* obvious
hi DiffText gui=underline guibg=red guifg=black

" Set CtrlP to search by filename rather than path
" let g:ctrlp_by_filename = 0
" Preview Markdown files with QuickLook
" map <Leader>v :write<cr>:sil !/usr/bin/qlmanage -p % > /dev/null &<cr>:redraw!<cr>
" set guifont=Sauce\ Code\ Powerline:h14

" show colorcolumn only on the lines that is longer than 100 charactors
highlight ColorColumn ctermbg=DarkRed
call matchadd('ColorColumn', '\%100v', 100)


" ==========================================================
" Key Mappings
" ==========================================================



" Toggle Nerdtree
map <leader>e :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>


" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" ctrl-jklm to navigate between split buffers
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" and lets make these all work in insert mode too ( <C-O> makes next cmd
"  happen as if in command mode )
imap <C-W> <C-O><C-W>



" Open window splits in various places
nmap <leader>sh :leftabove  vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove  new<CR>
nmap <leader>sj :rightbelow new<CR>

" Auto-center
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap { {zz
nmap } }zz


" toggle tagbar
nmap <leader>t :TagbarToggle<CR>

" toggle indent line
nmap <leader>in :IndentLinesToggle<CR>

" toggle fugitive Gstatus
nmap <leader>g :Git<CR>



" Cycle through open buffers with Control + Spacebar
map <C-n> :bn <CR>
map <C-b> :bp <CR>

" Paste from system clipboard
map <leader>p "+p

" hide matches on <leader>space (rather than searching for something like " 'asdf')
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>
" Set working directory to directory of file being edited
nnoremap <leader>. :lcd %:p:h<CR>

" Break line in normal mode
nnoremap <NL> i<CR><ESC>

" Break long line by comma
" nnoremap gob  :s/\((\zs\\|,\ *\zs\\|)\)/\r&/g<CR><Bar>:'[,']normal ==<CR>

" Fuzzy find files
nnoremap <silent> <Leader><cr> :CtrlP<CR>
let g:ctrlp_max_files=0


set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = ' '

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']


set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:indentLine_char = "┆"

highlight CocErrorFloat ctermfg=Black
" highlight CocInfoFloat ctermfg=Black
highlight CocHintFloat ctermfg=Black
highlight CocWarningFloat ctermfg=Black
