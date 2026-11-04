 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        for v2 = 1, #p1 do
            local v3 = p1[v2]
            if _G.checkRenderDistance(v3.Position) ~= false then
                local v4, v5, v6 = _G.getRayFloor(v3, 400)
                if v4 then
                    local v7 = script.crash:Clone()
                    v7.CFrame = CFrame.new(v5, v6) * CFrame.Angles(0, 1.5707963267948966, 0)
                    v7.Attachment.Smoke.Color = ColorSequence.new(v4.Color)
                    v7.Attachment.rocks.Color = ColorSequence.new(v4.Color)
                    v7.Parent = workspace
                    _G.customEmit(v7)
                    _G.destroy(v7, 5)
                    _G.PlayEffect("GroundRocks2", nil, CFrame.new(v7.Position) * CFrame.new(0, 5, 0), 25, 150, 35, 0, 5)
                    _G.shakenear(v5, 750, 75, 125, -0.4)
                end
            end
        end
    end
}