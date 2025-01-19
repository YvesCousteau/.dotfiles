#!/usr/bin/env fish

set host $hostname
set gruvbox_light '󰖨 gruvbox'
set tokyonight_dark '󰤄 tokyonight'

function rofi_cmd
	rofi -dmenu \
		-p "$host" \
		-theme $HOME/.local/share/rofi/menu_themes/theme/$THEME.rasi
end

function run_rofi
	echo -e "$tokyonight_dark\n$gruvbox_light" | rofi_cmd
end

set chosen $(run_rofi)
switch $chosen
case $tokyonight_dark
    $HOME/.scripts/theme_reloader.fish --tokyonight-dark
case $gruvbox_light
    $HOME/.scripts/theme_reloader.fish --gruvbox-light
end
