 

require(script.Parent.Types)
local u1 = {}
return function(u2) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.GuiService = game:GetService("GuiService")
    u1.RunService = game:GetService("RunService")
    u1.UserInputService = game:GetService("UserInputService")
    u1.ContextActionService = game:GetService("ContextActionService")
    u1.TextService = game:GetService("TextService")
    u1.ICONS = {
        ["RIGHT_POINTING_TRIANGLE"] = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
        ["DOWN_POINTING_TRIANGLE"] = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
        ["MULTIPLICATION_SIGN"] = "rbxasset://textures/AnimationEditor/icon_close.png",
        ["BOTTOM_RIGHT_CORNER"] = "\226\151\162",
        ["CHECK_MARK"] = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
        ["ALPHA_BACKGROUND_TEXTURE"] = "rbxasset://textures/meshPartFallback.png"
    }
    u1.GuiInset = u1.GuiService:GetGuiInset()
    u1.IS_STUDIO = u1.RunService:IsStudio()
    function u1.getTime() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if u1.IS_STUDIO then
            return os.clock()
        else
            return time()
        end
    end
    function u1.getMouseLocation() --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1.UserInputService:GetMouseLocation() - u1.GuiInset
    end
    function u1.findBestWindowPosForPopup(p3, p4, p5, p6) --[[ Line: 37 ]]
        local v7
        if p3.X + p4.X + 20 > p6.X then
            if p3.Y + p4.Y + 20 > p6.Y then
                v7 = p3 + Vector2.new(0, -(20 + p4.Y))
            else
                v7 = p3 + Vector2.new(0, 20)
            end
        else
            v7 = p3 + Vector2.new(20, 0)
        end
        local v8 = Vector2.new
        local v9 = v7.X + p4.X
        local v10 = p6.X
        local v11 = math.min(v9, v10) - p4.X
        local v12 = p5.X
        local v13 = math.max(v11, v12)
        local v14 = v7.Y + p4.Y
        local v15 = p6.Y
        local v16 = math.min(v14, v15) - p4.Y
        local v17 = p5.Y
        return v8(v13, (math.max(v16, v17)))
    end
    function u1.isPosInsideRect(p18, p19, p20) --[[ Line: 57 ]]
        local v21
        if p18.X > p19.X and (p18.X < p20.X and p18.Y > p19.Y) then
            v21 = p18.Y < p20.Y
        else
            v21 = false
        end
        return v21
    end
    function u1.extend(p22, p23) --[[ Line: 61 ]]
        local v24 = table.clone(p22)
        for v25, v26 in p23 do
            v24[v25] = v26
        end
        return v24
    end
    function u1.UIPadding(p27, p28) --[[ Line: 69 ]]
        local v29 = Instance.new("UIPadding")
        v29.PaddingLeft = UDim.new(0, p28.X)
        v29.PaddingRight = UDim.new(0, p28.X)
        v29.PaddingTop = UDim.new(0, p28.Y)
        v29.PaddingBottom = UDim.new(0, p28.Y)
        v29.Parent = p27
        return v29
    end
    function u1.UIListLayout(p30, p31, p32) --[[ Line: 79 ]]
        local v33 = Instance.new("UIListLayout")
        v33.SortOrder = Enum.SortOrder.LayoutOrder
        v33.Padding = p32
        v33.FillDirection = p31
        v33.Parent = p30
        return v33
    end
    function u1.UIStroke(p34, p35, p36, p37) --[[ Line: 88 ]]
        local v38 = Instance.new("UIStroke")
        v38.Thickness = p35
        v38.Color = p36
        v38.Transparency = p37
        v38.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        v38.LineJoinMode = Enum.LineJoinMode.Round
        v38.Parent = p34
        return v38
    end
    function u1.UICorner(p39, p40) --[[ Line: 99 ]]
        local v41 = Instance.new("UICorner")
        v41.CornerRadius = UDim.new(p40 and 0 or 1, p40 or 0)
        v41.Parent = p39
        return v41
    end
    function u1.UISizeConstraint(p42, p43, p44) --[[ Line: 106 ]]
        local v45 = Instance.new("UISizeConstraint")
        v45.MinSize = p43 or v45.MinSize
        v45.MaxSize = p44 or v45.MaxSize
        v45.Parent = p42
        return v45
    end
    function u1.UIReference(p46, p47, p48) --[[ Line: 114 ]]
        local v49 = Instance.new("ObjectValue")
        v49.Name = p48
        v49.Value = p47
        v49.Parent = p46
        return v49
    end
    function u1.getScreenSizeForWindow(p50) --[[ Line: 123 ]]
        if p50.usesScreenGUI then
            return p50.Instance.AbsoluteSize
        else
            local v51 = p50.Instance.Parent
            if v51:IsA("GuiBase2d") then
                return v51.AbsoluteSize
            elseif v51.Parent:IsA("GuiBase2d") then
                return v51.AbsoluteSize
            else
                return workspace.CurrentCamera.ViewportSize
            end
        end
    end
    local u52 = Instance.new("GetTextBoundsParams")
    u52.Font = u2._config.TextFont
    u52.Size = u2._config.TextSize
    u52.Width = (1 / 0)
    function u1.calculateTextSize(p53, p54) --[[ Line: 148 ]]
        --[[
        Upvalues:
            [1] = u52
            [2] = u1
        --]]
        if p54 then
            u52.Width = p54
        end
        u52.Text = p53
        local v55 = u1.TextService:GetTextBoundsAsync(u52)
        if p54 then
            u52.Width = (1 / 0)
        end
        return v55
    end
    function u1.applyTextStyle(p56) --[[ Line: 163 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p56.FontFace = u2._config.TextFont
        p56.TextSize = u2._config.TextSize
        p56.TextColor3 = u2._config.TextColor
        p56.TextTransparency = u2._config.TextTransparency
        p56.TextXAlignment = Enum.TextXAlignment.Left
        p56.AutoLocalize = false
        p56.RichText = false
    end
    function u1.applyInteractionHighlights(p57, u58, u59) --[[ Line: 174 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local u60 = false
        p57.MouseEnter:Connect(function() --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u59
                [3] = u60
            --]]
            u58.BackgroundColor3 = u59.ButtonHoveredColor
            u58.BackgroundTransparency = u59.ButtonHoveredTransparency
            u60 = false
        end)
        p57.MouseLeave:Connect(function() --[[ Line: 183 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u59
                [3] = u60
            --]]
            u58.BackgroundColor3 = u59.ButtonColor
            u58.BackgroundTransparency = u59.ButtonTransparency
            u60 = true
        end)
        p57.InputBegan:Connect(function(p61) --[[ Line: 190 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u59
            --]]
            if p61.UserInputType == Enum.UserInputType.MouseButton1 or p61.UserInputType == Enum.UserInputType.Gamepad1 then
                u58.BackgroundColor3 = u59.ButtonActiveColor
                u58.BackgroundTransparency = u59.ButtonActiveTransparency
            end
        end)
        p57.InputEnded:Connect(function(p62) --[[ Line: 198 ]]
            --[[
            Upvalues:
                [1] = u60
                [2] = u58
                [3] = u59
            --]]
            if (p62.UserInputType == Enum.UserInputType.MouseButton1 or p62.UserInputType == Enum.UserInputType.Gamepad1) and not u60 then
                if p62.UserInputType == Enum.UserInputType.MouseButton1 then
                    u58.BackgroundColor3 = u59.ButtonHoveredColor
                    u58.BackgroundTransparency = u59.ButtonHoveredTransparency
                end
                if p62.UserInputType == Enum.UserInputType.Gamepad1 then
                    u58.BackgroundColor3 = u59.ButtonColor
                    u58.BackgroundTransparency = u59.ButtonTransparency
                end
            end
        end)
        p57.SelectionImageObject = u2.SelectionImageObject
    end
    function u1.applyInteractionHighlightsWithMultiHighlightee(p63, u64) --[[ Line: 215 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local u65 = false
        p63.MouseEnter:Connect(function() --[[ Line: 217 ]]
            --[[
            Upvalues:
                [1] = u64
                [2] = u65
            --]]
            for _, v66 in u64 do
                v66[1].BackgroundColor3 = v66[2].ButtonHoveredColor
                v66[1].BackgroundTransparency = v66[2].ButtonHoveredTransparency
                u65 = false
            end
        end)
        p63.MouseLeave:Connect(function() --[[ Line: 226 ]]
            --[[
            Upvalues:
                [1] = u64
                [2] = u65
            --]]
            for _, v67 in u64 do
                v67[1].BackgroundColor3 = v67[2].ButtonColor
                v67[1].BackgroundTransparency = v67[2].ButtonTransparency
                u65 = true
            end
        end)
        p63.InputBegan:Connect(function(p68) --[[ Line: 235 ]]
            --[[
            Upvalues:
                [1] = u64
            --]]
            if p68.UserInputType == Enum.UserInputType.MouseButton1 or p68.UserInputType == Enum.UserInputType.Gamepad1 then
                for _, v69 in u64 do
                    v69[1].BackgroundColor3 = v69[2].ButtonActiveColor
                    v69[1].BackgroundTransparency = v69[2].ButtonActiveTransparency
                end
            end
        end)
        p63.InputEnded:Connect(function(p70) --[[ Line: 245 ]]
            --[[
            Upvalues:
                [1] = u65
                [2] = u64
            --]]
            if (p70.UserInputType == Enum.UserInputType.MouseButton1 or p70.UserInputType == Enum.UserInputType.Gamepad1) and not u65 then
                for _, v71 in u64 do
                    if p70.UserInputType == Enum.UserInputType.MouseButton1 then
                        v71[1].BackgroundColor3 = v71[2].ButtonHoveredColor
                        v71[1].BackgroundTransparency = v71[2].ButtonHoveredTransparency
                    end
                    if p70.UserInputType == Enum.UserInputType.Gamepad1 then
                        v71[1].BackgroundColor3 = v71[2].ButtonColor
                        v71[1].BackgroundTransparency = v71[2].ButtonTransparency
                    end
                end
            end
        end)
        p63.SelectionImageObject = u2.SelectionImageObject
    end
    function u1.applyTextInteractionHighlights(p72, u73, u74) --[[ Line: 264 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local u75 = false
        p72.MouseEnter:Connect(function() --[[ Line: 266 ]]
            --[[
            Upvalues:
                [1] = u73
                [2] = u74
                [3] = u75
            --]]
            u73.TextColor3 = u74.ButtonHoveredColor
            u73.TextTransparency = u74.ButtonHoveredTransparency
            u75 = false
        end)
        p72.MouseLeave:Connect(function() --[[ Line: 273 ]]
            --[[
            Upvalues:
                [1] = u73
                [2] = u74
                [3] = u75
            --]]
            u73.TextColor3 = u74.ButtonColor
            u73.TextTransparency = u74.ButtonTransparency
            u75 = true
        end)
        p72.InputBegan:Connect(function(p76) --[[ Line: 280 ]]
            --[[
            Upvalues:
                [1] = u73
                [2] = u74
            --]]
            if p76.UserInputType == Enum.UserInputType.MouseButton1 or p76.UserInputType == Enum.UserInputType.Gamepad1 then
                u73.TextColor3 = u74.ButtonActiveColor
                u73.TextTransparency = u74.ButtonActiveTransparency
            end
        end)
        p72.InputEnded:Connect(function(p77) --[[ Line: 288 ]]
            --[[
            Upvalues:
                [1] = u75
                [2] = u73
                [3] = u74
            --]]
            if (p77.UserInputType == Enum.UserInputType.MouseButton1 or p77.UserInputType == Enum.UserInputType.Gamepad1) and not u75 then
                if p77.UserInputType == Enum.UserInputType.MouseButton1 then
                    u73.TextColor3 = u74.ButtonHoveredColor
                    u73.TextTransparency = u74.ButtonHoveredTransparency
                end
                if p77.UserInputType == Enum.UserInputType.Gamepad1 then
                    u73.TextColor3 = u74.ButtonColor
                    u73.TextTransparency = u74.ButtonTransparency
                end
            end
        end)
        p72.SelectionImageObject = u2.SelectionImageObject
    end
    function u1.applyFrameStyle(p78, p79, p80) --[[ Line: 305 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v81 = u2._config.FramePadding
        local v82 = u2._config.FrameBorderSize
        local v83 = u2._config.BorderColor
        local v84 = u2._config.ButtonTransparency
        local v85 = u2._config.FrameRounding
        if v82 > 0 and v85 > 0 then
            p78.BorderSizePixel = 0
            local v86 = Instance.new("UIStroke")
            v86.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            v86.LineJoinMode = Enum.LineJoinMode.Round
            v86.Transparency = v84
            v86.Thickness = v82
            v86.Color = v83
            u1.UICorner(p78, v85)
            v86.Parent = p78
            if not p79 then
                u1.UIPadding(p78, u2._config.FramePadding)
                return
            end
        elseif v82 < 1 and v85 > 0 then
            p78.BorderSizePixel = 0
            u1.UICorner(p78, v85)
            if not p79 then
                u1.UIPadding(p78, u2._config.FramePadding)
                return
            end
        elseif v85 < 1 then
            p78.BorderSizePixel = v82
            p78.BorderColor3 = v83
            p78.BorderMode = Enum.BorderMode.Inset
            if not p79 then
                u1.UIPadding(p78, v81 - Vector2.new(v82, v82))
                return
            end
            if not p80 then
                u1.UIPadding(p78, -Vector2.new(v82, v82))
            end
        end
    end
    function u1.discardState(p87) --[[ Line: 350 ]]
        for _, v88 in p87.state do
            v88.ConnectedWidgets[p87.ID] = nil
        end
    end
    u1.EVENTS = {
        ["hover"] = function(u89) --[[ Name: hover, Line 357 ]]
            return {
                ["Init"] = function(u90) --[[ Line: 359 ]]
                    --[[
                    Upvalues:
                        [1] = u89
                    --]]
                    local v91 = u89(u90)
                    v91.MouseEnter:Connect(function() --[[ Line: 361 ]]
                        --[[
                        Upvalues:
                            [1] = u90
                        --]]
                        u90.isHoveredEvent = true
                    end)
                    v91.MouseLeave:Connect(function() --[[ Line: 364 ]]
                        --[[
                        Upvalues:
                            [1] = u90
                        --]]
                        u90.isHoveredEvent = false
                    end)
                    u90.isHoveredEvent = false
                end,
                ["Get"] = function(p92) --[[ Line: 369 ]]
                    return p92.isHoveredEvent
                end
            }
        end,
        ["click"] = function(u93) --[[ Name: click, Line 375 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            return {
                ["Init"] = function(u94) --[[ Line: 377 ]]
                    --[[
                    Upvalues:
                        [1] = u93
                        [2] = u2
                    --]]
                    local v95 = u93(u94)
                    u94.lastClickedTick = -1
                    v95.MouseButton1Click:Connect(function() --[[ Line: 381 ]]
                        --[[
                        Upvalues:
                            [1] = u94
                            [2] = u2
                        --]]
                        u94.lastClickedTick = u2._cycleTick + 1
                    end)
                end,
                ["Get"] = function(p96) --[[ Line: 385 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    return p96.lastClickedTick == u2._cycleTick
                end
            }
        end,
        ["rightClick"] = function(u97) --[[ Name: rightClick, Line 391 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            return {
                ["Init"] = function(u98) --[[ Line: 393 ]]
                    --[[
                    Upvalues:
                        [1] = u97
                        [2] = u2
                    --]]
                    local v99 = u97(u98)
                    u98.lastRightClickedTick = -1
                    v99.MouseButton2Click:Connect(function() --[[ Line: 397 ]]
                        --[[
                        Upvalues:
                            [1] = u98
                            [2] = u2
                        --]]
                        u98.lastRightClickedTick = u2._cycleTick + 1
                    end)
                end,
                ["Get"] = function(p100) --[[ Line: 401 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    return p100.lastRightClickedTick == u2._cycleTick
                end
            }
        end,
        ["doubleClick"] = function(u101) --[[ Name: doubleClick, Line 407 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            return {
                ["Init"] = function(u102) --[[ Line: 409 ]]
                    --[[
                    Upvalues:
                        [1] = u101
                        [2] = u1
                        [3] = u2
                    --]]
                    local v103 = u101(u102)
                    u102.lastClickedTime = -1
                    u102.lastClickedPosition = Vector2.zero
                    u102.lastDoubleClickedTick = -1
                    v103.MouseButton1Down:Connect(function(p104, p105) --[[ Line: 415 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u102
                            [3] = u2
                        --]]
                        local v106 = u1.getTime()
                        if v106 - u102.lastClickedTime < u2._config.MouseDoubleClickTime and (Vector2.new(p104, p105) - u102.lastClickedPosition).Magnitude < u2._config.MouseDoubleClickMaxDist then
                            u102.lastDoubleClickedTick = u2._cycleTick + 1
                        else
                            u102.lastClickedTime = v106
                            u102.lastClickedPosition = Vector2.new(p104, p105)
                        end
                    end)
                end,
                ["Get"] = function(p107) --[[ Line: 426 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    return p107.lastDoubleClickedTick == u2._cycleTick
                end
            }
        end,
        ["ctrlClick"] = function(u108) --[[ Name: ctrlClick, Line 432 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            return {
                ["Init"] = function(u109) --[[ Line: 434 ]]
                    --[[
                    Upvalues:
                        [1] = u108
                        [2] = u1
                        [3] = u2
                    --]]
                    local v110 = u108(u109)
                    u109.lastCtrlClickedTick = -1
                    v110.MouseButton1Click:Connect(function() --[[ Line: 438 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u109
                            [3] = u2
                        --]]
                        if u1.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u1.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                            u109.lastCtrlClickedTick = u2._cycleTick + 1
                        end
                    end)
                end,
                ["Get"] = function(p111) --[[ Line: 444 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    return p111.lastCtrlClickedTick == u2._cycleTick
                end
            }
        end,
        ["shortcut"] = function(u112) --[[ Name: shortcut, Line 450 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            return {
                ["Init"] = function(u113) --[[ Line: 452 ]]
                    --[[
                    Upvalues:
                        [1] = u112
                        [2] = u1
                        [3] = u2
                    --]]
                    local v114, u115 = u112(u113)
                    u113.lastShortcutTick = -1
                    u1.ContextActionService:BindAction(u113.ID, function(_, p116, p117) --[[ Line: 456 ]]
                        --[[
                        Upvalues:
                            [1] = u115
                            [2] = u113
                            [3] = u2
                        --]]
                        if p116 == Enum.UserInputState.Begin and p117:IsModifierKeyDown(u115) then
                            u113.lastShortcutTick = u2._cycleTick + 1
                        end
                    end, false, v114)
                end,
                ["Get"] = function(p118) --[[ Line: 464 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    return p118.lastShortcutTick == u2._cycleTick
                end
            }
        end
    }
    require(script.Root)(u2, u1)
    require(script.Window)(u2, u1)
    require(script.Menu)(u2, u1)
    require(script.Format)(u2, u1)
    require(script.Text)(u2, u1)
    require(script.Button)(u2, u1)
    require(script.Checkbox)(u2, u1)
    require(script.RadioButton)(u2, u1)
    require(script.Tree)(u2, u1)
    require(script.Input)(u2, u1)
    require(script.Combo)(u2, u1)
    require(script.Table)(u2, u1)
end