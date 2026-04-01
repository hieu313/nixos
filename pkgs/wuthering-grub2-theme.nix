{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  theme ? "jinxi",
  screen ? "1080p",
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "wuthering-grub2-theme";
  version = "0-unstable-2025-01-01"; # cập nhật theo commit date thực tế

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "Wuthering-grub2-themes";
    rev = "ed3f8bcd292e7a0684f3c30f20939710d263a321"; # thay bằng commit hash cụ thể
    hash = "sha256-q9TLZTZI/giwKu8sCTluxvkBG5tyan7nFOqn4iGLnkA=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    cp -a common/*.pf2 $out/
    cp -a config/theme-${screen}.txt $out/theme.txt
    cp -a backgrounds/background-${theme}.jpg $out/background.jpg
    cp -a assets/assets-icons/icons-${screen} $out/icons
    cp -a assets/assets-other/other-${screen}/*.png $out/

    runHook postInstall
  '';

  meta = {
    description = "Wuthering Waves grub2 theme (${theme} / ${screen})";
    homepage = "https://github.com/vinceliuice/Wuthering-grub2-themes";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})