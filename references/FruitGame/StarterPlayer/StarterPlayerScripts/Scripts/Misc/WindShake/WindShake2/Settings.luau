 

local v1 = {}
local u2 = {
    ["WindPower"] = "number",
    ["WindSpeed"] = "number",
    ["WindDirection"] = "Vector3"
}
function v1.new(u3, u4) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u5 = table.create(3)
    local u6 = u3:GetAttribute("WindPower")
    local u7 = u3:GetAttribute("WindSpeed")
    local u8 = u3:GetAttribute("WindDirection")
    u5.WindPower = typeof(u6) == u2.WindPower and u6 or u4.WindPower
    u5.WindSpeed = typeof(u7) == u2.WindSpeed and u7 or u4.WindSpeed
    u5.WindDirection = typeof(u8) == u2.WindDirection and u8 or u4.WindDirection
    local u10 = u3:GetAttributeChangedSignal("WindPower"):Connect(function() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u3
            [3] = u5
            [4] = u2
            [5] = u4
        --]]
        u6 = u3:GetAttribute("WindPower")
        local v9 = u6
        u5.WindPower = typeof(v9) == u2.WindPower and u6 or u4.WindPower
    end)
    local u12 = u3:GetAttributeChangedSignal("WindSpeed"):Connect(function() --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u3
            [3] = u5
            [4] = u2
            [5] = u4
        --]]
        u7 = u3:GetAttribute("WindSpeed")
        local v11 = u7
        u5.WindSpeed = typeof(v11) == u2.WindSpeed and u7 or u4.WindSpeed
    end)
    local u14 = u3:GetAttributeChangedSignal("WindDirection"):Connect(function() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u3
            [3] = u5
            [4] = u2
            [5] = u4
        --]]
        u8 = u3:GetAttribute("WindDirection")
        local v13 = u8
        u5.WindDirection = typeof(v13) == u2.WindDirection and u8 or u4.WindDirection
    end)
    function u5.Destroy(_) --[[ Line: 41 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u12
            [3] = u14
            [4] = u5
        --]]
        u10:Disconnect()
        u12:Disconnect()
        u14:Disconnect()
        table.clear(u5)
    end
    return u5
end
return v1