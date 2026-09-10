# dotfiles

NixOS system config + home-manager, as a single flake.

This repo used to be a bare git-dir checked out against `$HOME` on Regolith
Linux (see git history before the `nixos-migration` merge for that setup).
It's now a normal work-tree, and doubles as the flake for the machine it
lives on.

## Layout

```
flake.nix                    # pins nixpkgs + home-manager, defines nixosConfigurations.nixos
hosts/nixos/configuration.nix       # system config (flakes enabled, home-manager wired in as a module)
hosts/nixos/hardware-configuration.nix
home/home.nix                # home-manager entrypoint
home/modules/shell.nix       # zsh, starship, fzf, ssh-agent
home/modules/git.nix         # programs.git
home/modules/tmux.nix        # programs.tmux
home/modules/kitty.nix       # programs.kitty
home/modules/neovim.nix      # programs.neovim + plugins
.config/nvim/                # plain files referenced by home/modules/neovim.nix (coc-settings.json, ftplugin)
.config/regolith/i3/config   # dormant - kept from the old Regolith setup, not wired into anything while on GNOME
dev/docker-compose.yml       # local dev services (mongo, redis) for other projects, unrelated to the system config
```

## Setup

```
git clone git@github.com:kellyjosephprice/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
sudo nixos-rebuild switch --flake .#nixos
```

That one command activates both the system config and home-manager - there's
no separate `home-manager switch` step.

## Making changes

Edit the relevant file under `home/` or `hosts/nixos/`, then:

```
cd ~/git/dotfiles
nix flake check --no-build   # fast sanity check
nixos-rebuild build --flake .#nixos   # build without activating, no sudo needed
sudo nixos-rebuild switch --flake .#nixos   # activate
```

`nixos-rebuild switch --rollback` gets back to the previous generation if a
switch goes wrong.
