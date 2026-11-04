 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(game.ReplicatedStorage.Modules.Trove)
local u5 = require(v1.Modules.Client.WeaponVFXRecolor)
local u6 = require(script.Parent.VFXHandler)
local u7 = v3.LocalPlayer
local _ = workspace.Effects
local v8 = {}
local u89 = {
    ["Part1"] = function(p9) --[[ Name: Part1, Line 20 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
        --]]
        local v10 = p9.Character
        local v11 = v10.HumanoidRootPart
        local v12 = p9.Prestige and script.Prestige or script.Normal
        task.wait(0.15)
        local v13 = v12.slash1:Clone()
        u5.apply(v13, v10)
        v13.Parent = v11
        local v14 = v12.SlashBeam1:Clone()
        u5.apply(v14, v10)
        v14.CFrame = v11.CFrame * CFrame.new(0.356735229, -1.46740842, -1.4251914, 0.853913128, 0.520416617, -1.06541973e-14, -9.09775896e-15, -5.54462135e-15, 1, 0.520416617, -0.853913128, 0)
        v14.Parent = workspace.Effects
        u6.TweenBeams(v14.Beams, {
            ["Properties"] = {
                ["Brightness"] = 30,
                ["TextureSpeed"] = 2,
                ["Width0"] = 0,
                ["Width1"] = 0
            },
            ["RotationSpeed"] = -3.2,
            ["Rotation"] = true,
            ["Offset"] = CFrame.new(0, 0, 0),
            ["Duration"] = 0.15,
            ["Easing"] = "Quad",
            ["EasingDirection"] = "In"
        })
        _G.customEmit(v13)
        _G.destroy(v13, 5)
        _G.destroy(v14, 5)
    end,
    ["Part2"] = function(p15) --[[ Name: Part2, Line 56 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u2
            [4] = u4
            [5] = u7
        --]]
        local u16 = p15.Victim
        local u17 = p15.Character
        local v18 = p15.Start
        local u19 = p15.Prestige and script.Prestige or script.Normal
        local u20 = u17.HumanoidRootPart
        local v21 = workspace:GetServerTimeNow() - v18
        task.delay(0.25 - v21, function() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u5
                [3] = u17
                [4] = u20
                [5] = u6
            --]]
            local v22 = u19.slash2:Clone()
            u5.apply(v22, u17)
            v22.Parent = u20
            local v23 = u19.SlashBeam2:Clone()
            u5.apply(v23, u17)
            v23.CFrame = u20.CFrame * CFrame.new(-1.69764709, 4.94388103, 0.84167099, -0.0211195108, -0.0108366041, 0.999718249, 0.456519544, -0.889713407, -1.06511954e-14, 0.889462769, 0.456390887, 0.0237374306)
            v23.Parent = workspace.Effects
            local v24 = u6.TweenBeams
            local v25 = v23.Beams
            local v26 = {
                ["Properties"] = {
                    ["Brightness"] = 20,
                    ["TextureSpeed"] = 2,
                    ["Width0"] = 0,
                    ["Width1"] = 0
                },
                ["RotationSpeed"] = -3.2,
                ["Rotation"] = true,
                ["Offset"] = CFrame.new(0, 0, 0),
                ["Duration"] = 0.15,
                ["Easing"] = "Quad",
                ["EasingDirection"] = "In"
            }
            v24(v25, v26)
            _G.customEmit(v22)
            _G.destroy(v22, 4)
            _G.destroy(v23, 4)
        end)
        task.delay(0.583 - v21, function() --[[ Line: 96 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u5
                [3] = u17
                [4] = u20
                [5] = u6
            --]]
            local v27 = u19.slash3:Clone()
            u5.apply(v27, u17)
            v27.Parent = u20
            local v28 = u19.SlashBeam3:Clone()
            u5.apply(v28, u17)
            v28.CFrame = u20.CFrame * CFrame.new(-1.68106842, 5.35716629, 0.142848015, -0.0209237151, -0.0112099871, 0.999718308, 0.472248822, -0.881465256, -1.06511962e-14, 0.881216943, 0.472115725, 0.0237374343)
            v28.Parent = workspace.Effects
            local v29 = u6.TweenBeams
            local v30 = v28.Beams
            local v31 = {
                ["Properties"] = {
                    ["Brightness"] = 20,
                    ["TextureSpeed"] = 2,
                    ["Width0"] = 0,
                    ["Width1"] = 0
                },
                ["RotationSpeed"] = -3.2,
                ["Rotation"] = true,
                ["Offset"] = CFrame.new(0, 0, 0),
                ["Duration"] = 0.15,
                ["Easing"] = "Quad",
                ["EasingDirection"] = "In"
            }
            v29(v30, v31)
            _G.customEmit(v27)
            _G.destroy(v27, 4)
            _G.destroy(v28, 4)
        end)
        task.delay(1.167 - v21, function() --[[ Line: 127 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u5
                [3] = u17
                [4] = u16
                [5] = u6
            --]]
            local v32 = u19.KickThrow:Clone()
            u5.apply(v32, u17)
            local v33 = u17.PrimaryPart.Position.X
            local v34 = u16.PrimaryPart.Position.Y
            local v35 = u17.PrimaryPart.Position.Z
            local v36 = Vector3.new(v33, v34, v35)
            v32.WorldCFrame = CFrame.new(u16.PrimaryPart.Position, v36) * CFrame.Angles(3.141592653589793, 0, 0)
            v32.Parent = workspace.Terrain
            local v37 = u19.Wind1Beam:Clone()
            u5.apply(v37, u17)
            v37.CFrame = v32.WorldCFrame * CFrame.new(0, 0, -10)
            v37.Parent = workspace.Effects
            local v38 = u6.TweenBeams
            local v39 = v37.Beams
            local v40 = {
                ["Properties"] = {
                    ["Brightness"] = 0,
                    ["TextureSpeed"] = 2,
                    ["Width0"] = 0,
                    ["Width1"] = 0
                },
                ["RotationSpeed"] = 0.5,
                ["Rotation"] = true,
                ["Offset"] = CFrame.new(0, 0, 2),
                ["Duration"] = 0.35,
                ["Easing"] = "Quad",
                ["EasingDirection"] = "In"
            }
            v38(v39, v40)
            _G.customEmit(v32)
            _G.destroy(v32, 4)
            _G.destroy(v37, 4)
            local v41 = u19.Wind2Beam:Clone()
            u5.apply(v41, u17)
            v41.CFrame = v32.WorldCFrame * CFrame.new(0, 0, -10)
            v41.Parent = workspace.Effects
            local v42 = u6.TweenBeams
            local v43 = v41.Beams
            local v44 = {
                ["Properties"] = {
                    ["Brightness"] = 0,
                    ["TextureSpeed"] = 0,
                    ["Width0"] = 1,
                    ["Width1"] = 1
                },
                ["RotationSpeed"] = 0.8,
                ["Rotation"] = true,
                ["Offset"] = CFrame.new(0, 0, 2),
                ["Duration"] = 0.5,
                ["Easing"] = "Quad",
                ["EasingDirection"] = "In"
            }
            v42(v43, v44)
            _G.destroy(v41, 4)
        end)
        task.delay(1.233 - v21, function() --[[ Line: 182 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u5
                [3] = u17
            --]]
            local v45 = u19.WindSpinBeam1:Clone()
            u5.apply(v45, u17)
            v45.Parent = u17.UpperTorso
            _G.destroy(v45, 3)
            local u46 = v45:GetDescendants()
            for u47 = 1, #u46 do
                if u46[u47]:IsA("Beam") then
                    u46[u47].Enabled = true
                    local u48 = u46[u47].Width0
                    local u49 = u46[u47].Width1
                    u46[u47].Width0 = 0
                    u46[u47].Width1 = 0
                    task.spawn(function() --[[ Line: 197 ]]
                        --[[
                        Upvalues:
                            [1] = u46
                            [2] = u47
                            [3] = u48
                            [4] = u49
                        --]]
                        local v50 = {
                            ["Width0"] = u48,
                            ["Width1"] = u49
                        }
                        _G.tween(u46[u47], {
                            0.3,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, v50)
                        task.wait(0.3)
                        _G.tween(u46[u47], {
                            0.4,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        })
                    end)
                end
            end
        end)
        local v51 = u17.HumanoidRootPart
        local _ = u16.HumanoidRootPart
        local v52 = p15.VictimPosition
        local v53 = p15.CharacterPosition
        local v54 = 0.75 - v21
        local v55 = 1.2 - v21
        local v56 = (v53 - v52).Unit
        local v57 = (Vector3.new(0, 1, 0)):Cross(v56)
        local v58 = CFrame.fromMatrix(Vector3.new(0, 0, 0), v57, Vector3.new(0, 1, 0))
        repeat
            u2.Heartbeat:Wait()
            local v59 = workspace:GetServerTimeNow() - v18
            local v60 = u4
            local v61 = v59 / v54
            v51.CFrame = v58 + v53:Lerp(v52, (v60:GetValue(math.min(v61, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out)))
        until v55 <= v59
        if u17 == u7.Character then
            local v62 = -v56
            local v63 = Instance.new("LinearVelocity")
            v63.Attachment0 = v51:FindFirstChild("RootAttachment")
            v63.ForceLimitMode = Enum.ForceLimitMode.PerAxis
            v63.RelativeTo = Enum.ActuatorRelativeTo.World
            v63.MaxAxesForce = Vector3.new(999999, 999999, 999999)
            v63.VectorVelocity = v62 * 40 + Vector3.new(0, 25, 0)
            v63.Parent = v51
            local v64 = os.clock()
            repeat
                local v65 = task.wait()
                local v66 = os.clock() - v64
                v62 = v62:Lerp(-(Vector3.new(0, 1, 0)):Cross(workspace.CurrentCamera.CFrame.RightVector), v65 * 5)
                v63.VectorVelocity = v62 * 40 + Vector3.new(0, 25, 0)
            until v66 >= 0.45
            v63:Destroy()
        end
    end,
    ["ExplosionPart"] = function(p67) --[[ Name: ExplosionPart, Line 254 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v68 = p67.VictimRootPart
        local v69 = p67.RootPart
        local v70 = p67.Prestige and script.Prestige or script.Normal
        local v71 = p67.Prestige and script.Parent.Prestige or script.Parent.Normal
        local v72 = _G.emitHitVfx(v70.Explosion, v68.CFrame)
        if v72 then
            u5.apply(v72, v69.Parent)
        end
        _G.PlaySound(v68, v70.GrabSkill_Explode)
        _G.shakenear(v69.Position, 75, 75, 80, -1)
        local v73 = p67.ReturnDuration
        local v74 = p67.ServerTime
        local v75 = v69.Position - v68.Position
        local v76 = v75.Unit
        local v77 = v68.Position + v75 * 0.5 + (Vector3.new(0, 1, 0)):Cross(v76) * 15 + Vector3.new(0, 15, 0)
        local v78 = v69.Parent
        local v79 = v71.ChakramClone:Clone()
        u5.apply(v79, v78)
        v79:PivotTo(v68.CFrame)
        v79.Parent = workspace.Effects
        local v80 = v70.Grindskill_loop:Clone()
        v80.Parent = v79.PrimaryPart
        v80:Play()
        v79.AnimationController.Animator:LoadAnimation(script.Parent.Spin):Play()
        repeat
            local v81 = (workspace:GetServerTimeNow() - v74) / v73
            local v82 = math.min(v81, 1)
            local v83 = v68.Position
            local v84 = v69.Position
            local v85 = v83:Lerp(v77, v82):Lerp(v77:Lerp(v84, v82), v82)
            local v86 = (Vector3.new(0, 1, 0)):Cross(((v83 - v84) * Vector3.new(1, 0, 1)).Unit)
            v79:PivotTo(CFrame.fromMatrix(v85, v86, Vector3.new(0, 1, 0)) * CFrame.Angles(0, 0, 0.7853981633974483))
            task.wait()
        until v82 >= 1 or (v85 - v69.Position).Magnitude <= 5
        _G.tween(v80, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        for _, v87 in v79:QueryDescendants("ParticleEmitter") do
            v87.Enabled = false
        end
        for _, v88 in v79:QueryDescendants("BasePart") do
            v88.Transparency = 1
        end
        _G.destroy(v79, 3)
    end
}
function v8.start(_, p90) --[[ Line: 322 ]]
    --[[
    Upvalues:
        [1] = u89
    --]]
    local v91 = u89[p90.Type]
    if v91 then
        v91(p90)
    end
end
return v8