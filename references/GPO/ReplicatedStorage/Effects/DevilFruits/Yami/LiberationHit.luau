 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v4 = script.rokemitters:Clone()
            v4.CFrame = p1 * CFrame.Angles(0, math.random(-360, 360), 0)
            local v5 = v4.Attachment:GetChildren()
            for v6 = 1, #v5 do
                if v5[v6].Name:match("smoke") or (v5[v6].Name:match("dust") or v5[v6].Name:match("Smoke")) then
                    v5[v6].Color = ColorSequence.new(p2)
                end
            end
            local v7 = (p3 / Vector3.new(3, 3, 3)).Magnitude / 2
            v4.Size = v4.Size * v7
            _G.scaleParticle(v4, v7, true)
            v4.Parent = workspace.Effects
            _G.customEmit(v4)
            local v8 = script.Part:Clone()
            v8.CFrame = p1
            v8.Size = p3
            v8.Parent = workspace.Effects
            _G.tween(v8, {
                0.2,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Size"] = Vector3.new(15, 15, 15) * v7
            })
            _G.destroy(v8, 0.2)
            _G.PlaySound(v8, script["LiberationRockHit" .. math.random(1, 4)], {
                ["Pitch"] = math.random(90, 110) / 100
            })
            task.wait(2)
            _G.destroy(v4, 5)
        end
    end
}