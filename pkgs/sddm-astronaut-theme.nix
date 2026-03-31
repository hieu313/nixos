{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
	variant ? "pixel_sakura_static",
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "sddm-astronaut-theme";
  version = "1.0-unstable-2025-12-06";

  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "d73842c761f7d7859f3bdd80e4360f09180fad41";
    sha256 = "sha256-+94WVxOWfVhIEiVNWwnNBRmN+d1kbZCIF10Gjorea9M=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
		cp -r $src/. $out/share/sddm/themes/sddm-astronaut-theme/
		chmod -R u+w $out/share/sddm/themes/sddm-astronaut-theme/
    cat <<EOF > $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
[SddmGreeterTheme]
Name=sddm-astronaut-theme
Description=sddm-astronaut-theme
Author=keyitdev
Website=https://github.com/Keyitdev/sddm-astronaut-theme
License=GPL-3.0-or-later
Type=sddm-theme
Version=1.3
ConfigFile=Themes/${variant}.conf
Screenshot=Previews/astronaut.png
MainScript=Main.qml
TranslationsDirectory=translations
Theme-Id=sddm-astronaut-theme
Theme-API=2.0
QtVersion=6
EOF
    runHook postInstall
  '';

  meta = {
    description = "Astronaut theme for SDDM";
    homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})