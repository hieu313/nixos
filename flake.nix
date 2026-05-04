{
  description = "The whole kit n kaboodle";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-managerU = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/latest";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      home-managerU,
      noctalia,
      flatpaks,
      nixos-wsl,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      libU = nixpkgs-unstable.lib;

      mkWorkstation =
        { deviceModule, hmImports }:
        libU.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            deviceModule
            home-managerU.nixosModules.home-manager
            flatpaks.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                sharedModules = [
                  # Propagate hostName to HM modules
                  (
                    { osConfig, ... }:
                    {
                      _module.args.hostName = osConfig.networking.hostName;
                    }
                  )
                  # Expose declarative-flatpak Home Manager module
                  flatpaks.homeModules.default
                ];
                users.hieunm = {
                  imports = hmImports;
                };
              };
            }
          ];
        };

      mkWsl =
        { deviceModule, hmImports }:
        libU.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            nixos-wsl.nixosModules.default
            deviceModule
            home-managerU.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                sharedModules = [
                  (
                    { osConfig, ... }:
                    {
                      _module.args.hostName = osConfig.networking.hostName;
                    }
                  )
                ];
                users.hieunm = {
                  imports = hmImports;
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        prometheus = mkWorkstation {
          deviceModule = ./devices/laptop/prometheus/default.nix;
          hmImports = [
            ./home/common.nix
            ./home/programs/zsh.nix
            ./home/desktop/niri.nix
          ];
        };

        aries = mkWorkstation {
          deviceModule = ./devices/laptop/aries/default.nix;
          hmImports = [
            ./home/common.nix
            ./home/programs/zsh.nix
            ./home/desktop/niri.nix
          ];
        };

        wsl = mkWsl {
          deviceModule = ./devices/wsl/default.nix;
          hmImports = [
            ./home/wsl.nix
          ];
        };
      };
    };
}
