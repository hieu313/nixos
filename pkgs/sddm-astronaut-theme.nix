{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
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
    cp -aR $src/. $out/share/sddm/themes/sddm-astronaut-theme/
    cp ${../config/sddm/metadata.desktop} $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
    runHook postInstall
  '';

  meta = {
    description = "Astronaut theme for SDDM";
    homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})