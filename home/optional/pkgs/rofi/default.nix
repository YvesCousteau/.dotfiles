{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    pass = { };
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

  home.file = {
    ".local/share/rofi/menu_launcher/theme/gruvbox-light.rasi" = {
      source = ./menu_launcher/theme/gruvbox-light.rasi;
    };
    ".local/share/rofi/menu_launcher/theme/tokyonight-dark.rasi" = {
      source = ./menu_launcher/theme/tokyonight-dark.rasi;
    };
    ".local/share/rofi/menu_power/theme/gruvbox-light.rasi" = {
      source = ./menu_power/theme/gruvbox-light.rasi;
    };
    ".local/share/rofi/menu_power/theme/tokyonight-dark.rasi" = {
      source = ./menu_power/theme/tokyonight-dark.rasi;
    };
    ".local/share/rofi/menu_themes/theme/gruvbox-light.rasi" = {
      source = ./menu_themes/theme/gruvbox-light.rasi;
    };
    ".local/share/rofi/menu_themes/theme/tokyonight-dark.rasi" = {
      source = ./menu_themes/theme/tokyonight-dark.rasi;
    };

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
  };
}
