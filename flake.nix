{
  description = "Home Manager configuration of alejandro";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
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
    let
      system = "aarch64-darwin";
    in
    {
      darwinConfigurations."alejandro" = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./darwin.nix

          # home-manager as a nix-darwin module
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true; # share nixpkgs with nix-darwin: do not build twice!
            home-manager.useUserPackages = true; # install to ~/Applications/Home Manager Apps
            home-manager.users.alejandro = import ./home.nix;
          }
        ];
      };
    };
}
