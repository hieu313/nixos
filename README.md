My NixOS journey. Use with caution. If you plan to clone, you should read through the configurations of the profile you plan to build from and make sure everything is correct for your system.

The purpose of this repository is to provide a public repo of how my NixOS systems evolve over time, and maybe some examples for different configurations. I am not a Nix expert, I'm sure there are better ways to do what I'm doing.

That being said, here are the following profiles (environments) I'm building / have built:

    - Niri: Fully functional, uses Noctalia Shell. My live config files for both are not being managed for both despite the files being in /config, my live files are mostly the same I've just been lazy and haven't implemented mkOutOfStoreSymLink for these yet. They are mostly up to date

    - Hyprland: Functional (haven't tested/updated window rules for 0.53 changes). Boot into another environment like niri to adjust window rules if needed.

    - XFCE: Functional, disable XFCE's compositor and Picom take over. Haven't figured out how to declare this yet

    - GNOME: Functional, check /profiles/gnome/system.nix for the GNOME specific configuration and tweak what you would like. GNOME stock apps are disabled and some of my favorite extensions are included. I'll make it more declarative in the future.

    - KDE Plasma: Broken, I rarely use KDE. Still working on full functionality

    - SteamOS: Broken, I've been testing a custom "SteamOS" build that boots directly into gamescope with Steam in big picture mode. Doesn't work too well yet, will likely have to do a complete overhaul

How to use: I have built "host files" for each host and environment. This allows me to switch to a different environment based on hostname-profile (where profile is the environment). For example on my desktop with the hostname of erebos, to build into a niri environment, you would do sudo nixos-rebuild boot --flake .#erebos-niri (given that you're in the root of the repo), then reboot (I use the "boot" switch instead of "switch" as trying to rebuild into a system from a tty or different DE/WM is not clean). You can check the flake for exact names and modify them how you like if you're copying this repo. Please note that there are a lot of instances of using hostnames within different configs and files here, as hostnames for me are static. This build also expects that the user will always be gumbo, this comes into play especially with home manager. If you are using a different user in your configuration, you will need to adjust all occurences of the gumbo user in these configs.

Anything named "common.nix" is a shared configuration across my desktop and laptops. Most of the configurations are shared. Any device specific configurations would go in /devices to the respective device, as well as the hardware-configuration.nix which you ***MUST REPLACE***. Profile specific configurations live in /profiles to the respective environment, please note that there are often profile specific home manager configs that are imported into each profile. If it wasn't obvious, those can be found in /home.

The /hosts files are purely for importing configurations. If you're adjusting host names, file names, implementing a new profile, those must be changed in both the respective host file as well as the flake.

Servers are not yet online, that project is being tracked in my local Forge and is expected to be completed in March of 2026. Eventually I'll overhaul the structure of this repo and turn the "profiles" into modules but don't have time for that rn