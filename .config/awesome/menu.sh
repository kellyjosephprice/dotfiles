#!/bin/bash
####
#
# awesome-menu-builder - Simple shell script to build menus for 
# awesome-menu.
#
# Concept from http://www.calmar.ws/tmp/dmenu_do
#
####

# build your menu here with whatever simple names you want to use
MENU="urxvtc
chromium
sunflower
libreoffice
gimp
vim
logout
"
# display the menu and yank the choice made
CHOICE=$(awesome-menu <<< "${MENU}" "Run: ")
# parse the choice
case ${CHOICE%% *} in
    # you only need to put lines here for what you want to run
    # differently than the rest
    logout)
        awesome-client <<< "0 quit"
    ;;
    vim)
        awesome-client <<< "0 spawn urxvtc -e ${CHOICE}'"
    ;;
    *)
       awesome-client <<< "0 spawn ${CHOICE}"
    ;;
esac
