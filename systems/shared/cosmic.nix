{
  inputs,
  pkgs,
  lib,
  ...
}: {
  nix.settings = {
    substituters = ["https://cosmic.cachix.org/"];
    trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
  };
  specialisation.cosmic.configuration = {
    # Enable COSMIC Epoch
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    systemd.tmpfiles.rules = [
      "L /usr/share/X11/xkb/rules/base.xml - - - - ${pkgs.xkeyboard_config}/share/X11/xkb/rules/base.xml"
    ];
  };
  environment.systemPackages = with pkgs; [cosmic-term];

  programs.ssh.startAgent = true;
  environment.variables.SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
  systemd.user.services.preload-ssh-key = {
    after = ["ssh-agent.service"];
    wants = ["ssh-agent.service"];
    wantedBy = ["default.target"];
    script = with pkgs; ''
      ${openssh}/bin/ssh-add ~/.ssh/id_ed25519
    '';
  };
}
