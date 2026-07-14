-- https://wiki.hypr.land/Configuring/Window-Rules/

-- Ignore maximize requests from all apps
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Dock the hyprland-run launcher near the bottom-left
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Warp is the only window that gets transparency
hl.window_rule({
    name    = "warp-opacity",
    match   = { class = "^(dev\\.warp\\.Warp)$" },

    opacity = "0.95 0.95",
})

-- Let XWayland apps render at native scale (no blurry upscaling)
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
