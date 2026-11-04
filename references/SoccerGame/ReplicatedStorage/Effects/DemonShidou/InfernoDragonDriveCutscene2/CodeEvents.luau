  

local EmitModule = require(game.ReplicatedStorage.Shared.EmitModule);
local u25 = {
    { 47, function() -- Line: 3
            (function(p1) -- Line: 4, Name: Emit
                for _, descendant in ipairs(p1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u2 = descendant:GetAttribute("EmitDelay") or 0;
                        local u3 = descendant:GetAttribute("EmitCount") or 1;
                        local u4 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 10
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
            end)(workspace.VFX.CutsceneVFX.Kick1);
        end },
    { 249, function() -- Line: 28
            (function(p5) -- Line: 29, Name: Emit
                for _, descendant in ipairs(p5:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u6 = descendant:GetAttribute("EmitDelay") or 0;
                        local u7 = descendant:GetAttribute("EmitCount") or 1;
                        local u8 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 35
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
            end)(workspace.VFX.CutsceneVFX.Fall);
        end },
    { 447, function() -- Line: 53
            (function(p9) -- Line: 54, Name: Emit
                for _, descendant in ipairs(p9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u10 = descendant:GetAttribute("EmitDelay") or 0;
                        local u11 = descendant:GetAttribute("EmitCount") or 1;
                        local u12 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 60
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
            end)(workspace.VFX.CutsceneVFX.Summon);
        end },
    { 539, function() -- Line: 78
            (function(p13) -- Line: 79, Name: Emit
                for _, descendant in ipairs(p13:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u14 = descendant:GetAttribute("EmitDelay") or 0;
                        local u15 = descendant:GetAttribute("EmitCount") or 1;
                        local u16 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 85
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
            end)(workspace.VFX.CutsceneVFX.Ground);
        end },
    { 542, function() -- Line: 103
            -- upvalues: EmitModule (copy)
            EmitModule.emit(workspace.VFX["blr dragon rig2"].RootPart.Main["Eye.L"].Flight);
        end },
    { 543, function() -- Line: 106
            -- upvalues: EmitModule (copy)
            EmitModule.emit(workspace.VFX.CutsceneVFX.ScreenEffect);
        end },
    { 1089, function() -- Line: 109
            (function(p17) -- Line: 110, Name: Emit
                for _, descendant in ipairs(p17:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u18 = descendant:GetAttribute("EmitDelay") or 0;
                        local u19 = descendant:GetAttribute("EmitCount") or 1;
                        local u20 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 116
                            -- upvalues: u18 (copy), descendant (copy), u19 (copy), u20 (copy)
                            task.wait(u18);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u19);
                            end;

                            if u20 > 0 then
                                descendant.Enabled = true;
                                task.wait(u20);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.BG);
        end },
    { 1681, function() -- Line: 134
            -- upvalues: EmitModule (copy)
            EmitModule.emit(workspace.VFX.Ball.BALL.Enable);
        end },
    { 1870, function() -- Line: 137
            (function(p21) -- Line: 138, Name: Emit
                for _, descendant in ipairs(p21:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u22 = descendant:GetAttribute("EmitDelay") or 0;
                        local u23 = descendant:GetAttribute("EmitCount") or 1;
                        local u24 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 144
                            -- upvalues: u22 (copy), descendant (copy), u23 (copy), u24 (copy)
                            task.wait(u22);

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
            end)(workspace.VFX.CutsceneVFX.Kick2);
        end }
};

return function(u26) -- Line: 163
    -- upvalues: u25 (copy)
    task.spawn(function() -- Line: 164
        -- upvalues: u26 (copy), u25 (ref)
        local v27 = 0;

        while u26:IsPlaying() do
            local CurrentFrame = u26.CurrentFrame;

            for _, v in u25 do
                local v28 = v[1];
                local v29 = v[2];

                if v28 <= CurrentFrame and v27 < v28 then
                    task.spawn(v29);
                end;
            end;

            task.wait();
            v27 = CurrentFrame;
        end;
    end);
end;