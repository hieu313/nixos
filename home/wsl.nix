{
  imports = [
    ./core.nix
    ./tui-packages.nix
    ./programs/zsh.nix
  ];

  devStacks.node.enable = true;
}
