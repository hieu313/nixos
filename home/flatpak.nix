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
      "flathub:app/app.zen_browser.zen/x86_64/stable"
      "flathub:app/org.videolan.VLC/x86_64/stable"
      "flathub:app/com.visualstudio.code/x86_64/stable"
      "flathub:app/one.ablaze.floorp/x86_64/stable"
    ];

    overrides = {
      global.Context.filesystems = [ "xdg-download" ];
      "app.zen_browser.zen".Context.filesystems = "xdg-download:rw;xdg-documents:rw";
      "one.ablaze.floorp".Context.filesystems = "xdg-download:rw;xdg-documents:rw";
    };

    onCalendar = "weekly";
  };

  programs.zsh.shellAliases = {
    zen = "flatpak run app.zen_browser.zen";
    vlc = "flatpak run org.videolan.VLC";
    vscode = "flatpak run com.visualstudio.code";
    floorp = "flatpak run one.ablaze.floorp";
  };
	# Add wine to the PATH
	home.file.".local/bin/wine" = {
		executable = true;
		text = ''
			#!/bin/sh
			exec flatpak run \
				--branch=stable-25.08 \
				--env=WINEPREFIX=/home/hieunm/WindowsApps \
				--filesystem=/home/hieunm/WindowsApps \
				--command=wine \
				org.winehq.Wine "$@"
		'';
	};
}