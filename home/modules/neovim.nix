{ config, lib, pkgs, ... }:

let
  # nvim-treesitter's new (0.9+) API expects parsers to already be present
  # rather than fetched+compiled at runtime via require('nvim-treesitter').install(...)
  # - that runtime install did a network fetch + native compile, which isn't
  # reproducible (or even possible, sandboxed) under nix. Bundling the
  # grammars into the plugin itself replaces that install() call entirely;
  # vim.treesitter.start() is all that's needed afterwards.
  #
  # Kept the same language list as the old config, minus a few names that
  # were never real parser names to begin with ('html_tags', 'ecma', 'jsx' -
  # JSX highlighting comes bundled with the javascript/tsx parsers).
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.javascript
    p.typescript
    p.lua
    p.bash
    p.tsx
    p.svelte
    p.css
    p.html
  ]);
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      vim-gitgutter
      vim-fugitive
      treesitterWithGrammars
      gruvbox-baby
      lualine-nvim
      nvim-web-devicons
      coc-nvim
      vim-snippets
      vim-better-whitespace
      vim-plugin-AnsiEsc
      nerdcommenter
      fzf-vim
      goyo-vim
      rust-vim
    ];

    initLua = ''
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

      -- Parsers are bundled via nix (see treesitterWithGrammars above) -
      -- just turn highlighting on for these filetypes.
      local treeSitterLangs = { 'javascript', 'typescript', 'lua', 'bash', 'tsx', 'svelte', 'css', 'html' }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = treeSitterLangs,
        callback = function() vim.treesitter.start() end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("scss_iskeyword", { clear = true }),
        pattern = "scss",
        callback = function()
          vim.opt_local.iskeyword:append("@-@")
        end,
      })

      -- User Commands
      vim.api.nvim_create_user_command('Bacon', 'r! curl -s "https://baconipsum.com/api/?type=all-meat&paras=3&format=text"',
        {})
      vim.api.nvim_create_user_command('Lemon', 'r! curl -s "https://lemon-ipsum.com/" --header "accept: text/plain"', {})
    '';
  };

  home.file = {
    ".config/nvim/coc-settings.json".source = ../../.config/nvim/coc-settings.json;
    ".config/nvim/after/ftplugin/markdown_wrapping.vim".source = ../../.config/nvim/after/ftplugin/markdown_wrapping.vim;
  };
}
