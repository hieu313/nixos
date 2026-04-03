{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:
{
	home.packages = with pkgs; [
		nemo
		nemo-fileroller
		file-roller
	];

	home.file.".local/share/nemo/extensions-3.0/libnemo-fileroller.so".source =
    "${pkgs.nemo-fileroller}/lib/nemo/extensions-3.0/libnemo-fileroller.so";
}
