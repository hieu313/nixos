let
  prometheus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGtgGS1yIgGGrH2WFuuqmBRGZ8v7wec15bOK5Nygizl gumbo@prometheus";
  systems = [ prometheus ];
in
{
  "test.age".publicKeys = systems;
}
