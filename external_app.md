# External App
Those packages which I don't want to setup by nix (which is quite annoying), so I install them manually.

IF YOU INSTALL .DEB APP manually, please run `nix-alien` first to save which deps to use in this app

## Coccoc Browser
1. Visit [coccoc official website](https://coccoc.com/download)
2. Download the latest version .deb file
3. Install it manually
```sh
sudo mkdir -p /opt/coccoc-deb
cd /opt/coccoc-deb
sudo ar x /path/to/file.deb
sudo tar -xf data.tar.*
nix run github:thiagokokada/nix-alien -- /opt/coccoc-deb/opt/coccoc/browser/browser
```
	- While installing, it will ask you to select some packages, just select anything you want.
4. You can add alias for the browser by adding the following to your `~/.config/zsh/keys.zsh` or `~/.config/zsh/aliases.zsh` file:
```sh
alias coccoc="nix run github:thiagokokada/nix-alien -- /opt/coccoc-deb/opt/coccoc/browser/browser"
```
5. Desktop file
```sh
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/coccoc.desktop << EOF
[Desktop Entry]
Name=Coccoc Browser
Exec=nix-alien -- /opt/coccoc-deb/opt/coccoc/browser/browser
Icon=/opt/coccoc-deb/opt/coccoc/browser/product_logo_128.png
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
sudo mkdir -p /opt/proxypal-deb
cd /opt/proxypal-deb
sudo ar x /path/to/file.deb
sudo tar -xf data.tar.*
nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /opt/proxypal-deb/usr/bin/proxypal
```
	- While installing, it will ask you to select some packages, just select anything you want.
4. You can add alias for the browser by adding the following to your `~/.config/zsh/keys.zsh` or `~/.config/zsh/aliases.zsh` file:
```sh
alias coccoc="nix run github:thiagokokada/nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /opt/proxypal-deb/usr/bin/proxypal"
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
Exec=nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /opt/proxypal-deb/usr/bin/proxypal
Icon=/opt/proxypal-deb/usr/share/icons/hicolor/128x128/apps/proxypal.png
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
sudo mkdir -p /opt/iloader-deb
cd /opt/iloader-deb
sudo ar x /path/to/file.deb
sudo tar -xf data.tar.*
nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /opt/iloader-deb/usr/bin/iloader
```
	- While installing, it will ask you to select some packages, just select anything you want.
4. You can add alias for the browser by adding the following to your `~/.config/zsh/keys.zsh` or `~/.config/zsh/aliases.zsh` file:
```sh
alias coccoc="nix run github:thiagokokada/nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /opt/iloader-deb/usr/bin/iloader"
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
Exec=nix-alien -l libayatana-appindicator3.so.1 -l libappindicator3.so.1 -- /opt/iloader-deb/usr/bin/iloader
Icon=/opt/iloader-deb/usr/share/icons/hicolor/256x256@2/apps/iloader.png
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

## Plant vs Zombie Fusion (Multi-lang)
### 1. Wine wrapper

In this setup, `wine` is not a native system Wine binary. It is a shell function that runs Wine through Flatpak:

```zsh
function wine() {
	WINEPREFIX="$HOME/WindowsApps" flatpak run \
		--branch=stable-25.08 \
		--env=WINEPREFIX="$HOME/WindowsApps" \
		--filesystem="$HOME/WindowsApps" \
		--command=wine \
		org.winehq.Wine \
		"$@"
}
```
- Explanation: 
  - WINEPREFIX="$HOME/WindowsApps" stores the Windows/Wine environment, including installed runtimes and registry settings.
  - --filesystem="$HOME/WindowsApps" allows the Flatpak Wine sandbox to read and run files from this directory.
  - It is recommended to keep games under $HOME/WindowsApps, for example: $HOME/WindowsApps/Game

### 2. Download and extract the game
- Download the multi-language PC release from: https://github.com/Teyliu/PVZF-Translation/releases
- Create a folder for the game:
```bash
mkdir -p "$HOME/WindowsApps/Game/PVZF-Translation"
unzip "/path/to/download.zip" -d "$HOME/WindowsApps/Game/PVZF-Translation"
```
- To play game, run:
```bash
cd $HOME/WindowsApps/PVZF-Translation/"Game Files"
WINEDLLOVERRIDES="version=n,b" wine PlantsVsZombiesRH.exe
```
### 3. (Optional) Install .NET 6 to run ModUpdateUtil.exe
- ModUpdateUtil.exe requires .NET 6 Desktop Runtime inside the Wine prefix.
- Install it with Flatpak Wine's winetricks:
```bash
WINEPREFIX="$HOME/WindowsApps" flatpak run \
	--branch=stable-25.08 \
	--env=WINEPREFIX="$HOME/WindowsApps" \
	--filesystem="$HOME/WindowsApps" \
	--command=winetricks \
	org.winehq.Wine dotnetdesktop6
```
- Optional check:
```bash
WINEPREFIX="$HOME/WindowsApps" flatpak run \
	--branch=stable-25.08 \
	--env=WINEPREFIX="$HOME/WindowsApps" \
	--filesystem="$HOME/WindowsApps" \
	--command=wine \
	org.winehq.Wine "C:\\Program Files\\dotnet\\dotnet.exe" --list-runtimes
```
- You should see something like: `Microsoft.WindowsDesktop.App 6.0.36`
#### Desktop file
```bash
mkdir -p "$HOME/.local/share/applications"

cat > "$HOME/.local/share/applications/pvz-fusion-multilang.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Plants vs. Zombies Fusion Multi-lang
Comment=Launch PvZ Fusion 3.6.1 Multi-language
Exec=env WINEPREFIX=$HOME/WindowsApps WINEDLLOVERRIDES=version=n,b flatpak run --branch=stable-25.08 --env=WINEPREFIX=$HOME/WindowsApps --env=WINEDLLOVERRIDES=version=n,b --filesystem=$HOME/WindowsApps --command=wine org.winehq.Wine "$HOME/WindowsApps/Game/PVZF-Translation/Game Files/PlantsVsZombiesRH.exe"
Path=$HOME/WindowsApps/Game/PVZF-Translation/Game Files
Terminal=false
Categories=Game;
StartupNotify=true
EOF


chmod +x "$HOME/.local/share/applications/pvz-fusion-multilang.desktop"
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
```