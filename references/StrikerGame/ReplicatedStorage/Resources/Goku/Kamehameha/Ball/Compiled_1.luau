 
 

return {
    { 81, function(p1) -- Line: 3
            for _, descendant in pairs(p1.R6.Torso.Aura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p1.cancer:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 83, function(p2) -- Line: 19
            for _, descendant in pairs(p2.R6.scriptingproblemfix:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 183, function(p3) -- Line: 29
            for _, descendant in pairs(p3.step1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 200, function(p4) -- Line: 39
            for _, descendant in pairs(p4.spin:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 260, function(p5) -- Line: 49
            for _, descendant in pairs(p5.kame:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p5.R6.scriptingproblemfix:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p5.big2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 340, function(p6) -- Line: 71
            for _, descendant in pairs(p6.kame:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p6.big2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};