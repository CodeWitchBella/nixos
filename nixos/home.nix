{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    firefox
    _1password
    _1password-gui
    git
    vscode
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
  programs.direnv = {
    enable = true;
  };
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
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
  home.stateVersion = "23.05";
}
