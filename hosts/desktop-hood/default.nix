{
  modulesPath,
  lib,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../nixos/disk-config.nix
  ];

  boot.loader = {
    grub.efiInstallAsRemovable = true;
    efi.canTouchEfiVariables = false;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMc6jbhoDuKt0YOIF9prT4reT9WG6sP2sEFVj59loQwq me@desktop-hood"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAq7LsVEV+jw4yPpLyDc4XIS2yVmSJt0J24pS4BQYtGD me@laptop-work"
  ];

  # services = {
  #   displayManager = {
  #     autoLogin.enable = true;
  #     autoLogin.user = "me";
  #   };
  # };

  disko.devices.disk.disk1.device = "/dev/nvme1n1";

  # networking = {
  # wg-quick = {
  #   interfaces = {
  #     wg0 = {
  #       address = [ "10.100.0.2/32" ];
  #     };
  #   };
  # };
  # };

  # environment.etc."wireguard/wg0" = {
  #   source = builtins.toString ../../secrets/${name}/wg0;
  #   mode = "0400";
  # };
}
