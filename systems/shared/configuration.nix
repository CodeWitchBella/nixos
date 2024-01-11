{
  config,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
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
    extraGroups = ["networkmanager" "wheel" "scanner" "lp"];
    shell = pkgs.nushell;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # services
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    gnomeExtensions.appindicator
    ungoogled-chromium
    firefox
    gitFull
    (nerdfonts.override {fonts = ["FiraCode"];})
    gnome.gnome-tweaks
    dig
    mesa-demos
    zoxide
    bat
    fd
    zellij
    usbutils
    wl-clipboard

    libreoffice-qt
    hunspell
    hunspellDicts.cs_CZ
    hunspellDicts.en_US-large
    hunspellDicts.en_GB-large
  ];
  environment.variables.EDITOR = "nvim";
  environment.shells = [pkgs.nushell];
  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany # web browser
    totem # video player
    geary # email client
    seahorse # password manager
    gnome-music
    pkgs.gnome-tour
    pkgs.gnome-console
  ];
  services.xserver.excludePackages = [pkgs.xterm];
  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon]; # https://nixos.wiki/wiki/GNOME#Systray_Icons

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [uniemoji];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Enable GNOME and KDE
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm.enable = true;

      # Enable automatic login for the user, we're aiming to get to encrypted hard
      # drive everywhere anyway.
      autoLogin.enable = true;
      autoLogin.user = "isabella";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
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
