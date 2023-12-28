{
  pkgs,
  lib,
  config,
  host,
  ...
}: let
  shared = import ../shared/home.nix {
    inherit pkgs lib config host;
  };
in
  lib.recursiveUpdate shared {
    # https://rycee.gitlab.io/home-manager/options.html
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      _1password
      _1password-gui
    ];
    programs.git.extraConfig = {
      "gpg \"ssh\"".program = "op-ssh-sign";
    };
    programs.ssh = {
      enable = true;
      matchBlocks."*".extraOptions = {identityAgent = "~/.1password/agent.sock";};
    };
    programs.helix = {
      enable = true;
    };
    home.stateVersion = "23.05";
  }
