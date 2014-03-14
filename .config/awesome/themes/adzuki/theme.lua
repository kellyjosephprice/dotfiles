---------------------------
-- Default awesome theme --
---------------------------

theme = {}
home = os.getenv("HOME")

--theme.font          = "DejaVu Sans 8"
theme.font          = "Ubuntu 9"

theme.bg_normal     = "#525252"
theme.bg_focus      = "#5e6a79"
theme.bg_urgent     = "#f5f5f5"
theme.bg_minimize   = "#525252"

theme.fg_normal     = "#f5f5f5"
theme.fg_focus      = "#f5f5f5"
theme.fg_urgent     = "#525252"
theme.fg_minimize   = "#f5f5f5"

theme.border_width  = "2"
theme.border_normal = "#525252"
theme.border_focus  = "#f5f5f5"
theme.border_marked = "#656565"

-- Display the taglist squares
theme.taglist_squares_sel   = home .. "/.config/awesome/themes/adzuki/taglist/squarefw.png"
theme.taglist_squares_unsel = home .. "/.config/awesome/themes/adzuki/taglist/squarew.png"

theme.tasklist_floating_icon = home .. "/.config/awesome/themes/adzuki/tasklist/floating.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = home .. "/.config/awesome/themes/adzuki/submenu.png"
theme.menu_height = "18"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = home .. "/.config/awesome/themes/adzuki/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = home .. "/.config/awesome/themes/adzuki/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = home .. "/.config/awesome/themes/adzuki/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = home .. "/.config/awesome/themes/adzuki/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = home .. "/.config/awesome/themes/adzuki/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = home .. "/.config/awesome/themes/adzuki/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = home .. "/.config/awesome/themes/adzuki/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = home .. "/.config/awesome/themes/adzuki/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = home .. "/.config/awesome/themes/adzuki/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = home .. "/.config/awesome/themes/adzuki/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = home .. "/.config/awesome/themes/adzuki/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = home .. "/.config/awesome/themes/adzuki/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = home .. "/.config/awesome/themes/adzuki/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = home .. "/.config/awesome/themes/adzuki/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = home .. "/.config/awesome/themes/adzuki/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = home .. "/.config/awesome/themes/adzuki/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = home .. "/.config/awesome/themes/adzuki/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = home .. "/.config/awesome/themes/adzuki/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh =        home .. "/.config/awesome/themes/adzuki/layouts/fairh.png"
theme.layout_fairv =        home .. "/.config/awesome/themes/adzuki/layouts/fairv.png"
theme.layout_floating  =    home .. "/.config/awesome/themes/adzuki/layouts/floating.png"
theme.layout_magnifier =    home .. "/.config/awesome/themes/adzuki/layouts/magnifier.png"
theme.layout_max =          home .. "/.config/awesome/themes/adzuki/layouts/max.png"
theme.layout_fullscreen =   home .. "/.config/awesome/themes/adzuki/layouts/max.png"
theme.layout_tilebottom =   home .. "/.config/awesome/themes/adzuki/layouts/tilebottom.png"
theme.layout_tileleft   =   home .. "/.config/awesome/themes/adzuki/layouts/tileleft.png"
theme.layout_tile =         home .. "/.config/awesome/themes/adzuki/layouts/tile.png"
theme.layout_tiletop =      home .. "/.config/awesome/themes/adzuki/layouts/tiletop.png"
theme.layout_spiral  =      home .. "/.config/awesome/themes/adzuki/layouts/spiral.png"
theme.layout_dwindle =      home .. "/.config/awesome/themes/adzuki/layouts/dwindle.png"

theme.awesome_icon = home .. "/.config/awesome/themes/adzuki/start-here-archlinux.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
