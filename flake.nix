{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    nvf.url = "github:notashelf/nvf/v0.8";
    ansible-vim.url = "github:pearofducks/ansible-vim";
    ansible-vim.flake = false;

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nvf,
      ...
    }@inputs:
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/home/configuration.nix
          nvf.nixosModules.default
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
