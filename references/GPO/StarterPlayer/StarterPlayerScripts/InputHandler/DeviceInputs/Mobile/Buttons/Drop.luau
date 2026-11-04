 

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
        ["Texture"] = "http://www.roblox.com/asset/?id=17644360865",
        ["Name"] = script.Name
    })
    v9:_main()
    return v9
end
function u6.Activated(_) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    require(u4.Backpack:WaitForChild("InputCallbacks")).Callbacks.DropTool:Mobile_Activate()
end
function u6._main(u10) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local function u12(p11) --[[ Line: 38 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        if p11:IsA("Tool") then
            u10.Button.Visible = p11:FindFirstChild("CanBeDropped") ~= nil and true or u10.Mobile.EditMode.Editting
        end
    end
    local function u14(p13) --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        if p13:IsA("Tool") then
            u10.Button.Visible = u10.Mobile.EditMode.Editting
        end
    end
    local v15 = u4.Character or u4.CharacterAdded:Wait()
    u10.Button.Visible = false
    v15.ChildAdded:Connect(u12)
    v15.ChildRemoved:Connect(u14)
    u4.CharacterAdded:Connect(function(p16) --[[ Name: CharacterAdded, Line 48 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u12
            [3] = u14
        --]]
        u10.Button.Visible = false
        p16.ChildAdded:Connect(u12)
        p16.ChildRemoved:Connect(u14)
    end)
end
return u6