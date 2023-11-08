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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };
  outputs = inputs@{ nixpkgs, home-manager, darwin, asahi-firmware, nixos-apple-silicon, nixvim, flake-utils, ... }: {
    darwinConfigurations."IsabellaM2" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./darwin/configuration.nix
      ];
    };
    nixosConfigurations."IsblDesktop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./systems/desktop/configuration.nix
        nixvim.nixosModules.nixvim
        home-manager.nixosModules.home-manager
        {
          networking.hostName = "IsblDesktop";
          home-manager.users.isabella = import ./systems/personal/home.nix;
        }
      ];
    };
    nixosConfigurations."IsblAsahi" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./systems/asahi/configuration.nix
        nixvim.nixosModules.nixvim
        home-manager.nixosModules.home-manager
        nixos-apple-silicon.nixosModules.apple-silicon-support
        {
          hardware.asahi.peripheralFirmwareDirectory = asahi-firmware;
          networking.hostName = "IsblAsahi";
          home-manager.users.isabella = import ./systems/personal/home.nix;
        }
      ];
    };
    nixosConfigurations."IsblWork" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./systems/work/configuration.nix
        nixvim.nixosModules.nixvim
        home-manager.nixosModules.home-manager
        {
          networking.hostName = "IsblWork";
          home-manager.users.isabella = import ./systems/work/home.nix;
        }
      ];
    };
  } // (flake-utils.lib.eachDefaultSystem (system: { formatter = nixpkgs.legacyPackages.${system}.alejandra; }));
}
