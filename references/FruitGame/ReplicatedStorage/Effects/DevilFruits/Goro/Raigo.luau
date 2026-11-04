 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
require(game.ReplicatedStorage.Modules.GLightning)
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u3 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
function v1.start(_, u4, p5, u6) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if u4 == nil then
        return
    end
    if _G.checkRenderDistance(u4.PrimaryPart.Position) == false then
        return
    end
    if p5 == "effect" then
        local v7 = u4.PrimaryPart.Size.X
        local v8 = u4.PrimaryPart.CFrame
        local v9 = v8 * CFrame.new(0, 0, 0)
        while true do
            if _G.checkRenderDistance(u4.PrimaryPart.Position) == true and v7 <= (v9.Position - u4.PrimaryPart.Position).Magnitude then
                local v10 = CFrame.new(u4.PrimaryPart.CFrame.Position, v8.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, v7 / 2, 0)
                local v11 = _G.PlayEffect
                local v12 = v10 * CFrame.new(0, -v7 / 2, 0)
                local v13 = BrickColor.new("White")
                local v14 = v7 * 2
                local v15 = v7 / 10
                local v16 = v7 * 2
                local v17 = Vector3.new(v14, v15, v16)
                local v18 = v7 / 10
                v11("Shockwave2", nil, v12, v10, v13, v17, Vector3.new(v7, v18, v7), v7 / 100, 0, Enum.EasingStyle.Quad, Color3.fromRGB(89, 161, 255), Enum.Material.Neon, "Rings")
                _G.PlaySound(u4.PrimaryPart, script.sfx, {
                    ["RollOffMaxDistance"] = v7 * 10,
                    ["RollOffMinDistance"] = v7 * 4
                })
                v9 = u4.PrimaryPart.CFrame
            end
            game["Run Service"].Heartbeat:Wait()
            if u4.PrimaryPart.Anchored == true or u4.Parent == nil then
                return
            end
        end
    else
        if p5 ~= "charge" then
            local u19 = CFrame.new(u4.PrimaryPart.Position)
            local u20 = u4.PrimaryPart.Size.X
            local v21 = u20 / 7
            local v22 = _G.PlayEffect
            local v23 = u19 * CFrame.new(0, u20, 0)
            local v24 = u19 * CFrame.new(0, -u20 / 2, 0)
            local v25 = BrickColor.new("White")
            local v26 = u20 / 5
            local v27 = u20 / 5
            local v28 = Vector3.new(v26, v21, v27)
            local v29 = u20 * 3
            local v30 = u20 * 3
            v22("Shockwave2", nil, v23, v24, v25, v28, Vector3.new(v29, v21, v30), 0.75, 0, Enum.EasingStyle.Exponential, endColor, Enum.Material.Neon, "Rings")
            local v31 = _G.PlayEffect
            local v32 = u19 * CFrame.new(0, u20 * 1.2, 0)
            local v33 = u19 * CFrame.new(0, 0, 0)
            local v34 = BrickColor.new("White")
            local v35 = Vector3.new(u20, v21, u20)
            local v36 = u20 * 2
            local v37 = u20 * 2
            v31("Shockwave2", nil, v32, v33, v34, v35, Vector3.new(v36, v21, v37), 2, 0, Enum.EasingStyle.Exponential, endColor, Enum.Material.Neon, "Rings")
            u4.PrimaryPart.Material = Enum.Material.Neon
            _G.tween(u4.PrimaryPart, {
                2,
                "Smoother",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = _G.filterColor(u6, Color3.fromRGB(89, 161, 255))
            })
            _G.tween(u4.outter, {
                2,
                "Smoother",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = _G.filterColor(u6, Color3.fromRGB(89, 161, 255))
            })
            _G.tween(u4.PrimaryPart.PointLight, {
                2,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0
            })
            task.spawn(function() --[[ Line: 102 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u4
                    [3] = u19
                    [4] = u2
                    [5] = u6
                    [6] = u3
                --]]
                local v38 = tick()
                if tick() - v38 < 3 then
                    local v39 = 50 + u20 / 20
                    for _ = 1, math.clamp(v39, 0, 75) do
                        local v40 = u4.PrimaryPart.Size.X
                        local v41 = u19
                        local v42 = Instance.new("Attachment")
                        _G.destroy(v42, 1)
                        v42.Parent = workspace.Terrain
                        if typeof(v41) == "CFrame" then
                            v42.WorldCFrame = v41
                        end
                        if typeof(v41) == "Vector3" then
                            v42.Position = v41
                        end
                        local v43 = u19
                        local v44 = CFrame.Angles
                        local v45 = math.random(-360, 360)
                        local v46 = math.rad(v45)
                        local v47 = math.random(-360, 360)
                        local v48 = math.rad(v47)
                        local v49 = math.random(-360, 360)
                        local v50 = v43 * v44(v46, v48, (math.rad(v49)))
                        local v51 = v50 * CFrame.new(0, v40 / 2, 0)
                        local v52 = Instance.new("Attachment")
                        _G.destroy(v52, 1)
                        v52.Parent = workspace.Terrain
                        if typeof(v51) == "CFrame" then
                            v52.WorldCFrame = v51
                        end
                        if typeof(v51) == "Vector3" then
                            v52.Position = v51
                        end
                        local _ = math.random(300, 1000) / 1000
                        v52.WorldCFrame = v50 * CFrame.new(0, v40 * (math.random(150, 200) / 100), 0)
                        local v53 = u2.new(v42, v52, 10)
                        v53.CurveSize0 = 0
                        v53.CurveSize1 = 0
                        v53.PulseSpeed = math.random(10, 20)
                        v53.AnimationSpeed = math.random(15, 20)
                        v53.PulseLength = 2
                        v53.FadeLength = 0.25
                        v53.Thickness = v40 / 10
                        v53.Color = _G.filterColor(u6, Color3.fromRGB(89, 161, 255))
                        v53.MinTransparency = 0
                        v53.Frequency = math.random(15, 25)
                        v53.MinThicknessMultiplier = 0.5
                        v53.MaxThicknessMultiplier = 1
                        v53.MinRadius = 0
                        v53.MaxRadius = v40 / 3
                        v53.ContractFrom = 1
                        local v54 = u3.new(v53)
                        v54.MaxDistance = v40 * 2
                        v54.MinDistance = v40
                        v54.MaxSparkCount = 3
                        v54.MaxSpeed = v40 / 2
                        game["Run Service"].RenderStepped:Wait()
                    end
                end
            end)
            task.spawn(function() --[[ Line: 138 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u19
                --]]
                local v55 = tick()
                while true do
                    local v56 = u4.PrimaryPart.Size.X
                    local v57 = Ray.new(u19.Position, CFrame.new(u19.Position).UpVector * -v56)
                    local v58, v59 = _G.raycastWhitelist(v57, { workspace.Islands, workspace.Env })
                    local v60 = u4.PrimaryPart
                    v60.Attachment2.sm2.Speed = NumberRange.new(v56 * 4, v56 * 6)
                    v60.Attachment2.Rocks.Speed = v60.Attachment2.sm2.Speed
                    v60.Attachment2.sm2.Size = NumberSequence.new(0, v56 / 1.5)
                    v60.Attachment2.sm2:Emit(3)
                    v60.Attachment2.Rocks:Emit(2)
                    u4.PrimaryPart.Attachment.ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.5, v56 * 1.25, 0), NumberSequenceKeypoint.new(1, 0, 0) })
                    if v58 then
                        v60.Attachment2.WorldCFrame = CFrame.new(v59)
                        v60.Attachment2.Rocks.Transparency = NumberSequence.new(0)
                        v60.Attachment2.sm2.Enabled = true
                        v60.Attachment2.sm2.Transparency = NumberSequence.new(0.5, 1)
                        v60.Attachment2.sm2.Color = ColorSequence.new(v58.Color)
                        v60.Attachment2.Rocks.Color = ColorSequence.new(v58.Color)
                    else
                        v60.Attachment2.sm2.Enabled = false
                        v60.Attachment2.Rocks.Enabled = false
                        v60.Attachment2.Rocks.Transparency = NumberSequence.new(1)
                        v60.Attachment2.sm2.Transparency = NumberSequence.new(1)
                    end
                    game["Run Service"].Heartbeat:Wait()
                    if tick() - v55 >= 1.5 then
                        u4.PrimaryPart.Attachment.ParticleEmitter.Enabled = false
                        return
                    end
                end
            end)
            local v61 = u19
            for v62 = 1, 5 do
                local v63 = script.Part:Clone()
                v63.CFrame = v61
                v63.Mesh.Scale = u4.PrimaryPart.Size * 1.1
                v63.Parent = workspace.Effects
                _G.tween(v63, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.tween(v63.Mesh, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(u20, u20, u20) * (v62 + 1.1)
                })
                _G.destroy(v63, 0.25)
                task.wait(0.25)
            end
            task.wait(1)
            if u4:FindFirstChild("outter") then
                _G.tween(u4.outter, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0)
                })
                _G.tween(u4.PrimaryPart.Mesh, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, 0)
                })
            end
            return
        end
        local v64 = tick()
        if tick() - v64 >= 3 then
            return
        end
        local v65 = 0
        while true do
            if _G.checkRenderDistance(u4.PrimaryPart.Position) == true and tick() - v65 >= 0.015 then
                local v66 = u4.PrimaryPart.Size.X / 2
                local v67 = u4.PrimaryPart.CFrame
                local v68 = Instance.new("Attachment")
                _G.destroy(v68, 1)
                v68.Parent = workspace.Terrain
                if typeof(v67) == "CFrame" then
                    v68.WorldCFrame = v67
                end
                if typeof(v67) == "Vector3" then
                    v68.Position = v67
                end
                local v69 = CFrame.Angles
                local v70 = math.random(-120, 120)
                local v71 = math.rad(v70)
                local v72 = math.random(-120, 120)
                local v73 = v67 * v69(3.141592653589793, v71, (math.rad(v72)))
                local v74 = v73 * CFrame.new(0, v66 / 2, 0)
                local v75 = Instance.new("Attachment")
                _G.destroy(v75, 1)
                v75.Parent = workspace.Terrain
                if typeof(v74) == "CFrame" then
                    v75.WorldCFrame = v74
                end
                if typeof(v74) == "Vector3" then
                    v75.Position = v74
                end
                local _ = math.random(250, 750) / 1000
                v75.WorldCFrame = v73 * CFrame.new(0, v66 * (math.random(200, 300) / 100), 0)
                local v76 = u2.new(v68, v75, 10)
                local v77 = math.random(5, 10)
                v76.CurveSize0 = 0
                v76.CurveSize1 = v77
                v76.PulseSpeed = 5
                v76.AnimationSpeed = math.random(15, 20)
                v76.PulseLength = math.random(100, 250) / 200
                v76.FadeLength = 0.25
                v76.Thickness = v66 / 5
                v76.Color = _G.filterColor(u6, Color3.fromRGB(89, 161, 255))
                v76.Frequency = math.random(15, 25)
                v76.MinThicknessMultiplier = 0.1
                v76.MaxThicknessMultiplier = 1
                v76.MinRadius = 0
                v76.MaxRadius = v66 / 3
                v76.ContractFrom = 0.5
                local v78 = u3.new(v76)
                v78.MaxDistance = v66 * 2
                v78.MinDistance = v66
                v78.MaxSparkCount = 2
                v78.MaxSpeed = v66 / 2
                v65 = tick()
            end
            game["Run Service"].Heartbeat:Wait()
            if u4.PrimaryPart.Anchored == false or u4.Parent == nil then
                return
            end
        end
    end
end
return v1