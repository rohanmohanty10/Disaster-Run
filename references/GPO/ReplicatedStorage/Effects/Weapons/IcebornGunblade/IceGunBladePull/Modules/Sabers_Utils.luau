 

local u1 = game:GetService("TweenService")
local u2 = require(script.Bezier)
local u27 = {
    ["GetBezier"] = function(_) --[[ Name: GetBezier, Line 7 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        return u2
    end,
    ["GetTweener"] = function(_) --[[ Name: GetTweener, Line 11 ]]
        if _G.saber_Tweener == nil then
            _G.saber_Tweener = require(script.Tweener)
            _G.saber_Tweener:Init()
        end
        return _G.saber_Tweener
    end,
    ["Lerp"] = function(_, p3, p4, p5) --[[ Name: Lerp, Line 19 ]]
        return p3 + (p4 - p3) * p5
    end,
    ["ScaleNumberSequence"] = function(_, p6, p7) --[[ Name: ScaleNumberSequence, Line 23 ]]
        local v8 = p6.Keypoints
        for v9 = 1, #v8 do
            v8[v9] = NumberSequenceKeypoint.new(v8[v9].Time, v8[v9].Value * p7, v8[v9].Envelope * p7)
        end
        return NumberSequence.new(v8)
    end,
    ["ScaleNumberRange"] = function(_, p10, p11) --[[ Name: ScaleNumberRange, Line 31 ]]
        return NumberRange.new(p10.Min * p11, p10.Max * p11)
    end,
    ["DivideEmitCount"] = function(_, p12, p13) --[[ Name: DivideEmitCount, Line 35 ]]
        for _, v14 in pairs(p12:GetDescendants()) do
            if v14:IsA("ParticleEmitter") then
                local v15 = v14:GetAttribute("EmitCount")
                if v15 then
                    v14:SetAttribute("EmitCount", v15 / p13)
                end
            end
        end
    end,
    ["Emit"] = function(_, p16) --[[ Name: Emit, Line 46 ]]
        for _, u17 in pairs(p16:GetDescendants()) do
            if u17:IsA("ParticleEmitter") then
                task.delay(u17:GetAttribute("EmitDelay") or 0, function() --[[ Line: 50 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                    --]]
                    u17:Emit(u17:GetAttribute("EmitCount") or 10)
                end)
            end
        end
    end,
    ["ToggleDescendants"] = function(_, p18, p19) --[[ Name: ToggleDescendants, Line 56 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        for _, v20 in pairs(p18:GetDescendants()) do
            if v20:IsA("ParticleEmitter") or (v20:IsA("Beam") or v20:IsA("Trail")) then
                v20.Enabled = p19 or not v20.Enabled
            elseif v20:IsA("PointLight") and typeof(p19) ~= "boolean" then
                u1:Create(v20, TweenInfo.new(0.5), {
                    ["Brightness"] = p19 or 0
                }):Play()
            end
        end
    end,
    ["TweenLightDescendants"] = function(_, p21, u22, u23, p24) --[[ Name: TweenLightDescendants, Line 68 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        for _, u25 in pairs(p21:GetDescendants()) do
            if not u25:IsA("PointLight") then
                task.delay(p24 or 0, function() --[[ Line: 71 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u25
                        [3] = u23
                        [4] = u22
                    --]]
                    local v26 = {
                        ["Brightness"] = u22 or 0
                    }
                    u1:Create(u25, TweenInfo.new(u23 or 0.5), v26):Play()
                end)
            end
        end
    end,
    ["ParticleScaler"] = {}
}
function u27.ParticleScaler.new(p28, p29) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u27
    --]]
    local u30 = {
        ["CurrentScale"] = 1,
        ["OldScale"] = 1,
        ["Particles"] = {}
    }
    for _, v31 in p28:GetDescendants() do
        if v31:IsA("ParticleEmitter") then
            local v32 = {
                ["Size"] = v31.Size,
                ["ZOffset"] = v31.ZOffset,
                ["Acceleration"] = v31.Acceleration,
                ["Speed"] = v31.Speed
            }
            u30.Particles[v31] = v32
        end
    end
    function u30.SetScale(_, p33) --[[ Line: 100 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        u30.OldScale = u30.CurrentScale
        u30.CurrentScale = p33
    end
    function u30.GetParticles(_) --[[ Line: 105 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        local v34 = {}
        for v35, _ in u30.Particles do
            table.insert(v34, v35)
        end
        return v34
    end
    function u30.Scale(_, p36) --[[ Line: 115 ]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u27
        --]]
        if u30.Particles[p36] then
            p36.Size = u27:ScaleNumberSequence(u30.Particles[p36].Size, u30.CurrentScale)
            p36.ZOffset = u30.Particles[p36].ZOffset * u30.CurrentScale
            p36.Acceleration = u30.Particles[p36].Acceleration * u30.CurrentScale
            p36.Speed = u27:ScaleNumberRange(u30.Particles[p36].Speed, u30.CurrentScale)
        end
    end
    function u30.ScaleAll(_) --[[ Line: 124 ]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u27
        --]]
        for v37, v38 in u30.Particles do
            v37.Size = u27:ScaleNumberSequence(v38.Size, u30.CurrentScale)
            v37.ZOffset = v38.ZOffset * u30.CurrentScale
            v37.Acceleration = v38.Acceleration * u30.CurrentScale
            v37.Speed = u27:ScaleNumberRange(v38.Speed, u30.CurrentScale)
        end
    end
    function u30.RestoreAll(_) --[[ Line: 133 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        for _, v39 in u30:GetParticles() do
            v39.Size = u30.Particles[v39].Size
            v39.ZOffset = u30.Particles[v39].ZOffset
            v39.Acceleration = u30.Particles[v39].Acceleration
            v39.Speed = u30.Particles[v39].Speed
        end
    end
    if p29 ~= nil then
        u30:SetScale(p29)
        u30:ScaleAll()
    end
    return u30
end
return u27