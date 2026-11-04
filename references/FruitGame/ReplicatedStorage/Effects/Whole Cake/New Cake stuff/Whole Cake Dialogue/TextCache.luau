 

local u1 = game:GetService("TextService")
local u23 = {
    ["Cache"] = {},
    ["_toKey"] = function(_, p2, p3, p4) --[[ Name: _toKey, Line 8 ]]
        local v5 = p2.Family
        local v6 = p2.Style.Name
        local v7 = p2.Weight.Name
        local v8 = p2.Bold
        return v5 .. v6 .. v7 .. tostring(v8) .. tostring(p4) .. p3
    end,
    ["GetText"] = function(_, p9) --[[ Name: GetText, Line 18 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u1
        --]]
        local v10 = p9.Font
        local v11 = p9.Text
        local v12 = p9.TextSize
        local v13 = u23:_toKey(v10, v11, v12)
        u23[v13] = u23[v13] or {}
        local v14 = table.remove(u23[v13])
        if v14 then
            return v14
        end
        local v15 = Instance.new("GetTextBoundsParams")
        v15.Text = v11
        v15.Font = v10
        v15.Size = v12
        v15.Width = v15.Size
        local v16 = u1:GetTextBoundsAsync(v15) + Vector2.one
        local v17 = script.Frame:Clone()
        v17.Size = UDim2.fromOffset(v16.X, v16.Y)
        local v18 = v17.TextLabel
        v18.FontFace = v10
        v18.Size = v17.Size
        v18.TextSize = v12
        v18.Text = v11
        return v17
    end,
    ["Return"] = function(_, p19) --[[ Name: Return, Line 51 ]]
        --[[
        Upvalues:
            [1] = u23
        --]]
        local v20 = p19.TextLabel
        local v21 = u23:_toKey(v20.FontFace, v20.Text, v20.TextSize)
        u23[v21] = u23[v21] or {}
        local v22 = u23[v21]
        table.insert(v22, p19)
        p19.Parent = nil
    end
}
return u23