{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.isbl.impermanence;
  prepersist = pkgs.writeTextFile {
    name = "prepersist";
    executable = true;
    destination = "/bin/prepersist";
    text = ''
      #!${pkgs.bash}/bin/bash
      set -xe
      pth=`realpath $1`
      mv $1 /persistent$pth
      ln -s /persistent$pth $1
    '';
  };
in
{
  options = {
    isbl.impermanence = with lib; {
      enable = mkEnableOption (lib.mdDoc "marks that we should use impermanence here");
      btrfsRoot = mkOption {
        type = types.str;
      };
      rootFiles = mkOption {
        type = types.listOf types.str;
      };
      rootDirectories = mkOption {
        type = types.listOf types.str;
      };
      homeFiles = mkOption {
        type = types.listOf types.str;
      };
      homeDirectories = mkOption {
        type = types.listOf types.anything;
      };
      copiedOnBoot = mkOption {
        type = types.listOf types.str;
      };
    };
  };

  config = lib.mkIf cfg.enable (
    let
      homeFiles = cfg.homeFiles;
      getParents =
        path:
        let
          segments = lib.lists.flatten (builtins.split "/" path);
          takes = lib.lists.range 1 (builtins.length segments - 1);
          parents = builtins.map (len: lib.lists.take len segments) takes;
        in
        builtins.map (segments: builtins.concatStringsSep "/" segments) parents;
    in
    {
      environment.systemPackages = [ prepersist ];
      environment.persistence."/persistent" = {
        enable = true; # NB: Defaults to true, not needed
        hideMounts = true;
        directories = cfg.rootDirectories;
        files = cfg.rootFiles;
        users.isabella = {
          directories = cfg.homeDirectories;
          files = homeFiles;
        };
      };
      systemd.tmpfiles.rules =
        [
          "d /persistent/home/isabella 0700 isabella users - -"
        ]
        # make sure the files exist with proper permissions
        ++ lib.lists.unique (
          builtins.concatMap (
            homeFile:
            builtins.map (dir: "d /persistent/home/isabella/${dir} 0755 isabella users - -") (
              getParents homeFile
            )
          ) homeFiles
        )
        ++ (builtins.map (file: "f /persistent/home/isabella/${file} 0600 isabella users - -") homeFiles);

      systemd.tmpfiles.settings."10-resetting" = builtins.listToAttrs (
        builtins.map (file: {
          name = file;
          value.C.argument = "/persistent${file}";
        }) cfg.copiedOnBoot
      );

      boot.initrd.systemd.enable = true;
      boot.initrd.systemd.services.rollback = {
        description = "Rollback root filesystem to a pristine state on boot";
        wantedBy = [
          "initrd.target"
        ];
        after = [
          "dev-mapper-cryptroot.device"
          "cryptsetup.target"
          "initrd-switch-root.target"
        ];
        before = [
          "initrd-switch-root.target"
          "run-agenix.d.mount"
          "systemd-remount-fs.service"
        ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script =
          let
            disk = cfg.btrfsRoot;
            btrfs = "${pkgs.btrfs-progs}/bin/btrfs";
          in
          ''
            set -xe
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
      };
    }
  );
}
