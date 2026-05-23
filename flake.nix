{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    nvf.url = "github:notashelf/nvf/";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nvf,
      ...
    }@inputs:
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/home/configuration.nix
          inputs.home-manager.nixosModules.default
          nvf.nixosModules.default
        ];
      };
    };
}
