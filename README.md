# isbl-nixos

This repo currently contains my desktop nixos setup. I also had
[MacOS nix setup](https://github.com/CodeWitchBella/nix-darwin-config/tree/main)
but I'll likely either stop using that if I stop using mac, or move it here too.

## Getting Started

1. install nixos with user named `isabella`
2. git clone this repo to ~/nixos (some parts of this config assume this path)
3. `ln -s /home/isabella/nixos/flake.nix /etc/nixos/`
4. `nixos-rebuild switch`
5. configure 1password to run on start in Tweaks

## Getting started MacOS

1. Install homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Install nix: `sh <(curl -L https://nixos.org/nix/install)`
3. Set hostname: `scutil --set IsabellaM2` (or setup new system in configuration)
4. Clone the repo `git clone git@github.com:CodeWitchBella/nixos.git`
5. Install this flake: `nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake ~/nixos`
6. Set nushell as default: `chsh -s /run/current-system/sw/bin/nu`

Now you can use everything as normal. Use the following to apply changes:

```
darwin-rebuild switch --flake ~/nixos/flake.nix
```
