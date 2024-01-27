{
  pkgs,
  lib,
  config,
  ...
}: let
  shared = import ../personal/home.nix {
    inherit pkgs lib config;
    host = "desktop";
  };
in
  lib.recursiveUpdate shared {
    programs.git.extraConfig = {
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrYVxQiKKIzGqLIO+6w6qA1d+E9vR2bFLW0EuT4e6zA";
    };
  }
