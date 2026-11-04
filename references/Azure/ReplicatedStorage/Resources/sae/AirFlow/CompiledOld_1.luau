 
 

return {
    { 0, function(p1, p2) -- Line: 3
            for _, descendant in pairs(p1.VFX.saeotwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 6
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 9
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;

            for _, descendant in pairs(p1.VFX.saeotstuff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p2.CamPart.saeotlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p2.camwind1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p1["azl ballllllls_rig"].Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p1.VFX.EyeFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 28, function(p3, p4) -- Line: 49
            for _, descendant in pairs(p3.VFX.n1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 52
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 55
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 42, function(p5, p6) -- Line: 64
            for _, descendant in pairs(p5.VFX.n2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 67
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 70
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 47, function(p7, p8) -- Line: 79
            for _, descendant in pairs(p7.VFX.grassemitdash:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 82
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 85
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 70, function(p9, p10) -- Line: 94
            for _, descendant in pairs(p9.VFX.saeotwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 97
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = false;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 100
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 172, function(p11, p12) -- Line: 109
            for _, descendant in pairs(p11.VFX.saeotstuff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p11["azl ballllllls_rig"].Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 486, function(p13, p14) -- Line: 124
            for _, descendant in pairs(p14.CamPart.saeotlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p14.camwind1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p13.VFX.EyeFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 626, function(p15, p16) -- Line: 145
            for _, descendant in pairs(p15.VFX.saeotwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 148
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 151
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;

            for _, descendant in pairs(p15.VFX.saeotstuff:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p16.CamPart.saeotlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p16.camwind1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p15["azl ballllllls_rig"].Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p15.VFX.EyeFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};