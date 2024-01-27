{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.isbl.cosmic;
in {
  meta.maintainers = with lib.maintainers; [nyanbinary];

  options.isbl.cosmic = {
    enable = lib.mkEnableOption (lib.mdDoc "COSMIC desktop environment");
  };

  config = lib.mkIf cfg.enable {
    # components that need to be in PATH
    environment.systemPackages = with pkgs; [
      cosmic-applibrary
      cosmic-applets
      cosmic-bg
      cosmic-comp
      cosmic-edit
      cosmic-files
      cosmic-greeter
      cosmic-icons
      cosmic-launcher
      cosmic-notifications
      cosmic-osd
      cosmic-panel
      cosmic-randr
      cosmic-screenshot
      cosmic-settings
      cosmic-settings-daemon
      cosmic-term
      cosmic-workspaces-epoch
    ];

    # COSMIC portal doesn't support everything yet
    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-cosmic
      #xdg-desktop-portal-gtk
    ];

    # session files for display manager and systemd
    services.xserver.displayManager.sessionPackages = with pkgs; [cosmic-session];
    systemd.packages = with pkgs; [cosmic-session];
  };
}
