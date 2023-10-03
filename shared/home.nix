{ pkgs }:
{
  programs.vscode = import ../vscode/vscode.nix { inherit pkgs; };
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "isabella@skorepova.info";
    userName = "Isabella Skořepová";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      submodule.recurse = "true";
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGS4V/SauPK+C9moGX5gscGYYPNV5E6QNUyaZrL1eg0";
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      alias.frp = "!bash -c \"git fetch --prune ; git rebase `git symbolic-ref refs/remotes/origin/HEAD --short`; git push --force\"";
      alias.fr = "!bash -c \"git fetch --prune ; git rebase `git symbolic-ref refs/remotes/origin/HEAD --short`\"";
    };
  };
}