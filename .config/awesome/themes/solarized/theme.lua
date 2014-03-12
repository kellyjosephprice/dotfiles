---------------------------
-- Default awesome theme --
---------------------------

theme = {}

--theme.font          = "DejaVu Sans 8"
theme.font          = "Ubuntu 10"

theme.bg_normal     = "#002b36" -- base03
theme.bg_focus      = "#073642" -- base02
theme.bg_urgent     = "#073642" -- base02
theme.bg_minimize   = "#073642" -- base02

theme.fg_normal     = "#93a1a1" -- base1
theme.fg_focus      = "#93a1a1" -- base1
theme.fg_urgent     = "#b58900" -- yellow
theme.fg_minimize   = "#6c71c4" -- violet

theme.border_normal = "#586e75" -- base01
theme.border_focus  = "#93a1a1" -- base1
theme.border_marked = "#859900" -- green
theme.border_width  = "2"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/kprice/.config/awesome/themes/solarized/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/kprice/.config/awesome/themes/solarized/taglist/squarew.png"

theme.tasklist_floating_icon = "/home/kprice/.config/awesome/themes/solarized/tasklist/floating.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/kprice/.config/awesome/themes/solarized/submenu.png"
theme.menu_height = "18"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/kprice/.config/awesome/themes/solarized/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/kprice/.config/awesome/themes/solarized/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/kprice/.config/awesome/themes/solarized/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/kprice/.config/awesome/themes/solarized/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/kprice/.config/awesome/themes/solarized/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/kprice/.config/awesome/themes/solarized/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/kprice/.config/awesome/themes/solarized/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/kprice/.config/awesome/themes/solarized/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/kprice/.config/awesome/themes/solarized/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/home/kprice/.config/awesome/themes/solarized/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/kprice/.config/awesome/themes/solarized/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/kprice/.config/awesome/themes/solarized/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/kprice/.config/awesome/themes/solarized/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/kprice/.config/awesome/themes/solarized/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/kprice/.config/awesome/themes/solarized/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/kprice/.config/awesome/themes/solarized/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/kprice/.config/awesome/themes/solarized/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/kprice/.config/awesome/themes/solarized/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/kprice/img/bg.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh =        "/home/kprice/.config/awesome/themes/solarized/layouts/fairh.png"
theme.layout_fairv =        "/home/kprice/.config/awesome/themes/solarized/layouts/fairv.png"
theme.layout_floating  =    "/home/kprice/.config/awesome/themes/solarized/layouts/floating.png"
theme.layout_magnifier =    "/home/kprice/.config/awesome/themes/solarized/layouts/magnifier.png"
theme.layout_max =          "/home/kprice/.config/awesome/themes/solarized/layouts/max.png"
theme.layout_fullscreen =   "/home/kprice/.config/awesome/themes/solarized/layouts/max.png"
theme.layout_tilebottom =   "/home/kprice/.config/awesome/themes/solarized/layouts/tilebottom.png"
theme.layout_tileleft   =   "/home/kprice/.config/awesome/themes/solarized/layouts/tileleft.png"
theme.layout_tile =         "/home/kprice/.config/awesome/themes/solarized/layouts/tile.png"
theme.layout_tiletop =      "/home/kprice/.config/awesome/themes/solarized/layouts/tiletop.png"
theme.layout_spiral  =      "/home/kprice/.config/awesome/themes/solarized/layouts/spiral.png"
theme.layout_dwindle =      "/home/kprice/.config/awesome/themes/solarized/layouts/dwindle.png"

theme.awesome_icon = "/home/kprice/.config/awesome/themes/solarized/start-here-archlinux.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
