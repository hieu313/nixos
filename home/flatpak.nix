{
  lib,
  hostName,
  ...
}:
{
  services.flatpak = lib.mkIf (hostName == "aries") {
    enable = true;
    remotes = {
      flathub = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
    packages = [
      "flathub:app/app.zen_browser.zen//stable"
      "flathub:app/org.mozilla.firefox//stable"
      "flathub:app/org.chromium.Chromium//stable"
      "flathub:app/org.videolan.VLC//stable"
      "flathub:app/io.mpv.Mpv//stable"
      "flathub:app/com.visualstudio.code//stable"
      "flathub:app/com.obsproject.Studio//stable"
    ];
    onCalendar = "weekly";
  };
}
