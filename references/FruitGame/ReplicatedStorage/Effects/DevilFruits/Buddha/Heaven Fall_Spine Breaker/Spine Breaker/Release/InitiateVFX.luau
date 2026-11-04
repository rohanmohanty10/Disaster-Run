 

local _ = _G.Ess.Tween
local u1 = _G.Emit
local u2 = require(script.CreateImpactFrames)
return {
    ["Explode"] = function(p3, p4, p5) --[[ Name: Explode, Line 8 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if _G.checkRenderDistance(p3.PrimaryPart.Position) == false then
            return
        else
            local v6 = p5.Light:Clone()
            local v7 = v6.BigAwaken
            v6:ScaleTo(p4)
            v6:PivotTo(CFrame.new(p3:GetPivot().Position))
            v6.Parent = workspace.Effects
            u1(v6:GetDescendants(), true)
            u2.Self()
            local v8 = _G.Ess.CreateHitbox(v7.CFrame, Vector3.new(90, 90, 90) * p4, { workspace.Islands.Dummy })
            if v8 then
                for _, v9 in v8 do
                    if not v9:HasTag("Buffed") then
                        v9:AddTag("Buffed")
                        local v10 = p5.Buff:Clone()
                        v10:PivotTo(v9:GetPivot())
                        v10.WeldConstraint.Part1 = v9.PrimaryPart
                        v10.Parent = workspace.Effects
                        u1(v10:GetDescendants(), false, 2.5)
                        task.delay(2.5, v9.RemoveTag, v9, "Buffed")
                        task.delay(3.06, v10.Destroy, v10)
                    end
                end
            end
        end
    end
}