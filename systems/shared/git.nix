{pkgs, ...}: {
  enable = true;
  lfs.enable = true;
  userName = "Isabella Skořepová";
  userEmail = "isabella@skorepova.info";
  extraConfig = {
    init.defaultBranch = "main";
    push.autoSetupRemote = true;
    submodule.recurse = "true";
    user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGS4V/SauPK+C9moGX5gscGYYPNV5E6QNUyaZrL1eg0";
    commit.gpgsign = true;
    gpg.format = "ssh";
    alias.frp = "!bash -c \"git fetch --prune --tags ; git rebase `git symbolic-ref refs/remotes/origin/HEAD --short`; git push --force\"";
    alias.fr = "!bash -c \"git fetch --prune --tags ; git rebase `git symbolic-ref refs/remotes/origin/HEAD --short`\"";
    alias.ruff = ''      !bash -c "
              set -xe
              if [ -z \"`git status --porcelain`\" ]; then
                if ruff format --check && ruff check; then
                  echo \"Everything ok\"
                else
                  ruff format
                  ruff check --fix
                  git commit -a -m ruff
                  echo \"ruffed some feathers\"
                fi
              else
                echo \"not ready for ruff\"
                exit 1
              fi
            "
    '';
    rebase.autostash = true;
    pull.rebase = true;
    "gpg \"ssh\"".program = "${pkgs.openssh}/bin/ssh-keygen";
  };
}
