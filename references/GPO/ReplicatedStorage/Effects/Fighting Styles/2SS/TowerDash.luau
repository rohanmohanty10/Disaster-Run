 

local v1 = {}
local u2 = require(script.fastspeed)
function v1.start(_, u3, p4, p5) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.Position) ~= false then
        _G.PlaySound(u3, script.Parent.sounds.dash)
        task.spawn(function() --[[ Line: 10 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            task.wait(0.1)
            _G.PlaySound(u3, script.Parent.sounds.katanaswirl)
        end)
        local v6 = script.Parent.effect.dasheffect:Clone()
        if p5:FindFirstChild("BusoMelee") then
            v6:Destroy()
            v6 = script.Parent.effect.dasheffectBuso:Clone()
            require(script.Parent.BusoColor):applyColors(u3.Parent, v6)
        end
        v6:PivotTo(u3.CFrame)
        v6.Parent = workspace.Effects
        u2(v6, p4, p5)
    end
end
return v1