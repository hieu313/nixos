{
  description = "The whole kit n kaboodle";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    home-managerU = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-managerS = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs-stable,
      home-managerU,
      home-managerS,
      noctalia,
      agenix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      libU = nixpkgs-unstable.lib;
      libS = nixpkgs-stable.lib;

      mkWorkstation =
        { deviceModule, hmImports }:
        libU.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            deviceModule
            home-managerU.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                users.gumbo = {
                  imports = hmImports;
                };
              };
            }
          ];
        };

      mkServer =
        { deviceModule, hmImports }:
        libS.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            deviceModule
            agenix.nixosModules.default
            ./modules/baseline.server.nix
            ./modules/ssh.nix
            home-managerS.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                users.gumbo = {
                  imports = hmImports;
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        erebos = mkWorkstation {
          deviceModule = ./devices/desktop/erebos/default.nix;
          hmImports = [
            ./home/common.nix
            ./home/zsh.nix
            ./home/niri.nix
          ];
        };

        prometheus = mkWorkstation {
          deviceModule = ./devices/laptop/prometheus/default.nix;
          hmImports = [
            ./home/common.nix
            ./home/zsh.nix
            ./home/niri.nix
          ];
        };

        # steamos build is still in testing, expect major changes and broken functionality
        steamos = mkWorkstation {
          deviceModule = ./devices/desktop/dionysus/default.nix;
          hmImports = [
            ./home/steam.nix
          ];
        };

        void = mkServer {
          deviceModule = ./devices/server/void/default.nix;
          hmImports = [
            ./home/server.nix
            ./home/zsh.nix
          ];
        };
      };
    };
}
