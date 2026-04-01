{ appimageTools, fetchurl, lib }:

let
  pname = "cursor-ai";
  version = "2.6";

  src = fetchurl {
    url = "https://api2.cursor.sh/updates/download/golden/linux-x64/cursor/${version}";
    hash = "sha256-rmPXBpIHIp87yF0PDJhqIgvtXOVYT0JXHT66Yynwggg=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/512x512/apps

    cp ${./icon.png} $out/share/icons/hicolor/512x512/apps/cursor-ai.png

    cat > $out/share/applications/cursor-ai.desktop << EOF
[Desktop Entry]
Name=Cursor
Comment=AI Code Editor
Exec=cursor-ai %F
Icon=cursor-ai
Type=Application
Categories=Development;TextEditor;IDE;
MimeType=text/plain;inode/directory;
StartupWMClass=Cursor
Terminal=false
EOF
  '';

  meta = with lib; {
    description = "AI-powered code editor based on VSCode";
    homepage = "https://cursor.sh";
    platforms = [ "x86_64-linux" ];
    license = licenses.unfree;
  };
}