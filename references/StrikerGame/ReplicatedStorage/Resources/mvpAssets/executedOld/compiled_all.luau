 
 

return {
    { 0, function(p1) -- Line: 3
            for _, descendant in pairs(p1.aa.KaiserExecuted.Kaiser.Head:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 180, function(p2) -- Line: 12
            for _, descendant in pairs(p2.aa.KaiserExecuted.Kaiser.Head:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 0, function(p3) -- Line: 21
            for _, descendant in pairs(p3.aa.KaiserExecuted.Kaiser.Torso:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 180, function(p4) -- Line: 30
            for _, descendant in pairs(p4.aa.KaiserExecuted.Kaiser.Torso:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 14, function(p5) -- Line: 39
            (function(p6, p7) -- Line: 40, Name: Emit
                if p7 == "Child" then
                    for _, child in ipairs(p6:GetChildren()) do
                        if child:IsA("ParticleEmitter") or child:IsA("Beam") then
                            local v8 = child:GetAttribute("EmitDelay") or 0;
                            local u9 = child:GetAttribute("EmitCount") or 1;
                            local u10 = child:GetAttribute("EmitDuration") or 0;
                            task.delay(v8, function() -- Line: 48
                                -- upvalues: child (copy), u9 (copy), u10 (copy)
                                child:Emit(u9);

                                if u10 > 0 then
                                    child.Enabled = true;
                                    task.wait(u10);
                                    child.Enabled = false;
                                end;
                            end);
                        end;
                    end;

                    return;
                end;

                if p7 == "Descendant" then
                    for _, descendant in ipairs(p6:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                            local v11 = descendant:GetAttribute("EmitDelay") or 0;
                            local u12 = descendant:GetAttribute("EmitCount") or 1;
                            local u13 = descendant:GetAttribute("EmitDuration") or 0;
                            task.delay(v11, function() -- Line: 65
                                -- upvalues: descendant (copy), u12 (copy), u13 (copy)
                                if descendant:IsA("ParticleEmitter") then
                                    descendant:Emit(u12);
                                end;

                                if u13 > 0 then
                                    descendant.Enabled = true;
                                    task.wait(u13);
                                    descendant.Enabled = false;
                                end;
                            end);
                        end;
                    end;
                end;
            end)(p5.VFX.Floor, "Descendant");
        end },
    { 90, function(p14) -- Line: 84
            for _, descendant in pairs(p14.VFX.star:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 309, function(p15) -- Line: 93
            for _, descendant in pairs(p15.VFX.star:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 102, function(p16) -- Line: 102
            (function(p17, p18) -- Line: 103, Name: Emit
                if p18 == "Child" then
                    for _, child in ipairs(p17:GetChildren()) do
                        if child:IsA("ParticleEmitter") or child:IsA("Beam") then
                            local v19 = child:GetAttribute("EmitDelay") or 0;
                            local u20 = child:GetAttribute("EmitCount") or 1;
                            local u21 = child:GetAttribute("EmitDuration") or 0;
                            task.delay(v19, function() -- Line: 111
                                -- upvalues: child (copy), u20 (copy), u21 (copy)
                                child:Emit(u20);

                                if u21 > 0 then
                                    child.Enabled = true;
                                    task.wait(u21);
                                    child.Enabled = false;
                                end;
                            end);
                        end;
                    end;

                    return;
                end;

                if p18 == "Descendant" then
                    for _, descendant in ipairs(p17:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                            local v22 = descendant:GetAttribute("EmitDelay") or 0;
                            local u23 = descendant:GetAttribute("EmitCount") or 1;
                            local u24 = descendant:GetAttribute("EmitDuration") or 0;
                            task.delay(v22, function() -- Line: 128
                                -- upvalues: descendant (copy), u23 (copy), u24 (copy)
                                if descendant:IsA("ParticleEmitter") then
                                    descendant:Emit(u23);
                                end;

                                if u24 > 0 then
                                    descendant.Enabled = true;
                                    task.wait(u24);
                                    descendant.Enabled = false;
                                end;
                            end);
                        end;
                    end;
                end;
            end)(p16.VFX.Emit2, "Descendant");
        end }
};