 

game:GetService("TweenService")
game:GetService("Debris")
local u1 = game:GetService("RunService")
Random.new()
require(script.Parent.Shared)
local u2 = script.VFX
local u3 = RaycastParams.new()
u3.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u3.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p4) --[[ Name: start, Line 19 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
            [3] = u3
        --]]
        local v5 = p4.Character
        local v6 = p4.CFrame
        local v7 = p4.Duration
        local v8 = v5.HumanoidRootPart
        local v9 = v8.CFrame
        local v10 = p4.Direction
        local v11 = p4.LastCFrame
        if p4.zagCount > 5 then
            p4.zagCount = 1
        end
        local v12 = Instance.new("BodyVelocity")
        v12.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000)
        v12.Parent = v8
        local v13 = u2.Trail:Clone()
        v13.CFrame = v8.CFrame
        v13.Parent = workspace.Effects
        local v14 = u2.Appear_Emit:Clone()
        v14.CFrame = v8.CFrame
        v14.Parent = workspace.Effects
        _G.tween(v14.PointLight, {
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 40,
            ["Brightness"] = 0
        })
        _G.customEmit(v14)
        _G.destroy(v14, 3)
        local _ = v14.CFrame
        _G.PlaySound(v6, script["SoulZeusZigZagDash" .. p4.zagCount])
        if v11 then
            local v15 = u2.LightningBeam:Clone()
            v15.CFrame = v8.CFrame
            v15.Start.WorldCFrame = CFrame.new(v11.Position, v6.Position)
            v15.End.WorldCFrame = v15.Start.WorldCFrame
            v15.Parent = workspace.Effects
            local v16 = v7 * 2
            _G.destroy(v15, v16)
            _G.tween(v15.End, {
                v16,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["WorldPosition"] = v6.Position
            })
            local v17 = v15:GetDescendants()
            for v18 = 1, #v17 do
                if v17[v18]:IsA("Beam") then
                    local v19 = v17[v18]
                    v19.Width0 = v19.Width0 * 4
                    local v20 = v17[v18]
                    v20.Width1 = v20.Width1 * 4
                    _G.tween(v17[v18], {
                        v16,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end
            end
        end
        local v21 = 0
        while v21 <= 1 do
            local _, v22 = u1.Stepped:Wait()
            v21 = v21 + v22 / v7
            local v23 = v21 >= 1 and 1 or v21
            if v5.PrimaryPart == nil then
                break
            end
            local v24 = CFrame.new(Vector3.new(0, 0, 0), v10)
            local v25 = v9.Position
            local v26 = v9.Position
            local v27 = v6.Position
            local v28 = v24 + ((1 - v23) * (1 - v23) * v25 + 2 * (1 - v23) * v23 * v26 + v23 * v23 * v27)
            if v28 ~= v28 then
                warn("NaN detected in RootPart CFrame, breaking loop")
                break
            end
            v8.CFrame = v28
            local v29 = CFrame.new(Vector3.new(0, 0, 0), v10)
            local v30 = v9.Position
            local v31 = v9.Position
            local v32 = v6.Position
            local v33 = v29 + ((1 - v21) * (1 - v21) * v30 + 2 * (1 - v21) * v21 * v31 + v21 * v21 * v32)
            if v33 ~= v33 then
                warn("NaN detected in Trail CFrame, breaking loop")
                break
            end
            v13.CFrame = CFrame.new(v33.Position, v6.Position)
            local v34 = v13.Floor
            local v35 = workspace:Raycast(v8.Position + Vector3.new(0, 3, 0), Vector3.new(0, -25, 0), u3)
            if v35 and v35.Instance then
                _G.recolorParticles(v34, v35.Instance.Color)
                local v36 = v8.CFrame.LookVector * 3
                local v37 = v34.Dust1
                v37.Acceleration = v37.Acceleration + v36
                local v38 = v34.Rocks
                v38.Acceleration = v38.Acceleration + v36
                v34.WorldCFrame = CFrame.new(v35.Position, v35.Position + v35.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
            end
            local v39 = _G.particleEnabled
            local v40
            if v35 == nil then
                v40 = false
            else
                v40 = v35.Instance ~= nil
            end
            v39(v34, v40)
            if v21 >= 1 or v21 < 0 then
                break
            end
        end
        v12:Destroy()
        _G.particleEnabled(v13, false)
        task.delay(3, v13.Destroy, v13)
    end
}