 

local v1 = {}
local u2 = workspace.Effects
local u3 = _G.tween
local function u7(p4, p5) --[[ Line: 10 ]]
    for _, v6 in p4:GetDescendants() do
        if v6:IsA("ParticleEmitter") then
            v6.Enabled = p5
        end
    end
end
local u8 = RaycastParams.new()
u8.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
u8.FilterType = Enum.RaycastFilterType.Include
function v1.start(_, p9) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u8
        [3] = u3
        [4] = u7
    --]]
    os.time()
    local v10 = script.Wind:Clone()
    v10:PivotTo(p9.HumanoidRootPart.CFrame)
    _G.particleEnabled(v10, false)
    v10.Parent = u2
    local v11 = script.CharWind:Clone()
    v11.Parent = u2
    v11.CFrame = p9.HumanoidRootPart.CFrame
    local v12 = Instance.new("WeldConstraint")
    v12.Parent = v11
    v12.Part0 = v11
    v12.Part1 = p9.HumanoidRootPart
    local v13 = _G.PlaySound(p9.PrimaryPart, script["Audio/GoldSurfStart"])
    v13.Parent = p9.PrimaryPart
    local v14 = script["Audio/GoldSurfLoop"]:Clone()
    v14.Parent = p9.PrimaryPart
    v14:Play()
    local v15 = 0
    while p9:GetAttribute("GoldenPathOn") ~= nil do
        local v16 = workspace:Raycast(p9.HumanoidRootPart.Position + p9.HumanoidRootPart.CFrame.LookVector * 5, Vector3.new(0, -20, 0), u8)
        if tick() - v15 >= 0.08 then
            v15 = tick()
            if v16 then
                local u17 = script.GoldPath:Clone()
                local v18 = CFrame.new(v16.Position, v16.Position + v16.Normal)
                local v19 = CFrame.Angles
                local v20 = math.random(0, 360)
                u17.CFrame = v18 * v19(-1.5707963267948966, math.rad(v20), 0) * CFrame.new(math.random(-200, 200) / 100, 0, 0)
                u17.Attachment.Dust.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v16.Instance.Color), ColorSequenceKeypoint.new(1, v16.Instance.Color) })
                u17.Parent = u2
                _G.customEmit(u17)
                u3(u17, {
                    0.3,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false
                }, {
                    ["Size"] = Vector3.new(11.48, 0.227, 10.134) * math.random(600, 1500) / 1000
                })
                u3(u17.PointLight, {
                    0.8,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false
                }, {
                    ["Range"] = 13
                })
                task.delay(0.75, function() --[[ Line: 67 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u17
                    --]]
                    u3(u17, {
                        0.7,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false
                    }, {
                        ["Size"] = Vector3.new(0.48, 0.227, 0.134)
                    })
                    u3(u17.PointLight, {
                        0.8,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false
                    }, {
                        ["Brightness"] = 0
                    })
                    _G.destroy(u17, 0.7)
                end)
            end
        end
        if v16 and v16.Instance ~= nil then
            _G.particleEnabled(v10, true)
            local v21 = v16.Position + Vector3.new(0, 2, 0)
            local v22 = (p9.PrimaryPart.CFrame * CFrame.new(0, 0, -100)).Position
            local v23 = v22.X
            local v24 = v21.Y
            local v25 = v22.Z
            local v26 = Vector3.new(v23, v24, v25)
            local v27 = v10.PrimaryPart
            local v28 = CFrame.lookAt
            local v29 = p9.PrimaryPart.Position.X
            local v30 = v21.Y
            local v31 = p9.PrimaryPart.Position.Z
            v27.CFrame = v28(Vector3.new(v29, v30, v31), v26)
        else
            _G.particleEnabled(v10, false)
        end
        task.wait()
    end
    u3(v14, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Volume"] = 0
    })
    _G.destroy(v14, 0.25)
    if v13 then
        u3(v13, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Volume"] = 0
        })
        _G.destroy(v13, 0.25)
    end
    _G.PlaySound(p9.PrimaryPart, script["Audio/GoldSurfEnd"])
    u7(v11, false)
    _G.destroy(v11, 2.7)
    v10.HumanoidRootPart.Anchored = true
    _G.destroy(v10, 2.7)
    for _, u32 in pairs(v10:GetDescendants()) do
        if u32:IsA("Beam") then
            task.spawn(function() --[[ Line: 106 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u32
                --]]
                u3(u32, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false
                }, {
                    ["Transparency"] = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) }),
                    ["TextureSpeed"] = 0.3
                })
            end)
        end
    end
end
return v1