with (import ./keys.nix); {
  "password.age".publicKeys = users ++ (builtins.attrValues system);
}
