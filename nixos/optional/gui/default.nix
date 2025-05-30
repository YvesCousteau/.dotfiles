{
  lib,
  pkgs,
  mergedSetup,
  ...
}:
let
  isWayland = mergedSetup.gui.params.displayServer == "wayland";
in
{
  imports = [
    ./hyprland.nix
    ./wayland.nix
  ];

  services = {
    displayManager = {
      autoLogin.enable = mergedSetup.gui.params.autoLogin.enable;
      autoLogin.user = mergedSetup.gui.params.autoLogin.user;
    };
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = if mergedSetup.gui.params.displayServer == "wayland" then true else false;
          banner = "go fuck your self";
        };
      };
      desktopManager.gnome.enable =
        if mergedSetup.gui.params.displayServer == "wayland" then false else true;
    };
    ratbagd.enable = true; # DBus daemon to configure input devices
    dbus.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Managing the graphical display system on your computer.
  systemd.services.display-manager.serviceConfig = {
    NoNewPrivileges = false;

    ProtectSystem = "full";
    ProtectControlGroups = true;
    ProtectClock = true;
    ProtectKernelModules = true;
    ProtectProc = "default";

    PrivateMounts = true;
    PrivateIPC = true;

    RestrictSUIDSGID = true;
    RestrictRealtime = true;
    RestrictFileSystems = [ ];
    RestrictNamespaces = [
      "~cgroup"
      "uts"
      "pid"
      "net"
      "user"
      "mnt"
      "ipc"
    ];
    RestrictAddressFamilies = [
      "AF_UNIX"
      "AF_NETLINK"
      "AF_INET"
      "AF_INET6"
      "~AF_PACKET"
    ];

    SystemCallArchitectures = [ "native" ];
    SystemCallErrorNumber = "EPERM";
    SystemCallFilter = [
      "~@obsolete"
      "~@cpu-emulation"
      "~@clock"
      "~@swap"
      "~@module"
      "~@reboot"
      "~@raw-io"
      "~@debug"
    ];

    CapabilityBoundingSet = [
      "CAP_SYS_ADMIN"
      "CAP_SETUID"
      "CAP_SETGID"
      "CAP_SETPCAP"
      "CAP_KILL"
      "CAP_SYS_TTY_CONFIG"
      "CAP_DAC_OVERRIDE"
      "CAP_DAC_READ_SEARCH"
      "CAP_FOWNER"
      "CAP_IPC_OWNER"
      "CAP_FSETID"
      "CAP_SETFCAP"
      "CAP_CHOWN"
    ];
    AmbientCapabilities = [ ];

    DevicePolicy = "closed";
    DeviceAllow = [
      "/dev/tty7 rw"
      "/dev/input/* rw" # Allow Wayland to access keyboards/mice
      "/dev/dri/* rw" # Allow access to GPU devices
    ];

    LockPersonality = true;
    UMask = "077";
    IPAddressDeny = "any";
    KeyringMode = lib.mkForce "private";
  };

  environment.systemPackages = with pkgs; [
    brightnessctl # Command-line utility to control device brightness
  ];
}
