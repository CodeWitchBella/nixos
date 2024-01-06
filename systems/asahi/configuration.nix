# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../personal/configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  sound.enable = true;
  services.nix-serve = {
    enable = false;
    secretKeyFile = "/var/cache-priv-key.pem";
  };
  services.nginx = {
    enable = false;
    recommendedProxySettings = true;
    virtualHosts = {
      # ... existing hosts config etc. ...
      "asahi.isbl.cz" = {
        locations."/".proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      };
    };
  };
  services.sshd.enable = false;

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  #hardware.asahi.pkgsSystem = "x86_64-linux";
  hardware.asahi.addEdgeKernelConfig = true;
  hardware.asahi.withRust = true;
  hardware.asahi.useExperimentalGPUDriver = true;
  #hardware.asahi.experimentalGPUInstallMode = "overlay";

  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
  boot.consoleLogLevel = 0;
  boot.kernelParams = ["quiet" "udev.log_level=0"];

  #services.input-remapper.enable = true;

  systemd.services.swap-keys = {
    wantedBy = ["multi-user.target"];
    enable = true;
    serviceConfig = {
      User = "root";
      Group = "root";
    };
    script = ''
      echo 1 > /sys/module/hid_apple/parameters/swap_fn_leftctrl
      echo 1 > /sys/module/hid_apple/parameters/swap_opt_cmd
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
