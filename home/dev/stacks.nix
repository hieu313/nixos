{ lib, ... }:

{
  options.devStacks = {
    node.enable = lib.mkEnableOption "Node development tools";
    php.enable = lib.mkEnableOption "PHP development tools";
    java = {
      enable = lib.mkEnableOption "Java development tools";
      defaultVersion = lib.mkOption {
        type = lib.types.enum [ 17 25 ];
        default = 25;
        description = "Default JDK version for Java development tools.";
      };
      extraVersions = lib.mkOption {
        type = lib.types.listOf (lib.types.enum [ 17 25 ]);
        default = [ 17 25 ];
        description = "Additional JDK versions exposed for IDE discovery.";
      };
    };
  };
}
