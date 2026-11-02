# Apps only this always-on laptop gets. Kept lean on purpose.
{ pkgs, ... }:

{
  imports = [ ../home.nix ];

  home.packages = [
    pkgs.htop
    pkgs.proton-pass
  ];
}
