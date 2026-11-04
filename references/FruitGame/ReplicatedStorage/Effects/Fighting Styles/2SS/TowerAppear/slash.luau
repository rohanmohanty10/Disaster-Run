 

game:GetService("TweenService")
TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local _ = game:GetService("RunService").Heartbeat
local _ = Vector3.new
local _ = CFrame.new;
({}).Transparency = 1
CFrame.Angles(0, 0.9, 0)
CFrame.Angles(0, 3.0473448739820994, 0)
Random.new()
return function(p1) --[[ Line: 11 ]]
    p1.root.Attachment.Sparkles:Emit(1)
    p1.root.Attachment.Waves:Emit(6)
    _G.destroy(p1, 1)
end