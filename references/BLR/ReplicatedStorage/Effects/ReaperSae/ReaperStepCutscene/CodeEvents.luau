  

local u21 = {
    { 5, function() -- Line: 1
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
            end)(workspace.VFX.CutsceneVFX.Enable);
        end },
    { 146, function() -- Line: 26
            (function(p5) -- Line: 27, Name: Emit
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
            end)(workspace.VFX.CutsceneVFX.Slash);
        end },
    { 226, function() -- Line: 51
            (function(p9) -- Line: 52, Name: Emit
                for _, descendant in ipairs(p9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u10 = descendant:GetAttribute("EmitDelay") or 0;
                        local u11 = descendant:GetAttribute("EmitCount") or 1;
                        local u12 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 58
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
            end)(workspace.VFX.CutsceneVFX.SaeTele);
        end },
    { 272, function() -- Line: 76
            (function(p13) -- Line: 77, Name: Emit
                for _, descendant in ipairs(p13:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u14 = descendant:GetAttribute("EmitDelay") or 0;
                        local u15 = descendant:GetAttribute("EmitCount") or 1;
                        local u16 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 83
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
            end)(workspace.VFX.CutsceneVFX.Slash1);
        end },
    { 302, function() -- Line: 101
            (function(p17) -- Line: 102, Name: Emit
                for _, descendant in ipairs(p17:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u18 = descendant:GetAttribute("EmitDelay") or 0;
                        local u19 = descendant:GetAttribute("EmitCount") or 1;
                        local u20 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 108
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
            end)(workspace.VFX.CutsceneVFX.Slash2);
        end },
    { 411, function() -- Line: 126
            shared.vfx.emit(workspace.VFX.Meshes);
        end }
};

return function(u22) -- Line: 130
    -- upvalues: u21 (copy)
    task.spawn(function() -- Line: 131
        -- upvalues: u22 (copy), u21 (ref)
        local v23 = 0;

        while u22:IsPlaying() do
            local CurrentFrame = u22.CurrentFrame;

            for _, v in u21 do
                local v24 = v[1];
                local v25 = v[2];

                if v24 <= CurrentFrame and v23 < v24 then
                    task.spawn(v25);
                end;
            end;

            task.wait();
            v23 = CurrentFrame;
        end;
    end);
end;