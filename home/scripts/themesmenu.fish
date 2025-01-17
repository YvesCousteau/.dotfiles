#!/usr/bin/env fish

set host $hostname
set gruvbox_light '󰖨 gruvbox'
set tokyonight_dark '󰤄 tokyonight'

function rofi_cmd
	rofi -dmenu \
		-p "$host" \
		-theme $HOME/.local/share/rofi/themesmenu/theme/$THEME.rasi
end

function run_rofi
	echo -e "$tokyonight_dark\n$gruvbox_light" | rofi_cmd
end

function kitty_reload 
    ln -sf ~/.config/kitty/theme/$THEME.conf ~/.config/kitty/theme.conf
    kill -SIGUSR1 $(pgrep kitty)
end

function hyprland_reload 
    hyprctl reload
end

function run_cmd
    if test "$argv[1]" = "--tokyonight-dark"
        set -U THEME "tokyonight-dark"
    else if test "$argv[1]" = "--gruvbox-light"
        set -U THEME "gruvbox-light"
    end
    kitty_reload
    hyprland_reload
end

set chosen $(run_rofi)
switch $chosen
case $tokyonight_dark
    run_cmd --tokyonight-dark
case $gruvbox_light
    run_cmd --gruvbox-light
end
