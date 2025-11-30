{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'uwsm start hyprland-uwsm.desktop'";
        user = "greeter";
      };
      initial_session = {
        command = "uwsm start hyprland-uwsm.desktop";
        user = "gumbo";
      };
    };
  };

  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = { };

  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
    ghostty
    screen
    rofi
    tokyonight-gtk-theme
    brightnessctl
    pamixer
    grim
    slurp
    wl-clipboard
    swayimg
    nemo
    gvfs
  ];
}
