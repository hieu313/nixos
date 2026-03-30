{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "custom-fonts";
	dontBuild = true;
  version = "1.0";

  src = ./fonts;

	installPhase = ''
		runHook preInstall
		mkdir -p $out/share/fonts/custom-fonts
		cp -r $src/* $out/share/fonts/custom-fonts/

		runHook postInstall
  '';

	meta = {
		description = "Custom fonts";
		homepage = "https://github.com/Keyitdev/sddm-astronaut-theme/tree/master/Fonts";
		license = lib.licenses.gpl3Only;
		platforms = lib.platforms.linux;
	};
})