 

local u1 = game:GetService("TweenService")
return function(p2, p3, p4) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for _, v5 in p2:GetDescendants() do
        if v5:IsA("ParticleEmitter") then
            v5:SetAttribute("TimeScale", v5.TimeScale)
            u1:Create(v5, p3, {
                ["TimeScale"] = p4
            }):Play()
        end
    end
end