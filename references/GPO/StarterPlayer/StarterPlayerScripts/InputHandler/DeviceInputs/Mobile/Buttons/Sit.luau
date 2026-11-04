 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1.Modules
local u4 = v2.LocalPlayer
local u5 = RaycastParams.new()
u5.FilterDescendantsInstances = { workspace.Ships }
u5.FilterType = Enum.RaycastFilterType.Include
require(v3.ContextActionService)
local v6 = require(script.Parent.Shared)
local u7 = setmetatable({}, v6)
u7.__index = u7
function u7.new(p8) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v9 = u7
    local v10 = setmetatable({}, v9)
    v10.Mobile = p8
    v10.Button = v10:_createButton({
        ["ButtonData"] = p8.SavedButtons[script.Name],
        ["Texture"] = "rbxassetid://17594682814",
        ["Name"] = script.Name
    })
    return v10
end
function u7.Activated(_) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    require(u4.Backpack:WaitForChild("InputCallbacks")).Callbacks.ShipSeat:Mobile_Activate()
end
function u7._groundDetection(_) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v11 = u4.Character
    local v12 = v11.PrimaryPart
    local v13 = v11.Humanoid
    if v12 == nil then
        return nil
    end
    local v14 = v13.HipHeight + v12.Size.Y * 0.5 + 1
    return workspace:Raycast(v12.Position, v12.CFrame.UpVector * -v14, u5)
end
function u7.Update(p15) --[[ Line: 50 ]]
    p15.Button.Visible = p15:_groundDetection() or p15.Mobile.EditMode.Editting
end
return u7