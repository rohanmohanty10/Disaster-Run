 

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
        ["Texture"] = "http://www.roblox.com/asset/?id=17062995746",
        ["Name"] = script.Name
    })
    v9.PickUpRadius = 15
    return v9
end
function u6.Activated(_) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    require(u4.Backpack:WaitForChild("InputCallbacks")).Callbacks.Carry:Mobile_Activate()
end
function u6._uiVisibility(p10) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if p10.Mobile.EditMode.Editting then
        return true
    end
    for _, v11 in workspace.Ragdolls:GetChildren() do
        local v12 = u4.Character
        if v11 ~= v12 and v11.PrimaryPart ~= nil then
            local v13 = v12:FindFirstChild("HumanoidRootPart")
            if v13 and (v11.HumanoidRootPart.Position - v13.Position).Magnitude < p10.PickUpRadius then
                return true
            end
        end
    end
end
function u6.Update(p14) --[[ Line: 49 ]]
    p14.Button.Visible = p14:_uiVisibility()
end
return u6