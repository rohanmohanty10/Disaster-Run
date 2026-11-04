 

 

return {
    { 0, function(p1, p2, p3, p4, p5) -- Line: 3
            for _, descendant in ipairs(p2.Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1, function(p6, p7, p8, p9, p10) -- Line: 13
            for _, descendant in ipairs(p8.Eyes:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 50, function(p11, p12, p13, p14, p15) -- Line: 24
            for _, descendant in ipairs(p12.Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 57, function(p16, p17, p18, p19, p20) -- Line: 34
            for _, descendant in ipairs(p17.Lines2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 61, function(p21, p22, p23, p24, p25) -- Line: 44
            for _, descendant in ipairs(p23.Eyes:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant:Clear();
                end;
            end;
        end },
    { 62, function(p26, p27, p28, p29, p30) -- Line: 55
            for _, descendant in ipairs(p26.Smoke1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 65, function(p31, p32, p33, p34, p35) -- Line: 65
            for _, descendant in ipairs(p31.Dash:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 67, function(p36, p37, p38, p39, p40) -- Line: 75
            for _, descendant in ipairs(p40.Skid:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 75, function(p41, p42, p43, p44, p45) -- Line: 85
            for _, descendant in ipairs(p41.Smoke2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 80, function(p46, p47, p48, p49, p50) -- Line: 95
            for _, descendant in ipairs(p50.Skid:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 96, function(p51, p52, p53, p54, p55) -- Line: 105
            for _, descendant in ipairs(p51.Dash2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 100, function(p56, p57, p58, p59, p60) -- Line: 115
            for _, descendant in ipairs(p57.Lines2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 101, function(p61, p62, p63, p64, p65) -- Line: 125
            for _, descendant in ipairs(p61.Smoke3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 108, function(p66, p67, p68, p69, p70) -- Line: 135
            for _, descendant in ipairs(p66.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 192, function(p71, p72, p73, p74, p75) -- Line: 145
            for _, descendant in ipairs(p71.Smoke4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 195, function(p76, p77, p78, p79, p80) -- Line: 155
            for _, descendant in ipairs(p79:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 204, function(p81, p82, p83, p84, p85) -- Line: 165
            for _, descendant in ipairs(p81.Smoke5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 210, function(p86, p87, p88, p89, p90) -- Line: 175
            for _, descendant in ipairs(p86.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 255, function(p91, p92, p93, p94, p95) -- Line: 185
            for _, descendant in ipairs(p91.BallWind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 281, function(p96, p97, p98, p99, p100) -- Line: 195
            for _, descendant in ipairs(p99:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 282, function(p101, p102, p103, p104, p105) -- Line: 205
            for _, descendant in ipairs(p101.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 290, function(p106, p107, p108, p109, p110) -- Line: 215
            for _, descendant in ipairs(p106.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end }
};