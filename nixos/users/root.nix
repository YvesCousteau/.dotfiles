{ mergedSetup, ... }:
{
  group = "root";
  isNormalUser = false;
  extraGroups = [
    "wheel"
  ];
  hashedPassword = "$6$ZNZFnpB1Wy800/Nz$7EMJ6qSnbSfSsAetfK7IIxoH1wpZP85Oq5sMz5tl8jFI4dLG9EPE8NwaPiM1FxV91/38PSLZNoLaTBvz71/LX1";
  openssh.authorizedKeys.keys = mergedSetup.networking.internet.ssh.root.authorizedKeys;
}
