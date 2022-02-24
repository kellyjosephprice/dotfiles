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
Plug 'junegunn/gv.vim'

Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'dracula/vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_gruvbox_dark_hard'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-tsserver',
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
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

nmap <leader>do <Plug>(coc-codeaction)

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

Plug 'junegunn/goyo.vim'

Plug '907th/vim-auto-save'
"let g:auto_save = 1
"let g:auto_save_events = ["CursorHold"]

"Plug 'jdonaldson/vaxe'

call plug#end()

set re=0
set showcmd
set splitright
set clipboard+=unnamedplus

set expandtab
set tabstop=2

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
colorscheme gruvbox-material

" Set filename as tmux title
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim " . expand("%:t") . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")

autocmd BufRead,BufNewFile *eslintrc set filetype=json

command Bacon :r! curl -s "https://baconipsum.com/api/?type=all-meat&paras=5&format=text"
