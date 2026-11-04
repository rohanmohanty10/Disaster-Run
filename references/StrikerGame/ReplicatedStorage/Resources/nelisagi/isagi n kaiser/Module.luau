 
 

return {
    { 36, function(p1, p2, p3, p4) -- Line: 3
            if p4 then
                for _, descendant in pairs(p4.ScreenEffs:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end },
    { 42, function(p5, p6, p7, p8) -- Line: 14
            if p8 then
                for _, descendant in pairs(p8.PuzzleTransition:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end;
        end },
    { 48, function(p9, p10, p11, p12) -- Line: 25
            if p12 then
                for _, descendant in pairs(p12.PuzzleTransition:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end;
        end },
    { 54, function(p13, p14, p15, p16) -- Line: 36
            if p16 then
                for _, descendant in pairs(p16.PuzzleTransition:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end;
        end },
    { 168, function(p17, p18, p19, p20) -- Line: 47
            for _, descendant in pairs(p18.HumanoidRootPart.CutsceneVFX.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 264, function(p21, p22, p23, p24) -- Line: 56
            if p24 then
                for _, descendant in pairs(p24.SecondEff:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 273, function(p25, p26, p27, p28) -- Line: 67
            for _, descendant in pairs(p26.HumanoidRootPart.CutsceneVFX.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p25.Head.PredatorEyeVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p25.Head.PredatorEyeVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            if p28 then
                for _, descendant in pairs(p28.ScreenEffs:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 333, function(p29, p30, p31, p32) -- Line: 93
            if p32 then
                for _, descendant in pairs(p32.SecondEff:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            for _, descendant in pairs(p30.HumanoidRootPart.CutsceneVFX.Five:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 366, function(p33, p34, p35, p36) -- Line: 109
            for _, descendant in pairs(p34.HumanoidRootPart.CutsceneVFX.Five:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 421, function(p37, p38, p39, p40) -- Line: 118
            for _, descendant in ipairs(p38.HumanoidRootPart.CutsceneVFX.Five:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 480, function(p41, p42, p43, p44) -- Line: 128
            if p44 then
                for _, descendant in pairs(p44.ScreenEffs:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end },
    { 507, function(p45, p46, p47, p48) -- Line: 139
            if p48 then
                for _, descendant in pairs(p48.ScreenEffs:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 561, function(p49, p50, p51, p52) -- Line: 150
            if p52 then
                for _, descendant in pairs(p52.FirstEff:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;
                end;

                for _, descendant in pairs(p52.ScreenEffs:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            for _, descendant in pairs(p50.HumanoidRootPart.CutsceneVFX.Seven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p50.HumanoidRootPart.CutsceneVFX.Seven:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 635, function(p53, p54, p55, p56) -- Line: 176
            if p56 then
                for _, descendant in pairs(p56.PuzzleTransition:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end;
        end },
    { 642, function(p57, p58, p59, p60) -- Line: 187
            for _, descendant in pairs(p57.Head.PredatorEyeVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            if p60 then
                for _, descendant in pairs(p60.FirstEff:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            for _, descendant in pairs(p58.HumanoidRootPart.CutsceneVFX.Seven:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 648, function(p61, p62, p63, p64) -- Line: 208
            for _, descendant in pairs(p62.HumanoidRootPart.CutsceneVFX.Eight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end }
};