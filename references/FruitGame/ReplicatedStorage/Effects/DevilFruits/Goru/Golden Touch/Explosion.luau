 

local u1 = require(script.Info)
local u2 = workspace.Effects
local u3 = _G.tween
local u4 = RaycastParams.new()
u4.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
u4.FilterType = Enum.RaycastFilterType.Include
local function u9(p5) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u1
    --]]
    local v6 = script.AuraWind:Clone()
    v6.Parent = u2
    v6:PivotTo(CFrame.new(p5.HumanoidRootPart.Position + Vector3.new(0, 1, 0)))
    v6.FlashWave.Decal.Transparency = 0.87
    v6.CurvedImage.Decal.Transparency = 0.87
    u3(v6.FlashWave.Decal, {
        1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Transparency"] = 1
    })
    u3(v6.FlashWave.Mesh, {
        1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Scale"] = v6.FlashWave.Mesh.Scale * 2
    })
    u3(v6.CurvedImage.Decal, {
        1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Transparency"] = 1
    })
    u3(v6.CurvedImage.Mesh, {
        1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Scale"] = v6.CurvedImage.Mesh.Scale * 2
    })
    _G.destroy(v6, 2)
    local v7 = script.SharpWindMesh:Clone()
    v7.Parent = u2
    v7.CFrame = CFrame.new(p5.HumanoidRootPart.Position - Vector3.new(0, 1, 0))
    u3(v7.Mesh, {
        0.6,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.In,
        0,
        false
    }, {
        ["Scale"] = Vector3.new(12, 7, 12)
    })
    u3(v7.Decal, {
        0.6,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.In,
        0,
        false
    }, {
        ["Transparency"] = 0.83
    })
    for _, v8 in u1.sharpWind do
        v7.Decal.Texture = v8
        game["Run Service"].Heartbeat:Wait()
        task.wait(0.025)
    end
    v7.Decal.Transparency = 1
    _G.destroy(v7, 1.4)
end
local function u17(p10) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    _G.PlaySound(p10, script.explosionSFX)
    local v11 = script.Explosion:Clone()
    v11.Parent = u2
    v11.Position = p10.UpperTorso.Position
    _G.customEmit(v11)
    _G.destroy(v11, 4)
    v11.Light.Brightness = 10
    u3(v11.Light, {
        1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.In,
        0,
        false
    }, {
        ["Brightness"] = 0
    })
    local v12 = workspace:Raycast(v11.Position, Vector3.new(0, -10, 0), u4)
    if v12 then
        for _, v13 in v11.recolor:GetChildren() do
            if v13:IsA("ParticleEmitter") then
                v13.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v12.Instance.Color), ColorSequenceKeypoint.new(1, v12.Instance.Color) })
            end
        end
        local v14 = v12.Position + Vector3.new(0, 0.1, 0)
        local v15 = v12.Normal
        v11.Crack.WorldCFrame = CFrame.new(v14, v14 + v15) * CFrame.Angles(1.5707963267948966, 0, 0)
    else
        v11.Crack:Destroy()
        v11.recolor:Destroy()
    end
    local v16 = p10.UpperTorso.Position
    _G.PlayEffect("GroundRocks4", nil, {
        ["Segments"] = 24,
        ["Position"] = v16 + Vector3.new(0, 1, 0),
        ["DistanceRandomness"] = Vector2.new(0.25, 1),
        ["Duration"] = 4,
        ["TweenDuration"] = 2,
        ["Radius"] = 12,
        ["Direction"] = Vector3.new(0, -10, 0),
        ["Angle"] = 0.4363323129985824
    })
end
local function u22(p18) --[[ Line: 115 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v19 = script.BeamWind:Clone()
    v19.Parent = u2
    v19.Position = p18.HumanoidRootPart.Position
    v19.WindBeamFX.Position = p18.HumanoidRootPart.Position + Vector3.new(0, 15, 0)
    _G.destroy(v19, 3)
    for _, u20 in v19:GetDescendants() do
        if u20:IsA("Beam") then
            task.spawn(function() --[[ Line: 123 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u20
                --]]
                u3(u20, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In,
                    0,
                    false
                }, {
                    ["Transparency"] = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.1, 0.985),
                        NumberSequenceKeypoint.new(0.2, 0.957),
                        NumberSequenceKeypoint.new(0.376, 0.376),
                        NumberSequenceKeypoint.new(0.4, 0.2),
                        NumberSequenceKeypoint.new(0.6, 0.909),
                        NumberSequenceKeypoint.new(1, 1)
                    }),
                    ["TextureSpeed"] = 1.5
                })
            end)
        end
    end
    task.wait(0.25)
    for _, u21 in v19:GetDescendants() do
        if u21:IsA("Beam") then
            task.spawn(function() --[[ Line: 144 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u21
                --]]
                u3(u21, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In,
                    0,
                    false
                }, {
                    ["Transparency"] = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) }),
                    ["TextureSpeed"] = 0.6
                })
            end)
        end
    end
end
return function(_, u23, p24) --[[ Line: 159 ]]
    --[[
    Upvalues:
        [1] = u22
        [2] = u9
        [3] = u17
    --]]
    local v25 = p24 - 0.4
    _G.PlayEffect("GoldenStatue", nil, u23, v25)
    task.spawn(function() --[[ Line: 161 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u23
        --]]
        u22(u23)
    end)
    task.spawn(function() --[[ Line: 166 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u23
        --]]
        u9(u23)
    end)
    task.spawn(function() --[[ Line: 170 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u23
        --]]
        u17(u23)
    end)
end