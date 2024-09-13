{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.isbl.impermanence;
in {
  options = {
    isbl.impermanence = {
      enable = mkEnableOption (lib.mdDoc "marks that we should use impermanence here");
    };
  };

  config = {};
}
