{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.workstation.bootmgr;
in
{
  options.workstation.bootmgr = {
    enable = lib.mkEnableOption "Boot manager configuration";

    loader = lib.mkOption {
      type = lib.types.enum [ "systemd-boot" "grub" ];
      default = "systemd-boot";
      description = "Boot loader to use: systemd-boot or grub";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;

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
            menuentry "Windows Boot Manager" {
							insmod part_gpt
							insmod fat
							insmod chain
							search --no-floppy --fs-uuid --set=root D0D1-D1CA
							chainloader /efi/Microsoft/Boot/bootmgfw.efi
            }
						menuentry "Arch Linux" {
							insmod part_gpt
							insmod ext2
							search --no-floppy --fs-uuid --set=root ee5e8f38-3176-47a1-b00f-a5b9dc7ef605
							linux /boot/vmlinuz-linux root=UUID=ee5e8f38-3176-47a1-b00f-a5b9dc7ef605 rw quiet
							initrd /boot/intel-ucode.img /boot/initramfs-linux.img
						}
          '';
        };
      };

      kernelPackages = pkgs.linuxPackages_latest;
      kernelModules = [ "uvcvideo" ];
    };
  };
}