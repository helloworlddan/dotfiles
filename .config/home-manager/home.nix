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
    GOPATH = "$HOME/.go/";
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
      gruvbox-nvim

      vim-sleuth
      comment-nvim
      gitsigns-nvim
      conform-nvim
      indentLine
      friendly-snippets
      nvim-colorizer-lua

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

    extraLuaConfig = (builtins.readFile ./nvim.lua);
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
