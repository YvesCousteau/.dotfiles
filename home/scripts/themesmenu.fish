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

set chosen $(run_rofi)
switch $chosen
case $tokyonight_dark
    $HOME/.scripts/reloadtheme.fish --tokyonight-dark
case $gruvbox_light
    $HOME/.scripts/reloadtheme.fish --gruvbox-light
end
