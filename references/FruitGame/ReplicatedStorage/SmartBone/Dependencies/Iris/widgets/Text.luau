 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local v3 = u1.WidgetConstructor
    local v10 = {
        ["hasState"] = false,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1,
            ["Wrapped"] = 2,
            ["Color"] = 3,
            ["RichText"] = 4
        },
        ["Events"] = {
            ["hovered"] = u2.EVENTS.hover(function(p4) --[[ Line: 14 ]]
                return p4.Instance
            end)
        },
        ["Generate"] = function(p5) --[[ Name: Generate, Line 18 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v6 = Instance.new("TextLabel")
            v6.Name = "Iris_Text"
            v6.Size = UDim2.fromOffset(0, 0)
            v6.BackgroundTransparency = 1
            v6.BorderSizePixel = 0
            v6.ZIndex = p5.ZIndex
            v6.LayoutOrder = p5.ZIndex
            v6.AutomaticSize = Enum.AutomaticSize.XY
            u2.applyTextStyle(v6)
            u2.UIPadding(v6, Vector2.new(0, 2))
            return v6
        end,
        ["Update"] = function(p7) --[[ Name: Update, Line 33 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v8 = p7.Instance
            if p7.arguments.Text == nil then
                error("Iris.Text Text Argument is required", 5)
            end
            if p7.arguments.Wrapped then
                v8.TextWrapped = true
            else
                v8.TextWrapped = false
            end
            if p7.arguments.Color then
                v8.TextColor3 = p7.arguments.Color
            else
                v8.TextColor3 = u1._config.TextColor
            end
            if p7.arguments.RichText then
                v8.RichText = true
            else
                v8.RichText = false
            end
            v8.Text = p7.arguments.Text
        end,
        ["Discard"] = function(p9) --[[ Name: Discard, Line 56 ]]
            p9.Instance:Destroy()
        end
    }
    v3("Text", v10)
    local v11 = u1.WidgetConstructor
    local v21 = {
        ["hasState"] = false,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1
        },
        ["Events"] = {
            ["hovered"] = u2.EVENTS.hover(function(p12) --[[ Line: 68 ]]
                return p12.Instance
            end)
        },
        ["Generate"] = function(p13) --[[ Name: Generate, Line 72 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            local v14 = Instance.new("Frame")
            v14.Name = "Iris_SeparatorText"
            v14.Size = UDim2.fromScale(1, 0)
            v14.BackgroundTransparency = 1
            v14.BorderSizePixel = 0
            v14.AutomaticSize = Enum.AutomaticSize.Y
            v14.ZIndex = p13.ZIndex
            v14.LayoutOrder = p13.ZIndex
            v14.ClipsDescendants = true
            u2.UIPadding(v14, Vector2.new(0, u1._config.SeparatorTextPadding.Y))
            u2.UIListLayout(v14, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemSpacing.X))
            v14.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            local v15 = Instance.new("TextLabel")
            v15.Name = "TextLabel"
            v15.BackgroundTransparency = 1
            v15.BorderSizePixel = 0
            v15.AutomaticSize = Enum.AutomaticSize.XY
            v15.ZIndex = p13.ZIndex + 1
            v15.LayoutOrder = p13.ZIndex + 1
            u2.applyTextStyle(v15)
            v15.Parent = v14
            local v16 = Instance.new("Frame")
            v16.Name = "Left"
            v16.AnchorPoint = Vector2.new(1, 0.5)
            v16.BackgroundColor3 = u1._config.SeparatorColor
            v16.BackgroundTransparency = u1._config.SeparatorTransparency
            v16.BorderSizePixel = 0
            v16.Size = UDim2.fromOffset(u1._config.SeparatorTextPadding.X - u1._config.ItemSpacing.X, u1._config.SeparatorTextBorderSize)
            v16.ZIndex = p13.ZIndex
            v16.LayoutOrder = p13.ZIndex
            v16.Parent = v14
            local v17 = Instance.new("Frame")
            v17.Name = "Right"
            v17.AnchorPoint = Vector2.new(1, 0.5)
            v17.BackgroundColor3 = u1._config.SeparatorColor
            v17.BackgroundTransparency = u1._config.SeparatorTransparency
            v17.BorderSizePixel = 0
            v17.Size = UDim2.new(1, 0, 0, u1._config.SeparatorTextBorderSize)
            v17.ZIndex = p13.ZIndex + 2
            v17.LayoutOrder = p13.ZIndex + 2
            v17.Parent = v14
            return v14
        end,
        ["Update"] = function(p18) --[[ Name: Update, Line 126 ]]
            local v19 = p18.Instance.TextLabel
            if p18.arguments.Text == nil then
                error("Iris.Text Text Argument is required", 5)
            end
            v19.Text = p18.arguments.Text
        end,
        ["Discard"] = function(p20) --[[ Name: Discard, Line 134 ]]
            p20.Instance:Destroy()
        end
    }
    v11("SeparatorText", v21)
end