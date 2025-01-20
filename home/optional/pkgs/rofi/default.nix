{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    pass = { };
    location = "center";
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
    extraConfig = {
      hide-scrollbar = true;
      show-icons = true;
    };
    font = "FiraCode Nerd Font 14";
  };

  xdg.configFile."rofi/theme".source = ./theme;

  home.file = {
    ".scripts/menu_themes.fish" = {
      source = builtins.toString ../../../scripts/menu_themes.fish;
      executable = true;
    };
    ".scripts/menu_power.fish" = {
      source = builtins.toString ../../../scripts/menu_power.fish;
      executable = true;
    };
    ".scripts/menu_launcher.fish" = {
      source = builtins.toString ../../../scripts/menu_launcher.fish;
      executable = true;
    };
    ".scripts/menu_shortcuts.fish" = {
      source = builtins.toString ../../../scripts/menu_shortcuts.fish;
      executable = true;
    };
  };
}
