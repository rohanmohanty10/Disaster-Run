 

local v1 = {}
local u2 = {
    ["WindPower"] = "number",
    ["WindSpeed"] = "number",
    ["WindDirection"] = "Vector3",
    ["PivotOffset"] = "CFrame"
}
function v1.new(u3) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u4 = {}
    local u5 = u3:GetAttribute("WindPower")
    local u6 = u3:GetAttribute("WindSpeed")
    local u7 = u3:GetAttribute("WindDirection")
    local v8
    if typeof(u5) == u2.WindPower then
        v8 = u5
    else
        v8 = nil
    end
    u4.WindPower = v8
    local v9
    if typeof(u6) == u2.WindSpeed then
        v9 = u6
    else
        v9 = nil
    end
    u4.WindSpeed = v9
    local v10
    if typeof(u7) == u2.WindDirection then
        v10 = u7.Magnitude <= 0 and Vector3.new(0, 0, 0) or u7.Unit
    else
        v10 = nil
    end
    u4.WindDirection = v10
    local v11
    if u3:IsA("BasePart") then
        v11 = u3.PivotOffset
    else
        v11 = nil
    end
    u4.PivotOffset = v11
    local v12 = u4.PivotOffset
    local v13
    if typeof(v12) == "CFrame" then
        v13 = u4.PivotOffset:Inverse()
    else
        v13 = nil
    end
    u4.PivotOffsetInverse = v13
    local u17 = u3:GetAttributeChangedSignal("WindPower"):Connect(function() --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u3
            [3] = u4
            [4] = u2
        --]]
        u5 = u3:GetAttribute("WindPower")
        local v14 = u4
        local v15 = u5
        local v16
        if typeof(v15) == u2.WindPower then
            v16 = u5
        else
            v16 = nil
        end
        v14.WindPower = v16
    end)
    local u21 = u3:GetAttributeChangedSignal("WindSpeed"):Connect(function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u3
            [3] = u4
            [4] = u2
        --]]
        u6 = u3:GetAttribute("WindSpeed")
        local v18 = u4
        local v19 = u6
        local v20
        if typeof(v19) == u2.WindSpeed then
            v20 = u6
        else
            v20 = nil
        end
        v18.WindSpeed = v20
    end)
    local u25 = u3:GetAttributeChangedSignal("WindDirection"):Connect(function() --[[ Line: 40 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u3
            [3] = u4
            [4] = u2
        --]]
        u7 = u3:GetAttribute("WindDirection")
        local v22 = u4
        local v23 = u7
        local v24
        if typeof(v23) == u2.WindDirection then
            v24 = u7.Magnitude <= 0 and Vector3.new(0, 0, 0) or u7.Unit
        else
            v24 = nil
        end
        v22.WindDirection = v24
    end)
    local u26
    if u3:IsA("BasePart") then
        u26 = u3:GetPropertyChangedSignal("PivotOffset"):Connect(function() --[[ Line: 49 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
            --]]
            u4.PivotOffset = u3.PivotOffset
            u4.PivotOffsetInverse = u4.PivotOffset:Inverse()
        end)
    else
        u26 = nil
    end
    function u4.Destroy(_) --[[ Line: 57 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u21
            [3] = u25
            [4] = u26
            [5] = u4
        --]]
        u17:Disconnect()
        u21:Disconnect()
        u25:Disconnect()
        if u26 then
            u26:Disconnect()
        end
        table.clear(u4)
    end
    return u4
end
return v1