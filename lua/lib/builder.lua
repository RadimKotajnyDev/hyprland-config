-- Accumulates hyprlang config lines with indentation tracking.

local Builder = {}
Builder.__index = Builder

local INDENT = "    "

function Builder.new()
    return setmetatable({ lines = {}, depth = 0 }, Builder)
end

function Builder:raw(text)
    if text == nil or text == "" then
        self.lines[#self.lines + 1] = ""
    else
        self.lines[#self.lines + 1] = INDENT:rep(self.depth) .. text
    end
    return self
end

function Builder:blank()
    return self:raw("")
end

function Builder:comment(text)
    return self:raw(text and ("# " .. text) or "#")
end

-- A banner like:
--   ################
--   ### MONITORS ###
--   ################
function Builder:banner(title)
    local label = "### " .. title .. " ###"
    local rule = ("#"):rep(#label)
    return self:raw(rule):raw(label):raw(rule)
end

function Builder:var(name, value)
    return self:raw("$" .. name .. " = " .. value)
end

-- Repeatable keys (monitor, env, bind, bezier, animation, ...) go through here too;
-- hyprlang treats duplicate keys as appends.
function Builder:kw(key, value)
    if value == nil or value == "" then
        return self:raw(key .. " =")
    end
    return self:raw(key .. " = " .. tostring(value))
end

-- name { ... }, nestable: fn receives the builder at the deeper indent level.
function Builder:block(name, fn)
    self:raw(name .. " {")
    self.depth = self.depth + 1
    fn(self)
    self.depth = self.depth - 1
    return self:raw("}")
end

function Builder:tostring()
    return table.concat(self.lines, "\n") .. "\n"
end

return Builder
