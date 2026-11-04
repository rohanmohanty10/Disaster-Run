 

local v1 = {}
local u2 = require(script.slash)
function v1.start(_, p3, p4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        _G.PlaySound(p3, script.Parent.sounds.shortslash)
        _G.PlaySound(p3, script.Parent.sounds.longslash)
        local v5 = script.Parent.effect.slash:Clone()
        if p4:FindFirstChild("BusoMelee") then
            v5:Destroy()
            v5 = script.Parent.effect.slashBuso:Clone()
        end
        v5:PivotTo(p3.CFrame)
        require(script.Parent.BusoColor):applyColors(p4, v5)
        v5.Parent = workspace.Effects
        u2(v5)
    end
end
return v1