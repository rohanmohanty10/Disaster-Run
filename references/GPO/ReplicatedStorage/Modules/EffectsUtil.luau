 

local u8 = {
    ["Emit"] = function(_, p1) --[[ Name: Emit, Line 3 ]]
        for _, v2 in ipairs(p1:GetDescendants()) do
            if v2:IsA("ParticleEmitter") then
                v2:Emit(v2:GetAttribute("EmitCount"))
            end
        end
    end,
    ["ToggleEnabled"] = function(_, p3, p4) --[[ Name: ToggleEnabled, Line 11 ]]
        for _, v5 in ipairs(p3:GetDescendants()) do
            if v5:IsA("ParticleEmitter") then
                v5.Enabled = p4
            end
        end
    end,
    ["DelayEmit"] = function(_, u6, p7) --[[ Name: DelayEmit, Line 19 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        task.delay(p7, function() --[[ Line: 20 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u6
            --]]
            u8:Emit(u6)
        end)
    end
}
return u8