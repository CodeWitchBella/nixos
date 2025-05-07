# isbl-nixos

> [!WARNING]  
> I moved from nixos back to fedora recently. Mostly because Asahi linux works better and I like all my linux to be same.
> HOWEVER, I still use nixos for my "dotfiles" via home-manager. See my [nix-home] repo.
> My server setup can be found at [nixos-servers]

[nix-home]: https://github.com/CodeWitchBella/nix-home
[nixos-servers]: https://github.com/CodeWitchBella/nixos-servers

This repo currently contains my desktop nixos setup.

## Getting Started

1. install nixos with user named `isabella`
2. git clone this repo to ~/nixos (some parts of this config assume this path)
3. `ln -s /home/isabella/nixos/flake.nix /etc/nixos/`
4. `nixos-rebuild switch`
5. configure 1password to run on start in Tweaks

## Getting Started Asahi

<details>
<summary>This is long. Click to expand.</summary>

(verified working when I was switching from ext4 to btrfs)

1. Boot into the installer. [guide](https://github.com/tpwrules/nixos-apple-silicon/blob/main/docs/uefi-standalone.md)
2. Become root `sudo -s`
3. Delete existing install (if exists)
   ```sh
   sgdisk /dev/nvme0n1 -p
   sgdisk /dev/nvme0n1 -d=X # replace X with old partition, probably 5
   ```
4. Connect to internet to get btrfs

```sh
iwctl
station list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect NETWORKNAME
# wait for password prompt
exit
```

or if you know the network name

```sh
iwctl
station wlan0 show
station wlan0 connect-hidden NETWORKNAME
# wait for password prompt
```

5. Create new partition

```sh
sgdisk /dev/nvme0n1 -p # to see preexisting partitions
sgdisk /dev/nvme0n1 -n 0:0 -s
sgdisk /dev/nvme0n1 -p # look for the new partition
cryptsetup luksFormat /dev/nvme0n1p5
cryptsetup luksOpen /dev/nvme0n1p5 cryptroot
nix-shell -p btrfs-progs
mkfs.btrfs -L nixos /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt
cd /mnt
btrfs subvolume create nix
btrfs subvolume create rootfs
btrfs subvolume create persistent
cd
umount /mnt
```

6. Mount everything and copy stuff

```sh
mount -o subvol=rootfs /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot /mnt/nix /mnt/persistent
mount -o subvol=nix /dev/disk/by-label/nixos /mnt/nix
mount -o subvol=persistent /dev/disk/by-label/nixos /mnt/persistent
mount /dev/disk/by-partuuid/`cat /proc/device-tree/chosen/asahi,efi-system-partition` /mnt/boot
```

7. Generate config

```sh
nixos-generate-config --root /mnt
cp -r /etc/nixos/apple-silicon-support /mnt/etc/nixos/
chmod -R +w /mnt/etc/nixos/
nano /mnt/etc/nixos/configuration.nix
```

8. Deal with firmware+flakes

```sh
mkdir -p /mnt/etc/nixos/firmware
cp /mnt/boot/asahi/{all_firmware.tar.gz,kernelcache*} /mnt/etc/nixos/firmware
cd /mnt/etc/nixos/firmware
nix-shell -p git
echo "{outputs = {...}:{};}" > flake.nix
git init
git branch -m main
git config user.name "Isabella Skorepova"
git config user.email "isabella@skorepova.info"
git add .
git commit -am "firmware"
```

9. Change config a bit

```nix
imports =
  [
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

# Use the systemd-boot EFI boot loader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = false;

hardware.asahi.pkgsSystem = "x86_64-linux";
networking.wireless.iwd = {enable=true; settings.General.EnableNetworkConfiguration = true; } ;
hardware.asahi.peripheralFirmwareDirectory = ./firmware;
networking.hostName = "IsblAsahi";
users.users.isabella = {
  isNormalUser = true;
  extraGroups = ["wheel"];
};
nix.settings.experimental-features = [ "nix-command" "flakes" ];
environment.systemPackages = with pkgs; [
  git vim
];
```

10. Install

```sh
systemctl restart systemd-timesyncd
nixos-install
reboot
```

11. Post-install

- Login as root and `passwd isabella`
- Login as isabella
- `iwctl` to connect to WiFi (see previous step)
- `git clone https://github.com/CodeWitchBella/nixos`
- `sudo ln -s /home/isabella/nixos/flake.nix /etc/nixos/`
- `cp /etc/nixos/hardware-configuration.nix systems/asahi/`
- edit hardware-configuration to set `neededForBoot=true;` at `/persistent`
- `nix flake lock --update-input asahi-firmware`
- `sudo nixos-rebuild boot --impure`
- reboot

</details>

To apply changes:

```sh
sudo nixos-rebuild switch --impure
```
