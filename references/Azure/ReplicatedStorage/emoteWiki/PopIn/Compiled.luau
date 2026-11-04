 

 

return {
    { 15, function(p1) -- Line: 3
            for _, descendant in ipairs(p1.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v2 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v2, function() -- Line: 10
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 41, function(p3) -- Line: 19
            for _, descendant in ipairs(p3.Stars:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v4 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v4, function() -- Line: 26
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 51, function(p5) -- Line: 35
            for _, descendant in ipairs(p5.Stars:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v6 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v6, function() -- Line: 42
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 52, function(p7) -- Line: 51
            for _, descendant in ipairs(p7.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v8 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v8, function() -- Line: 58
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 58, function(p9) -- Line: 67
            for _, descendant in ipairs(p9.Stars:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v10 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v10, function() -- Line: 74
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 95, function(p11) -- Line: 83
            for _, descendant in ipairs(p11.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v12 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v12, function() -- Line: 90
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 120, function(p13) -- Line: 99
            for _, descendant in ipairs(p13.Stars:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v14 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v14, function() -- Line: 106
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 133, function(p15) -- Line: 115
            for _, descendant in ipairs(p15.Stars:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v16 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v16, function() -- Line: 122
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 139, function(p17) -- Line: 131
            for _, descendant in ipairs(p17.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v18 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v18, function() -- Line: 138
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 142, function(p19) -- Line: 147
            for _, descendant in ipairs(p19.Stars:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v20 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v20, function() -- Line: 154
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 153, function(p21) -- Line: 163
            for _, descendant in ipairs(p21.Stars:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v22 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v22, function() -- Line: 170
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 183, function(p23) -- Line: 179
            for _, descendant in ipairs(p23.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v24 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v24, function() -- Line: 186
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 213, function(p25) -- Line: 195
            for _, descendant in ipairs(p25.Star:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v26 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v26, function() -- Line: 202
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 257, function(p27) -- Line: 211
            for _, descendant in ipairs(p27.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v28 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v28, function() -- Line: 218
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 265, function(p29) -- Line: 227
            for _, descendant in ipairs(p29.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v30 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v30, function() -- Line: 234
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 336, function(p31) -- Line: 243
            for _, descendant in ipairs(p31.BigStar:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v32 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v32, function() -- Line: 250
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 340, function(p33) -- Line: 259
            for _, descendant in ipairs(p33.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v34 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v34, function() -- Line: 266
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 362, function(p35) -- Line: 275
            for _, descendant in ipairs(p35.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v36 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v36, function() -- Line: 282
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 381, function(p37) -- Line: 291
            for _, descendant in ipairs(p37.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v38 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v38, function() -- Line: 298
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 401, function(p39) -- Line: 307
            for _, descendant in ipairs(p39.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v40 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v40, function() -- Line: 314
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 425, function(p41) -- Line: 323
            for _, descendant in ipairs(p41.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v42 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v42, function() -- Line: 330
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 467, function(p43) -- Line: 339
            for _, descendant in ipairs(p43.Heart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v44 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v44, function() -- Line: 346
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 479, function(p45) -- Line: 355
            for _, descendant in ipairs(p45.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v46 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v46, function() -- Line: 362
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 506, function(p47) -- Line: 371
            for _, descendant in ipairs(p47.Hearts:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v48 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v48, function() -- Line: 378
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 509, function(p49) -- Line: 387
            for _, descendant in ipairs(p49.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v50 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v50, function() -- Line: 394
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 542, function(p51) -- Line: 403
            for _, descendant in ipairs(p51.Hearts:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v52 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v52, function() -- Line: 410
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 553, function(p53) -- Line: 419
            for _, descendant in ipairs(p53.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v54 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v54, function() -- Line: 426
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 582, function(p55) -- Line: 435
            for _, descendant in ipairs(p55.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v56 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v56, function() -- Line: 442
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 592, function(p57) -- Line: 451
            for _, descendant in ipairs(p57.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v58 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v58, function() -- Line: 458
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 593, function(p59) -- Line: 467
            for _, descendant in ipairs(p59.Specs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 600, function(p60) -- Line: 478
            for _, descendant in ipairs(p60.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v61 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v61, function() -- Line: 485
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end },
    { 643, function(p62) -- Line: 494
            for _, descendant in ipairs(p62.Specs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 666, function(p63) -- Line: 505
            for _, descendant in ipairs(p63.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local Attribute = descendant:GetAttribute("EmitCount");
                    local v64 = descendant:GetAttribute("EmitDelay") or 0;

                    if typeof(Attribute) == "number" then
                        task.delay(v64, function() -- Line: 512
                            -- upvalues: descendant (copy), Attribute (copy)
                            descendant:Emit(Attribute);
                        end);
                    end;
                end;
            end;
        end }
};