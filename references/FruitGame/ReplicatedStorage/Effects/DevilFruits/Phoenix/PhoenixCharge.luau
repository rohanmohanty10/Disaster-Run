 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = game:GetService("ReplicatedStorage"):WaitForChild("Refrences"):WaitForChild("Phoenix")
local u4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
local u5 = require(game:GetService("ReplicatedStorage").Util.ShakeCamera)
local u6 = workspace.CurrentCamera
local u7 = require(u3.Modules.Slash)
local u8 = require(game.ReplicatedStorage.Util.Tween)
require(u3.Effects.Flare)
function v1.start(_, p9, p10, p11, p12, p13) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u8
        [4] = u6
        [5] = u5
        [6] = u7
        [7] = u2
    --]]
    local v14 = p11 or 10
    if not p12 then
        Color3.fromRGB(255, 170, 0)
    end
    local v15 = p13 or 0.5
    local v16 = p9.CFrame
    if _G.checkRenderDistance(v16.Position) == false then
        return
    end
    local v17 = Instance.new("Part")
    v17.Anchored = true
    v17.CanCollide = false
    v17.Size = Vector3.new(1, 1, 1) * v14
    v17.Transparency = 1
    v17.CFrame = v16
    local v18 = Instance.new("Attachment")
    local v19 = -v17.Size.Y / 2
    v18.Position = Vector3.new(0, v19, 0)
    v18.Parent = v17
    local v20 = script.dust.Attachment:Clone()
    local v21 = -v17.Size.Y / 3
    v20.Position = Vector3.new(0, v21, 0)
    v20.Parent = v17
    local v22 = {}
    local v23 = {}
    for v24 = 1, 2 do
        local v25 = v24 == 1 and 1.25 or 1.5
        local v26 = u3.Particles["Flame" .. v24]:Clone()
        v22[v26] = v26.Size.Keypoints
        local v27 = v14 * 8
        v26.Rate = math.min(200, v27)
        v26.Size = u4.ScaleParticleSize(v22[v26], v14 * 0.35)
        v26.Drag = v14 * 0.5
        v26.ZOffset = 1
        v26.Speed = NumberRange.new(v14 * 2 * v25, v14 * 8 * v25)
        v26.Parent = v18
        table.insert(v23, v26)
    end
    v17.Parent = workspace.Effects
    for _, v28 in next, v23 do
        v28.Enabled = true
    end
    _G.PlayEffect("Spheres", nil, {
        ["cf"] = v16,
        ["ti"] = 0.25,
        ["ti2"] = 0.25,
        ["range"] = 15,
        ["minThick"] = 1,
        ["maxThick"] = 15,
        ["part"] = p9,
        ["color"] = Color3.fromRGB(255, 170, 0),
        ["am"] = 15
    })
    _G.PlayEffect("Spheres", nil, {
        ["cf"] = v16,
        ["ti"] = 0.25,
        ["ti2"] = 0.25,
        ["range"] = 15,
        ["minThick"] = 1,
        ["maxThick"] = 15,
        ["part"] = p9,
        ["color"] = Color3.fromRGB(0, 255, 255),
        ["am"] = 15
    })
    u4.PlaySound(v17, u3.Sounds["Audio/PhoUltWhoosh1"])
    local v29 = tick()
    local v30 = nil
    local v31 = 0
    local v32 = 0
    while p9 and (p9.Parent and (p10 and p10.Value)) do
        local v33 = tick()
        local v34 = (v33 - v29) / 5
        local v35 = math.min(1, v34)
        if not p10.Value or (p10.Parent == nil or tick() - v29 >= 10) then
            break
        end
        local v36 = p9.CFrame
        local v37 = u8.point(v14, v14 * 2, v35)
        local v38 = v15 * u8.point(1, 0.75, v35)
        v17.Size = Vector3.new(1, 1, 1) * v37
        v17.CFrame = v36
        for v39, v40 in next, v23 do
            local v41 = v39 == 1 and 1.25 or 1.5
            local v42 = v22[v40]
            v40.Size = u4.ScaleParticleSize(v42, v37 * 0.2)
            local v43 = v37 * 5
            v40.Rate = math.min(360, v43)
            v40.Drag = v37 * 0.75
            v40.Speed = NumberRange.new(v37 * 8 * v41, v37 * 16 * v41)
        end
        v20.Rocks.Speed = NumberRange.new(v37 * 8, v37 * 16)
        v20.sm2.Speed = NumberRange.new(v37 * 8, v37 * 16)
        local v44 = Ray.new(v20.WorldPosition + Vector3.new(0, 3, 0), v20.WorldCFrame.upVector * -10)
        local v45, _, _ = _G.raycastWhitelist(v44, { workspace.Islands, workspace.Env, workspace.Ships })
        if v45 then
            v20.Rocks.Color = ColorSequence.new(v45.Color)
            v20.sm2.Color = v20.Rocks.Color
        else
            v20.Rocks.Enabled = false
            v20.sm2.Enabled = false
        end
        if v33 - v31 > v38 * 0.6 then
            u4.PlaySound(v17, u3.Sounds["Audio/PhoUltStart"], {
                ["PlaybackSpeed"] = 1 / v38
            })
            v31 = v33
        end
        if v38 < v33 - v32 then
            local v46 = (u6.CFrame.Position - v36.Position).Magnitude / (25 + v37 * 2.75)
            if v46 < 1 then
                local v47 = 1 - v46
                u5({
                    ["RotationInfluence"] = Vector3.new(0, 0, 1),
                    ["Roughness"] = 4 * v47,
                    ["Magnitude"] = 6 * v47,
                    ["FadeIn"] = v38 * 2,
                    ["FadeOut"] = v38 * 0.5
                })
            end
            if v35 > 0.2 then
                local v48 = v37 * 1 * 1.5
                local v49 = CFrame.new(0, -2.5, 0)
                u7.new(8, {
                    ["Anchor"] = v17,
                    ["Scale"] = v48,
                    ["Color"] = Color3.fromRGB(0, 170, 255),
                    ["Accent"] = Color3.fromRGB(255, 170, 0),
                    ["Offset"] = v49,
                    ["Transparency"] = 0.075,
                    ["Duration"] = v38 * 0.75 * 1.5,
                    ["RotationDirection"] = 3
                }):Emit()
            end
            if v35 > 0 then
                u7.new(5, {
                    ["Anchor"] = v17,
                    ["Scale"] = v37 * 1.5 * Random.new():NextNumber(0.75, 1.25),
                    ["Color"] = Color3.fromRGB(0, 170, 255),
                    ["Duration"] = v38,
                    ["Transparency"] = 0,
                    ["RotationDirection"] = (math.random(1, 2) == 1 and 1 or -1) * 2
                }):Emit()
            end
            if v35 > 0.15 then
                u7.new(6, {
                    ["Anchor"] = v17,
                    ["Scale"] = v37 * 1.75 * Random.new():NextNumber(1, 1.5),
                    ["Offset"] = CFrame.new(0, math.random(-v37 / 2, -v37 / 4), 0),
                    ["Transparency"] = 0,
                    ["Color"] = Color3.fromRGB(213, 115, 61),
                    ["Duration"] = v38 * 1.5,
                    ["RotationDirection"] = (math.random(1, 2) == 1 and 1 or -1) * 2
                }):Emit()
                v32 = v33
            else
                v32 = v33
            end
        end
        local v50 = v30 or 0
        if v35 > 0.05 then
            if v33 - v50 <= v38 * 0.65 then
                v33 = v50
            end
        else
            v33 = v50
        end
        u2.RenderStepped:Wait()
        v30 = v33
    end
    for _, v51 in next, v23 do
        v51.Enabled = false
    end
    v20.Rocks.Enabled = false
    v20.sm2.Enabled = false
    task.wait(1 + v23[2].Lifetime.Max)
    v17:Destroy()
end
return v1