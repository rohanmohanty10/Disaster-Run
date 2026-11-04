 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 17 ]]
        if p1 and (p1:FindFirstChild("HumanoidRootPart") and _G.checkRenderDistance(p1:FindFirstChild("HumanoidRootPart").Position) == false) then
            return
        end
        local v3 = 0
        while true do
            if tick() - v3 >= 0.1 then
                if _G.checkRenderDistance(p1.HumanoidRootPart.Position) == true then
                    local v4 = script.Part:Clone()
                    local v5 = Instance.new("Weld")
                    v5.Part0 = p1.HumanoidRootPart
                    v5.Part1 = v4
                    local v6 = CFrame.new(0, 1, 0)
                    local v7 = CFrame.Angles
                    local v8 = math.random(-180, 180)
                    v5.C0 = v6 * v7(0, math.rad(v8), 0)
                    v5.Parent = v4
                    local v9 = math.random(15, 18)
                    local v10 = v4.Mesh
                    local v11 = -v9
                    local v12 = -v9
                    v10.Scale = Vector3.new(v11, 1, v12)
                    v4.Parent = workspace.Effects
                    _G.tween(v4.Decal, {
                        0.25,
                        "Smoother",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1,
                        ["Color3"] = Color3.fromRGB(0, 0, 0)
                    })
                    _G.tween(v4.Mesh, {
                        0.25,
                        "Smooth",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = Vector3.new(-30, -1, -30)
                    })
                    _G.PlayEffect("Rotate", nil, v5, CFrame.Angles(0, -0.25, 0))
                    _G.destroy(v4, 0.25)
                end
                v3 = tick()
            end
            game["Run Service"].Heartbeat:Wait()
            if p2.Parent == nil then
                return
            end
        end
    end
}