 

 

return {
    { 0, function(p1, p2) -- Line: 3
            for _, descendant in ipairs(p2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 960, function(p3, p4) -- Line: 14
            for _, descendant in ipairs(p4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1214, function(p5, p6) -- Line: 25
            for _, descendant in ipairs(p6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};