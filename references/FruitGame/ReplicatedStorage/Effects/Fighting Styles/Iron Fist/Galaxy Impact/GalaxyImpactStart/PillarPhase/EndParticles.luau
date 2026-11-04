 

local u1 = game:GetService("TweenService")
local u2 = Random.new()
local u3 = {}
u3.__index = u3
function u3.new(p4) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v5 = u3
    local v6 = setmetatable({}, v5)
    v6.Shrink = p4.Shrink
    v6.Color = p4.Color
    v6.TrailLifeTime = p4.TrailLifeTime or 3
    v6.Duration = p4.Duration or 5
    v6.Position = p4.Position
    v6.YGoal = p4.YGoal or 0
    v6.Revolutions = p4.Revolutions or u2:NextNumber(2, 2.5)
    v6.GoalRadius = p4.GoalRadius
    v6.StartRadius = p4.StartRadius
    v6.Size = p4.Size
    v6.Angle = math.random() * 2 * 3.141592653589793
    v6.LastLightningPart = nil
    v6.Model = p4.Model
    v6.CurrentLightningAmount = 1
    v6.LightningAmount = 100
    v6:_main()
    return v6
end
function u3._lerp(_, p7, p8, p9) --[[ Line: 35 ]]
    return p7 + (p8 - p7) * p9
end
function u3._createTrail(p10, p11) --[[ Line: 39 ]]
    local v12 = script.Part:Clone()
    v12.Top.Position = Vector3.new(0, 1, 0) * p11 / 2
    v12.Bot.Position = -v12.Top.Position
    v12.Trail.Lifetime = p10.TrailLifeTime
    v12.Trail.Color = ColorSequence.new(p10.Color)
    return v12
end
function u3._createLightningPart(p13) --[[ Line: 49 ]]
    local v14 = script.boltPart:Clone()
    v14.Color = p13.Color
    return v14
end
function u3._addLightingPart(p15, p16) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v17 = u2:NextUnitVector() * 1.5
    local v18 = p15.LastLightningPart
    p15.CurrentLightningAmount = p15.CurrentLightningAmount + 1
    local v19
    if v18 then
        local v20 = v18.CFrame * CFrame.new(0, 0, -v18.Size.Z / 2).Position
        local v21 = p16 + v17
        local v22 = (v20 - v21).Magnitude
        local v23 = p15.Size / 20 * (p15.Shrink and (1 - p15.CurrentLightningAmount / p15.LightningAmount or 1) or 1)
        v19 = p15:_createLightningPart()
        v19.CFrame = CFrame.new(v20, v21) * CFrame.new(0, 0, -v22 / 2)
        v19.Size = Vector3.new(v23, v23, v22)
    else
        v19 = p15:_createLightningPart()
        v19.Position = p16 + v17
    end
    local v24 = p15.Duration / p15.LightningAmount * 6 + 0.25
    u1:Create(v19, TweenInfo.new(v24, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Size"] = v19.Size * Vector3.new(0, 0, 1)
    }):Play()
    _G.destroy(v19, v24)
    v19.Parent = p15.Model
    p15.LastLightningPart = v19
end
function u3._main(u25) --[[ Line: 97 ]]
    local u26 = u25.StartRadius
    local u27 = u25.GoalRadius
    local _ = math.random(2) == 1
    task.spawn(function() --[[ Line: 106 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u26
            [3] = u27
        --]]
        local v28 = 1 / u25.LightningAmount
        local v29 = v28
        local v30 = 0
        while v30 <= 1 do
            v30 = v30 + task.wait() / u25.Duration
            local v31 = u25:_lerp(u26, u27, v30)
            local v32 = u25:_lerp(0, u25.YGoal, v30)
            local v33 = CFrame.new(u25.Position) * CFrame.Angles(0, u25.Angle + u25.Revolutions * 3.141592653589793 * v30, 0) * CFrame.new(0, v32, v31)
            if v28 <= v30 then
                v28 = v28 + v29
                u25:_addLightingPart(v33.Position)
            end
        end
        task.wait(1)
        u25:Destroy()
    end)
end
function u3.Destroy(p34) --[[ Line: 148 ]]
    setmetatable(p34, nil)
end
return u3