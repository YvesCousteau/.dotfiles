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
    ".local/share/rofi/launcher/theme/gruvbox-light.rasi" = {
      source = ./launcher/theme/gruvbox-light.rasi;
    };
    ".local/share/rofi/launcher/theme/tokyonight-dark.rasi" = {
      source = ./launcher/theme/tokyonight-dark.rasi;
    };
    ".local/share/rofi/powermenu/theme/gruvbox-light.rasi" = {
      source = ./powermenu/theme/gruvbox-light.rasi;
    };
    ".local/share/rofi/powermenu/theme/tokyonight-dark.rasi" = {
      source = ./powermenu/theme/tokyonight-dark.rasi;
    };
    ".local/share/rofi/themesmenu/theme/gruvbox-light.rasi" = {
      source = ./themesmenu/theme/gruvbox-light.rasi;
    };
    ".local/share/rofi/themesmenu/theme/tokyonight-dark.rasi" = {
      source = ./themesmenu/theme/tokyonight-dark.rasi;
    };

    ".scripts/themesmenu.fish" = {
      source = builtins.toString ../../../scripts/themesmenu.fish;
      executable = true;
    };
    ".scripts/powermenu.fish" = {
      source = builtins.toString ../../../scripts/powermenu.fish;
      executable = true;
    };
    ".scripts/launchermenu.fish" = {
      source = builtins.toString ../../../scripts/launchermenu.fish;
      executable = true;
    };
  };
}
