{ pkgs, ... }: {
  # https://rycee.gitlab.io/home-manager/options.html
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    firefox
    _1password
    _1password-gui
    git
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    gnome.gnome-tweaks
    dig
  ];
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Isabella Skořepová";
    userEmail = "isabella@skorepova.info";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      submodule.recurse = "true";
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGS4V/SauPK+C9moGX5gscGYYPNV5E6QNUyaZrL1eg0";
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "op-ssh-sign";
      alias.frp = "!bash -c \"git fetch --prune ; git rebase `git symbolic-ref refs/remotes/origin/HEAD --short`; git push --force\"";
      alias.fr = "!bash -c \"git fetch --prune ; git rebase `git symbolic-ref refs/remotes/origin/HEAD --short`\"";
    };
  };
  programs.ssh = {
    enable = true;
    matchBlocks."*".extraOptions = { identityAgent = "~/.1password/agent.sock"; };
  };
  programs.nushell = {
    enable = true;
    configFile.source = ../nushell/config.nu;
    envFile.source = ../nushell/env.nu;
  };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {};
  };
  programs.direnv = {
    enable = true;
  };
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };
  programs.helix = {
    enable = true;
  };
  programs.vscode = import ../vscode/vscode.nix { inherit pkgs; };
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local custom = require 'custom';
      local config = wezterm.config_builder();
      custom.apply_to_config(config);
      return config;
    '';
  };
  home.stateVersion = "23.05";
}
