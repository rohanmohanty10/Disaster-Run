 

return {
    ["CreateFlyingRocks"] = function(p1, p2, p3) --[[ Name: CreateFlyingRocks, Line 3 ]]
        local v4 = Random.new():NextNumber(0.8, 1.15)
        local u5 = script.Rock1:Clone()
        _G.matchMaterial(u5, p3.Instance)
        _G.matchMaterial(u5.Rock2, p3.Instance)
        u5.Color = p3.Instance.Color:Lerp(Color3.new(0, 0, 0), 0.35)
        u5.Rock2.Color = p3.Instance.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0.15)
        u5.Size = u5.Size * v4
        local v6 = u5.Rock2
        v6.Size = v6.Size * v4
        local v7 = (0 + u5.Mass + u5.Rock2.Mass) / 2
        u5.Position = (p1 * CFrame.new(0, 0, 0)).Position
        u5.Orientation = Vector3.new(20, 10, 20) * Random.new():NextNumber(-5, 5)
        u5.Parent = workspace.Effects
        u5:ApplyImpulse(p2 * Vector3.new(1, v4, 1) * v4 * (v7 ^ 1 / 2 / 3))
        u5:ApplyAngularImpulse(Vector3.new(20, 10, 20) * (Random.new():NextUnitVector() * 10) * (v7 ^ 1 / 2))
        task.delay(1.7, function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5:Destroy()
        end)
    end
}