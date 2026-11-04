 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) ~= false then
            local v3 = p1.PrimaryPart.CFrame
            local v4 = p1:Clone()
            v4.Parent = workspace.Effects
            _G.destroy(v4, 2)
            p1:Destroy()
            if p2 == nil then
                _G.PlayEffect("BombExplosion", nil, v3, -5, 15, 0.25, 0.75, 300, 15)
            end
            v4:BreakJoints()
            v4.PrimaryPart:Destroy()
            local v5 = v4:GetDescendants()
            for v6 = 1, #v5 do
                if v5[v6]:IsA("BasePart") ~= false then
                    v5[v6]:BreakJoints()
                    local v7 = v5[v6]
                    local v8 = math.random(-25, 25)
                    local v9 = math.random(50, 75)
                    local v10 = math.random
                    v7.Velocity = Vector3.new(v8, v9, v10(-25, 25))
                    local v11 = v5[v6]
                    local v12 = math.random(-10, 10)
                    local v13 = math.random(-10, 10)
                    local v14 = math.random
                    v11.RotVelocity = Vector3.new(v12, v13, v14(-10, 10))
                    v5[v6].CanCollide = false
                end
            end
        end
    end
}