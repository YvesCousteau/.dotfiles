#!/usr/bin/env fish

set host `hostname`
set light '󰖨 Light'
set dark '󰤄 Dark'

function rofi_cmd
	rofi -dmenu \
		-p "$host" \
		-theme $HOME/.local/share/rofi/themesmenu/theme/$THEME.rasi
end

function run_rofi
	echo -e "$dark\n$light" | rofi_cmd
end

function run_cmd
    if test "$argv[1]" = "--dark"
        set -gx THEME "tokyonight-dark"
    else if test "$argv[1]" = "--light"
        set -gx THEME "gruvbox-light"
    end
end

set chosen "$(run_rofi)"
switch $chosen
case $dark
    run_cmd --dark
case $light
    run_cmd --light
end
