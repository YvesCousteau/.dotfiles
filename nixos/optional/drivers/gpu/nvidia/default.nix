{ config, pkgs, ... }:
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  environment.systemPackages = with pkgs; [
    nvidia_x11
  ];
}
