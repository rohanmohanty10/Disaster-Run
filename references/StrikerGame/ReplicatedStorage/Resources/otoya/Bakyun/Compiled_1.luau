 
 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            for _, descendant in pairs(p2["real lofeu"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p1.smokebg:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            if p3 then
                for _, descendant in pairs(p3.CamPart:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;
                end;

                for _, descendant in pairs(p3.CamPart:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 13, function(p4, p5, p6) -- Line: 36
            if p6 then
                for _, descendant in pairs(p6.CamPart:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end },
    { 76, function(p7, p8, p9) -- Line: 48
            for _, descendant in pairs(p8["real lofeu"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.1;
                end;
            end;

            for _, descendant in pairs(p7.smokebg:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.06;
                end;
            end;
        end },
    { 167, function(p10, p11, p12) -- Line: 64
            for _, descendant in pairs(p10.grass1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p10.grass1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.1;
                end;
            end;
        end },
    { 230, function(p13, p14, p15) -- Line: 81
            for _, descendant in pairs(p14["real lofeu"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;

            for _, descendant in pairs(p13.grass1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;

            for _, descendant in pairs(p13.smokebg:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant.TimeScale = 1;
                end;
            end;
        end },
    { 231, function(p16, p17, p18) -- Line: 106
            for _, descendant in pairs(p16.grass2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 233, function(p19, p20, p21) -- Line: 116
            for _, descendant in pairs(p19.grass3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 239, function(p22, p23, p24) -- Line: 126
            for _, descendant in pairs(p22.grass4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 249, function(p25, p26, p27) -- Line: 136
            for _, descendant in pairs(p25.grass5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 253, function(p28, p29, p30) -- Line: 146
            for _, descendant in pairs(p28.jump:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 260, function(p31, p32, p33) -- Line: 156
            for _, descendant in pairs(p31.otoyatrap:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p32["real lofeu"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    descendant.TimeScale = 0.1;
                end;
            end;
        end },
    { 331, function(p34, p35, p36) -- Line: 174
            for _, descendant in pairs(p34.breath0:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 424, function(p37, p38, p39) -- Line: 184
            if p39 then
                for _, descendant in pairs(p39.CamPart:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 427, function(p40, p41, p42) -- Line: 196
            if p42 then
                for _, descendant in pairs(p42.CamPart:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            for _, descendant in pairs(p40.vein:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 431, function(p43, p44, p45) -- Line: 215
            if p45 then
                for _, descendant in pairs(p45.CamPart:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end },
    { 481, function(p46, p47, p48) -- Line: 227
            for _, descendant in pairs(p47["real lofeu"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant.TimeScale = 1;
                end;
            end;
        end }
};