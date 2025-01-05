# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
let
  # Use /dev/mapper to prevent timeout:
  # https://github.com/NixOS/nixpkgs/issues/250003#issuecomment-1724708072
  encryptedDevice = "/dev/mapper/luks-a1f7c9fc-b483-4851-87ad-29e56d103c3c";
  #   encryptedDevice = "/dev/disk/by-uuid/426400d9-5b4c-4957-8f29-fe43c391ab92";
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "thunderbolt"
    "xhci_pci"
    "ahci"
    "usbhid"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = encryptedDevice;
    fsType = "btrfs";
    options = [ "subvol=rootfs" ];
  };

  boot.initrd.luks.devices."luks-a1f7c9fc-b483-4851-87ad-29e56d103c3c".device =
    "/dev/disk/by-uuid/a1f7c9fc-b483-4851-87ad-29e56d103c3c";

  fileSystems."/nix" = {
    device = encryptedDevice;
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/persistent" = {
    device = encryptedDevice;
    fsType = "btrfs";
    options = [ "subvol=persistent" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1248-F9CB";
    fsType = "vfat";
  };

  swapDevices = [
    # { device = "/dev/disk/by-uuid/f4fa709b-277b-49cb-8993-d0ee6b235f61"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp10s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
