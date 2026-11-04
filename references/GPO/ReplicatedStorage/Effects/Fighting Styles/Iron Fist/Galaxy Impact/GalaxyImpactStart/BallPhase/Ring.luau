 

game:GetService("TweenService")
local _ = Enum.EasingStyle.Sine
local _ = Enum.EasingDirection.Out
local u1 = {}
u1.__index = u1
function u1.new(p2) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = u1
    local v4 = setmetatable({}, v3)
    v4.Color = p2.Color
    v4.Alpha = p2.Alpha or 0
    v4.Target = p2.Target
    v4.Duration = p2.Duration or 4
    v4.GoalAlpha = p2.GoalAlpha or 1
    v4.Frames = 50
    v4.TweenInfo = TweenInfo.new(v4.Duration / v4.Frames, Enum.EasingStyle.Linear)
    v4.HalfHeight = v4.Target.Size.Y
    v4.StartingPoint = v4.Target.Position + Vector3.new(0, 1, 0) * v4.HalfHeight
    v4.EndingPoint = v4.Target.Position + Vector3.new(0, 1, 0) * -v4.HalfHeight
    v4.Ring = script.Ring:Clone()
    return v4
end
function u1.start(u5) --[[ Line: 39 ]]
    local u6 = u5.Alpha
    local u7 = u5.GoalAlpha
    local u8 = u5.Duration
    local u9 = u5.Frames
    local u10 = u8 / u9
    local u11 = u5.Ring
    u11.Position = u5.StartingPoint:Lerp(u5.EndingPoint, u6)
    u11.Parent = workspace.Effects
    local u12 = u6
    for _, v13 in u11:GetDescendants() do
        if v13:IsA("Beam") then
            v13.Color = ColorSequence.new(u5.Color)
        end
    end
    task.spawn(function() --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u11
            [3] = u5
            [4] = u6
            [5] = u10
            [6] = u8
            [7] = u12
            [8] = u7
        --]]
        for v14 = 1, u9 do
            if not u11.Parent then
                return
            end
            local v15 = u5.Target.Size.X
            u5.StartingPoint = u5.Target.Position + Vector3.new(0, 1, 0) * v15
            u5.EndingPoint = u5.Target.Position + Vector3.new(0, 1, 0) * -v15
            u6 = u10 * v14 / u8
            local v16 = u12
            local v17 = u6
            local v18 = v16 + (u7 - v16) * v17
            u11.Position = u5.StartingPoint:Lerp(u5.EndingPoint, v18)
            local v19 = u11.Ring1
            local v20 = math.min(v18, 1)
            local v21 = v15 ^ 2 - (v20 * v15 * 2 - v15) ^ 2
            local v22 = math.sqrt(v21)
            local v23 = v22 * 4 / 3
            local v24 = { v19.Attachment1, v19.Attachment2 }
            local v25 = 25 * (1 - u6)
            for _, v26 in v24 do
                v26.bf1.Width0 = v25
                v26.bf1.Width1 = v25
                v26.bf2.Width0 = v25
                v26.bf2.Width1 = v25
                v26["1"].Position = Vector3.new(0, 1, 0) * v22
                v26["2"].Position = Vector3.new(0, 1, 0) * -v22
                v26.bf1.CurveSize1 = v23
                v26.bf2.CurveSize1 = -v23
                v26.bf1.CurveSize0 = -v23
                v26.bf2.CurveSize0 = v23
            end
            task.wait(u10)
        end
    end)
end
return u1