 
 

return {
    { 29, function(p1) -- Line: 3
            for _, descendant in pairs(p1.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u2 = descendant:GetAttribute("EmitCount") or 10;
                    local u3 = descendant:GetAttribute("EmitDuration") or 0;
                    local v4 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v4, function() -- Line: 13
                        -- upvalues: u3 (copy), descendant (copy), u2 (copy)
                        if u3 <= 0 then
                            descendant:Emit(u2);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u3, function() -- Line: 17
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 226, function(p5) -- Line: 30
            for _, descendant in pairs(p5.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u6 = descendant:GetAttribute("EmitCount") or 10;
                    local u7 = descendant:GetAttribute("EmitDuration") or 0;
                    local v8 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v8, function() -- Line: 40
                        -- upvalues: u7 (copy), descendant (copy), u6 (copy)
                        if u7 <= 0 then
                            descendant:Emit(u6);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u7, function() -- Line: 44
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 252, function(p9) -- Line: 57
            for _, descendant in pairs(p9.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u10 = descendant:GetAttribute("EmitCount") or 10;
                    local u11 = descendant:GetAttribute("EmitDuration") or 0;
                    local v12 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v12, function() -- Line: 67
                        -- upvalues: u11 (copy), descendant (copy), u10 (copy)
                        if u11 <= 0 then
                            descendant:Emit(u10);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u11, function() -- Line: 71
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 295, function(p13) -- Line: 84
            for _, descendant in pairs(p13.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u14 = descendant:GetAttribute("EmitCount") or 10;
                    local u15 = descendant:GetAttribute("EmitDuration") or 0;
                    local v16 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v16, function() -- Line: 94
                        -- upvalues: u15 (copy), descendant (copy), u14 (copy)
                        if u15 <= 0 then
                            descendant:Emit(u14);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u15, function() -- Line: 98
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 337, function(p17) -- Line: 111
            for _, descendant in pairs(p17.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u18 = descendant:GetAttribute("EmitCount") or 10;
                    local u19 = descendant:GetAttribute("EmitDuration") or 0;
                    local v20 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v20, function() -- Line: 121
                        -- upvalues: u19 (copy), descendant (copy), u18 (copy)
                        if u19 <= 0 then
                            descendant:Emit(u18);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u19, function() -- Line: 125
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 371, function(p21) -- Line: 138
            for _, descendant in pairs(p21.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u22 = descendant:GetAttribute("EmitCount") or 10;
                    local u23 = descendant:GetAttribute("EmitDuration") or 0;
                    local v24 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v24, function() -- Line: 148
                        -- upvalues: u23 (copy), descendant (copy), u22 (copy)
                        if u23 <= 0 then
                            descendant:Emit(u22);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u23, function() -- Line: 152
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 404, function(p25) -- Line: 165
            for _, descendant in pairs(p25.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u26 = descendant:GetAttribute("EmitCount") or 10;
                    local u27 = descendant:GetAttribute("EmitDuration") or 0;
                    local v28 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v28, function() -- Line: 175
                        -- upvalues: u27 (copy), descendant (copy), u26 (copy)
                        if u27 <= 0 then
                            descendant:Emit(u26);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u27, function() -- Line: 179
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 437, function(p29) -- Line: 192
            for _, descendant in pairs(p29.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u30 = descendant:GetAttribute("EmitCount") or 10;
                    local u31 = descendant:GetAttribute("EmitDuration") or 0;
                    local v32 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v32, function() -- Line: 202
                        -- upvalues: u31 (copy), descendant (copy), u30 (copy)
                        if u31 <= 0 then
                            descendant:Emit(u30);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u31, function() -- Line: 206
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 471, function(p33) -- Line: 219
            for _, descendant in pairs(p33.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u34 = descendant:GetAttribute("EmitCount") or 10;
                    local u35 = descendant:GetAttribute("EmitDuration") or 0;
                    local v36 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v36, function() -- Line: 229
                        -- upvalues: u35 (copy), descendant (copy), u34 (copy)
                        if u35 <= 0 then
                            descendant:Emit(u34);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u35, function() -- Line: 233
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 532, function(p37) -- Line: 246
            for _, descendant in pairs(p37.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u38 = descendant:GetAttribute("EmitCount") or 10;
                    local u39 = descendant:GetAttribute("EmitDuration") or 0;
                    local v40 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v40, function() -- Line: 256
                        -- upvalues: u39 (copy), descendant (copy), u38 (copy)
                        if u39 <= 0 then
                            descendant:Emit(u38);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u39, function() -- Line: 260
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 610, function(p41) -- Line: 273
            for _, descendant in pairs(p41.hamwind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u42 = descendant:GetAttribute("EmitCount") or 10;
                    local u43 = descendant:GetAttribute("EmitDuration") or 0;
                    local v44 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v44, function() -- Line: 283
                        -- upvalues: u43 (copy), descendant (copy), u42 (copy)
                        if u43 <= 0 then
                            descendant:Emit(u42);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u43, function() -- Line: 287
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end }
};