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

    homeFiles = [
      ".config/Code/User/globalStorage/storage.json" # recent workspaces
      ".config/nushell/history.txt"
      ".local/share/kwalletd/kdewallet.salt" # it gets triggered anyways
      ".local/share/kwalletd/kdewallet.kwl"
      ".config/plasma-org.kde.plasma.desktop-appletsrc" # pinned apps among other things
      ".config/SuperSlicer"
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
    ];
  };
}
