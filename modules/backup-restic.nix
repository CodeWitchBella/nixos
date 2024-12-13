{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.isbl.backup-restic;
in
{
  options = {
    isbl.backup-restic = with lib; {
      enable = mkEnableOption (lib.mdDoc "backup restic");
      passwordFile = mkOption {
        type = types.path;
      };
      folder = mkOption {
        type = types.path;
      };
    };
  };

  config = lib.mkIf cfg.enable (
    let
      homeFiles = cfg.homeFiles;
      box = "u419690";
      user = "${box}-sub2";
    in
    {
      age.secrets.restic-storage-password.file = ../secrets/restic-storage-password.age;
      age.secrets.restic-password.file = cfg.passwordFile;

      services.restic.backups = {
        remotebackup = {
          initialize = true;
          exclude = [
            "/persistent/@backup-snapshot"
            "node_modules"
            ".local/share/Steam"
            "home/isabella/Downloads"
            "target/debug"
            "home/isabella/Documents/nixpkgs"
          ];
          passwordFile = config.age.secrets.restic-password.path;
          repository = "sftp://${user}@${box}.your-storagebox.de${cfg.folder}";
          paths = [
            "/persistent"
          ];
          extraOptions = [
            "sftp.command='${pkgs.sshpass}/bin/sshpass -f ${config.age.secrets.restic-storage-password.path} -- ssh -4 ${box}.your-storagebox.de -l ${user} -s sftp'"
            "--verbose"
          ];
          timerConfig = {
            OnCalendar = "02:05";
            Persistent = true;
            After = "network-online.target";
            OnBootSec = "15min";
          };
          backupPrepareCommand = ''
            set -Eeuxo pipefail
            # clean old snapshot
            if btrfs subvolume delete /persistent/@backup-snapshot; then
                echo "WARNING: previous run did not cleanly finish, removing old snapshot"
            fi

            btrfs subvolume snapshot -r /persistent /persistent/@backup-snapshot

            VOLUME=`grep "/persistent btrfs" < /etc/mtab | cut -d " " -f 1`
            umount /persistent
            mount -t btrfs -o subvol=/persistent/@backup-snapshot $VOLUME /persistent
          '';
          backupCleanupCommand = ''
            btrfs subvolume delete /persistent/@backup-snapshot
          '';
        };
      };

      systemd.services.restic-backups-remotebackup = {
        path = with pkgs; [
          btrfs-progs
          umount
          mount
        ];
        serviceConfig = {
          PrivateMounts = true;
          KillMode = "control-group";
        };
      };

      programs.ssh.knownHosts = {
        "${box}.your-storagebox.de".publicKey =
          "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA5EB5p/5Hp3hGW1oHok+PIOH9Pbn7cnUiGmUEBrCVjnAw+HrKyN8bYVV0dIGllswYXwkG/+bgiBlE6IVIBAq+JwVWu1Sss3KarHY3OvFJUXZoZyRRg/Gc/+LRCE7lyKpwWQ70dbelGRyyJFH36eNv6ySXoUYtGkwlU5IVaHPApOxe4LHPZa/qhSRbPo2hwoh0orCtgejRebNtW5nlx00DNFgsvn8Svz2cIYLxsPVzKgUxs8Zxsxgn+Q/UvR7uq4AbAhyBMLxv7DjJ1pc7PJocuTno2Rw9uMZi1gkjbnmiOh6TTXIEWbnroyIhwc8555uto9melEUmWNQ+C+PwAK+MPw==";
      };
    }
  );
}
