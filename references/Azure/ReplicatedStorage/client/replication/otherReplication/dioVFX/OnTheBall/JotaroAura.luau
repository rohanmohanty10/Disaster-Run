 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            for _, descendant in ipairs(p3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 949, function(p4, p5, p6) -- Line: 14
            for _, descendant in ipairs(p6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1214, function(p7, p8, p9) -- Line: 25
            for _, descendant in ipairs(p9:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};