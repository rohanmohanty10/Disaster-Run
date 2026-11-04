 

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("UserInputService")
v1.LocalPlayer:WaitForChild("PlayerGui")
local v3 = v2:WaitForChild("Modules")
require(v3.Leveling)
local v4 = v3.Shared
require(v4.GameUtils)
require(v4:WaitForChild("SoundUtils"))
v2:WaitForChild("Events")
local u6 = {
    ["Initialized"] = false,
    ["Initialize"] = function(p5) --[[ Name: Initialize, Line 21 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        if u6.Initialized then
            return
        elseif _G.arena ~= true then
            p5:GetStatsFolder()
            u6.CrewsUI = require(script.CrewsUI)
            u6.CrewsUI:Initialize(p5)
            u6.Initialized = true
        end
    end
}
return u6