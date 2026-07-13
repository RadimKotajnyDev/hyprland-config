-- https://wiki.hypr.land/Configuring/Binds/

local GAMING_MODE = "DP-1, 1920x1080@175, 1920x0, 1"
local PRODUCTIVITY_MODE = "DP-1, 3440x1440@175, 1920x0, 1.25"

-- Workspace keys 1..9 then 0 -> workspace 10.
local WORKSPACE_KEYS = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
local function workspace_for(key)
    return key == "0" and 10 or tonumber(key)
end

-- mod, key, dispatcher, arg -> "mod, key, dispatcher, arg"
local function spec(mod, key, dispatcher, arg)
    local parts = { mod, key, dispatcher }
    if arg ~= nil then
        parts[#parts + 1] = arg
    end
    return table.concat(parts, ", ")
end

return function(b)
    b:banner("KEYBINDINGS"):blank()

    b:comment('"Windows" key as the main modifier')
    b:var("mainMod", "SUPER")
    b:blank()

    b:comment("Apps and window management")
    b:kw("bind", spec("$mainMod", "Q", "exec", "$terminal"))
    b:kw("bind", spec("$mainMod", "C", "killactive"))
    b:kw("bind", spec("$mainMod", "M", "exec",
        "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
    b:kw("bind", spec("$mainMod", "E", "exec", "$fileManager"))
    b:kw("bind", spec("$mainMod", "V", "togglefloating"))
    b:comment("fullscreen 0 = real fullscreen; pressing again toggles back out")
    b:kw("bind", spec("$mainMod", "F", "fullscreen", 0))
    b:kw("bind", spec("$mainMod", "R", "exec", "$menu"))
    b:kw("bind", spec("$mainMod", "P", "pseudo"))
    b:kw("bind", spec("$mainMod", "J", "layoutmsg", "togglesplit"))
    b:blank()

    b:comment("Move focus with mainMod + arrow keys")
    for _, d in ipairs({ { "left", "l" }, { "right", "r" }, { "up", "u" }, { "down", "d" } }) do
        b:kw("bind", spec("$mainMod", d[1], "movefocus", d[2]))
    end
    b:blank()

    b:comment("Switch workspaces with mainMod + [0-9]")
    for _, key in ipairs(WORKSPACE_KEYS) do
        b:kw("bind", spec("$mainMod", key, "workspace", workspace_for(key)))
    end
    b:blank()

    b:comment("Move active window to a workspace with mainMod + SHIFT + [0-9]")
    for _, key in ipairs(WORKSPACE_KEYS) do
        b:kw("bind", spec("$mainMod SHIFT", key, "movetoworkspace", workspace_for(key)))
    end
    b:blank()

    b:comment("Rofi window switcher")
    b:kw("bind", spec("ALT", "Tab", "exec", "rofi -show window"))
    b:blank()

    b:comment("Gaming mode: main monitor to raw 1080p, no scaling")
    b:kw("bind", spec("$mainMod ALT", "G", "exec", ('hyprctl keyword monitor "%s"'):format(GAMING_MODE)))
    b:comment("Productivity mode: back to ultrawide at 125% scale")
    b:kw("bind", spec("$mainMod ALT", "P", "exec", ('hyprctl keyword monitor "%s"'):format(PRODUCTIVITY_MODE)))
    b:blank()

    b:comment("Special workspace (scratchpad)")
    b:kw("bind", spec("$mainMod", "S", "togglespecialworkspace", "magic"))
    b:kw("bind", spec("$mainMod SHIFT", "S", "movetoworkspace", "special:magic"))
    b:blank()

    b:comment("Scroll through existing workspaces with mainMod + scroll")
    b:kw("bind", spec("$mainMod", "mouse_down", "workspace", "e+1"))
    b:kw("bind", spec("$mainMod", "mouse_up", "workspace", "e-1"))
    b:blank()

    b:comment("Move/resize windows with mainMod + LMB/RMB and dragging")
    b:kw("bindm", spec("$mainMod", "mouse:272", "movewindow"))
    b:kw("bindm", spec("$mainMod", "mouse:273", "resizewindow"))
    b:blank()

    b:comment("Volume and brightness keys (repeat while held, work when locked)")
    b:kw("bindel", spec("", "XF86AudioRaiseVolume", "exec", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
    b:kw("bindel", spec("", "XF86AudioLowerVolume", "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
    b:kw("bindel", spec("", "XF86AudioMute", "exec", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
    b:kw("bindel", spec("", "XF86AudioMicMute", "exec", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
    b:kw("bindel", spec("", "XF86MonBrightnessUp", "exec", "brightnessctl -e4 -n2 set 5%+"))
    b:kw("bindel", spec("", "XF86MonBrightnessDown", "exec", "brightnessctl -e4 -n2 set 5%-"))
    b:blank()

    b:comment("Media keys (requires playerctl)")
    b:kw("bindl", spec("", "XF86AudioNext", "exec", "playerctl next"))
    b:kw("bindl", spec("", "XF86AudioPause", "exec", "playerctl play-pause"))
    b:kw("bindl", spec("", "XF86AudioPlay", "exec", "playerctl play-pause"))
    b:kw("bindl", spec("", "XF86AudioPrev", "exec", "playerctl previous"))
    b:blank()
end
