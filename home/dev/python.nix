{ pkgs, ... }:
let
  
in
{
	home.packages = with pkgs; [
		python315
		python3Packages.pyclip
		python3Packages.httpx
		python3Packages.pillow
		python3Packages.curl-cffi
		python3Packages.cloudscraper
		python313Packages.unrpa
	];
}
