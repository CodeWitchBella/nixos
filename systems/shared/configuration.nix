{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    git
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    gnome.gnome-tweaks
    dig
  ];
}