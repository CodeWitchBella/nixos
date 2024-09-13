{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    asahi-firmware.url = "git+file:/etc/nixos/firmware?ref=main";
    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    asahi-firmware,
    nixos-apple-silicon,
    flake-utils,
    lix-module,
    ...
  }:
    {
      nixosConfigurations."IsblDesktop" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules =
          (import ./modules/modules.nix)
          ++ [
            inputs.nixos-cosmic.nixosModules.default
            ./systems/desktop/configuration.nix
            inputs.impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            inputs.ragenix.nixosModules.default
            {
              networking.hostName = "IsblDesktop";
              home-manager.sharedModules = [inputs.plasma-manager.homeManagerModules.plasma-manager];
              home-manager.users.isabella = import ./systems/desktop/home.nix;
            }
          ];
      };
      nixosConfigurations."IsblAsahi" = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        modules =
          (import ./modules/modules.nix)
          ++ [
            ./systems/asahi/configuration.nix
            inputs.nixos-cosmic.nixosModules.default
            home-manager.nixosModules.home-manager
            nixos-apple-silicon.nixosModules.apple-silicon-support
            lix-module.nixosModules.default
            {
              hardware.asahi.peripheralFirmwareDirectory = asahi-firmware;
              networking.hostName = "IsblAsahi";
              home-manager.users.isabella = import ./systems/asahi/home.nix;
            }
          ];
      };
      nixosConfigurations."IsblWork" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./systems/work/configuration.nix
          inputs.nixos-cosmic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            networking.hostName = "IsblWork";
            home-manager.users.isabella = import ./systems/work/home.nix;
          }
        ];
      };
      formatter.aarch64-linux = inputs.alejandra.defaultPackage.aarch64-linux;
      formatter.x86_64-linux = inputs.alejandra.defaultPackage.x86_64-linux;
    }
    // (inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [inputs.devshell.overlays.default];
        };
      in {
        formatter = inputs.alejandra.defaultPackage.${system};
        devShell = pkgs.devshell.mkShell {
          packages = [inputs.ragenix.packages."${system}".default];
        };
      }
    ));
}
