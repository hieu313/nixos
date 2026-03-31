{
  lib,
  hostName,
  ...
}:
{
  services.flatpak = {
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
      "flathub:app/one.ablaze.floorp//stable"
    ];
    onCalendar = "weekly";
  };
  programs.zsh.shellAliases = {
    mpv = "flatpak run io.mpv.Mpv";
    zen = "app.zen_browser.zen";
    firefox = "org.mozilla.firefox";
    chrome = "org.chromium.Chromium";
    vlc = "org.videolan.VLC";
    vscode = "com.visualstudio.code";
    obs = "com.obsproject.Studio";
    floorp = "one.ablaze.floorp";
  };
}