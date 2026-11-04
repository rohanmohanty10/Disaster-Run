 

 

return {
    { 0, function(p1, p2) -- Line: 3
            for _, descendant in pairs(p2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p1.vfx.cam.zurr:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 25, function(p3) -- Line: 18
            for _, descendant in pairs(p3.vfx.cam.zurr:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 39, function(p4) -- Line: 28
            shared.vfx.emit(p4.Splash);
            shared.vfx.emit(p4.glassemitter);
        end },
    { 162, function(p5) -- Line: 34
            for _, descendant in pairs(p5.vfx.cam.lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 172, function(p6) -- Line: 44
            for _, descendant in pairs(p6.vfx.swordrop:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 447, function(p7) -- Line: 54
            for _, descendant in pairs(p7.vfx.glasses:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 498, function(p8) -- Line: 64
            for _, descendant in pairs(p8.vfx.cam.base:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 567, function(p9) -- Line: 74
            for _, descendant in pairs(p9.vfx.Part:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 699, function(p10) -- Line: 84
            for _, descendant in pairs(p10.vfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};