{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.specialisation != { } || true) {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "isabella";
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      # plasma-browser-integration
      # konsole
      (lib.getBin qttools) # Expose qdbus in PATH
      # ark
      elisa
      # gwenview
      okular
      kate
      khelpcenter
      # spectacle
      ffmpegthumbs
      krdp
    ];
  };
}
