{ config, ... }:

{
  xdg.enable = true;

  # GNOME auto-starts xdg-user-dirs-update on every graphical login, which
  # clobbers home-manager's managed (read-only) user-dirs.dirs symlink with
  # its own plain file. Disable that autostart entry via the standard
  # freedesktop override mechanism (a same-named file with Hidden=true).
  xdg.configFile."autostart/xdg-user-dirs.desktop".text = ''
    [Desktop Entry]
    Hidden=true
  '';

  xdg.userDirs = let
    home = config.home.homeDirectory;
  in {
    enable = true;
    createDirectories = true;

    desktop = null;
    download = "${home}/tmp";
    documents = "${home}/doc";
    pictures = "${home}/img";
    music = "${home}/msc";
    publicShare = null;
    templates = null;
    videos = "${home}/vid";
    projects = "${home}/wsp";
  };
}
