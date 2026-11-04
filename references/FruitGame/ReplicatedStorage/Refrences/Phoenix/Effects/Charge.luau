 

local u1 = game:GetService("RunService")
local u2 = workspace:WaitForChild("Effects")
local u3 = require(game.ReplicatedStorage.Util.Tween)
local u4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
local u5 = game:GetService("ReplicatedStorage"):WaitForChild("Phoenix")
local u6 = require(u5.Modules.Slash)
require(u5.Effects.Shockwave)
local u7 = require(u5.Effects.Flare)
local u8 = require(game:GetService("ReplicatedStorage").Util.ShakeCamera)
local u9 = workspace.CurrentCamera
return function(p10, p11, p12, p13, p14) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u2
        [4] = u7
        [5] = u3
        [6] = u9
        [7] = u8
        [8] = u6
        [9] = u1
    --]]
    local v15 = p12 or 10
    if not p13 then
        Color3.fromRGB(255, 170, 0)
    end
    local v16 = p10.CFrame
    local v17 = Instance.new("Part")
    v17.Anchored = true
    v17.CanCollide = false
    v17.Size = Vector3.new(1, 1, 1) * v15
    v17.Transparency = 1
    v17.CFrame = v16
    local v18 = Instance.new("Attachment", v17)
    local v19 = -v17.Size.Y / 2
    v18.Position = Vector3.new(0, v19, 0)
    local v20 = script.dust.Attachment:Clone()
    local v21 = -v17.Size.Y / 3
    v20.Position = Vector3.new(0, v21, 0)
    v20.Parent = v17
    local v22 = {}
    local v23 = {}
    local v24 = p14 or 0.5
    for v25 = 1, 2 do
        local v26 = v25 == 1 and 1.25 or 1.5
        local v27 = u5.Particles["Flame" .. v25]:Clone()
        v22[v27] = v27.Size.Keypoints
        local v28 = v15 * 8
        v27.Rate = math.min(200, v28)
        v27.Size = u4.ScaleParticleSize(v22[v27], v15 * 0.35)
        v27.Drag = v15 * 0.5
        v27.ZOffset = 1
        v27.Speed = NumberRange.new(v15 * 2 * v26, v15 * 8 * v26)
        v27.Parent = v18
        table.insert(v23, v27)
    end
    v17.Parent = u2
    for _, v29 in next, v23 do
        v29.Enabled = true
    end
    local v30 = u7
    local v31 = v17.CFrame
    local v32 = Color3.fromRGB(255, 170, 0)
    local v33 = v15 * 1.5
    local v34 = v15 * 0.5
    v30(v31, v32, v33, math.min(12, v34), v15 * 0.5, v15 * 0.75, v24 * 0.5, v24 * 0.25)
    u4.PlaySound(v17, u5.Sounds["Audio/PhoUltWhoosh1"])
    local v35 = tick()
    local v36 = nil
    local v37 = 0
    local v38 = 0
    while p10 and (p10.Parent and (p11 and p11.Value)) do
        local v39 = tick()
        local v40 = (v39 - v35) / 5
        local v41 = math.min(1, v40)
        if not p11.Value then
            break
        end
        local v42 = p10.CFrame
        local v43 = u3.point(v15, v15 * 2, v41)
        local v44 = v24 * u3.point(1, 0.75, v41)
        v17.Size = Vector3.new(1, 1, 1) * v43
        v17.CFrame = v42
        for v45, v46 in next, v23 do
            local v47 = v45 == 1 and 1.25 or 1.5
            local v48 = v22[v46]
            v46.Size = u4.ScaleParticleSize(v48, v43 * 0.2)
            local v49 = v43 * 5
            v46.Rate = math.min(360, v49)
            v46.Drag = v43 * 0.75
            v46.Speed = NumberRange.new(v43 * 8 * v47, v43 * 16 * v47)
        end
        v20.Rocks.Speed = NumberRange.new(v43 * 8, v43 * 16)
        v20.sm2.Speed = NumberRange.new(v43 * 8, v43 * 16)
        local v50 = Ray.new(v20.WorldPosition + Vector3.new(0, 3, 0), v20.WorldCFrame.upVector * -10)
        local v51, _, _ = _G.raycastWhitelist(v50, { workspace.Islands, workspace.Env, workspace.Ships })
        if v51 then
            v20.Rocks.Color = ColorSequence.new(v51.Color)
            v20.sm2.Color = v20.Rocks.Color
        else
            v20.Rocks.Enabled = false
            v20.sm2.Enabled = false
        end
        if v39 - v37 > v44 * 0.6 then
            u4.PlaySound(v17, u5.Sounds["Audio/PhoUltStart"], {
                ["PlaybackSpeed"] = 1 / v44
            })
            v37 = v39
        end
        if v44 < v39 - v38 then
            local v52 = (u9.CFrame.p - v42.p).Magnitude / (25 + v43 * 2.75)
            if v52 < 1 then
                local v53 = 1 - v52
                u8({
                    ["RotationInfluence"] = Vector3.new(0, 0, 1),
                    ["Roughness"] = 8 * v53,
                    ["Magnitude"] = 6 * v53,
                    ["FadeIn"] = v44 * 2,
                    ["FadeOut"] = v44 * 0.5
                })
            end
            if v41 > 0.2 then
                local v54 = v43 * 2 * 1.5
                local v55 = CFrame.new(0, -2.5, 0)
                u6.new(8, {
                    ["Anchor"] = v17,
                    ["Scale"] = v54,
                    ["Color"] = Color3.fromRGB(0, 170, 255),
                    ["Accent"] = Color3.fromRGB(255, 170, 0),
                    ["Offset"] = v55,
                    ["Transparency"] = 0.075,
                    ["Duration"] = v44 * 0.75 * 1.5,
                    ["RotationDirection"] = 3
                }):Emit()
            end
            if v41 > 0 then
                u6.new(5, {
                    ["Anchor"] = v17,
                    ["Scale"] = v43 * 1.5 * Random.new():NextNumber(0.75, 1.25),
                    ["Color"] = Color3.fromRGB(0, 170, 255),
                    ["Duration"] = v44,
                    ["Transparency"] = 0,
                    ["RotationDirection"] = (math.random(1, 2) == 1 and 1 or -1) * 2
                }):Emit()
            end
            if v41 > 0.15 then
                u6.new(6, {
                    ["Anchor"] = v17,
                    ["Scale"] = v43 * 1.75 * Random.new():NextNumber(1, 1.5),
                    ["Offset"] = CFrame.new(0, math.random(-v43 / 2, -v43 / 4), 0),
                    ["Transparency"] = 0,
                    ["Color"] = Color3.fromRGB(213, 115, 61),
                    ["Duration"] = v44 * 1.5,
                    ["RotationDirection"] = (math.random(1, 2) == 1 and 1 or -1) * 2
                }):Emit()
                v38 = v39
            else
                v38 = v39
            end
        end
        local v56 = v36 or 0
        if v41 > 0.05 then
            if v39 - v56 <= v44 * 0.65 then
                v39 = v56
            end
        else
            v39 = v56
        end
        u1.RenderStepped:Wait()
        v36 = v39
    end
    for _, v57 in next, v23 do
        v57.Enabled = false
    end
    v20.Rocks.Enabled = false
    v20.sm2.Enabled = false
    task.wait(1 + v23[2].Lifetime.Max)
    v17:Destroy()
end