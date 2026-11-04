 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    u1.WidgetConstructor("Separator", {
        ["hasState"] = false,
        ["hasChildren"] = false,
        ["Args"] = {},
        ["Events"] = {},
        ["Generate"] = function(p3) --[[ Name: Generate, Line 9 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            local v4 = Instance.new("Frame")
            v4.Name = "Iris_Separator"
            v4.BackgroundColor3 = u1._config.SeparatorColor
            v4.BackgroundTransparency = u1._config.SeparatorTransparency
            v4.BorderSizePixel = 0
            if p3.parentWidget.type == "SameLine" then
                v4.Size = UDim2.new(0, 1, 1, 0)
            else
                v4.Size = UDim2.new(1, 0, 0, 1)
            end
            v4.ZIndex = p3.ZIndex
            v4.LayoutOrder = p3.ZIndex
            u2.UIListLayout(v4, Enum.FillDirection.Vertical, UDim.new(0, 0))
            return v4
        end,
        ["Update"] = function(_) --[[ Name: Update, Line 28 ]] end,
        ["Discard"] = function(p5) --[[ Name: Discard, Line 29 ]]
            p5.Instance:Destroy()
        end
    })
    local v13 = {
        ["hasState"] = false,
        ["hasChildren"] = true,
        ["Args"] = {
            ["Width"] = 1
        },
        ["Events"] = {},
        ["Generate"] = function(p6) --[[ Name: Generate, Line 41 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            local v7 = Instance.new("Frame")
            v7.Name = "Iris_Indent"
            v7.BackgroundTransparency = 1
            v7.BorderSizePixel = 0
            v7.Size = UDim2.fromScale(1, 0)
            v7.AutomaticSize = Enum.AutomaticSize.Y
            v7.ZIndex = p6.ZIndex
            v7.LayoutOrder = p6.ZIndex
            u2.UIListLayout(v7, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y))
            u2.UIPadding(v7, Vector2.new(0, 0))
            return v7
        end,
        ["Update"] = function(p8) --[[ Name: Update, Line 56 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v9 = p8.Instance
            local v10
            if p8.arguments.Width then
                v10 = p8.arguments.Width
            else
                v10 = u1._config.IndentSpacing
            end
            v9.UIPadding.PaddingLeft = UDim.new(0, v10)
        end,
        ["Discard"] = function(p11) --[[ Name: Discard, Line 67 ]]
            p11.Instance:Destroy()
        end,
        ["ChildAdded"] = function(p12, _) --[[ Name: ChildAdded, Line 70 ]]
            return p12.Instance
        end
    }
    u1.WidgetConstructor("Indent", v13)
    local v21 = {
        ["hasState"] = false,
        ["hasChildren"] = true,
        ["Args"] = {
            ["Width"] = 1,
            ["VerticalAlignment"] = 2
        },
        ["Events"] = {},
        ["Generate"] = function(p14) --[[ Name: Generate, Line 83 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v15 = Instance.new("Frame")
            v15.Name = "Iris_SameLine"
            v15.BackgroundTransparency = 1
            v15.BorderSizePixel = 0
            v15.Size = UDim2.fromScale(1, 0)
            v15.AutomaticSize = Enum.AutomaticSize.Y
            v15.ZIndex = p14.ZIndex
            v15.LayoutOrder = p14.ZIndex
            u2.UIListLayout(v15, Enum.FillDirection.Horizontal, UDim.new(0, 0))
            return v15
        end,
        ["Update"] = function(p16) --[[ Name: Update, Line 97 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v17 = p16.Instance.UIListLayout
            local v18
            if p16.arguments.Width then
                v18 = p16.arguments.Width
            else
                v18 = u1._config.ItemSpacing.X
            end
            v17.Padding = UDim.new(0, v18)
            if p16.arguments.VerticalAlignment then
                v17.VerticalAlignment = p16.arguments.VerticalAlignment
            else
                v17.VerticalAlignment = Enum.VerticalAlignment.Center
            end
        end,
        ["Discard"] = function(p19) --[[ Name: Discard, Line 113 ]]
            p19.Instance:Destroy()
        end,
        ["ChildAdded"] = function(p20, _) --[[ Name: ChildAdded, Line 116 ]]
            return p20.Instance
        end
    }
    u1.WidgetConstructor("SameLine", v21)
    u1.WidgetConstructor("Group", {
        ["hasState"] = false,
        ["hasChildren"] = true,
        ["Args"] = {},
        ["Events"] = {},
        ["Generate"] = function(p22) --[[ Name: Generate, Line 126 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            local v23 = Instance.new("Frame")
            v23.Name = "Iris_Group"
            v23.BackgroundTransparency = 1
            v23.BorderSizePixel = 0
            v23.Size = UDim2.fromOffset(0, 0)
            v23.AutomaticSize = Enum.AutomaticSize.XY
            v23.ZIndex = p22.ZIndex
            v23.LayoutOrder = p22.ZIndex
            v23.ClipsDescendants = true
            u2.UIListLayout(v23, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.X))
            return v23
        end,
        ["Update"] = function(_) --[[ Name: Update, Line 141 ]] end,
        ["Discard"] = function(p24) --[[ Name: Discard, Line 142 ]]
            p24.Instance:Destroy()
        end,
        ["ChildAdded"] = function(p25, _) --[[ Name: ChildAdded, Line 145 ]]
            return p25.Instance
        end
    })
end