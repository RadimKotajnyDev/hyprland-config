-- Cursor size has to be set in three places or it only half-applies:
--   env         -> XWayland / Qt / most toolkits, read at process launch
--   setcursor   -> the compositor's own cursor, applied live
--   gsettings   -> GTK apps, which ignore XCURSOR_SIZE on Wayland entirely
-- Change SIZE here and all three stay in sync.

local SIZE = 20
local THEME = "default"

return function(b)
    b:banner("CURSOR"):blank()

    b:kw("env", "XCURSOR_SIZE, " .. SIZE)
    b:kw("env", "HYPRCURSOR_SIZE, " .. SIZE)
    b:kw("env", "XCURSOR_THEME, " .. THEME)
    b:kw("env", "HYPRCURSOR_THEME, " .. THEME)
    b:blank()

    b:comment("Compositor cursor, applied at startup")
    b:kw("exec-once", ("hyprctl setcursor %s %d"):format(THEME, SIZE))
    b:blank()

    b:comment("GTK apps read gsettings, not XCURSOR_SIZE")
    b:kw("exec-once", ("gsettings set org.gnome.desktop.interface cursor-theme '%s'"):format(THEME))
    b:kw("exec-once", ("gsettings set org.gnome.desktop.interface cursor-size %d"):format(SIZE))
    b:blank()
end
