#!/usr/bin/env fish

function kitty_reload 
    ln -sf ~/.config/kitty/theme/$THEME.conf ~/.config/kitty/theme.conf
    kill -SIGUSR1 $(pgrep kitty)
end

function wallpaper_reload 
    $HOME/.scripts/wallpapers_rand.fish
end

function hyprland_reload 
    hyprctl reload
end

if test "$argv[1]" = "--tokyonight-dark"
    set -Ux THEME "tokyonight-dark"
    set tmux_path (nix-build -E 'let pkgs = import <nixpkgs> {}; tokyonight = pkgs.tmuxPlugins.mkTmuxPlugin { pluginName = "tokyonight"; version = "latest"; src = pkgs.fetchFromGitHub { owner = "fabioluciano"; repo = "tmux-tokyo-night"; rev = "main"; sha256 = "sha256-9nDgiJptXIP+Hn9UY+QFMgoghw4HfTJ5TZq0f9KVOFg="; }; }; in tokyonight')
    $tmux_path/share/tmux-plugins/tokyonight/tmux-tokyo-night.tmux
    for server_name in /run/user/1000/nvim.* # maybe should be updated later lol
        nvim --server "$server_name" --remote-send ":lua vim.cmd('colorscheme tokyonight-night')<CR>"
    end
else if test "$argv[1]" = "--gruvbox-light"
    set -Ux THEME "gruvbox-light"
    set tmux_path $(nix eval --raw nixpkgs#tmuxPlugins.gruvbox.outPath)
    $tmux_path/share/tmux-plugins/gruvbox/gruvbox-tpm.tmux
    for server_name in /run/user/1000/nvim.* # maybe should be updated later lol
        nvim --server "$server_name" --remote-send ":lua vim.o.background = 'light'<CR>"
        nvim --server "$server_name" --remote-send ":lua vim.cmd('colorscheme gruvbox')<CR>"
    end
end
kitty_reload
hyprland_reload
wallpaper_reload