{
  pkgs,
  lib,
  config,
  ...
}: let
  shared = import ../personal/home.nix {
    inherit pkgs lib config;
    host = "asahi";
  };
in
  lib.recursiveUpdate shared {
    programs.git.extraConfig = {
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZdRoS3HXiUh77MLq2OczaysE79CK0NZGfHyH+3tBlv";
    };
  }
