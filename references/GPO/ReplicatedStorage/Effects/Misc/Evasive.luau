 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 3 ]]
        local v4 = tick()
        repeat
            p1:SetAttribute("previousEvasiveTick", tick())
            _G.soruDashing = true
            p1:SetAttribute("evading", true)
            p1.Humanoid.WalkSpeed = p2
            game["Run Service"].RenderStepped:Wait()
        until p3 <= tick() - v4
        p1.Humanoid.WalkSpeed = 16
        p1:SetAttribute("previousEvasiveTick", tick())
        _G.soruDashing = nil
        p1:SetAttribute("evading", nil)
    end
}