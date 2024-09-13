{
  lib,
  config,
  pkgs,
  ...
}: let
  homeFiles = [
    ".config/Code/User/globalStorage/storage.json" # recent workspaces
    ".config/nushell/history.txt"
    ".config/kwalletrc" # so that it stays disabled
    ".local/share/kwalletd" # it gets triggered anyways
    ".config/kxkbrc" # keyboard layouts
    ".config/plasma-org.kde.plasma.desktop-appletsrc" # pinned apps among other things
  ];
  getParents = path: let
    segments = lib.lists.flatten (builtins.split "/" path);
    takes = lib.lists.range 1 (builtins.length segments - 1);
    parents = builtins.map (len: lib.lists.take len segments) takes;
  in
    builtins.map (segments: builtins.concatStringsSep "/" segments) parents;
in {
  isbl.impermanence.enable = true;
  environment.persistence."/persistent" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/lib/nixos" # stuff like uid maps
      "/var/lib/bluetooth" # so that I don't have to pair everything

      # Note that stuff like (below) can be accessed via the old snapshots
      #  - "/var/log"
      #  - "/var/lib/systemd/coredump"
    ];
    files = [
      "/etc/machine-id"
      #"/etc/shadow" # passwords..., meh
    ];
    users.isabella = {
      directories = [
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
      files = homeFiles;
    };
  };
  systemd.tmpfiles.rules =
    [
      "d /persistent/home/isabella 0700 isabella users - -"
      "L+ /etc/nixos/flake.nix - - - - /home/isabella/nixos/flake.nix"
    ]
    # make sure the files exist with proper permissions
    ++ lib.lists.unique (builtins.concatMap (
        homeFile:
          builtins.map
          (dir: "d /persistent/home/isabella/${dir} 0755 isabella users - -")
          (getParents homeFile)
      )
      homeFiles)
    ++ (builtins.map (file: "f /persistent/home/isabella/${file} 0600 isabella users - -") homeFiles);
  boot.initrd.postDeviceCommands = let
    disk = config.fileSystems."/".device;
    btrfs = "${pkgs.btrfs-progs}/bin/btrfs";
  in
    lib.mkAfter ''
      mkdir /btrfs_tmp
      mount ${disk} /btrfs_tmp
      if [[ -e /btrfs_tmp/rootfs ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/rootfs)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/rootfs "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(${btrfs} subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          ${btrfs} subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      ${btrfs} subvolume create /btrfs_tmp/rootfs
      umount /btrfs_tmp
      rmdir /btrfs_tmp
    '';
}
