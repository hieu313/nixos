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
      "flathub:app/org.videolan.VLC//stable"
      "flathub:app/com.visualstudio.code//stable"
      "flathub:app/one.ablaze.floorp//stable"
    ];
    overrides = {
      global.Context.filesystems = "xdg-download";

      "app.zen_browser.zen".Context.filesystems = "xdg-download:rw;xdg-documents:rw";
      "org.mozilla.firefox".Context.filesystems   = "xdg-download:rw;xdg-documents:rw";
      "one.ablaze.floorp".Context.filesystems     = "xdg-download:rw;xdg-documents:rw";
    };
    onCalendar = "weekly";
  };
  programs.zsh.shellAliases = {
    zen     = "flatpak run app.zen_browser.zen";
    firefox = "flatpak run org.mozilla.firefox";
    vlc     = "flatpak run org.videolan.VLC";
    vscode  = "flatpak run com.visualstudio.code";
    floorp  = "flatpak run one.ablaze.floorp";
  };
}
