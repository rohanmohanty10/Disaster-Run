 

local v1 = game:GetService("RunService")
local u2 = game.ReplicatedStorage.Refrences.Fishman
local u3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Tween)
local u4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Spring)
local u5 = workspace:WaitForChild("Effects")
local u6 = workspace.CurrentCamera
local u7 = {}
v1:BindToRenderStep(script.Parent.Name .. "-" .. script.Name, Enum.RenderPriority.Last.Value - 1000, function(p8) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u3
    --]]
    local v9 = tick()
    local _ = u6.CFrame.LookVector
    local v10 = 0
    for v11, u13 in next, u7 do
        if v10 > 0 then
            local u13 = u7[v11 - v10]
        end
        local v14 = v9 - u13.Start
        if u13.FadeIn + u13.FadeOut + u13.Lifetime < v14 then
            spawn(function() --[[ Line: 22 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13:Destroy()
            end)
            table.remove(u7, v11 - v10)
            v10 = v10 + 1
        else
            local v15 = 1
            local v16
            if u13.FadeIn + u13.Lifetime < v14 then
                local v17 = (v14 - u13.FadeIn - u13.Lifetime) / u13.FadeOut
                u3.ease["in"].sine(v17, 1, -1, 1)
                local v18 = u3.ease.inout.quad(v17, 0, 1, 1)
                v16 = u3.point(u13.Transparency, 1, v18)
                v15 = 1
            elseif u13.FadeIn < v14 then
                local _ = (v14 - u13.FadeIn) / u13.Lifetime
                v16 = u13.Transparency
            else
                local v19 = v14 / u13.FadeIn
                v15 = u3.ease.out.quad(v19, 0, 1, 1)
                v16 = u3.point(1, u13.Transparency, v15)
            end
            local v20 = u13.CFrame.p - u13.Reference.CFrame.p
            local v21 = v20.Magnitude > 0.01 and v20 and v20 or Vector3.new()
            local v22 = u13.Spring
            local v23 = math.cos(v9)
            local v24 = math.sin(v9)
            v22:SetGoal(v21 + Vector3.new(v23, v24) * u13.Scale.Magnitude / 2)
            u13.Spring2:SetGoal(u13.Scale.X * v15)
            local v25 = u13.Spring:GetPosition()
            local v26 = u13.Spring2:GetPosition()
            local v27 = v25.Magnitude * 0.41421356237309503 * 2
            u13.Reference.Beam.CurveSize0 = v27
            u13.Reference.Beam.CurveSize1 = -v27
            u13.Reference.Beam.Width0 = v26
            u13.Reference.Attachment.Position = Vector3.new(0, 1, 0) * u13.Scale.Y * v15 + v25
            u13.Reference.Beam.Transparency = NumberSequence.new(v16)
            u13.Spring:Update(p8)
            u13.Spring2:Update(p8)
            u13.CFrame = u13.CFrame:Lerp(u13.Reference.CFrame, p8 * 12)
        end
    end
end)
local u34 = {
    ["new"] = function(p28) --[[ Name: new, Line 77 ]]
        --[[
        Upvalues:
            [1] = u34
        --]]
        local v29 = {
            ["CFrame"] = p28.CFrame or CFrame.new(),
            ["Scale"] = p28.Scale or Vector2.new(1, 2),
            ["FadeIn"] = p28.FadeIn or 0.5,
            ["Lifetime"] = p28.Lifetime or 2,
            ["FadeOut"] = p28.FadeOut or 0.5,
            ["Transparency"] = p28.Transparency or 0.5
        }
        local v30 = {
            ["__index"] = u34
        }
        return setmetatable(v29, v30):__init()
    end,
    ["__init"] = function(p31) --[[ Name: __init, Line 88 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u5
            [4] = u7
        --]]
        if p31.Reference then
            return p31
        end
        p31.Spring = u4.new(0.25, 2, (Vector3.new()))
        p31.Spring2 = u4.new(0.25, 2, 0)
        p31.Reference = u2.Assets.Strand:Clone()
        p31.Reference.Attachment.Position = Vector3.new()
        p31.Reference.Beam.Width0 = 0
        p31.Reference.Beam.Transparency = NumberSequence.new(1)
        p31.Reference.CFrame = p31.CFrame
        p31.Reference.Parent = u5
        p31.Reference.Beam.Enabled = true
        p31.Start = tick()
        local v32 = u7
        table.insert(v32, p31)
        return p31
    end,
    ["Destroy"] = function(p33) --[[ Name: Destroy, Line 112 ]]
        p33.Reference:Destroy()
    end
}
return u34