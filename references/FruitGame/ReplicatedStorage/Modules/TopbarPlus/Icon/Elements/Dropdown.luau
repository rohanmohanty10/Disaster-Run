 

local u1 = game:GetService("TweenService")
local u2 = game:GetService("RunService")
local u3 = require(script.Parent.Parent.Features.Themes)
return function(u4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u2
    --]]
    local u5 = Instance.new("Frame")
    u5.Name = "Dropdown"
    u5.AutomaticSize = Enum.AutomaticSize.X
    u5.BackgroundTransparency = 1
    u5.BorderSizePixel = 0
    u5.AnchorPoint = Vector2.new(0.5, 0)
    u5.Position = UDim2.new(0.5, 0, 1, 10)
    u5.ZIndex = -2
    u5.ClipsDescendants = true
    u5.Parent = u4.widget
    local u6 = game:GetService("GuiService")
    u4:setBehaviour("Dropdown", "BackgroundTransparency", function(p7) --[[ Line: 20 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        local v8 = p7 * u6.PreferredTransparency
        if p7 == 1 then
            return p7
        else
            return v8
        end
    end)
    u4.janitor:add(u6:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() --[[ Line: 28 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
        --]]
        u4:refreshAppearance(u5, "BackgroundTransparency")
    end))
    local v9 = Instance.new("UICorner")
    v9.Name = "DropdownCorner"
    v9.CornerRadius = UDim.new(0, 10)
    v9.Parent = u5
    local u10 = Instance.new("ScrollingFrame")
    u10.Name = "DropdownScroller"
    u10.AutomaticSize = Enum.AutomaticSize.X
    u10.BackgroundTransparency = 1
    u10.BorderSizePixel = 0
    u10.AnchorPoint = Vector2.new(0, 0)
    u10.Position = UDim2.new(0, 0, 0, 0)
    u10.ZIndex = -1
    u10.ClipsDescendants = true
    u10.Visible = true
    u10.VerticalScrollBarInset = Enum.ScrollBarInset.None
    u10.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    u10.Active = false
    u10.ScrollingEnabled = true
    u10.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u10.ScrollBarThickness = 5
    u10.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    u10.ScrollBarImageTransparency = 0.8
    u10.CanvasSize = UDim2.new(0, 0, 0, 0)
    u10.Selectable = false
    u10.Active = true
    u10.Parent = u5
    local u11 = Instance.new("NumberValue")
    u11.Name = "DropdownSpeed"
    u11.Value = 0.07
    u11.Parent = u5
    local u12 = Instance.new("UIPadding")
    u12.Name = "DropdownPadding"
    u12.PaddingTop = UDim.new(0, 0)
    u12.PaddingBottom = UDim.new(0, 0)
    u12.Parent = u10
    local v13 = Instance.new("UIListLayout")
    v13.Name = "DropdownList"
    v13.FillDirection = Enum.FillDirection.Vertical
    v13.SortOrder = Enum.SortOrder.LayoutOrder
    v13.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v13.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
    v13.Parent = u10
    local v14 = u4.dropdownJanitor
    local u15 = require(u4.iconModule)
    u4.dropdownChildAdded:Connect(function(u16) --[[ Line: 81 ]]
        local _, u17 = u16:modifyTheme({
            { "Widget", "BorderSize", 0 },
            { "IconCorners", "CornerRadius", UDim.new(0, 10) },
            { "Widget", "MinimumWidth", 190 },
            { "Widget", "MinimumHeight", 58 },
            { "IconLabel", "TextSize", 20 },
            { "IconOverlay", "Size", UDim2.new(1, 0, 1, 0) },
            { "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
            { "Notice", "Position", UDim2.new(1, -24, 0, 5) },
            { "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
            { "Selection", "Size", UDim2.new(1, -0, 1, -0) },
            { "Selection", "Position", UDim2.new(0, 0, 0, 0) }
        })
        task.defer(function() --[[ Line: 96 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u17
            --]]
            u16.joinJanitor:add(function() --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u17
                --]]
                u16:removeModification(u17)
            end)
        end)
    end)
    u4.dropdownSet:Connect(function(p18) --[[ Line: 103 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u15
        --]]
        for _, v19 in pairs(u4.dropdownIcons) do
            local v20 = u15.getIconByUID(v19)
            if v20 then
                v20:destroy()
            end
        end
        if type(p18) == "table" then
            for _, v21 in pairs(p18) do
                v21:joinDropdown(u4)
            end
        end
    end)
    local function u33() --[[ Line: 117 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u10
            [3] = u12
        --]]
        local v22 = u5:GetAttribute("MaxIcons")
        if not v22 then
            return 0
        end
        local v23 = {}
        for _, v24 in pairs(u10:GetChildren()) do
            if v24:IsA("GuiObject") and v24.Visible then
                table.insert(v23, v24)
            end
        end
        table.sort(v23, function(p25, p26) --[[ Line: 128 ]]
            return p25.AbsolutePosition.Y < p26.AbsolutePosition.Y
        end)
        local v27 = math.ceil(v22)
        local v28 = 0
        for v29 = 1, v27 do
            local v30 = v23[v29]
            if not v30 then
                break
            end
            local v31 = v30.AbsoluteSize.Y
            local v32
            if v29 == v27 then
                v32 = v27 ~= v22
            else
                v32 = false
            end
            if v32 then
                v31 = v31 * (v22 - v27 + 1)
            end
            v28 = v28 + v31
        end
        return v28 + (u12.PaddingTop.Offset + u12.PaddingBottom.Offset)
    end
    local u34 = nil
    local u35 = nil
    local u36 = nil
    local u37 = nil
    local function v41() --[[ Line: 163 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u5
            [3] = u36
            [4] = u37
            [5] = u11
            [6] = u34
            [7] = u35
            [8] = u4
            [9] = u33
            [10] = u1
        --]]
        local v38 = u3.getInstanceValue(u5, "MaxIcons") or 1
        local v39
        if u36 and (u36 == v38 and u37) then
            v39 = u37
        else
            v39 = TweenInfo.new(u11.Value * v38, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
            u37 = v39
            u36 = v38
        end
        if u34 then
            u34:Cancel()
            u34 = nil
        end
        if u35 then
            u35:Cancel()
            u35 = nil
        end
        if u4.isSelected then
            local v40 = u33()
            u5.Visible = true
            u5.BackgroundTransparency = 0
            u5.Size = UDim2.new(0, u5.Size.X.Offset, 0, 0)
            u34 = u1:Create(u5, v39, {
                ["Size"] = UDim2.new(0, u5.Size.X.Offset, 0, v40)
            })
            u34:Play()
            u34.Completed:Connect(function() --[[ Line: 184 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                u34 = nil
            end)
        else
            u35 = u1:Create(u5, TweenInfo.new(0), {
                ["Size"] = UDim2.new(0, u5.Size.X.Offset, 0, 0)
            })
            u35:Play()
            u35.Completed:Connect(function() --[[ Line: 191 ]]
                --[[
                Upvalues:
                    [1] = u35
                --]]
                u35 = nil
            end)
        end
    end
    v14:add(u4.toggled:Connect(v41))
    v41()
    local function u45() --[[ Line: 201 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u5
            [3] = u36
            [4] = u37
            [5] = u11
            [6] = u4
            [7] = u34
            [8] = u35
            [9] = u2
            [10] = u33
            [11] = u1
        --]]
        local v42 = u3.getInstanceValue(u5, "MaxIcons") or 1
        local v43
        if u36 and (u36 == v42 and u37) then
            v43 = u37
        else
            v43 = TweenInfo.new(u11.Value * v42, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
            u37 = v43
            u36 = v42
        end
        if u4.isSelected then
            if u34 then
                u34:Cancel()
                u34 = nil
            end
            if u35 then
                u35:Cancel()
                u35 = nil
            end
            u2.Heartbeat:Wait()
            local v44 = u33()
            u34 = u1:Create(u5, v43, {
                ["Size"] = UDim2.new(0, u5.Size.X.Offset, 0, v44)
            })
            u34:Play()
            u34.Completed:Connect(function() --[[ Line: 219 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                u34 = nil
            end)
        end
    end
    v14:add(u4.toggled:Connect(v41))
    local u46 = 0
    local u47 = false
    local function u66() --[[ Line: 232 ]]
        --[[
        Upvalues:
            [1] = u46
            [2] = u47
            [3] = u66
            [4] = u5
            [5] = u10
            [6] = u15
            [7] = u4
            [8] = u12
        --]]
        u46 = u46 + 1
        if u47 then
            return
        end
        local u48 = u46
        u47 = true
        task.defer(function() --[[ Line: 237 ]]
            --[[
            Upvalues:
                [1] = u47
                [2] = u46
                [3] = u48
                [4] = u66
            --]]
            u47 = false
            if u46 ~= u48 then
                u66()
            end
        end)
        local v49 = u5:GetAttribute("MaxIcons")
        if not v49 then
            return
        end
        local v50 = {}
        for _, v51 in pairs(u10:GetChildren()) do
            if v51:IsA("GuiObject") and v51.Visible then
                local v52 = { v51, v51.AbsolutePosition.Y }
                table.insert(v50, v52)
            end
        end
        table.sort(v50, function(p53, p54) --[[ Line: 252 ]]
            return p53[2] < p54[2]
        end)
        local v55 = math.ceil(v49)
        local v56 = 0
        local v57 = false
        for v58 = 1, v55 do
            local v59 = v50[v58]
            if not v59 then
                break
            end
            local v60 = v59[1]
            local v61 = v60.AbsoluteSize.Y
            local v62
            if v58 == v55 then
                v62 = v55 ~= v49
            else
                v62 = false
            end
            if v62 then
                v61 = v61 * (v49 - v55 + 1)
            end
            v56 = v56 + v61
            if not v62 then
                local v63 = v60:GetAttribute("WidgetUID")
                if v63 then
                    v63 = u15.getIconByUID(v63)
                end
                if v63 then
                    local v64
                    if v57 then
                        v64 = nil
                    else
                        v64 = u4:getInstance("ClickRegion")
                        v57 = true
                    end
                    v63:getInstance("ClickRegion").NextSelectionUp = v64
                end
            end
        end
        local v65 = v56 + (u12.PaddingTop.Offset + u12.PaddingBottom.Offset)
        u10.Size = UDim2.fromOffset(0, v65)
    end
    v14:add(u10:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(u66))
    v14:add(u10.ChildAdded:Connect(u66))
    v14:add(u10.ChildRemoved:Connect(u45))
    v14:add(u10.ChildRemoved:Connect(u66))
    v14:add(u5:GetAttributeChangedSignal("MaxIcons"):Connect(u66))
    v14:add(u5:GetAttributeChangedSignal("MaxIcons"):Connect(u45))
    v14:add(u4.childThemeModified:Connect(u66))
    u66()
    for _, v67 in pairs(u10:GetChildren()) do
        if v67:IsA("GuiObject") then
            v67:GetPropertyChangedSignal("Visible"):Connect(u45)
            v67:GetPropertyChangedSignal("Size"):Connect(u45)
        end
    end
    u10.ChildAdded:Connect(function(p68) --[[ Line: 309 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u45
        --]]
        u2.Heartbeat:Wait()
        if p68:IsA("GuiObject") then
            p68:GetPropertyChangedSignal("Visible"):Connect(u45)
            p68:GetPropertyChangedSignal("Size"):Connect(u45)
        end
        u45()
    end)
    u5.Visible = false
    return u5
end