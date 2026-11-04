 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local v3 = u1.WidgetConstructor
    local v4 = {
        ["hasState"] = true,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1,
            ["Index"] = 2
        }
    }
    local v9 = {
        ["selected"] = {
            ["Init"] = function(_) --[[ Line: 13 ]] end,
            ["Get"] = function(p5) --[[ Line: 14 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p5.lastSelectedTick == u1._cycleTick
            end
        },
        ["unselected"] = {
            ["Init"] = function(_) --[[ Line: 19 ]] end,
            ["Get"] = function(p6) --[[ Line: 20 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p6.lastUnselectedTick == u1._cycleTick
            end
        },
        ["active"] = {
            ["Init"] = function(_) --[[ Line: 25 ]] end,
            ["Get"] = function(p7) --[[ Line: 26 ]]
                return p7.state.index.value == p7.arguments.Index
            end
        },
        ["hovered"] = u2.EVENTS.hover(function(p8) --[[ Line: 30 ]]
            return p8.Instance
        end)
    }
    v4.Events = v9
    function v4.Generate(u10) --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v11 = Instance.new("TextButton")
        v11.Name = "Iris_RadioButton"
        v11.BackgroundTransparency = 1
        v11.BorderSizePixel = 0
        v11.Size = UDim2.fromOffset(0, 0)
        v11.Text = ""
        v11.AutomaticSize = Enum.AutomaticSize.XY
        v11.ZIndex = u10.ZIndex
        v11.AutoButtonColor = false
        v11.LayoutOrder = u10.ZIndex
        local v12 = u1._config.TextSize + 2 * (u1._config.FramePadding.Y - 1)
        local v13 = Instance.new("Frame")
        v13.Name = "Button"
        v13.Size = UDim2.fromOffset(v12, v12)
        v13.ZIndex = u10.ZIndex + 1
        v13.LayoutOrder = u10.ZIndex + 1
        v13.Parent = v11
        v13.BackgroundColor3 = u1._config.FrameBgColor
        v13.BackgroundTransparency = u1._config.FrameBgTransparency
        u2.UICorner(v13)
        local v14 = Instance.new("Frame")
        v14.Name = "Circle"
        v14.Position = UDim2.fromOffset(u1._config.FramePadding.Y, u1._config.FramePadding.Y)
        v14.Size = UDim2.fromOffset(u1._config.TextSize - 2, u1._config.TextSize - 2)
        v14.ZIndex = u10.ZIndex + 1
        v14.LayoutOrder = u10.ZIndex + 1
        v14.Parent = v13
        v14.BackgroundColor3 = u1._config.CheckMarkColor
        v14.BackgroundTransparency = u1._config.CheckMarkTransparency
        u2.UICorner(v14)
        u2.applyInteractionHighlights(v11, v13, {
            ["ButtonColor"] = u1._config.FrameBgColor,
            ["ButtonTransparency"] = u1._config.FrameBgTransparency,
            ["ButtonHoveredColor"] = u1._config.FrameBgHoveredColor,
            ["ButtonHoveredTransparency"] = u1._config.FrameBgHoveredTransparency,
            ["ButtonActiveColor"] = u1._config.FrameBgActiveColor,
            ["ButtonActiveTransparency"] = u1._config.FrameBgActiveTransparency
        })
        v11.MouseButton1Click:Connect(function() --[[ Line: 78 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            u10.state.index:set(u10.arguments.Index)
        end)
        local v15 = Instance.new("TextLabel")
        v15.Name = "TextLabel"
        u2.applyTextStyle(v15)
        v15.Position = UDim2.new(0, v12 + u1._config.ItemInnerSpacing.X, 0.5, 0)
        v15.ZIndex = u10.ZIndex + 1
        v15.LayoutOrder = u10.ZIndex + 1
        v15.AutomaticSize = Enum.AutomaticSize.XY
        v15.AnchorPoint = Vector2.new(0, 0.5)
        v15.BackgroundTransparency = 1
        v15.BorderSizePixel = 0
        v15.Parent = v11
        return v11
    end
    function v4.Update(p16) --[[ Line: 96 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        p16.Instance.TextLabel.Text = p16.arguments.Text or "Radio Button"
        if p16.state then
            u1._widgets[p16.type].UpdateState(p16)
        end
    end
    function v4.Discard(p17) --[[ Line: 105 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p17.Instance:Destroy()
        u2.discardState(p17)
    end
    function v4.GenerateState(p18) --[[ Line: 109 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p18.state.index == nil then
            p18.state.index = u1._widgetState(p18, "index", p18.arguments.Value)
        end
    end
    function v4.UpdateState(p19) --[[ Line: 114 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v20 = p19.Instance.Button.Circle
        if p19.state.index.value == p19.arguments.Index then
            v20.BackgroundTransparency = u1._config.CheckMarkTransparency
            p19.lastSelectedTick = u1._cycleTick + 1
        else
            v20.BackgroundTransparency = 1
            p19.lastUnselectedTick = u1._cycleTick + 1
        end
    end
    v3("RadioButton", v4)
end