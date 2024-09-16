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
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

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

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    asahi-firmware,
    nixos-apple-silicon,
    ...
  }:
    (inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [inputs.devshell.flakeModule];
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        formatter = inputs.alejandra.defaultPackage.${system};
        devshells.default = {
          packages = [inputs.agenix.packages."${system}".default];
        };
      };
    })
    // {
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
            inputs.agenix.nixosModules.default
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
            inputs.nixos-cosmic.nixosModules.default
            ./systems/asahi/configuration.nix
            inputs.impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            nixos-apple-silicon.nixosModules.apple-silicon-support
            inputs.agenix.nixosModules.default
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
    };
}
