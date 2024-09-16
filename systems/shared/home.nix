{
  pkgs,
  lib,
  config,
  host,
}: {
  programs.vscode = import ../../vscode/vscode.nix {inherit pkgs host;};
  programs.git = import ./git.nix {inherit pkgs;};
  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config.show_banner = false
      source ~/nixos/nushell/zoxide.nu
    '';
    extraEnv = ''
      $env.EDITOR = "nvim"
    '';
  };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {};
  };
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  programs.neovim = import ../../neovim/neovim.nix {inherit pkgs;};

  home.file = {
    ".config/kwalletrc".source = ./home/-config/kwalletrc;
    ".config/kxkbrc".source = ./home/-config/kxkbrc;
  };
}
