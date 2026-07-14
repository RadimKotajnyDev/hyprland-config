-- https://wiki.hypr.land/Configuring/Monitors/

-- Second 1080p monitor (left) - 60Hz, 100% scale
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = 1 })

-- Main ultrawide Odyssey G8 (right) - 175Hz, 125% scale
hl.monitor({ output = "DP-1", mode = "3440x1440@175", position = "1920x0", scale = 1.25 })
