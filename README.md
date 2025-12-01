My NixOS journey. While of course you can clone, swap out hardware files, paths and boot from some of the profiles, I would not recommend it. If you plan to clone, you should read through the configurations of the profiles you plan to build from and make sure everything is correct for your system.

The purpose of this repository is to provide a public repo of how my NixOS systems evolve over time, and maybe some examples for different configurations. I am not a Nix expert, I'm sure there are better ways to do what I'm doing.

That being said, the following profiles (environments) are functional

- Niri
- Hyprland
- XFCE (known to be buggy on VM's, disable XFCE compositor, change Picom backend to xrender should fix it)

Servers are not yet online, that project is being tracked in my local Forge and is expected to be completed in March of 2026. Profiles for GNOME and KDE Plasma are not expected until mid 2026 as I just don't use them.
