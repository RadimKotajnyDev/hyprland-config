-- Processes started with the session (notification daemons, bars, wallpaper, ...).
-- Add entries here, e.g. "waybar" or "nm-applet".

local startup = require("lua.lib.startup")

local autostart = {
    -- "nm-applet",
    -- "waybar & hyprpaper & firefox",
}

for _, cmd in ipairs(autostart) do
    startup.add(cmd)
end
