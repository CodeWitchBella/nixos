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
            (
              builtins.filter
              (
                ext:
                  ext.name
                  != "rust-analyzer"
                  && ext.name != "alejandra"
                  # atlassian crap only on work machine
                  && ext.name != "atlascode"
              )
              (import ../vscode/extensions.nix).extensions
            )
            ++ (
              if host == "work"
              then (import ../vscode/extensions-work.nix).extensions
              else []
            )
          )
        );
    }
    // {pname = "vscode";};
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
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.rulers" = [80 120];
    "diffEditor.ignoreTrimWhitespace" = false;
    "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.formatOnSave" = true;
    "vsicons.dontShowNewVersionMessage" = true;
  };
}
