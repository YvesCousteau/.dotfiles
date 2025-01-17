{
  inputs, lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bootloader
    ./shell
    ./networking
    ./security
    ./pkgs
    ./system
    ./users
  ];

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = true;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # tools and libs
  environment.systemPackages = with pkgs; [
    libnotify   # notification manager

    gcc         # collection of compilers
    glibc

    unzip
    tree
    parted
    busybox
  ];

  system.activationScripts.createMnt = ''
    mkdir -p /mnt
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
