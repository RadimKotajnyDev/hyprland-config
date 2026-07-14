# hyprland-config

Hyprland config, written in Lua against the native `hl.*` API (Hyprland >= 0.55).

Hyprland loads `hyprland.lua` directly — `hyprctl systeminfo` reports
`configProvider: lua`. There is no build step: edit a module and reload.

    hyprctl reload

## Layout

    hyprland.lua           entry point; requires the sections below, in order
    lua/sections/*.lua     one module per concern (monitors, keybindings, ...)
    lua/lib/startup.lua    queues commands to run once at Hyprland start
    hyprland-backup.conf   the original pre-Lua hyprlang config, kept for reference

## Notes

`hyprctl keyword` does not work under the Lua config provider — it only supports
the legacy hyprlang parser. Anything that used to shell out to it (the monitor
mode toggles) calls the `hl.*` API from a Lua function instead.

If `hyprland.lua` throws, Hyprland registers no binds and drops to emergency
mode. Check `hyprctl configerrors`.
