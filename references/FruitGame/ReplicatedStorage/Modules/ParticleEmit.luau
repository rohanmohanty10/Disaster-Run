 

game:GetService("ReplicatedStorage")
game:GetService("Players")
local u1 = game:GetService("TweenService")
local u2 = {
    ["types"] = {
        ["Part"] = 1,
        ["BasePart"] = 1,
        ["MeshPart"] = 1,
        ["Attachment"] = 2,
        ["ParticleEmitter"] = 0,
        ["Beam"] = 3,
        ["PointLight"] = 4
    }
}
local u6 = {
    ["Beam"] = function(u3) --[[ Line: 18 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        task.spawn(function() --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u1
            --]]
            if u3:GetAttribute("Duration") then
                if not u3:GetAttribute("Duration") then
                    return
                end
                task.delay(u3:GetAttribute("EmitDelay"), function() --[[ Line: 21 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u1
                    --]]
                    local v4 = u3:GetAttribute("TweenDuration") or 0.2
                    u1:Create(u3, TweenInfo.new(v4), {
                        ["Width0"] = u3:GetAttribute("Width0"),
                        ["Width1"] = u3:GetAttribute("Width1")
                    }):Play()
                    task.wait(u3:GetAttribute("Duration"))
                    u1:Create(u3, TweenInfo.new(v4), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                end)
            end
        end)
    end,
    ["ParticleEmitter"] = function(p5) --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        u2:EmitParticle(p5)
    end,
    ["Trail"] = function(_) --[[ Line: 35 ]] end
}
u2.TypeHandler = {
    [0] = function(p7) --[[ Line: 41 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        u2:EmitParticle(p7)
    end,
    [1] = function(p8) --[[ Line: 45 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        for _, v9 in pairs(p8:GetDescendants()) do
            if u6[v9.ClassName] then
                u6[v9.ClassName](v9)
            end
        end
    end,
    [2] = function(p10) --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        for _, v11 in pairs(p10:GetChildren()) do
            if not v11.Enabled then
                u2:EmitParticle(v11)
            end
        end
    end,
    [3] = function(p12) --[[ Line: 61 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        for _, v13 in pairs(p12:GetDescendants()) do
            if u6[v13.ClassName] then
                u6[v13.ClassName](v13)
            end
        end
    end,
    [4] = function(p14) --[[ Line: 69 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        if u6[p14.ClassName] then
            u6[p14.ClassName](p14)
        end
    end
}
function u2.EmitParticle(_, u15) --[[ Line: 76 ]]
    if u15.ClassName == "ParticleEmitter" then
        local v16 = u15:GetAttribute("EmitDelay") or 0
        local u17 = u15:GetAttribute("EmitCount") or 0
        local u18 = u15:GetAttribute("EmitDuration") or 0
        task.delay(v16, function() --[[ Line: 83 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u17
                [3] = u18
            --]]
            if u15:IsA("ParticleEmitter") then
                u15:Emit(u17)
            end
            if u15:IsA("Sound") then
                local v19 = u15:Clone()
                v19.Parent = u15.Parent
                v19:Play()
                task.delay(v19.TimeLength, v19.Destroy, v19)
            end
            if u18 > 0 then
                task.defer(function() --[[ Line: 96 ]]
                    --[[
                    Upvalues:
                        [1] = u15
                        [2] = u18
                    --]]
                    u15.Enabled = true
                    task.wait(u18)
                    u15.Enabled = false
                end)
            end
        end)
    end
end
function u2.EmitBeam(_, p20, p21) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p20 then
        local u22 = p21.Duration or 1
        local v23 = p21.Speed or 0.2
        local v24 = p21.Delay or 0
        local u25 = TweenInfo.new(v23, p21.Style or Enum.EasingStyle.Linear)
        for _, u26 in pairs(p20:GetDescendants()) do
            if u26:IsA("Beam") then
                delay(v24, function() --[[ Line: 116 ]]
                    --[[
                    Upvalues:
                        [1] = u26
                        [2] = u1
                        [3] = u25
                        [4] = u22
                    --]]
                    local v27 = u26.Width0
                    local v28 = u26.Width1
                    u26.Width0 = 0
                    u26.Width1 = 0
                    u1:Create(u26, u25, {
                        ["Width0"] = v27,
                        ["Width1"] = v28
                    }):Play()
                    task.defer(function() --[[ Line: 123 ]]
                        --[[
                        Upvalues:
                            [1] = u22
                            [2] = u1
                            [3] = u26
                            [4] = u25
                        --]]
                        task.wait(u22)
                        u1:Create(u26, u25, {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        }):Play()
                    end)
                end)
            end
        end
    end
end
function u2.Resize(_, p29, p30) --[[ Line: 138 ]]
    local v31 = p29.Parent
    local v32 = Instance.new("Model")
    p29.Parent = v32
    v32:ScaleTo(p30)
    p29.Parent = v31
    v32:Destroy()
    return p29
end
function u2.EmitHandler(_, p33) --[[ Line: 149 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p33:IsA("Model") then
        for _, v34 in pairs(p33:GetChildren()) do
            u2:EmitHandler(v34)
        end
    elseif u2.types[p33.ClassName] then
        u2.TypeHandler[u2.types[p33.ClassName]](p33)
    end
end
function u2.ToggleEmit(_, p35, p36) --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if u6[p35.ClassName] then
        if p36 == nil then
            p35.Enabled = not p35.Enabled
        else
            p35.Enabled = p36
        end
    else
        for _, v37 in pairs(p35:GetDescendants()) do
            if u6[v37.ClassName] then
                if p36 == nil then
                    v37.Enabled = not v37.Enabled
                else
                    v37.Enabled = p36
                end
            end
        end
        return
    end
end
function u2.Cleanup(_, u38, p39) --[[ Line: 181 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    task.delay(p39 or 0, function() --[[ Line: 183 ]]
        --[[
        Upvalues:
            [1] = u38
            [2] = u1
        --]]
        if u38 then
            for _, v40 in pairs(u38:GetDescendants()) do
                if v40:IsA("ParticleEmitter") then
                    v40.Enabled = false
                end
                if v40:IsA("BasePart") or v40:IsA("MeshPart") then
                    u1:Create(v40, TweenInfo.new(0.5), {
                        ["Transparency"] = 1
                    }):Play()
                end
            end
            task.wait(10)
            u38:Destroy()
        end
    end)
end
function u2.Destroy(_, p41) --[[ Line: 201 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v42 = p41:GetDescendants()
    for _, _ in pairs(v42) do
        u2:ToggleEmit(p41, false)
    end
    task.delay(u2:GetMaxLifetime(v42), p41.Destroy, p41)
end
function u2.ParticleDestroy(_, p43) --[[ Line: 209 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    if p43 then
        local v44 = p43:GetDescendants()
        local v45 = u2:GetMaxLifetime(v44)
        for _, v46 in pairs(v44) do
            u2:ToggleEmit(p43, false)
            if v46.ClassName:match("Light") then
                u1:Create(v46, TweenInfo.new(v45), {
                    ["Brightness"] = 0
                }):Play()
            end
        end
        task.delay(v45, p43.Destroy, p43)
    end
end
function u2.WeldToPart(_, p47, p48) --[[ Line: 224 ]]
    if not (p47 and p48) then
        return false
    end
    local v49 = Instance.new("Weld")
    v49.Part0 = p47
    v49.Part1 = p48
    v49.Parent = p47
    return v49
end
function u2.EmitToParent(_, p50, p51) --[[ Line: 235 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p50 then
        if p51:IsA("BasePart") or p51:IsA("MeshPart") then
            for _, v52 in pairs(p51:GetChildren()) do
                v52.Parent = p50
                u2:EmitHandler(v52)
            end
            return p50
        end
        p51.Parent = p50
        u2:EmitHandler(p51)
    end
    return p50
end
function u2.GetMaxLifetime(_, p53) --[[ Line: 250 ]]
    local v54 = 0
    for _, v55 in pairs(p53) do
        local v56
        if v55:IsA("ParticleEmitter") then
            v56 = v55.Lifetime.Max + (v55:GetAttribute("EmitDuration") or 0)
            if v54 > v56 then
                v56 = v54
            end
        else
            v56 = v54
        end
        if v55:IsA("Trail") then
            v54 = v55.Lifetime
            if v56 > v54 then
                v54 = v56
            end
        else
            v54 = v56
        end
    end
    return v54
end
return u2