require 'nvim-treesitter.configs'.setup {
  auto_install = true,

  highlight = {
    enable = true,
  },

  additional_vim_regex_highlighting = false,
}

-- npm i -g typescript typescript-language-server
--vim.pack.add {
--{ src = 'https://github.com/neovim/nvim-lspconfig' },
--}

--<leader>ed  <Plug>(coc-codeaction-selected)
--vim.api.map('v', '<leader>ed', '<Plug>(coc-codeaction-selected)', {})
--nmap <leader>ed  <Plug>(coc-codeaction)
--vim.api.map('n', '<leader>ed', '<Plug>(coc-codeaction)', {})
--nmap <leader>ed  <Plug>(coc-codeaction)



vim.g.gruvbox_bab_transparent_mode = 1

vim.cmd('set background=dark')
vim.cmd('colorscheme gruvbox-baby')

vim.o.number = true
