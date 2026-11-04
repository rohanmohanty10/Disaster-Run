 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local u3 = false
    local u4 = nil
    local u5 = {}
    local function u9(p6) --[[ Line: 8 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u1
            [3] = u3
            [4] = u4
        --]]
        for v7 = #u5, p6 and p6 + 1 or 1, -1 do
            local v8 = u5[v7]
            v8.state.isOpened:set(false)
            v8.Instance.BackgroundColor3 = u1._config.HeaderColor
            v8.Instance.BackgroundTransparency = 1
            table.remove(u5, v7)
        end
        if #u5 == 0 then
            u3 = false
            u4 = nil
        end
    end
    local function u27(p10) --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v11 = p10.parentWidget.type == "Menu"
        local v12 = p10.Instance
        local v13 = p10.ChildContainer
        local v14 = UDim2.fromOffset
        local v15 = v13.AbsoluteSize.X
        local v16 = v12.AbsoluteSize.X
        local v17 = math.max(v15, v16)
        local v18 = v13.AbsoluteSize.Y
        local v19 = v12.AbsoluteSize.Y
        v13.Size = v14(v17, (math.max(v18, v19)))
        if v13.Parent ~= nil then
            local v20 = v12.AbsolutePosition
            local v21 = v12.AbsoluteSize
            local v22 = v13.AbsoluteSize
            local v23 = u1._config.PopupBorderSize
            local v24 = v13.Parent.AbsoluteSize
            local v25 = v20.X + v23
            if p10.parentWidget.type == "Menu" then
                if v20.X + v22.X > v24.X then
                    v25 = v20.X - v23 - (v11 and (v22.X or 0) or 0)
                else
                    v25 = v20.X + v23 + (v11 and (v21.X or 0) or 0)
                end
            end
            local v26
            if v20.Y + v22.Y > v24.Y then
                v26 = v20.Y - v23 - v22.Y + (v11 and v21.Y or 0)
            else
                v26 = v20.Y + v23 + (v11 and 0 or v21.Y)
            end
            v13.Position = UDim2.fromOffset(v25, v26)
        end
    end
    u2.UserInputService.InputBegan:Connect(function(p28) --[[ Line: 62 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u5
            [5] = u9
        --]]
        if p28.UserInputType ~= Enum.UserInputType.MouseButton1 and p28.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return
        end
        if u3 == false then
            return
        end
        if u4 == nil then
            return
        end
        local v29 = u2.getMouseLocation()
        local v30 = false
        for _, v31 in u5 do
            for _, v32 in { v31.ChildContainer, v31.Instance } do
                local v33 = v32.AbsolutePosition
                local v34 = v33 + v32.AbsoluteSize
                if u2.isPosInsideRect(v29, v33, v34) then
                    v30 = true
                    break
                end
            end
        end
        if not v30 then
            u9()
        end
    end)
    u1.WidgetConstructor("MenuBar", {
        ["hasState"] = false,
        ["hasChildren"] = true,
        ["Args"] = {},
        ["Events"] = {},
        ["Generate"] = function(p35) --[[ Name: Generate, Line 97 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            local v36 = Instance.new("Frame")
            v36.Name = "MenuBar"
            v36.Size = UDim2.fromScale(1, 0)
            v36.AutomaticSize = Enum.AutomaticSize.Y
            v36.BackgroundColor3 = u1._config.MenubarBgColor
            v36.BackgroundTransparency = u1._config.MenubarBgTransparency
            v36.BorderSizePixel = 0
            v36.ZIndex = p35.ZIndex
            v36.LayoutOrder = p35.ZIndex
            v36.ClipsDescendants = true
            u2.UIPadding(v36, Vector2.new(u1._config.ItemSpacing.X, 2))
            u2.UIListLayout(v36, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center
            return v36
        end,
        ["Update"] = function(p37) --[[ Name: Update, Line 114 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local u38 = p37.parentWidget
            if u38.type == "Window" then
                local v39 = u38.Instance
                if v39 then
                    v39 = u38.Instance:FindFirstChild("WindowButton")
                end
                if v39 then
                    p37.Instance.Parent = v39
                    local u40 = #u1._postCycleCallbacks + 1
                    local u41 = u1._cycleTick + 1
                    u1._postCycleCallbacks[u40] = function() --[[ Line: 125 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u41
                            [3] = u38
                            [4] = u40
                        --]]
                        if u1._cycleTick == u41 then
                            u1._widgets.Window.Update(u38)
                            u1._postCycleCallbacks[u40] = nil
                        end
                    end
                end
                return
            elseif u38.type ~= "Root" then
                error("The MenuBar was not created directly under a window or root.")
            end
        end,
        ["ChildAdded"] = function(p42) --[[ Name: ChildAdded, Line 139 ]]
            return p42.Instance
        end,
        ["Discard"] = function(p43) --[[ Name: Discard, Line 142 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v44 = p43.parentWidget
            p43.Instance:Destroy()
            u1._widgets.Window.Update(v44)
        end
    })
    local v45 = u1.WidgetConstructor
    local v46 = {
        ["hasState"] = true,
        ["hasChildren"] = true,
        ["Args"] = {
            ["Text"] = 1
        }
    }
    local v51 = {
        ["clicked"] = u2.EVENTS.click(function(p47) --[[ Line: 157 ]]
            return p47.Instance
        end),
        ["hovered"] = u2.EVENTS.hover(function(p48) --[[ Line: 160 ]]
            return p48.Instance
        end),
        ["opened"] = {
            ["Init"] = function(_) --[[ Line: 164 ]] end,
            ["Get"] = function(p49) --[[ Line: 165 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p49.lastOpenedTick == u1._cycleTick
            end
        },
        ["closed"] = {
            ["Init"] = function(_) --[[ Line: 170 ]] end,
            ["Get"] = function(p50) --[[ Line: 171 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p50.lastClosedTick == u1._cycleTick
            end
        }
    }
    v46.Events = v51
    function v46.Generate(u52) --[[ Line: 176 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u5
            [4] = u3
            [5] = u4
            [6] = u9
        --]]
        u52.ButtonColors = {
            ["ButtonColor"] = u1._config.HeaderColor,
            ["ButtonTransparency"] = 1,
            ["ButtonHoveredColor"] = u1._config.HeaderHoveredColor,
            ["ButtonHoveredTransparency"] = u1._config.HeaderHoveredTransparency,
            ["ButtonActiveColor"] = u1._config.HeaderHoveredColor,
            ["ButtonActiveTransparency"] = u1._config.HeaderHoveredTransparency
        }
        local v53
        if u52.parentWidget.type == "Menu" then
            v53 = Instance.new("TextButton")
            v53.Name = "Menu"
            v53.BackgroundColor3 = u1._config.HeaderColor
            v53.BackgroundTransparency = 1
            v53.BorderSizePixel = 0
            v53.Size = UDim2.fromScale(1, 0)
            v53.Text = ""
            v53.AutomaticSize = Enum.AutomaticSize.Y
            v53.ZIndex = u52.ZIndex
            v53.LayoutOrder = u52.ZIndex
            v53.AutoButtonColor = false
            local v54 = u2.UIPadding(v53, u1._config.FramePadding)
            v54.PaddingTop = v54.PaddingTop - UDim.new(0, 1)
            u2.UIListLayout(v53, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
            local v55 = Instance.new("TextLabel")
            v55.Name = "TextLabel"
            v55.AnchorPoint = Vector2.new(0, 0)
            v55.BackgroundTransparency = 1
            v55.BorderSizePixel = 0
            v55.ZIndex = u52.ZIndex + 2
            v55.LayoutOrder = u52.ZIndex + 2
            v55.AutomaticSize = Enum.AutomaticSize.XY
            u2.applyTextStyle(v55)
            v55.Parent = v53
            local v56 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
            local v57 = v56 * 0.2
            local v58 = v56 - math.round(v57) * 2
            local v59 = Instance.new("ImageLabel")
            v59.Name = "Icon"
            v59.Size = UDim2.fromOffset(v58, v58)
            v59.BackgroundTransparency = 1
            v59.BorderSizePixel = 0
            v59.ImageColor3 = u1._config.TextColor
            v59.ImageTransparency = u1._config.TextTransparency
            v59.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE
            v59.ZIndex = u52.ZIndex + 3
            v59.LayoutOrder = u52.ZIndex + 3
            v59.Parent = v53
        else
            v53 = Instance.new("TextButton")
            v53.Name = "Menu"
            v53.Size = UDim2.fromScale(0, 0)
            v53.AutomaticSize = Enum.AutomaticSize.XY
            v53.BackgroundColor3 = u1._config.HeaderColor
            v53.BackgroundTransparency = 1
            v53.BorderSizePixel = 0
            v53.Text = ""
            v53.LayoutOrder = u52.ZIndex
            v53.ZIndex = u52.ZIndex
            v53.AutoButtonColor = false
            v53.ClipsDescendants = true
            u2.applyTextStyle(v53)
            u2.UIPadding(v53, Vector2.new(u1._config.ItemSpacing.X, u1._config.FramePadding.Y))
        end
        u2.applyInteractionHighlights(v53, v53, u52.ButtonColors)
        v53.MouseButton1Click:Connect(function() --[[ Line: 252 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u52
                [3] = u3
                [4] = u4
            --]]
            local v60 = #u5 > 1 and true or not u52.state.isOpened.value
            u52.state.isOpened:set(v60)
            u3 = v60
            u4 = v60 and u52 or nil
            if #u5 <= 1 then
                if v60 then
                    local v61 = u5
                    local v62 = u52
                    table.insert(v61, v62)
                    return
                end
                table.remove(u5)
            end
        end)
        v53.MouseEnter:Connect(function() --[[ Line: 267 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
                [3] = u52
                [4] = u5
                [5] = u9
            --]]
            if u3 and (u4 and u4 ~= u52) then
                local v63 = u52.parentWidget
                u9((table.find(u5, v63)))
                u52.state.isOpened:set(true)
                u4 = u52
                u3 = true
                local v64 = u5
                local v65 = u52
                table.insert(v64, v65)
            end
        end)
        local v66 = Instance.new("ScrollingFrame")
        v66.Name = "ChildContainer"
        v66.BackgroundColor3 = u1._config.WindowBgColor
        v66.BackgroundTransparency = u1._config.WindowBgTransparency
        v66.BorderSizePixel = 0
        v66.Size = UDim2.fromOffset(0, 0)
        v66.AutomaticSize = Enum.AutomaticSize.XY
        v66.AutomaticCanvasSize = Enum.AutomaticSize.Y
        v66.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency
        v66.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor
        v66.ScrollBarThickness = u1._config.ScrollbarSize
        v66.CanvasSize = UDim2.fromScale(0, 0)
        v66.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        v66.ZIndex = u52.ZIndex + 6
        v66.LayoutOrder = u52.ZIndex + 6
        v66.ClipsDescendants = true
        u2.UIListLayout(v66, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top
        local v67 = u1._rootInstance
        if v67 then
            v67 = u1._rootInstance:FindFirstChild("PopupScreenGui")
        end
        v66.Parent = v67
        u52.ChildContainer = v66
        u2.UIStroke(v66, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency)
        u2.UIPadding(v66, Vector2.new(2, u1._config.WindowPadding.Y - u1._config.ItemSpacing.Y))
        return v53
    end
    function v46.Update(p68) --[[ Line: 316 ]]
        local v69 = p68.Instance
        if p68.parentWidget.type == "Menu" then
            v69 = v69.TextLabel
        end
        v69.Text = p68.arguments.Text or "Menu"
    end
    function v46.ChildAdded(p70, _) --[[ Line: 326 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        u27(p70)
        return p70.ChildContainer
    end
    function v46.ChildDiscarded(p71, _) --[[ Line: 330 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        u27(p71)
    end
    function v46.GenerateState(p72) --[[ Line: 333 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p72.state.isOpened == nil then
            p72.state.isOpened = u1._widgetState(p72, "isOpened", false)
        end
    end
    function v46.UpdateState(p73) --[[ Line: 338 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u27
        --]]
        local v74 = p73.ChildContainer
        if p73.state.isOpened.value then
            p73.lastOpenedTick = u1._cycleTick + 1
            p73.ButtonColors.ButtonTransparency = u1._config.HeaderTransparency
            v74.Visible = true
            u27(p73)
        else
            p73.lastClosedTick = u1._cycleTick + 1
            p73.ButtonColors.ButtonTransparency = 1
            v74.Visible = false
        end
    end
    function v46.Discard(p75) --[[ Line: 353 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p75.Instance:Destroy()
        u2.discardState(p75)
    end
    v45("Menu", v46)
    local v76 = u1.WidgetConstructor
    local v90 = {
        ["hasState"] = false,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1,
            ["KeyCode"] = 2,
            ["ModifierKey"] = 3
        },
        ["Events"] = {
            ["clicked"] = u2.EVENTS.click(function(p77) --[[ Line: 368 ]]
                return p77.Instance
            end),
            ["hovered"] = u2.EVENTS.hover(function(p78) --[[ Line: 371 ]]
                return p78.Instance
            end)
        },
        ["Generate"] = function(u79) --[[ Name: Generate, Line 375 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
                [3] = u9
                [4] = u3
                [5] = u4
                [6] = u5
            --]]
            local v80 = Instance.new("TextButton")
            v80.Name = "MenuItem"
            v80.BackgroundTransparency = 1
            v80.BorderSizePixel = 0
            v80.Size = UDim2.fromScale(1, 0)
            v80.Text = ""
            v80.AutomaticSize = Enum.AutomaticSize.Y
            v80.ZIndex = u79.ZIndex
            v80.LayoutOrder = u79.ZIndex
            v80.AutoButtonColor = false
            local v81 = u2.UIPadding(v80, u1._config.FramePadding)
            v81.PaddingTop = v81.PaddingTop - UDim.new(0, 1)
            u2.UIListLayout(v80, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X))
            u2.applyInteractionHighlights(v80, v80, {
                ["ButtonColor"] = u1._config.HeaderColor,
                ["ButtonTransparency"] = 1,
                ["ButtonHoveredColor"] = u1._config.HeaderHoveredColor,
                ["ButtonHoveredTransparency"] = u1._config.HeaderHoveredTransparency,
                ["ButtonActiveColor"] = u1._config.HeaderHoveredColor,
                ["ButtonActiveTransparency"] = u1._config.HeaderHoveredTransparency
            })
            v80.MouseButton1Click:Connect(function() --[[ Line: 400 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9()
            end)
            v80.MouseEnter:Connect(function() --[[ Line: 404 ]]
                --[[
                Upvalues:
                    [1] = u79
                    [2] = u3
                    [3] = u4
                    [4] = u5
                    [5] = u9
                --]]
                local v82 = u79.parentWidget
                if u3 and (u4 and u4 ~= v82) then
                    u9((table.find(u5, v82)))
                    u4 = v82
                    u3 = true
                end
            end)
            local v83 = Instance.new("TextLabel")
            v83.Name = "TextLabel"
            v83.AnchorPoint = Vector2.new(0, 0)
            v83.BackgroundTransparency = 1
            v83.BorderSizePixel = 0
            v83.ZIndex = u79.ZIndex + 2
            v83.LayoutOrder = u79.ZIndex + 2
            v83.AutomaticSize = Enum.AutomaticSize.XY
            u2.applyTextStyle(v83)
            v83.Parent = v80
            local v84 = Instance.new("TextLabel")
            v84.Name = "Shortcut"
            v84.AnchorPoint = Vector2.new(0, 0)
            v84.BackgroundTransparency = 1
            v84.BorderSizePixel = 0
            v84.ZIndex = u79.ZIndex + 3
            v84.LayoutOrder = u79.ZIndex + 3
            v84.AutomaticSize = Enum.AutomaticSize.XY
            u2.applyTextStyle(v84)
            v84.Text = ""
            v84.TextColor3 = u1._config.TextDisabledColor
            v84.TextTransparency = u1._config.TextDisabledTransparency
            v84.Parent = v80
            return v80
        end,
        ["Update"] = function(p85) --[[ Name: Update, Line 447 ]]
            local v86 = p85.Instance
            local v87 = v86.TextLabel
            local v88 = v86.Shortcut
            v87.Text = p85.arguments.Text
            if p85.arguments.KeyCode then
                v88.Text = p85.arguments.ModifierKey.Name .. " + " .. p85.arguments.KeyCode.Name
            end
        end,
        ["Discard"] = function(p89) --[[ Name: Discard, Line 457 ]]
            p89.Instance:Destroy()
        end
    }
    v76("MenuItem", v90)
    local v91 = u1.WidgetConstructor
    local v92 = {
        ["hasState"] = true,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1,
            ["KeyCode"] = 2,
            ["ModifierKey"] = 3
        }
    }
    local v96 = {
        ["checked"] = {
            ["Init"] = function(_) --[[ Line: 472 ]] end,
            ["Get"] = function(p93) --[[ Line: 473 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p93.lastCheckedTick == u1._cycleTick
            end
        },
        ["unchecked"] = {
            ["Init"] = function(_) --[[ Line: 478 ]] end,
            ["Get"] = function(p94) --[[ Line: 479 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p94.lastUncheckedTick == u1._cycleTick
            end
        },
        ["hovered"] = u2.EVENTS.hover(function(p95) --[[ Line: 483 ]]
            return p95.Instance
        end)
    }
    v92.Events = v96
    function v92.Generate(u97) --[[ Line: 487 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
            [3] = u9
            [4] = u3
            [5] = u4
            [6] = u5
        --]]
        local v98 = Instance.new("TextButton")
        v98.Name = "MenuItem"
        v98.BackgroundTransparency = 1
        v98.BorderSizePixel = 0
        v98.Size = UDim2.fromScale(1, 0)
        v98.Text = ""
        v98.AutomaticSize = Enum.AutomaticSize.Y
        v98.ZIndex = u97.ZIndex
        v98.LayoutOrder = u97.ZIndex
        v98.AutoButtonColor = false
        local v99 = u2.UIPadding(v98, u1._config.FramePadding)
        v99.PaddingTop = v99.PaddingTop - UDim.new(0, 1)
        u2.UIListLayout(v98, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center
        u2.applyInteractionHighlights(v98, v98, {
            ["ButtonColor"] = u1._config.HeaderColor,
            ["ButtonTransparency"] = 1,
            ["ButtonHoveredColor"] = u1._config.HeaderHoveredColor,
            ["ButtonHoveredTransparency"] = u1._config.HeaderHoveredTransparency,
            ["ButtonActiveColor"] = u1._config.HeaderHoveredColor,
            ["ButtonActiveTransparency"] = u1._config.HeaderHoveredTransparency
        })
        v98.MouseButton1Click:Connect(function() --[[ Line: 512 ]]
            --[[
            Upvalues:
                [1] = u97
                [2] = u9
            --]]
            local v100 = u97.state.isChecked.value
            u97.state.isChecked:set(not v100)
            u9()
        end)
        v98.MouseEnter:Connect(function() --[[ Line: 518 ]]
            --[[
            Upvalues:
                [1] = u97
                [2] = u3
                [3] = u4
                [4] = u5
                [5] = u9
            --]]
            local v101 = u97.parentWidget
            if u3 and (u4 and u4 ~= v101) then
                u9((table.find(u5, v101)))
                u4 = v101
                u3 = true
            end
        end)
        local v102 = Instance.new("TextLabel")
        v102.Name = "TextLabel"
        v102.AnchorPoint = Vector2.new(0, 0)
        v102.BackgroundTransparency = 1
        v102.BorderSizePixel = 0
        v102.ZIndex = u97.ZIndex + 2
        v102.LayoutOrder = u97.ZIndex + 2
        v102.AutomaticSize = Enum.AutomaticSize.XY
        u2.applyTextStyle(v102)
        v102.Parent = v98
        local v103 = Instance.new("TextLabel")
        v103.Name = "Shortcut"
        v103.AnchorPoint = Vector2.new(0, 0)
        v103.BackgroundTransparency = 1
        v103.BorderSizePixel = 0
        v103.ZIndex = u97.ZIndex + 3
        v103.LayoutOrder = u97.ZIndex + 3
        v103.AutomaticSize = Enum.AutomaticSize.XY
        u2.applyTextStyle(v103)
        v103.Text = ""
        v103.TextColor3 = u1._config.TextDisabledColor
        v103.TextTransparency = u1._config.TextDisabledTransparency
        v103.Parent = v98
        local v104 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
        local v105 = v104 * 0.2
        local v106 = v104 - math.round(v105) * 2
        local v107 = Instance.new("ImageLabel")
        v107.Name = "Icon"
        v107.Size = UDim2.fromOffset(v106, v106)
        v107.BackgroundTransparency = 1
        v107.BorderSizePixel = 0
        v107.ImageColor3 = u1._config.TextColor
        v107.ImageTransparency = u1._config.TextTransparency
        v107.Image = u2.ICONS.CHECK_MARK
        v107.ZIndex = u97.ZIndex + 4
        v107.LayoutOrder = u97.ZIndex + 4
        v107.Parent = v98
        return v98
    end
    function v92.GenerateState(p108) --[[ Line: 578 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p108.state.isChecked == nil then
            p108.state.isChecked = u1._widgetState(p108, "isChecked", false)
        end
    end
    function v92.Update(p109) --[[ Line: 583 ]]
        local v110 = p109.Instance
        local v111 = v110.TextLabel
        local v112 = v110.Shortcut
        v111.Text = p109.arguments.Text
        if p109.arguments.KeyCode then
            v112.Text = p109.arguments.ModifierKey.Name .. " + " .. p109.arguments.KeyCode.Name
        end
    end
    function v92.UpdateState(p113) --[[ Line: 593 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v114 = p113.Instance.Icon
        if p113.state.isChecked.value then
            v114.Image = u2.ICONS.CHECK_MARK
            p113.lastCheckedTick = u1._cycleTick + 1
        else
            v114.Image = ""
            p113.lastUncheckedTick = u1._cycleTick + 1
        end
    end
    function v92.Discard(p115) --[[ Line: 605 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p115.Instance:Destroy()
        u2.discardState(p115)
    end
    v91("MenuToggle", v92)
end