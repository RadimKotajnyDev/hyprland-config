-- https://wiki.hypr.land/Configuring/Variables/
-- general / decoration / animations / layouts / misc

--        NAME,           X0,   Y0,   X1,   Y1
local beziers = {
    { "easeOutQuint",   0.23, 1,    0.32, 1 },
    { "easeInOutCubic", 0.65, 0.05, 0.36, 1 },
    { "linear",         0,    0,    1,    1 },
    { "almostLinear",   0.5,  0.5,  0.75, 1 },
    { "quick",          0.15, 0,    0.1,  1 },
}

--           NAME,            ONOFF, SPEED, CURVE,          [STYLE]
local animations = {
    { "global",        1, 10,   "default" },
    { "border",        1, 5.39, "easeOutQuint" },
    { "windows",       1, 4.79, "easeOutQuint" },
    { "windowsIn",     1, 4.1,  "easeOutQuint", "popin 87%" },
    { "windowsOut",    1, 1.49, "linear",       "popin 87%" },
    { "fadeIn",        1, 1.73, "almostLinear" },
    { "fadeOut",       1, 1.46, "almostLinear" },
    { "fade",          1, 3.03, "quick" },
    { "layers",        1, 3.81, "easeOutQuint" },
    { "layersIn",      1, 4,    "easeOutQuint", "fade" },
    { "layersOut",     1, 1.5,  "linear",       "fade" },
    { "fadeLayersIn",  1, 1.79, "almostLinear" },
    { "fadeLayersOut", 1, 1.39, "almostLinear" },
    { "workspaces",    1, 1.94, "almostLinear", "fade" },
    { "workspacesIn",  1, 1.21, "almostLinear", "fade" },
    { "workspacesOut", 1, 1.94, "almostLinear", "fade" },
    { "zoomFactor",    1, 7,    "quick" },
}

return function(b)
    b:banner("LOOK AND FEEL"):blank()

    b:block("general", function(g)
        g:kw("gaps_in", 5)
        g:kw("gaps_out", 20)
        g:blank()
        g:kw("border_size", 2)
        g:kw("col.active_border", "rgba(33ccffee) rgba(00ff99ee) 45deg")
        g:kw("col.inactive_border", "rgba(595959aa)")
        g:blank()
        g:comment("Resize windows by dragging borders and gaps")
        g:kw("resize_on_border", false)
        g:comment("See https://wiki.hypr.land/Configuring/Tearing/ before enabling")
        g:kw("allow_tearing", false)
        g:blank()
        g:kw("layout", "dwindle")
    end)
    b:blank()

    b:block("decoration", function(d)
        d:kw("rounding", 10)
        d:kw("rounding_power", 2)
        d:blank()
        d:kw("active_opacity", 1.0)
        d:kw("inactive_opacity", 1.0)
        d:blank()
        d:block("shadow", function(s)
            s:kw("enabled", true)
            s:kw("range", 4)
            s:kw("render_power", 3)
            s:kw("color", "rgba(1a1a1aee)")
        end)
        d:blank()
        d:block("blur", function(s)
            s:kw("enabled", true)
            s:kw("size", 3)
            s:kw("passes", 1)
            s:kw("vibrancy", 0.1696)
        end)
    end)
    b:blank()

    b:block("animations", function(a)
        a:kw("enabled", "yes, please :)")
        a:blank()
        a:comment("Curves: https://wiki.hypr.land/Configuring/Animations/#curves")
        for _, z in ipairs(beziers) do
            a:kw("bezier", ("%s, %s, %s, %s, %s"):format(z[1], z[2], z[3], z[4], z[5]))
        end
        a:blank()
        for _, an in ipairs(animations) do
            local spec = ("%s, %s, %s, %s"):format(an[1], an[2], an[3], an[4])
            if an[5] then
                spec = spec .. ", " .. an[5]
            end
            a:kw("animation", spec)
        end
    end)
    b:blank()

    b:comment("https://wiki.hypr.land/Configuring/Dwindle-Layout/")
    b:block("dwindle", function(d)
        d:kw("preserve_split", true)
    end)
    b:blank()

    b:comment("https://wiki.hypr.land/Configuring/Master-Layout/")
    b:block("master", function(m)
        m:kw("new_status", "master")
    end)
    b:blank()

    b:block("misc", function(m)
        m:kw("vrr", 0)
        m:kw("force_default_wallpaper", 1)
        m:kw("disable_hyprland_logo", true)
    end)
    b:blank()
end
