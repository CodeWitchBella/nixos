{ pkgs, lib, config }:
{
  programs.vscode = import ../../vscode/vscode.nix { inherit pkgs; };
  programs.git = import ./git.nix { inherit pkgs; };
  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config.show_banner = false
      source ~/nixos/nushell/zoxide.nu
    '';
  };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = { };
  };
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local custom = require 'custom';
      local config = wezterm.config_builder();
      custom.apply_to_config(config);
      return config;
    '';
  };
  home.file = {
    ".config/wezterm/custom.lua".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ../../wezterm/custom.lua);
  };

  programs.neovim = import ../../neovim/neovim.nix { inherit pkgs; };
}
