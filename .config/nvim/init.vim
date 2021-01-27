" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nocompatible

call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug'

Plug 'sheerun/vimrc'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/gruvbox-material'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'angr'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-eslint'
  \ ]
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

set updatetime=300
set shortmess+=c

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

Plug 'aliou/sql-heredoc.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'preservim/nerdcommenter'
call plug#end()

let mapleader = ","

set re=0
set showcmd
set splitright
set clipboard+=unnamedplus

set textwidth=79
set fo+=t

" markdown to html
map <F3> :%!markdown<CR>

" Stop using arrow keys!
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

set cmdheight=2

" Print Options
set printoptions=header:0,syntax:n,paper:letter,formfeed:y

" Don't use Ex mode, use Q for formatting
map Q gq

set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_palette = 'original'
let g:airline_theme = 'gruvbox_material'
colorscheme gruvbox-material

" Set filename as tmux title
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim " . expand("%:t") . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")

autocmd BufRead,BufNewFile *eslintrc set filetype=json
