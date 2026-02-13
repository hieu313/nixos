let
  prometheus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGtgGS1yIgGGrH2WFuuqmBRGZ8v7wec15bOK5Nygizl gumbo@prometheus";
  erebos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIs1OcvnBVh9gb+beeBZwNWfnQTBHwFXk0WePYX9Z2Kc gumbo@erebos";
  void = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAsDNzlcgZCCLp8lD3lfXJ7meW8j5mnxlI1uBQ63V/J6 gumbo@void";
  systems = [ prometheus erebos void ];
  workstations = [ prometheus erebos ];
in
{
  "test.age".publicKeys = systems;
  "matrix.env".publicKeys = systems;
  "gumbo.age".publicKeys = workstations;
  "borg.prometheus.age".publicKeys = [ prometheus ];
  "borg.erebos.age".publicKeys = workstations;
}
