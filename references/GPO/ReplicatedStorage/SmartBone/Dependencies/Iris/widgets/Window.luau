 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local function u7() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if u1._rootInstance == nil then
            return
        else
            local v3 = u1._rootInstance:FindFirstChild("PopupScreenGui")
            if v3 then
                local v4 = v3.TooltipContainer
                local v5 = u2.getMouseLocation()
                local v6 = u2.findBestWindowPosForPopup(v5, v4.AbsoluteSize, u1._config.DisplaySafeAreaPadding, v3.AbsoluteSize)
                v4.Position = UDim2.fromOffset(v6.X, v6.Y)
            end
        end
    end
    u2.UserInputService.InputChanged:Connect(u7)
    local v14 = {
        ["hasState"] = false,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1
        },
        ["Events"] = {},
        ["Generate"] = function(p8) --[[ Name: Generate, Line 32 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            p8.parentWidget = u1._rootWidget
            local v9 = Instance.new("Frame")
            v9.Name = "Iris_Tooltip"
            v9.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0))
            v9.AutomaticSize = Enum.AutomaticSize.Y
            v9.BorderSizePixel = 0
            v9.BackgroundTransparency = 1
            v9.ZIndex = p8.ZIndex + 1
            v9.LayoutOrder = p8.ZIndex + 1
            local v10 = Instance.new("TextLabel")
            v10.Name = "TooltipText"
            v10.Size = UDim2.fromOffset(0, 0)
            v10.AutomaticSize = Enum.AutomaticSize.XY
            v10.BackgroundColor3 = u1._config.WindowBgColor
            v10.BackgroundTransparency = u1._config.WindowBgTransparency
            v10.BorderSizePixel = u1._config.PopupBorderSize
            v10.TextWrapped = true
            v10.ZIndex = p8.ZIndex + 1
            v10.LayoutOrder = p8.ZIndex + 1
            u2.applyTextStyle(v10)
            u2.UIStroke(v10, u1._config.WindowBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency)
            u2.UIPadding(v10, u1._config.WindowPadding)
            if u1._config.PopupRounding > 0 then
                u2.UICorner(v10, u1._config.PopupRounding)
            end
            v10.Parent = v9
            return v9
        end,
        ["Update"] = function(p11) --[[ Name: Update, Line 66 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            local v12 = p11.Instance.TooltipText
            if p11.arguments.Text == nil then
                error("Iris.Text Text Argument is required", 5)
            end
            v12.Text = p11.arguments.Text
            u7()
        end,
        ["Discard"] = function(p13) --[[ Name: Discard, Line 75 ]]
            p13.Instance:Destroy()
        end
    }
    u1.WidgetConstructor("Tooltip", v14)
    local u15 = 0
    local u16 = nil
    local u17 = false
    local u18 = nil
    local u19 = nil
    local u20 = false
    local u21 = false
    local u22 = false
    local u23 = Enum.TopBottom.Top
    local u24 = Enum.LeftRight.Left
    local u25 = nil
    local u26 = nil
    local u27 = false
    local u28 = {}
    local function u33() --[[ Line: 99 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u28
        --]]
        if u1._config.UseScreenGUIs ~= false then
            local v29 = 65535
            local v30 = nil
            for _, v31 in u28 do
                if v31.state.isOpened.value and (not v31.arguments.NoNav and v31.Instance:IsA("ScreenGui")) then
                    local v32 = v31.Instance.DisplayOrder
                    if v32 < v29 then
                        v30 = v31
                        v29 = v32
                    end
                end
            end
            if v30.state.isUncollapsed.value == false then
                v30.state.isUncollapsed:set(true)
            end
            u1.SetFocusedWindow(v30)
        end
    end
    local function u49(p34, p35) --[[ Line: 126 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v36 = Vector2.new(p34.state.position.value.X, p34.state.position.value.Y)
        local v37 = (u1._config.TextSize + u1._config.FramePadding.Y * 2) * 2
        local v38 = u2.getScreenSizeForWindow(p34)
        local v39 = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y)
        local v40 = v38 - v36 - v39
        local v41 = Vector2.new
        local v42 = p35.X
        local v43 = v40.X
        local v44 = math.max(v43, v37)
        local v45 = math.clamp(v42, v37, v44)
        local v46 = p35.Y
        local v47 = v40.Y
        local v48 = math.max(v47, v37)
        return v41(v45, (math.clamp(v46, v37, v48)))
    end
    local function u67(p50, p51) --[[ Line: 142 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v52 = p50.Instance
        local v53 = u2.getScreenSizeForWindow(p50)
        local v54 = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y)
        local v55 = Vector2.new
        local v56 = p51.X
        local v57 = v54.X
        local v58 = v54.X
        local v59 = v53.X - v52.WindowButton.AbsoluteSize.X - v54.X
        local v60 = math.max(v58, v59)
        local v61 = math.clamp(v56, v57, v60)
        local v62 = p51.Y
        local v63 = v54.Y
        local v64 = v54.Y
        local v65 = v53.Y - v52.WindowButton.AbsoluteSize.Y - v54.Y
        local v66 = math.max(v64, v65)
        return v55(v61, (math.clamp(v62, v63, v66)))
    end
    function u1.SetFocusedWindow(p68) --[[ Line: 164 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u27
            [3] = u28
            [4] = u1
            [5] = u15
            [6] = u2
        --]]
        if u26 ~= p68 then
            if u27 and u26 ~= nil then
                if u28[u26.ID] then
                    local v69 = u26.Instance.WindowButton
                    local v70 = v69.TitleBar
                    if u26.state.isUncollapsed.value then
                        v70.BackgroundColor3 = u1._config.TitleBgColor
                        v70.BackgroundTransparency = u1._config.TitleBgTransparency
                    else
                        v70.BackgroundColor3 = u1._config.TitleBgCollapsedColor
                        v70.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency
                    end
                    v69.UIStroke.Color = u1._config.BorderColor
                end
                u27 = false
                u26 = nil
            end
            if p68 ~= nil then
                u27 = true
                u26 = p68
                local v71 = p68.Instance
                local v72 = v71.WindowButton
                local v73 = v72.TitleBar
                v73.BackgroundColor3 = u1._config.TitleBgActiveColor
                v73.BackgroundTransparency = u1._config.TitleBgActiveTransparency
                v72.UIStroke.Color = u1._config.BorderActiveColor
                u15 = u15 + 1
                if p68.usesScreenGUI then
                    v71.DisplayOrder = u15 + u1._config.DisplayOrderOffset
                end
                if p68.state.isUncollapsed.value == false then
                    p68.state.isUncollapsed:set(true)
                end
                if u2.GuiService.SelectedObject then
                    if v73.Visible then
                        u2.GuiService:Select(v73)
                        return
                    end
                    u2.GuiService:Select(v71.ChildContainer)
                end
            end
        end
    end
    u2.UserInputService.InputBegan:Connect(function(p74, p75) --[[ Line: 221 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u33
            [4] = u21
            [5] = u22
            [6] = u27
            [7] = u26
            [8] = u23
            [9] = u24
            [10] = u20
            [11] = u19
        --]]
        if not p75 and p74.UserInputType == Enum.UserInputType.MouseButton1 then
            u1.SetFocusedWindow(nil)
        end
        if p74.KeyCode == Enum.KeyCode.Tab and (u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
            u33()
        end
        if p74.UserInputType == Enum.UserInputType.MouseButton1 and (u21 and (not u22 and (u27 and u26))) then
            local v76 = u26.state.position.value + u26.state.size.value * 0.5
            local v77 = u2.getMouseLocation() - v76
            local v78 = v77.X
            local v79 = math.abs(v78) * u26.state.size.value.Y
            local v80 = v77.Y
            if math.abs(v80) * u26.state.size.value.X <= v79 then
                u23 = Enum.TopBottom.Center
                local v81 = v77.X
                local v82
                if math.sign(v81) == -1 then
                    v82 = Enum.LeftRight.Left
                else
                    v82 = Enum.LeftRight.Right
                end
                u24 = v82
            else
                u24 = Enum.LeftRight.Center
                local v83 = v77.Y
                local v84
                if math.sign(v83) == -1 then
                    v84 = Enum.TopBottom.Top
                else
                    v84 = Enum.TopBottom.Bottom
                end
                u23 = v84
            end
            u20 = true
            u19 = u26
        end
    end)
    u2.UserInputService.TouchTapInWorld:Connect(function(_, p85) --[[ Line: 252 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if not p85 then
            u1.SetFocusedWindow(nil)
        end
    end)
    u2.UserInputService.InputChanged:Connect(function(p86) --[[ Line: 258 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u16
            [3] = u2
            [4] = u18
            [5] = u67
            [6] = u20
            [7] = u19
            [8] = u25
            [9] = u24
            [10] = u23
            [11] = u49
        --]]
        if u17 and u16 then
            local v87
            if p86.UserInputType == Enum.UserInputType.Touch then
                local v88 = p86.Position
                v87 = Vector2.new(v88.X, v88.Y)
            else
                v87 = u2.getMouseLocation()
            end
            local v89 = u16.Instance.WindowButton
            local v90 = u67(u16, v87 - u18)
            v89.Position = UDim2.fromOffset(v90.X, v90.Y)
            u16.state.position.value = v90
        end
        if u20 and (u19 and u19.arguments.NoResize ~= true) then
            local v91 = u19.Instance.WindowButton
            local v92 = Vector2.new(v91.Position.X.Offset, v91.Position.Y.Offset)
            local v93 = Vector2.new(v91.Size.X.Offset, v91.Size.Y.Offset)
            local v94
            if p86.UserInputType == Enum.UserInputType.Touch then
                v94 = p86.Delta
            else
                v94 = u2.getMouseLocation() - u25
            end
            local v95 = v92 + Vector2.new(u24 ~= Enum.LeftRight.Left and 0 or v94.X, u23 ~= Enum.TopBottom.Top and 0 or v94.Y)
            local v96 = Vector2.new
            local v97
            if u24 == Enum.LeftRight.Left then
                v97 = -v94.X
            else
                v97 = u24 ~= Enum.LeftRight.Right and 0 or v94.X
            end
            local v98
            if u23 == Enum.TopBottom.Top then
                v98 = -v94.Y
            else
                v98 = u23 ~= Enum.TopBottom.Bottom and 0 or v94.Y
            end
            local v99 = u49(u19, v93 + v96(v97, v98))
            local v100 = u67(u19, v95)
            v91.Size = UDim2.fromOffset(v99.X, v99.Y)
            u19.state.size.value = v99
            v91.Position = UDim2.fromOffset(v100.X, v100.Y)
            u19.state.position.value = v100
        end
        u25 = u2.getMouseLocation()
    end)
    u2.UserInputService.InputEnded:Connect(function(p101, _) --[[ Line: 319 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u16
            [3] = u20
            [4] = u19
            [5] = u33
        --]]
        if (p101.UserInputType == Enum.UserInputType.MouseButton1 or p101.UserInputType == Enum.UserInputType.Touch) and (u17 and u16) then
            local v102 = u16.Instance.WindowButton
            u17 = false
            u16.state.position:set(Vector2.new(v102.Position.X.Offset, v102.Position.Y.Offset))
        end
        if (p101.UserInputType == Enum.UserInputType.MouseButton1 or p101.UserInputType == Enum.UserInputType.Touch) and (u20 and u19) then
            local v103 = u19.Instance
            u20 = false
            u19.state.size:set(v103.WindowButton.AbsoluteSize)
        end
        if p101.KeyCode == Enum.KeyCode.ButtonX then
            u33()
        end
    end)
    local v104 = u1.WidgetConstructor
    local v105 = {
        ["hasState"] = true,
        ["hasChildren"] = true,
        ["Args"] = {
            ["Title"] = 1,
            ["NoTitleBar"] = 2,
            ["NoBackground"] = 3,
            ["NoCollapse"] = 4,
            ["NoClose"] = 5,
            ["NoMove"] = 6,
            ["NoScrollbar"] = 7,
            ["NoResize"] = 8,
            ["NoNav"] = 9,
            ["NoMenu"] = 10
        }
    }
    local v111 = {
        ["closed"] = {
            ["Init"] = function(_) --[[ Line: 362 ]] end,
            ["Get"] = function(p106) --[[ Line: 363 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p106.lastClosedTick == u1._cycleTick
            end
        },
        ["opened"] = {
            ["Init"] = function(_) --[[ Line: 368 ]] end,
            ["Get"] = function(p107) --[[ Line: 369 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p107.lastOpenedTick == u1._cycleTick
            end
        },
        ["collapsed"] = {
            ["Init"] = function(_) --[[ Line: 374 ]] end,
            ["Get"] = function(p108) --[[ Line: 375 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p108.lastCollapsedTick == u1._cycleTick
            end
        },
        ["uncollapsed"] = {
            ["Init"] = function(_) --[[ Line: 380 ]] end,
            ["Get"] = function(p109) --[[ Line: 381 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p109.lastUncollapsedTick == u1._cycleTick
            end
        },
        ["hovered"] = u2.EVENTS.hover(function(p110) --[[ Line: 385 ]]
            return p110.Instance.WindowButton
        end)
    }
    v105.Events = v111
    function v105.Generate(u112) --[[ Line: 390 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u28
            [3] = u2
            [4] = u16
            [5] = u17
            [6] = u18
            [7] = u27
            [8] = u26
            [9] = u20
            [10] = u23
            [11] = u24
            [12] = u19
            [13] = u21
            [14] = u22
        --]]
        u112.parentWidget = u1._rootWidget
        u112.usesScreenGUI = u1._config.UseScreenGUIs
        u28[u112.ID] = u112
        local v113
        if u112.usesScreenGUI then
            v113 = Instance.new("ScreenGui")
            v113.ResetOnSpawn = false
            v113.DisplayOrder = u1._config.DisplayOrderOffset
            v113.IgnoreGuiInset = u1._config.IgnoreGuiInset
        else
            v113 = Instance.new("Folder")
        end
        v113.Name = "Iris_Window"
        local v114 = Instance.new("TextButton")
        v114.Name = "WindowButton"
        v114.Size = UDim2.fromOffset(0, 0)
        v114.BackgroundTransparency = 1
        v114.BorderSizePixel = 0
        v114.Text = ""
        v114.ClipsDescendants = false
        v114.AutoButtonColor = false
        v114.Selectable = false
        v114.SelectionImageObject = u1.SelectionImageObject
        v114.ZIndex = u112.ZIndex + 1
        v114.LayoutOrder = u112.ZIndex + 1
        v114.SelectionGroup = true
        v114.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        v114.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        v114.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
        v114.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        u2.UIStroke(v114, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency)
        v114.Parent = v113
        v114.InputBegan:Connect(function(p115) --[[ Line: 430 ]]
            --[[
            Upvalues:
                [1] = u112
                [2] = u1
                [3] = u16
                [4] = u17
                [5] = u18
                [6] = u2
            --]]
            if p115.UserInputType ~= Enum.UserInputType.MouseMovement and p115.UserInputType ~= Enum.UserInputType.Keyboard then
                if u112.state.isUncollapsed.value then
                    u1.SetFocusedWindow(u112)
                end
                if not u112.arguments.NoMove and p115.UserInputType == Enum.UserInputType.MouseButton1 then
                    u16 = u112
                    u17 = true
                    u18 = u2.getMouseLocation() - u112.state.position.value
                end
            end
        end)
        local u116 = Instance.new("ScrollingFrame")
        u116.Name = "ChildContainer"
        u116.Size = UDim2.fromScale(1, 1)
        u116.Position = UDim2.fromOffset(0, 0)
        u116.BackgroundColor3 = u1._config.WindowBgColor
        u116.BackgroundTransparency = u1._config.WindowBgTransparency
        u116.BorderSizePixel = 0
        u116.AutomaticCanvasSize = Enum.AutomaticSize.Y
        u116.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency
        u116.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor
        u116.CanvasSize = UDim2.fromScale(0, 1)
        u116.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        u116.ZIndex = u112.ZIndex + 3
        u116.LayoutOrder = u112.ZIndex + 3
        u116.ClipsDescendants = true
        u2.UIPadding(u116, u1._config.WindowPadding)
        u116.Parent = v114
        u116:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 466 ]]
            --[[
            Upvalues:
                [1] = u112
                [2] = u116
            --]]
            u112.state.scrollDistance.value = u116.CanvasPosition.Y
        end)
        u116.InputBegan:Connect(function(p117) --[[ Line: 471 ]]
            --[[
            Upvalues:
                [1] = u112
                [2] = u1
            --]]
            if p117.UserInputType ~= Enum.UserInputType.MouseMovement and p117.UserInputType ~= Enum.UserInputType.Keyboard then
                if u112.state.isUncollapsed.value then
                    u1.SetFocusedWindow(u112)
                end
            end
        end)
        local v118 = Instance.new("Frame")
        v118.Name = "TerminatingFrame"
        v118.Size = UDim2.fromOffset(0, u1._config.WindowPadding.Y + u1._config.FramePadding.Y)
        v118.BackgroundTransparency = 1
        v118.BorderSizePixel = 0
        v118.LayoutOrder = 2147483632
        u2.UIListLayout(u116, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top
        v118.Parent = u116
        local v119 = Instance.new("Frame")
        v119.Name = "TitleBar"
        v119.Size = UDim2.fromScale(1, 0)
        v119.AutomaticSize = Enum.AutomaticSize.Y
        v119.BorderSizePixel = 0
        v119.ZIndex = u112.ZIndex + 1
        v119.LayoutOrder = u112.ZIndex + 1
        v119.ClipsDescendants = true
        v119.Parent = v114
        v119.InputBegan:Connect(function(p120) --[[ Line: 504 ]]
            --[[
            Upvalues:
                [1] = u112
                [2] = u16
                [3] = u17
                [4] = u18
            --]]
            if p120.UserInputType == Enum.UserInputType.Touch and not u112.arguments.NoMove then
                u16 = u112
                u17 = true
                local v121 = p120.Position
                u18 = Vector2.new(v121.X, v121.Y) - u112.state.position.value
            end
        end)
        local v122 = u1._config.TextSize + (u1._config.FramePadding.Y - 1) * 2
        local v123 = Instance.new("TextButton")
        v123.Name = "CollapseButton"
        v123.AnchorPoint = Vector2.new(0, 0.5)
        v123.Size = UDim2.fromOffset(v122, v122)
        v123.Position = UDim2.new(0, u1._config.FramePadding.X + 1, 0.5, 0)
        v123.AutomaticSize = Enum.AutomaticSize.None
        v123.BackgroundTransparency = 1
        v123.BorderSizePixel = 0
        v123.AutoButtonColor = false
        v123.Text = ""
        v123.ZIndex = u112.ZIndex + 4
        u2.UICorner(v123)
        v123.Parent = v119
        v123.MouseButton1Click:Connect(function() --[[ Line: 533 ]]
            --[[
            Upvalues:
                [1] = u112
            --]]
            u112.state.isUncollapsed:set(not u112.state.isUncollapsed.value)
        end)
        u2.applyInteractionHighlights(v123, v123, {
            ["ButtonColor"] = u1._config.ButtonColor,
            ["ButtonTransparency"] = 1,
            ["ButtonHoveredColor"] = u1._config.ButtonHoveredColor,
            ["ButtonHoveredTransparency"] = u1._config.ButtonHoveredTransparency,
            ["ButtonActiveColor"] = u1._config.ButtonActiveColor,
            ["ButtonActiveTransparency"] = u1._config.ButtonActiveTransparency
        })
        local v124 = Instance.new("ImageLabel")
        v124.Name = "Arrow"
        v124.AnchorPoint = Vector2.new(0.5, 0.5)
        local v125 = UDim2.fromOffset
        local v126 = v122 * 0.7
        local v127 = math.floor(v126)
        local v128 = v122 * 0.7
        v124.Size = v125(v127, (math.floor(v128)))
        v124.Position = UDim2.fromScale(0.5, 0.5)
        v124.BackgroundTransparency = 1
        v124.BorderSizePixel = 0
        v124.Image = u2.ICONS.MULTIPLICATION_SIGN
        v124.ImageColor3 = u1._config.TextColor
        v124.ImageTransparency = u1._config.TextTransparency
        v124.ZIndex = u112.ZIndex + 5
        v124.Parent = v123
        local v129 = Instance.new("TextButton")
        v129.Name = "CloseButton"
        v129.AnchorPoint = Vector2.new(1, 0.5)
        v129.Size = UDim2.fromOffset(v122, v122)
        v129.Position = UDim2.new(1, -(u1._config.FramePadding.X + 1), 0.5, 0)
        v129.AutomaticSize = Enum.AutomaticSize.None
        v129.BackgroundTransparency = 1
        v129.BorderSizePixel = 0
        v129.Text = ""
        v129.ZIndex = u112.ZIndex + 4
        v129.AutoButtonColor = false
        u2.UICorner(v129)
        v129.MouseButton1Click:Connect(function() --[[ Line: 574 ]]
            --[[
            Upvalues:
                [1] = u112
            --]]
            u112.state.isOpened:set(false)
        end)
        u2.applyInteractionHighlights(v129, v129, {
            ["ButtonColor"] = u1._config.ButtonColor,
            ["ButtonTransparency"] = 1,
            ["ButtonHoveredColor"] = u1._config.ButtonHoveredColor,
            ["ButtonHoveredTransparency"] = u1._config.ButtonHoveredTransparency,
            ["ButtonActiveColor"] = u1._config.ButtonActiveColor,
            ["ButtonActiveTransparency"] = u1._config.ButtonActiveTransparency
        })
        v129.Parent = v119
        local v130 = Instance.new("ImageLabel")
        v130.Name = "Icon"
        v130.AnchorPoint = Vector2.new(0.5, 0.5)
        local v131 = UDim2.fromOffset
        local v132 = v122 * 0.7
        local v133 = math.floor(v132)
        local v134 = v122 * 0.7
        v130.Size = v131(v133, (math.floor(v134)))
        v130.Position = UDim2.fromScale(0.5, 0.5)
        v130.BackgroundTransparency = 1
        v130.BorderSizePixel = 0
        v130.Image = u2.ICONS.MULTIPLICATION_SIGN
        v130.ImageColor3 = u1._config.TextColor
        v130.ImageTransparency = u1._config.TextTransparency
        v130.ZIndex = u112.ZIndex + 5
        v130.Parent = v129
        local v135 = u1._config.WindowTitleAlign == Enum.LeftRight.Left and 0 or (u1._config.WindowTitleAlign == Enum.LeftRight.Center and 0.5 or 1)
        local v136 = Instance.new("TextLabel")
        v136.Name = "Title"
        v136.AnchorPoint = Vector2.new(v135, 0)
        v136.Position = UDim2.fromScale(v135, 0)
        v136.AutomaticSize = Enum.AutomaticSize.XY
        v136.BorderSizePixel = 0
        v136.BackgroundTransparency = 1
        v136.ZIndex = u112.ZIndex + 3
        u2.applyTextStyle(v136)
        u2.UIPadding(v136, u1._config.FramePadding)
        v136.Parent = v119
        local v137 = u1._config.TextSize + u1._config.FramePadding.X
        local v138 = Instance.new("TextButton")
        v138.Name = "ResizeGrip"
        v138.AnchorPoint = Vector2.new(1, 1)
        v138.Size = UDim2.fromOffset(v137, v137)
        v138.Position = UDim2.fromScale(1, 1)
        v138.AutoButtonColor = false
        v138.BorderSizePixel = 0
        v138.BackgroundTransparency = 1
        v138.Text = u2.ICONS.BOTTOM_RIGHT_CORNER
        v138.TextSize = v137
        v138.TextColor3 = u1._config.ButtonColor
        v138.TextTransparency = u1._config.ButtonTransparency
        v138.LineHeight = 1.1
        v138.Selectable = false
        v138.ZIndex = u112.ZIndex + 3
        v138.Parent = v114
        u2.applyTextInteractionHighlights(v138, v138, {
            ["ButtonColor"] = u1._config.ButtonColor,
            ["ButtonTransparency"] = u1._config.ButtonTransparency,
            ["ButtonHoveredColor"] = u1._config.ButtonHoveredColor,
            ["ButtonHoveredTransparency"] = u1._config.ButtonHoveredTransparency,
            ["ButtonActiveColor"] = u1._config.ButtonActiveColor,
            ["ButtonActiveTransparency"] = u1._config.ButtonActiveTransparency
        })
        v138.MouseButton1Down:Connect(function() --[[ Line: 655 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u26
                [3] = u112
                [4] = u1
                [5] = u20
                [6] = u23
                [7] = u24
                [8] = u19
            --]]
            if not u27 or u26 ~= u112 then
                u1.SetFocusedWindow(u112)
            end
            u20 = true
            u23 = Enum.TopBottom.Bottom
            u24 = Enum.LeftRight.Right
            u19 = u112
        end)
        local v139 = Instance.new("TextButton")
        v139.Name = "ResizeBorder"
        v139.Size = UDim2.new(1, u1._config.WindowResizePadding.X * 2, 1, u1._config.WindowResizePadding.Y * 2)
        v139.Position = UDim2.fromOffset(-u1._config.WindowResizePadding.X, -u1._config.WindowResizePadding.Y)
        v139.BackgroundTransparency = 1
        v139.BorderSizePixel = 0
        v139.Text = ""
        v139.AutoButtonColor = false
        v139.Active = true
        v139.Selectable = false
        v139.ZIndex = u112.ZIndex
        v139.LayoutOrder = u112.ZIndex
        v139.ClipsDescendants = false
        v139.Parent = v114
        v139.MouseEnter:Connect(function() --[[ Line: 681 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u112
                [3] = u21
            --]]
            if u26 == u112 then
                u21 = true
            end
        end)
        v139.MouseLeave:Connect(function() --[[ Line: 686 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u112
                [3] = u21
            --]]
            if u26 == u112 then
                u21 = false
            end
        end)
        v114.MouseEnter:Connect(function() --[[ Line: 692 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u112
                [3] = u22
            --]]
            if u26 == u112 then
                u22 = true
            end
        end)
        v114.MouseLeave:Connect(function() --[[ Line: 697 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u112
                [3] = u22
            --]]
            if u26 == u112 then
                u22 = false
            end
        end)
        return v113
    end
    function v105.Update(p140) --[[ Line: 705 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v141 = p140.Instance.WindowButton
        local v142 = v141.TitleBar
        local v143 = v142.Title
        local v144 = v141:FindFirstChild("MenuBar")
        local v145 = v141.ChildContainer
        local v146 = v141.ResizeGrip
        local v147 = 0
        local v148 = 0
        if p140.arguments.NoResize == true then
            v146.Visible = false
        else
            v146.Visible = true
        end
        if p140.arguments.NoScrollbar then
            v145.ScrollBarThickness = 0
        else
            v145.ScrollBarThickness = u1._config.ScrollbarSize
        end
        if p140.arguments.NoTitleBar then
            v142.Visible = false
        else
            v142.Visible = true
            local v149 = v142.AbsoluteSize.Y
            v147 = v147 + v149
            v148 = v148 + v149
        end
        if v144 then
            if p140.arguments.NoMenu then
                v144.Visible = false
            else
                v144.Visible = true
                v147 = v147 + v144.AbsoluteSize.Y
            end
            v144.Position = UDim2.fromOffset(0, v148)
        end
        if p140.arguments.NoBackground then
            v145.BackgroundTransparency = 1
        else
            v145.BackgroundTransparency = u1._config.WindowBgTransparency
        end
        local v150 = u1._config.FramePadding.X + u1._config.TextSize + u1._config.FramePadding.X * 2
        if p140.arguments.NoCollapse then
            v142.CollapseButton.Visible = false
            v142.Title.UIPadding.PaddingLeft = UDim.new(0, u1._config.FramePadding.X)
        else
            v142.CollapseButton.Visible = true
            v142.Title.UIPadding.PaddingLeft = UDim.new(0, v150)
        end
        if p140.arguments.NoClose then
            v142.CloseButton.Visible = false
            v142.Title.UIPadding.PaddingRight = UDim.new(0, u1._config.FramePadding.X)
        else
            v142.CloseButton.Visible = true
            v142.Title.UIPadding.PaddingRight = UDim.new(0, v150)
        end
        v145.Size = UDim2.new(1, 0, 1, -v147)
        v145.CanvasSize = UDim2.new(0, 0, 1, -v147)
        v145.Position = UDim2.fromOffset(0, v147)
        v143.Text = p140.arguments.Title or ""
    end
    function v105.Discard(p151) --[[ Line: 775 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u27
            [3] = u16
            [4] = u17
            [5] = u19
            [6] = u20
            [7] = u28
            [8] = u2
        --]]
        if u26 == p151 then
            u26 = nil
            u27 = false
        end
        if u16 == p151 then
            u16 = nil
            u17 = false
        end
        if u19 == p151 then
            u19 = nil
            u20 = false
        end
        u28[p151.ID] = nil
        p151.Instance:Destroy()
        u2.discardState(p151)
    end
    function v105.ChildAdded(p152) --[[ Line: 792 ]]
        return p152.Instance.WindowButton.ChildContainer
    end
    function v105.UpdateState(p153) --[[ Line: 797 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v154 = p153.state.size.value
        local v155 = p153.state.position.value
        local v156 = p153.state.isUncollapsed.value
        local v157 = p153.state.isOpened.value
        local u158 = p153.state.scrollDistance.value
        local v159 = p153.Instance
        local v160 = v159.WindowButton
        local v161 = v160.TitleBar
        local u162 = v160.ChildContainer
        local v163 = v160.ResizeGrip
        v160.Size = UDim2.fromOffset(v154.X, v154.Y)
        v160.Position = UDim2.fromOffset(v155.X, v155.Y)
        if v157 then
            if p153.usesScreenGUI then
                v159.Enabled = true
                v160.Visible = true
            else
                v160.Visible = true
            end
            p153.lastOpenedTick = u1._cycleTick + 1
        else
            if p153.usesScreenGUI then
                v159.Enabled = false
                v160.Visible = false
            else
                v160.Visible = false
            end
            p153.lastClosedTick = u1._cycleTick + 1
        end
        if v156 then
            v161.CollapseButton.Arrow.Image = u2.ICONS.DOWN_POINTING_TRIANGLE
            u162.Visible = true
            if p153.arguments.NoResize ~= true then
                v163.Visible = true
            end
            v160.AutomaticSize = Enum.AutomaticSize.None
            p153.lastUncollapsedTick = u1._cycleTick + 1
        else
            local v164 = v161.AbsoluteSize.Y
            v161.CollapseButton.Arrow.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE
            u162.Visible = false
            v163.Visible = false
            v160.Size = UDim2.fromOffset(v154.X, v164)
            p153.lastCollapsedTick = u1._cycleTick + 1
        end
        if v157 and v156 then
            u1.SetFocusedWindow(p153)
        else
            v161.BackgroundColor3 = u1._config.TitleBgCollapsedColor
            v161.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency
            v160.UIStroke.Color = u1._config.BorderColor
            u1.SetFocusedWindow(nil)
        end
        if u158 and u158 ~= 0 then
            local u165 = #u1._postCycleCallbacks + 1
            local u166 = u1._cycleTick + 1
            u1._postCycleCallbacks[u165] = function() --[[ Line: 863 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u166
                    [3] = u162
                    [4] = u158
                    [5] = u165
                --]]
                if u1._cycleTick == u166 then
                    u162.CanvasPosition = Vector2.new(0, u158)
                    u1._postCycleCallbacks[u165] = nil
                end
            end
        end
    end
    function v105.GenerateState(p167) --[[ Line: 871 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u27
            [3] = u26
            [4] = u67
            [5] = u49
        --]]
        if p167.state.size == nil then
            p167.state.size = u1._widgetState(p167, "size", Vector2.new(400, 300))
        end
        if p167.state.position == nil then
            local v168 = p167.state
            local v169 = u1._widgetState
            local v170 = "position"
            local v171
            if u27 and u26 then
                v171 = u26.state.position.value + Vector2.new(15, 45)
            else
                v171 = Vector2.new(150, 250)
            end
            v168.position = v169(p167, v170, v171)
        end
        p167.state.position.value = u67(p167, p167.state.position.value)
        p167.state.size.value = u49(p167, p167.state.size.value)
        if p167.state.isUncollapsed == nil then
            p167.state.isUncollapsed = u1._widgetState(p167, "isUncollapsed", true)
        end
        if p167.state.isOpened == nil then
            p167.state.isOpened = u1._widgetState(p167, "isOpened", true)
        end
        if p167.state.scrollDistance == nil then
            p167.state.scrollDistance = u1._widgetState(p167, "scrollDistance", 0)
        end
    end
    v104("Window", v105)
end