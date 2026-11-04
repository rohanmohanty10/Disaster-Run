 

local u7 = {
    ["ScaleNumberSequence"] = function(_, p1, p2) --[[ Name: ScaleNumberSequence, Line 3 ]]
        local v3 = p1.Keypoints
        for v4 = 1, #v3 do
            v3[v4] = NumberSequenceKeypoint.new(v3[v4].Time, v3[v4].Value * p2, v3[v4].Envelope * p2)
        end
        return NumberSequence.new(v3)
    end,
    ["ScaleNumberRange"] = function(_, p5, p6) --[[ Name: ScaleNumberRange, Line 11 ]]
        return NumberRange.new(p5.Min * p6, p5.Max * p6)
    end,
    ["ParticleScaler"] = {}
}
function u7.ParticleScaler.new(p8, p9) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local u10 = {
        ["CurrentScale"] = 1,
        ["OldScale"] = 1,
        ["Particles"] = {}
    }
    for _, v11 in p8:GetDescendants() do
        if v11:IsA("ParticleEmitter") then
            local v12 = {
                ["Size"] = v11.Size,
                ["ZOffset"] = v11.ZOffset,
                ["Acceleration"] = v11.Acceleration,
                ["Speed"] = v11.Speed
            }
            u10.Particles[v11] = v12
        end
    end
    function u10.SetScale(_, p13) --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        u10.OldScale = u10.CurrentScale
        u10.CurrentScale = p13
    end
    function u10.GetParticles(_) --[[ Line: 41 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        local v14 = {}
        for v15, _ in u10.Particles do
            table.insert(v14, v15)
        end
        return v14
    end
    function u10.Scale(_, p16) --[[ Line: 51 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u7
        --]]
        if u10.Particles[p16] then
            p16.Size = u7:ScaleNumberSequence(u10.Particles[p16].Size, u10.CurrentScale)
            p16.ZOffset = u10.Particles[p16].ZOffset * u10.CurrentScale
            p16.Acceleration = u10.Particles[p16].Acceleration * u10.CurrentScale
            p16.Speed = u7:ScaleNumberRange(u10.Particles[p16].Speed, u10.CurrentScale)
        end
    end
    function u10.ScaleAll(_) --[[ Line: 60 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u7
        --]]
        for v17, v18 in u10.Particles do
            v17.Size = u7:ScaleNumberSequence(v18.Size, u10.CurrentScale)
            v17.ZOffset = v18.ZOffset * u10.CurrentScale
            v17.Acceleration = v18.Acceleration * u10.CurrentScale
            v17.Speed = u7:ScaleNumberRange(v18.Speed, u10.CurrentScale)
        end
    end
    function u10.RestoreAll(_) --[[ Line: 69 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        for _, v19 in u10:GetParticles() do
            v19.Size = u10.Particles[v19].Size
            v19.ZOffset = u10.Particles[v19].ZOffset
            v19.Acceleration = u10.Particles[v19].Acceleration
            v19.Speed = u10.Particles[v19].Speed
        end
    end
    if p9 ~= nil then
        u10:SetScale(p9)
        u10:ScaleAll()
    end
    return u10
end
function u7.start(_, p20, u21, p22) --[[ Line: 86 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p20 ~= nil then
        local u23 = u7.ParticleScaler.new(p20, u21.startScale)
        local u24 = Instance.new("NumberValue")
        u24.Value = u21.startScale
        local u25 = game:GetService("TweenService"):Create(u24, TweenInfo.new(p22), {
            ["Value"] = u21.endScale
        })
        u24.Changed:Connect(function() --[[ Line: 104 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u24
                [3] = u25
                [4] = u23
            --]]
            if u21.customEnd == nil or u21.customEnd() ~= true then
                u23:SetScale(u24.Value)
                u23:ScaleAll()
            else
                u24:Destroy()
                u25:Destroy()
            end
        end)
        u24.Parent = script
        u25.Completed:Connect(function() --[[ Line: 114 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u25
            --]]
            _G.destroy(u24, 1)
            u25:Destroy()
        end)
        u25:Play()
    end
end
return u7