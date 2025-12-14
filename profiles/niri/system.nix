{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.niri.enable = true;

  programs.yazi = {
    enable = true;
    plugins = {
      starship = pkgs.yaziPlugins.starship;
      wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
      chmod = pkgs.yaziPlugins.chmod;
      git = pkgs.yaziPlugins.git;
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    rofi
    xwayland-satellite
    tokyonight-gtk-theme
    swayimg
    rose-pine-cursor
    pkgs.adwaita-icon-theme
    nemo

  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };

      initial_session = {
        command = "niri-session";
        user = "gumbo";
      };
    };
  };

}
