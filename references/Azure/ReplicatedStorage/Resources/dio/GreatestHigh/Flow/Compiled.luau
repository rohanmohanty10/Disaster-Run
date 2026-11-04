 
 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            for _, descendant in pairs(p3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u4 = descendant:GetAttribute("EmitCount") or 10;
                    local u5 = descendant:GetAttribute("EmitDuration") or 0;
                    local v6 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v6, function() -- Line: 13
                        -- upvalues: u5 (copy), descendant (copy), u4 (copy)
                        if u5 <= 0 then
                            descendant:Emit(u4);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u5, function() -- Line: 17
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 1, function(p7, p8, p9) -- Line: 30
            for _, descendant in pairs(p8:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "aura" then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 3, function(p10, p11, p12) -- Line: 41
            for _, descendant in pairs(p12.HumanoidRootPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u13 = descendant:GetAttribute("EmitCount") or 10;
                    local u14 = descendant:GetAttribute("EmitDuration") or 0;
                    local v15 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v15, function() -- Line: 51
                        -- upvalues: u14 (copy), descendant (copy), u13 (copy)
                        if u14 <= 0 then
                            descendant:Emit(u13);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u14, function() -- Line: 55
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 7, function(p16, p17, p18) -- Line: 68
            for _, descendant in pairs(p17.brosawsomething:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u19 = descendant:GetAttribute("EmitCount") or 10;
                    local u20 = descendant:GetAttribute("EmitDuration") or 0;
                    local v21 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v21, function() -- Line: 78
                        -- upvalues: u20 (copy), descendant (copy), u19 (copy)
                        if u20 <= 0 then
                            descendant:Emit(u19);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u20, function() -- Line: 82
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 61, function(p22, p23, p24) -- Line: 95
            local Legbottom = p23:WaitForChild("Right Leg").Legbottom;

            for _, descendant in pairs(Legbottom:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u25 = descendant:GetAttribute("EmitCount") or 10;
                    local u26 = descendant:GetAttribute("EmitDuration") or 0;
                    local v27 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v27, function() -- Line: 105
                        -- upvalues: u26 (copy), descendant (copy), u25 (copy)
                        if u26 <= 0 then
                            descendant:Emit(u25);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u26, function() -- Line: 109
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 62, function(p28, p29, p30) -- Line: 122
            local Legbottom = p29:WaitForChild("Left Leg").Legbottom;

            for _, descendant in pairs(Legbottom:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u31 = descendant:GetAttribute("EmitCount") or 10;
                    local u32 = descendant:GetAttribute("EmitDuration") or 0;
                    local v33 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v33, function() -- Line: 132
                        -- upvalues: u32 (copy), descendant (copy), u31 (copy)
                        if u32 <= 0 then
                            descendant:Emit(u31);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u32, function() -- Line: 136
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 63, function(p34, p35, p36) -- Line: 149
            for _, descendant in pairs(p35.Wind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u37 = descendant:GetAttribute("EmitCount") or 10;
                    local u38 = descendant:GetAttribute("EmitDuration") or 0;
                    local v39 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v39, function() -- Line: 159
                        -- upvalues: u38 (copy), descendant (copy), u37 (copy)
                        if u38 <= 0 then
                            descendant:Emit(u37);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u38, function() -- Line: 163
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 121, function(p40, p41, p42) -- Line: 176
            for _, descendant in pairs(p41:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "aura" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 152, function(p43, p44, p45) -- Line: 187
            for _, descendant in pairs(p43.time:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u46 = descendant:GetAttribute("EmitCount") or 10;
                    local u47 = descendant:GetAttribute("EmitDuration") or 0;
                    local v48 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v48, function() -- Line: 197
                        -- upvalues: u47 (copy), descendant (copy), u46 (copy)
                        if u47 <= 0 then
                            descendant:Emit(u46);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u47, function() -- Line: 201
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 187, function(p49, p50, p51) -- Line: 214
            for _, descendant in pairs(p50.impactpart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u52 = descendant:GetAttribute("EmitCount") or 10;
                    local u53 = descendant:GetAttribute("EmitDuration") or 0;
                    local v54 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v54, function() -- Line: 224
                        -- upvalues: u53 (copy), descendant (copy), u52 (copy)
                        if u53 <= 0 then
                            descendant:Emit(u52);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u53, function() -- Line: 228
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 197, function(p55, p56, p57) -- Line: 241
            local v58 = p56:WaitForChild("Left Leg");

            for _, descendant in pairs(v58:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u59 = descendant:GetAttribute("EmitCount") or 10;
                    local u60 = descendant:GetAttribute("EmitDuration") or 0;
                    local v61 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v61, function() -- Line: 251
                        -- upvalues: u60 (copy), descendant (copy), u59 (copy)
                        if u60 <= 0 then
                            descendant:Emit(u59);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u60, function() -- Line: 255
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 206, function(p62, p63, p64) -- Line: 268
            local v65 = p63:WaitForChild("Left Leg");

            for _, descendant in pairs(v65:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u66 = descendant:GetAttribute("EmitCount") or 10;
                    local u67 = descendant:GetAttribute("EmitDuration") or 0;
                    local v68 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v68, function() -- Line: 278
                        -- upvalues: u67 (copy), descendant (copy), u66 (copy)
                        if u67 <= 0 then
                            descendant:Emit(u66);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u67, function() -- Line: 282
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 212, function(p69, p70, p71) -- Line: 295
            local v72 = p70:WaitForChild("Left Leg");

            for _, descendant in pairs(v72:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u73 = descendant:GetAttribute("EmitCount") or 10;
                    local u74 = descendant:GetAttribute("EmitDuration") or 0;
                    local v75 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v75, function() -- Line: 305
                        -- upvalues: u74 (copy), descendant (copy), u73 (copy)
                        if u74 <= 0 then
                            descendant:Emit(u73);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u74, function() -- Line: 309
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 216, function(p76, p77, p78) -- Line: 322
            local v79 = p77:WaitForChild("Right Leg");

            for _, descendant in pairs(v79:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u80 = descendant:GetAttribute("EmitCount") or 10;
                    local u81 = descendant:GetAttribute("EmitDuration") or 0;
                    local v82 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v82, function() -- Line: 332
                        -- upvalues: u81 (copy), descendant (copy), u80 (copy)
                        if u81 <= 0 then
                            descendant:Emit(u80);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u81, function() -- Line: 336
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 227, function(p83, p84, p85) -- Line: 349
            local v86 = p84:WaitForChild("Left Leg");

            for _, descendant in pairs(v86:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u87 = descendant:GetAttribute("EmitCount") or 10;
                    local u88 = descendant:GetAttribute("EmitDuration") or 0;
                    local v89 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v89, function() -- Line: 359
                        -- upvalues: u88 (copy), descendant (copy), u87 (copy)
                        if u88 <= 0 then
                            descendant:Emit(u87);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u88, function() -- Line: 363
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 381, function(p90, p91, p92) -- Line: 376
            local v93 = p91:WaitForChild("Left Leg");

            for _, descendant in pairs(v93:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u94 = descendant:GetAttribute("EmitCount") or 10;
                    local u95 = descendant:GetAttribute("EmitDuration") or 0;
                    local v96 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v96, function() -- Line: 386
                        -- upvalues: u95 (copy), descendant (copy), u94 (copy)
                        if u95 <= 0 then
                            descendant:Emit(u94);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u95, function() -- Line: 390
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 382, function(p97, p98, p99) -- Line: 403
            local v100 = p98:WaitForChild("Right Leg");

            for _, descendant in pairs(v100:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u101 = descendant:GetAttribute("EmitCount") or 10;
                    local u102 = descendant:GetAttribute("EmitDuration") or 0;
                    local v103 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v103, function() -- Line: 413
                        -- upvalues: u102 (copy), descendant (copy), u101 (copy)
                        if u102 <= 0 then
                            descendant:Emit(u101);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u102, function() -- Line: 417
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 383, function(p104, p105, p106) -- Line: 430
            for _, descendant in pairs(p105.Wind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u107 = descendant:GetAttribute("EmitCount") or 10;
                    local u108 = descendant:GetAttribute("EmitDuration") or 0;
                    local v109 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v109, function() -- Line: 440
                        -- upvalues: u108 (copy), descendant (copy), u107 (copy)
                        if u108 <= 0 then
                            descendant:Emit(u107);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u108, function() -- Line: 444
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 565, function(p110, p111, p112) -- Line: 457
            for _, descendant in pairs(p111.Torso.staraura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u113 = descendant:GetAttribute("EmitCount") or 10;
                    local u114 = descendant:GetAttribute("EmitDuration") or 0;
                    local v115 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v115, function() -- Line: 467
                        -- upvalues: u114 (copy), descendant (copy), u113 (copy)
                        if u114 <= 0 then
                            descendant:Emit(u113);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u114, function() -- Line: 471
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 712, function(p116, p117, p118) -- Line: 484
            for _, descendant in pairs(p116.time:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local u119 = descendant:GetAttribute("EmitCount") or 10;
                    local u120 = descendant:GetAttribute("EmitDuration") or 0;
                    local v121 = descendant:GetAttribute("EmitDelay") or 0;
                    task.delay(v121, function() -- Line: 494
                        -- upvalues: u120 (copy), descendant (copy), u119 (copy)
                        if u120 <= 0 then
                            descendant:Emit(u119);

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(u120, function() -- Line: 498
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end },
    { 738, function(p122, p123, p124) -- Line: 511
            for _, descendant in pairs(p123:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "aura" then
                    descendant.Enabled = false;
                end;
            end;
        end }
};