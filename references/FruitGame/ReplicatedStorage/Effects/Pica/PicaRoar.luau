 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.TransformedWorldCFrame.Position) == false then
            return
        end
        local v3 = script.Part:Clone()
        v3.CFrame = p1.TransformedWorldCFrame
        v3.Parent = workspace.Effects
        local v4 = tick()
        local v5 = 0
        local v6 = 0
        while true do
            if tick() - v5 >= 0.1 then
                v5 = tick()
                _G.customEmit(v3)
            end
            if tick() - v6 >= 0.5 then
                _G.shakenear(p1.TransformedWorldCFrame.Position, 750, 75, 125, -0.4)
                v6 = tick()
            end
            v3.CFrame = p1.TransformedWorldCFrame
            task.wait()
            if p2 <= tick() - v4 then
                _G.destroy(v3, 3)
                return
            end
        end
    end
}