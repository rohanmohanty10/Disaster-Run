 

local _ = script
game:GetService("ReplicatedStorage")
game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
game:GetService("TweenService")
Random.new()
return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 10 ]]
        if p1 == nil then
            return
        elseif p1.PrimaryPart then
            _G.emitHitVfx(script.ChargeEmit, p1.PrimaryPart.CFrame)
            _G.PlaySound(p1.PrimaryPart, script.openSFX)
        end
    end
}