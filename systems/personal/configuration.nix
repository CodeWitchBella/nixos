{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [../shared/configuration.nix];

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
    obs-studio
    bitwarden-cli
    rbw
    super-slicer-latest
    cura
    openscad
    freecad
    telegram-desktop
    inkscape
    valent
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
  hardware.sane.extraBackends = with pkgs; [sane-airscan];
  services.ipp-usb.enable = true;
}
