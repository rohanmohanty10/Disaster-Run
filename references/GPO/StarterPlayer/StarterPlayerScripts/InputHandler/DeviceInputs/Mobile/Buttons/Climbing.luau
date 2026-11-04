 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
game:GetService("RunService")
local v3 = v1.Modules
local u4 = v2.LocalPlayer
local u5 = RaycastParams.new()
u5.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u5.FilterType = Enum.RaycastFilterType.Include
require(v3.ContextActionService)
local v6 = require(script.Parent.Shared)
local u7 = setmetatable({}, v6)
u7.__index = u7
function u7.new(p8) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v9 = u7
    local v10 = setmetatable({}, v9)
    v10.Mobile = p8
    v10.Button = v10:_createButton({
        ["ButtonData"] = p8.SavedButtons[script.Name],
        ["Texture"] = "http://www.roblox.com/asset/?id=15938962139",
        ["Name"] = script.Name
    })
    v10.Detect = nil
    return v10
end
function u7.Activated(_) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    require(u4.Backpack:WaitForChild("InputCallbacks")).Callbacks.Climb:Mobile_Activate()
end
function u7._frontDetection(_) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v11 = u4.Character.HumanoidRootPart
    return workspace:Raycast(v11.Position, v11.CFrame.LookVector * 3, u5)
end
function u7.Update(p12) --[[ Line: 48 ]]
    p12.Button.Visible = p12:_frontDetection() ~= nil and true or p12.Mobile.EditMode.Editting
end
return u7