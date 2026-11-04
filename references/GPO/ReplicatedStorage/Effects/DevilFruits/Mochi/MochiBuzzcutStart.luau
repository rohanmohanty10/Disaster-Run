 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            _G.PlaySound(p1.HumanoidRootPart, script.MochiBuzzStart)
            local v2 = script.Mochis:Clone()
            local v3 = p1.Humanoid.BodyWidthScale.Value
            local v4 = p1.Humanoid.BodyDepthScale.Value
            local v5 = p1.Humanoid.BodyHeightScale.Value
            local v6 = Vector3.new(v3, v5, v4) + Vector3.new(0.025, 0.025, 0.025)
            local v7 = { "RightHand", "RightLowerArm", "RightUpperArm" }
            _G.destroy(v2, 0.45)
            for _, v8 in v7 do
                local v9 = p1[v8]
                local v10 = v2[v8]
                v10.Weld.Part1 = v9
                local v11 = v10.Mesh
                local v12 = -v9.Size.Y * 0.125
                v11.Offset = Vector3.new(0, v12, 0)
                local v13 = v10.Mesh
                local v14 = v6.X
                local v15 = v6.Z
                v13.Scale = Vector3.new(v14, 0, v15) * 0.85
            end
            v2.Parent = workspace.Effects
            local v16 = {
                0.1,
                "Linear",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }
            for _, v17 in v7 do
                _G.tween(v2[v17].Mesh, v16, {
                    ["Scale"] = v6,
                    ["Offset"] = Vector3.new(0, 0, 0)
                })
                task.wait(0.1)
            end
        end
    end
}