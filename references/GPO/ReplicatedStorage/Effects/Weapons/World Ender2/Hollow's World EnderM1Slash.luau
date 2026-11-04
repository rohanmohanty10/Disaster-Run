 

local _ = script
game:GetService("ReplicatedStorage")
game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
game:GetService("TweenService")
Random.new()
return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 10 ]]
        _G.PlayEffect("WorldEnderCustomSlash", nil, p1, p2, "Hollow\'s World Ender")
    end
}