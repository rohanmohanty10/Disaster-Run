 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local u4 = {
        ["Init"] = function(_) --[[ Line: 5 ]] end,
        ["Get"] = function(p3) --[[ Line: 6 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            return p3.lastNumberChangedTick == u1._cycleTick
        end
    }
    local function u9(p5, p6, p7) --[[ Line: 11 ]]
        if typeof(p5) == "number" then
            return p5
        end
        if typeof(p5) == "Vector2" then
            if p6 == 1 then
                return p5.X
            end
            if p6 == 2 then
                return p5.Y
            end
        elseif typeof(p5) == "Vector3" then
            if p6 == 1 then
                return p5.X
            end
            if p6 == 2 then
                return p5.Y
            end
            if p6 == 3 then
                return p5.Z
            end
        elseif typeof(p5) == "UDim" then
            if p6 == 1 then
                return p5.Scale
            end
            if p6 == 2 then
                return p5.Offset
            end
        elseif typeof(p5) == "UDim2" then
            if p6 == 1 then
                return p5.X.Scale
            end
            if p6 == 2 then
                return p5.X.Offset
            end
            if p6 == 3 then
                return p5.Y.Scale
            end
            if p6 == 4 then
                return p5.Y.Offset
            end
        elseif typeof(p5) == "Color3" then
            local v8 = p7.UseHSV and { p5:ToHSV() } or { p5.R, p5.G, p5.B }
            if p6 == 1 then
                return v8[1]
            end
            if p6 == 2 then
                return v8[2]
            end
            if p6 == 3 then
                return v8[3]
            end
        elseif typeof(p5) == "Rect" then
            if p6 == 1 then
                return p5.Min.X
            end
            if p6 == 2 then
                return p5.Min.Y
            end
            if p6 == 3 then
                return p5.Max.X
            end
            if p6 == 4 then
                return p5.Max.Y
            end
        elseif typeof(p5) == "table" then
            return p5[p6]
        end
        error((("Incorrect datatype or value: %* %* %*"):format(p5, typeof(p5), p6)))
    end
    local function u23(p10, p11, p12, p13) --[[ Line: 70 ]]
        if typeof(p10) == "number" then
            return p12
        end
        if typeof(p10) == "Vector2" then
            if p11 == 1 then
                return Vector2.new(p12, p10.Y)
            end
            if p11 == 2 then
                return Vector2.new(p10.X, p12)
            end
        elseif typeof(p10) == "Vector3" then
            if p11 == 1 then
                local v14 = p10.Y
                local v15 = p10.Z
                return Vector3.new(p12, v14, v15)
            end
            if p11 == 2 then
                local v16 = p10.X
                local v17 = p10.Z
                return Vector3.new(v16, p12, v17)
            end
            if p11 == 3 then
                local v18 = p10.X
                local v19 = p10.Y
                return Vector3.new(v18, v19, p12)
            end
        elseif typeof(p10) == "UDim" then
            if p11 == 1 then
                return UDim.new(p12, p10.Offset)
            end
            if p11 == 2 then
                return UDim.new(p10.Scale, p12)
            end
        elseif typeof(p10) == "UDim2" then
            if p11 == 1 then
                return UDim2.new(UDim.new(p12, p10.X.Offset), p10.Y)
            end
            if p11 == 2 then
                return UDim2.new(UDim.new(p10.X.Scale, p12), p10.Y)
            end
            if p11 == 3 then
                return UDim2.new(p10.X, UDim.new(p12, p10.Y.Offset))
            end
            if p11 == 4 then
                return UDim2.new(p10.X, UDim.new(p10.Y.Scale, p12))
            end
        elseif typeof(p10) == "Rect" then
            if p11 == 1 then
                return Rect.new(Vector2.new(p12, p10.Min.Y), p10.Max)
            end
            if p11 == 2 then
                return Rect.new(Vector2.new(p10.Min.X, p12), p10.Max)
            end
            if p11 == 3 then
                return Rect.new(p10.Min, Vector2.new(p12, p10.Max.Y))
            end
            if p11 == 4 then
                return Rect.new(p10.Min, Vector2.new(p10.Max.X, p12))
            end
        elseif typeof(p10) == "Color3" then
            if p13.UseHSV then
                local v20, v21, v22 = p10:ToHSV()
                if p11 == 1 then
                    return Color3.fromHSV(p12, v21, v22)
                end
                if p11 == 2 then
                    return Color3.fromHSV(v20, p12, v22)
                end
                if p11 == 3 then
                    return Color3.fromHSV(v20, v21, p12)
                end
            end
            if p11 == 1 then
                return Color3.new(p12, p10.G, p10.B)
            end
            if p11 == 2 then
                return Color3.new(p10.R, p12, p10.B)
            end
            if p11 == 3 then
                return Color3.new(p10.R, p10.G, p12)
            end
        end
        error((("Incorrect datatype or value %* %* %*"):format(p10, typeof(p10), p11)))
    end
    local u24 = {
        ["Num"] = { 1 },
        ["Vector2"] = { 1, 1 },
        ["Vector3"] = { 1, 1, 1 },
        ["UDim"] = { 0.01, 1 },
        ["UDim2"] = {
            0.01,
            1,
            0.01,
            1
        },
        ["Color3"] = { 1, 1, 1 },
        ["Color4"] = {
            1,
            1,
            1,
            1
        },
        ["Rect"] = {
            1,
            1,
            1,
            1
        }
    }
    local u25 = {
        ["Num"] = { 0 },
        ["Vector2"] = { 0, 0 },
        ["Vector3"] = { 0, 0, 0 },
        ["UDim"] = { 0, 0 },
        ["UDim2"] = {
            0,
            0,
            0,
            0
        },
        ["Rect"] = {
            0,
            0,
            0,
            0
        }
    }
    local u26 = {
        ["Num"] = { 100 },
        ["Vector2"] = { 100, 100 },
        ["Vector3"] = { 100, 100, 100 },
        ["UDim"] = { 1, 960 },
        ["UDim2"] = {
            1,
            960,
            1,
            960
        },
        ["Rect"] = {
            960,
            960,
            960,
            960
        }
    }
    local u27 = {
        ["Num"] = { "" },
        ["Vector2"] = { "X: ", "Y: " },
        ["Vector3"] = { "X: ", "Y: ", "Z: " },
        ["UDim"] = { "", "" },
        ["UDim2"] = {
            "",
            "",
            "",
            ""
        },
        ["Color3_RGB"] = { "R: ", "G: ", "B: " },
        ["Color3_HSV"] = { "H: ", "S: ", "V: " },
        ["Color4_RGB"] = {
            "R: ",
            "G: ",
            "B: ",
            "T: "
        },
        ["Color4_HSV"] = {
            "H: ",
            "S: ",
            "V: ",
            "T: "
        },
        ["Rect"] = {
            "X: ",
            "Y: ",
            "X: ",
            "Y: "
        }
    }
    local u28 = {
        ["Num"] = { 0 },
        ["Vector2"] = { 0, 0 },
        ["Vector3"] = { 0, 0, 0 },
        ["UDim"] = { 3, 0 },
        ["UDim2"] = {
            3,
            0,
            3,
            0
        },
        ["Color3"] = { 0, 0, 0 },
        ["Color4"] = {
            0,
            0,
            0,
            0
        },
        ["Rect"] = {
            0,
            0,
            0,
            0
        }
    }
    local function u54(u29, p30, p31, p32) --[[ Line: 194 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u9
        --]]
        local v33 = p31 + (2 * u1._config.ItemInnerSpacing.X + p32 * 2)
        local v34 = u2.abstractButton.Generate(u29)
        v34.Name = "SubButton"
        v34.ZIndex = u29.ZIndex + 5
        v34.LayoutOrder = u29.ZIndex + 5
        v34.TextXAlignment = Enum.TextXAlignment.Center
        v34.Text = "-"
        v34.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize)
        v34.Parent = p30
        v34.MouseButton1Click:Connect(function() --[[ Line: 206 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u29
                [3] = u9
                [4] = u1
            --]]
            local v35 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
            local v36 = (u29.arguments.Increment and u9(u29.arguments.Increment, 1, u29.arguments) or 1) * (v35 and 100 or 1)
            local v37 = u29.state.number.value - v36
            if u29.arguments.Min ~= nil then
                local v38 = u9
                local v39 = u29.arguments.Min
                local v40 = u29.arguments
                v37 = math.max(v37, v38(v39, 1, v40))
            end
            if u29.arguments.Max ~= nil then
                local v41 = u9
                local v42 = u29.arguments.Max
                local v43 = u29.arguments
                v37 = math.min(v37, v41(v42, 1, v43))
            end
            u29.state.number:set(v37)
            u29.lastNumberChangedTick = u1._cycleTick + 1
        end)
        local v44 = u2.abstractButton.Generate(u29)
        v44.Name = "AddButton"
        v44.ZIndex = u29.ZIndex + 6
        v44.LayoutOrder = u29.ZIndex + 6
        v44.TextXAlignment = Enum.TextXAlignment.Center
        v44.Text = "+"
        v44.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize)
        v44.Parent = p30
        v44.MouseButton1Click:Connect(function() --[[ Line: 232 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u29
                [3] = u9
                [4] = u1
            --]]
            local v45 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
            local v46 = (u29.arguments.Increment and u9(u29.arguments.Increment, 1, u29.arguments) or 1) * (v45 and 100 or 1)
            local v47 = u29.state.number.value + v46
            if u29.arguments.Min ~= nil then
                local v48 = u9
                local v49 = u29.arguments.Min
                local v50 = u29.arguments
                v47 = math.max(v47, v48(v49, 1, v50))
            end
            if u29.arguments.Max ~= nil then
                local v51 = u9
                local v52 = u29.arguments.Max
                local v53 = u29.arguments
                v47 = math.min(v47, v51(v52, 1, v53))
            end
            u29.state.number:set(v47)
            u29.lastNumberChangedTick = u1._cycleTick + 1
        end)
        return v33
    end
    local function v107(u55, u56, u57) --[[ Line: 252 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u1
            [4] = u54
            [5] = u9
            [6] = u23
            [7] = u28
            [8] = u27
        --]]
        local v106 = {
            ["hasState"] = true,
            ["hasChildren"] = false,
            ["Args"] = {
                ["Text"] = 1,
                ["Increment"] = 2,
                ["Min"] = 3,
                ["Max"] = 4,
                ["Format"] = 5
            },
            ["Events"] = {
                ["numberChanged"] = u4,
                ["hovered"] = u2.EVENTS.hover(function(p58) --[[ Line: 265 ]]
                    return p58.Instance
                end)
            },
            ["Generate"] = function(u59) --[[ Name: Generate, Line 269 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u2
                    [3] = u1
                    [4] = u56
                    [5] = u54
                    [6] = u9
                    [7] = u23
                --]]
                local v60 = Instance.new("Frame")
                v60.Name = "Iris_Input" .. u55
                v60.Size = UDim2.fromScale(1, 0)
                v60.BackgroundTransparency = 1
                v60.BorderSizePixel = 0
                v60.ZIndex = u59.ZIndex
                v60.LayoutOrder = u59.ZIndex
                v60.AutomaticSize = Enum.AutomaticSize.Y
                u2.UIListLayout(v60, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X))
                local v61 = 0
                local v62 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
                if u56 == 1 then
                    v61 = u54(u59, v60, v61, v62)
                end
                local v63 = UDim.new(u1._config.ContentWidth.Scale / u56, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u56 - 1) - v61) / u56)
                local v64 = UDim.new(v63.Scale * (u56 - 1), v63.Offset * (u56 - 1) + u1._config.ItemInnerSpacing.X * (u56 - 1) + v61)
                local v65 = u1._config.ContentWidth - v64
                for u66 = 1, u56 do
                    local u67 = Instance.new("TextBox")
                    u67.Name = "InputField" .. tostring(u66)
                    u67.ZIndex = u59.ZIndex + u66
                    u67.LayoutOrder = u59.ZIndex + u66
                    if u66 == u56 then
                        u67.Size = UDim2.new(v65, UDim.new())
                    else
                        u67.Size = UDim2.new(v63, UDim.new())
                    end
                    u67.AutomaticSize = Enum.AutomaticSize.Y
                    u67.BackgroundColor3 = u1._config.FrameBgColor
                    u67.BackgroundTransparency = u1._config.FrameBgTransparency
                    u67.ClearTextOnFocus = false
                    u67.TextTruncate = Enum.TextTruncate.AtEnd
                    u67.ClipsDescendants = true
                    u2.applyFrameStyle(u67)
                    u2.applyTextStyle(u67)
                    u2.UISizeConstraint(u67, Vector2.new(1, 0))
                    u67.Parent = v60
                    u67.FocusLost:Connect(function() --[[ Line: 325 ]]
                        --[[
                        Upvalues:
                            [1] = u67
                            [2] = u59
                            [3] = u9
                            [4] = u66
                            [5] = u23
                            [6] = u1
                        --]]
                        local v68 = u67.Text
                        local v69 = tonumber(v68:match("-?%d*%.?%d*"))
                        if v69 ~= nil then
                            if u59.arguments.Min ~= nil then
                                local v70 = u9
                                local v71 = u59.arguments.Min
                                local v72 = u66
                                local v73 = u59.arguments
                                v69 = math.max(v69, v70(v71, v72, v73))
                            end
                            if u59.arguments.Max ~= nil then
                                local v74 = u9
                                local v75 = u59.arguments.Max
                                local v76 = u66
                                local v77 = u59.arguments
                                v69 = math.min(v69, v74(v75, v76, v77))
                            end
                            if u59.arguments.Increment then
                                local v78 = v69 / u9(u59.arguments.Increment, u66, u59.arguments)
                                v69 = math.round(v78) * u9(u59.arguments.Increment, u66, u59.arguments)
                            end
                            u59.state.number:set(u23(u59.state.number.value, u66, v69, u59.arguments))
                            u59.lastNumberChangedTick = u1._cycleTick + 1
                        end
                        local v79 = u59.arguments.Format[u66] or u59.arguments.Format[1]
                        if u59.arguments.Prefix then
                            v79 = u59.arguments.Prefix[u66] .. v79
                        end
                        u67.Text = string.format(v79, u9(u59.state.number.value, u66, u59.arguments))
                        u59.state.editingText:set(0)
                    end)
                    u67.Focused:Connect(function() --[[ Line: 352 ]]
                        --[[
                        Upvalues:
                            [1] = u67
                            [2] = u59
                            [3] = u66
                        --]]
                        u67.CursorPosition = #u67.Text + 1
                        u67.SelectionStart = 1
                        u59.state.editingText:set(u66)
                    end)
                end
                local v80 = Instance.new("TextLabel")
                v80.Name = "TextLabel"
                v80.Size = UDim2.fromOffset(0, v62)
                v80.BackgroundTransparency = 1
                v80.BorderSizePixel = 0
                v80.ZIndex = u59.ZIndex + 7
                v80.LayoutOrder = u59.ZIndex + 7
                v80.AutomaticSize = Enum.AutomaticSize.X
                u2.applyTextStyle(v80)
                v80.Parent = v60
                return v60
            end,
            ["Update"] = function(p81) --[[ Name: Update, Line 376 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u56
                    [3] = u28
                    [4] = u9
                    [5] = u27
                --]]
                local v82 = p81.Instance
                v82.TextLabel.Text = p81.arguments.Text or ("Input %*"):format(u55)
                if u56 == 1 then
                    v82.SubButton.Visible = not p81.arguments.NoButtons
                    v82.AddButton.Visible = not p81.arguments.NoButtons
                end
                if p81.arguments.Format then
                    local v83 = p81.arguments.Format
                    if typeof(v83) ~= "table" then
                        p81.arguments.Format = { p81.arguments.Format }
                        return
                    end
                end
                local v84 = {}
                for v85 = 1, u56 do
                    local v86 = u28[u55][v85]
                    if p81.arguments.Increment then
                        local v87 = u9(p81.arguments.Increment, v85, p81.arguments)
                        local v88 = v87 == 0 and 1 or v87
                        local v89 = -math.log10(v88)
                        local v90 = math.ceil(v89)
                        v86 = math.max(v86, v90, v86)
                    end
                    if p81.arguments.Max then
                        local v91 = u9(p81.arguments.Max, v85, p81.arguments)
                        local v92 = v91 == 0 and 1 or v91
                        local v93 = -math.log10(v92)
                        local v94 = math.ceil(v93)
                        v86 = math.max(v86, v94, v86)
                    end
                    if p81.arguments.Min then
                        local v95 = u9(p81.arguments.Min, v85, p81.arguments)
                        local v96 = v95 == 0 and 1 or v95
                        local v97 = -math.log10(v96)
                        local v98 = math.ceil(v97)
                        v86 = math.max(v86, v98, v86)
                    end
                    if v86 > 0 then
                        v84[v85] = ("%%.%*f"):format(v86)
                    else
                        v84[v85] = "%d"
                    end
                end
                p81.arguments.Format = v84
                p81.arguments.Prefix = u27[u55]
            end,
            ["Discard"] = function(p99) --[[ Name: Discard, Line 421 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                p99.Instance:Destroy()
                u2.discardState(p99)
            end,
            ["GenerateState"] = function(p100) --[[ Name: GenerateState, Line 425 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u57
                --]]
                if p100.state.number == nil then
                    p100.state.number = u1._widgetState(p100, "number", u57)
                end
                if p100.state.editingText == nil then
                    p100.state.editingText = u1._widgetState(p100, "editingText", 0)
                end
            end,
            ["UpdateState"] = function(p101) --[[ Name: UpdateState, Line 433 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u9
                --]]
                local v102 = p101.Instance
                for v103 = 1, u56 do
                    local v104 = v102:FindFirstChild("InputField" .. tostring(v103))
                    local v105 = p101.arguments.Format[v103] or p101.arguments.Format[1]
                    if p101.arguments.Prefix then
                        v105 = p101.arguments.Prefix[v103] .. v105
                    end
                    v104.Text = string.format(v105, u9(p101.state.number.value, v103, p101.arguments))
                end
            end
        }
        return v106
    end
    local u108 = 0
    local u109 = false
    local u110 = nil
    local u111 = 0
    local u112 = ""
    local function u126() --[[ Line: 461 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u108
            [3] = u109
            [4] = u110
            [5] = u112
            [6] = u111
            [7] = u9
            [8] = u24
            [9] = u23
            [10] = u1
        --]]
        local v113 = u2.getMouseLocation().X
        local v114 = v113 - u108
        u108 = v113
        if u109 == false then
            return
        elseif u110 ~= nil then
            local v115 = u110.state.number
            if u112 == "Color3" or u112 == "Color4" then
                v115 = u110.state.color
                if u111 == 4 then
                    v115 = u110.state.transparency
                end
            end
            local v116 = (u110.arguments.Increment and u9(u110.arguments.Increment, u111, u110.arguments) or u24[u112][u111]) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) and 10 or 1) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)) and 0.1 or 1) * ((u112 == "Color3" or u112 == "Color4") and 5 or 1)
            local v117 = u9(v115.value, u111, u110.arguments) + v114 * v116
            if u110.arguments.Min ~= nil then
                local v118 = u9
                local v119 = u110.arguments.Min
                local v120 = u111
                local v121 = u110.arguments
                v117 = math.max(v117, v118(v119, v120, v121))
            end
            if u110.arguments.Max ~= nil then
                local v122 = u9
                local v123 = u110.arguments.Max
                local v124 = u111
                local v125 = u110.arguments
                v117 = math.min(v117, v122(v123, v124, v125))
            end
            v115:set(u23(v115.value, u111, v117, u110.arguments))
            u110.lastNumberChangedTick = u1._cycleTick + 1
        end
    end
    local function u135(p127, p128, p129, p130, p131) --[[ Line: 502 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
            [3] = u109
            [4] = u110
            [5] = u111
            [6] = u112
            [7] = u126
        --]]
        local v132 = u2.getTime()
        local v133 = v132 - p127.lastClickedTime < u1._config.MouseDoubleClickTime
        local v134 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
        if v133 and (Vector2.new(p130, p131) - p127.lastClickedPosition).Magnitude < u1._config.MouseDoubleClickMaxDist or v134 then
            p127.state.editingText:set(p129)
        else
            p127.lastClickedTime = v132
            p127.lastClickedPosition = Vector2.new(p130, p131)
            u109 = true
            u110 = p127
            u111 = p129
            u112 = p128
            u126()
        end
    end
    u2.UserInputService.InputChanged:Connect(u126)
    u2.UserInputService.InputEnded:Connect(function(p136) --[[ Line: 525 ]]
        --[[
        Upvalues:
            [1] = u109
            [2] = u110
            [3] = u111
        --]]
        if p136.UserInputType == Enum.UserInputType.MouseButton1 and u109 then
            u109 = false
            u110 = nil
            u111 = 0
        end
    end)
    local function u200(u137, u138, u139) --[[ Line: 533 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u1
            [4] = u9
            [5] = u23
            [6] = u135
            [7] = u28
            [8] = u27
        --]]
        local v199 = {
            ["hasState"] = true,
            ["hasChildren"] = false,
            ["Args"] = {
                ["Text"] = 1,
                ["Increment"] = 2,
                ["Min"] = 3,
                ["Max"] = 4,
                ["Format"] = 5
            },
            ["Events"] = {
                ["numberChanged"] = u4,
                ["hovered"] = u2.EVENTS.hover(function(p140) --[[ Line: 546 ]]
                    return p140.Instance
                end)
            },
            ["Generate"] = function(u141) --[[ Name: Generate, Line 550 ]]
                --[[
                Upvalues:
                    [1] = u137
                    [2] = u2
                    [3] = u1
                    [4] = u138
                    [5] = u9
                    [6] = u23
                    [7] = u135
                --]]
                u141.lastClickedTime = -1
                u141.lastClickedPosition = Vector2.zero
                local v142 = Instance.new("Frame")
                v142.Name = "Iris_Drag" .. u137
                v142.Size = UDim2.fromScale(1, 0)
                v142.BackgroundTransparency = 1
                v142.BorderSizePixel = 0
                v142.ZIndex = u141.ZIndex
                v142.LayoutOrder = u141.ZIndex
                v142.AutomaticSize = Enum.AutomaticSize.Y
                u2.UIListLayout(v142, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X))
                local v143 = 0
                local v144 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
                if u137 == "Color3" or u137 == "Color4" then
                    v143 = v143 + (u1._config.ItemInnerSpacing.X + v144)
                    local v145 = Instance.new("ImageLabel")
                    v145.Name = "ColorBox"
                    v145.BorderSizePixel = 0
                    v145.Size = UDim2.fromOffset(v144, v144)
                    v145.ZIndex = u141.ZIndex + 5
                    v145.LayoutOrder = u141.ZIndex + 5
                    v145.Image = u2.ICONS.ALPHA_BACKGROUND_TEXTURE
                    v145.ImageTransparency = 1
                    u2.applyFrameStyle(v145, true, true)
                    v145.Parent = v142
                end
                local v146 = UDim.new(u1._config.ContentWidth.Scale / u138, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u138 - 1) - v143) / u138)
                local v147 = UDim.new(v146.Scale * (u138 - 1), v146.Offset * (u138 - 1) + u1._config.ItemInnerSpacing.X * (u138 - 1) + v143)
                local v148 = u1._config.ContentWidth - v147
                for u149 = 1, u138 do
                    local v150 = Instance.new("TextButton")
                    v150.Name = "DragField" .. tostring(u149)
                    v150.ZIndex = u141.ZIndex + u149
                    v150.LayoutOrder = u141.ZIndex + u149
                    if u149 == u138 then
                        v150.Size = UDim2.new(v148, UDim.new())
                    else
                        v150.Size = UDim2.new(v146, UDim.new())
                    end
                    v150.AutomaticSize = Enum.AutomaticSize.Y
                    v150.BackgroundColor3 = u1._config.FrameBgColor
                    v150.BackgroundTransparency = u1._config.FrameBgTransparency
                    v150.AutoButtonColor = false
                    v150.Text = ""
                    v150.ClipsDescendants = true
                    u2.applyFrameStyle(v150)
                    u2.applyTextStyle(v150)
                    u2.UISizeConstraint(v150, Vector2.new(1, 0))
                    v150.TextXAlignment = Enum.TextXAlignment.Center
                    v150.Parent = v142
                    u2.applyInteractionHighlights(v150, v150, {
                        ["ButtonColor"] = u1._config.FrameBgColor,
                        ["ButtonTransparency"] = u1._config.FrameBgTransparency,
                        ["ButtonHoveredColor"] = u1._config.FrameBgHoveredColor,
                        ["ButtonHoveredTransparency"] = u1._config.FrameBgHoveredTransparency,
                        ["ButtonActiveColor"] = u1._config.FrameBgActiveColor,
                        ["ButtonActiveTransparency"] = u1._config.FrameBgActiveTransparency
                    })
                    local u151 = Instance.new("TextBox")
                    u151.Name = "InputField"
                    u151.ZIndex = u141.ZIndex + 5
                    u151.LayoutOrder = u141.ZIndex + 2
                    u151.Size = UDim2.new(1, 0, 1, 0)
                    u151.BackgroundTransparency = 1
                    u151.ClearTextOnFocus = false
                    u151.TextTruncate = Enum.TextTruncate.AtEnd
                    u151.ClipsDescendants = true
                    u151.Visible = false
                    u2.applyFrameStyle(u151, true)
                    u2.applyTextStyle(u151)
                    u151.Parent = v150
                    u151.FocusLost:Connect(function() --[[ Line: 648 ]]
                        --[[
                        Upvalues:
                            [1] = u151
                            [2] = u141
                            [3] = u137
                            [4] = u149
                            [5] = u9
                            [6] = u23
                            [7] = u1
                        --]]
                        local v152 = u151.Text
                        local v153 = tonumber(v152:match("-?%d*%.?%d*"))
                        local v154 = u141.state.number
                        if u137 == "Color4" and u149 == 4 then
                            v154 = u141.state.transparency
                        elseif u137 == "Color3" or u137 == "Color4" then
                            v154 = u141.state.color
                        end
                        if v153 ~= nil then
                            if u137 == "Color3" or u137 == "Color4" and not u141.arguments.UseFloats then
                                v153 = v153 / 255
                            end
                            if u141.arguments.Min ~= nil then
                                local v155 = u9
                                local v156 = u141.arguments.Min
                                local v157 = u149
                                local v158 = u141.arguments
                                v153 = math.max(v153, v155(v156, v157, v158))
                            end
                            if u141.arguments.Max ~= nil then
                                local v159 = u9
                                local v160 = u141.arguments.Max
                                local v161 = u149
                                local v162 = u141.arguments
                                v153 = math.min(v153, v159(v160, v161, v162))
                            end
                            if u141.arguments.Increment then
                                local v163 = v153 / u9(u141.arguments.Increment, u149, u141.arguments)
                                v153 = math.round(v163) * u9(u141.arguments.Increment, u149, u141.arguments)
                            end
                            v154:set(u23(v154.value, u149, v153, u141.arguments))
                            u141.lastNumberChangedTick = u1._cycleTick + 1
                        end
                        local v164 = u9(v154.value, u149, u141.arguments)
                        if u137 == "Color3" or u137 == "Color4" and not u141.arguments.UseFloats then
                            local v165 = v164 * 255
                            v164 = math.round(v165)
                        end
                        local v166 = u141.arguments.Format[u149] or u141.arguments.Format[1]
                        if u141.arguments.Prefix then
                            v166 = u141.arguments.Prefix[u149] .. v166
                        end
                        u151.Text = string.format(v166, v164)
                        u141.state.editingText:set(0)
                        u151:ReleaseFocus(true)
                    end)
                    u151.Focused:Connect(function() --[[ Line: 691 ]]
                        --[[
                        Upvalues:
                            [1] = u151
                            [2] = u141
                            [3] = u149
                        --]]
                        u151.CursorPosition = #u151.Text + 1
                        u151.SelectionStart = 1
                        u141.state.editingText:set(u149)
                    end)
                    v150.MouseButton1Down:Connect(function(p167, p168) --[[ Line: 699 ]]
                        --[[
                        Upvalues:
                            [1] = u135
                            [2] = u141
                            [3] = u137
                            [4] = u149
                        --]]
                        u135(u141, u137, u149, p167, p168)
                    end)
                end
                local v169 = Instance.new("TextLabel")
                v169.Name = "TextLabel"
                v169.Size = UDim2.fromOffset(0, v144)
                v169.BackgroundTransparency = 1
                v169.BorderSizePixel = 0
                v169.ZIndex = u141.ZIndex + 5
                v169.LayoutOrder = u141.ZIndex + 5
                v169.AutomaticSize = Enum.AutomaticSize.X
                u2.applyTextStyle(v169)
                v169.Parent = v142
                return v142
            end,
            ["Update"] = function(p170) --[[ Name: Update, Line 719 ]]
                --[[
                Upvalues:
                    [1] = u137
                    [2] = u138
                    [3] = u28
                    [4] = u9
                    [5] = u27
                --]]
                p170.Instance.TextLabel.Text = p170.arguments.Text or ("Drag %*"):format(u137)
                if p170.arguments.Format then
                    local v171 = p170.arguments.Format
                    if typeof(v171) ~= "table" then
                        p170.arguments.Format = { p170.arguments.Format }
                        return
                    end
                end
                if not p170.arguments.Format then
                    local v172 = {}
                    for v173 = 1, u138 do
                        local v174 = u28[u137][v173]
                        if p170.arguments.Increment then
                            local v175 = u9(p170.arguments.Increment, v173, p170.arguments)
                            local v176 = v175 == 0 and 1 or v175
                            local v177 = -math.log10(v176)
                            local v178 = math.ceil(v177)
                            v174 = math.max(v174, v178, v174)
                        end
                        if p170.arguments.Max then
                            local v179 = u9(p170.arguments.Max, v173, p170.arguments)
                            local v180 = v179 == 0 and 1 or v179
                            local v181 = -math.log10(v180)
                            local v182 = math.ceil(v181)
                            v174 = math.max(v174, v182, v174)
                        end
                        if p170.arguments.Min then
                            local v183 = u9(p170.arguments.Min, v173, p170.arguments)
                            local v184 = v183 == 0 and 1 or v183
                            local v185 = -math.log10(v184)
                            local v186 = math.ceil(v185)
                            v174 = math.max(v174, v186, v174)
                        end
                        if v174 > 0 then
                            v172[v173] = ("%%.%*f"):format(v174)
                        else
                            v172[v173] = "%d"
                        end
                    end
                    p170.arguments.Format = v172
                    p170.arguments.Prefix = u27[u137]
                end
            end,
            ["Discard"] = function(p187) --[[ Name: Discard, Line 759 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                p187.Instance:Destroy()
                u2.discardState(p187)
            end,
            ["GenerateState"] = function(p188) --[[ Name: GenerateState, Line 763 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u139
                --]]
                if p188.state.number == nil then
                    p188.state.number = u1._widgetState(p188, "number", u139)
                end
                if p188.state.editingText == nil then
                    p188.state.editingText = u1._widgetState(p188, "editingText", false)
                end
            end,
            ["UpdateState"] = function(p189) --[[ Name: UpdateState, Line 771 ]]
                --[[
                Upvalues:
                    [1] = u138
                    [2] = u137
                    [3] = u9
                    [4] = u1
                --]]
                local v190 = p189.Instance
                for v191 = 1, u138 do
                    local v192 = p189.state.number
                    if u137 == "Color3" or u137 == "Color4" then
                        v192 = p189.state.color
                        if v191 == 4 then
                            v192 = p189.state.transparency
                        end
                    end
                    local v193 = v190:FindFirstChild("DragField" .. tostring(v191))
                    local v194 = v193.InputField
                    local v195 = u9(v192.value, v191, p189.arguments)
                    if (u137 == "Color3" or u137 == "Color4") and not p189.arguments.UseFloats then
                        local v196 = v195 * 255
                        v195 = math.round(v196)
                    end
                    local v197 = p189.arguments.Format[v191] or p189.arguments.Format[1]
                    if p189.arguments.Prefix then
                        v197 = p189.arguments.Prefix[v191] .. v197
                    end
                    v193.Text = string.format(v197, v195)
                    v194.Text = tostring(v195)
                    if p189.state.editingText.value == v191 then
                        v194.Visible = true
                        v194:CaptureFocus()
                        v193.TextTransparency = 1
                    else
                        v194.Visible = false
                        v193.TextTransparency = u1._config.TextTransparency
                    end
                end
                if u137 == "Color3" or u137 == "Color4" then
                    local v198 = v190.ColorBox
                    v198.BackgroundColor3 = p189.state.color.value
                    if u137 == "Color4" then
                        v198.ImageTransparency = 1 - p189.state.transparency.value
                    end
                end
            end
        }
        return v199
    end
    local function v208(u201, ...) --[[ Line: 819 ]]
        --[[
        Upvalues:
            [1] = u200
            [2] = u2
            [3] = u27
            [4] = u1
        --]]
        local u202 = { ... }
        local v203 = u200(u201, u201 == "Color4" and 4 or 3, u202[1])
        local v207 = {
            ["Args"] = {
                ["Text"] = 1,
                ["UseFloats"] = 2,
                ["UseHSV"] = 3,
                ["Format"] = 4
            },
            ["Update"] = function(p204) --[[ Name: Update, Line 830 ]]
                --[[
                Upvalues:
                    [1] = u201
                    [2] = u27
                    [3] = u1
                --]]
                p204.Instance.TextLabel.Text = p204.arguments.Text or ("Drag %*"):format(u201)
                if p204.arguments.Format then
                    local v205 = p204.arguments.Format
                    if typeof(v205) ~= "table" then
                        p204.arguments.Format = { p204.arguments.Format }
                        ::l6::
                        p204.arguments.Min = {
                            0,
                            0,
                            0,
                            0
                        }
                        p204.arguments.Max = {
                            1,
                            1,
                            1,
                            1
                        }
                        p204.arguments.Increment = {
                            0.001,
                            0.001,
                            0.001,
                            0.001
                        }
                        if p204.state then
                            u1._widgets[p204.type].UpdateState(p204)
                        end
                        return
                    end
                end
                if p204.arguments.UseFloats then
                    p204.arguments.Format = { "%.3f" }
                else
                    p204.arguments.Format = { "%d" }
                end
                p204.arguments.Prefix = u27[u201 .. (p204.arguments.UseHSV and "_HSV" or "_RGB")]
                goto l6
            end,
            ["GenerateState"] = function(p206) --[[ Name: GenerateState, Line 857 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u202
                    [3] = u201
                --]]
                if p206.state.color == nil then
                    p206.state.color = u1._widgetState(p206, "color", u202[1])
                end
                if u201 == "Color4" and p206.state.transparency == nil then
                    p206.state.transparency = u1._widgetState(p206, "transparency", u202[2])
                end
                if p206.state.editingText == nil then
                    p206.state.editingText = u1._widgetState(p206, "editingText", false)
                end
            end
        }
        return u2.extend(v203, v207)
    end
    local u209 = false
    local u210 = nil
    local u211 = 0
    local u212 = ""
    local function u224() --[[ Line: 885 ]]
        --[[
        Upvalues:
            [1] = u209
            [2] = u210
            [3] = u211
            [4] = u9
            [5] = u24
            [6] = u212
            [7] = u25
            [8] = u26
            [9] = u1
            [10] = u2
            [11] = u23
        --]]
        if u209 == false then
            return
        elseif u210 ~= nil then
            local v213 = u211
            local v214 = u210.Instance:FindFirstChild("SliderField" .. tostring(v213))
            local v215 = u210.arguments.Increment and u9(u210.arguments.Increment, u211, u210.arguments) or u24[u212][u211]
            local v216 = u210.arguments.Min and u9(u210.arguments.Min, u211, u210.arguments) or u25[u212][u211]
            local v217 = u210.arguments.Max and u9(u210.arguments.Max, u211, u210.arguments) or u26[u212][u211]
            local v218 = u1._config.FramePadding.X
            local v219 = ((v215 < 1 and 0 or 1) + v217 - v216) / v215
            local v220 = math.floor(v219)
            local v221 = (u2.getMouseLocation().X - (v214.AbsolutePosition.X + v218)) / (v214.AbsoluteSize.X - v218 * 2) * v220
            local v222 = math.floor(v221) * v215 + v216
            local v223 = math.clamp(v222, v216, v217)
            u210.state.number:set(u23(u210.state.number.value, u211, v223, u210.arguments))
            u210.lastNumberChangedTick = u1._cycleTick + 1
        end
    end
    local function u228(p225, p226, p227) --[[ Line: 915 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u209
            [3] = u210
            [4] = u211
            [5] = u212
            [6] = u224
        --]]
        if u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            p225.state.editingText:set(p227)
        else
            u209 = true
            u210 = p225
            u211 = p227
            u212 = p226
            u224()
        end
    end
    u2.UserInputService.InputChanged:Connect(u224)
    u2.UserInputService.InputEnded:Connect(function(p229) --[[ Line: 931 ]]
        --[[
        Upvalues:
            [1] = u209
            [2] = u210
            [3] = u211
            [4] = u212
        --]]
        if p229.UserInputType == Enum.UserInputType.MouseButton1 and u209 then
            u209 = false
            u210 = nil
            u211 = 0
            u212 = ""
        end
    end)
    local function v308(u230, u231, u232, ...) --[[ Line: 940 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u1
            [4] = u9
            [5] = u23
            [6] = u228
            [7] = u28
            [8] = u27
            [9] = u24
            [10] = u25
            [11] = u26
        --]]
        local v307 = {
            ["hasState"] = true,
            ["hasChildren"] = false,
            ["Args"] = {
                ["Text"] = 1,
                ["Increment"] = 2,
                ["Min"] = 3,
                ["Max"] = 4,
                ["Format"] = 5
            },
            ["Events"] = {
                ["numberChanged"] = u4,
                ["hovered"] = u2.EVENTS.hover(function(p233) --[[ Line: 953 ]]
                    return p233.Instance
                end)
            },
            ["Generate"] = function(u234) --[[ Name: Generate, Line 957 ]]
                --[[
                Upvalues:
                    [1] = u230
                    [2] = u2
                    [3] = u1
                    [4] = u231
                    [5] = u9
                    [6] = u23
                    [7] = u228
                --]]
                local v235 = Instance.new("Frame")
                v235.Name = "Iris_Slider" .. u230
                v235.Size = UDim2.fromScale(1, 0)
                v235.BackgroundTransparency = 1
                v235.BorderSizePixel = 0
                v235.ZIndex = u234.ZIndex
                v235.LayoutOrder = u234.ZIndex
                v235.AutomaticSize = Enum.AutomaticSize.Y
                u2.UIListLayout(v235, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X))
                local v236 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
                local v237 = UDim.new(u1._config.ContentWidth.Scale / u231, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u231 - 1)) / u231)
                local v238 = UDim.new(v237.Scale * (u231 - 1), v237.Offset * (u231 - 1) + u1._config.ItemInnerSpacing.X * (u231 - 1))
                local v239 = u1._config.ContentWidth - v238
                for u240 = 1, u231 do
                    local v241 = Instance.new("TextButton")
                    v241.Name = "SliderField" .. tostring(u240)
                    v241.ZIndex = u234.ZIndex + u240
                    v241.LayoutOrder = u234.ZIndex + u240
                    if u240 == u231 then
                        v241.Size = UDim2.new(v239, UDim.new())
                    else
                        v241.Size = UDim2.new(v237, UDim.new())
                    end
                    v241.AutomaticSize = Enum.AutomaticSize.Y
                    v241.BackgroundColor3 = u1._config.FrameBgColor
                    v241.BackgroundTransparency = u1._config.FrameBgTransparency
                    v241.AutoButtonColor = false
                    v241.Text = ""
                    v241.ClipsDescendants = true
                    u2.applyFrameStyle(v241)
                    u2.applyTextStyle(v241)
                    u2.UISizeConstraint(v241, Vector2.new(1, 0))
                    v241.Parent = v235
                    local v242 = Instance.new("TextLabel")
                    v242.Name = "OverlayText"
                    v242.Size = UDim2.fromScale(1, 1)
                    v242.BackgroundTransparency = 1
                    v242.BorderSizePixel = 0
                    v242.ZIndex = u234.ZIndex + 10
                    v242.ClipsDescendants = true
                    u2.applyTextStyle(v242)
                    v242.TextXAlignment = Enum.TextXAlignment.Center
                    v242.Parent = v241
                    u2.applyInteractionHighlights(v241, v241, {
                        ["ButtonColor"] = u1._config.FrameBgColor,
                        ["ButtonTransparency"] = u1._config.FrameBgTransparency,
                        ["ButtonHoveredColor"] = u1._config.FrameBgHoveredColor,
                        ["ButtonHoveredTransparency"] = u1._config.FrameBgHoveredTransparency,
                        ["ButtonActiveColor"] = u1._config.FrameBgActiveColor,
                        ["ButtonActiveTransparency"] = u1._config.FrameBgActiveTransparency
                    })
                    local u243 = Instance.new("TextBox")
                    u243.Name = "InputField"
                    u243.ZIndex = u234.ZIndex + 5
                    u243.LayoutOrder = u234.ZIndex + 2
                    u243.Size = UDim2.new(1, 0, 1, 0)
                    u243.BackgroundTransparency = 1
                    u243.ClearTextOnFocus = false
                    u243.TextTruncate = Enum.TextTruncate.AtEnd
                    u243.ClipsDescendants = true
                    u243.Visible = false
                    u2.applyFrameStyle(u243, true)
                    u2.applyTextStyle(u243)
                    u243.Parent = v241
                    u243.FocusLost:Connect(function() --[[ Line: 1045 ]]
                        --[[
                        Upvalues:
                            [1] = u243
                            [2] = u234
                            [3] = u9
                            [4] = u240
                            [5] = u23
                            [6] = u1
                        --]]
                        local v244 = u243.Text
                        local v245 = tonumber(v244:match("-?%d*%.?%d*"))
                        if v245 ~= nil then
                            if u234.arguments.Min ~= nil then
                                local v246 = u9
                                local v247 = u234.arguments.Min
                                local v248 = u240
                                local v249 = u234.arguments
                                v245 = math.max(v245, v246(v247, v248, v249))
                            end
                            if u234.arguments.Max ~= nil then
                                local v250 = u9
                                local v251 = u234.arguments.Max
                                local v252 = u240
                                local v253 = u234.arguments
                                v245 = math.min(v245, v250(v251, v252, v253))
                            end
                            if u234.arguments.Increment then
                                local v254 = v245 / u9(u234.arguments.Increment, u240, u234.arguments)
                                v245 = math.round(v254) * u9(u234.arguments.Increment, u240, u234.arguments)
                            end
                            u234.state.number:set(u23(u234.state.number.value, u240, v245, u234.arguments))
                            u234.lastNumberChangedTick = u1._cycleTick + 1
                        end
                        local v255 = u234.arguments.Format[u240] or u234.arguments.Format[1]
                        if u234.arguments.Prefix then
                            v255 = u234.arguments.Prefix[u240] .. v255
                        end
                        u243.Text = string.format(v255, u9(u234.state.number.value, u240, u234.arguments))
                        u234.state.editingText:set(0)
                        u243:ReleaseFocus(true)
                    end)
                    u243.Focused:Connect(function() --[[ Line: 1075 ]]
                        --[[
                        Upvalues:
                            [1] = u243
                            [2] = u234
                            [3] = u240
                        --]]
                        u243.CursorPosition = #u243.Text + 1
                        u243.SelectionStart = 1
                        u234.state.editingText:set(u240)
                    end)
                    v241.MouseButton1Down:Connect(function() --[[ Line: 1083 ]]
                        --[[
                        Upvalues:
                            [1] = u228
                            [2] = u234
                            [3] = u230
                            [4] = u240
                        --]]
                        u228(u234, u230, u240)
                    end)
                    local v256 = Instance.new("Frame")
                    v256.Name = "GrabBar"
                    v256.ZIndex = u234.ZIndex + 5
                    v256.LayoutOrder = u234.ZIndex + 5
                    v256.AnchorPoint = Vector2.new(0, 0.5)
                    v256.Position = UDim2.new(0, 0, 0.5, 0)
                    v256.BorderSizePixel = 0
                    v256.BackgroundColor3 = u1._config.SliderGrabColor
                    v256.Transparency = u1._config.SliderGrabTransparency
                    if u1._config.GrabRounding > 0 then
                        u2.UICorner(v256, u1._config.GrabRounding)
                    end
                    v256.Parent = v241
                end
                local v257 = Instance.new("TextLabel")
                v257.Name = "TextLabel"
                v257.Size = UDim2.fromOffset(0, v236)
                v257.BackgroundTransparency = 1
                v257.BorderSizePixel = 0
                v257.ZIndex = u234.ZIndex + 5
                v257.LayoutOrder = u234.ZIndex + 5
                v257.AutomaticSize = Enum.AutomaticSize.X
                u2.applyTextStyle(v257)
                v257.Parent = v235
                return v235
            end,
            ["Update"] = function(p258) --[[ Name: Update, Line 1118 ]]
                --[[
                Upvalues:
                    [1] = u230
                    [2] = u231
                    [3] = u28
                    [4] = u9
                    [5] = u27
                    [6] = u24
                    [7] = u25
                    [8] = u26
                    [9] = u1
                --]]
                local v259 = p258.Instance
                v259.TextLabel.Text = p258.arguments.Text or ("Slider %*"):format(u230)
                if p258.arguments.Format then
                    local v260 = p258.arguments.Format
                    if typeof(v260) ~= "table" then
                        p258.arguments.Format = { p258.arguments.Format }
                        ::l6::
                        for v261 = 1, u231 do
                            local v262 = v259:FindFirstChild("SliderField" .. tostring(v261))
                            local v263 = v262.GrabBar
                            local v264 = p258.arguments.Increment and u9(p258.arguments.Increment, v261, p258.arguments) or u24[u230][v261]
                            local v265 = p258.arguments.Min and u9(p258.arguments.Min, v261, p258.arguments) or u25[u230][v261]
                            local v266 = ((p258.arguments.Max and u9(p258.arguments.Max, v261, p258.arguments) or u26[u230][v261]) + 1 - v265) / v264
                            local v267 = 1 / math.floor(v266)
                            local v268 = u1._config.GrabMinSize / v262.AbsoluteSize.X
                            local v269 = math.max(v267, v268)
                            v263.Size = UDim2.new(v269, 0, 1, 0)
                        end
                        return
                    end
                end
                local v270 = {}
                for v271 = 1, u231 do
                    local v272 = u28[u230][v271]
                    if p258.arguments.Increment then
                        local v273 = u9(p258.arguments.Increment, v271, p258.arguments)
                        local v274 = v273 == 0 and 1 or v273
                        local v275 = -math.log10(v274)
                        local v276 = math.ceil(v275)
                        v272 = math.max(v272, v276, v272)
                    end
                    if p258.arguments.Max then
                        local v277 = u9(p258.arguments.Max, v271, p258.arguments)
                        local v278 = v277 == 0 and 1 or v277
                        local v279 = -math.log10(v278)
                        local v280 = math.ceil(v279)
                        v272 = math.max(v272, v280, v272)
                    end
                    if p258.arguments.Min then
                        local v281 = u9(p258.arguments.Min, v271, p258.arguments)
                        local v282 = v281 == 0 and 1 or v281
                        local v283 = -math.log10(v282)
                        local v284 = math.ceil(v283)
                        v272 = math.max(v272, v284, v272)
                    end
                    if v272 > 0 then
                        v270[v271] = ("%%.%*f"):format(v272)
                    else
                        v270[v271] = "%d"
                    end
                end
                p258.arguments.Format = v270
                p258.arguments.Prefix = u27[u230]
                goto l6
            end,
            ["Discard"] = function(p285) --[[ Name: Discard, Line 1176 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                p285.Instance:Destroy()
                u2.discardState(p285)
            end,
            ["GenerateState"] = function(p286) --[[ Name: GenerateState, Line 1180 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u232
                --]]
                if p286.state.number == nil then
                    p286.state.number = u1._widgetState(p286, "number", u232)
                end
                if p286.state.editingText == nil then
                    p286.state.editingText = u1._widgetState(p286, "editingText", false)
                end
            end,
            ["UpdateState"] = function(p287) --[[ Name: UpdateState, Line 1188 ]]
                --[[
                Upvalues:
                    [1] = u231
                    [2] = u9
                    [3] = u24
                    [4] = u230
                    [5] = u25
                    [6] = u26
                    [7] = u1
                --]]
                local v288 = p287.Instance
                for v289 = 1, u231 do
                    local v290 = v288:FindFirstChild("SliderField" .. tostring(v289))
                    local v291 = v290.InputField
                    local v292 = v290.OverlayText
                    local v293 = v290.GrabBar
                    local v294 = u9(p287.state.number.value, v289, p287.arguments)
                    local v295 = p287.arguments.Format[v289] or p287.arguments.Format[1]
                    if p287.arguments.Prefix then
                        v295 = p287.arguments.Prefix[v289] .. v295
                    end
                    v292.Text = string.format(v295, v294)
                    v291.Text = tostring(v294)
                    local v296 = p287.arguments.Increment and u9(p287.arguments.Increment, v289, p287.arguments) or u24[u230][v289]
                    local v297 = p287.arguments.Min and u9(p287.arguments.Min, v289, p287.arguments) or u25[u230][v289]
                    local v298 = p287.arguments.Max and u9(p287.arguments.Max, v289, p287.arguments) or u26[u230][v289]
                    local v299 = u1._config.FramePadding.X
                    local v300 = ((v296 < 1 and 0 or 1) + v298 - v297) / v296
                    local v301 = math.floor(v300)
                    local v302 = (v294 - v297) / (v298 - v297)
                    local v303 = 1 - v293.AbsoluteSize.X / (v290.AbsoluteSize.X - v299 * 2)
                    local v304 = v302 * v301
                    local v305 = math.floor(v304) / v301
                    local v306 = math.clamp(v305, 0, v303)
                    v293.Position = UDim2.new(v306, 0, 0.5, 0)
                    if p287.state.editingText.value == v289 then
                        v291.Visible = true
                        v292.Visible = false
                        v293.Visible = false
                        v291:CaptureFocus()
                    else
                        v291.Visible = false
                        v292.Visible = true
                        v293.Visible = true
                    end
                end
            end
        }
        return v307
    end
    local v309 = v107("Num", 1, 0)
    v309.Args.NoButtons = 6
    u1.WidgetConstructor("InputNum", v309)
    u1.WidgetConstructor("InputVector2", v107("Vector2", 2, Vector2.zero))
    u1.WidgetConstructor("InputVector3", v107("Vector3", 3, Vector3.new(0, 0, 0)))
    u1.WidgetConstructor("InputUDim", v107("UDim", 2, UDim.new()))
    u1.WidgetConstructor("InputUDim2", v107("UDim2", 4, UDim2.new()))
    u1.WidgetConstructor("InputRect", v107("Rect", 4, Rect.new(0, 0, 0, 0)))
    u1.WidgetConstructor("DragNum", u200("Num", 1, 0))
    u1.WidgetConstructor("DragVector2", u200("Vector2", 2, Vector2.zero))
    u1.WidgetConstructor("DragVector3", u200("Vector3", 3, Vector3.new(0, 0, 0)))
    u1.WidgetConstructor("DragUDim", u200("UDim", 2, UDim.new()))
    u1.WidgetConstructor("DragUDim2", u200("UDim2", 4, UDim2.new()))
    u1.WidgetConstructor("DragRect", u200("Rect", 4, Rect.new(0, 0, 0, 0)))
    u1.WidgetConstructor("InputColor3", v208("Color3", Color3.fromRGB(0, 0, 0)))
    u1.WidgetConstructor("InputColor4", v208("Color4", Color3.fromRGB(0, 0, 0), 0))
    u1.WidgetConstructor("SliderNum", v308("Num", 1, 0))
    u1.WidgetConstructor("SliderVector2", v308("Vector2", 2, Vector2.zero))
    u1.WidgetConstructor("SliderVector3", v308("Vector3", 3, Vector3.new(0, 0, 0)))
    u1.WidgetConstructor("SliderUDim", v308("UDim", 2, UDim.new()))
    u1.WidgetConstructor("SliderUDim2", v308("UDim2", 4, UDim2.new()))
    u1.WidgetConstructor("SliderRect", v308("Rect", 4, Rect.new(0, 0, 0, 0)))
    local v310 = u1.WidgetConstructor
    local v311 = {
        ["hasState"] = true,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1,
            ["TextHint"] = 2
        }
    }
    local v315 = {
        ["textChanged"] = {
            ["Init"] = function(p312) --[[ Line: 1319 ]]
                p312.lastTextchangeTick = 0
            end,
            ["Get"] = function(p313) --[[ Line: 1322 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p313.lastTextchangeTick == u1._cycleTick
            end
        },
        ["hovered"] = u2.EVENTS.hover(function(p314) --[[ Line: 1326 ]]
            return p314.Instance
        end)
    }
    v311.Events = v315
    function v311.Generate(u316) --[[ Line: 1330 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v317 = Instance.new("Frame")
        v317.Name = "Iris_InputText"
        v317.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0))
        v317.BackgroundTransparency = 1
        v317.BorderSizePixel = 0
        v317.ZIndex = u316.ZIndex
        v317.LayoutOrder = u316.ZIndex
        v317.AutomaticSize = Enum.AutomaticSize.Y
        u2.UIListLayout(v317, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X))
        local u318 = Instance.new("TextBox")
        u318.Name = "InputField"
        u318.Size = UDim2.new(1, 0, 0, 0)
        u318.AutomaticSize = Enum.AutomaticSize.Y
        u318.BackgroundColor3 = u1._config.FrameBgColor
        u318.BackgroundTransparency = u1._config.FrameBgTransparency
        u318.Text = ""
        u318.PlaceholderColor3 = u1._config.TextDisabledColor
        u318.TextTruncate = Enum.TextTruncate.AtEnd
        u318.ClearTextOnFocus = false
        u318.ZIndex = u316.ZIndex + 1
        u318.LayoutOrder = u316.ZIndex + 1
        u318.ClipsDescendants = true
        u2.applyFrameStyle(u318)
        u2.applyTextStyle(u318)
        u2.UISizeConstraint(u318, Vector2.new(1, 0))
        u318.Parent = v317
        u318.FocusLost:Connect(function() --[[ Line: 1362 ]]
            --[[
            Upvalues:
                [1] = u316
                [2] = u318
                [3] = u1
            --]]
            u316.state.text:set(u318.Text)
            u316.lastTextchangeTick = u1._cycleTick + 1
        end)
        local v319 = u1._config.TextSize + u1._config.FramePadding.Y * 2
        local v320 = Instance.new("TextLabel")
        v320.Name = "TextLabel"
        v320.Size = UDim2.fromOffset(0, v319)
        v320.AutomaticSize = Enum.AutomaticSize.X
        v320.BackgroundTransparency = 1
        v320.BorderSizePixel = 0
        v320.ZIndex = u316.ZIndex + 4
        v320.LayoutOrder = u316.ZIndex + 4
        u2.applyTextStyle(v320)
        v320.Parent = v317
        return v317
    end
    function v311.Update(p321) --[[ Line: 1384 ]]
        local v322 = p321.Instance
        local v323 = v322.TextLabel
        local v324 = v322.InputField
        v323.Text = p321.arguments.Text or "Input Text"
        v324.PlaceholderText = p321.arguments.TextHint or ""
    end
    function v311.Discard(p325) --[[ Line: 1392 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p325.Instance:Destroy()
        u2.discardState(p325)
    end
    function v311.GenerateState(p326) --[[ Line: 1396 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p326.state.text == nil then
            p326.state.text = u1._widgetState(p326, "text", "")
        end
    end
    function v311.UpdateState(p327) --[[ Line: 1401 ]]
        p327.Instance.InputField.Text = p327.state.text.value
    end
    v310("InputText", v311)
end