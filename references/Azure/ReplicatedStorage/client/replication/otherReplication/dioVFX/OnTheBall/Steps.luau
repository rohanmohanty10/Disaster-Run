 

 

return {
    { 4, function(p1) -- Line: 3
            local function Emitir(p2) -- Line: 4
                for _, descendant in pairs(p2:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        local u3 = descendant:GetAttribute("EmitCount") or 0;
                        local u4 = descendant:GetAttribute("EmitDuration") or 0;
                        local v5 = descendant:GetAttribute("EmitDelay") or 0;
                        task.delay(v5, function() -- Line: 11
                            -- upvalues: descendant (copy), u3 (copy), u4 (copy)
                            descendant:Emit(u3);

                            if u4 > 0 then
                                descendant.Enabled = true;
                                task.delay(u4, function() -- Line: 16
                                    -- upvalues: descendant (ref)
                                    descendant.Enabled = false;
                                end);
                            end;
                        end);
                    end;
                end;
            end;

            local Steps = p1:FindFirstChild("Steps", true);

            if Steps then
                Emitir(Steps);
            end;
        end },
    { 31, function(p6) -- Line: 32
            local function v11(p7) -- Line: 33
                for _, descendant in pairs(p7:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        local u8 = descendant:GetAttribute("EmitCount") or 0;
                        local u9 = descendant:GetAttribute("EmitDuration") or 0;
                        local v10 = descendant:GetAttribute("EmitDelay") or 0;
                        task.delay(v10, function() -- Line: 40
                            -- upvalues: descendant (copy), u8 (copy), u9 (copy)
                            descendant:Emit(u8);

                            if u9 > 0 then
                                descendant.Enabled = true;
                                task.delay(u9, function() -- Line: 45
                                    -- upvalues: descendant (ref)
                                    descendant.Enabled = false;
                                end);
                            end;
                        end);
                    end;
                end;
            end;

            local Steps = p6:FindFirstChild("Steps", true);

            if Steps then
                v11(Steps);
            end;
        end },
    { 61, function(p12) -- Line: 61
            local function v17(p13) -- Line: 62
                for _, descendant in pairs(p13:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        local u14 = descendant:GetAttribute("EmitCount") or 0;
                        local u15 = descendant:GetAttribute("EmitDuration") or 0;
                        local v16 = descendant:GetAttribute("EmitDelay") or 0;
                        task.delay(v16, function() -- Line: 69
                            -- upvalues: descendant (copy), u14 (copy), u15 (copy)
                            descendant:Emit(u14);

                            if u15 > 0 then
                                descendant.Enabled = true;
                                task.delay(u15, function() -- Line: 74
                                    -- upvalues: descendant (ref)
                                    descendant.Enabled = false;
                                end);
                            end;
                        end);
                    end;
                end;
            end;

            local Steps = p12:FindFirstChild("Steps", true);

            if Steps then
                v17(Steps);
            end;
        end },
    { 104, function(p18) -- Line: 90
            local function v23(p19) -- Line: 91
                for _, descendant in pairs(p19:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        local u20 = descendant:GetAttribute("EmitCount") or 0;
                        local u21 = descendant:GetAttribute("EmitDuration") or 0;
                        local v22 = descendant:GetAttribute("EmitDelay") or 0;
                        task.delay(v22, function() -- Line: 98
                            -- upvalues: descendant (copy), u20 (copy), u21 (copy)
                            descendant:Emit(u20);

                            if u21 > 0 then
                                descendant.Enabled = true;
                                task.delay(u21, function() -- Line: 103
                                    -- upvalues: descendant (ref)
                                    descendant.Enabled = false;
                                end);
                            end;
                        end);
                    end;
                end;
            end;

            local Steps = p18:FindFirstChild("Steps", true);

            if Steps then
                v23(Steps);
            end;
        end }
};