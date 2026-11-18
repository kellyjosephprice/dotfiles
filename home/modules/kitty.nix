{ config, lib, pkgs, binder-wave, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.commit-mono;
      name = "CommitMono";
      size = 11.0;
    };

    settings = {
      allow_hyperlinks = "yes";
      bold_font = "CommitMono Bold";
      italic_font = "CommitMono Italic";
      bold_italic_font = "CommitMono Bold Italic";
      hide_window_decorations = "yes";
    };

    extraConfig = builtins.readFile "${binder-wave}/plugins/kitty/binder-wave.conf";
  };
}
