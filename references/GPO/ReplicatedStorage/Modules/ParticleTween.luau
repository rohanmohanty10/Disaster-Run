 

local v1 = {}
local u2 = require(script.BoatTween)
function v1.ResizeParticles(_, p3, p4, p5, p6, p7) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = {
        ["ParticleEmitter"] = {
            ["Size"] = "Size",
            ["Speed"] = "Speed",
            ["Acceleration"] = "Acceleration"
        },
        ["Beam"] = {
            ["Width0"] = "Width0",
            ["Width1"] = "Width1",
            ["CurveSize0"] = "CurveSize0",
            ["CurveSize1"] = "CurveSize1"
        },
        ["Trail"] = {}
    }
    local v23 = {
        ["NumberSequence"] = function(p9, p10) --[[ Line: 24 ]]
            local v11 = {}
            for v12, v13 in p9.Keypoints do
                v11[v12] = NumberSequenceKeypoint.new(v13.Time, v13.Value * p10, v13.Envelope)
            end
            return NumberSequence.new(v11)
        end,
        ["NumberRange"] = function(p14, p15) --[[ Line: 33 ]]
            return NumberRange.new(p14.Min * p15, p14.Max * p15)
        end,
        ["number"] = function(p16, p17) --[[ Line: 37 ]]
            return p16 * p17
        end,
        ["Vector3"] = function(p18, p19) --[[ Line: 41 ]]
            local v20 = p18.X * p19
            local v21 = p18.Y * p19
            local v22 = p18.Z * p19
            return Vector3.new(v20, v21, v22)
        end
    }
    for _, v24 in pairs(p3:GetDescendants()) do
        local v25 = v8[v24.ClassName]
        if v25 then
            for v26, _ in pairs(v25) do
                local v27 = v24[v26]
                local v28 = v23[typeof(v27)](v27, p4)
                if v28 then
                    local v29 = {
                        ["Time"] = p5,
                        ["Goal"] = {
                            [v26] = v28
                        },
                        ["EasingStyle"] = p6,
                        ["EasingDirection"] = p7
                    }
                    local u30 = u2:Create(v24, v29)
                    u30:Play()
                    task.defer(function() --[[ Line: 64 ]]
                        --[[
                        Upvalues:
                            [1] = u30
                        --]]
                        u30.Completed:Wait()
                        u30:Destroy()
                    end)
                end
            end
        end
    end
end
return v1