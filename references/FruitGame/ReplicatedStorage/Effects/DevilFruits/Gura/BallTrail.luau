
return {
    ["start"] = function(_, p1, p2, p3, p4, p5, p6) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(p1.Position) == false then
            return
        end
        local v7 = p1.CFrame
        if p6 == nil then
            p6 = 0.05
        end
        while true do
            game["Run Service"].RenderStepped:Wait()
            if p6 <= (p1.Position - v7.Position).Magnitude then
                local v8 = script.Part:Clone()
                v8.Mesh.Scale = Vector3.new(p3, p3, p3)
                v8.Color = p4
                v8.CFrame = p1.CFrame
                local v9 = p1.CFrame
                local v10 = (v7.Position - v9.Position).Magnitude
                v8.Mesh.Scale = Vector3.new(0, v10, 0)
                v8.CFrame = CFrame.new(v7.Position, v9.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v10 / 2, 0)
                v8.Mesh.Scale = Vector3.new(p3, v10, p3)
                v8.Parent = workspace.Effects
                v8.Attachment.ParticleEmitter:Emit(2)
                _G.tween(v8.Mesh, {
                    p5,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, v10, 0)
                })
                _G.destroy(v8, p5 + 2)
                v7 = p1.CFrame
            end
            if p2:IsDescendantOf(game) == false then
                return
            end
        end
    end
}