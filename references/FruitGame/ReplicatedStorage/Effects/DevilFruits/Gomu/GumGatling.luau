 

local v1 = {}
local _ = game:GetService("RunService").Heartbeat
local u2 = Random.new()
function v1.start(_, p3, p4, _, p5) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if not _G.checkRenderDistance(p3.HumanoidRootPart.Position) then
        return
    end
    local v6 = script.GatlingLoop:Clone()
    v6.Parent = p3.Head
    v6:Play()
    local v7 = script.Part.Attachment:Clone()
    v7.Parent = p3.RightLowerArm
    local v8 = script.Part.Attachment:Clone()
    v8.Parent = p3.LeftLowerArm
    local v9 = false
    while true do
        local v10 = p3.HumanoidRootPart.CFrame
        local v11 = u2:NextNumber(-0.675, 0.675)
        local v12 = -math.random(150, 225) / 100
        local v13 = u2:NextNumber(-0.25, 0.25)
        local v14 = script.BendyLimb:Clone()
        local v15 = v14.Punch
        local v16 = v14.Spurt
        local v17 = v14.Line
        local _ = p3.RightLowerArm
        local v18 = p3:FindFirstChild("BusoMelee")
        if v9 then
            local v19 = CFrame.Angles(v13, v13, v11)
            v14:PivotTo(v10 * CFrame.new(0 + v13, 1, v12) * v19)
            v15.Color = p3.RightLowerArm.Color
            if v18 then
                v15.Color = Color3.fromRGB(0, 0, 0)
            end
            v16.Color = v15.Color
            v17.Color = v15.Color
            v16.CFrame = p3.RightUpperArm.CFrame * CFrame.Angles(v11, v11, 1.51)
            v7.Spark3:Emit(6)
            v7.ring:Emit(1)
        else
            v14:PivotTo(v10 * CFrame.new(-0 + v13, -1, v12) * CFrame.Angles(v13, v13, 3.14 + v11))
            v15.Color = p3.LeftLowerArm.Color
            if v18 then
                v15.Color = Color3.fromRGB(0, 0, 0)
            end
            v16.CFrame = p3.LeftUpperArm.CFrame * CFrame.Angles(v11, v11, 1.51)
            v16.Color = v15.Color
            v17.Color = v15.Color
            local _ = p3.LeftLowerArm
            v8.Spark3:Emit(6)
            v8.ring:Emit(1)
        end
        v14.Parent = workspace.Effects
        v14.AnimationController:LoadAnimation(v14.Animation):Play(0)
        _G.tween(v16.Mesh, {
            0.1,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(3, 0.1, 0.1),
            ["Offset"] = Vector3.new(-1.5, 0, 0)
        })
        _G.tween(v17.Mesh, {
            0.1,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(6, 1, 1),
            ["Offset"] = Vector3.new(5, 0, 0)
        })
        _G.destroy(v17, 0.1)
        _G.destroy(v14, 0.125)
        v9 = not v9
        local v20 = v10 * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(math.random(-200, 200) / 100, -math.random(100, 300) / 100, math.random(-200, 200) / 100)
        local v21 = math.random(500, 1000) / 100
        local v22 = _G.PlayEffect
        local v23 = v20 * CFrame.new(0, math.random(50, 150) / 100, 0)
        local v24 = BrickColor.new("White")
        local v25 = Vector3.new(v21, 0, v21)
        local v26 = v21 / 4
        local v27 = v21 / 4
        v22("Shockwave2", nil, v23, v20, v24, v25, Vector3.new(v26, 0.25, v27), math.random(50, 200) / 1000, 0.8, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
        local v28 = p3.HumanoidRootPart.CFrame
        local v29 = Ray.new(v28.Position, CFrame.new(v28.Position).upVector * -15)
        local v30, v31, _ = _G.raycastWhitelist(v29, { workspace.Islands, workspace.Ships })
        if v30 then
            local v32 = (v28.Position - v31).Magnitude
            p5.CFrame = v28 * CFrame.new(0, -v32, 0) * CFrame.Angles(3.141592653589793, 0, 0)
            local v33, v34, v35 = Color3.toHSV(v30.Color)
            local v36 = Color3.fromHSV(v33, v34, v35 - 0.1)
            p5.Attachment.sm2.Color = ColorSequence.new(v36)
            p5.Attachment.sm2.Enabled = true
        else
            p5.Attachment.sm2.Enabled = false
        end
        task.wait(0.02)
        if p4.Parent == nil then
            v6:Destroy()
            _G.destroy(v7, 0.3)
            _G.destroy(v8, 0.3)
            return
        end
    end
end
return v1