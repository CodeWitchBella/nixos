open extensions.nix | lines | filter {|x| ($x | str substring 0..1) == '#'} | str join (char newline) | save -f extensions.nix
char newline | save --append extensions.nix
~/Documents/nixpkgs/pkgs/applications/editors/vscode/extensions/update_installed_exts.sh | save --append extensions.nix
