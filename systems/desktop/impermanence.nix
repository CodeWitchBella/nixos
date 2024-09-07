{
  lib,
  config,
  pkgs,
  ...
}: {
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
      ];
      files = [];
    };
  };
  boot.initrd.postDeviceCommands = let
    disk = config.fileSystems."/".device;
    btrfs = "${pkgs.btrfs-progs}/bin/btrfs";
  in
    lib.mkAfter ''
      mkdir /btrfs_tmp
      mount ${disk} /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
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

      ${btrfs} subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
      rmdir /btrfs_tmp
    '';
}