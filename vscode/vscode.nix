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
    "editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";
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
    "atlascode.bitbucket.enabled" = false;
    "redhat.telemetry.enabled" = false;
    "atlascode.jira.jqlList" = [
      {
        "id" = "37c659fb-4276-47d1-8322-f2c5728d4424";
        "siteId" = "6b7e7661-4a41-4d17-a5e2-ffc6e0719bd4";
        "name" = "my tickets in current sprint";
        "query" = "sprint in openSprints() and assignee = currentUser()";
        "enabled" = true;
        "monitor" = true;
      }
      {
        "id" = "25dc507b-83b4-4b8e-9f1d-aaedc5b3284b";
        "siteId" = "6b7e7661-4a41-4d17-a5e2-ffc6e0719bd4";
        "name" = "my tickets in backlog";
        "query" = "sprint is empty and assignee = currentUser()";
        "enabled" = true;
        "monitor" = true;
      }
    ];
    "atlascode.jira.todoIssues.enabled" = false;
    "atlascode.jira.startWorkBranchTemplate.customTemplate" = "isbl/{{{issuekey}}}-{{{summary}}}";
    "python.analysis.typeCheckingMode" = "strict";
    "yaml.schemas"."file:///nix/store/3wvs2g85k4qxp6nl7ndhn1gcr582fc4m-vscode-extension-atlassian-atlascode-3.0.9/share/vscode/extensions/atlassian.atlascode/resources/schemas/pipelines-schema.json" = "bitbucket-pipelines.yml";
    "[yaml]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
}
