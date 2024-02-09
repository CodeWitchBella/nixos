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
      #"gpg \"ssh\"".program = "op-ssh-sign";
    };
    programs.ssh = {
      enable = true;
      #matchBlocks."*".extraOptions = {identityAgent = "~/.1password/agent.sock";};
      matchBlocks = {
        "priscilla.local.isbl.cz" = {};
      };
    };

    home.stateVersion = "23.05";
    home.file.".config/rbw/config.json".text = ''{"email":"me@isbl.cz","base_url":"https://vault.isbl.cz/","identity_url":null,"notifications_url":null,"lock_timeout":3600,"sync_interval":3600,"pinentry":"pinentry","client_cert_path":null}'';
  }
