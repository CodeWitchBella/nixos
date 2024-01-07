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
    pinentry
    pinentry-gnome

    libreoffice-qt
    hunspell
    hunspellDicts.cs_CZ
    hunspellDicts.en_US-large
    hunspellDicts.en_GB-large
  ];
  hardware.sane.extraBackends = with pkgs; [sane-airscan];
  services.ipp-usb.enable = true;
}
