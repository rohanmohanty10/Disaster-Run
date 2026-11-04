 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v3 = require(script.slash)
            _G.PlaySound(p1, script.Parent.sounds.explodeslash)
            local v4 = script.Parent.effect.finalslash:Clone()
            if p2:FindFirstChild("BusoMelee") then
                v4:Destroy()
                v4 = script.Parent.effect.finalslashBuso:Clone()
            end
            v4:PivotTo(p1.CFrame)
            require(script.Parent.BusoColor):applyColors(p2, v4)
            v4.Parent = workspace.Effects
            v3(v4)
        end
    end
}