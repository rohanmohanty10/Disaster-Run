 

game:GetService("RunService")
game:GetService("TweenService")
return {
    ["start"] = function(_, p1) --[[ Name: start, Line 16 ]]
        local v2 = p1.Statue
        local v3 = p1.State
        if v3 == "Combust" then
            local v4 = script.StatueCombust:Clone()
            v4:PivotTo(v2:GetPivot())
            v4.Parent = workspace.Effects
            _G.customEmit(v4)
            task.delay(5, v4.Destroy, v4)
            _G.PlaySound(v4.CFrame, script.StatueSFX.StatueDie)
        elseif v3 == "Hit" then
            local v5 = script.StatueHit:Clone()
            v5:PivotTo(v2:GetPivot())
            v5.Parent = workspace.Effects
            _G.customEmit(v5)
            task.delay(5, v5.Destroy, v5)
            _G.PlaySound(v5.CFrame, script.StatueSFX["StatueHit" .. math.random(1, 3)], {
                ["RandomPitch"] = true
            })
        end
    end
}