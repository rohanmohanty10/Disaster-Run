 

local v1 = game:GetService("Players")
game:GetService("ReplicatedStorage")
v1.LocalPlayer:WaitForChild("PlayerGui")
local u2 = {
    ["Initialized"] = false,
    ["Initialize"] = function(_) --[[ Name: Initialize, Line 10 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        u2.Initialized = true
    end
}
return u2