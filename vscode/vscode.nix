{
  pkgs,
  host,
}:
{
  enable = true;
  enableUpdateCheck = false;
  enableExtensionUpdateCheck = false;
  mutableExtensionsDir = false;
  #package = pkgs.vscode.fhs;
  profiles.default = {
    extensions =
      let
        nixpkgs-exts = with pkgs.vscode-extensions; [
          rust-lang.rust-analyzer
          ms-vscode-remote.remote-ssh
          ms-toolsai.jupyter
          ms-toolsai.jupyter-renderers
          # ms-python.python
        ];
        shared-exts = builtins.filter (
          ext:
          ext.name != "rust-analyzer"
          && ext.name != "remote-ssh"
          && ext.name != "ruff"
          && ext.name != "vscode-pull-request-github"
          && ext.publisher != "ms-python"
          && ext.publisher != "ms-toolsai"
        ) (import ../vscode/extensions.nix).extensions;
        work-exts = if host == "work" then (import ./work-extensions.nix).extensions else [ ];
        exts = shared-exts ++ work-exts;
        build-extension =
          extension:
          pkgs.vscode-utils.buildVscodeMarketplaceExtension {
            mktplcRef = {
              inherit (extension)
                name
                publisher
                version
                sha256
                ;
            };
          };
      in
      nixpkgs-exts ++ (map build-extension exts);
    userSettings = {
      "workbench.iconTheme" = "vscode-icons";
      "files.associations"."flake.lock" = "json";
      "editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";
      "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "window.titleBarStyle" = "custom";
      "window.autoDetectColorScheme" = true;
      "window.zoomLevel" = 1;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "[typescriptreact]"."editor.defaultFormatter" = "biomejs.biome";
      "[typescript]"."editor.defaultFormatter" = "biomejs.biome";
      "[javascript]"."editor.defaultFormatter" = "biomejs.biome";
      "[html]"."editor.defaultFormatter" = "biomejs.biome";
      "editor.rulers" = [
        80
        120
      ];
      "diffEditor.ignoreTrimWhitespace" = false;
      "[css]"."editor.defaultFormatter" = "biomejs.biome";
      "[json]"."editor.defaultFormatter" = "biomejs.biome";
      "editor.formatOnSave" = true;
      "vsicons.dontShowNewVersionMessage" = true;
      "mypy-type-checker.importStrategy" = "fromEnvironment";
      "python.analysis.typeCheckingMode" = "off";
      "python.analysis.diagnosticMode" = "workspace";
      "python.analysis.autoImportCompletions" = true;
      "python.analysis.inlayHints.variableTypes" = true;
      "python.analysis.inlayHints.functionReturnTypes" = true;
      "python.analysis.inlayHints.callArgumentNames" = "all";
      "python.analysis.inlayHints.pytestParameters" = true;
      "python.analysis.fixAll" = [
        "source.unusedImports"
        "source.convertImportFormat"
      ];
      "python.analysis.autoFormatStrings" = true;
      "[yaml]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "workbench.tree.enableStickyScroll" = true;
      "security.workspace.trust.enabled" = false; # doesn't play well with impermanence
      "prisma.showPrismaDataPlatformNotification" = false;
      "git.postCommitCommand" = "push";
      "biome.requireConfigFile" = true;
      "python.locator" = "js";
      "biome.lsp.bin" = "${pkgs.biome}/bin/biome";
    };
  };
}
