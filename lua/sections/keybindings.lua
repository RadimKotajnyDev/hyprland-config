-- https://wiki.hypr.land/Configuring/Binds/

local programs = require("lua.sections.programs")

-- "Windows" key as the main modifier
local mainMod = "SUPER"

-- Monitor modes for the toggle bind below. These call hl.monitor() directly:
-- `hyprctl keyword` only works with the legacy hyprlang parser, so the old
-- `exec, hyprctl keyword monitor ...` form is a no-op under the Lua config.
local GAMING_MODE       = { output = "DP-1", mode = "1920x1080@175", position = "1920x0", scale = 1 }
local PRODUCTIVITY_MODE = { output = "DP-1", mode = "3440x1440@175", position = "1920x0", scale = 1.25 }

-- Which mode we're in is read back off the monitor rather than tracked in a
-- variable, so the toggle can't drift out of sync if the mode is changed elsewhere.
local function toggle_monitor_mode()
    local mon = hl.get_monitor(GAMING_MODE.output)
    local in_gaming = mon and mon.width == 1920
    hl.monitor(in_gaming and PRODUCTIVITY_MODE or GAMING_MODE)
end

-- Apps and window management
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(
    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- Real fullscreen; pressing again toggles back out
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + arrow keys
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(mainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
end

-- Switch workspaces with mainMod + [0-9], move the active window with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Rofi window switcher
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("rofi -show window"))

-- Screenshots (Spectacle-like). Script lives in ~/.config/hypr/scripts/.
-- No Print key on this keyboard, so the family hangs off SUPER + SHIFT + S.
local screenshot = "~/.config/hypr/scripts/screenshot.sh"
-- SUPER + SHIFT + S -> drag-select a region, then annotate/save/copy in satty
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot .. " region"))
-- SUPER + SHIFT + D -> capture the focused monitor (display), then satty
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(screenshot .. " screen"))
-- SUPER + SHIFT + W -> capture the active window, then satty
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(screenshot .. " window"))
-- SUPER + CTRL + S  -> region straight to the clipboard, no editor
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd(screenshot .. " region-copy"))

-- Toggle the main monitor: gaming (raw 1080p, no scaling) <-> productivity (ultrawide @ 125%)
hl.bind(mainMod .. " + ALT + G", toggle_monitor_mode)

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- Moved off SUPER+SHIFT+S (now the screenshot bind) to SUPER+ALT+S.
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume and brightness keys (repeat while held, work when locked)
local held = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), held)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), held)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), held)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), held)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), held)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), held)

-- Media keys (requires playerctl)
local locked = { locked = true }
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
