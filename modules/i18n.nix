{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.workstation.i18n;
in
{
  options.workstation.i18n.enable = lib.mkEnableOption "Enable i18n support";

  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
			type = "fcitx5";
  		enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        kdePackages.fcitx5-qt
        kdePackages.fcitx5-unikey
      ];
    };

    environment.sessionVariables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };
}
