{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.system}.default
    fuzzel
    rofi
    swaybg
    xwayland-satellite
    swaylock
    inputs.quickshell # .packages.${pkgs.system}.default
    tokyonight-gtk-theme
    nemo
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };

      initial_session = {
        command = "niri-session";
        user = "gumbo";
      };
    };
  };

}
