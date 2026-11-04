 
 

return function(p1) -- Line: 1
    if p1:IsA("ParticleEmitter") or (p1:IsA("Trail") or p1:IsA("Beam")) then
        p1.Enabled = true;
    end;

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
            descendant.Enabled = true;
        end;
    end;
end;