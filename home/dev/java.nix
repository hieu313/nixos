{ config, lib, pkgs, ... }:
let
  cfg = config.devStacks.java;
  jdkByVersion = {
    "17" = { name = "openjdk-17"; pkg = pkgs.jdk17; };
    "25" = { name = "openjdk-25"; pkg = pkgs.jdk25; };
  };
  selectedDefaultJdk = jdkByVersion.${toString cfg.defaultVersion}.pkg;
  selectedJdks = map (version: jdkByVersion.${toString version}) (
    lib.unique ([ cfg.defaultVersion ] ++ cfg.extraVersions)
  );
in
{
  config = lib.mkIf cfg.enable {
    programs.java = {
      enable = true;
      package = selectedDefaultJdk;
    };
    home.packages = [ pkgs.maven ];
    home.sessionPath = [ "$HOME/.config/Java/jdks" ];
    home.file = builtins.listToAttrs (
      builtins.map (entry: {
        name = ".config/Java/jdks/${entry.name}";
        value.source = entry.pkg;
      }) selectedJdks
    );
  };
}
