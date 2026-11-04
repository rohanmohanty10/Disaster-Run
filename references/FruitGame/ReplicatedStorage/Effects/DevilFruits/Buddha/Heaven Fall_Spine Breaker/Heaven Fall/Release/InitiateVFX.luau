 

local _ = _G.Ess.Tween
local u1 = _G.Emit
require(script.CreateImpactFrames)
return {
    ["Grab"] = function(_, p2, p3) --[[ Name: Grab, Line 8 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v4 = p3.Grab:Clone()
        v4:PivotTo(p2:GetPivot())
        v4.Parent = workspace.Effects
        u1(v4:GetDescendants(), true)
        task.delay(2, v4.Destroy, v4)
    end,
    ["HandCrush"] = function(_, p5, p6) --[[ Name: HandCrush, Line 19 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v7 = p6.HandCrush:Clone()
        v7:PivotTo(p5:GetPivot())
        v7.Parent = workspace.Effects
        u1(v7:GetDescendants(), true)
        task.delay(2, v7.Destroy, v7)
    end,
    ["FullSlam"] = function(_, p8, p9) --[[ Name: FullSlam, Line 29 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v10 = p9.Slam:Clone()
        v10:PivotTo(p8:GetPivot())
        v10.Parent = workspace.Effects
        u1(v10:GetDescendants(), true)
        task.delay(2, v10.Destroy, v10)
    end
}