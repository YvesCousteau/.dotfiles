# hosts/desktop-hood.nix
{ mkNixosConfiguration, nixos-hardware, ... }:

mkNixosConfiguration {
  system = "aarch64-linux";
  host = ./.;
  users = [ "bodyguard" ];
  setup = {
    nogui = {
      network = {
        suricata = true;
        nikto = true;
        wireshark = true;
      };
      misc = {
        elk = true;
      };
    };
    controller = {
      rpi5 = true;
    };
  };
}