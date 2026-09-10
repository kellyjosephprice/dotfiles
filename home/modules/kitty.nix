{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark";

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
    };
  };
}
