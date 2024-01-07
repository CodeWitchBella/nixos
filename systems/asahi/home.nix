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
  }
