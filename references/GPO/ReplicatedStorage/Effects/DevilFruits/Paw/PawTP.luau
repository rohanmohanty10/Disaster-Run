 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v2 = script.StartEff:Clone()
            v2.CFrame = p1
            v2.Parent = workspace.Effects
            _G.customEmit(v2)
            _G.destroy(v2, 0.3)
            for _ = 1, 10 do
                local v3 = script.Paw2:Clone()
                v3.CFrame = p1 * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                v3.Size = v3.Size * math.random(100, 500) / 100
                v3.Parent = workspace.Effects
                local v4 = math.random(250, 1000) / 1000
                _G.tween(v3, { v4, "Quad", "Out" }, {
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(),
                    ["CFrame"] = v3.CFrame * CFrame.new(0, 0, math.random(5, 15)) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                })
                _G.destroy(v3, v4)
            end
        end
    end
}