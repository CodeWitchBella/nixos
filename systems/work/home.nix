{
  pkgs,
  lib,
  config,
  ...
}:
let
  shared = import ../shared/home.nix {
    inherit pkgs lib config;
    host = "work";
  };
in
lib.recursiveUpdate shared {
  # https://rycee.gitlab.io/home-manager/options.html
  nixpkgs.config.allowUnfree = true;
  programs.git = {
    userEmail = "isabella.skorepova@draslovka.com";
    extraConfig = {
      user.signingKey = "~/.ssh/id_ed25519.pub";
    };
  };
  programs.ssh = {
    enable = true;
  };
  home.stateVersion = "23.05";
}
