{ config, pkgs, lib, ... }:

{
  programs.bash.initExtra = ''
    # Only run Gamescope on TTY2
    if [ "$(tty)" = "/dev/tty2" ]; then
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=gamescope
      export GAMESCOPE_DEBUG=1
      export GAMESCOPE_DRM_DEVICE=/dev/dri/card2

      exec ${pkgs.gamescope}/bin/gamescope \
        --backend drm \
        -W 1920 -H 1080 -f -- \
        ${pkgs.steam}/bin/steam -tenfoot -gamepadui
    fi
  '';
}
