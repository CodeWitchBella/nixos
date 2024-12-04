{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../shared/configuration.nix
  ];
  isbl.impermanence.enable = lib.mkForce false;
  hardware.bluetooth.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "mem_sleep_default=deep"
  ];

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
    ungoogled-chromium
    lens
  ];

  virtualisation.podman = {
    enable = true;
  };

  # nix.buildMachines = [
  #   # let's use the big hunk of metal I have under my desk
  #   {
  #     hostName = "desktop.isbl.cz";
  #     sshUser = "isabella";
  #     sshKey = "/home/isabella/.ssh/id_ed25519";
  #     system = "x86_64-linux";
  #     protocol = "ssh-ng";
  #     maxJobs = 3;
  #     speedFactor = 2;
  #     supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
  #     mandatoryFeatures = [];
  #   }
  # ];
  nix.distributedBuilds = true;
  nix.settings = {
    builders-use-substitutes = true;
  };
  systemd.tmpfiles.rules = [
    "L+ /root/.ssh/id_ed25519 - - - - /home/isabella/.ssh/id_ed25519"
  ];

  age.secrets.password.file = ../../secrets/password-work.age;
  users.users.isabella.hashedPasswordFile = config.age.secrets.password.path;

  system.stateVersion = "23.05";
}
