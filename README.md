# isbl-nixos

This repo currently contains my desktop nixos setup. I also had
[MacOS nix setup](https://github.com/CodeWitchBella/nix-darwin-config/tree/main)
but I'll likely either stop using that if I stop using mac, or move it here too.

## Getting Started

1. install nixos with user named `isabella`
2. git clone this repo to ~/nixos (some parts of this config assume this path)
3. `ln -s /home/isabella/nixos/flake.nix /etc/nixos/`
4. `nixos-rebuild switch`
5. configure 1password to run on start in Tweaks

## Getting started MacOS

1. Install homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Install nix: `sh <(curl -L https://nixos.org/nix/install)`
3. Set hostname: `scutil --set IsabellaM2` (or setup new system in configuration)
4. Clone the repo `git clone git@github.com:CodeWitchBella/nixos.git`
5. Install this flake: `nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake ~/nixos`
6. Set nushell as default: `chsh -s /run/current-system/sw/bin/nu`

Now you can use everything as normal. Use the following to apply changes:

```
darwin-rebuild switch --flake ~/nixos/flake.nix
```

## Getting Started Asahi

<details>
<summary>This is long. Click to expand.</summary>

(it's written from memory so might be incomplete somewhere)

1. Boot into the installer. [guide](https://github.com/tpwrules/nixos-apple-silicon/blob/main/docs/uefi-standalone.md)
2. Delete existing install (if exists)
   ```sh
   sgdisk /dev/nvme0n1 -p
   sgdisk /dev/nvme0n1 -d=X # replace X with old partition, probably 5
   ```
3. Create new partition

```sh
sgdisk /dev/nvme0n1 -p # to see preexisting partitions
sgdisk /dev/nvme0n1 -n 0:0 -s
sgdisk /dev/nvme0n1 -p # look for the new partition
cryptsetup luksFormat /dev/nvme0n1p5
cryptsetup luksOpen /dev/nvme0n1p5 cryptroot
mkfs.ext4 -L nixos /dev/mapper/cryptroot
```

4. Mount everything and copy stuff

```sh
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-partuuid/`cat /proc/device-tree/chosen/asahi,efi-system-partition` /mnt/boot
```

5. Generate config

```sh
nixos-generate-config --root /mnt
cp -r /etc/nixos/apple-silicon-support /mnt/etc/nixos/
chmod -R +w /mnt/etc/nixos/
nano /mnt/etc/nixos/configuration.nix
```

6. Deal with firmware+flakes

```sh
mkdir -p /mnt/etc/nixos/firmware && cp /mnt/boot/asahi/{all_firmware.tar.gz,kernelcache*} /mnt/etc/nixos/firmware
cd /mnt/etc/nixos/firmware
nix-shell -p git
git init
git config user.name "Isabella Skorepova"
git config user.email "isabella@skorepova.info"
git commit -am "firmware"
```

7. Change config a bit

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

8. WiFi

```sh
iwctl
station wlan0 show
station wlan0 connect-hidden wifiname
# wait for password prompt
```

9. Install

```sh
systemctl restart systemd-timesyncd
nixos-install
reboot
```

10. Post-install

- Login as root and `passwd isabella`
- Login as isabella
- `iwctl` to connect to WiFi
- `git clone https://github.com/CodeWitchBella/nixos`
- `sudo ln -s /home/isabella/nixos/flake.nix /etc/nixos/`
- `sudo nixos-rebuild switch --impure`
- reboot

</details>

To apply changes:

```sh
sudo nixos-rebuild switch --impure
```
