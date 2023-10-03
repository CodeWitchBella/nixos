{ pkgs, lib, ... }:
{

  services.nix-daemon.enable = true;
  
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
    pkgs.nushell
    pkgs.awscli2
    pkgs.lastpass-cli
    pkgs.docker-compose
    pkgs.cachix
    pkgs.direnv
    pkgs.gnupg
  ];

  users.users.isabella = {
    name = "isabella";
    home = "/Users/isabella";
  };

  system.stateVersion = 4;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.isabella = {pkgs,...}: {
    home.stateVersion = "23.11";
    programs.git = {
      enable = true;
      lfs.enable = true;
      userEmail = "isabella@skorepova.info";
      userName = "Isabella Skořepová";
      extraConfig = {
        init.defaultBranch = "main";
        submodule.recurse = "true";
        commit = {
          gpgSign = true;
        };
        alias.frp = "!bash -c \"git fetch --prune ; git rebase `git symbolic-ref refs/remotes/origin/HEAD --short`; git push --force\"";
        alias.fr = "!bash -c \"git fetch --prune ; git rebase `git symbolic-ref refs/remotes/origin/HEAD --short`\"";
      };
    };
    programs.nushell = {
      enable = true;
      envFile.source = ../nushell/env.nu;
      configFile.source = ../nushell/config.nu;
    };
    programs.ssh = {
      enable = true;
      extraConfig = ''IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
    };
  };

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "discord"
      "firefox"
      "inkscape"
      "obs"
      "rectangle"
      "spotify"
      "telegram"
      "visual-studio-code"
      "vlc"
      "zoom"
      "1password"
    ];
  };
}

