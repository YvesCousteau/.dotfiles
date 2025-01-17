{ ... }: {
  imports = [
    ../tmux 
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 12.0;
    };
    settings = {
      shell = "${toString ./../../../scripts/tmux_start.fish}";
      window_padding_width = 4;
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
    extraConfig = builtins.readFile ./config.conf;
  };

  xdg.configFile = {
    "kitty/theme/gruvbox_light.conf" = {
      source = ./theme/gruvbox-light.conf;
    };
    "kitty/theme/tokyonight-dark.conf" = {
      source = ./theme/tokyonight-dark.conf;
    };
  };

  home.file = {
    ".scripts/tmux_start.fish" = {
      source = builtins.toString ../../../scripts/tmux_start.fish;
      executable = true;
    };
    ".scripts/term.fish" = {
      source = builtins.toString ../../../scripts/term.fish;
      executable = true;
    };
  };
}
