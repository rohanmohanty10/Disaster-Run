 
 

return {
    { 4, function(p1, p2) -- Line: 3
            for _, descendant in ipairs(p2.Steps.StepOne:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 15, function(p3, p4) -- Line: 13
            for _, descendant in ipairs(p4.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 18, function(p5, p6) -- Line: 23
            for _, descendant in ipairs(p6.Steps.StepTwo:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 20, function(p7, p8) -- Line: 33
            for _, descendant in ipairs(p7.Swirl:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 27, function(p9, p10) -- Line: 43
            for _, descendant in ipairs(p10.Steps.StepThree:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 38, function(p11, p12) -- Line: 53
            for _, descendant in ipairs(p12.Steps.StepTwo:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 40, function(p13, p14) -- Line: 63
            for _, descendant in ipairs(p13.Swirl:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 43, function(p15, p16) -- Line: 73
            for _, descendant in ipairs(p16.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 45, function(p17, p18) -- Line: 83
            for _, descendant in ipairs(p18.Zig:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 46, function(p19, p20) -- Line: 93
            for _, descendant in ipairs(p20.Steps.StepThree:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 48, function(p21, p22) -- Line: 103
            for _, descendant in ipairs(p22.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 81, function(p23, p24) -- Line: 113
            for _, descendant in ipairs(p24.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 82, function(p25, p26) -- Line: 123
            for _, descendant in ipairs(p26.Zag:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 83, function(p27, p28) -- Line: 133
            for _, descendant in ipairs(p28.Steps.StepFour:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 86, function(p29, p30) -- Line: 143
            for _, descendant in ipairs(p30.Five:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 105, function(p31, p32) -- Line: 153
            for _, descendant in ipairs(p32.Steps.StepFour:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 116, function(p33, p34) -- Line: 163
            for _, descendant in ipairs(p34.Steps.StepFive:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 120, function(p35, p36) -- Line: 173
            for _, descendant in ipairs(p36.BallOne:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 129, function(p37, p38) -- Line: 183
            for _, descendant in ipairs(p38.BallTwo:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 130, function(p39, p40) -- Line: 193
            for _, descendant in ipairs(p40.Steps.StepFive:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 141, function(p41, p42) -- Line: 203
            for _, descendant in ipairs(p42.Steps.StepSix:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 151, function(p43, p44) -- Line: 213
            for _, descendant in ipairs(p44.Steps.StepSeven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 157, function(p45, p46) -- Line: 223
            for _, descendant in ipairs(p46.Six:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 169, function(p47, p48) -- Line: 233
            for _, descendant in ipairs(p48.Steps.StepEight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 175, function(p49, p50) -- Line: 243
            for _, descendant in ipairs(p50.Steps.StepNine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 187, function(p51, p52) -- Line: 253
            for _, descendant in ipairs(p52.BallThree:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 188, function(p53, p54) -- Line: 263
            for _, descendant in ipairs(p54.Seven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 189, function(p55, p56) -- Line: 273
            for _, descendant in ipairs(p55.SwirlTwo:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 210, function(p57, p58) -- Line: 283
            for _, descendant in ipairs(p57.SwirlTwo:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 211, function(p59, p60) -- Line: 293
            for _, descendant in ipairs(p60.BallThree:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};