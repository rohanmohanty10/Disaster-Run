 

local u1 = script.Parent.UIGradient
local u2 = game:GetService("TweenService"):Create(u1, TweenInfo.new(2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
    ["Offset"] = Vector2.new(1.25, 0)
})
local u3 = Vector2.new(-1.25, 0)
u1.Offset = u3
local function u4() --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
        [4] = u4
    --]]
    u2:Play()
    u2.Completed:Wait()
    u1.Offset = u3
    u2:Play()
    u2.Completed:Wait()
    u1.Offset = u3
    task.wait(0)
    u4()
end
u4()