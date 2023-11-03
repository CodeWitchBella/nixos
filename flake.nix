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
    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, home-manager, darwin, asahi-firmware, nixos-apple-silicon, ... }: {
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
        nixos-apple-silicon.nixosModules.apple-silicon-support
        {
          hardware.asahi.peripheralFirmwareDirectory = asahi-firmware;
          networking.hostName = "IsblAsahi";
          home-manager.users.isabella = import ./nixos/home.nix;
        }
      ];
    };
    nixosConfigurations."IsblWork" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./work/configuration.nix
        home-manager.nixosModules.home-manager
        {
          networking.hostName = "IsblWork";
          home-manager.users.isabella = import ./work/home.nix;
        }
      ];
    };
  };
}
