 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = Random.new()
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
local u5 = require(v1.Modules.BezierFormula)
require(v1.Modules.LightningBolt)
local u6 = game:GetService("ContentProvider")
local _ = v3.LocalPlayer
local u7 = workspace.Effects
local u8 = script.TornadoFlipBooks
local function u19(p9, p10, p11) --[[ Line: 22 ]]
    local function v17(u12, p13, p14) --[[ Line: 23 ]]
        for _, v15 in ipairs(u12:GetDescendants()) do
            if v15:IsA("ParticleEmitter") or v15:IsA("Trail") then
                v15.Enabled = p13
            end
        end
        if p14 then
            task.delay(p14, function() --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                for _, v16 in ipairs(u12:GetDescendants()) do
                    if v16:IsA("ParticleEmitter") or v16:IsA("Trail") then
                        v16.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p9) == "table" then
        for _, v18 in p9 do
            v17(v18, p10, p11)
        end
    else
        v17(p9, p10, p11)
    end
end
local function u25(p20) --[[ Line: 52 ]]
    for v21 = #p20, 2, -1 do
        local v22 = math.random(v21)
        local v23 = p20[v22]
        local v24 = p20[v21]
        p20[v21] = v23
        p20[v22] = v24
    end
end
local v26 = RaycastParams.new()
v26.FilterType = Enum.RaycastFilterType.Include
v26.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p27, u28, u29, u30, u31) --[[ Name: start, Line 65 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u5
            [4] = u7
            [5] = u19
            [6] = u8
            [7] = u25
            [8] = u4
        --]]
        if _G.checkRenderDistance(u28.PrimaryPart.Position) ~= false then
            task.spawn(function() --[[ Line: 69 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                u6:PreloadAsync({ script.TornadoFlipBooks })
            end)
            if p27 == "Spin" then
                u28.Humanoid:LoadAnimation(script.Animations.WhirlWind):Play()
                local u32 = u28.HumanoidRootPart
                local u33 = 0
                local v34, v35, v36 = _G.getRayFloor(u28.PrimaryPart.CFrame, 15)
                local v37 = script.Leap:Clone()
                v37.CFrame = CFrame.new(v35, v35 + v36) * CFrame.Angles(-1.5707963267948966, 0, 0)
                if v34 then
                    _G.recolorParticles(v37, v34.Color)
                else
                    v37.CFrame = u32.CFrame
                    v37.Dust.Rock:Destroy()
                    v37.Attachment1:Destroy()
                    _G.recolorParticles(v37, Color3.fromRGB(232, 232, 232))
                end
                v37.Parent = workspace.Effects
                _G.customEmit(v37)
                _G.destroy(v37, 4)
                local u38 = u29.LookVector
                local u39 = nil
                u39 = u2.Heartbeat:Connect(function(p40) --[[ Line: 96 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                        [2] = u28
                        [3] = u5
                        [4] = u29
                        [5] = u31
                        [6] = u30
                        [7] = u39
                        [8] = u32
                        [9] = u38
                    --]]
                    u33 = u33 + p40 * 1.2
                    u28.PrimaryPart.Velocity = Vector3.new()
                    local v41 = u5.QuadBezier(u33, u29.Position, u31, u30.Position + Vector3.new(0, 5, 0))
                    if u33 >= 1 then
                        u39:Disconnect()
                    else
                        u32.CFrame = CFrame.new(v41, v41 + u38)
                    end
                end)
                _G.PlaySound(u28.PrimaryPart, script.SLSpinStart).Parent = u28.PrimaryPart
                task.wait(0.8333333333333334)
                _G.PlaySound(u28.PrimaryPart, script.SLSpin).Parent = u28.PrimaryPart
                local v42, _, _ = _G.getRayFloor(u28.PrimaryPart.CFrame, 15)
                local u43 = CFrame.new(u32.Position)
                local u44 = script.WindEffect:Clone()
                u44.CFrame = u43
                if v42 then
                    u44.AttachmentC.Clouds.Color = ColorSequence.new(v42.Color)
                end
                local v45 = Instance.new("Highlight")
                v45.FillColor = Color3.fromRGB(235, 249, 255)
                v45.FillTransparency = 1
                v45.OutlineTransparency = 1
                v45.Adornee = u28
                v45.DepthMode = Enum.HighlightDepthMode.Occluded
                v45.Parent = u28
                _G.tween(v45, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
                    ["FillTransparency"] = 0.1
                })
                local v46 = u30 * CFrame.new(0, 0, 100)
                local v47 = _G.tween
                local v48 = u28.PrimaryPart
                local v49 = {
                    0.2,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v50 = {}
                local v51 = CFrame.new
                local v52 = u28.PrimaryPart.Position
                local v53 = v46.X
                local v54 = u28.PrimaryPart.Position.Y
                local v55 = v46.Z
                v50.CFrame = v51(v52, (Vector3.new(v53, v54, v55)))
                v47(v48, v49, v50)
                u44.Parent = u7
                u19(u44, true)
                task.spawn(function() --[[ Line: 136 ]]
                    --[[
                    Upvalues:
                        [1] = u43
                        [2] = u7
                        [3] = u2
                        [4] = u8
                        [5] = u19
                        [6] = u44
                    --]]
                    for _ = 1, 8 do
                        task.spawn(function() --[[ Line: 138 ]]
                            --[[
                            Upvalues:
                                [1] = u43
                                [2] = u7
                                [3] = u2
                                [4] = u8
                            --]]
                            local u56 = script.Cone:Clone()
                            local v57 = u43
                            local v58 = CFrame.Angles
                            local v59 = math.random(-360, 360)
                            u56.CFrame = v57 * v58(0, math.rad(v59), 0)
                            u56.Parent = u7
                            _G.customEmit(u56)
                            _G.tween(u56.Mesh, {
                                5,
                                "Quart",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Scale"] = u56.Mesh.Scale * 15
                            })
                            task.delay(0.1, function() --[[ Line: 147 ]]
                                --[[
                                Upvalues:
                                    [1] = u56
                                --]]
                                _G.tween(u56, {
                                    0.2,
                                    "Quad",
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Transparency"] = 1
                                })
                            end)
                            local v61 = u2.Heartbeat:Connect(function() --[[ Line: 151 ]]
                                --[[
                                Upvalues:
                                    [1] = u56
                                --]]
                                local v60 = u56
                                v60.CFrame = v60.CFrame * CFrame.Angles(0, 0.13962634015954636, 0)
                            end)
                            for _ = 1, 2 do
                                for v62 = 1, 24 do
                                    u56.Mesh.TextureId = u8["" .. v62].Texture
                                    task.wait(0.008333333333333333)
                                end
                            end
                            v61:Disconnect()
                            u56:Destroy()
                        end)
                        task.wait(0.1)
                    end
                    u19(u44, false)
                    _G.destroy(u44, 2)
                end)
                task.spawn(function() --[[ Line: 175 ]]
                    --[[
                    Upvalues:
                        [1] = u43
                        [2] = u7
                        [3] = u8
                    --]]
                    for _ = 1, 4 do
                        task.spawn(function() --[[ Line: 177 ]]
                            --[[
                            Upvalues:
                                [1] = u43
                                [2] = u7
                                [3] = u8
                            --]]
                            local v63 = script.SecondCone:Clone()
                            local v64 = u43
                            local v65 = CFrame.Angles
                            local v66 = math.random(-360, 360)
                            v63.CFrame = v64 * v65(0, math.rad(v66), 0)
                            v63.Parent = u7
                            _G.customEmit(v63)
                            _G.destroy(v63, 3)
                            local v67 = v63.Mesh
                            local v68 = v63.Mesh.Scale.X * 2
                            local v69 = v63.Mesh.Scale.Y * 1
                            local v70 = v63.Mesh.Scale.Z * 2
                            v67.Scale = Vector3.new(v68, v69, v70)
                            local v71 = v63.Mesh.Scale
                            _G.tween(v63, {
                                0.8,
                                "Linear",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Transparency"] = 1
                            })
                            local v72 = _G.tween
                            local v73 = v63.Mesh
                            local v74 = {
                                1,
                                "Linear",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }
                            local v75 = {}
                            local v76 = v71.X * 4
                            local v77 = v71.Y * 6
                            local v78 = v71.Z * 4
                            v75.Scale = Vector3.new(v76, v77, v78)
                            v72(v73, v74, v75)
                            for v79 = 6, 24 do
                                v63.Mesh.TextureId = u8["" .. v79].Texture
                                task.wait(0.022222222222222223)
                            end
                        end)
                        task.wait(0.2)
                    end
                end)
                local v80 = script.Move2Slashes:Clone()
                v80:PivotTo(u43 * CFrame.new(0, -2, 0))
                v80.Parent = u7
                _G.destroy(v80, 3)
                local v81 = v80.Slashes:GetChildren()
                u25(v81)
                tick()
                for _, v82 in v81 do
                    _G.customEmit(v82)
                    local v83 = script.Light.PointLight:Clone()
                    v83.Brightness = 5
                    v83.Parent = v82
                    _G.tween(v83, {
                        0.2,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Range"] = 45,
                        ["Brightness"] = 0
                    })
                    _G.destroy(v83, 0.2)
                    _G.PlayEffect("DeadLightning", nil, {
                        ["StartPosition"] = (v82.CFrame * CFrame.new(0, 0, 25)).Position,
                        ["EndPosition"] = (v82.CFrame * CFrame.new(0, 0, -25)).Position,
                        ["Points"] = 4,
                        ["Size"] = 1,
                        ["Branches"] = true,
                        ["NoHighlight"] = true,
                        ["RandomSize"] = NumberRange.new(0.15, 1),
                        ["Offset"] = NumberRange.new(-5, 5),
                        ["MainColor"] = Color3.fromRGB(230, 255, 255),
                        ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                        ["LightningDuration"] = 0.2,
                        ["WaitFunction"] = function(p84, _) --[[ Name: WaitFunction, Line 243 ]]
                            if p84 % 2 == 0 then
                                task.wait(0.05)
                            end
                        end
                    })
                    task.wait(0.05)
                end
                local v85 = script.Explosion:Clone()
                v85.CFrame = u43
                v85.Parent = u7
                _G.customEmit(v85)
                _G.destroy(v85, 2)
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 25,
                    ["Position"] = u32.Position + Vector3.new(0, 5, 0),
                    ["DistanceRandomness"] = Vector2.new(0.5, 1),
                    ["Duration"] = 2,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 25,
                    ["Direction"] = Vector3.new(0, -15, 0)
                })
                local v86 = script.Light:Clone()
                v86.CFrame = u43
                v86.Parent = workspace.Effects
                _G.tween(v86.PointLight, {
                    0.2,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 60,
                    ["Brightness"] = 0
                })
                _G.destroy(v86, 0.2)
                Color3.fromRGB(133, 255, 247)
                local _ = {
                    ["WorldPosition"] = CFrame.new(v85.Position).Position,
                    ["WorldAxis"] = Vector3.new(0, 1, 0)
                }
                for _ = 1, 5 do
                    _G.PlayEffect("DeadLightning", nil, {
                        ["StartPosition"] = u32.Position,
                        ["EndPosition"] = u32.Position + u4:NextUnitVector() * u4:NextNumber(35, 45),
                        ["Points"] = 10,
                        ["Size"] = 1,
                        ["Branches"] = true,
                        ["NoHighlight"] = true,
                        ["RandomSize"] = NumberRange.new(0.15, 1),
                        ["Offset"] = NumberRange.new(-25, 25),
                        ["MainColor"] = Color3.fromRGB(230, 255, 255),
                        ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                        ["LightningDuration"] = 0.1,
                        ["WaitFunction"] = function(p87, _) --[[ Name: WaitFunction, Line 308 ]]
                            if p87 % 2 == 0 then
                                task.wait()
                            end
                        end
                    })
                    task.wait()
                end
                _G.tween(v45, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
                    ["FillTransparency"] = 1
                })
                _G.destroy(v45, 0.1)
            end
        end
    end
}