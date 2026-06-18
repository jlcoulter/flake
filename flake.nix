{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    nvf.url = "github:notashelf/nvf/";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      # ── Desktop (jcpc) ──────────────────────────────────────────────────
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/desktop/default.nix
          inputs.home-manager.nixosModules.default
          nvf.nixosModules.default
        ];
      };

      # ── Server (AMD64) ─────────────────────────────────────────────────
      nixosConfigurations.server-amd = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/server-amd/default.nix
          inputs.home-manager.nixosModules.default
          nvf.nixosModules.default
        ];
      };

      # ── Server (ARM) ───────────────────────────────────────────────────
      nixosConfigurations.server-arm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/server/default.nix
          inputs.home-manager.nixosModules.default
          nvf.nixosModules.default
        ];
      };

      # ── MacBook (macOS) ────────────────────────────────────────────────
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/macbook
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              ./modules/theme/everforest.nix
            ];
            home-manager.users.jlcoulter = import ./hosts/macbook/home.nix;
          }
          nvf.darwinModules.default
        ];
      };
    };
}