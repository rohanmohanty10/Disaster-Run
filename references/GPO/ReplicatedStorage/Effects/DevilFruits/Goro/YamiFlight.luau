 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        while p2 and p2.Parent ~= nil do
            task.wait()
            local v3 = script.WindTrails:Clone()
            v3.Parent = workspace.Effects
            v3.CFrame = p1.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
            local v4 = Instance.new("Weld")
            v4.Part0 = p1.PrimaryPart
            v4.Part1 = v3
            v4.Parent = v3
            _G.PlayEffect("Rotate", nil, v4, CFrame.Angles(0, 0, 0.05235987755982989))
            local v5 = Instance.new("Attachment")
            local v6 = Instance.new("Attachment")
            v5.Parent = v3
            v6.Parent = v3
            local u7 = v3.Folder.Trail:Clone()
            u7.Parent = v3.Folder
            u7.Attachment0 = v5
            u7.Attachment1 = v6
            u7.Name = "TrailDupe"
            local v8 = math.random(-(v3.Size.X / (v3.Size.X / 2)), v3.Size.X / (v3.Size.X / 2))
            local v9 = math.random(-(v3.Size.Y / (v3.Size.Y / 2)), v3.Size.Y / (v3.Size.Y / 2))
            local v10 = math.random
            local v11 = -(v3.Size.Z / (v3.Size.Z / 2))
            local v12 = v3.Size.Z / (v3.Size.Z / 2)
            v5.Position = Vector3.new(v8, v9, v10(v11, v12))
            local v13 = v5.Position
            local v14 = math.random(-400, 400) / 100
            local v15 = math.random(-400, 400) / 100
            local v16 = math.random(-400, 400) / 100
            v6.Position = v13 + Vector3.new(v14, v15, v16)
            task.delay(0.5, function() --[[ Line: 42 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                u7.Enabled = false
            end)
            _G.destroy(v5, 0.9)
            _G.destroy(v6, 0.9)
            _G.destroy(u7, 0.9)
            _G.destroy(v3, 3)
            local v17 = _G.tween
            local v18 = {
                2,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }
            local v19 = {}
            local v20 = v6.Position
            local v21 = math.random(-600, 600) / 100
            local v22 = math.random(-600, 600) / 100
            local v23 = math.random
            v19.Position = v20 + Vector3.new(v21, v22, v23(5, 10))
            v17(v6, v18, v19)
        end
    end
}