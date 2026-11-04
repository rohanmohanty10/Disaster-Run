 

local u1 = _G.Ess.Tween
local u2 = _G.Emit
require(script.GroundSideRocks)
return {
    ["Light"] = function(p3, p4, p5) --[[ Name: Light, Line 8 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v6 = p5.Light:Clone()
        v6:ScaleTo(p4 * 1.5)
        v6:PivotTo(p3)
        v6.Parent = workspace.Effects
        u2(v6.Glow.Aura, false)
        return v6
    end,
    ["End"] = function(p7, _, p8) --[[ Name: End, Line 21 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        task.delay(p8 - 0.15, u2, p7.Glow.Aura:GetDescendants(), false)
        u2(p7.Glow.BuildUp, false, p8 / 1.125)
        u2(p7.Glow, false)
        u1(p7.Glow.PointLight, TweenInfo.new(p8 - 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ["Brightness"] = 0,
            ["Range"] = 50
        })
        for _, v9 in p7.Glow.BuildUp:GetChildren() do
            local v10 = p8 / 2 + 0.15
            v9.Rate = 1 / p8 * v9.Rate * 1.5
            v9.Lifetime = NumberRange.new(v9.Lifetime.Min * v10, v9.Lifetime.Max * v10)
            if not v9:GetAttribute("Ignore") then
                v9:Emit(2)
            end
        end
        for _, v11 in p7.Glow.BuildUp:GetChildren() do
            if not v11:GetAttribute("Ignore") then
                local v12 = {}
                for _, v13 in v11.Size.Keypoints do
                    local v14 = NumberSequenceKeypoint.new(v13.Time, v13.Value * 2, v13.Envelope)
                    v12[#v12 + 1] = v14
                end
                local v15 = {
                    ["Size"] = NumberSequence.new(v12)
                }
                _G.tween(v11, { p8, Enum.EasingStyle.Cubic, Enum.EasingDirection.In }, v15)
            end
        end
    end
}