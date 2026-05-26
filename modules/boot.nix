{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.workstation.boot;
in
{
  options.workstation.boot = {
    enable = lib.mkEnableOption "Boot configuration";

    loader = lib.mkOption {
      type = lib.types.enum [ "systemd-boot" "grub" ];
      default = "systemd-boot";
      description = "Boot loader to use: systemd-boot or grub";
    };

		enablePlymouth = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable Plymouth boot";
		};
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader = {
        efi = {
					canTouchEfiVariables = true;
					efiSysMountPoint = "/boot";
				};

        systemd-boot = {
          enable = cfg.loader == "systemd-boot";
          configurationLimit = 10;
        };

        grub = lib.mkIf (cfg.loader == "grub") {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = false;
          theme = pkgs.callPackage ../pkgs/wuthering-grub2-theme.nix {
            theme = "jinxi";
            screen = "1080p";
          };
          gfxmodeEfi = "1920x1080,auto";

          extraEntries = ''
            menuentry "Windows Boot Manager" --class windows --class os {
              insmod part_gpt
              insmod fat
              insmod chain
              search --no-floppy --fs-uuid --set=root D0D1-D1CA
              chainloader /efi/Microsoft/Boot/bootmgfw.efi
            }
          '';
        };
      };

			plymouth = lib.mkIf cfg.enablePlymouth {
				enable = true;
				theme = "spin";
				themePackages = with pkgs; [
					# By default we would install all themes
					(adi1090x-plymouth-themes.override {
						selected_themes = [ "spin" ];
					})
				];
			};

			# Enable "Silent boot"`
			consoleLogLevel = 3;
			initrd.verbose = false;
			kernelParams = [
				"quiet"
				"udev.log_level=3"
				"systemd.show_status=auto"
			];
    };
  };
}