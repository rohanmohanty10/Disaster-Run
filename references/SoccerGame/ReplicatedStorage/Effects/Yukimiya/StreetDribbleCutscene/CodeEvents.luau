  

local u43 = {
    { 0, function() -- Line: 1
            (function(p1) -- Line: 2, Name: Emit
                for _, descendant in ipairs(p1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u2 = descendant:GetAttribute("EmitDelay") or 0;
                        local u3 = descendant:GetAttribute("EmitCount") or 1;
                        local u4 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 8
                            -- upvalues: u2 (copy), descendant (copy), u3 (copy), u4 (copy)
                            task.wait(u2);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u3);
                            end;

                            if u4 > 0 then
                                descendant.Enabled = true;
                                task.wait(u4);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.Ball.BALL);
        end },
    { 42, function() -- Line: 26
            local function Emit(p5) -- Line: 27
                for _, descendant in ipairs(p5:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u6 = descendant:GetAttribute("EmitDelay") or 0;
                        local u7 = descendant:GetAttribute("EmitCount") or 1;
                        local u8 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 33
                            -- upvalues: u6 (copy), descendant (copy), u7 (copy), u8 (copy)
                            task.wait(u6);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u7);
                            end;

                            if u8 > 0 then
                                descendant.Enabled = true;
                                task.wait(u8);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end;

            Emit(workspace.VFX.CutsceneVFX.Wind1);
            Emit(workspace.VFX.CutsceneVFX.Wind2);
            Emit(workspace.VFX.CutsceneVFX.Wind3);
            Emit(workspace.VFX.CutsceneVFX.Enable);
            Emit(workspace.VFX.CutsceneVFX.CameraTracker);
        end },
    { 57, function() -- Line: 63
            (function(p9) -- Line: 64, Name: Emit
                for _, descendant in ipairs(p9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u10 = descendant:GetAttribute("EmitDelay") or 0;
                        local u11 = descendant:GetAttribute("EmitCount") or 1;
                        local u12 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 70
                            -- upvalues: u10 (copy), descendant (copy), u11 (copy), u12 (copy)
                            task.wait(u10);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u11);
                            end;

                            if u12 > 0 then
                                descendant.Enabled = true;
                                task.wait(u12);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Start);
        end },
    { 142, function() -- Line: 88
            local function v17(p13) -- Line: 89
                for _, descendant in ipairs(p13:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u14 = descendant:GetAttribute("EmitDelay") or 0;
                        local u15 = descendant:GetAttribute("EmitCount") or 1;
                        local u16 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 95
                            -- upvalues: u14 (copy), descendant (copy), u15 (copy), u16 (copy)
                            task.wait(u14);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u15);
                            end;

                            if u16 > 0 then
                                descendant.Enabled = true;
                                task.wait(u16);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end;

            local v18 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v18 = child;
                    break;
                end;
            end;

            v17(v18.Head);
            v17(v18["Left Arm"]);
            v17(v18["Right Arm"]);
            v17(v18["Right Leg"]);
            v17(v18["Right Leg"]);
            v17(v18.Torso);
        end },
    { 182, function() -- Line: 137
            (function(p19) -- Line: 138, Name: Emit
                for _, descendant in ipairs(p19:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u20 = descendant:GetAttribute("EmitDelay") or 0;
                        local u21 = descendant:GetAttribute("EmitCount") or 1;
                        local u22 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 144
                            -- upvalues: u20 (copy), descendant (copy), u21 (copy), u22 (copy)
                            task.wait(u20);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u21);
                            end;

                            if u22 > 0 then
                                descendant.Enabled = true;
                                task.wait(u22);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Flick1);
        end },
    { 220, function() -- Line: 162
            (function(p23) -- Line: 163, Name: Emit
                for _, descendant in ipairs(p23:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u24 = descendant:GetAttribute("EmitDelay") or 0;
                        local u25 = descendant:GetAttribute("EmitCount") or 1;
                        local u26 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 169
                            -- upvalues: u24 (copy), descendant (copy), u25 (copy), u26 (copy)
                            task.wait(u24);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u25);
                            end;

                            if u26 > 0 then
                                descendant.Enabled = true;
                                task.wait(u26);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Step1);
        end },
    { 254, function() -- Line: 187
            (function(p27) -- Line: 188, Name: Emit
                for _, descendant in ipairs(p27:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u28 = descendant:GetAttribute("EmitDelay") or 0;
                        local u29 = descendant:GetAttribute("EmitCount") or 1;
                        local u30 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 194
                            -- upvalues: u28 (copy), descendant (copy), u29 (copy), u30 (copy)
                            task.wait(u28);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u29);
                            end;

                            if u30 > 0 then
                                descendant.Enabled = true;
                                task.wait(u30);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Flick2);
        end },
    { 266, function() -- Line: 212
            (function(p31) -- Line: 213, Name: Emit
                for _, descendant in ipairs(p31:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u32 = descendant:GetAttribute("EmitDelay") or 0;
                        local u33 = descendant:GetAttribute("EmitCount") or 1;
                        local u34 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 219
                            -- upvalues: u32 (copy), descendant (copy), u33 (copy), u34 (copy)
                            task.wait(u32);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u33);
                            end;

                            if u34 > 0 then
                                descendant.Enabled = true;
                                task.wait(u34);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Step2);
        end },
    { 289, function() -- Line: 237
            (function(p35) -- Line: 238, Name: Emit
                for _, descendant in ipairs(p35:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u36 = descendant:GetAttribute("EmitDelay") or 0;
                        local u37 = descendant:GetAttribute("EmitCount") or 1;
                        local u38 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 244
                            -- upvalues: u36 (copy), descendant (copy), u37 (copy), u38 (copy)
                            task.wait(u36);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u37);
                            end;

                            if u38 > 0 then
                                descendant.Enabled = true;
                                task.wait(u38);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Flick3);
        end },
    { 316, function() -- Line: 262
            (function(p39) -- Line: 263, Name: Emit
                for _, descendant in ipairs(p39:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u40 = descendant:GetAttribute("EmitDelay") or 0;
                        local u41 = descendant:GetAttribute("EmitCount") or 1;
                        local u42 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 269
                            -- upvalues: u40 (copy), descendant (copy), u41 (copy), u42 (copy)
                            task.wait(u40);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u41);
                            end;

                            if u42 > 0 then
                                descendant.Enabled = true;
                                task.wait(u42);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Step3);
        end }
};

return function(u44) -- Line: 288
    -- upvalues: u43 (copy)
    task.spawn(function() -- Line: 289
        -- upvalues: u44 (copy), u43 (ref)
        local v45 = 0;

        while u44:IsPlaying() do
            local CurrentFrame = u44.CurrentFrame;

            for _, v in u43 do
                local v46 = v[1];
                local v47 = v[2];

                if v46 <= CurrentFrame and v45 < v46 then
                    task.spawn(v47);
                end;
            end;

            task.wait();
            v45 = CurrentFrame;
        end;
    end);
end;