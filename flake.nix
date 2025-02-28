{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    asahi-firmware.url = "git+file:/persistent/firmware?ref=main";
    nixos-apple-silicon = {
      url = "github:oliverbestmann/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/x86_64-linux";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell = {
      url = "github:numtide/devshell";
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

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      asahi-firmware,
      nixos-apple-silicon,
      ...
    }:
    let
      modules = (import ./modules/modules.nix) ++ [
        inputs.nixos-cosmic.nixosModules.default
        home-manager.nixosModules.home-manager
        inputs.agenix.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
      ];
    in
    (inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devshell.flakeModule ];
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixfmt-rfc-style;
          devshells.default = {
            packages = [ inputs.agenix.packages."${system}".default ];
          };
        };
    })
    // {
      nixosConfigurations."IsblDesktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = modules ++ [
          ./systems/desktop/configuration.nix
          {
            networking.hostName = "IsblDesktop";
            home-manager.sharedModules = [ ];
            home-manager.users.isabella = import ./systems/desktop/home.nix;
          }
        ];
      };
      nixosConfigurations."IsblAsahi" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = modules ++ [
          ./systems/asahi/configuration.nix

          nixos-apple-silicon.nixosModules.apple-silicon-support
          {
            hardware.asahi.peripheralFirmwareDirectory = asahi-firmware;
            networking.hostName = "IsblAsahi";
            home-manager.users.isabella = import ./systems/asahi/home.nix;
          }
        ];
      };
      nixosConfigurations."IsblWork" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = modules ++ [
          ./systems/work/configuration.nix
          {
            networking.hostName = "IsblWork";
            home-manager.users.isabella = import ./systems/work/home.nix;
          }
        ];
      };
    };
}
