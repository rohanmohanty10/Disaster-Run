 
 

return {
    { 6, function(p1, p2) -- Line: 3
            for _, descendant in pairs(p2.CutsceneVFX.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p2.CutsceneVFX.ScreenEffs1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 42, function(p3, p4) -- Line: 17
            for _, descendant in pairs(p4.CutsceneVFX.ScreenEffs1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 72, function(p5, p6) -- Line: 26
            for _, descendant in pairs(p6.CutsceneVFX.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 144, function(p7, p8) -- Line: 35
            for _, descendant in pairs(p8.CutsceneVFX.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p8.CutsceneVFX.ScreenEffs1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 165, function(p9, p10) -- Line: 49
            for _, descendant in pairs(p10.CutsceneVFX.ScreenEffs1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 222, function(p11, p12) -- Line: 58
            for _, descendant in pairs(p12.CutsceneVFX.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 270, function(p13, p14) -- Line: 67
            for _, descendant in pairs(p13.TeethVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p14.CutsceneVFX.ScreenEffs1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 366, function(p15, p16) -- Line: 81
            for _, descendant in pairs(p16.CutsceneVFX.ScreenEffs1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 372, function(p17, p18) -- Line: 90
            for _, descendant in pairs(p18.CutsceneVFX.Five:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 450, function(p19, p20) -- Line: 99
            for _, descendant in pairs(p20.CutsceneVFX.Six:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 498, function(p21, p22) -- Line: 108
            for _, descendant in pairs(p22.CutsceneVFX.Seven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 566, function(p23, p24) -- Line: 117
            for _, descendant in pairs(p24.CutsceneVFX.Eight:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p24.CutsceneVFX.ScreenEffs1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p24.CutsceneVFX.Eight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 585, function(p25, p26) -- Line: 136
            for _, descendant in pairs(p26.CutsceneVFX.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 594, function(p27, p28) -- Line: 145
            for _, descendant in pairs(p28.CutsceneVFX.ScreenEffs1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 672, function(p29, p30) -- Line: 154
            for _, descendant in pairs(p30.CutsceneVFX.Eight:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p30.CutsceneVFX.Ten:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end }
};