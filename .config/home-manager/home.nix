{ config, pkgs, ... }:

{
  home.username = "stamer";
  home.homeDirectory = "/home/stamer";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    bash tree stow htop jq ripgrep fzf gnupg gh go google-cloud-sdk terraform

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    (pkgs.writeShellScriptBin "gacurl" ''curl -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json"'')
    (pkgs.writeShellScriptBin "gicurl" ''curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'')
    (pkgs.writeShellScriptBin "gawhoami" ''curl "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$(gcloud auth print-access-token)"'')
    (pkgs.writeShellScriptBin "giwhoami" ''curl "https://www.googleapis.com/oauth2/v1/tokeninfo?id_token=$(gcloud auth print-identity-token)"'')
  ];

  home.file = {
    ".location".text = ''America/Buenos_Aires'';

# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox

      vim-sleuth
      comment-nvim
      gitsigns-nvim
      conform-nvim
      indentline-blankline
      friendly-snippets
      nvim-colorizer

      which-key-nvim
      todo-comments-nvim
      mini-nvim
      nvterm
      plenary-nvim
      nvim-tree-lua
      nvim-web-devicons

      telescope-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim

      nvim-treesitter.withAllGrammars

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      vim-lua
      luasnip
      cmp_luasnip

      vim-nix
      vim-go
    ];

    extraLuaConfig = ''
    vim.cmd.colorscheme = 'gruvbox'
    vim.g.leader = ' ' 
    vim.g.localleader = ' ' 
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.mouse = 'a'
    vim.opt.showmode = false
    vim.opt.clipboard = 'unnamedplus'
    vim.opt.breakindent = true
    vim.opt.undofile = true
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.signcolumn = 'yes'
    vim.opt.updatetime = 250
    vim.opt.timeoutlen = 300
    vim.opt.splitright = true
    vim.opt.splitbelow = true
    vim.opt.list = true
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
    vim.opt.inccommand = 'split'
    vim.opt.cursorline = true
    vim.opt.scrolloff = 10
    vim.opt.hlsearch = true

    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

    vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
    vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
    vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
    vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

    vim.api.nvim_create_autocmd('TextYankPost', {
      desc = 'Highlight when yanking (copying) text',
      group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
      callback = function()
      vim.highlight.on_yank()
      end,
    })

    require('which-key').setup()

    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    }

    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
      local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
      end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    local servers = {
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      gopls = {},
      lua_ls = {},
      nixd = {},
    }

    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
        end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
        end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }

    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    local statusline = require 'mini.statusline'
    statusline.setup()
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    require('nvim-treesitter.configs').setup {
      highlight = { enable = true },
      indent = { enable = true },
    }
    '';
  };

  programs.git = {
    enable = true;
    userName = "Daniel Stamer";
    userEmail = "dan@hello-world.sh";

    signing = { 
      key = null;
      signByDefault = true;
    };

    aliases = {
      cm = "commit -asS";
      co = "checkout";
      df = "difftool --stat";
      st = "status -sb";
      tg = "tag -s";
      sh = "show --show-signature";
      ps = "push --all";
      pl = "pull --all";
      pt = "push --tags";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all";
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
