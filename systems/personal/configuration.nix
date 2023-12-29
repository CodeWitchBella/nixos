{
  config,
  pkgs,
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
  ];
  hardware.sane.extraBackends = with pkgs; [sane-airscan];
  services.ipp-usb.enable = true;
}
