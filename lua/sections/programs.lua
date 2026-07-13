-- https://wiki.hypr.land/Configuring/Keywords/
-- Programs referenced by the keybinds in sections/keybindings.lua.

return function(b)
    b:banner("MY PROGRAMS"):blank()

    b:var("terminal", "warp-terminal")
    b:var("fileManager", "dolphin")
    b:var("menu", "rofi -show drun")
    b:blank()
end
