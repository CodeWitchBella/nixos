{
  pkgs,
  lib,
  config,
  ...
}:
let
  shared = import ../personal/home.nix {
    inherit pkgs lib config;
    host = "desktop";
  };
in
lib.recursiveUpdate shared {
  programs.git.extraConfig = {
    user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrYVxQiKKIzGqLIO+6w6qA1d+E9vR2bFLW0EuT4e6zA";
  };

  # programs.plasma.input.keyboard.layouts = [
  #   {
  #     layout = "us";
  #   }
  #   {
  #     layout = "cz";
  #     variant = "qwerty";
  #   }
  # ];
  # programs.plasma.kwin.effects.fallApart.enable = true;
  # programs.plasma.kwin.nightLight.mode = "location";
  # programs.plasma.kwin.nightLight.location.latitude = "50.0835494";
  # programs.plasma.kwin.nightLight.location.longitude = "14.4341414";
  # programs.plasma.kwin.nightLight.temperature.night = 4500;
  # programs.plasma.kwin.scripts.polonium.enable = true;

  home.file.".config/powerdevilrc" = {
    text = ''
      [AC][SuspendAndShutdown]
      AutoSuspendAction=0
    '';
    target = ".config/powerdevilrc";
  };
  home.file."plasma-org.kde.plasma.desktop-appletsrc".text = ''
    [Containments][24][Applets][28][Configuration][General]
    launchers=applications:systemsettings.desktop,preferred://filemanager,applications:firefox.desktop,applications:org.kde.konsole.desktop
  '';
}
