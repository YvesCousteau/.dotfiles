{ pkgs, mergedSetup, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };
  security.pam.services.hyprlock = {};
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    hyprcursor
    hyprpaper
    wlr-randr
  ];

  environment.sessionVariables = {
    WAYLAND_DISPLAY = "wayland-0";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };
}
