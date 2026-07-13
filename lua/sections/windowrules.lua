-- https://wiki.hypr.land/Configuring/Window-Rules/

-- Each rule: a name, the match: predicates, and the properties to apply.
local rules = {
    {
        name = "suppress-maximize-events",
        comment = "Ignore maximize requests from all apps",
        match = { class = ".*" },
        props = { suppress_event = "maximize" },
    },
    {
        name = "fix-xwayland-drags",
        comment = "Fix some dragging issues with XWayland",
        match = {
            class = "^$",
            title = "^$",
            xwayland = true,
            float = true,
            fullscreen = false,
            pin = false,
        },
        props = { no_focus = true },
    },
    {
        name = "move-hyprland-run",
        comment = "Dock the hyprland-run launcher near the bottom-left",
        match = { class = "hyprland-run" },
        props = { move = "20 monitor_h-120", float = "yes" },
    },
}

-- Keys are emitted in a fixed order so output is stable across runs
-- (Lua table iteration order is not deterministic).
local MATCH_ORDER = { "class", "title", "xwayland", "float", "fullscreen", "pin", "workspace" }
local PROP_ORDER = { "suppress_event", "no_focus", "move", "float", "border_size", "rounding" }

local function emit_ordered(b, tbl, order, prefix)
    for _, key in ipairs(order) do
        local v = tbl[key]
        if v ~= nil then
            b:kw(prefix .. key, tostring(v))
        end
    end
end

return function(b)
    b:banner("WINDOWS AND WORKSPACES"):blank()

    for _, rule in ipairs(rules) do
        b:block("windowrule", function(r)
            if rule.comment then
                r:comment(rule.comment)
            end
            r:kw("name", rule.name)
            r:blank()
            emit_ordered(r, rule.match, MATCH_ORDER, "match:")
            r:blank()
            emit_ordered(r, rule.props, PROP_ORDER, "")
        end)
        b:blank()
    end

    b:comment("Let XWayland apps render at native scale (no blurry upscaling)")
    b:block("xwayland", function(x)
        x:kw("force_zero_scaling", true)
    end)
    b:blank()
end
