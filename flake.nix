{
  description = "The whole kit n kaboodle";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      home-manager,
      noctalia,
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
            home-manager.nixosModules.home-manager
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
        # erebos is my desktop/gaming build
        erebos = mkWorkstation {
          deviceModule = ./devices/desktop/erebos/default.nix;
          hmImports = [
            ./home/common.nix
            ./home/zsh.nix
            # all hm environments are listed below, comment/uncomment as needed
            ./home/niri.nix
            # ./home/hypr.nix
            # ./home/gnome.nix
            # ./home/kde.nix
            # ./home/xfce.nix
          ];
        };

        # prometheus is my laptop build
        prometheus = mkWorkstation {
          deviceModule = ./devices/laptop/prometheus/default.nix;
          hmImports = [
            ./home/common.nix
            ./home/zsh.nix
            # all hm environments are listed below, comment/uncomment as needed
            ./home/niri.nix
            # ./home/hypr.nix
            # ./home/gnome.nix
            # ./home/kde.nix
            # ./home/xfce.nix
          ];
        };

        # steamos build is still in testing, expect major changes and broken functionality
        steamos = mkWorkstation {
          deviceModule = ./devices/desktop/dionysus/default.nix;
          hmImports = [
            ./home/steam.nix
          ];
        };
      };
    };
}
