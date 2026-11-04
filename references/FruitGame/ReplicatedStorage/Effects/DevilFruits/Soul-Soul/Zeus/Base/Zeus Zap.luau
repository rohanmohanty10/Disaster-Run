 

game:GetService("TweenService")
game:GetService("Debris")
Random.new()
require(script.Parent.Shared)
local u1 = script.VFX
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = u1.Hit:Clone()
        v3.CFrame = p2.UpperTorso.CFrame
        v3.Parent = workspace.Effects
        _G.customEmit(v3)
        _G.destroy(v3, 4)
    end
}