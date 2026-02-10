{ config, 
... 
}:
{
  age.secrets.matrix-env = {
    file = ../../../secrets/matrix.env;
    path = "/run/agenix/matrix.env";
    owner = "gumbo";
    group = "users";
    mode = "0400";
  };
}
