 

local _ = _G.Ess.Tween
local u1 = _G.Emit
require(script.CreateImpactFrames)
return {
    ["Explode"] = function(p2, p3, p4) --[[ Name: Explode, Line 8 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
            local v5 = p4.Light:Clone()
            local _ = v5.BigAwaken
            v5:ScaleTo(p3)
            v5:PivotTo(CFrame.new(p2:GetPivot().Position))
            v5.Parent = workspace.Effects
            u1(v5:GetDescendants(), true)
        end
    end
}