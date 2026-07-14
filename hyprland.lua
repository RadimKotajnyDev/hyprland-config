--
-- Hyprland config.
--
-- Since 0.55 Hyprland reads this file directly (`hyprctl systeminfo` reports
-- configProvider: lua). There is no generation step any more -- edit the modules
-- under lua/sections/ and apply with:
--
--     hyprctl reload
--
-- The pre-Lua hyprlang config is preserved verbatim in hyprland-backup.conf.
--

local startup = require("lua.lib.startup")

-- Loaded in this order.
local SECTIONS = {
    "monitors",
    "programs",
    "autostart",
    "environment",
    "cursor",
    "look_and_feel",
    "input",
    "keybindings",
    "windowrules",
}

for _, name in ipairs(SECTIONS) do
    require("lua.sections." .. name)
end

-- Runs everything the sections queued with startup.add(), once, at Hyprland start.
startup.install()
