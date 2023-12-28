{
  pkgs,
  lib,
  config,
  ...
}: let
  shared = import ../personal/home.nix {
    inherit pkgs lib config;
    host = "desktop";
  };
in
  lib.recursiveUpdate shared {}
