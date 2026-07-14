-- Processes started with the session (notification daemons, bars, wallpaper, ...).
-- Add entries here, e.g. "waybar" or "nm-applet".

local startup = require("lua.lib.startup")

local autostart = {
    "hyprpaper", -- wallpaper daemon, reads hyprpaper.conf
    "waybar",
}

for _, cmd in ipairs(autostart) do
    startup.add(cmd)
end
