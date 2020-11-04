" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

"Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf'
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'

Plug 'aliou/sql-heredoc.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'powerman/vim-plugin-AnsiEsc'

"Plug 'mindriot101/vim-yapf'
"Plug 'Vimjas/vim-python-pep8-indent'
call plug#end()

let mapleader = "\\"

let g:vim_json_syntax_conceal = 0
let g:vim_jsx_pretty_colorful_config = 1

let g:airline_powerline_fonts = 1
let g:airline_theme = 'angr'

set re=1

set backspace=indent,eol,start
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
set history=50
set ruler
set showcmd
set incsearch

set path=.,,**

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set hidden
set showmatch

set so=3
set relativenumber

set textwidth=72
set colorcolumn=+1
set synmaxcol=2048

set splitright

"set clipboard+=unnamedplus

au BufNewFile,BufRead *.plist set filetype=xml

autocmd FileType python set tabstop=4

au BufRead,BufNewFile *.god set filetype=ruby

" markdown to html
map <F3> :%!markdown<CR>

" Stop using arrow keys!
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

set laststatus=2

set encoding=utf-8

set cmdheight=2

" Print Options
set printoptions=header:0,syntax:n,paper:letter,formfeed:y

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set termguicolors
  syntax on
  set background=dark
  let ayucolor="mirage"
  colorscheme ayu
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  autocmd BufWritePost *.py call Yapf()

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  "autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
  "autocmd VimLeave * call system("tmux rename-window zsh")
  autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
  set title

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
