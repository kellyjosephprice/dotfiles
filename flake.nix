{
  description = "kelly's NixOS system + home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    antigravity-nix.url = "github:jacopone/antigravity-nix";
  };

  outputs = { self, nixpkgs, home-manager, antigravity-nix, ... }: {
    nixosConfigurations.ayocote = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos/configuration.nix
        { nixpkgs.overlays = [ antigravity-nix.overlays.default ]; }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kelly = import ./home/home.nix;
        }
      ];
    };
  };
}
