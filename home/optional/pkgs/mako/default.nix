{ config, ... }: 
let
  # homeDir = builtins.getEnv "HOME";
  homeDir = config.home.homeDirectory;
in {
    # https://www.mankier.com/5/mako
    services.mako = {
        enable = true;
        # null or one of "top-right", "top-center", "top-left", "bottom-right", "bottom-center", "bottom-left", "center"
        anchor = "bottom-right";
        borderRadius = 4;
        borderSize = 2;
        font = "FiraCode Nerd Font Mono 10";
        format = "<b>%s</b>\\n%b";
        groupBy = null;
        height = 100;
        width = 300;
        margin = "5, 0";
        padding = "5";
        iconPath = "${homeDir}/.icons";
        icons = true;
        ignoreTimeout = false;
        # null or one of "background", "bottom", "top", "overlay"
        layer = "top";
        # If 1, enable Pango markup. If 0, disable Pango markup. If enabled, Pango markup will be interpreted in your format specifier and in the body of notifications.
        markup = true;
        maxIconSize = 32;
        maxVisible = 5;
        output = null;
        # null or one of "+time", "-time", "+priority", "-priority"
        sort = "-time";
        defaultTimeout = 5000;
        extraConfig = builtins.toString ./config;
  };
}
