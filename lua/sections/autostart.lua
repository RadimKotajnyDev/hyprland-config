-- Processes started with the session (notification daemons, bars, wallpaper, ...).
-- Add entries here, e.g. { "waybar" } or { "$terminal" }.

local autostart = {
    -- "nm-applet &",
    -- "waybar & hyprpaper & firefox",
}

return function(b)
    b:banner("AUTOSTART"):blank()

    if #autostart == 0 then
        b:comment("(nothing to autostart yet - add entries in lua/sections/autostart.lua)")
    else
        for _, cmd in ipairs(autostart) do
            b:kw("exec-once", cmd)
        end
    end
    b:blank()
end
