{
  description = "Home Manager configuration of alejandro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }:
    {
      darwinConfigurations."wacos" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/wacos/darwin.nix

          # home-manager as a nix-darwin module
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true; # share nixpkgs with nix-darwin: do not build twice!
            home-manager.useUserPackages = true; # install to ~/Applications/Home Manager Apps
            home-manager.users.alejandro = import ./hosts/wacos/home.nix;
          }
        ];
      };

      nixosConfigurations."warch" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/warch/linux.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alejandro = import ./hosts/warch/home.nix;
          }
        ];
      };
    };
}
