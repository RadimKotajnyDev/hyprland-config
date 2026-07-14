-- Commands to run once, when Hyprland starts (the old `exec-once`).
--
-- Sections queue commands with startup.add(); hyprland.lua calls startup.install()
-- after all sections have loaded, so everything lands in a single hyprland.start
-- handler and the order is exactly the order the sections were required in.

local M = { commands = {} }

function M.add(cmd)
    M.commands[#M.commands + 1] = cmd
end

function M.install()
    if #M.commands == 0 then
        return
    end

    hl.on("hyprland.start", function()
        for _, cmd in ipairs(M.commands) do
            hl.exec_cmd(cmd)
        end
    end)
end

return M
