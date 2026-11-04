 

require(script.Parent.Parent.Types)
return function(u1, u2) --[[ Line: 3 ]]
    local u3 = {}
    local v4 = u1._postCycleCallbacks
    table.insert(v4, function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        for _, v5 in u3 do
            v5.RowColumnIndex = 0
        end
    end)
    local v6 = u1.WidgetConstructor
    local v32 = {
        ["hasState"] = false,
        ["hasChildren"] = true,
        ["Args"] = {
            ["NumColumns"] = 1,
            ["RowBg"] = 2,
            ["BordersOuter"] = 3,
            ["BordersInner"] = 4
        },
        ["Events"] = {
            ["hovered"] = u2.EVENTS.hover(function(p7) --[[ Line: 23 ]]
                return p7.Instance
            end)
        },
        ["Generate"] = function(p8) --[[ Name: Generate, Line 27 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u1
                [3] = u2
            --]]
            u3[p8.ID] = p8
            p8.InitialNumColumns = -1
            p8.RowColumnIndex = 0
            p8.ColumnInstances = {}
            p8.CellInstances = {}
            local v9 = Instance.new("Frame")
            v9.Name = "Iris_Table"
            v9.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, 0))
            v9.AutomaticSize = Enum.AutomaticSize.Y
            v9.BackgroundTransparency = 1
            v9.BorderSizePixel = 0
            v9.ZIndex = p8.ZIndex + 1024
            v9.LayoutOrder = p8.ZIndex
            v9.ClipsDescendants = true
            u2.UIListLayout(v9, Enum.FillDirection.Horizontal, UDim.new(0, 0))
            u2.UIStroke(v9, 1, u1._config.TableBorderStrongColor, u1._config.TableBorderStrongTransparency)
            return v9
        end,
        ["Update"] = function(p10) --[[ Name: Update, Line 51 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            local v11 = p10.Instance
            if p10.arguments.BordersOuter == false then
                v11.UIStroke.Thickness = 0
            else
                v11.UIStroke.Thickness = 1
            end
            if p10.InitialNumColumns == -1 then
                if p10.arguments.NumColumns == nil then
                    error("Iris.Table NumColumns argument is required", 5)
                end
                p10.InitialNumColumns = p10.arguments.NumColumns
                for v12 = 1, p10.InitialNumColumns do
                    local v13 = p10.ZIndex + 1 + v12
                    local v14 = Instance.new("Frame")
                    v14.Name = ("Column_%*"):format(v12)
                    v14.Size = UDim2.new(1 / p10.InitialNumColumns, 0, 0, 0)
                    v14.AutomaticSize = Enum.AutomaticSize.Y
                    v14.BackgroundTransparency = 1
                    v14.BorderSizePixel = 0
                    v14.ZIndex = v13
                    v14.LayoutOrder = v13
                    v14.ClipsDescendants = true
                    u2.UIListLayout(v14, Enum.FillDirection.Vertical, UDim.new(0, 0))
                    p10.ColumnInstances[v12] = v14
                    v14.Parent = v11
                end
            elseif p10.arguments.NumColumns ~= p10.InitialNumColumns then
                error("Iris.Table NumColumns Argument must be static")
            end
            if p10.arguments.RowBg == false then
                for _, v15 in p10.CellInstances do
                    v15.BackgroundTransparency = 1
                end
            else
                for v16, v17 in p10.CellInstances do
                    local v18 = v16 / p10.InitialNumColumns
                    local v19
                    if math.ceil(v18) % 2 == 0 then
                        v19 = u1._config.TableRowBgAltTransparency
                    else
                        v19 = u1._config.TableRowBgTransparency
                    end
                    v17.BackgroundTransparency = v19
                end
            end
            if p10.arguments.BordersInner == false then
                for _, v20 in p10.CellInstances do
                    v20.UIStroke.Thickness = 0
                end
            else
                for _, v21 in p10.CellInstances do
                    v21.UIStroke.Thickness = 0.5
                end
            end
        end,
        ["Discard"] = function(p22) --[[ Name: Discard, Line 113 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            u3[p22.ID] = nil
            p22.Instance:Destroy()
        end,
        ["ChildAdded"] = function(p23) --[[ Name: ChildAdded, Line 117 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            if p23.RowColumnIndex == 0 then
                p23.RowColumnIndex = 1
            end
            local v24 = p23.CellInstances[p23.RowColumnIndex]
            if v24 then
                return v24
            end
            local v25 = p23.ColumnInstances[(p23.RowColumnIndex - 1) % p23.InitialNumColumns + 1]
            local v26 = v25.ZIndex + p23.RowColumnIndex
            local v27 = Instance.new("Frame")
            v27.Name = ("Cell_%*"):format(p23.RowColumnIndex)
            v27.Size = UDim2.new(1, 0, 0, 0)
            v27.AutomaticSize = Enum.AutomaticSize.Y
            v27.BackgroundTransparency = 1
            v27.BorderSizePixel = 0
            v27.ZIndex = v26
            v27.LayoutOrder = v26
            v27.ClipsDescendants = true
            u2.UIPadding(v27, u1._config.CellPadding)
            u2.UIListLayout(v27, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y))
            if p23.arguments.BordersInner == false then
                u2.UIStroke(v27, 0, u1._config.TableBorderLightColor, u1._config.TableBorderLightTransparency)
            else
                u2.UIStroke(v27, 0.5, u1._config.TableBorderLightColor, u1._config.TableBorderLightTransparency)
            end
            if p23.arguments.RowBg ~= false then
                local v28 = p23.RowColumnIndex / p23.InitialNumColumns
                local v29 = math.ceil(v28)
                local v30
                if v29 % 2 == 0 then
                    v30 = u1._config.TableRowBgAltColor
                else
                    v30 = u1._config.TableRowBgColor
                end
                local v31
                if v29 % 2 == 0 then
                    v31 = u1._config.TableRowBgAltTransparency
                else
                    v31 = u1._config.TableRowBgTransparency
                end
                v27.BackgroundColor3 = v30
                v27.BackgroundTransparency = v31
            end
            p23.CellInstances[p23.RowColumnIndex] = v27
            v27.Parent = v25
            return v27
        end
    }
    v6("Table", v32)
end