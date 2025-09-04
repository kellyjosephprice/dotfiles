set nocompatible
let mapleader = ','

call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug'

Plug 'editorconfig/editorconfig-vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_gruvbox_dark_hard'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-tsserver',
  \ 'coc-stylelintplus'
  \ ]

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

Plug 'git@github.com:github/copilot.vim.git'

let g:copilot_no_tab_map = v:true
inoremap <silent><expr> <S-TAB> copilot#Accept("")
call plug#end()

set re=0
set showcmd
set splitright
set clipboard+=unnamedplus

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set textwidth=79
set fo+=t

"autocmd FileType javascript JsPreTmpl
"autocmd FileType javascriptreact JsPreTmpl
"autocmd FileType typescript JsPreTmpl

" Stop using arrow keys!
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

set cmdheight=2

" Set filename as tmux title
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim " . expand("%:t") . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")

set backup
set backupdir=~/.vim/backup

command Bacon :r! curl -s "https://baconipsum.com/api/?type=all-meat&paras=3&format=text"
command Lemon :r! ~/bin/lemon-ipsum.js

lua require('init')
