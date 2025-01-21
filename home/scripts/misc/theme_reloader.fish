#!/usr/bin/env fish

function kitty_reload 
    ln -sf ~/.config/kitty/theme/$THEME.conf ~/.config/kitty/theme.conf
    kill -SIGUSR1 $(pgrep kitty)
end

function mako_reload 
    pkill mako
    mako -c ~/.config/mako/theme/$THEME.conf &
end

function hyprland_reload 
    hyprctl reload
end

function nvim_reload 
    $HOME/.scripts/nvim.fish
end

function tmux_reload 
    $HOME/.scripts/tmux_reloader.fish
end

function rofi_reload 
    ln -sf ~/.config/rofi/theme/menu_launcher/$THEME.conf ~/.config/rofi/menu_launcher/theme.conf
    ln -sf ~/.config/rofi/theme/menu_themes$THEME.conf ~/.config/rofi/menu_themes/theme.conf
    ln -sf ~/.config/rofi/theme/menu_shortcuts$THEME.conf ~/.config/rofi/menu_shortcuts/theme.conf
    ln -sf ~/.config/rofi/theme/menu_power$THEME.conf ~/.config/rofi/menu_power/theme.conf
end

echo $argv[1]
if test "$argv[1]" = "--tokyonight-dark"
    set -U THEME "tokyonight-dark"
    hyprland_reload
    hyprctl keyword general:col.active_border "rgba(a9b1d6ff)" 2&> /dev/null
    hyprctl keyword general:col.inactive_border "rgba(1a1b26ff)" 2&> /dev/null
else if test "$argv[1]" = "--gruvbox-light"
    set -U THEME "gruvbox-light"
    hyprland_reload
    hyprctl keyword general:col.active_border "rgba(3c3836ff)" 2&> /dev/null
    hyprctl keyword general:col.inactive_border "rgba(fbf1c7ff)" 2&> /dev/null
end
echo "THEME: $THEME"
nvim_reload
rofi_reload
tmux_reload
kitty_reload
mako_reload
