# isbl-nixos

This repo currently contains my desktop nixos setup. I also had
[MacOS nix setup](https://github.com/CodeWitchBella/nix-darwin-config/tree/main)
but I'll likely either stop using that if I stop using mac, or move it here too.

## Getting Started

1. install nixos
2. git clone this repo to ~/nixos
3. `ln -s /home/isabella/nixos/flake.nix /etc/nixos/`
4. `ln -s ~/nixos/wezterm/custom.lua ~/.config/wezterm/custom.lua`
5. `nixos-rebuild switch`
6. configure 1password to run on start in Tweaks

## Getting started MacOS 

1. Install nix: `sh <(curl -L https://nixos.org/nix/install)`
2. Set hostname to `IsabellaM2` (or setup new system in configuration)
3. Clone the repo `git clone git@github.com:CodeWitchBella/nixos.git`
4. Install this flake: `nix run nix-darwin -- switch --flake ~/.config/nix-darwin`

