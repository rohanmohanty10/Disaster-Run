 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
game:GetService("UserInputService")
local v3 = v1.Modules
local _ = v2.LocalPlayer
local u4 = require(v3.ContextActionService)
local v5 = require(script.Parent.Shared)
local u6 = setmetatable({}, v5)
u6.__index = u6
function u6.new(_) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
    --]]
    local v7 = u6
    local v8 = setmetatable({}, v7)
    local _, _, v9 = u4:GetMobileUI()
    v9.MouseButton1Down:Connect(function() --[[ Name: Activated, Line 20 ]]
        _G.swimmingAscension = true
    end)
    v9.MouseButton1Up:Connect(function() --[[ Name: Deactivated, Line 25 ]]
        _G.swimmingAscension = false
    end)
    return v8
end
return u6