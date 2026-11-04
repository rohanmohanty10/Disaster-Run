 
 

return {
    { 0, function(p1) -- Line: 3
            for _, descendant in pairs(p1.miau:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(1.55, function() -- Line: 10
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 74, function(p2) -- Line: 18
            for _, descendant in pairs(p2.miau:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p2.aaa.Torso.yao:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 93, function(p3, p4) -- Line: 38
            for _, descendant in pairs(p4.vfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(6.133, function() -- Line: 45
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            for _, descendant in pairs(p4.vfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    task.delay(6.133, function() -- Line: 60
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            for _, descendant in pairs(p4.vfx:GetDescendants()) do
                if descendant:IsA("SpotLight") then
                    descendant.Enabled = true;
                    task.delay(6.133, function() -- Line: 75
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            for _, descendant in pairs(p3.fast:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(6.133, function() -- Line: 89
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 461, function(p5) -- Line: 97
            for _, descendant in pairs(p5.inv:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p5.aaa.Torso.yao:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 490, function(p6) -- Line: 119
            for _, descendant in pairs(p6.inv:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0;
                end;
            end;
        end },
    { 743, function(p7) -- Line: 131
            for _, descendant in pairs(p7.aaa.Head:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(1.567, function() -- Line: 138
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 837, function(p8) -- Line: 146
            for _, descendant in pairs(p8.inv:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end }
};