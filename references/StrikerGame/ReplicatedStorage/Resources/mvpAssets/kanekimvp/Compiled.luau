 

 

return {
    { 0, function(p1, p2) -- Line: 3
            for _, descendant in pairs(p1.KanekiCry:GetDescendants()) do
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
        end },
    { 1531, function(p3, p4, p5) -- Line: 18
            for _, descendant in pairs(p5.GlassCrack:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 21
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 24
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 556, function(p6, p7, p8) -- Line: 33
            for _, descendant in pairs(p7.FaceLine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 36
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 39
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;

            for _, descendant in pairs(p8.CamLine2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 48
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 51
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 557, function(p9, p10, p11) -- Line: 60
            for _, descendant in pairs(p10.KanekiEyes:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 63
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 66
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;

            for _, descendant in pairs(p11.CamLine2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 75
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 78
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 1122, function(p12) -- Line: 87
            shared.vfx.emit(p12.ChainBroke);
        end },
    { 1156, function(p13) -- Line: 92
            shared.vfx.emit(p13.RingMesh);
        end },
    { 1210, function(p14) -- Line: 97
            for _, descendant in pairs(p14.KaguneArm1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 100
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 103
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 1245, function(p15) -- Line: 112
            for _, descendant in pairs(p15.KaguneArm2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 115
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 118
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 1267, function(p16) -- Line: 127
            for _, descendant in pairs(p16.KaguneArm3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 130
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 133
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 1289, function(p17) -- Line: 142
            for _, descendant in pairs(p17.KaguneArm4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 145
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 148
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 1496, function(p18, p19) -- Line: 157
            shared.vfx.emit(p19.EyeGlare);
        end },
    { 1531, function(p20, p21, p22) -- Line: 162
            for _, descendant in pairs(p22.GlassCrack:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 165
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 168
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end }
};