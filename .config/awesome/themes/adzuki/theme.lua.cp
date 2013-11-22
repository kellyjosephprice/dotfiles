---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "DejaVu Sans 9"

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
theme.border_focus  = "#5e6a79"
theme.border_marked = "#656565"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/kelly/.config/awesome/themes/adzuki/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/kelly/.config/awesome/themes/adzuki/taglist/squarew.png"

theme.tasklist_floating_icon = "/home/kelly/.config/awesome/themes/adzuki/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/kelly/.config/awesome/themes/adzuki/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/kelly/.config/awesome/themes/adzuki/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/kelly/.config/awesome/themes/adzuki/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/kelly/.config/awesome/themes/adzuki/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/kelly/.config/awesome/themes/adzuki/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/kelly/.config/awesome/themes/adzuki/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/kelly/.config/awesome/themes/adzuki/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/kelly/.config/awesome/themes/adzuki/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/kelly/.config/awesome/themes/adzuki/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/kelly/.config/awesome/themes/adzuki/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/kelly/.config/awesome/themes/adzuki/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
-- theme.wallpaper_cmd = { "awsetbg /home/kelly/.config/awesome/themes/adzuki/background.png" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/kelly/.config/awesome/themes/adzuki/layouts/fairhw.png"
theme.layout_fairv = "/home/kelly/.config/awesome/themes/adzuki/layouts/fairvw.png"
theme.layout_floating  = "/home/kelly/.config/awesome/themes/adzuki/layouts/floatingw.png"
theme.layout_magnifier = "/home/kelly/.config/awesome/themes/adzuki/layouts/magnifierw.png"
theme.layout_max = "/home/kelly/.config/awesome/themes/adzuki/layouts/maxw.png"
theme.layout_fullscreen = "/home/kelly/.config/awesome/themes/adzuki/layouts/fullscreenw.png"
theme.layout_tilebottom = "/home/kelly/.config/awesome/themes/adzuki/layouts/tilebottomw.png"
theme.layout_tileleft   = "/home/kelly/.config/awesome/themes/adzuki/layouts/tileleftw.png"
theme.layout_tile = "/home/kelly/.config/awesome/themes/adzuki/layouts/tilew.png"
theme.layout_tiletop = "/home/kelly/.config/awesome/themes/adzuki/layouts/tiletopw.png"
theme.layout_spiral  = "/home/kelly/.config/awesome/themes/adzuki/layouts/spiralw.png"
theme.layout_dwindle = "/home/kelly/.config/awesome/themes/adzuki/layouts/dwindlew.png"

theme.awesome_icon = "/home/kelly/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
