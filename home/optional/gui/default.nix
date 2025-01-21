{ pkgs, lib, mergedSetup, ... }:
let
  waybarCommand = ''
    exec = $HOME/.scripts/waybar.fish
  '' else "";
  hyprpaperCommand = ''
    exec-once = hyprpaper
    exec-once = while true; do $HOME/.scripts/wallpapers_rand.sh; sleep 900; done
  '';
  hyprlandConf = pkgs.substituteAll {
    src = ./hyprland.conf;
    waybar_command = waybarCommand;
    hyprpaper_command = hyprpaperCommand;
    animations_enable = "true";
    custom = mergedSetup.gui.extra.hyprland;
  };
in
{
  imports = 
      ../pkgs/waybar 
      ../pkgs/mako
      ../pkgs/kitty 
      ../pkgs/rofi 
      ../pkgs/mpv 
    ];

  xdg.configFile = {
    "hypr/hyprland.conf".source = hyprlandConf;
    "hypr/windowrule.conf".source = ./windowrule.conf;
    "hypr/keybindings.conf".source = ./keybindings.conf;
    "hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    "hypr/hyprlock.conf".source = ./hyprlock.conf;
    "swappy/config".text = ''
      [Default]
      save_dir=~/Screenshots
      save_filename_format=screenshot-%Y%m%d-%H%M%S.png
      show_panel=false
      line_size=5
      text_size=20
      text_font=sans-serif
    '';
  };

  home.file = {
    ".scripts/theme_reloader.fish" = {
      source = builtins.toString ../../scripts/theme_reloader.fish;
      executable = true;
    };
    ".scripts/wallpapers_rand.fish" = {
      source = builtins.toString ../../scripts/wallpapers_rand.fish;
      executable = true;
    };
    ".wallpapers" = {
      source = ../../wallpapers;
    };
    ".local/share/icons" = {
      source = ../../cursors;
    };
  };
}
