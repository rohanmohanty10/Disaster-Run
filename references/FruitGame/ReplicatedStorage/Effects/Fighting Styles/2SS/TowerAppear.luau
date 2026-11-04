 

local v1 = {}
local u2 = require(script.slash)
function v1.start(_, p3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        local v4 = script.Parent.effect.appeareffect:Clone()
        v4:PivotTo(p3.CFrame)
        v4.root.WC.Part1 = p3
        require(script.Parent.BusoColor):applyColors(p3.Parent, v4)
        v4.Parent = workspace
        v4.root.WC.Enabled = true
        u2(v4)
    end
end
return v1