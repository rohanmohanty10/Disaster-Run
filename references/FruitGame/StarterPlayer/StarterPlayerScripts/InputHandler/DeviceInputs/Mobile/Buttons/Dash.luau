 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1.Modules
local u4 = v2.LocalPlayer
require(v3.ContextActionService)
local v5 = require(script.Parent.Shared)
local u6 = setmetatable({}, v5)
u6.__index = u6
function u6.new(p7) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v8 = u6
    local v9 = setmetatable({}, v8)
    v9.Button = v9:_createButton({
        ["ButtonData"] = p7.SavedButtons[script.Name],
        ["Texture"] = "http://www.roblox.com/asset/?id=15938960818",
        ["Name"] = script.Name
    })
    return v9
end
function u6.Activated(_) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    require(u4.Backpack:WaitForChild("InputCallbacks")).Callbacks.Dash:Mobile_Activate()
end
return u6