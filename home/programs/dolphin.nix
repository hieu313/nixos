{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:
{
	home.packages = with pkgs; [
		kdePackages.dolphin
		kdePackages.dolphin-plugins
		kdePackages.kio-extras
		kdePackages.kimageformats
		kdePackages.ffmpegthumbs
	];

  xdg.configFile."dolphinrc" = {
    text = ''
      [CompactMode]
      IconSize=22

      [ContextMenu]
      ShowCopyMoveMenu=true

      [DetailsMode]
      IconSize=22
      PreviewSize=16

      [ExtractDialog]
      1920x1080 screen: Window-Maximized=true
      2 screens: Window-Maximized=true

      [General]
      ConfirmClosingMultipleTabs=false
      RememberOpenedTabs=false
      ShowSelectionToggle=false
      ShowStatusBar=false
      Version=202
      ViewPropsTimestamp=2023,4,26,16,58,48.324

      [IconsMode]
      MaximumTextLines=1
      PreviewSize=112

      [InformationPanel]
      dateFormat=ShortFormat

      [KFileDialog Settings]
      Places Icons Auto-resize=false
      Places Icons Static Size=16

      [KPropertiesDialog]
      2560x1080 screen: Window-Maximized=true

      [MainWindow]
      MenuBar=Disabled

      [MainWindow][Toolbar mainToolBar]
      IconSize=16
      ToolButtonStyle=IconOnly

      [PlacesPanel]
      IconSize=16

      [PreviewSettings]
      Plugins=appimagethumbnail,audiothumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,heif,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,opendocumentthumbnail,svgthumbnail

      [Toolbar mainToolBar]
      ToolButtonStyle=IconOnly

      [$Version]
      update_info=dolphin_detailsmodesettings.upd:rename-leading-padding
    '';

    force = true;
  };
}
