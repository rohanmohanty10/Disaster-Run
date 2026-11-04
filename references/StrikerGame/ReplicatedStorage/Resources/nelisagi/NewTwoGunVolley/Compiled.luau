 
 

return {
    { 0, function(p1, p2, p3, p4, p5) -- Line: 3
            for _, descendant in pairs(p3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 6, function(p6, p7, p8, p9, p10) -- Line: 30
            for _, descendant in pairs(p10.HumanoidRootPart.CutsceneVFX.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 54, function(p11, p12, p13, p14, p15) -- Line: 39
            for _, descendant in pairs(p15.HumanoidRootPart.CutsceneVFX.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 72, function(p16, p17, p18, p19, p20) -- Line: 48
            for _, descendant in pairs(p20.HumanoidRootPart.CutsceneVFX.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 86, function(p21, p22, p23, p24, p25) -- Line: 57
            for _, descendant in pairs(p23:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p22:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 207, function(p26, p27, p28, p29, p30) -- Line: 72
            for _, descendant in pairs(p30.HumanoidRootPart.CutsceneVFX.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 357, function(p31, p32, p33, p34, p35) -- Line: 81
            for _, descendant in pairs(p35.HumanoidRootPart.CutsceneVFX.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 885, function(p36, p37, p38, p39, p40) -- Line: 90
            for _, descendant in pairs(p40.HumanoidRootPart.CutsceneVFX.Five:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p40.HumanoidRootPart.CutsceneVFX.Five:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 943, function(p41, p42, p43, p44, p45) -- Line: 105
            for _, descendant in pairs(p45.Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1008, function(p46, p47, p48, p49, p50) -- Line: 114
            for _, descendant in pairs(p50.HumanoidRootPart.CutsceneVFX.Six:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p46.ScreenEffs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1046, function(p51, p52, p53, p54, p55) -- Line: 128
            for _, descendant in pairs(p51.ScreenEffs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p55.HumanoidRootPart.CutsceneVFX.Five:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1050, function(p56, p57, p58, p59, p60) -- Line: 142
            for _, descendant in pairs(p60.HumanoidRootPart.CutsceneVFX.Seven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p60.HumanoidRootPart.CutsceneVFX.Seven:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1087, function(p61, p62, p63, p64, p65) -- Line: 156
            shared.vfx.emit(p64.LeftGun["Cylinder.003"].kaboom, p64["Right Gun"]["Cylinder.003"].kaboom);
            p64.LeftGun["Cylinder.003"].kaboom["1"].Enabled = true;
            p64["Right Gun"]["Cylinder.003"].kaboom["1"].Enabled = true;

            for _, descendant in pairs(p65.HumanoidRootPart.CutsceneVFX.Seven:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p65.HumanoidRootPart.CutsceneVFX.Eight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p65.HumanoidRootPart.CutsceneVFX.Eight:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p61.ScreenEffs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1143, function(p66, p67, p68, p69, p70) -- Line: 183
            for _, descendant in pairs(p70.HumanoidRootPart.CutsceneVFX.Eight:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            p69.LeftGun["Cylinder.003"].kaboom["1"].Enabled = false;
            p69["Right Gun"]["Cylinder.003"].kaboom["1"].Enabled = false;

            for _, descendant in pairs(p66.ScreenEffs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p70.Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};