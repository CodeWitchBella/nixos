# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}:
let
  m = {
    unitConfig = {
      FailureAction = "poweroff-force";
      StartLimitAction = "poweroff-force";
    };
  };
in
{
  imports = [
    ./impermanence.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../personal/configuration.nix
  ];
  nix.gc.automatic = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.systemd-boot.configurationLimit = 120;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  #boot.kernelPackages = pkgs.linuxPackages_5_4;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment.systemPackages = with pkgs; [
    bitwarden # missing aarch64 and it does not really do much anyways
    ungoogled-chromium
  ];

  isbl.services.sunshine.enable = true;
  isbl.backup-restic = {
    enable = true;
    passwordFile = ../../secrets/restic-desktop.age;
    folder = "/desktop";
  };
  programs.steam.enable = true;
  systemd.user.services.sunshine.environment.WAYLAND_DISPLAY = "wayland-0";

  # systemd.enableEmergencyMode = false;
  # boot.initrd.systemd.services."dev-nvme0n1p1.device" = m;
  # boot.initrd.systemd.services."systemd-ask-password-console.service" = m;
  # boot.initrd.systemd.services."dev-disk-by\\x2duuid-426400d9\\x2d5b4c\\x2d4957\\x2d8f29\\x2dfe43c391ab92.device" = m;
  # boot.initrd.systemd.services."dev-mapper-luks\\x2da1f7c9fc\\x2db483\\x2d4851\\x2d87ad\\x2d29e56d103c3c.device" = m;
  # boot.initrd.systemd.services."dev-disk-by\\x2duuid-a1f7c9fc\\x2db483\\x2d4851\\x2d87ad\\x2d29e56d103c3c.device" = m;

  # boot.initrd.systemd.services.timeout-shutdown = {
  #   description = "Shutdown the system on password timeout";
  #   wantedBy = [
  #     "initrd.target"
  #   ];
  #   after = [
  #     "dev-mapper-cryptroot.device"
  #     "cryptsetup.target"
  #     "initrd-switch-root.target"
  #   ];
  #   before = [
  #     "initrd-switch-root.target"
  #     "run-agenix.d.mount"
  #     "systemd-remount-fs.service"
  #   ];
  #   unitConfig.DefaultDependencies = "no";
  #   serviceConfig.Type = "oneshot";
  #   script = ''
  #     set -xe
  #     if [ ! -e ${config.fileSystems."/".device} ]; then shutdown ; fi
  #   '';
  # };

  system.stateVersion = "23.05"; # Did you read the comment?
}
