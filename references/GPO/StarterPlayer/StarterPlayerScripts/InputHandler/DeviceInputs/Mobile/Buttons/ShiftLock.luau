 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1.Modules
local v4 = v2.LocalPlayer
local v5 = v4:WaitForChild("PlayerScripts")
local u6 = require(v5:WaitForChild("PlayerModule"))
local u7 = v4:WaitForChild("PlayerGui"):WaitForChild("MobileMouseIcon")
local u8 = require(v3.ContextActionService)
local v9 = require(script.Parent.Shared)
local u10 = setmetatable({}, v9)
u10.__index = u10
function u10.new(p11) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u6
    --]]
    local v12 = u10
    local v13 = setmetatable({}, v12)
    u6.cameras.CameraModule:ConstructMobileShiftLock()
    v13.Button = u10:_createButton({
        ["ButtonData"] = p11.SavedButtons[script.Name],
        ["Texture"] = "rbxassetid://17604463768",
        ["Name"] = script.Name
    })
    return v13
end
function u10.Activated(_) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u8
    --]]
    u6.cameras.CameraModule:ToggleMobileShiftLock()
    local v14 = u6.cameras.CameraModule.activeMouseLockController:GetIsMouseLocked()
    u7.Enabled = v14
    u8:UpdateTexture({
        ["ButtonName"] = "ShiftLock",
        ["Texture"] = v14 and "http://www.roblox.com/asset/?id=15938966453" or "rbxassetid://17604463768"
    })
end
return u10