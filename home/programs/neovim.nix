{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."nvim" = {
    source = lib.cleanSourceWith {
      src = ../../config/nvim;
      filter = path: type:
				! builtins.elem (builtins.baseNameOf path) [
					"lazy-lock.json"
				];
    };
    recursive = true;
  };
  home.sessionVariables.EDITOR = "nvim";
}