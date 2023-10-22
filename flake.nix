{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    asahi-firmware.url = "git+file:/etc/nixos/firmware?ref=main";
  };
  outputs = inputs@{ nixpkgs, home-manager, darwin, asahi-firmware, ... }: {
    darwinConfigurations."IsabellaM2" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./darwin/configuration.nix
      ];
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.isabella = import ./nixos/home.nix;
        }
      ];
    };
    nixosConfigurations."IsblAsahi" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./asahi/configuration.nix
        home-manager.nixosModules.home-manager
        {
          hardware.asahi.peripheralFirmwareDirectory = asahi-firmware;
          networking.hostName = "IsblAsahi";
          home-manager.users.isabella = import ./nixos/home.nix;
        }
      ];
    };
  };
}
