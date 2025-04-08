# Rugu's Nix Config

This repository contains my personal configuration files for my NixOS setups.
Before switching to NixOS, I used a conventional
[dotfiles](https://github.com/kugurerdem/dotfiles) repository. Now, the files
in this repository fully replace that old setup.

# Setup Instructions

First, clone this repo.

```
git clone https://github.com/kugurerdem/nix-config rugu-nix-config
```

Change directory into it.

```
cd rugu-nix-config
```

First let us link the system configuration files, and then rebuild the system.

```
ln -fs "$PWD/system/configuration.nix" "/etc/nixos/configuration.nix"
sudo nixos-rebuild switch
```

Then, in order to configure home, install `home-manager`:

```
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --update
```

Now, create home.nix file;

```
cp /home-manager/home-example.nix home.nix
```

Configure it. And then, link the home-manager configs.

```
mkdir -p .config/home-manager
ln -s "$PWD/home-manager/home.nix" "$HOME/.config/home-manager/home.nix"
```

And finally, run:

```
home-manager switch
```
