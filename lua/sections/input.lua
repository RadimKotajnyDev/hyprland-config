-- https://wiki.hypr.land/Configuring/Variables/#input

hl.config({
    input = {
        kb_layout  = "cz,us",
        kb_variant = "",
        kb_model   = "",
        -- Alt+Shift cycles cz <-> us
        kb_options = "grp:alt_shift_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        -- -1.0 - 1.0, 0 means no modification
        sensitivity   = 0,

        -- "flat" removes the acceleration curve, but input still goes through
        -- libinput's pointer handling. force_no_accel bypasses that too, which
        -- is as close to a raw signal as the compositor gets.
        -- If the cursor ever desyncs from where clicks land, this is the cause:
        -- set it back to false.
        accel_profile  = "flat",
        force_no_accel = true,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Per-device config: https://wiki.hypr.land/Configuring/Devices/
-- The mouse enumerates as "logitech-pro-x-2-1" (see `hyprctl devices`).
-- Nothing to override on it right now; global input settings above apply.
