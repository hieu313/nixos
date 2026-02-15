locals {
  ipv4 = "192.0.2.1"
}

module "deploy" {
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.mymachine.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.mymachine.config.system.build.diskoScript"
  target_host            = local.ipv4
  instance_id            = local.ipv4
  debug_logging          = true
  build_on_remote        = true
  extra_files_script     = "${path.module}/decrypt-ssh-secrets.sh"
  disk_encryption_key_scripts = [{
    path   = "/tmp/secret.key"
    script = "${path.module}/decrypt-zfs-key.sh"
  }]
}
