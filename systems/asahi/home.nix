{
  pkgs,
  lib,
  config,
  ...
}: let
  shared = import ../personal/home.nix {inherit pkgs lib config;};
in
  lib.recursiveUpdate shared {
    home.file.".config/input-remapper-2/config.json".source = ./input-remapper/config.json;
    home.file.".config/input-remapper-2/presets/Apple MTP keyboard/normal_order.json".source = ./input-remapper/normal_order.json;
  }
