 

local u1 = require(game.ReplicatedStorage.Modules.FastWait)
local u2 = require(game.ReplicatedStorage.Modules.GLightning)
local v3 = script.Beam.Transparency.Keypoints
local u4 = {}
local u5 = {}
local v6 = {}
for v7 = 1, #v3 do
    local v8 = v3[v7]
    local v9 = {
        ["Transparency"] = v8.Value,
        ["Time"] = v8.Time
    }
    table.insert(u4, v9)
end
local v10 = script.Beam.Size.Keypoints
for v11 = 1, #v10 do
    local v12 = v10[v11]
    local v13 = {
        ["Size"] = v12.Value,
        ["Time"] = v12.Time
    }
    table.insert(u5, v13)
end
function v6.start(_, p14, u15) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u5
        [4] = u4
    --]]
    if _G.checkRenderDistance(p14.Position) ~= false then
        local u16 = CFrame.new(p14.Position)
        local v17 = u16 * CFrame.new(0, 10, 0)
        local v18 = Ray.new(v17.Position, v17.upVector * -50)
        local u19, u20, u21 = _G.raycastWhitelist(v18, { workspace.Islands, workspace.Env, workspace.Ships })
        local u22 = nil
        if u19 then
            u22 = script.dust:Clone()
            u22.CFrame = CFrame.new(u20, u20 + u21) * CFrame.Angles(1.5707963267948966, 0, 0)
            u22.Attachment.sm.Size = NumberSequence.new(0, 35)
            u22.Attachment.sm.Enabled = false
            u22.Attachment.Rocks.Enabled = false
            u22.Attachment.sm.Color = ColorSequence.new(u19.Color)
            u22.Parent = workspace.Effects
            _G.destroy(u22, 5)
            task.spawn(function() --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u22
                --]]
                u1(0.25)
                _G.PlaySound(u22, script.lightning)
                _G.tween(u22.PointLight, {
                    0.1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    -1,
                    true,
                    0
                }, {
                    ["Range"] = 75
                })
                u1(1.25)
                _G.tween(u22.PointLight, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 0
                })
            end)
        else
            _G.PlaySound(u16, script.lightning)
        end
        for v23 = 1, 5 do
            local u24 = script.cloud:Clone()
            local v25 = v23 == 1 and 1 or 5
            local v26 = CFrame.new(u16.Position) * CFrame.new(math.random(-v25, v25), math.random(97.5, 100), math.random(-v25, v25))
            local v27 = CFrame.Angles
            local v28 = math.random(-360, 360)
            u24.CFrame = v26 * v27(0, math.rad(v28), 0)
            u24.Mesh.Scale = Vector3.new(0, 0, 0)
            u24.Parent = workspace.Effects
            local _ = math.random(100, 500) / 100
            _G.tween(u24, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = Color3.fromRGB(99, 95, 98)
            })
            _G.tween(u24.Mesh, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(90, 45, 90)
            })
            task.spawn(function() --[[ Line: 64 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u24
                --]]
                u1(0.25)
                _G.tween(u24.Mesh, {
                    0.2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    -1,
                    true,
                    0
                }, {
                    ["Scale"] = Vector3.new(67.5, 33.75, 67.5)
                })
                u1(1.5)
                _G.tween(u24.Mesh, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, 0)
                })
                _G.destroy(u24, 0.5)
            end)
        end
        u1(0.25)
        task.spawn(function() --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u16
                [3] = u20
                [4] = u21
                [5] = u22
                [6] = u1
            --]]
            local v29 = Color3.fromRGB(255, 255, 255)
            for v30 = 1, 5 do
                if u19 then
                    local v31 = _G.PlayEffect
                    local v32 = u16
                    local v33 = u16 * CFrame.new(0, 75, 0)
                    local v34 = BrickColor.new("White")
                    local v35 = v30 * 10
                    local v36 = v30 * 10
                    local v37 = Vector3.new(v35, 5, v36)
                    local v38 = v30 * 15
                    local v39 = v30 * 15
                    v31("Shockwave2", nil, v32, v33, v34, v37, Vector3.new(v38, 5, v39), 0.5, 0, Enum.EasingStyle.Exponential, v29, Enum.Material.Neon, "Rings")
                end
                local v40 = CFrame.new(u20, u20 + u21) * CFrame.Angles(-1.5707963267948966, 0, 0)
                local v41 = _G.PlayEffect
                local v42 = v40 * CFrame.new(0, 1, 0)
                local v43 = v40 * CFrame.new(0, 1, 0)
                local v44 = BrickColor.new("White")
                local v45 = v30 * 35
                local v46 = v30 * 35
                v41("Shockwave2", nil, v42, v43, v44, Vector3.new(v45, 2, v46), Vector3.new(0, 2, 0), 0.5, 0, Enum.EasingStyle.Exponential, v29, Enum.Material.Neon, "Rings")
                _G.PlayEffect("GroundRocks", nil, v40, v30 * 10, v30 * 1.5 + 2, v30 * 5, 3)
                if u22 then
                    _G.customEmit(u22)
                end
                local v47 = script.Part:Clone()
                v47.CFrame = v40
                v47.Mesh.Scale = Vector3.new(0, 0, 0)
                v47.Parent = workspace.Effects
                _G.PlaySound(v47, script.earthburstlarge1)
                _G.tween(v47.Mesh, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(85, 85, 85)
                })
                _G.tween(v47, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v47, 0.25)
                u1(0.2)
            end
        end)
        task.spawn(function() --[[ Line: 102 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u15
                [3] = u5
                [4] = u4
                [5] = u16
                [6] = u1
            --]]
            task.spawn(function() --[[ Line: 103 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u15
                    [3] = u5
                    [4] = u4
                    [5] = u16
                    [6] = u1
                --]]
                for _ = 1, 20 do
                    local v48 = u2.new
                    local v49 = {
                        ["Lifetime"] = math.random(800, 1500) / 10000,
                        ["DrawType"] = "Singular",
                        ["Colors"] = _G.filterColor(u15, script.Beam.Color.Keypoints),
                        ["Sizes"] = u5,
                        ["Transparencies"] = u4
                    }
                    local v50 = {}
                    local v51 = {}
                    local v52 = u16.Position
                    local v53 = math.random(-35, 35)
                    local v54 = math.random
                    v51.Position = v52 + Vector3.new(v53, 0, v54(-35, 35)) / 2
                    local v55 = math.random(-50, 50)
                    local v56 = math.random
                    v51.Velocity = Vector3.new(v55, 0, v56(-50, 50))
                    v51.Acceleration = Vector3.new(0, 0, 0)
                    v51.Drag = 0
                    v50.Start = v51
                    local v57 = {}
                    local v58 = u16.Position
                    local v59 = math.random(-35, 35)
                    local v60 = math.random(17.5, 70)
                    local v61 = math.random
                    v57.Position = v58 + Vector3.new(v59, v60, v61(-35, 35))
                    local v62 = math.random(-15, 15)
                    local v63 = math.random
                    v57.Velocity = Vector3.new(v62, 0, v63(-15, 15))
                    v57.Acceleration = Vector3.new(0, 25, 0)
                    v57.Drag = 0
                    v50.End = v57
                    v49.Points = v50
                    v49.ArcSize = {
                        ["Min"] = 5,
                        ["Max"] = 25
                    }
                    v49.ChangesSegmentOffset = true
                    v49.OffsetChangePercent = {
                        ["EqualOrBelow"] = 0.5,
                        ["Bounds"] = { 0, 1 }
                    }
                    v49.Seed = Random.new():NextNumber(0, 9000000000)
                    v49.Bends = 3
                    v49.Fork_Bends = 2
                    v49.Fork_Chance = 0
                    v49.Max_Depth = 2
                    v48(v49)
                    u1()
                end
            end)
            for _ = 1, 10 do
                local v64 = u2.new
                local v65 = {
                    ["Lifetime"] = 1,
                    ["DrawType"] = "Singular",
                    ["Colors"] = _G.filterColor(u15, script.Beam.Color.Keypoints),
                    ["Sizes"] = u5,
                    ["Transparencies"] = u4
                }
                local v66 = {
                    ["Start"] = {
                        ["Position"] = (u16 * CFrame.new(0, 100, 0)).Position,
                        ["Velocity"] = Vector3.new(0, 0, 0),
                        ["Acceleration"] = Vector3.new(0, 0, 0),
                        ["Drag"] = 0
                    },
                    ["End"] = {
                        ["Position"] = u16.Position - Vector3.new(0, 10, 0),
                        ["Velocity"] = Vector3.new(0, 0, 0),
                        ["Acceleration"] = Vector3.new(0, 0, 0),
                        ["Drag"] = 3
                    }
                }
                v65.Points = v66
                v65.ArcSize = {
                    ["Min"] = 15,
                    ["Max"] = 45
                }
                v65.ChangesSegmentOffset = true
                v65.OffsetChangePercent = {
                    ["EqualOrBelow"] = 0.2,
                    ["Bounds"] = { 0, 1 }
                }
                v65.Seed = Random.new():NextNumber(0, 9000000000)
                v65.Bends = 3
                v65.Fork_Bends = 2
                v65.Fork_Chance = 0
                v65.Max_Depth = 2
                v64(v65)
                u1()
            end
        end)
    end
end
return v6