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
    pkgs-stable.super-slicer-latest
    cura
    openscad
    freecad
    telegram-desktop
  ];
  hardware.sane.extraBackends = with pkgs; [sane-airscan];
  services.ipp-usb.enable = true;
}
