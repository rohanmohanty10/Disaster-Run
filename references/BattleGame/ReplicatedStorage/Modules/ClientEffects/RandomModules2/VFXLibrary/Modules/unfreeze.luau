 
-- Decompiled with Potassium's decompiler.

return function(p1) --[[ Line: 1 ]]
    for _, v2 in p1:GetDescendants() do
        if v2:IsA("ParticleEmitter") then
            v2.TimeScale = v2:GetAttribute("TimeScale") or 1;
        end;
    end;
end;