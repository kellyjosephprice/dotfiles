{ config, ... }:

{
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
    extraConfig = {
      XDG_PROJECTS_DIR = "${home}/wsp";
      XDG_WORK_DIR = "${home}/git";
    };
  };
}
