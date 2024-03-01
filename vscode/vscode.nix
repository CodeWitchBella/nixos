{
  pkgs,
  host,
}: {
  enable = true;
  enableUpdateCheck = false;
  enableExtensionUpdateCheck = false;
  mutableExtensionsDir = false;
  #package = pkgs.vscode.fhs;
  package =
    pkgs.vscode-with-extensions.override
    {
      vscodeExtensions = with pkgs.vscode-extensions;
        [
          rust-lang.rust-analyzer
          kamadorueda.alejandra
          ms-vscode-remote.remote-ssh
        ]
        ++ (
          map
          (extension:
            pkgs.vscode-utils.buildVscodeMarketplaceExtension {
              mktplcRef = {
                inherit (extension) name publisher version sha256;
              };
            })
          (
            builtins.filter
            (
              ext:
                ext.name
                != "rust-analyzer"
                && ext.name != "alejandra"
                && ext.name != "remote-ssh"
            )
            (import ../vscode/extensions.nix).extensions
          )
        );
    }
    // {pname = "vscode";};
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
    "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.rulers" = [80 120];
    "diffEditor.ignoreTrimWhitespace" = false;
    "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
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
    "python.analysis.fixAll" = ["source.unusedImports" "source.convertImportFormat"];
    "python.analysis.autoFormatStrings" = true;
    "[yaml]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "workbench.tree.enableStickyScroll" = true;
  };
}
