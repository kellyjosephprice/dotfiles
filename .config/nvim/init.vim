" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nocompatible
let mapleader = ','

call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug'

Plug 'sheerun/vimrc'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'

Plug 'Quramy/vim-js-pretty-template'

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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
vmap <leader>ed  <Plug>(coc-codeaction-selected)
nmap <leader>ed  <Plug>(coc-codeaction)
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)

Plug 'honza/vim-snippets'

Plug 'aliou/sql-heredoc.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'preservim/nerdcommenter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
call plug#end()

set re=0
set showcmd
set splitright
set clipboard+=unnamedplus

set textwidth=79
set fo+=t

call jspretmpl#register_tag('pug', 'pug')

autocmd FileType javascript JsPreTmpl
autocmd FileType javascriptreact JsPreTmpl
autocmd FileType typescript JsPreTmpl

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
