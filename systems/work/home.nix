{
  pkgs,
  lib,
  config,
  ...
}: let
  shared = import ../shared/home.nix {inherit pkgs lib config;};
in
  lib.recursiveUpdate shared {
    # https://rycee.gitlab.io/home-manager/options.html
    nixpkgs.config.allowUnfree = true;
    programs.git.extraConfig = {
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINJNSxGvq+d/a51mbAhZXXEM5BtFs5AihszeGgfl67Km";
    };
    programs.ssh = {
      enable = true;
    };
    home.stateVersion = "23.05";
  }
