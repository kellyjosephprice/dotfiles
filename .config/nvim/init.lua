local vim = vim
local Plug = vim.fn['plug#']

-- Leader key
vim.g.mapleader = ','

-- Options
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand('~/.vim/backup')
vim.opt.clipboard:append('unnamedplus')
vim.opt.cmdheight = 2
vim.opt.compatible = false
vim.opt.expandtab = true
vim.opt.formatoptions:append('t')
vim.opt.number = true
vim.opt.re = 0
vim.opt.shiftwidth = 2
vim.opt.shortmess:append('c')
vim.opt.showcmd = true
vim.opt.softtabstop = 2
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.textwidth = 79
vim.opt.updatetime = 300

-- Plugins (vim-plug)
vim.call('plug#begin')
Plug('junegunn/vim-plug')
Plug('editorconfig/editorconfig-vim')
Plug('airblade/vim-gitgutter')
Plug('tpope/vim-fugitive')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('luisiacc/gruvbox-baby', { ['branch'] = 'main' })
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
Plug('honza/vim-snippets')
Plug('ntpeters/vim-better-whitespace')
Plug('powerman/vim-plugin-AnsiEsc')
Plug('preservim/nerdcommenter')
Plug('junegunn/fzf', { ['do'] = function() vim.call('fzf#install()') end })
Plug('junegunn/fzf.vim')
Plug('junegunn/goyo.vim')
Plug('rust-lang/rust.vim')
vim.call('plug#end')

-- CoC Globals
vim.g.coc_global_extensions = {
  'coc-prettier',
  'coc-eslint',
  'coc-tsserver',
  'coc-stylelintplus'
}

-- CoC functions and helpers
_G.check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.show_documentation = function()
  if vim.tbl_contains({ 'vim', 'help' }, vim.bo.filetype) then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  else
    vim.fn.CocAction('doHover')
  end
end

_G.show_doc_if_no_diagnostic = function()
  if vim.fn['coc#float#has_float']() == 0 and vim.fn.CocHasProvider('hover') == 1 then
    vim.fn.CocActionAsync('doHover')
  end
end

_G.show_hover_doc = function()
  vim.fn.timer_start(500, 'v:lua.show_doc_if_no_diagnostic')
end

-- Keymaps
local keyset = vim.keymap.set
local opts_remap = { silent = true, remap = true }
local opts_silent = { silent = true }

-- CoC Tab Completion (using nvim_set_keymap for complex expression)
vim.api.nvim_set_keymap("i", "<TAB>",
  'pumvisible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "\\<C-r>=coc#rpc#request(\'doKeymap\', [\'snippets-expand-jump\',\'\'])\\<CR>" : v:lua.check_back_space() ? "\\<TAB>" : coc#refresh()',
  { silent = true, expr = true, noremap = true })

-- CoC Mappings (requires remap = true for <Plug>)
keyset("v", "<leader>ed", "<Plug>(coc-codeaction-selected)", opts_remap)
keyset("n", "<leader>ed", "<Plug>(coc-codeaction-selected)", opts_remap)
keyset("i", "<C-l>", "<Plug>(coc-snippets-expand)", opts_remap)
keyset("v", "<C-j>", "<Plug>(coc-snippets-select)", opts_remap)
keyset("n", "gd", "<Plug>(coc-definition)", opts_remap)
keyset("n", "gy", "<Plug>(coc-type-definition)", opts_remap)
keyset("n", "gi", "<Plug>(coc-implementation)", opts_remap)
keyset("n", "gr", "<Plug>(coc-references)", opts_remap)
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", opts_remap)
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", opts_remap)
keyset("n", "<leader>do", "<Plug>(coc-codeaction)", opts_remap)
keyset("n", "K", "<CMD>lua show_documentation()<CR>", opts_silent)

-- FZF Mappings
keyset("n", "<leader>f", ":Rg<CR>", opts_silent)
keyset("n", "<leader>b", ":Buffers<CR>", opts_silent)
keyset("n", "<C-f>", ":Files<CR>", opts_silent)

-- Disable Arrow Keys
keyset("", "<Up>", "<nop>")
keyset("", "<Down>", "<nop>")
keyset("", "<Left>", "<nop>")
keyset("", "<Right>", "<nop>")

vim.g.rustfmt_autosave = 1

-- Autocmds
local hover_group = vim.api.nvim_create_augroup("CocHover", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = hover_group,
  callback = function()
    _G.show_hover_doc()
  end
})

local tmux_group = vim.api.nvim_create_augroup("TmuxTitle", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost", "BufNewFile", "BufEnter" }, {
  group = tmux_group,
  pattern = "*",
  callback = function()
    vim.fn.system("tmux rename-window 'vim " .. vim.fn.expand("%:t") .. "'")
  end
})
vim.api.nvim_create_autocmd("VimLeave", {
  group = tmux_group,
  callback = function()
    vim.fn.system("tmux setw automatic-rename")
  end
})

require('lualine').setup {
  options = {
    theme = "gruvbox-baby"
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' }
  },
}

vim.cmd.set('background=dark')
vim.cmd.colorscheme("gruvbox-baby")

local treeSitterLangs = { 'javascript', 'typescript', 'lua', 'bash', 'tsx', 'svelte', 'css', 'html_tags', 'html', 'ecma',
  'jsx' }
require('nvim-treesitter').install(treeSitterLangs)
vim.api.nvim_create_autocmd('FileType', {
  pattern = treeSitterLangs,
  callback = function() vim.treesitter.start() end,
})

-- User Commands
vim.api.nvim_create_user_command('Bacon', 'r! curl -s "https://baconipsum.com/api/?type=all-meat&paras=3&format=text"',
  {})
vim.api.nvim_create_user_command('Lemon', 'r! curl -s "https://lemon-ipsum.com/" --header "accept: text/plain"', {})
