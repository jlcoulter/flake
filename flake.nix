{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    nvf.url = "github:notashelf/nvf/";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  nix-darwin.url = "github:LnL7/nix-darwin";
  nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nvf,
      nix-darwin,
	home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          inputs.home-manager.nixosModules.default
          nvf.nixosModules.default
        ];
      };
	darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
	system = "aarch64-darwin";

        specialArgs = { inherit self inputs; };
	modules = [
	./hosts/macbook
	inputs.home-manager.darwinModules.home-manager {
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.jlcoulter = import ./modules/shared/home.nix;
}
];
	};
    };
}
