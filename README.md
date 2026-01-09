My NixOS journey. Use with caution. If you plan to clone, you should read through the configurations of the profile you plan to build from and make sure everything is correct for your system.

The purpose of this repository is to provide a public repo of how my NixOS systems evolve over time, and maybe some examples for different configurations. I am not a Nix expert, I'm sure there are better ways to do what I'm doing.

That being said, here are the following profiles (environments) I'm building / have built:

- Niri: Fully functional, uses Noctalia Shell
- Hyprland: Functional (haven't tested/updated window rules for 0.53 changes)
- XFCE: Functional, disable XFCE's compositor and Picom take over. Haven't figured out how to declare this yet
- KDE Plasma: Broken, I rarely use KDE. Still working on full functionality
- SteamOS: Broken, I've been testing a custom "SteamOS" build that boots directly into gamescope with Steam in big picture mode. Doesn't work too well yet, will likely have to do a complete overhaul
- GNOME: Non-existent, I don't use GNOME. I'll get it functional at some point, but just use Niri if you want the best tiling experience 

Servers are not yet online, that project is being tracked in my local Forge and is expected to be completed in March of 2026. Eventually I'll overhaul the structure of this repo and turn the "profiles" into modules but don't have time for that rn