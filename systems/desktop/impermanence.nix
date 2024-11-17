{
  lib,
  config,
  pkgs,
  ...
}: {
  systemd.tmpfiles.rules = [
    "L+ /etc/nixos/flake.nix - - - - /home/isabella/nixos/flake.nix"
  ];
  isbl.impermanence = {
    enable = true;
    btrfsRoot = config.fileSystems."/".device;
    rootDirectories = [
      "/var/lib/nixos" # stuff like uid maps
      "/var/lib/bluetooth" # so that I don't have to pair everything

      # Note that stuff like (below) can be accessed via the old snapshots
      #  - "/var/log"
      #  - "/var/lib/systemd/coredump"
    ];
    rootFiles = [
      "/etc/machine-id"
      #"/etc/shadow" # passwords..., meh
    ];

    copiedOnBoot = [
      "/home/isabella/.config/plasma-org.kde.plasma.desktop-appletsrc" # pinned apps among other things
    ];

    homeFiles = [
      ".config/Code/User/globalStorage"
      ".config/Code/User/workplaceStorage"
      ".config/nushell/history.txt"
      ".config/kwinoutputconfig.json" # screen settings
    ];
    homeDirectories = [
      "Downloads"
      # "Music" - I don't use this one
      # "Pictures" - screenshot dumping ground
      "Documents"
      # "Videos" - I don't use this one
      "nixos"
      {
        directory = ".ssh";
        mode = "0700";
      }
      ".local/share/direnv"
      ".mozilla"
      ".config/sunshine"
      ".local/share/Steam"
      ".local/share/zoxide"
      ".factorio"
    ];
  };
}
