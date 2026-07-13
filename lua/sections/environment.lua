-- https://wiki.hypr.land/Configuring/Environment-variables/

-- Cursor env vars live in sections/cursor.lua.
local env = {
    -- Keeps the Steam desktop UI legible on the 125%-scaled ultrawide.
    { "STEAM_FORCE_DESKTOPUI_SCALE", 1.25 },
}

return function(b)
    b:banner("ENVIRONMENT VARIABLES"):blank()

    for _, e in ipairs(env) do
        b:kw("env", e[1] .. ", " .. tostring(e[2]))
    end
    b:blank()

    b:banner("PERMISSIONS"):blank()
    b:comment("https://wiki.hypr.land/Configuring/Permissions/")
    b:comment("Changes here need a full Hyprland restart, they are not applied on-the-fly.")
    b:blank()
    b:comment("ecosystem {")
    b:comment("  enforce_permissions = 1")
    b:comment("}")
    b:blank()
    b:comment("permission = /usr/(bin|local/bin)/grim, screencopy, allow")
    b:comment("permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow")
    b:comment("permission = /usr/(bin|local/bin)/hyprpm, plugin, allow")
    b:blank()
end
