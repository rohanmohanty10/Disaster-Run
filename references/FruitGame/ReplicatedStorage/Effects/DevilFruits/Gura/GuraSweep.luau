 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) ~= false then
            repeat
                game["Run Service"].Heartbeat:Wait()
                local v4 = script.m:Clone()
                v4.Parent = workspace.Effects
                v4.Size = Vector3.new(p3, 0, p3)
                local v5 = p1.HumanoidRootPart.CFrame * CFrame.new(0, 2.8, 0)
                local v6 = CFrame.Angles
                local v7 = math.random(-360, 360)
                v4.CFrame = v5 * v6(0, math.rad(v7), 0)
                _G.PlayEffect("Rotate", nil, v4, CFrame.Angles(0, -0.2, 0))
                _G.tween(v4, {
                    0.15,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v4, 0.15)
            until p2:IsDescendantOf(game) == false
        end
    end
}