{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../shared/configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "mem_sleep_default=deep"
  ];
  services.fwupd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  systemd.oomd = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    beekeeper-studio
    thunderbird
    graphite-cli
  ];

  virtualisation.podman = {
    enable = true;
  };

  system.stateVersion = "23.05";
}
