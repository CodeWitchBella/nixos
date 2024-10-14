with (import ./keys.nix); {
  "password.age".publicKeys = users ++ [system.desktop system.personal];
  "password-work.age".publicKeys = users ++ [system.work];
}
