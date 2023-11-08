{ pkgs, lib, config, ... }: let
  shared = import ../shared/home.nix { inherit pkgs lib config; };
in lib.recursiveUpdate shared {
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
    matchBlocks."*".extraOptions = { identityAgent = "~/.1password/agent.sock"; };
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
  home.stateVersion = "23.05";
}
