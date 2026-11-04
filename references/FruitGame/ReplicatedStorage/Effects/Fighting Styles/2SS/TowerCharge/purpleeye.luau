 

game:GetService("TweenService")
local _ = Vector3.new
local _ = CFrame.new
return function(p1) --[[ Line: 7 ]]
    p1.ballcenter.Sparkles:Emit(1)
    _G.destroy(p1, 0.6)
end