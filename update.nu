#!/usr/bin/nu

let inputs = (open flake.lock | from json | get nodes.root.inputs | transpose key value | get key)
let hostname = (hostname)

for input in $inputs {
    if $hostname != "IsblAsahi" and ($input == "asahi-firmware" or $input == "nixos-apple-silicon") {
        continue
    }
    nix flake lock --update-input $input
}
