{ pkgs, lib, ... }: let
  shared = import ../shared/home.nix { inherit pkgs; };
in lib.recursiveUpdate shared {
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
  programs.git = (import ./git.nix {});
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
