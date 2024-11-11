with (import ./keys.nix); let
  systems = rec {
    personal = [system.desktop system.asahi];
    all = systems.personal ++ [system.work];
  };
in {
  "password.age".publicKeys = users ++ [system.desktop system.personal];
  "password-work.age".publicKeys = users ++ [system.work];
  "restic-storage-password.age".publicKeys = users ++ systems.personal;
  "restic-desktop.age".publicKeys = users ++ systems.personal;
}
