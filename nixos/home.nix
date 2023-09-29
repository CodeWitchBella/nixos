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
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGS4V/SauPK+C9moGX5gscGYYPNV5E6QNUyaZrL1eg0";
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "op-ssh-sign";
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
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    #package = pkgs.vscode.fhs;
    package = pkgs.vscode-with-extensions.override {
      vscodeExtensions = map
        (extension: pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            inherit (extension) name publisher version sha256;
          };
        })
        (import ../vscode/extensions.nix).extensions;
    } // { pname = "vscode"; };
    userSettings = {
      "workbench.iconTheme" = "vscode-icons";
      "files.associations"."flake.lock" = "json";
      "editor.codeActionsOnSave"."source.fixAll.eslint" = true;
      "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "window.titleBarStyle" = "custom";
      "window.autoDetectColorScheme" = true;
      "window.zoomLevel" = 1;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    # Installing extensions is not compatible with adding them ad-hoc and not all
    # extensions are available in nixos.
    # Instead, I just added the extensions to recommended in this repo so that it
    # becomes one click install.
    #extensions = with pkgs.vscode-extensions; [
    #  mkhl.direnv
    #];
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
  home.stateVersion = "23.05";
}
