 

local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local v3 = game:GetService("ReplicatedStorage")
local v4 = v1.LocalPlayer
local u5 = v4.PlayerGui
local v6 = v3.Modules
local u7 = game.ReplicatedStorage:WaitForChild("Stats" .. v4.Name):WaitForChild("Settings"):WaitForChild("MobileButtonScale")
local u8 = TweenInfo.new(0.25, Enum.EasingStyle.Quart)
local v9 = require(v6.Shared.Signals.Signal)
local u10 = {
    ["Buttons"] = {},
    ["JumpButtonSize"] = Vector2.new(70, 70),
    ["ButtonAdded"] = v9.new()
}
_G.mobileButtonScale = u7.Value
u7:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u5
    --]]
    _G.mobileButtonScale = u7.Value
    local v11 = u5:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
    local v12 = v11.Size
    if v11:GetAttribute("OriginalSize") == nil then
        v11:SetAttribute("OriginalSize", v12)
    end
    v11:GetAttribute("OriginalSize")
end)
function u10._isSmallScreenDevice(_) --[[ Line: 45 ]]
    local v13 = script.ContextActionGui.AbsoluteSize
    local v14 = v13.X
    local v15 = v13.Y
    return math.min(v14, v15) <= 500
end
function u10.GetPositionAndSize(p16) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v17 = u5:WaitForChild("TouchGui")
    local v18 = v17:WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
    if v17 then
        local v19 = p16.JumpButtonSize
        local v20 = v19.X
        local v21 = v19.Y
        local v22 = v18.AbsolutePosition
        local v23 = UDim2.fromOffset(v22.X, v22.Y)
        return UDim2.new(0, v20, 0, v21), v23 - UDim2.new(0, v20 * 1, 0, 0)
    elseif p16:_isSmallScreenDevice() then
        return UDim2.new(0, 35, 0, 35), UDim2.fromScale(0.75, 0.75)
    else
        return UDim2.new(0, 45, 0, 45), UDim2.fromScale(0.75, 0.75)
    end
