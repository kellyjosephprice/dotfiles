# dotfiles

NixOS system config + home-manager, as a single flake.

This repo used to be a bare git-dir checked out against `$HOME` on Regolith
Linux (see git history before the `nixos-migration` merge for that setup).
It's now a normal work-tree, and doubles as the flake for the machine it
lives on.

## Layout

```
flake.nix                    # pins nixpkgs + home-manager, defines ayocote and kidney
hosts/common.nix             # system settings every machine shares
hosts/ayocote/               # dev machine
hosts/kidney/                # always-on ThinkPad; services.nix supports ~/git/prunez-estate
home/home.nix                # home-manager settings every machine shares
home/hosts/                  # apps only one machine gets
home/modules/shell.nix       # zsh, starship, fzf, ssh-agent
home/modules/git.nix         # programs.git
home/modules/tmux.nix        # programs.tmux
home/modules/kitty.nix       # programs.kitty
home/modules/neovim.nix      # programs.neovim + plugins
.config/nvim/                # plain files referenced by home/modules/neovim.nix (coc-settings.json, ftplugin)
.config/regolith/i3/config   # dormant - kept from the old Regolith setup, not wired into anything while on GNOME
```

## Setup

```
git clone git@github.com:kellyjosephprice/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
sudo nixos-rebuild switch --flake .
```

The flake picks the config matching the machine's hostname. That one command activates both the system config and home-manager - there's
no separate `home-manager switch` step.

## Making changes

Edit the relevant file under `home/` or `hosts/`, then:

```
cd ~/git/dotfiles
nix flake check --no-build   # fast sanity check
nixos-rebuild build --flake .   # build without activating, no sudo needed
sudo nixos-rebuild switch --flake .   # activate
```

`nixos-rebuild switch --rollback` gets back to the previous generation if a
switch goes wrong.
