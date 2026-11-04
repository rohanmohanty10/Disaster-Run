 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            for _, descendant in ipairs(p3.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 74, function(p4, p5, p6) -- Line: 13
            for _, descendant in ipairs(p6.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 118, function(p7, p8, p9) -- Line: 23
            for _, descendant in ipairs(p9.One2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 175, function(p10, p11, p12) -- Line: 33
            for _, descendant in ipairs(p12.One2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 188, function(p13, p14, p15) -- Line: 43
            for _, descendant in ipairs(p14.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 405, function(p16, p17, p18) -- Line: 53
            for _, descendant in ipairs(p18.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 444, function(p19, p20, p21) -- Line: 63
            for _, descendant in ipairs(p20.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 485, function(p22, p23, p24) -- Line: 73
            for _, descendant in ipairs(p23.Run:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 668, function(p25, p26, p27) -- Line: 83
            if p25 then
                for _, descendant in ipairs(p25.Lines:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 754, function(p28, p29, p30) -- Line: 95
            if p28 then
                for _, descendant in ipairs(p28.Lines:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end },
    { 764, function(p31, p32, p33) -- Line: 107
            for _, descendant in ipairs(p32.Five:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end }
};