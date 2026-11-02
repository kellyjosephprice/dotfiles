{ config, lib, pkgs, ... }:

{
  programs.chromium = {
    enable = true;

    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };
}
