 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            _G.PlaySound(p1.HumanoidRootPart, script.MochiBuzzStart)
            local u2 = script.BurnMochi:Clone()
            local v3 = p1.Humanoid.BodyWidthScale.Value
            local v4 = p1.Humanoid.BodyDepthScale.Value
            local v5 = p1.Humanoid.BodyHeightScale.Value
            local v6 = Vector3.new(v3, v5, v4) + Vector3.new(0.025, 0.025, 0.025)
            local v7 = p1.RightUpperArm
            local v8 = u2.RightUpperArm
            v8.Weld.Part1 = v7
            u2.root.Weld.Part1 = v7
            local v9 = v8.Mesh
            local v10 = v7.Size.Y * 0.25
            v9.Offset = Vector3.new(0, v10, 0)
            local v11 = v8.Mesh
            local v12 = v6.X
            local v13 = v6.Z
            v11.Scale = Vector3.new(v12, 0, v13) * 0.925
            u2.root.WhiteBall.C1 = CFrame.new(0, -1.5, 0)
            u2.DoughHand.Size = Vector3.new(0, 0, 0)
            u2.WhiteBall.Mesh.Scale = Vector3.new(0, 0, 0)
            u2.HotBall.Size = Vector3.new(0, 0, 0)
            u2:SetAttribute("movin", true)
            u2.Parent = workspace.Effects
            local v14 = Instance.new("ObjectValue")
            v14.Name = "burnMochi"
            v14.Value = u2
            v14.Parent = p1.PrimaryPart
            _G.tween(u2.WhiteBall.Mesh, {
                0.18,
                "Quad",
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(3, 3, 3)
            })
            local v15 = {
                0.35,
                "Quad",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }
            _G.tween(v8.Mesh, v15, {
                ["Scale"] = v6,
                ["Offset"] = Vector3.new(0, 0, 0)
            })
            delay(0.21, function() --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                _G.customEmit(u2.root.Attachment.Dough)
                u2.HotBall.Size = Vector3.new(2.5, 2.5, 2.5)
                while u2:GetAttribute("movin") do
                    local v16 = tick() * 2
                    local v17 = math.cos(v16) * 0.05 + 4
                    local v18 = Vector3.new(v17, v17, v17)
                    u2.root.WhiteBall.C1 = u2.root.WhiteBall.C1:lerp(CFrame.Angles(v17, 0, v17), 0.19)
                    u2.root.DoughHand.C1 = u2.root.DoughHand.C1:lerp(CFrame.new(0, 0, v17 * 0.475), 0.19)
                    u2.WhiteBall.Mesh.Scale = u2.WhiteBall.Mesh.Scale:lerp(v18, 0.19)
                    u2.HotBall.Size = u2.WhiteBall.Mesh.Scale - Vector3.new(0.65, 0.65, 0.65)
                    u2.DoughHand.Size = u2.WhiteBall.Mesh.Scale - Vector3.new(2, 2, 2.45)
                    task.wait(0.0166666667)
                end
            end)
        end
    end
}