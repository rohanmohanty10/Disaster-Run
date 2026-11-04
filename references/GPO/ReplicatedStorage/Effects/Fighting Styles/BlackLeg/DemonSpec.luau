 

local v1 = {}
local function u7(p2, p3) --[[ Line: 3 ]]
    local v4 = p2.Size * math.random(90, 130) / 100
    local v5 = math.random(100, 1000) / 5000
    local v6 = p2.Size.Z
    p2.Size = Vector3.new(v5, v5, v6)
    _G.tween(p2, {
        0.2,
        Enum.EasingStyle.Exponential,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = v4,
        ["Transparency"] = 1,
        ["CFrame"] = p2.CFrame * CFrame.new(0, 0, -p3 / 2)
    })
end
function v1.start(_, p8, p9) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if _G.checkRenderDistance(p8.HumanoidRootPart.Position) ~= false then
        repeat
            game["Run Service"].Heartbeat:Wait()
            local v10 = script.Model:Clone()
            local v11 = p8.HumanoidRootPart.CFrame
            local v12 = CFrame.Angles
            local v13 = math.random(-10, 10)
            local v14 = math.rad(v13)
            local v15 = math.random(-10, 10)
            v10:PivotTo(v11 * v12(v14, math.rad(v15), math.random(-360, 360)) * CFrame.new(math.random(-1000, 1000) / 1000, math.random(-1000, 1000) / 1000, -5))
            v10.Parent = workspace.Effects
            u7(v10.PrimaryPart, 10)
            u7(v10.Flame, 10)
            _G.destroy(v10, 0.25)
            local v16 = script.ring:Clone()
            v16.CFrame = v10.PrimaryPart.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(1.5707963267948966, math.random(-360, 360), 0)
            v16.Parent = workspace.Effects
            local v17 = math.random(400, 600) / 100
            local v18 = _G.tween
            local v19 = {
                0.2,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v20 = {}
            local v21 = v16.Size.Y
            v20.Size = Vector3.new(v17, v21, v17)
            v20.Transparency = 1
            v18(v16, v19, v20)
            v16.Attachment.ParticleEmitter:Emit(6)
            _G.destroy(v16, 0.25)
        until p9:IsDescendantOf(game) == false
    end
end
return v1