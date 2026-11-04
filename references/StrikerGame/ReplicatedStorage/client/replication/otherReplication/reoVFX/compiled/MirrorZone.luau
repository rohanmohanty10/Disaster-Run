 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            if p1 then
                for _, descendant in ipairs(p1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end },
    { 29, function(p4, p5, p6) -- Line: 14
            for _, descendant in ipairs(p5.RootPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.6, function() -- Line: 18
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 42, function(p7, p8, p9) -- Line: 24
            for _, descendant in ipairs(p9.Breath:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 61, function(p10, p11, p12) -- Line: 33
            for _, descendant in ipairs(p12.Transition:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.2, function() -- Line: 37
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 80, function(p13, p14, p15) -- Line: 43
            for _, descendant in ipairs(p15.HalfAura:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in ipairs(p15.PantherStep:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 86, function(p16, p17, p18) -- Line: 57
            for _, descendant in ipairs(p18.Chomp:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 105, function(p19, p20, p21) -- Line: 66
            for _, descendant in ipairs(p21.Transition2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.25, function() -- Line: 70
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 182, function(p22, p23, p24) -- Line: 76
            for _, descendant in ipairs(p24.Breath:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 213, function(p25, p26, p27) -- Line: 85
            for _, descendant in ipairs(p27.ballaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.9, function() -- Line: 89
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                        descendant:Clear();
                    end);
                end;
            end;
        end },
    { 235, function(p28, p29, p30) -- Line: 95
            for _, descendant in ipairs(p30.PantherStep2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 251, function(p31, p32, p33) -- Line: 104
            for _, descendant in ipairs(p33.PantherStep3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 265, function(p34, p35, p36) -- Line: 113
            for _, descendant in ipairs(p36.Transition2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.25, function() -- Line: 117
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 271, function(p37, p38, p39) -- Line: 123
            for _, descendant in ipairs(p39.HalfAura:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in ipairs(p39.FullAura:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in ipairs(p39.Shot:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in ipairs(p39.Shot:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            if p37 then
                for _, descendant in ipairs(p37:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 324, function(p40, p41, p42) -- Line: 154
            for _, descendant in ipairs(p42.FullAura:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in ipairs(p42.Shot:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};