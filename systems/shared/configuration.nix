{
  config,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # nix.settings.auto-optimise-store = true; # On every build
  nix.optimise.automatic = true; # on schedule
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 60d";
  };

  nix.settings.extra-substituters = [
    "https://cache.lix.systems"
  ];

  nix.settings.trusted-public-keys = [
    "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
  ];

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
    extraGroups = ["networkmanager" "wheel" "scanner" "lp" "dialout"];
    shell = pkgs.nushell;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # services
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    traceroute
    vim
    wget
    htop
    gnomeExtensions.appindicator
    ungoogled-chromium
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

    libreoffice-qt
    hunspell
    hunspellDicts.cs_CZ
    hunspellDicts.en_US-large
    hunspellDicts.en_GB-large
    bind
  ];
  virtualisation.podman.enable = true;

  environment.variables.EDITOR = "nvim";
  environment.shells = [pkgs.nushell];
  environment.gnome.excludePackages = [
    pkgs.epiphany # web browser
    pkgs.totem # video player
    pkgs.geary # email client
    pkgs.seahorse # password manager
    pkgs.gnome.gnome-music
    pkgs.gnome-tour
    pkgs.gnome-console
  ];
  services.xserver.excludePackages = [pkgs.xterm];
  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon]; # https://nixos.wiki/wiki/GNOME#Systray_Icons

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [uniemoji];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.nix-ld.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Enable GNOME and KDE
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
  };
  services.libinput.enable = true;
  services.displayManager = {
    # Enable automatic login for the user, we're aiming to get to encrypted hard
    # drive everywhere anyway.
    autoLogin.enable = true;
    autoLogin.user = "isabella";
  };

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
}
