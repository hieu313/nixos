# Central font packages + fontconfig defaults for machines using workstation.baseline.
# Keep font lists here only — avoid duplicating font packages in Home Manager.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.workstation.baseline;
in
{
  config = lib.mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        inter
				open-sans
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [
            "Inter"
            "Open Sans"
            "Noto Sans"
          ];
          serif = [ "Noto Serif" ];
          monospace = [ "JetBrainsMono Nerd Font" ];
        };
      };
      fontDir.enable = true;
    };
  };
}
