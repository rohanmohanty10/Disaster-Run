 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.sBeat)
local function u12(p3, p4, p5, p6, p7) --[[ Line: 7 ]]
    local v8 = p3 + (p4 - p3) * p7
    local v9 = p4 + (p5 - p4) * p7
    local v10 = p5 + (p6 - p5) * p7
    local v11 = v8 + (v9 - v8) * p7
    return v11 + (v9 + (v10 - v9) * p7 - v11) * p7
end
function setTwoEndPoints(p13, p14, p15)
    local v16 = (p14 - p15).Magnitude
    local v17 = p13.Size.X
    local v18 = p13.Size.Y
    p13.Size = Vector3.new(v17, v18, v16)
    p13.CFrame = CFrame.new(p14:Lerp(p15, 0.5), p15)
    return p13
end
require(game.ReplicatedStorage.Modules.FastWait)
function v1.start(_, u19, p20, u21, _, u22) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u2
    --]]
    local u23, u24, u25, u26 = unpack(p20)
    local u27 = CFrame.new((u12(u23, u24, u25, u26, 0.025))).Position
    local u28 = game.Players:GetPlayerFromCharacter(u19.Parent)
    if _G.checkRenderDistance(u27) ~= false then
        local u29 = _G.getEffect("Shockwave")
        task.spawn(function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u23
                [3] = u24
                [4] = u25
                [5] = u26
                [6] = u21
                [7] = u19
                [8] = u28
                [9] = u27
                [10] = u29
                [11] = u2
                [12] = u22
            --]]
            local v30 = CFrame.new((u12(u23, u24, u25, u26, u21)))
            local v31 = script.head:Clone()
            v31.Parent = workspace.Effects
            v31.roar:Play()
            script.Beam.Color = script.bflame.BurningPart.Color
            local v32 = script.bflame:Clone()
            v32.Transparency = 1
            v32.Parent = workspace.Effects
            local _ = u28 == game.Players.LocalPlayer
            tick()
            for u33 = 0, 1 + u21, u21 do
                local v34 = CFrame.new((u12(u23, u24, u25, u26, u33)))
                v32.Anchored = true
                v32.CFrame = CFrame.new(v34.Position, u27) * CFrame.Angles(0, 3.141592653589793, 0)
                v31.CFrame = v32.CFrame * CFrame.new(0, 0, -v31.Size.X / 4) * CFrame.Angles(0, -1.5707963267948966, 0)
                local v35 = u33 * 10
                local v36 = v35 * 4
                local v37 = v36 * 0.5
                local v38 = v36 * 0.571428571
                v31.Size = Vector3.new(v36, v37, v38)
                u27 = v34.Position
                if v30 and (workspace.CurrentCamera.CFrame.Position - v34.Position).Magnitude < 2000 then
                    local v39 = (v30.Position - v34.Position).Magnitude
                    local v40 = script.Part:Clone()
                    v40.CFrame = CFrame.new(v30.Position:Lerp(v34.Position, 0.5), v34.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
                    v40.Size = Vector3.new(v35, v39, v35)
                    v40.Parent = workspace.Effects
                    _G.tween(v40.Mesh, {
                        1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = Vector3.new(0, 1, 0)
                    })
                    _G.destroy(v40, 1)
                    local v41 = Instance.new("Attachment")
                    local v42 = v41:Clone()
                    v41.Parent = v32
                    v42.Parent = v32
                    local v43 = script.Beam:Clone()
                    v43.Parent = v32
                    local v44 = (v32.CFrame * CFrame.new(0, 0, u33 * 75)).Position
                    local v45 = math.random(-25, 25)
                    local v46 = math.random(-25, 25)
                    local v47 = math.random
                    local v48 = v44 + Vector3.new(v45, v46, v47(-25, 25))
                    v43.Width0 = math.random(25, 100)
                    v43.Width1 = math.random(25, 100)
                    v43.Attachment0 = v41
                    v43.Attachment1 = v42
                    _G.tween(v42, {
                        0.25,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["WorldPosition"] = v48
                    })
                    _G.tween(v43, {
                        0.25,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                    _G.destroy(v43, 0.25)
                    local v49 = script.bflame:Clone()
                    v49.Anchored = true
                    v49.Size = v40.Size
                    v49.CFrame = v40.CFrame
                    v49.Parent = workspace.Effects
                    v49.BurningPart.Size = NumberSequence.new(v39, 0)
                    v49.BurningPart:Emit(5)
                    v49.BurningPart2.Size = v49.BurningPart.Size
                    v49.BurningPart2:Emit(5)
                    _G.destroy(v49, 1)
                    if _G.fastmode == false then
                        local u50 = v49.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
                        local u51 = u33 * (u21 + 1)
                        pcall(function() --[[ Line: 116 ]]
                            --[[
                            Upvalues:
                                [1] = u29
                                [2] = u50
                                [3] = u51
                                [4] = u33
                            --]]
                            local v52 = u29
                            local v53 = u50
                            local v54 = u50
                            local v55 = BrickColor.new("Black")
                            local v56 = 45 * u51
                            local v57 = 75 * u51
                            local v58 = 45 * u51
                            local v59 = Vector3.new(v56, v57, v58)
                            local v60 = u33 * 10
                            local v61 = u33 * 10
                            v52:start(v53, v54, v55, v59, Vector3.new(v60, 0, v61), 0.5, 0, Enum.EasingStyle.Exponential, Color3.fromRGB(0, 0, 0), Enum.Material.Neon)
                        end)
                    end
                end
                u2()
                v30 = v34
            end
            _G.destroy(v32, 1)
            local v62 = CFrame.new((u12(u23, u24, u25, u26, 1)))
            local v63 = _G.tween
            local v64 = {
                0.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v65 = {
                ["Transparency"] = 1
            }
            local v66 = v31.Size.X
            v65.Size = Vector3.new(v66, 0, 0)
            v63(v31, v64, v65)
            _G.destroy(v31, 5)
            local v67 = v62 * CFrame.new(0, 45, 0)
            local v68 = Ray.new(v67.Position, v67.upVector * -100)
            local v69 = _G.raycastWhitelist(v68, { workspace.Islands, workspace.Ships })
            local v70 = script.Fist2:Clone()
            v70.CFrame = v62
            v70.Parent = workspace.Effects
            v70.BurningPart.Size = NumberSequence.new(40, 0)
            v70.Attachment.Ring.Size = NumberSequence.new(20, 85)
            v70.ignite3:Play()
            _G.customEmit(v70)
            _G.PlayEffect("GroundRocks2", nil, CFrame.new(v62.Position), 20, 25, 4, 0, 5)
            _G.PlaySound(v70, script.explode)
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = v62,
                ["ti"] = 0.1,
                ["ti2"] = 0.25,
                ["range"] = 37.5,
                ["minThick"] = 25,
                ["maxThick"] = 45,
                ["part"] = nil,
                ["color"] = BrickColor.new("Steel blue").Color,
                ["am"] = 30
            })
            if v69 then
                v70.Attachment.sm.Color = ColorSequence.new(v69.Color)
                v70.Attachment.Rocks.Color = ColorSequence.new(v69.Color)
                _G.customEmit(v70.Attachment.Rocks)
            end
            _G.destroy(v70, 5)
            if u28 == game.Players.LocalPlayer then
                u22:FireServer(v62)
            end
        end)
    end
end
return v1