{ pkgs, ... }: {
  # https://rycee.gitlab.io/home-manager/options.html
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    firefox
    _1password
    _1password-gui
    git
    vscode
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Isabella Skořepová";
    userEmail = "isabella@skorepova.info";
    extraConfig = {
      init.defaultBranch = "main";
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
    };
    extensions = with pkgs.vscode-extensions; [
      # wmaurer.change-case
      mkhl.direnv
      editorconfig.editorconfig
      dbaeumer.vscode-eslint
      waderyan.gitblame
      bbenoist.nix
      esbenp.prettier-vscode
      stkb.rewrap
      bradlc.vscode-tailwindcss
      vscode-icons-team.vscode-icons
      thenuprojectcontributors.vscode-nushell-lang
      # arcanis.vscode-zipfs
    ];
  };
  programs.wezterm = {
    enable = true;
  };
  home.stateVersion = "23.05";
}
