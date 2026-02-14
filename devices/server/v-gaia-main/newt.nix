{
  config,
  pkgs,
  lib,
  ...
}:
{

  services.newt = {
    enable = true;
    environmentFile = "/run/agenix/newt.env.age";
  };

  age.secrets."newt.env.age" = {
    file = ../../../secrets/newt.env.age;
    path = "/run/agenix/newt.env.age";
    owner = "gumbo";
    group = "users";
    mode = "0400";
  };

}
