 

local u1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local u3 = game:GetService("UserInputService")
local v4 = u1.Modules
local u5 = v2.LocalPlayer
require(v4.ContextActionService)
local v6 = require(script.Parent.Shared)
local u7 = require(v4.SwordHandle.SwordInfo)
local u8 = setmetatable({}, v6)
u8.__index = u8
function u8.new(p9) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v10 = u8
    local v11 = setmetatable({}, v10)
    v11.Mobile = p9
    v11.Button = v11:_createButton({
        ["ButtonData"] = p9.SavedButtons.Attack,
        ["Texture"] = "rbxassetid://18629682395",
        ["Name"] = "Attack"
    })
    v11:_main()
    return v11
end
local u12 = false
function u8.Activated(_, p13) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u12
    --]]
    if _G.mobileUsingSkill then
        return
    end
    local v14 = require(u5.Backpack:WaitForChild("InputCallbacks"))
    if u12 == false then
        u12 = true
        while u12 == true do
            if not v14.Utils.holdingValidMelee() then
                return
            end
            v14.Callbacks.Attack:Mobile_Activate()
            if p13 == true then
                break
            end
            task.wait()
        end
        u12 = false
    end
end
function u8.Deactivated(_) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    u12 = false
end
function u8._isValidMelee(_, p15) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    return p15 ~= nil and (not p15 or (p15:GetAttributes().MeleeTool ~= nil or u7[p15.Name] ~= nil)) and true or false
end
function u8._main(u16) --[[ Line: 72 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
        [3] = u3
    --]]
    local u17 = u1:WaitForChild((("Stats%*"):format(u5)))
    local function v19(_, p18) --[[ Line: 75 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u5
            [3] = u16
        --]]
        if p18 then
            return
        elseif _G.mobileUsingSkill then
            return
        elseif u17.Settings.M1Button.Value == true then
            return
        elseif u16:_isValidMelee((u5.Character:FindFirstChildWhichIsA("Tool"))) then
            u16:Activated(true)
        end
    end
    local function u21(p20) --[[ Line: 86 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u17
        --]]
        if p20:IsA("Tool") then
            u16.Button.Visible = u16:_isValidMelee(p20) and u17.Settings.M1Button.Value or u16.Mobile.EditMode.Editting
        end
    end
    local function u23(p22) --[[ Line: 91 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        if p22:IsA("Tool") then
            u16.Button.Visible = u16.Mobile.EditMode.Editting
        end
    end
    local v24 = u5.Character or u5.CharacterAdded:Wait()
    u16.Button.Visible = false
    v24.ChildAdded:Connect(u21)
    v24.ChildRemoved:Connect(u23)
    u5.CharacterAdded:Connect(function(p25) --[[ Name: CharacterAdded, Line 96 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u21
            [3] = u23
        --]]
        u16.Button.Visible = false
        p25.ChildAdded:Connect(u21)
        p25.ChildRemoved:Connect(u23)
    end)
    u17.Settings.M1Button.Changed:Connect(function() --[[ Line: 106 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u16
            [3] = u17
        --]]
        local v26 = u5.Character:FindFirstChildWhichIsA("Tool")
        if v26:IsA("Tool") then
            u16.Button.Visible = u16:_isValidMelee(v26) and u17.Settings.M1Button.Value or u16.Mobile.EditMode.Editting
        end
    end)
    u3.TouchTapInWorld:Connect(v19)
end
return u8