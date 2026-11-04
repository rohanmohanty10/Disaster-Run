  

local u33 = {
    { 1, function() -- Line: 1
            (function(p1) -- Line: 2, Name: Emit
                for _, descendant in ipairs(p1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
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
            end)(workspace.VFX.Step1);
        end },
    { 13, function() -- Line: 26
            (function(p5) -- Line: 27, Name: Emit
                for _, descendant in ipairs(p5:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
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
            end)(workspace.VFX.Step2);
        end },
    { 28, function() -- Line: 51
            (function(p9) -- Line: 52, Name: Emit
                for _, descendant in ipairs(p9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
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
            end)(workspace.VFX.Step3);
        end },
    { 41, function() -- Line: 76
            (function(p13) -- Line: 77, Name: Emit
                for _, descendant in ipairs(p13:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
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
            end)(workspace.VFX.Step4);
        end },
    { 78, function() -- Line: 101
            (function(p17) -- Line: 102, Name: Emit
                for _, descendant in ipairs(p17:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
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
            end)(workspace.VFX.Step5);
        end },
    { 408, function() -- Line: 126
            (function(p21) -- Line: 127, Name: Emit
                for _, descendant in ipairs(p21:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u22 = descendant:GetAttribute("EmitDelay") or 0;
                        local u23 = descendant:GetAttribute("EmitCount") or 1;
                        local u24 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 133
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
            end)(workspace.VFX.PuzzleEmit1);
        end },
    { 454, function() -- Line: 151
            (function(p25) -- Line: 152, Name: Emit
                for _, descendant in ipairs(p25:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u26 = descendant:GetAttribute("EmitDelay") or 0;
                        local u27 = descendant:GetAttribute("EmitCount") or 1;
                        local u28 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 158
                            -- upvalues: u26 (copy), descendant (copy), u27 (copy), u28 (copy)
                            task.wait(u26);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u27);
                            end;

                            if u28 > 0 then
                                descendant.Enabled = true;
                                task.wait(u28);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.Step6);
        end },
    { 528, function() -- Line: 176
            (function(p29) -- Line: 177, Name: Emit
                for _, descendant in ipairs(p29:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u30 = descendant:GetAttribute("EmitDelay") or 0;
                        local u31 = descendant:GetAttribute("EmitCount") or 1;
                        local u32 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 183
                            -- upvalues: u30 (copy), descendant (copy), u31 (copy), u32 (copy)
                            task.wait(u30);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u31);
                            end;

                            if u32 > 0 then
                                descendant.Enabled = true;
                                task.wait(u32);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.JumpEmit);
        end },
    { 531, function() -- Line: 201
            shared.vfx.emit(workspace.VFX.swirl);
        end },
    { 589, function() -- Line: 204
            game:GetService("Workspace");
            shared.vfx.emit(workspace.VFX.RushBeam);
        end },
    { 591, function() -- Line: 209
            shared.vfx.emit(workspace.VFX["golden deagle L"]["Left Gun"], workspace.VFX["golden deagle R"]["Right Gun"]);
        end },
    { 594, function() -- Line: 212
            game:GetService("Workspace");
            shared.vfx.emit(workspace.VFX.Cast);
        end },
    { 664, function() -- Line: 217
            game:GetService("Workspace");
            shared.vfx.emit(workspace.VFX.Rush);
        end }
};

return function(u34) -- Line: 223
    -- upvalues: u33 (copy)
    task.spawn(function() -- Line: 224
        -- upvalues: u34 (copy), u33 (ref)
        local v35 = 0;

        while u34:IsPlaying() do
            local CurrentFrame = u34.CurrentFrame;

            for _, v in u33 do
                local v36 = v[1];
                local v37 = v[2];

                if v36 <= CurrentFrame and v35 < v36 then
                    task.spawn(v37);
                end;
            end;

            task.wait();
            v35 = CurrentFrame;
        end;
    end);
end;