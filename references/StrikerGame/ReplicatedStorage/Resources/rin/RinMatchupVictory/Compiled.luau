 
 

return {
    { 13, function(p1) -- Line: 3
            for _, descendant in pairs(p1.rininterceptimpact:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p1.rininterceptimpact:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.5;
                end;
            end;
        end },
    { 14, function(p2) -- Line: 19
            for _, descendant in pairs(p2.rininterceptbeamangle1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 26, function(p3) -- Line: 28
            for _, descendant in pairs(p3.rininterceptimpact:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.05;
                end;
            end;
        end },
    { 60, function(p4) -- Line: 38
            for _, descendant in pairs(p4.rininterceptbeamangle2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 80, function(p5) -- Line: 47
            for _, descendant in pairs(p5.rininterceptsweatdrops2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p5.rin:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 81, function(p6) -- Line: 63
            for _, descendant in pairs(p6.rininterceptbeamangle1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p6.rininterceptimpact:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end },
    { 82, function(p7) -- Line: 78
            for _, descendant in pairs(p7.rininterceptimpact2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p7.rininterceptimpact2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end },
    { 84, function(p8) -- Line: 94
            for _, descendant in pairs(p8.rininterceptimpact2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.015;
                end;
            end;
        end },
    { 253, function(p9) -- Line: 104
            for _, descendant in pairs(p9.rininterceptsweatdrops2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.1;
                end;
            end;

            for _, descendant in pairs(p9.rin:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p9.rin:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.1;
                end;
            end;
        end },
    { 260, function(p10) -- Line: 126
            for _, descendant in pairs(p10.rininterceptbeamangle2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p10.rininterceptbeamangle3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 265, function(p11) -- Line: 140
            for _, descendant in pairs(p11.rininterceptimpact2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end },
    { 459, function(p12) -- Line: 150
            for _, descendant in pairs(p12.rininterceptbeamangle3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 576, function(p13) -- Line: 159
            for _, descendant in pairs(p13.rininterceptsweatdrops2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;

            for _, descendant in pairs(p13.rininterceptsweatdrops2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};