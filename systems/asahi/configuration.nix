# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./impermanence.nix
    ./hardware-configuration.nix
    ../personal/configuration.nix
  ];

  nixpkgs.overlays = [
    (import ./widevine.nix)
  ];
  environment.sessionVariables.MOZ_GMP_PATH = [ "${pkgs.widevine}/gmp-widevinecdm/system-installed" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.kernelModules = [ "hid-apple" ];
  boot.extraModprobeConfig = ''
    options hid_apple swap_opt_cmd=1
    options hid_apple swap_fn_leftctrl=1
    options hid_apple fnmode=1
  '';

  services.sshd.enable = false;

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  #hardware.asahi.pkgsSystem = "x86_64-linux";
  hardware.asahi = {
    withRust = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    setupAsahiSound = true;
  };

  hardware.bluetooth = {
    enable = true;
    # input.General.ClassicBondedOnly = false; #see https://discourse.nixos.org/t/nix-channel-23-11-bluez-and-bluezfull/37285/17
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
  # Note that the following two need to be either both enabled, or disabled,
  # otherwise it doesn't boot.
  # settings.General.Experimental = true;
  # services.blueman.enable = true;

  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=0"
  ];

  boot.initrd.systemd.services.timeout-shutdown = {
    description = "Shutdown the system on password timeout";
    wantedBy = [
      "initrd.target"
    ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      set -xe
      sleep 60
      if [ ! -e ${config.fileSystems."/".device} ]; then poweroff ; fi
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
