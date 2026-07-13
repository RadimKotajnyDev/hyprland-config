-- https://wiki.hypr.land/Configuring/Monitors/

return function(b)
    b:banner("MONITORS"):blank()

    b:comment("Second 1080p monitor (left) - 60Hz, 100% scale")
    b:kw("monitor", "HDMI-A-1, 1920x1080@60, 0x0, 1")
    b:blank()

    b:comment("Main ultrawide Odyssey G8 (right) - 175Hz, 125% scale")
    b:kw("monitor", "DP-1, 3440x1440@175, 1920x0, 1.25")
    b:blank()
end
