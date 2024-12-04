{
  config,
  pkgs,
  ...
}:
{
  imports = [ ../shared/configuration.nix ];

  services.tailscale.enable = true;
  isbl.impermanence.rootDirectories = [
    "/var/lib/tailscale"
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.sane = {
    enable = true;
    snapshot = true;
  };
  environment.systemPackages = with pkgs; [
    gimp
    krita
    vlc
    ffmpeg
    # obs-studio
    bitwarden-cli
    rbw
    super-slicer-latest
    openscad
    telegram-desktop
    inkscape
    valent
    ktailctl
    simple-scan
  ];

  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
  hardware.sane.extraBackends = with pkgs; [ sane-airscan ];
  services.ipp-usb.enable = true;

  age.secrets.password.file = ../../secrets/password.age;
  users.users.isabella.hashedPasswordFile = config.age.secrets.password.path;
}
