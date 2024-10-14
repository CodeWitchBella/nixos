{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./cosmic.nix
    ./kde.nix
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # nix.settings.auto-optimise-store = true; # On every build
  nix.optimise.automatic = true; # on schedule
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 60d";
  };
  nix.package = pkgs.lix;

  system.autoUpgrade = {
    enable = false;
    flake = "${config.users.users.isabella.home}/nixos";
    flags = [
      "--update-input"
      "nixpkgs"
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.isabella = {
    isNormalUser = true;
    description = "Isabella Skořepová";
    extraGroups = ["networkmanager" "wheel" "scanner" "lp" "dialout" "input"];
    shell = pkgs.nushell;
  };
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # services
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nushell
    traceroute
    vim
    wget
    htop
    gnomeExtensions.appindicator
    firefox
    gitFull
    (nerdfonts.override {fonts = ["FiraCode"];})
    b612
    gnome-tweaks
    dig
    mesa-demos
    zoxide
    bat
    fd
    zellij
    usbutils
    wl-clipboard
    inkscape
    vlc
    lshw
    pciutils
    gimp
    gnome-disk-utility

    libreoffice-qt
    hunspell
    hunspellDicts.cs_CZ
    hunspellDicts.en_US-large
    hunspellDicts.en_GB-large
    bind
    evince
    spectacle
    rink
  ];
  virtualisation.podman.enable = true;

  environment.variables = {
    EDITOR = "nvim";
  };
  environment.shells = [pkgs.nushell];
  environment.gnome.excludePackages = [
    pkgs.epiphany # web browser
    pkgs.totem # video player
    pkgs.geary # email client
    # pkgs.seahorse # password manager
    pkgs.gnome.gnome-music
    pkgs.gnome-tour
    pkgs.gnome-console
  ];
  services.xserver.excludePackages = [pkgs.xterm];
  services.udev.packages = with pkgs; [gnome-settings-daemon]; # https://nixos.wiki/wiki/GNOME#Systray_Icons

  # i18n.inputMethod = {
  #   enable = true;
  #   type = "ibus";
  #   ibus.engines = with pkgs.ibus-engines; [uniemoji];
  # };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";
  #time.timeZone = "America/New_York";

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

  services.openssh.enable = lib.mkForce true;
  services.openssh.hostKeys = [
    {
      path = "/persistent/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }
  ];
}
