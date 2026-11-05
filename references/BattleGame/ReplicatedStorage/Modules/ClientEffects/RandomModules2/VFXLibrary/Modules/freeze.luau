 

local l__TweenService__1 = game:GetService("TweenService");
return function(p1, p2, p3) --[[ Line: 3 ]]
    -- upvalues: l__TweenService__1 (copy)
    for _, v4 in p1:GetDescendants() do
        if v4:IsA("ParticleEmitter") then
            v4:SetAttribute("TimeScale", v4.TimeScale);
            l__TweenService__1:Create(v4, p2, {
                TimeScale = p3
            }):Play();
        end;
    end;
end;