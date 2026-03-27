let
  prometheus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGtgGS1yIgGGrH2WFuuqmBRGZ8v7wec15bOK5Nygizl hieunm@prometheus";
  erebos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIs1OcvnBVh9gb+beeBZwNWfnQTBHwFXk0WePYX9Z2Kc hieunm@erebos";
  void = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAsDNzlcgZCCLp8lD3lfXJ7meW8j5mnxlI1uBQ63V/J6 hieunm@void";
  v-gaia-main = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDfwt9c7HbYBwgwGrEZBXDjvvajvAz4ubOEdpWobFntB hieunm@v-gaia-main";
  null = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKf4hUmWlIiN8/+rLyZEqqhhBKNS08dEFGL6ix47Fjko hieunm@null";
  systems = [ prometheus erebos void ];
  workstations = [ prometheus erebos ];
in
{
  "test.age".publicKeys = systems;
  "matrix.env".publicKeys = systems;
  "tuwunel-token.age".publicKeys = systems;
  "hieunm.age".publicKeys = workstations;
  # borg secrets
  "borg.prometheus.age".publicKeys = [ prometheus ];
  "borg.erebos.age".publicKeys = workstations;
  "borg.void.age".publicKeys = [ prometheus void ];
  "borg.v-gaia-main.age".publicKeys = workstations ++ [ v-gaia-main ];
  #v-gaia-main secrets
  "newt.env.age".publicKeys = workstations ++ [ v-gaia-main ];
  "kavita.tokenkey.age".publicKeys = workstations ++ [ v-gaia-main ];
  "forgejo_dbPass.age".publicKeys = workstations ++ [ v-gaia-main ];
  #etc
  "wg0.age".publicKeys = workstations ++ [ null ];
}
