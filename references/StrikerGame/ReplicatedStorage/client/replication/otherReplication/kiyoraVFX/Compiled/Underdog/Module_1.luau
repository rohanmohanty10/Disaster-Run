 
 

return {
    { 5, function(p1, p2, p3) -- Line: 3
            for _, descendant in pairs(p2.kiyorapass:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p3.CamPart.CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p1.Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 40, function(p4, p5, p6) -- Line: 27
            for _, descendant in pairs(p6.CamPart.CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p4.Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p6.CamPart.Wind1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 130, function(p7, p8, p9) -- Line: 51
            for _, descendant in pairs(p9.CamPart.Wind1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 135, function(p10, p11, p12) -- Line: 61
            shared.vfx.emit(p11.isagitagshotvfx);
        end }
};