# Apps only the dev machine gets.
{ pkgs, ... }:

{
  imports = [ ../home.nix ];

  home.packages = [
    pkgs.appimage-run
    pkgs.discord
    pkgs.dotnet-sdk
    pkgs.gimp
    pkgs.google-antigravity-cli
    pkgs.hashlink
    pkgs.haxe
    pkgs.opencode
    pkgs.prusa-slicer
    pkgs.steam
    pkgs.ucblogo
    pkgs.wesnoth
  ];
}
