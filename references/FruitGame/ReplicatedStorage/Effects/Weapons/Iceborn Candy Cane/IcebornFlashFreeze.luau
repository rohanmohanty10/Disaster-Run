 

local v1 = {}
local _ = game:GetService("TweenService")
game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = require(v2.Modules.Client.WeaponVFXRecolor)
setmetatable({}, {
    ["__mode"] = "k"
})
local v4 = RaycastParams.new()
v4.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
v4.FilterType = Enum.RaycastFilterType.Include
local _ = _G.tween
local function u13(p5, p6) --[[ Line: 32 ]]
    local v7 = p5.Keypoints
    if #v7 == 0 then
        return 0, 0
    end
    if p6 <= v7[1].Time then
        return v7[1].Value, v7[1].Envelope
    end
    if v7[#v7].Time <= p6 then
        return v7[#v7].Value, v7[#v7].Envelope
    end
    for v8 = 1, #v7 - 1 do
        local v9 = v7[v8]
        local v10 = v7[v8 + 1]
        if v9.Time <= p6 and p6 <= v10.Time then
            local v11 = v10.Time - v9.Time
            local v12 = v11 <= 0 and 0 or (p6 - v9.Time) / v11
            return v9.Value + (v10.Value - v9.Value) * v12, v9.Envelope + (v10.Envelope - v9.Envelope) * v12
        end
    end
    return v7[#v7].Value, v7[#v7].Envelope
end
local function _(p14, p15, p16) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    local v17 = p15.Keypoints
    local v18 = table.create(#v17)
    for v19, v20 in ipairs(v17) do
        local v21, v22 = u13(p14, v20.Time)
        local v23, v24 = u13(p15, v20.Time)
        v18[v19] = NumberSequenceKeypoint.new(v20.Time, v21 + (v23 - v21) * p16, v22 + (v24 - v22) * p16)
    end
    return NumberSequence.new(v18)
end
function v1.start(_, p25) --[[ Line: 113 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if p25.ActionType == "Fade" then
        local u26 = p25.floorModel
        local v27 = p25.startTime - workspace:GetServerTimeNow()
        task.delay(v27 / 2, function() --[[ Line: 119 ]]
            --[[
            Upvalues:
                [1] = u26
            --]]
            _G.particleEnabled(u26, false)
        end)
        task.delay(v27, function() --[[ Line: 123 ]]
            --[[
            Upvalues:
                [1] = u26
            --]]
            local function v29(p28) --[[ Line: 126 ]]
                _G.tween(p28, {
                    0.5,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["CFrame"] = p28.CFrame * CFrame.Angles(0, 2.0943951023931953, 0)
                })
            end
            v29(u26.iceFloor)
            v29(u26.NeonOutline)
            _G.tween(u26.iceFloor.Attachment.PointLight, {
                0.5,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0
            })
            _G.destroy(u26, 5)
        end)
    elseif p25.ActionType == "Intro" then
        local v30 = p25.Character
        local v31 = p25.startCFrame
        local v32, v33, _ = _G.getRayFloor(v31, 10)
        local v34 = (not v32 and 1 or (v31.Position - v33).Magnitude) + 0.3
        local v35 = script.Transition:Clone()
        u3.apply(v35, p25.Character)
        v35.CFrame = v31 * CFrame.new(0, -v34, -4)
        v35.Parent = workspace.Effects
        _G.destroy(v35, 5)
        _G.tween(v35, {
            0.2,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v35.CFrame + v31.LookVector * 12
        })
        local v36 = CFrame.new(v30.RightHand.Position)
        local v37 = script.Slam:Clone()
        u3.apply(v37, p25.Character)
        _G.vfxToFloor(v37, {
            ["StartCFrame"] = v36,
            ["Depth"] = 6
        })
        task.wait(0.2)
        _G.particleEnabled(v35, false)
        _G.destroy(v35, 3)
    end
end
return v1