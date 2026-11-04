 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local v3 = u1.WidgetConstructor
    local v4 = {
        ["hasState"] = true,
        ["hasChildren"] = false,
        ["Args"] = {
            ["Text"] = 1
        }
    }
    local v8 = {
        ["checked"] = {
            ["Init"] = function(_) --[[ Line: 12 ]] end,
            ["Get"] = function(p5) --[[ Line: 13 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p5.lastCheckedTick == u1._cycleTick
            end
        },
        ["unchecked"] = {
            ["Init"] = function(_) --[[ Line: 18 ]] end,
            ["Get"] = function(p6) --[[ Line: 19 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                return p6.lastUncheckedTick == u1._cycleTick
            end
        },
        ["hovered"] = u2.EVENTS.hover(function(p7) --[[ Line: 23 ]]
            return p7.Instance
        end)
    }
    v4.Events = v8
    function v4.Generate(u9) --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v10 = Instance.new("TextButton")
        v10.Name = "Iris_Checkbox"
        v10.BackgroundTransparency = 1
        v10.BorderSizePixel = 0
        v10.Size = UDim2.fromOffset(0, 0)
        v10.Text = ""
        v10.AutomaticSize = Enum.AutomaticSize.XY
        v10.ZIndex = u9.ZIndex
        v10.AutoButtonColor = false
        v10.LayoutOrder = u9.ZIndex
        local v11 = u1._config.TextSize + 2 * u1._config.FramePadding.Y
        local v12 = Instance.new("Frame")
        v12.Name = "CheckboxBox"
        v12.Size = UDim2.fromOffset(v11, v11)
        v12.BackgroundColor3 = u1._config.FrameBgColor
        v12.BackgroundTransparency = u1._config.FrameBgTransparency
        v12.ZIndex = u9.ZIndex + 1
        v12.LayoutOrder = u9.ZIndex + 1
        u2.applyFrameStyle(v12, true)
        u2.applyInteractionHighlights(v10, v12, {
            ["ButtonColor"] = u1._config.FrameBgColor,
            ["ButtonTransparency"] = u1._config.FrameBgTransparency,
            ["ButtonHoveredColor"] = u1._config.FrameBgHoveredColor,
            ["ButtonHoveredTransparency"] = u1._config.FrameBgHoveredTransparency,
            ["ButtonActiveColor"] = u1._config.FrameBgActiveColor,
            ["ButtonActiveTransparency"] = u1._config.FrameBgActiveTransparency
        })
        v12.Parent = v10
        local v13 = v11 * 0.1
        local v14 = math.ceil(v13)
        local v15 = v11 - v14 * 2
        local v16 = Instance.new("ImageLabel")
        v16.Name = "Checkmark"
        v16.Size = UDim2.fromOffset(v15, v15)
        v16.Position = UDim2.fromOffset(v14, v14)
        v16.BackgroundTransparency = 1
        v16.ImageColor3 = u1._config.CheckMarkColor
        v16.ImageTransparency = u1._config.CheckMarkTransparency
        v16.ScaleType = Enum.ScaleType.Fit
        v16.ZIndex = u9.ZIndex + 2
        v16.LayoutOrder = u9.ZIndex + 2
        v16.Parent = v10
        v10.MouseButton1Click:Connect(function() --[[ Line: 77 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            local v17 = u9.state.isChecked.value
            u9.state.isChecked:set(not v17)
        end)
        local v18 = Instance.new("TextLabel")
        v18.Name = "TextLabel"
        u2.applyTextStyle(v18)
        v18.AnchorPoint = Vector2.new(0, 0.5)
        v18.Position = UDim2.new(0, v11 + u1._config.ItemInnerSpacing.X, 0.5, 0)
        v18.ZIndex = u9.ZIndex + 1
        v18.LayoutOrder = u9.ZIndex + 1
        v18.AutomaticSize = Enum.AutomaticSize.XY
        v18.BackgroundTransparency = 1
        v18.BorderSizePixel = 0
        v18.Parent = v10
        return v10
    end
    function v4.Update(p19) --[[ Line: 96 ]]
        p19.Instance.TextLabel.Text = p19.arguments.Text or "Checkbox"
    end
    function v4.Discard(p20) --[[ Line: 100 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        p20.Instance:Destroy()
        u2.discardState(p20)
    end
    function v4.GenerateState(p21) --[[ Line: 104 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p21.state.isChecked == nil then
            p21.state.isChecked = u1._widgetState(p21, "checked", false)
        end
    end
    function v4.UpdateState(p22) --[[ Line: 109 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v23 = p22.Instance.Checkmark
        if p22.state.isChecked.value then
            v23.Image = u2.ICONS.CHECK_MARK
            p22.lastCheckedTick = u1._cycleTick + 1
        else
            v23.Image = ""
            p22.lastUncheckedTick = u1._cycleTick + 1
        end
    end
    v3("Checkbox", v4)
end