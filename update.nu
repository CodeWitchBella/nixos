#!/usr/bin/nu

cd ~/nixos
let inputs = (open flake.lock | from json | get nodes.root.inputs | transpose key value | get key)
let hostname = (hostname)

for input in $inputs {
    if $hostname != "IsblAsahi" and ($input == "asahi-firmware" or $input == "nixos-apple-silicon") {
        continue
    }
    print $"updating input: ($input)"
    nix flake update $input
}

nu vscode/gen-extensions.nu
nix fmt
