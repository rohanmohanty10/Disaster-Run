 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        local v2 = script.Effect:Clone()
        v2:ScaleTo(p1.Scale or 1)
        v2:PivotTo(p1.CFrame * CFrame.new(0, -v2.PrimaryPart.Size.Y / 2, 0))
        v2.Parent = workspace.Effects
        _G.destroy(v2, 4)
        _G.customEmit(v2)
        _G.PlaySound(v2, script["Audio/PresentHitGround"], {
            ["RollOffMaxDistance"] = script["Audio/PresentHitGround"].RollOffMaxDistance * p1.Scale or 1,
            ["RandomPitch"] = true
        })
    end
}