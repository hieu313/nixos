# My NixOS configurations v3

This is a pretty significant overhaul of the structure the repo used previously, and should allow for more flexibility and easier modification. About 20 directories and 40 files were removed.

The flake builds no longer depend on hostname-profile (e.g. `erebos-niri`, `prometheus-hypr`, etc) and are now only `.#hostname`. I've converted the "profiles" I used before into modules which can be enabled or disabled as needed. At the time of writing, the Home Manager file for the respective environment will need to be uncommented in `flake.nix`. Make sure you comment or remove any conflicting files from other environments.

I've removed the structure of the server layout from this repo. This is still planned and being tracked in a staging branch through my local forge. Until those are fully configured, it doesn't make sense to have the structure here.

Though I've learned a lot about NixOS since I started daily driving it in 2025, this configuration should still be used with caution. It's advised that you review all files for anything that may conflict with what you are looking for out of your build. You may need to adjust occurrences of things specific to my environment, like hostnames, usernames, filesystem mounts, etc. Part of the reason I broke things up into modules is to make that process easier.

## Repo structure

- `/config`: software configuration files (ghostty, fastfetch, niri binds, etc). Pretty much all of these are managed through Home Manager and deployed to `~/.config`.
- `/devices`: broken into `/desktop` and `/laptop`. This is where device-specific configurations and modules are imported and set, as well as the home for `hardware-configuration.nix`. If you're cloning this repo, don't forget to replace this file with your own.
- `/home`: Home Manager configurations for my baseline (`common.nix`), DE/WM-specific configurations, etc.
- `/modules`: this is where the vast majority of the restructuring was done. Review and adjust as needed. Many things are specific to my environment. Overall, the move to modules should make this repo much more flexible for both myself and anyone else who may want to use it.
- `/pics`: profile pictures and eventually screenshots to include in the README.

## Important things to note

- My machines run on the **unstable** branch, use the **latest kernel**, and **allow unfree software**. Garbage collection removes all generations older than 7 days.
- `/modules/baseline.nix` is exactly what it sounds like: a baseline. The majority of packages, services, kernel and boot parameters, and other core settings are defined here. You should be reviewing this file. The baseline is enabled with: ```workstation.baseline.enable = true;```
- All builds use **zsh** by default. I have separate **zsh** and **bash** Home Manager files, you can switch the shell to say bash by modifying the shell file Home Manager imports under either machines entry in ```flake.nix```.
- I use **Niri** almost exclusively. The Niri module uses **Noctalia Shell**. If you don't want to use Noctalia, remove it's input in `flake.nix` and remove the package from Niri's module. If you're using my Niri config from `/config/niri`, remove ```spawn-at-startup "noctalia-shell"``` from the file. The Niri module will be up to date more often than the others. GNOME and XFCE modules should be stable and usable.
- Hyprland currently lags behind upstream. Breaking changes were made to window-rule syntax in version 0.53, and I have not yet made adjustments to accommodate this.
- KDE is mostly broken. Wayland does not work, and while switching to X11 in SDDM will get you to a desktop, some applications do not open. I'll fix it eventually, but don't use KDE for now. If you would like to submit a PR to fix it, I will review and merge if everything looks good.
- Display managers change depending on what environment you choose:
  - Desktop environments use their defaults (GNOME = GDM, KDE = SDDM, XFCE = LightDM)
  - Window managers use `tuigreet` with autologin
- The **SteamOS** build is **not** a functional configuration. This was an experiment to create a SteamOS-like environment that boots directly into Gamescope, aiming for a more console-like experience with support for things like Netflix or YouTube as non-Steam games. It does boot into Gamescope with Steam in Big Picture mode (after a delay), but playing games or streaming them from another device does not work.
- No, this repo is not 100 MB. Wallpapers used to live here and were removed. The blobs should also be removed from `.git`. ```du -hs``` reports **8.7 MB** at the time of writing.

## Current valid build commands (from root of repo)

```sudo nixos-rebuild boot --flake .#prometheus``` (laptop build)

```sudo nixos-rebuild boot --flake .#erebos``` (desktop/gaming build)

Please consider sponsoring NixOS to support the people that have brought us this amazing software https://github.com/sponsors/NixOS