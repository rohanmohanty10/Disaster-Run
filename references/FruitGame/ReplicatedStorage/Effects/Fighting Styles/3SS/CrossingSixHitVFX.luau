 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        local v3 = _G.emitHitVfx(script.hitVFX, p1.PrimaryPart.CFrame, 1)
        if p2 then
            _G.PlayEffect("3SSRecolor", nil, v3, p2, "isBlue", Color3.fromRGB(46, 74, 255))
        end
    end
}