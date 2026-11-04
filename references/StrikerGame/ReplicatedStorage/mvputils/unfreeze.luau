 

 

return function(p1) -- Line: 1
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.TimeScale = descendant:GetAttribute("TimeScale") or 1;
        end;
    end;
end;