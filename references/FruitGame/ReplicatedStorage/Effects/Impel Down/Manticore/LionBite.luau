 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) ~= false then
            game:GetService("TweenService")
            local v2 = workspace.Effects
            local v3 = script.LionBite:Clone()
            local v4 = v3.Bite
            v3.Parent = v2
            v4.CFrame = p1["Cube.006"].CFrame * CFrame.new(0, -3, -15)
            task.wait(0.425)
            _G.customEmit(v4)
            _G.destroy(v3, 2.5)
        end
    end
}