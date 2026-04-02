{
  stdenv,
  fetchurl,
  lib,
  makeWrapper,
  libayatana-appindicator,
  gtk3,
  glib,
  webkitgtk_4_1,
}:

let
  pname = "proxypal";
  version = "1.0.0";
in
stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/hieu313/nixos/releases/download/${version}/proxypal-binary-nixos";
    hash = "sha256-kujrgGLrtWn/8VcONHSn1uq0rtQs8QKvOZSeW48PlMg=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/proxypal
    chmod +x $out/bin/proxypal

    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/512x512/apps
    cp ${./icon.png} $out/share/icons/hicolor/512x512/apps/proxypal.png

    cat > $out/share/applications/proxypal.desktop << EOF
[Desktop Entry]
Name=ProxyPal
Exec=proxypal %U
Icon=proxypal
Type=Application
Categories=Network;Utility;Development;
Keywords=proxy;ai;claude;chatgpt;gemini;llm;
StartupWMClass=ProxyPal
Terminal=false
EOF
  '';

  postFixup = ''
    wrapProgram $out/bin/proxypal \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [
        libayatana-appindicator
        gtk3
        glib
        webkitgtk_4_1
      ]}"
  '';

  meta = with lib; {
    description = "AI provider proxy for Claude, ChatGPT, Gemini, Copilot and more";
    homepage = "https://github.com/hieu313/nixos";
    platforms = [ "x86_64-linux" ];
    license = licenses.unfree;
    maintainers = [ ];
  };
}