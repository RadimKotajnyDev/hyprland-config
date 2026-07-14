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
        accel_profile = "flat",

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Per-device config: https://wiki.hypr.land/Configuring/Devices/
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })
