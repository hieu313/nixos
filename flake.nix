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
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      home-managerU,
      noctalia,
      flatpaks,
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
    in
    {
      nixosConfigurations = {
        erebos = mkWorkstation {
          deviceModule = ./devices/desktop/erebos/default.nix;
          hmImports = [
            ./home/common.nix
            ./home/programs/zsh.nix
            ./home/desktop/kde.nix
          ];
        };

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

        null = mkWorkstation {
          deviceModule = ./devices/desktop/null/default.nix;
          hmImports = [
            ./home/common.nix
            ./home/programs/zsh.nix
            ./home/desktop/kde.nix
          ];
        };

        # steamos build is still in testing, expect major changes and broken functionality
        steamos = mkWorkstation {
          deviceModule = ./devices/desktop/dionysus/default.nix;
          hmImports = [
            ./home/programs/steam.nix
          ];
        };
      };
    };
}
