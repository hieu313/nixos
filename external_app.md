# External App
Those packages which I don't want to setup by nix (which is quite annoying), so I install them manually.

IF YOU INSTALL .DEB APP manually, please run `nix-alien` first to save which deps to use in this app

## Coccoc Browser
1. Visit [coccoc official website](https://coccoc.com/download)
2. Download the latest version .deb file
3. Install it manually
```sh
mkdir -p /tmp/coccoc-deb
cd /tmp/coccoc-deb
ar x /path/to/file.deb
tar -xf data.tar.*
nix run github:thiagokokada/nix-alien -- /tmp/coccoc-deb/opt/coccoc/browser/browser
```
	- While installing, it will ask you to select some packages, just select anything you want.
4. You can add alias for the browser by adding the following to your `~/.config/zsh/keys.zsh` or `~/.config/zsh/aliases.zsh` file:
```sh
alias coccoc="nix run github:thiagokokada/nix-alien -- /tmp/coccoc-deb/opt/coccoc/browser/browser"
```
5. Desktop file
```sh
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/coccoc.desktop << EOF
[Desktop Entry]
Name=Coccoc Browser
Exec=nix-alien -- /tmp/coccoc-deb/opt/coccoc/browser/browser
Icon=/tmp/coccoc-deb/opt/coccoc/browser/product_logo_128.png
Type=Application
Categories=Browser;
StartupWMClass=Coccoc Browser
Terminal=false
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;x-scheme-handler/chrome-extension;
EOF
```

## Proxypal
1. Visit [github release](https://github.com/heyhuynhgiabuu/proxypal/releases)
2. Download the latest version .deb file
3. Install it manually
```sh
mkdir -p /tmp/proxypal-deb
cd /tmp/proxypal-deb
ar x /path/to/file.deb
tar -xf data.tar.*
nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /tmp/proxypal-deb/usr/bin/proxypal
```
	- While installing, it will ask you to select some packages, just select anything you want.
4. You can add alias for the browser by adding the following to your `~/.config/zsh/keys.zsh` or `~/.config/zsh/aliases.zsh` file:
```sh
alias coccoc="nix run github:thiagokokada/nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /tmp/proxypal-deb/usr/bin/proxypal"
```
5. Desktop file
```sh
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/proxypal.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=ProxyPal
Comment=Use your AI subscriptions everywhere
Exec=nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /tmp/proxypal-deb/usr/bin/proxypal
Icon=/tmp/proxypal-deb/usr/share/icons/hicolor/128x128/apps/proxypal.png
Categories=Development;Utility;
StartupWMClass=ProxyPal
Terminal=false
MimeType=x-scheme-handler/proxypal;
EOF
chmod +x ~/.local/share/applications/proxypal.desktop
update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

## Iloader (SideStore)
1. Visit [iloader official website](https://iloader.app/)
2. Install file .deb
3. Install it manually
```sh
mkdir -p /tmp/iloader-deb
cd /tmp/iloader-deb
ar x /path/to/file.deb
tar -xf data.tar.*
nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /tmp/iloader-deb/usr/bin/iloader
```
	- While installing, it will ask you to select some packages, just select anything you want.
4. You can add alias for the browser by adding the following to your `~/.config/zsh/keys.zsh` or `~/.config/zsh/aliases.zsh` file:
```sh
alias coccoc="nix run github:thiagokokada/nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /tmp/iloader-deb/usr/bin/iloader"
```
5. Desktop file
```sh
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/iloader.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=iloader
GenericName=iOS Sideloading Tool
Comment=Free and open-source iOS sideloading companion
Exec=nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /tmp/iloader-deb/usr/bin/iloader
Icon=/tmp/iloader-deb/usr/share/icons/hicolor/256x256@2/apps/iloader.png
Categories=Utility;Development;
Keywords=iOS;iPhone;iPad;sideloader;sideloading;SideStore;AltStore;IPA;
StartupWMClass=iloader
Terminal=false
StartupNotify=true
EOF
chmod +x ~/.local/share/applications/iloader.desktop
update-desktop-database ~/.local/share/applications 2>/dev/null || true
```



## Wine
1. Install it manually by flatpak
```sh
flatpak install org.winehq.Wine
```
  - Then select 2 (user) and select the version you want to install (recommended is wow64-25.08).

## Gridex
1. Download from [Gridex](https://github.com/gridex/gridex)
2. Run the following command to run the appimage:
```sh
QT_QPA_PLATFORM=xcb XDG_SESSION_TYPE=x11 appimage-run Gridex-latest-x86_64.AppImage
```
3. Desktop file
```sh
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons/hicolor/512x512/apps
cat > ~/.local/share/applications/gridex.desktop << EOF
[Desktop Entry]
Name=Gridex
Description=AI-native database IDE
Exec=QT_QPA_PLATFORM=xcb XDG_SESSION_TYPE=x11 appimage-run Gridex-latest-x86_64.AppImage
Icon=gridex
Type=Application
Categories=Development;
StartupWMClass=Gridex
EOF
```