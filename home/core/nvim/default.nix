{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {
    ".scripts/nvim_reloader.fish" = {
      source = builtins.toString ../../scripts/nvim_reloader.fish;
      executable = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraConfig = ''
      ${builtins.readFile ./config.vim}
      set shadafile=~/.local/share/nvim/custom.shada
    '';
    extraLuaConfig = ''
      ${builtins.readFile ./plugins/bufferline.lua}
      ${builtins.readFile ./plugins/colorizer.lua}
      ${builtins.readFile ./plugins/conform.lua}
      ${builtins.readFile ./plugins/gruvbox.lua}
      ${builtins.readFile ./plugins/notify.lua}
      ${builtins.readFile ./plugins/nvim-tree.lua}
      ${builtins.readFile ./plugins/oil.lua}
      ${builtins.readFile ./plugins/rewind.lua}
      ${builtins.readFile ./plugins/toggleterm.lua}
      ${builtins.readFile ./plugins/tokyonight.lua}
      ${builtins.readFile ./plugins/rest-nvim.lua}
      ${builtins.readFile ./plugins/which-key.lua}
      ${builtins.readFile ./keybindings.lua}
      ${builtins.readFile ./config.lua}
    '';
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/vim-plugin-names
    plugins =
      with pkgs.vimPlugins;
      [
        # ========================
        # misc
        # ========================
        toggleterm-nvim
        # https://github.com/akinsho/toggleterm.nvim
        # floating terminal
        telescope-nvim
        # https://github.com/nvim-telescope/telescope.nvim
        # fuzzy finder over lists
        nvim-notify
        # https://github.com/rcarriga/nvim-notify
        # notify
        vim-dadbod-ui
        # https://github.com/kristijanhusak/vim-dadbod-ui
        # navigation database gui
        oil-nvim
        # https://github.com/stevearc/oil.nvim/
        # file explorer that lets you edit your filesystem like a normal Neovim buffer.
        # ========================
        # code
        # ========================
        coc-nvim
        # https://github.com/neoclide/coc.nvim
        # conquer of completion nvim
        coc-lua
        # https://github.com/josa42/coc-lua
        # conquer of completion lua
        coc-rust-analyzer
        # ...
        # conquer of completion rust analyzer
        coc-tailwindcss
        # https://github.com/iamcco/coc-tailwindcss
        # conquer of completion of tailwindcss
        coc-fzf
        # https://github.com/antoinemadec/coc-fzf
        # conquer of completion for fzf
        vim-nix
        # https://github.com/LnL7/vim-nix
        # writing Nix expressions
        comment-nvim
        # https://github.com/numtostr/comment.nvim
        # comment line
        conform-nvim
        # https://github.com/stevearc/conform.nvim
        # formating code
        markdown-nvim
        # https://github.com/tadmccorkle/markdown.nvim
        # beautify markdown
        markdown-preview-nvim
        # https://github.com/iamcco/markdown-preview.nvim
        # preview markdown file
        nvim-lspconfig
        # https://github.com/neovim/nvim-lspconfig
        # Language Server Protocol
        rest-nvim
        # https://github.com/rest-nvim/rest.nvim
        # asynchronous Neovim HTTP client
        rust-vim
        # https://github.com/rust-lang/rust.vim
        # beautify code
        # ========================
        # git
        # ========================
        vim-flog
        # https://github.com/rbong/vim-flog
        # git graph
        fugitive
        # https://github.com/tpope/vim-fugitive (git)
        # git commands
        neogit
        # https://github.com/NeogitOrg/neogit
        # git interface
        lazygit-nvim
        # https://github.com/kdheepak/lazygit.nvim
        # git interface
        # ========================
        # clean gui
        # ========================
        bufferline-nvim
        # https://github.com/akinsho/bufferline.nvim
        # tabs behavior
        which-key-nvim
        # https://github.com/liuchengxu/vim-which-key
        # displays available keybindings
        gruvbox-nvim
        # https://github.com/ellisonleao/gruvbox.nvim
        # colorsheme
        tokyonight-nvim
        # https://github.com/folke/tokyonight.nvim
        # colorsheme
        nvim-colorizer-lua
        # https://github.com/nvchad/nvim-colorizer.lua
        # show color by code
        nvim-tree-lua
        # https://github.com/nvim-tree/nvim-tree.lua
        # file explorer
        nvim-web-devicons
        # https://github.com/nvim-tree/nvim-web-devicons
        # provide Nerd Font icons
        # ========================
        # trash / lost
        # ========================
        # vim-lastplace           # https://github.com/ethanholz/nvim-lastplace
        #                         # open the file where you quit it
        # rust-tools-nvim         # https://github.com/simrat39/rust-tools.nvim
        #                         #
        # telescope-coc-nvim      # https://github.com/fannheyward/telescope-coc.nvim
        #                         #
        # vim-dadbod              # https://github.com/tpope/vim-dadbod
        #                         #
        # vim-dadbod-completion   # https://github.com/kristijanhusak/vim-dadbod-completion
        #                         #
        # dressing-nvim           # https://github.com/stevearc/dressing.nvim
        #                         # input improvement
        {
          # https://github.com/nvim-treesitter/nvim-treesitter
          plugin = nvim-treesitter.withPlugins (
            plugins: with plugins; [
              tree-sitter-bash
              tree-sitter-c
              tree-sitter-cmake
              tree-sitter-css
              tree-sitter-gitignore
              tree-sitter-html
              tree-sitter-javascript
              tree-sitter-json
              tree-sitter-latex
              tree-sitter-lua
              tree-sitter-markdown
              tree-sitter-markdown_inline
              tree-sitter-mermaid
              tree-sitter-nix
              tree-sitter-proto
              tree-sitter-python
              tree-sitter-rust
              tree-sitter-sql
              tree-sitter-toml
              tree-sitter-typescript
              tree-sitter-vim
              tree-sitter-vimdoc
              tree-sitter-yaml
            ]
          );
          type = "lua";
        }
      ]
      ++ [
        (pkgs.vimUtils.buildVimPlugin {
          # https://github.com/atiladefreitas/dooing
          name = "dooing"; # todo minimalist
          src = pkgs.fetchFromGitHub {
            owner = "atiladefreitas";
            repo = "dooing";
            rev = "main";
            sha256 = "sha256-E4QVGPbH+24+BzB7p2e+kzJylCcz6PBYCY68/hAOEow=";
          };
        })
      ]
      ++ [
        (pkgs.vimUtils.buildVimPlugin {
          # # https://github.com/YvesCousteau/nvim-whatelse
          # name = "rewind.nvim";
          # src = pkgs.fetchFromGitHub {
          #   owner = "YvesCousteau";
          #   repo = "rewind.nvim";
          #   rev = "init";
          #   sha256 = "sha256-pGkA4TF1VfR5xWLSzJIT+Sd16xVtwRoxIBASzQvWlOk=";
          # };
          name = "rewind.nvim";
          src = /home/me/perso/rewind.nvim;
        })
      ];
  };

  home.packages = with pkgs; [
    luajit # Just-In-Time compiler for Lua programming language
    stylua # Opinionated Lua code formatter
    nixfmt-rfc-style # Formatter for Nix code following RFC style
    prettierd # Prettier daemon for faster formatting
    isort # Python utility to sort imports alphabetically
    black # The uncompromising Python code formatter
    nodePackages.prettier # Multi-language code formatter
  ];
}
