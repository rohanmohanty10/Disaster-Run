 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
local v4 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v4:GetControls()
local u5 = setmetatable({}, u3)
u5.__index = u5
function u5.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
    --]]
    local v6 = u3.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {}
    return v8
end
function u5.FirstSkill(p9) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local _ = p9.Cooldowns
    local _ = u1.Character
    local _ = u2["Stats" .. u1.Name]
end
return u5