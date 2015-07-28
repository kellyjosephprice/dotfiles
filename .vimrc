" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Adoptor:      Kelly Price <kellyjosephprice@gmail.com>
" Last change:	2012 Oct 08
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set backup		            " keep a backup file
set backupdir=~/.vim/backup " keep backups here
set directory=~/.vim/tmp	" keep swaps here
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
set history=50		        " keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching

set expandtab		" no real tabs
set shiftwidth=4	" autoindent width
set tabstop=4		" tab width
set softtabstop=4   " treat 4 spaces as tabs

set hidden
set showmatch

set so=3            " scrolloff
set textwidth=72    " wraps text
set number          " display line number

set splitright

" auto-complte menu
set completeopt=longest,menuone	" auto-completion magic
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

autocmd FileType ruby       set shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType eruby      set shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript set shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType jst        set shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType coffee     set shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html       set shiftwidth=2 tabstop=2 softtabstop=2

au BufNewFile,BufRead *.ejs		set filetype=jst
au BufNewFile,BufRead *.jst  		set filetype=jst
au BufNewFile,BufRead *.hamljs set filetype=jst

" perly stuff
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

" my perl includes pod
let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

"define :Tidy command to run perltidy on visual selection || entire buffer"
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy

"run :Tidy on entire buffer and return cursor to (approximate) original position"
fun DoTidy()
    let Pos = line2byte( line( "." ) ) 
    :Tidy
    exe "goto " . Pos 
endfun

"shortcut for normal mode to run on entire buffer then return to current line"
au Filetype perl nmap <F2> :call DoTidy()<CR>

"shortcut for visual mode to run on the the current visual selection"
au Filetype perl vmap <F2> :Tidy<CR>

" markdown to html
map <F3> :%!markdown<CR>

" easy access to beginning and end of line
noremap - $
noremap _ ^

set laststatus=2
let g:airline_powerline_fonts = 1
set encoding=utf-8

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
  syntax on
  set background=dark
  colorscheme solarized
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

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

  autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * 
    \ call system("tmux rename-window " . expand("%:t"))

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

