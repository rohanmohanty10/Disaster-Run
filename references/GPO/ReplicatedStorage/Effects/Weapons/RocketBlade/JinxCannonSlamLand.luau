 

game:GetService("RunService")
local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v2 = {}
local function u7(p3, p4) --[[ Line: 8 ]]
    local v5 = p3.Keypoints
    for v6 = 1, #v5 do
        v5[v6] = NumberSequenceKeypoint.new(v5[v6].Time, v5[v6].Value * p4, v5[v6].Envelope * p4)
    end
    return NumberSequence.new(v5)
end
function v2.start(_, p8, p9) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u7
    --]]
    local v10 = p8.PrimaryPart or p8:WaitForChild("HumanoidRootPart")
    if _G.checkRenderDistance(v10.Position) == false then
        return
    end
    local v11 = RaycastParams.new()
    v11.FilterType = Enum.RaycastFilterType.Whitelist
    v11.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
    local v12 = v10.CFrame
    for v13 = 1, 3 do
        if p8:FindFirstChild("PB") then
            break
        end
        local v14 = v12 * CFrame.new(0, 0, -(v13 * (v13 * 4) + 6))
        local v15 = workspace:Raycast(v14.Position, v14.UpVector * Vector3.new(0, -25, 0), v11)
        if v15 then
            local v16 = CFrame.new(v15.Position, v15.Position + v15.Normal)
            local v17 = script.Jinx2:Clone()
            if p9 == true then
                v17:Destroy()
                v17 = script.Jinx2Pres:Clone()
            end
            u1.apply(v17, p8)
            local v18 = CFrame.Angles
            local v19 = math.random(0, 360)
            v17.CFrame = v16 * v18(-1.5707963267948966, math.rad(v19), 0)
            v17.Parent = workspace.Effects
            if v15.Instance then
                v17.Attachment.Rocks.Color = ColorSequence.new(v15.Instance.Color)
            end
            for _, v20 in ipairs(v17:GetDescendants()) do
                if v20:IsA("ParticleEmitter") then
                    local v21 = v13 / 2
                    v20.Size = u7(v20.Size, v21)
                    v20.ZOffset = v20.ZOffset * v21
                    v20.Acceleration = v20.Acceleration * v21
                    local v22 = v20.Speed
                    v20.Speed = NumberRange.new(v22.Min * v21, v22.Max * v21)
                end
            end
            _G.customEmit(v17)
            _G.destroy(v17, 6)
            local v23 = script.MeshPart:Clone()
            u1.apply(v23, p8)
            v23.CFrame = v16 * CFrame.Angles(1.5707963267948966, 0, 0)
            v23.Parent = workspace.Effects
            _G.tween(v23, {
                0.5,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(5, 6, 5) * v13,
                ["Transparency"] = 1,
                ["CFrame"] = v16 * CFrame.new(0, 0, -(v13 * 6 / 2)) * CFrame.Angles(1.5707963267948966, -4.101523742186674, 0)
            })
            _G.destroy(v23, 0.5)
            local v24 = script.forcefield:Clone()
            u1.apply(v24, p8)
            local v25 = CFrame.Angles
            local v26 = math.random(0, 180)
            v24.CFrame = v16 * v25(-1.5707963267948966, math.rad(v26), 0)
            v24.Parent = workspace.Effects
            _G.tween(v24, {
                0.5,
                "Back",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(32, 32, 32),
                ["Transparency"] = 1
            })
            _G.destroy(v24, 0.5)
            local v27 = script.BeanWind:Clone()
            u1.apply(v27, p8)
            v27.CFrame = v16 * CFrame.new(0, 0, -5) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
            v27.Parent = workspace.Effects
            local u28 = script.scorch:Clone()
            u1.apply(u28, p8)
            local v29 = CFrame.Angles
            local v30 = math.random(0, 360)
            u28.CFrame = v16 * v29(-1.5707963267948966, math.rad(v30), 0)
            u28.Parent = workspace.Effects
            _G.PlaySound(u28, script["TripleImpactBoom" .. v13], {
                ["Volume"] = v13 / 10 + 0.4
            })
            _G.shakenear(u28.Position, 125, 100, 70, -1)
            _G.tween(u28, {
                0.1,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(10, 0.15, 10) * v13
            })
            for _, v31 in ipairs(u28:GetDescendants()) do
                if v31:IsA("Decal") then
                    _G.tween(v31, {
                        0.5,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 0.35
                    })
                end
            end
            task.delay(3, function() --[[ Line: 88 ]]
                --[[
                Upvalues:
                    [1] = u28
                --]]
                for _, v32 in ipairs(u28:GetDescendants()) do
                    if v32:IsA("Decal") then
                        _G.tween(v32, {
                            2,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1
                        })
                    end
                end
            end)
            _G.tween(v17.PointLight, {
                0.2,
                "Quad",
                Enum.EasingDirection.InOut,
                0,
                true,
                0
            }, {
                ["Brightness"] = 20
            })
            _G.destroy(u28, 6)
            _G.tween(v27.Mesh, {
                1.5,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(2, 2, 2) * v13
            })
            _G.tween(v27.Decal, {
                1.5,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.tween(v27, {
                1.5,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v16 * CFrame.new(0, 0, -(v13 * 2 / 2)) * CFrame.Angles(-1.5707963267948966, -2.181661564992912, 0)
            })
            _G.destroy(v27, 1.5)
        end
        task.wait(0.15)
    end
end
return v2