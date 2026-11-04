 

game:GetService("StarterPlayer")
local _ = script.Parent
return function(p1, p2, p3) --[[ Line: 6 ]]
    local v4 = p3 == nil and 1 or p3
    local v5 = Instance.new("Model")
    local v6
    if p2 == true then
        v6 = script.FireHahabaSwing:Clone()
    else
        v6 = script.HahabaSwing:Clone()
    end
    v6.CFrame = p1
    v6.Parent = v5
    v5:ScaleTo(v4)
    v5.Parent = workspace.Effects
    _G.customEmit(v5)
    _G.destroy(v5, 3)
end