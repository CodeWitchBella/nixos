{ pkgs, lib, ... }:
{
  services.nix-daemon.enable = true;
  services.activate-system.enable = true;
  
  programs.zsh.enable = true;
  #nixpkgs.config.allowUnfree = true;
  networking.hostName = "IsabellaM2";
  security.pam.enableSudoTouchIdAuth = true;
 
  nix = {
    settings = {
      auto-optimise-store = true;
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.curl
    pkgs.vim
    pkgs.htop
    pkgs.jq
    pkgs.gh
    pkgs.awscli2
    pkgs.lastpass-cli
    pkgs.docker-compose
    pkgs.cachix
    pkgs.direnv
    pkgs.gnupg
    pkgs.nushell
  ];
  environment.shells = [pkgs.nushell];
  environment.loginShell = pkgs.nushell;

  users.users.isabella = {
    name = "isabella";
    home = "/Users/isabella";
    shell = pkgs.nushell;
  };

  system.stateVersion = 4;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.isabella = {pkgs,...}: let
    shared = import ../shared/home.nix { inherit pkgs; };
  in lib.recursiveUpdate shared {
    home.stateVersion = "23.11";
    programs.ssh = {
      enable = true;
      extraConfig = ''IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
    };
    programs.vscode.userSettings = {
      "window.zoomLevel" = 0;
    };
    programs.nushell.extraEnv = ''
      $env.PATH = "/Users/isabella/.nix-profile/bin:/etc/profiles/per-user/isabella/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin"
    '';
  };

  fonts.fontDir.enable = true;
  fonts.fonts = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = false;
    onActivation.upgrade = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "discord"
      "firefox"
      "inkscape"
      "obs"
      "rectangle"
      "spotify"
      "telegram"
      "vlc"
      "zoom"
      "1password"
      "logi-options-plus"
      "gimp"
      "cloudflare-warp"
    ];
  };
  system.defaults = {
    dock = {
      show-recents = false;
      autohide = true;
      # static-only = true;
    };
    finder.AppleShowAllExtensions = true;
    # finder.QuitMenuItem = true;
  };
}

