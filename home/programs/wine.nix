{ pkgs, lib, ... }:
# NOTE: i use this to run classin, but it's working
# You should mount your windows (dual boot) to /mnt: sudo mount /dev/... /mnt
# then copy the WinSCard.dll to your WindowsApps directory:
# cp /mnt/Windows/System32/WinSCard.dll ~/WindowsApps/drive_c/windows/system32/winscard.dll
# cp /mnt/Windows/SysWOW64/WinSCard.dll ~/WindowsApps/drive_c/windows/syswow64/winscard.dll
{
  home.packages = with pkgs; [
    wineWow64Packages.stagingFull
    winetricks
  ];

  home.sessionVariables = {
    WINEDEBUG = "-all";
    WINEPREFIX = "$HOME/WindowsApps";
  };
}