 

return {
    ["CreateSideFlyingRocks"] = function(p1, p2, p3, p4) --[[ Name: CreateSideFlyingRocks, Line 3 ]]
        for _ = 1, 2 do
            local v5 = Random.new():NextNumber(0.8, 1.15)
            local u6 = script.Rock1:Clone()
            u6.Size = u6.Size * v5
            local v7 = u6.Rock2
            v7.Size = v7.Size * v5
            local v8 = (0 + u6.Mass + u6.Rock2.Mass) / 2
            u6.Position = (p1 * CFrame.new(p2, 0, 0)).Position
            u6.Orientation = Vector3.new(20, 10, 20) * Random.new():NextNumber(-5, 5)
            local v9, _, _ = _G.getRayFloor(u6.CFrame, 20)
            if v9 then
                _G.matchMaterial(u6, v9)
                u6.Attachment.Trail.Color = ColorSequence.new(v9.Color)
                u6.Parent = workspace.Effects
                local v10 = math.sign(p2)
                local v11 = math.sign(p2)
                u6:ApplyImpulse(p3 * Vector3.new(v10, v5, v11) * v5 + p4)
                u6:ApplyAngularImpulse(Vector3.new(20, 10, 20) * Random.new():NextNumber(-5, 5) * v8 / 5)
                task.delay(1.7, function() --[[ Line: 32 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                    --]]
                    u6:Destroy()
                end)
                p2 = -p2
            else
                u6:Destroy()
            end
        end
    end
}