with (import ./keys.nix); {
  "password.age".publicKeys = users ++ [system.desktop];
}
