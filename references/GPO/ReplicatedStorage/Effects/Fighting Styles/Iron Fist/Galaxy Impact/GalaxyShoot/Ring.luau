 

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
    v4.Scale = p2.Scale or 1
    v4.HalfHeight = v4.Target.Size.Y
    v4.StartingPoint = v4.Target.Position + Vector3.new(0, 1, 0) * v4.HalfHeight
    v4.EndingPoint = v4.Target.Position + Vector3.new(0, 1, 0) * -v4.HalfHeight
    v4.CFrameOffset = p2.CFrameOffset or CFrame.new()
    v4.Ring = script.Ring:Clone()
    return v4
end
function u1.start(u5) --[[ Line: 39 ]]
    local u6 = u5.Alpha
    local u7 = u5.GoalAlpha
    local u8 = u5.Duration
    local _ = u8 / u5.Frames
    local u9 = u5.Ring
    u9.Position = u5.StartingPoint:Lerp(u5.EndingPoint, u6)
    u9.CFrame = u9.CFrame * u5.CFrameOffset
    u9.Parent = workspace.Effects
    local u10 = u6
    for _, v11 in u9:GetDescendants() do
        if v11:IsA("Beam") then
            v11.Color = ColorSequence.new(u5.Color)
        end
    end
    task.spawn(function() --[[ Line: 59 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u8
            [3] = u9
            [4] = u5
            [5] = u10
            [6] = u7
        --]]
        while u6 <= 1 do
            u6 = u6 + task.wait() / u8
            if not u9.Parent then
                return
            end
            local v12 = u5.Target.Size.X * u5.Scale
            u5.StartingPoint = u5.Target.Position + Vector3.new(0, 1, 0) * v12
            u5.EndingPoint = u5.Target.Position + Vector3.new(0, 1, 0) * -v12
            local v13 = u10
            local v14 = u6
            local v15 = v13 + (u7 - v13) * v14
            u9.Position = u5.StartingPoint:Lerp(u5.EndingPoint, v15)
            local v16 = u9.Ring1
            local v17 = math.min(v15, 1)
            local v18 = v12 ^ 2 - (v17 * v12 * 2 - v12) ^ 2
            local v19 = math.sqrt(v18)
            local v20 = v19 * 4 / 3
            local v21 = { v16.Attachment1, v16.Attachment2 }
            local v22 = 15 * (1 - u6)
            for _, v23 in v21 do
                v23.bf1.Width0 = v22
                v23.bf1.Width1 = v22
                v23.bf2.Width0 = v22
                v23.bf2.Width1 = v22
                v23["1"].Position = Vector3.new(0, 1, 0) * v19
                v23["2"].Position = Vector3.new(0, 1, 0) * -v19
                v23.bf1.CurveSize1 = v20
                v23.bf2.CurveSize1 = -v20
                v23.bf1.CurveSize0 = -v20
                v23.bf2.CurveSize0 = v20
            end
        end
    end)
end
return u1