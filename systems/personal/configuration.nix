{ config, pkgs, ... }:
{
  imports = [ ../shared/configuration.nix ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.sane = {
    enable = true;
    snapshot = true;
  };
  environment.systemPackages = with pkgs; [
    gimp
    krita
  ];
  hardware.sane.extraBackends = with pkgs; [ sane-airscan ];
  services.ipp-usb.enable = true;
}
