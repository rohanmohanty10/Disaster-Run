 

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
    v9.Mobile = p7
    v9.Button = v9:_createButton({
        ["ButtonData"] = p7.SavedButtons[script.Name],
        ["Texture"] = "http://www.roblox.com/asset/?id=17062994173",
        ["Name"] = script.Name
    })
    return v9
end
function u6.Activated(_) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if u4.Character:FindFirstChild("gripweld") then
        warn("cancel grip")
        game.ReplicatedStorage.Events.KnockedOut:FireServer("grip", nil)
    else
        require(u4.Backpack:WaitForChild("InputCallbacks")).Callbacks.Grip:Mobile_Activate()
    end
end
function u6.Update(p10) --[[ Line: 42 ]]
    p10.Button.Visible = p10.Mobile.Buttons.Carry:_uiVisibility()
end
return u6