 

 

return {
    { 0, function(p1, p2, p3, p4, p5, p6) -- Line: 3
            for _, descendant in ipairs(p3.Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1, function(p7, p8, p9, p10, p11, p12) -- Line: 13
            for _, descendant in ipairs(p12.Run:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 61, function(p13, p14, p15, p16, p17, p18) -- Line: 23
            for _, descendant in ipairs(p14.Lines2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 63, function(p19, p20, p21, p22, p23, p24) -- Line: 33
            for _, descendant in ipairs(p21.Middle:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 69, function(p25, p26, p27, p28, p29, p30) -- Line: 43
            for _, descendant in ipairs(p27.Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant:Clear();
                end;
            end;
        end },
    { 71, function(p31, p32, p33, p34, p35, p36) -- Line: 54
            for _, descendant in ipairs(p32.IndicatorCharge:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 80, function(p37, p38, p39, p40, p41, p42) -- Line: 64
            for _, descendant in ipairs(p42.Run:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 92, function(p43, p44, p45, p46, p47, p48) -- Line: 74
            for _, descendant in ipairs(p44.Indicator:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 116, function(p49, p50, p51, p52, p53, p54) -- Line: 84
            for _, descendant in ipairs(p50.Lines2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 124, function(p55, p56, p57, p58, p59, p60) -- Line: 94
            for _, descendant in ipairs(p56.Indicator:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Clear();
                end;
            end;
        end },
    { 130, function(p61, p62, p63, p64, p65, p66) -- Line: 104
            for _, descendant in ipairs(p63.TBLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 139, function(p67, p68, p69, p70, p71, p72) -- Line: 114
            for _, descendant in ipairs(p70.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 339, function(p73, p74, p75, p76, p77, p78) -- Line: 124
            for _, descendant in ipairs(p75.TBLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 344, function(p79, p80, p81, p82, p83, p84) -- Line: 134
            for _, descendant in ipairs(p80.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 345, function(p85, p86, p87, p88, p89, p90) -- Line: 144
            for _, descendant in ipairs(p87.Lines3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 395, function(p91, p92, p93, p94, p95, p96) -- Line: 154
            for _, descendant in ipairs(p93.TBLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 397, function(p97, p98, p99, p100, p101, p102) -- Line: 164
            for _, descendant in ipairs(p99.Lines3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant:Clear();
                end;
            end;
        end },
    { 414, function(p103, p104, p105, p106, p107, p108) -- Line: 175
            for _, descendant in ipairs(p106.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 421, function(p109, p110, p111, p112, p113, p114) -- Line: 185
            for _, descendant in ipairs(p112.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 504, function(p115, p116, p117, p118, p119, p120) -- Line: 195
            for _, descendant in ipairs(p119.Cool:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 505, function(p121, p122, p123, p124, p125, p126) -- Line: 205
            for _, descendant in ipairs(p123.galaxy:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 506, function(p127, p128, p129, p130, p131, p132) -- Line: 215
            for _, descendant in ipairs(p127:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 632, function(p133, p134, p135, p136, p137, p138) -- Line: 225
            for _, descendant in ipairs(p133:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 633, function(p139, p140, p141, p142, p143, p144) -- Line: 235
            for _, descendant in ipairs(p143.Cool:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant:Clear();
                end;
            end;
        end },
    { 634, function(p145, p146, p147, p148, p149, p150) -- Line: 246
            for _, descendant in ipairs(p147.galaxy:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Clear();
                end;
            end;
        end },
    { 641, function(p151, p152, p153, p154, p155, p156) -- Line: 256
            for _, descendant in ipairs(p153.TBLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 646, function(p157, p158, p159, p160, p161, p162) -- Line: 266
            for _, descendant in ipairs(p160.Five:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end }
};