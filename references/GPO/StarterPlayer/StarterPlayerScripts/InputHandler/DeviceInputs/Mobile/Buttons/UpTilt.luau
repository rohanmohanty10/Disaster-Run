 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players").LocalPlayer
local v3 = v1.Modules
local u4 = require(v3.ContextActionService)
local v5 = require(script.Parent.Shared)
local u6 = require(v3.SwordHandle.SwordInfo)
local u7 = setmetatable({}, v5)
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
        ["Texture"] = "rbxassetid://18124381653",
        ["Name"] = "UpTilt",
        ["Title"] = "Ground"
    })
    v10:_main()
    return v10
end
function u7.Activated(_) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    _G.mobileUpTilt = not _G.mobileUpTilt
    u4:UpdateTexture({
        ["ButtonName"] = "UpTilt",
        ["Texture"] = _G.mobileUpTilt and "rbxassetid://18124381913" or "rbxassetid://18124381653"
    })
    u4:UpdateTitle({
        ["ButtonName"] = "UpTilt",
        ["Title"] = _G.mobileUpTilt and "Up Tilt" or "Ground"
    })
end
function u7._isValidMelee(_, p11) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return p11 ~= nil and (not p11 or (p11:GetAttributes().MeleeTool ~= nil or u6[p11.Name] ~= nil)) and true or false
end
function u7._main(u12) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local function u14(p13) --[[ Line: 59 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        if p13:IsA("Tool") then
            u12.Button.Visible = u12:_isValidMelee(p13) or u12.Mobile.EditMode.Editting
        end
    end
    local function u16(p15) --[[ Line: 64 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        if p15:IsA("Tool") then
            u12.Button.Visible = u12.Mobile.EditMode.Editting
        end
    end
    local v17 = u2.Character or u2.CharacterAdded:Wait()
    u12.Button.Visible = false
    v17.ChildAdded:Connect(u14)
    v17.ChildRemoved:Connect(u16)
    u2.CharacterAdded:Connect(function(p18) --[[ Name: CharacterAdded, Line 69 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u14
            [3] = u16
        --]]
        u12.Button.Visible = false
        p18.ChildAdded:Connect(u14)
        p18.ChildRemoved:Connect(u16)
    end)
end
return u7