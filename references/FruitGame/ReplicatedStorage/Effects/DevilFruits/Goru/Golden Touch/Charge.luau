 

local u1 = workspace.Effects
local u2 = require(game.ReplicatedStorage.Modules.BoatTween)
local function u6(p3, p4) --[[ Line: 9 ]]
    for _, v5 in p3:GetDescendants() do
        if v5:IsA("ParticleEmitter") then
            v5.Enabled = p4
        end
    end
end
local function u12(p7) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for _, u8 in p7:GetDescendants() do
        if u8:IsA("ParticleEmitter") and u8.Name ~= "Lightning" then
            task.spawn(function() --[[ Line: 20 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u8
                --]]
                local v9 = u2
                local v10 = u8
                local v11 = {
                    ["Time"] = 1.5,
                    ["EasingStyle"] = "Quad",
                    ["EasingDirection"] = "Out",
                    ["DelayTime"] = 0.6,
                    ["RepeatCount"] = 0,
                    ["StepType"] = "Heartbeat",
                    ["Goal"] = {
                        ["Size"] = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) })
                    }
                }
                v9:Create(v10, v11)
            end)
        end
    end
end
return function(_, p13) --[[ Name: chargeParticles, Line 40 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u12
        [3] = u6
    --]]
    local _, v14, _ = _G.getRayFloor(p13.PrimaryPart.CFrame, 5)
    local v15 = script.Suck:Clone()
    v15.Parent = u1
    v15.Position = v14
    local v16 = script.Charge.Attachment:Clone()
    v16.Parent = p13.UpperTorso
    for _, v17 in v16:GetDescendants() do
        if v17:IsA("ParticleEmitter") then
            local v18 = {}
            for _, v19 in pairs(v17.Size.Keypoints) do
                local v20 = NumberSequenceKeypoint.new
                local v21 = v19.Time
                local v22 = v19.Value * 0.25
                local v23 = v19.Envelope * 0.25
                table.insert(v18, v20(v21, v22, v23))
            end
            _G.tween(v17, {
                1.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Size"] = NumberSequence.new(v18)
            })
        end
    end
    _G.PlaySound(p13.UpperTorso, script.chargeSFX)
    u12(v16)
    u12(v15)
    local v24 = Instance.new("Highlight")
    v24.OutlineTransparency = 1
    v24.DepthMode = Enum.HighlightDepthMode.Occluded
    v24.FillTransparency = 1
    v24.OutlineColor = Color3.fromRGB(48, 48, 48)
    v24.FillColor = Color3.fromRGB(207, 153, 67)
    v24.Parent = p13
    _G.tween(v16.Light, {
        2,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0.3,
        false
    }, {
        ["Brightness"] = 2
    })
    _G.tween(v24, {
        0.7,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["FillTransparency"] = 0.4
    })
    task.wait(0.4)
    v16.Light:Destroy()
    u6(v15, false)
    u6(v16, false)
    _G.destroy(v16, 3)
    _G.destroy(v15, 3)
    v24:Destroy()
end