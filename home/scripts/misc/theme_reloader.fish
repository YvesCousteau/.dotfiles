#!/usr/bin/env fish

function kitty_reload 
    ln -sf ~/.config/kitty/theme/$THEME.conf ~/.config/kitty/theme.conf
    kill -SIGUSR1 $(pgrep kitty)
end

function hyprland_reload 
    hyprctl reload
end

echo $argv[1]
if test "$argv[1]" = "--tokyonight-dark"
    set -U THEME "tokyonight-dark"
    set tmux_path (nix-build -E 'let pkgs = import <nixpkgs> {}; tokyonight = pkgs.tmuxPlugins.mkTmuxPlugin { pluginName = "tokyonight"; version = "latest"; src = pkgs.fetchFromGitHub { owner = "fabioluciano"; repo = "tmux-tokyo-night"; rev = "main"; sha256 = "sha256-9nDgiJptXIP+Hn9UY+QFMgoghw4HfTJ5TZq0f9KVOFg="; }; }; in tokyonight')
    $tmux_path/share/tmux-plugins/tokyonight/tmux-tokyo-night.tmux 2&> /dev/null
    for server_name in /run/user/1000/nvim.* # maybe should be updated later lol
        nvim --server "$server_name" --remote-send ":lua vim.cmd('colorscheme tokyonight-night')<CR>"
    end
    hyprland_reload
    hyprctl keyword general:col.active_border "rgba(a9b1d6ff)" 2&> /dev/null
    hyprctl keyword general:col.inactive_border "rgba(1a1b26ff)" 2&> /dev/null
else if test "$argv[1]" = "--gruvbox-light"
    set -U THEME "gruvbox-light"
    set tmux_path $(nix eval --raw nixpkgs#tmuxPlugins.gruvbox.outPath)
    $tmux_path/share/tmux-plugins/gruvbox/gruvbox-tpm.tmux 2&> /dev/null
    for server_name in /run/user/1000/nvim.* # maybe should be updated later lol
        nvim --server "$server_name" --remote-send ":lua vim.o.background = 'light'<CR>"
        nvim --server "$server_name" --remote-send ":lua vim.cmd('colorscheme gruvbox')<CR>"
    end
    hyprland_reload
    hyprctl keyword general:col.active_border "rgba(3c3836ff)" 2&> /dev/null
    hyprctl keyword general:col.inactive_border "rgba(fbf1c7ff)" 2&> /dev/null
end
echo "THEME: $THEME"
kitty_reload
