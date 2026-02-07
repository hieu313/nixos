let
  prometheus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGtgGS1yIgGGrH2WFuuqmBRGZ8v7wec15bOK5Nygizl gumbo@prometheus";
  erebos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIs1OcvnBVh9gb+beeBZwNWfnQTBHwFXk0WePYX9Z2Kc gumbo@erebos";
  systems = [ prometheus erebos ];
in
{
  "test.age".publicKeys = systems;
}
