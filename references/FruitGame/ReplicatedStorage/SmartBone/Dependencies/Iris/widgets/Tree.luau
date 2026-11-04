 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local v3 = {
        ["hasState"] = true,
        ["hasChildren"] = true
    }
    local v7 = {
        ["collasped"] = {
            ["Init"] = function(_) --[[ Line: 9 ]] end,
            ["Get"] = function(p4) --[[ Line: 10 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p4.lastCollapsedTick == u1._cycleTick
            end
        },
        ["uncollapsed"] = {
            ["Init"] = function(_) --[[ Line: 15 ]] end,
            ["Get"] = function(p5) --[[ Line: 16 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p5.lastUncollapsedTick == u1._cycleTick
            end
        },
        ["hovered"] = u2.EVENTS.hover(function(p6) --[[ Line: 20 ]]
            return p6.Instance
        end)
    }
    v3.Events = v7
    function v3.Discard(p8) --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p8.Instance:Destroy()
        u2.discardState(p8)
    end
    function v3.ChildAdded(p9) --[[ Line: 28 ]]
        local v10 = p9.Instance.ChildContainer
        v10.Visible = p9.state.isUncollapsed.value
        return v10
    end
    function v3.UpdateState(p11) --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v12 = p11.state.isUncollapsed.value
        local v13 = p11.Instance
        local v14 = v13.ChildContainer
        v13.Header.Button.Arrow.Image = v12 and u2.ICONS.DOWN_POINTING_TRIANGLE or u2.ICONS.RIGHT_POINTING_TRIANGLE
        if v12 then
            p11.lastUncollapsedTick = u1._cycleTick + 1
        else
            p11.lastCollapsedTick = u1._cycleTick + 1
        end
        v14.Visible = v12
    end
    function v3.GenerateState(p15) --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p15.state.isUncollapsed == nil then
            p15.state.isUncollapsed = u1._widgetState(p15, "isUncollapsed", false)
        end
    end
    local v31 = {
        ["Args"] = {
            ["Text"] = 1,
            ["SpanAvailWidth"] = 2,
            ["NoIndent"] = 3
        },
        ["Generate"] = function(u16) --[[ Name: Generate, Line 68 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            local v17 = Instance.new("Frame")
            v17.Name = "Iris_Tree"
            v17.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, 0))
            v17.AutomaticSize = Enum.AutomaticSize.Y
            v17.BackgroundTransparency = 1
            v17.BorderSizePixel = 0
            v17.ZIndex = u16.ZIndex
            v17.LayoutOrder = u16.ZIndex
            u2.UIListLayout(v17, Enum.FillDirection.Vertical, UDim.new(0, 0))
            local v18 = Instance.new("Frame")
            v18.Name = "ChildContainer"
            v18.Size = UDim2.fromScale(1, 0)
            v18.AutomaticSize = Enum.AutomaticSize.Y
            v18.BackgroundTransparency = 1
            v18.BorderSizePixel = 0
            v18.ZIndex = u16.ZIndex + 1
            v18.LayoutOrder = u16.ZIndex + 1
            v18.Visible = false
            u2.UIListLayout(v18, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y))
            u2.UIPadding(v18, Vector2.new(0, 0)).PaddingTop = UDim.new(0, u1._config.ItemSpacing.Y)
            v18.Parent = v17
            local v19 = Instance.new("Frame")
            v19.Name = "Header"
            v19.Size = UDim2.fromScale(1, 0)
            v19.AutomaticSize = Enum.AutomaticSize.Y
            v19.BackgroundTransparency = 1
            v19.BorderSizePixel = 0
            v19.ZIndex = u16.ZIndex
            v19.LayoutOrder = u16.ZIndex
            v19.Parent = v17
            local v20 = Instance.new("TextButton")
            v20.Name = "Button"
            v20.BackgroundTransparency = 1
            v20.BorderSizePixel = 0
            v20.Text = ""
            v20.ZIndex = u16.ZIndex
            v20.LayoutOrder = u16.ZIndex
            v20.AutoButtonColor = false
            u2.applyInteractionHighlights(v20, v19, {
                ["ButtonColor"] = Color3.fromRGB(0, 0, 0),
                ["ButtonTransparency"] = 1,
                ["ButtonHoveredColor"] = u1._config.HeaderHoveredColor,
                ["ButtonHoveredTransparency"] = u1._config.HeaderHoveredTransparency,
                ["ButtonActiveColor"] = u1._config.HeaderActiveColor,
                ["ButtonActiveTransparency"] = u1._config.HeaderActiveTransparency
            })
            u2.UIPadding(v20, Vector2.zero).PaddingLeft = UDim.new(0, u1._config.FramePadding.X)
            u2.UIListLayout(v20, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
            v20.Parent = v19
            local v21 = Instance.new("ImageLabel")
            v21.Name = "Arrow"
            local v22 = UDim2.fromOffset
            local v23 = u1._config.TextSize
            local v24 = u1._config.TextSize * 0.7
            v21.Size = v22(v23, (math.floor(v24)))
            v21.BackgroundTransparency = 1
            v21.BorderSizePixel = 0
            v21.ImageColor3 = u1._config.TextColor
            v21.ImageTransparency = u1._config.TextTransparency
            v21.ScaleType = Enum.ScaleType.Fit
            v21.ZIndex = u16.ZIndex
            v21.LayoutOrder = u16.ZIndex
            v21.Parent = v20
            local v25 = Instance.new("TextLabel")
            v25.Name = "TextLabel"
            v25.Size = UDim2.fromOffset(0, 0)
            v25.AutomaticSize = Enum.AutomaticSize.XY
            v25.BackgroundTransparency = 1
            v25.BorderSizePixel = 0
            v25.ZIndex = u16.ZIndex
            v25.LayoutOrder = u16.ZIndex
            u2.UIPadding(v25, Vector2.new(0, 0)).PaddingRight = UDim.new(0, 21)
            u2.applyTextStyle(v25)
            v25.Parent = v20
            v20.MouseButton1Click:Connect(function() --[[ Line: 160 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                u16.state.isUncollapsed:set(not u16.state.isUncollapsed.value)
            end)
            return v17
        end,
        ["Update"] = function(p26) --[[ Name: Update, Line 166 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v27 = p26.Instance
            local v28 = v27.Header.Button
            local v29 = v28.TextLabel
            local v30 = v27.ChildContainer.UIPadding
            v29.Text = p26.arguments.Text or "Tree"
            if p26.arguments.SpanAvailWidth then
                v28.AutomaticSize = Enum.AutomaticSize.Y
                v28.Size = UDim2.fromScale(1, 0)
            else
                v28.AutomaticSize = Enum.AutomaticSize.XY
                v28.Size = UDim2.fromScale(0, 0)
            end
            if p26.arguments.NoIndent then
                v30.PaddingLeft = UDim.new(0, 0)
            else
                v30.PaddingLeft = UDim.new(0, u1._config.IndentSpacing)
            end
        end
    }
    u1.WidgetConstructor("Tree", u2.extend(v3, v31))
    local v43 = {
        ["Args"] = {
            ["Text"] = 1
        },
        ["Generate"] = function(u32) --[[ Name: Generate, Line 198 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            local v33 = Instance.new("Frame")
            v33.Name = "Iris_CollapsingHeader"
            v33.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, 0))
            v33.AutomaticSize = Enum.AutomaticSize.Y
            v33.BackgroundTransparency = 1
            v33.BorderSizePixel = 0
            v33.ZIndex = u32.ZIndex
            v33.LayoutOrder = u32.ZIndex
            u2.UIListLayout(v33, Enum.FillDirection.Vertical, UDim.new(0, 0))
            local v34 = Instance.new("Frame")
            v34.Name = "ChildContainer"
            v34.Size = UDim2.fromScale(1, 0)
            v34.AutomaticSize = Enum.AutomaticSize.Y
            v34.BackgroundTransparency = 1
            v34.BorderSizePixel = 0
            v34.ZIndex = u32.ZIndex + 1
            v34.LayoutOrder = u32.ZIndex + 1
            v34.Visible = false
            u2.UIListLayout(v34, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y))
            u2.UIPadding(v34, Vector2.new(0, 0)).PaddingTop = UDim.new(0, u1._config.ItemSpacing.Y)
            v34.Parent = v33
            local v35 = Instance.new("Frame")
            v35.Name = "Header"
            v35.Size = UDim2.fromScale(1, 0)
            v35.AutomaticSize = Enum.AutomaticSize.Y
            v35.BackgroundTransparency = 1
            v35.BorderSizePixel = 0
            v35.ZIndex = u32.ZIndex
            v35.LayoutOrder = u32.ZIndex
            v35.Parent = v33
            local v36 = Instance.new("TextButton")
            v36.Name = "Button"
            v36.Size = UDim2.new(1, 2 * u1._config.FramePadding.X, 0, 0)
            v36.Position = UDim2.fromOffset(-4, 0)
            v36.AutomaticSize = Enum.AutomaticSize.Y
            v36.BackgroundColor3 = u1._config.HeaderColor
            v36.BackgroundTransparency = u1._config.HeaderTransparency
            v36.BorderSizePixel = 0
            v36.Text = ""
            v36.ZIndex = u32.ZIndex
            v36.LayoutOrder = u32.ZIndex
            v36.AutoButtonColor = false
            v36.ClipsDescendants = true
            u2.UIPadding(v36, Vector2.new(2 * u1._config.FramePadding.X, u1._config.FramePadding.Y))
            u2.applyFrameStyle(v36, true, true)
            u2.UIListLayout(v36, Enum.FillDirection.Horizontal, UDim.new(0, 2 * u1._config.FramePadding.X)).VerticalAlignment = Enum.VerticalAlignment.Center
            u2.applyInteractionHighlights(v36, v36, {
                ["ButtonColor"] = u1._config.HeaderColor,
                ["ButtonTransparency"] = u1._config.HeaderTransparency,
                ["ButtonHoveredColor"] = u1._config.HeaderHoveredColor,
                ["ButtonHoveredTransparency"] = u1._config.HeaderHoveredTransparency,
                ["ButtonActiveColor"] = u1._config.HeaderActiveColor,
                ["ButtonActiveTransparency"] = u1._config.HeaderActiveTransparency
            })
            v36.Parent = v35
            local v37 = Instance.new("ImageLabel")
            v37.Name = "Arrow"
            local v38 = UDim2.fromOffset
            local v39 = u1._config.TextSize
            local v40 = u1._config.TextSize * 0.8
            v37.Size = v38(v39, (math.ceil(v40)))
            v37.AutomaticSize = Enum.AutomaticSize.Y
            v37.BackgroundTransparency = 1
            v37.BorderSizePixel = 0
            v37.ImageColor3 = u1._config.TextColor
            v37.ImageTransparency = u1._config.TextTransparency
            v37.ScaleType = Enum.ScaleType.Fit
            v37.ZIndex = u32.ZIndex
            v37.LayoutOrder = u32.ZIndex
            v37.Parent = v36
            local v41 = Instance.new("TextLabel")
            v41.Name = "TextLabel"
            v41.Size = UDim2.fromOffset(0, 0)
            v41.AutomaticSize = Enum.AutomaticSize.XY
            v41.BackgroundTransparency = 1
            v41.BorderSizePixel = 0
            v41.ZIndex = u32.ZIndex
            v41.LayoutOrder = u32.ZIndex
            u2.UIPadding(v41, Vector2.new(0, 0)).PaddingRight = UDim.new(0, 21)
            u2.applyTextStyle(v41)
            v41.Parent = v36
            v36.MouseButton1Click:Connect(function() --[[ Line: 296 ]]
                --[[
                Upvalues:
                    [1] = u32
                --]]
                u32.state.isUncollapsed:set(not u32.state.isUncollapsed.value)
            end)
            return v33
        end,
        ["Update"] = function(p42) --[[ Name: Update, Line 302 ]]
            p42.Instance.Header.Button.TextLabel.Text = p42.arguments.Text or "Collapsing Header"
        end
    }
    u1.WidgetConstructor("CollapsingHeader", u2.extend(v3, v43))
end