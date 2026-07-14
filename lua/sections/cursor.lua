-- Cursor size has to be set in three places or it only half-applies:
--   env         -> XWayland / Qt / most toolkits, read at process launch
--   setcursor   -> the compositor's own cursor, applied live
--   gsettings   -> GTK apps, which ignore XCURSOR_SIZE on Wayland entirely
-- Change SIZE here and all three stay in sync.

local startup = require("lua.lib.startup")

local SIZE = 20
local THEME = "default"

hl.env("XCURSOR_SIZE", tostring(SIZE))
hl.env("HYPRCURSOR_SIZE", tostring(SIZE))
hl.env("XCURSOR_THEME", THEME)
hl.env("HYPRCURSOR_THEME", THEME)

-- Compositor cursor, applied at startup
startup.add(("hyprctl setcursor %s %d"):format(THEME, SIZE))

-- GTK apps read gsettings, not XCURSOR_SIZE
startup.add(("gsettings set org.gnome.desktop.interface cursor-theme '%s'"):format(THEME))
startup.add(("gsettings set org.gnome.desktop.interface cursor-size %d"):format(SIZE))
