 

local u1 = game:GetService("TextService")
local u2 = script.Parent.Parent.Assets.Frame
local u24 = {
    ["Cache"] = {},
    ["_toKey"] = function(_, p3, p4, p5) --[[ Name: _toKey, Line 14 ]]
        local v6 = p3.Family
        local v7 = p3.Style.Name
        local v8 = p3.Weight.Name
        local v9 = p3.Bold
        return v6 .. v7 .. v8 .. tostring(v9) .. tostring(p5) .. p4
    end,
    ["GetText"] = function(_, p10) --[[ Name: GetText, Line 24 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u1
            [3] = u2
        --]]
        local v11 = p10.Font
        local v12 = p10.Text
        local v13 = p10.TextSize
        local v14 = u24:_toKey(v11, v12, v13)
        u24[v14] = u24[v14] or {}
        local v15 = table.remove(u24[v14])
        if v15 then
            return v15
        end
        local v16 = Instance.new("GetTextBoundsParams")
        v16.Text = v12
        v16.Font = v11
        v16.Size = v13
        v16.Width = v13
        local v17 = u1:GetTextBoundsAsync(v16) + Vector2.one
        local v18 = u2:Clone()
        v18.Size = UDim2.fromOffset(v17.X, v17.Y)
        local v19 = v18.TextLabel
        v19.FontFace = v11
        v19.Size = v18.Size
        v19.TextSize = v13
        v19.Text = v12
        return v18
    end,
    ["Return"] = function(_, p20) --[[ Name: Return, Line 56 ]]
        --[[
        Upvalues:
            [1] = u24
        --]]
        local v21 = p20.TextLabel
        local v22 = u24:_toKey(v21.Font, v21.Text, v21.TextSize)
        local v23 = u24.Cache[v22]
        table.insert(v23, p20)
        p20.Parent = nil
    end
}
return u24