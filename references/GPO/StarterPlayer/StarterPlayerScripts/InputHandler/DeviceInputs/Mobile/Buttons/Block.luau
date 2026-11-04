 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players").LocalPlayer
local v3 = v1.Modules
local u4 = require(v3.ContextActionService)
local v5 = require(script.Parent.Shared)
local u6 = setmetatable({}, v5)
u6.__index = u6
local u7 = game.ReplicatedStorage:WaitForChild("Stats" .. u2.Name, 5)
function u6.new(p8) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v9 = u6
    local v10 = setmetatable({}, v9)
    v10.Button = v10:_createButton({
        ["ButtonData"] = p8.SavedButtons[script.Name],
        ["Texture"] = "http://www.roblox.com/asset/?id=17628061408",
        ["Name"] = script.Name
    })
    v10:_main()
    return v10
end
function u6.Activated(_) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if u7.Settings.MobileBlockToggle.Value then
        _G.HoldingBlockKey = not _G.HoldingBlockKey
    else
        _G.HoldingBlockKey = true
    end
end
function u6.Deactivated(_) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if not u7.Settings.MobileBlockToggle.Value then
        _G.HoldingBlockKey = false
    end
end
function u6._main(p11) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local u12 = p11.Button
    local function u14(p13) --[[ Line: 55 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u2
        --]]
        if not p13 or p13:IsA("Tool") then
            u12.Visible = p13.Parent == u2.Character
        end
    end
    local function v16() --[[ Line: 68 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        while task.wait() do
            local v15 = {
                ["ButtonName"] = "Block",
                ["Texture"] = _G.blocking and "http://www.roblox.com/asset/?id=17628061408" or "rbxassetid://17628061604",
                ["Title"] = _G.blocking and "Unblock" or "Block"
            }
            u4:UpdateTitle(v15)
            u4:UpdateTexture(v15)
        end
    end
    task.spawn(v16)
    local v17 = u2.Character or u2.CharacterAdded:Wait()
    u12.Visible = false
    v17.ChildAdded:Connect(u14)
    v17.ChildRemoved:Connect(u14)
    u2.CharacterAdded:Connect(function(p18) --[[ Name: Update, Line 61 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u14
        --]]
        u12.Visible = false
        p18.ChildAdded:Connect(u14)
        p18.ChildRemoved:Connect(u14)
    end)
end
return u6