 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local v3 = u1.WidgetConstructor
    local v4 = {
        ["hasState"] = true,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1,
            ["Index"] = 2,
            ["NoClick"] = 3
        }
    }
    local v13 = {
        ["selected"] = {
            ["Init"] = function(_) --[[ Line: 22 ]] end,
            ["Get"] = function(p5) --[[ Line: 23 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p5.lastSelectedTick == u1._cycleTick
            end
        },
        ["unselected"] = {
            ["Init"] = function(_) --[[ Line: 28 ]] end,
            ["Get"] = function(p6) --[[ Line: 29 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p6.lastUnselectedTick == u1._cycleTick
            end
        },
        ["active"] = {
            ["Init"] = function(_) --[[ Line: 34 ]] end,
            ["Get"] = function(p7) --[[ Line: 35 ]]
                return p7.state.index.value == p7.arguments.Index
            end
        },
        ["clicked"] = u2.EVENTS.click(function(p8) --[[ Line: 39 ]]
            return p8.Instance.SelectableButton
        end),
        ["rightClicked"] = u2.EVENTS.rightClick(function(p9) --[[ Line: 43 ]]
            return p9.Instance.SelectableButton
        end),
        ["doubleClicked"] = u2.EVENTS.doubleClick(function(p10) --[[ Line: 47 ]]
            return p10.Instance.SelectableButton
        end),
        ["ctrlClicked"] = u2.EVENTS.ctrlClick(function(p11) --[[ Line: 51 ]]
            return p11.Instance.SelectableButton
        end),
        ["hovered"] = u2.EVENTS.hover(function(p12) --[[ Line: 55 ]]
            return p12.Instance.SelectableButton
        end)
    }
    v4.Events = v13
    function v4.Generate(u14) --[[ Line: 60 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v15 = Instance.new("Frame")
        v15.Name = "Iris_Selectable"
        v15.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, u1._config.TextSize))
        v15.AutomaticSize = Enum.AutomaticSize.None
        v15.BackgroundTransparency = 1
        v15.BorderSizePixel = 0
        v15.ZIndex = u14.ZIndex
        v15.LayoutOrder = u14.ZIndex
        local v16 = Instance.new("TextButton")
        v16.Name = "SelectableButton"
        v16.Size = UDim2.new(1, 0, 1, u1._config.ItemSpacing.Y - 1)
        local v17 = UDim2.fromOffset
        local v18 = u1._config.ItemSpacing.Y
        v16.Position = v17(0, -bit32.rshift(v18, 1))
        v16.BackgroundColor3 = u1._config.HeaderColor
        v16.ZIndex = u14.ZIndex + 1
        v16.LayoutOrder = u14.ZIndex + 1
        u2.applyFrameStyle(v16)
        u2.applyTextStyle(v16)
        u14.ButtonColors = {
            ["ButtonColor"] = u1._config.HeaderColor,
            ["ButtonTransparency"] = 1,
            ["ButtonHoveredColor"] = u1._config.HeaderHoveredColor,
            ["ButtonHoveredTransparency"] = u1._config.HeaderHoveredTransparency,
            ["ButtonActiveColor"] = u1._config.HeaderActiveColor,
            ["ButtonActiveTransparency"] = u1._config.HeaderActiveTransparency
        }
        u2.applyInteractionHighlights(v16, v16, u14.ButtonColors)
        v16.MouseButton1Click:Connect(function() --[[ Line: 92 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            if u14.arguments.NoClick ~= true then
                local v19 = u14
                local v20 = v19.state.index.value
                if type(v20) == "boolean" then
                    v19.state.index:set(not v19.state.index.value)
                    return
                end
                v19.state.index:set(v19.arguments.Index)
            end
        end)
        v16.Parent = v15
        return v15
    end
    function v4.Update(p21) --[[ Line: 102 ]]
        p21.Instance.SelectableButton.Text = p21.arguments.Text or "Selectable"
    end
    function v4.Discard(p22) --[[ Line: 107 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p22.Instance:Destroy()
        u2.discardState(p22)
    end
    function v4.GenerateState(p23) --[[ Line: 111 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p23.state.index == nil then
            if p23.arguments.Index ~= nil then
                error("a shared state index is required for Selectables with an Index argument", 5)
            end
            p23.state.index = u1._widgetState(p23, "index", false)
        end
    end
    function v4.UpdateState(p24) --[[ Line: 119 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v25 = p24.Instance.SelectableButton
        if p24.state.index.value == (p24.arguments.Index or true) then
            p24.ButtonColors.ButtonTransparency = u1._config.HeaderTransparency
            v25.BackgroundTransparency = u1._config.HeaderTransparency
            p24.lastSelectedTick = u1._cycleTick + 1
        else
            p24.ButtonColors.ButtonTransparency = 1
            v25.BackgroundTransparency = 1
            p24.lastUnselectedTick = u1._cycleTick + 1
        end
    end
    v3("Selectable", v4)
    local u26 = false
    local u27 = -1
    local u28 = nil
    local function u39(p29) --[[ Line: 138 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v30 = p29.Instance.PreviewContainer
        local v31 = v30.PreviewLabel
        local v32 = p29.ChildContainer
        local v33 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
        local v34 = u1._config.PopupBorderSize
        local v35 = p29.ComboChildrenHeight
        local v36 = v33 * math.min(v35, 8) - v34 * 2 + 3 * u1._config.FramePadding.Y
        local v37 = UDim.new(0, v30.AbsoluteSize.X - v34 * 2)
        v32.Size = UDim2.new(v37, UDim.new(0, v36))
        local v38 = v32.Parent.AbsoluteSize
        if v31.AbsolutePosition.Y + v33 + v36 > v38.Y then
            v32.Position = UDim2.new(0, v31.AbsolutePosition.X + v34, 0, v31.AbsolutePosition.Y - v34 - v36)
        else
            v32.Position = UDim2.new(0, v31.AbsolutePosition.X + v34, 0, v31.AbsolutePosition.Y + v33 + v34)
        end
    end
    u2.UserInputService.InputBegan:Connect(function(p40) --[[ Line: 161 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u27
            [3] = u1
            [4] = u2
            [5] = u28
        --]]
        if p40.UserInputType == Enum.UserInputType.MouseButton1 or (p40.UserInputType == Enum.UserInputType.MouseButton2 or p40.UserInputType == Enum.UserInputType.Touch) then
            if u26 == false then
                return
            elseif u27 ~= u1._cycleTick then
                local v41 = u2.getMouseLocation()
                local v42 = u28.ChildContainer
                local v43 = v42.AbsolutePosition - Vector2.new(0, u28.LabelHeight)
                local v44 = v42.AbsolutePosition + v42.AbsoluteSize
                if not u2.isPosInsideRect(v41, v43, v44) then
                    u28.state.isOpened:set(false)
                end
            end
        else
            return
        end
    end)
    local v45 = u1.WidgetConstructor
    local v46 = {
        ["hasState"] = true,
        ["hasChildren"] = true,
        ["Args"] = {
            ["Text"] = 1,
            ["NoButton"] = 2,
            ["NoPreview"] = 3
        }
    }
    local v51 = {
        ["opened"] = {
            ["Init"] = function(_) --[[ Line: 190 ]] end,
            ["Get"] = function(p47) --[[ Line: 191 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p47.lastOpenedTick == u1._cycleTick
            end
        },
        ["closed"] = {
            ["Init"] = function(_) --[[ Line: 196 ]] end,
            ["Get"] = function(p48) --[[ Line: 197 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p48.lastClosedTick == u1._cycleTick
            end
        },
        ["clicked"] = u2.EVENTS.click(function(p49) --[[ Line: 201 ]]
            return p49.Instance
        end),
        ["hovered"] = u2.EVENTS.hover(function(p50) --[[ Line: 204 ]]
            return p50.Instance
        end)
    }
    v46.Events = v51
    function v46.Generate(u52) --[[ Line: 208 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u26
            [4] = u28
        --]]
        local v53 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
        u52.ComboChildrenHeight = 0
        local v54 = Instance.new("Frame")
        v54.Name = "Iris_Combo"
        v54.Size = UDim2.fromScale(1, 0)
        v54.AutomaticSize = Enum.AutomaticSize.Y
        v54.BackgroundTransparency = 1
        v54.BorderSizePixel = 0
        v54.ZIndex = u52.ZIndex
        v54.LayoutOrder = u52.ZIndex
        u2.UIListLayout(v54, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.Y + 1))
        local v55 = Instance.new("TextButton")
        v55.Name = "PreviewContainer"
        v55.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0))
        v55.AutomaticSize = Enum.AutomaticSize.Y
        v55.BackgroundTransparency = 1
        v55.Text = ""
        v55.ZIndex = u52.ZIndex + 2
        v55.LayoutOrder = u52.ZIndex + 2
        v55.AutoButtonColor = false
        u2.applyFrameStyle(v55, true, true)
        u2.UIListLayout(v55, Enum.FillDirection.Horizontal, UDim.new(0, 0))
        v55.Parent = v54
        local v56 = Instance.new("TextLabel")
        v56.Name = "PreviewLabel"
        v56.Size = UDim2.new(1, 0, 0, 0)
        v56.AutomaticSize = Enum.AutomaticSize.Y
        v56.BackgroundColor3 = u1._config.FrameBgColor
        v56.BackgroundTransparency = u1._config.FrameBgTransparency
        v56.BorderSizePixel = 0
        v56.ZIndex = u52.ZIndex + 3
        v56.LayoutOrder = u52.ZIndex + 3
        u2.applyTextStyle(v56)
        u2.UIPadding(v56, u1._config.FramePadding)
        v56.Parent = v55
        local v57 = Instance.new("TextLabel")
        v57.Name = "DropdownButton"
        v57.Size = UDim2.new(0, v53, 0, v53)
        v57.BorderSizePixel = 0
        v57.BackgroundColor3 = u1._config.ButtonColor
        v57.BackgroundTransparency = u1._config.ButtonTransparency
        v57.Text = ""
        v57.ZIndex = u52.ZIndex + 4
        v57.LayoutOrder = u52.ZIndex + 4
        local v58 = v53 * 0.2
        local v59 = math.round(v58)
        local v60 = v53 - v59 * 2
        local v61 = Instance.new("ImageLabel")
        v61.Name = "Dropdown"
        v61.Size = UDim2.fromOffset(v60, v60)
        v61.Position = UDim2.fromOffset(v59, v59)
        v61.BackgroundTransparency = 1
        v61.BorderSizePixel = 0
        v61.ImageColor3 = u1._config.TextColor
        v61.ImageTransparency = u1._config.TextTransparency
        v61.ZIndex = u52.ZIndex + 5
        v61.LayoutOrder = u52.ZIndex + 5
        v61.Parent = v57
        v57.Parent = v55
        u2.applyInteractionHighlightsWithMultiHighlightee(v55, {
            {
                v56,
                {
                    ["ButtonColor"] = u1._config.FrameBgColor,
                    ["ButtonTransparency"] = u1._config.FrameBgTransparency,
                    ["ButtonHoveredColor"] = u1._config.FrameBgHoveredColor,
                    ["ButtonHoveredTransparency"] = u1._config.FrameBgHoveredTransparency,
                    ["ButtonActiveColor"] = u1._config.FrameBgActiveColor,
                    ["ButtonActiveTransparency"] = u1._config.FrameBgActiveTransparency
                }
            },
            {
                v57,
                {
                    ["ButtonColor"] = u1._config.ButtonColor,
                    ["ButtonTransparency"] = u1._config.ButtonTransparency,
                    ["ButtonHoveredColor"] = u1._config.ButtonHoveredColor,
                    ["ButtonHoveredTransparency"] = u1._config.ButtonHoveredTransparency,
                    ["ButtonActiveColor"] = u1._config.ButtonHoveredColor,
                    ["ButtonActiveTransparency"] = u1._config.ButtonHoveredColor
                }
            }
        })
        v55.InputBegan:Connect(function(p62) --[[ Line: 308 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u28
                [3] = u52
            --]]
            if not u26 or u28 == u52 then
                if p62.UserInputType == Enum.UserInputType.MouseButton1 or p62.UserInputType == Enum.UserInputType.Touch then
                    u52.state.isOpened:set(not u52.state.isOpened.value)
                end
            end
        end)
        local v63 = Instance.new("TextLabel")
        v63.Name = "TextLabel"
        v63.Size = UDim2.fromOffset(0, v53)
        v63.AutomaticSize = Enum.AutomaticSize.X
        v63.BackgroundTransparency = 1
        v63.BorderSizePixel = 0
        v63.ZIndex = u52.ZIndex + 5
        v63.LayoutOrder = u52.ZIndex + 5
        u2.applyTextStyle(v63)
        v63.Parent = v54
        local v64 = Instance.new("ScrollingFrame")
        v64.Name = "ChildContainer"
        v64.BackgroundColor3 = u1._config.WindowBgColor
        v64.BackgroundTransparency = u1._config.WindowBgTransparency
        v64.BorderSizePixel = 0
        v64.AutomaticCanvasSize = Enum.AutomaticSize.Y
        v64.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency
        v64.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor
        v64.ScrollBarThickness = u1._config.ScrollbarSize
        v64.CanvasSize = UDim2.fromScale(0, 0)
        v64.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        v64.ZIndex = u52.ZIndex + 6
        v64.LayoutOrder = u52.ZIndex + 6
        v64.ClipsDescendants = true
        u2.UIStroke(v64, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency)
        u2.UIPadding(v64, Vector2.new(2, 2 * u1._config.FramePadding.Y))
        u2.UIListLayout(v64, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
        local v65 = u1._rootInstance
        if v65 then
            v65 = u1._rootInstance:WaitForChild("PopupScreenGui")
        end
        v64.Parent = v65
        u52.ChildContainer = v64
        return v54
    end
    function v46.Update(p66) --[[ Line: 365 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v67 = p66.Instance
        local v68 = v67.PreviewContainer
        local v69 = v68.PreviewLabel
        local v70 = v68.DropdownButton
        v67.TextLabel.Text = p66.arguments.Text or "Combo"
        if p66.arguments.NoButton then
            v70.Visible = false
            v69.Size = UDim2.new(1, 0, 0, 0)
        else
            v70.Visible = true
            local v71 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
            v69.Size = UDim2.new(1, -v71, 0, 0)
        end
        if p66.arguments.NoPreview then
            v69.Visible = false
            v68.Size = UDim2.new(0, 0, 0, 0)
            v68.AutomaticSize = Enum.AutomaticSize.X
        else
            v69.Visible = true
            v68.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0))
            v68.AutomaticSize = Enum.AutomaticSize.Y
        end
    end
    function v46.ChildAdded(p72, p73) --[[ Line: 393 ]]
        --[[
        Upvalues:
            [1] = u39
        --]]
        if p73.type == "Selectable" then
            p72.ComboChildrenHeight = p72.ComboChildrenHeight + 1
        else
            p72.ComboChildrenHeight = p72.ComboChildrenHeight + 10
        end
        u39(p72)
        return p72.ChildContainer
    end
    function v46.ChildDiscarded(p74, p75) --[[ Line: 403 ]]
        if p75.type == "Selectable" then
            p74.ComboChildrenHeight = p74.ComboChildrenHeight - 1
        else
            p74.ComboChildrenHeight = p74.ComboChildrenHeight - 10
        end
    end
    function v46.GenerateState(u76) --[[ Line: 410 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if u76.state.index == nil then
            u76.state.index = u1._widgetState(u76, "index", "No Selection")
        end
        u76.state.index:onChange(function() --[[ Line: 414 ]]
            --[[
            Upvalues:
                [1] = u76
            --]]
            if u76.state.isOpened.value then
                u76.state.isOpened:set(false)
            end
        end)
        if u76.state.isOpened == nil then
            u76.state.isOpened = u1._widgetState(u76, "isOpened", false)
        end
    end
    function v46.UpdateState(p77) --[[ Line: 423 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u28
            [3] = u27
            [4] = u1
            [5] = u2
            [6] = u39
        --]]
        local v78 = p77.Instance.PreviewContainer
        local v79 = v78.PreviewLabel
        local v80 = v78.DropdownButton.Dropdown
        local v81 = p77.ChildContainer
        if p77.state.isOpened.value then
            u26 = true
            u28 = p77
            u27 = u1._cycleTick
            p77.lastOpenedTick = u1._cycleTick + 1
            v80.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE
            v81.Visible = true
            u39(p77)
        else
            if u26 then
                u26 = false
                u28 = nil
                p77.lastClosedTick = u1._cycleTick + 1
            end
            v80.Image = u2.ICONS.DOWN_POINTING_TRIANGLE
            v81.Visible = false
        end
        local v82 = p77.state.index.value
        local v83
        if typeof(v82) == "EnumItem" then
            v83 = v82.Name
        else
            v83 = tostring(v82)
        end
        v79.Text = v83
    end
    function v46.Discard(p84) --[[ Line: 455 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p84.Instance:Destroy()
        u2.discardState(p84)
    end
    v45("Combo", v46)
end