end
function u10._createButtonData(p24, p25) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u8
        [3] = u10
    --]]
    local v26 = p25.Button
    local u27 = p25.Frame
    local v28 = p25.Name
    local _ = p25.Callback
    local u29 = {
        ["Name"] = v28,
        ["Frame"] = u27,
        ["Button"] = v26,
        ["Properties"] = {},
        ["Callbacks"] = {},
        ["Animatable"] = p25.Animatable == nil and true or (p25.Animatable or true),
        ["SizeRatio"] = p25.SizeRatio,
        ["Connections"] = {}
    }
    local function v33() --[[ Line: 98 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u29
            [3] = u2
            [4] = u8
        --]]
        local v30 = u27.AbsoluteSize
        local v31 = script.Sounds:GetChildren()
        local v32 = v31[math.random(#v31)]
        v32.PlaybackSpeed = math.random(90, 110) / 100
        v32:Play()
        if u29.Animatable then
            u2:Create(u27, u8, {
                ["Size"] = u29.Properties.Size - UDim2.fromOffset(v30.X * 0.1, v30.Y * 0.1)
            }):Play()
        end
        if u29.Callbacks.InputBegan then
            u29.Callbacks.InputBegan()
        end
    end
    local function v34() --[[ Line: 115 ]]
        --[[
        Upvalues:
            [1] = u29
            [2] = u2
            [3] = u27
            [4] = u8
        --]]
        if u29.Animatable then
            u2:Create(u27, u8, {
                ["Size"] = u29.Properties.Size
            }):Play()
        end
        if u29.Callbacks.InputEnded then
            u29.Callbacks.InputEnded()
        end
    end
    u29.Connections.InputBegan = v26.MouseButton1Down:Connect(v33)
    u29.Connections.InputEnded = v26.InputEnded:Connect(v34)
    u10.Buttons[v28] = u29
    p24:_updateProperties(p25)
    if p25.AutoScaling then
        p24:_autoScaleButton(u29)
    end
    u10.ButtonAdded:Fire(v28, u29)
    return u29.Button
end
function u10._updateProperties(p35, p36) --[[ Line: 138 ]]
    local v37 = p36.Name
    for _, v38 in ipairs({
        "Size",
        "Position",
        "Title",
        "Callbacks",
        "Texture"
    }) do
        local v39 = p36[v38]
        if v39 then
            p35["Update" .. v38](p35, {
                [v38] = v39,
                ["ButtonName"] = v37
            })
        end
    end
end
function u10.GetButtonData(p40, p41) --[[ Line: 154 ]]
    return p40.Buttons[p41]
end
function u10.GetButton(p42, p43) --[[ Line: 158 ]]
    local v44 = p42.Buttons[p43]
    if v44 then
        v44 = v44.Button
    end
    return v44
end
function u10.GetButtonParent(p45, p46) --[[ Line: 163 ]]
    local v47 = p45.Buttons[p46]
    return v47 and v47.Button.Parent or nil
end
function u10._autoScaleButton(u48, u49) --[[ Line: 168 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local u50 = u5:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
    local v51 = u49.Button
    local v52 = u48.JumpButtonSize
    local _ = u49.Properties.Size
    u49.SizeRatio = u49.SizeRatio or v51.AbsoluteSize / v52
    local function v54() --[[ Line: 180 ]]
        --[[
        Upvalues:
            [1] = u49
            [2] = u48
            [3] = u50
        --]]
        local v53 = u49.SizeRatio
        u48:UpdateSize({
            ["ButtonName"] = u49.Name,
            ["Size"] = UDim2.fromOffset(u50.AbsoluteSize.X * v53.X, u50.AbsoluteSize.Y * v53.Y)
        })
    end
    v54()
    u50:GetPropertyChangedSignal("AbsoluteSize"):Connect(v54)
end
function u10.UpdateTexture(p55, p56) --[[ Line: 195 ]]
    local v57 = p55:GetButtonData(p56.ButtonName)
    if v57 then
        v57.Button.ActionIcon.Image = p56.Texture or ""
    end
end
function u10.UpdateCallbacks(p58, p59) --[[ Line: 202 ]]
    local v60 = p58:GetButtonData(p59.ButtonName)
    if v60 then
        v60.Callbacks = p59.Callbacks
    end
end
function u10.UpdatePosition(p61, p62) --[[ Line: 209 ]]
    local v63 = p61:GetButtonData(p62.ButtonName)
    if v63 then
        v63.Properties.Position = p62.Position
        v63.Frame.Position = p62.Position
    end
end
function u10.UpdateTitle(p64, p65) --[[ Line: 217 ]]
    local v66 = p64:GetButtonData(p65.ButtonName)
    if v66 then
        local v67 = v66.Button:FindFirstChild("ActionTitle")
        if v67 then
            v67.Text = p65.Title
        end
    else
        return
    end
end
function u10.UpdateSize(p68, p69) --[[ Line: 227 ]]
    local v70 = p68:GetButtonData(p69.ButtonName)
    if v70 then
        v70.Properties.Size = p69.Size
        v70.Frame.Size = p69.Size
    end
end
function u10.GetMobileUI(_) --[[ Line: 235 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v71 = u5:WaitForChild("TouchGui")
    local v72 = v71:WaitForChild("TouchControlFrame")
    return v71, v72, v72:WaitForChild("JumpButton")
end
function u10.CreateButton(p73, p74) --[[ Line: 245 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v75 = u5:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame")
    v75:WaitForChild("JumpButton")
    if not p74.Button then
        p74.Button = script.ContextActionButton:Clone()
        p74.Button.Name = ("%*"):format(p74.Name)
        p74.Button.Parent = v75
        p74.Frame = p74.Button
    end
    if not p74.Button:IsA("GuiButton") then
        p74.Frame = p74.Button
        p74.Frame.Parent = v75
        p74.Button = p74.Button:FindFirstChildWhichIsA("GuiButton", true)
    end
    p74.Size = p74.Size or p74.Frame.Size
    p74.Position = p74.Position or p74.Button.Position
    return p73:_createButtonData(p74)
end
return u10