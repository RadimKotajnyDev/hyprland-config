-- https://wiki.hypr.land/Configuring/Environment-variables/
-- Cursor env vars live in sections/cursor.lua.

-- Keeps the Steam desktop UI legible on the 125%-scaled ultrawide.
hl.env("STEAM_FORCE_DESKTOPUI_SCALE", "1.25")

-- Permissions: https://wiki.hypr.land/Configuring/Permissions/
-- Changes here need a full Hyprland restart, they are not applied on-the-fly.
--
-- hl.config({ ecosystem = { enforce_permissions = true } })
--
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
