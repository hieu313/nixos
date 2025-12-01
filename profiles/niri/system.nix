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
    rofi
    xwayland-satellite
    tokyonight-gtk-theme
    swayimg
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
