 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local u3 = { 0.4, "Sine", Enum.EasingDirection.Out }
local u4 = { 0.2, "Quad", Enum.EasingDirection.Out }
function windScaleToOffset(p5)
    return 0.365625 * p5 - 0.525
end
function v1.start(_, p6) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
    --]]
    if _G.checkRenderDistance(p6.PrimaryPart.Position) ~= false then
        local v7 = p6.HumanoidRootPart
        local v8 = p6.RightHand
        _G.PlaySound(v8.CFrame, script.StringBulletFire)
        local u9 = CFrame.new(v8.Position, v8.Position + v7.CFrame.LookVector) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -3, 0)
        local v10 = Instance.new("Attachment")
        v10.WorldCFrame = u9 * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0, 4)
        v10.Parent = workspace.Terrain
        _G.destroy(v10, 1)
        for _, v11 in script.StartParticles:GetChildren() do
            local v12 = v11:Clone()
            v12.Parent = v10
            _G.customEmit(v12)
            _G.destroy(v12, 1)
        end
        local u13 = nil
        task.spawn(function() --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u4
                [3] = u13
            --]]
            local v14 = script.WindRing:Clone()
            v14.CFrame = u9 * CFrame.new(0, 2, 0)
            v14.Mesh.Scale = Vector3.new(0, 18, 0)
            v14.Parent = workspace.Effects
            _G.tween(v14.Mesh, u4, {
                ["Scale"] = Vector3.new(6, 30, 6)
            })
            _G.tween(v14.Decal, u4, {
                ["Transparency"] = 1
            })
            _G.destroy(v14, 1)
            task.wait(0.03333333333333333)
            local v15 = script.WindRing:Clone()
            v15.CFrame = u9 * CFrame.new(0, -1, 0)
            v15.Mesh.Scale = Vector3.new(0, 0, 0)
            v15.Parent = workspace.Effects
            _G.tween(v15.Mesh, u4, {
                ["Scale"] = Vector3.new(5, 18, 5)
            })
            _G.tween(v15.Decal, u4, {
                ["Transparency"] = 1
            })
            _G.destroy(v15, 1)
            for v16 = 1, 10 do
                task.wait(v16 / 120)
                local v17 = script.WindRing:Clone()
                v17.CFrame = u13.CFrame
                v17.Mesh.Scale = Vector3.new(0, 0, 0)
                v17.Parent = workspace.Effects
                local v18 = _G.tween
                local v19 = v17.Mesh
                local v20 = u4
                local v21 = {}
                local v22 = 4 - v16 / 3
                local v23 = 4 - v16 / 3
                v21.Scale = Vector3.new(v22, 18, v23)
                v18(v19, v20, v21)
                _G.tween(v17.Decal, u4, {
                    ["Transparency"] = 1
                })
                _G.destroy(v17, 1)
            end
        end)
        u13 = script.Main:Clone()
        local v24 = u13.Start
        local v25 = math.random(0, 360)
        v24.Orientation = Vector3.new(0, v25, 0)
        u13.CFrame = u9
        u13.Parent = workspace.Effects
        local u26 = u13
        for _, v27 in u13.Beams:GetChildren() do
            v27.Attachment1 = v10
            _G.tween(v27, u3, {
                ["Transparency"] = NumberSequence.new(1)
            })
            local v28 = math.random(75, 150) / 10
            local v29 = math.random(1, 2) == 2 and -1 or 1
            v27.CurveSize0 = v28 * v29
            v27.CurveSize1 = v28 * v29 * -1
            u2:Create(v27, TweenInfo.new(1.5, Enum.EasingStyle.Elastic), {
                ["CurveSize0"] = 0,
                ["CurveSize1"] = 0
            }):Play()
        end
        for _, v30 in u26.Wind:GetChildren() do
            v30.Acceleration = v7.CFrame.LookVector * -50
        end
        task.delay(0.4, function() --[[ Line: 90 ]]
            --[[
            Upvalues:
                [1] = u26
            --]]
            local v31 = u26.Wind
            v31.Position = Vector3.new(0, 10000, 0)
            v31.Parent = workspace.Terrain
            _G.destroy(v31, 1)
        end)
        _G.tween(u26, { 0.5, "Sine", Enum.EasingDirection.Out }, {
            ["CFrame"] = u26.CFrame * CFrame.new(0, -50, 0)
        })
        _G.destroy(u26, 0.5)
        _G.tween(u26.Decal, u3, {
            ["Transparency"] = 1
        })
        _G.tween(u26.Start.ParticleEmitter, u3, {
            ["Transparency"] = NumberSequence.new(1)
        })
        local v32 = script.Wind:Clone()
        local v33 = Instance.new("Weld")
        v33.Part0 = u26
        v33.Part1 = v32
        v32.Mesh.Scale = Vector3.new(4, 5, 4)
        local v34 = v32.Mesh
        local v35 = windScaleToOffset(5)
        v34.Offset = Vector3.new(0, v35, 0)
        v33.Parent = v32
        v32.Parent = workspace.Effects
        local v36 = _G.tween
        local v37 = v32.Mesh
        local v38 = { 0.5, "Sine", Enum.EasingDirection.Out }
        local v39 = {
            ["Scale"] = Vector3.new(3, 75, 3)
        }
        local v40 = windScaleToOffset(75)
        v39.Offset = Vector3.new(0, v40, 0)
        v36(v37, v38, v39)
        _G.tween(v32.Decal, u3, {
            ["Transparency"] = 1
        })
        _G.destroy(v32, 0.5)
    end
end
return v1