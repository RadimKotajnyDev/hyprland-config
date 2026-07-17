-- https://wiki.hypr.land/Configuring/Variables/
-- general / decoration / animations / layouts / misc

hl.config({
	general = {
		gaps_in = 8,
		gaps_out = 8,

		border_size = 2,
		-- Gruvbox: yellow -> orange gradient on focus, bg3 when inactive.
		-- Same yellow (#fabd2f) as the active workspace marker in waybar.
		col = {
			active_border = { colors = { "rgba(fabd2fee)", "rgba(fe8019ee)" }, angle = 45 },
			inactive_border = "rgba(665c54aa)",
		},

		-- Resize windows by dragging borders and gaps
		resize_on_border = true,
		-- See https://wiki.hypr.land/Configuring/Tearing/ before enabling
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		-- Dim windows that aren't focused, on top of the opacity above.
		dim_inactive = false,
		dim_strength = 0.2,
		-- The special workspace (scratchpad) dims what's behind it.
		dim_special = 0.3,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	-- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
	dwindle = {
		preserve_split = true,
	},

	-- https://wiki.hypr.land/Configuring/Master-Layout/
	master = {
		new_status = "master",
	},

	misc = {
		vrr = 0,
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
	},
})

-- Curves: https://wiki.hypr.land/Configuring/Animations/#curves
--        NAME,             X0,   Y0,   X1,   Y1
local beziers = {
	{ "easeOutQuint", 0.23, 1, 0.32, 1 },
	{ "easeInOutCubic", 0.65, 0.05, 0.36, 1 },
	{ "linear", 0, 0, 1, 1 },
	{ "almostLinear", 0.5, 0.5, 0.75, 1 },
	{ "quick", 0.15, 0, 0.1, 1 },
}

for _, z in ipairs(beziers) do
	hl.curve(z[1], { type = "bezier", points = { { z[2], z[3] }, { z[4], z[5] } } })
end

--           NAME,           SPEED, CURVE,          [STYLE]
local animations = {
	{ "global", 10, "default" },
	{ "border", 5.39, "easeOutQuint" },
	{ "windows", 4.79, "easeOutQuint" },
	{ "windowsIn", 4.1, "easeOutQuint", "popin 87%" },
	{ "windowsOut", 1.49, "linear", "popin 87%" },
	{ "fadeIn", 1.73, "almostLinear" },
	{ "fadeOut", 1.46, "almostLinear" },
	{ "fade", 3.03, "quick" },
	{ "layers", 3.81, "easeOutQuint" },
	{ "layersIn", 4, "easeOutQuint", "fade" },
	{ "layersOut", 1.5, "linear", "fade" },
	{ "fadeLayersIn", 1.79, "almostLinear" },
	{ "fadeLayersOut", 1.39, "almostLinear" },
	{ "workspaces", 1.94, "almostLinear", "fade" },
	{ "workspacesIn", 1.21, "almostLinear", "fade" },
	{ "workspacesOut", 1.94, "almostLinear", "fade" },
	{ "zoomFactor", 7, "quick" },
}

for _, a in ipairs(animations) do
	hl.animation({ leaf = a[1], enabled = true, speed = a[2], bezier = a[3], style = a[4] })
end
