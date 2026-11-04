 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 18 ]]
        if _G.checkRenderDistance(p1.Position) == false then
            return
        end
        local v4 = CFrame.new(p2, p2 + p3)
        local v5 = CFrame.Angles
        local v6 = math.random(0, 360)
        local v7 = v4 * v5(1.5707963267948966, math.rad(v6), 3.141592653589793)
        local v8 = tick()
        local v9 = 0
        while true do
            if tick() - v9 >= 0.1 then
                if tick() - v8 >= 1 then
                    break
                end
                local v10 = script.Parent.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
                v10:ClearAllChildren()
                local v11 = math.random(5, 8)
                v10.Size = Vector3.new(v11, v11, v11)
                v10.CFrame = v7
                v10.Parent = workspace.Effects
                _G.tween(v10, {
                    0.25,
                    "EntranceExpressive",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = CFrame.new(v10.Position) * CFrame.new(0, 20, 0)
                })
                _G.tween(v10, {
                    0.25,
                    "Smoother",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["Color"] = Color3.fromRGB(0, 0, 0)
                })
                _G.destroy(v10, 0.25)
                v9 = tick()
            end
            task.wait(0.1)
            if tick() - v8 >= 1 then
                break
            end
        end
    end
}