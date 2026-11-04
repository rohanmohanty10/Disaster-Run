  

local u62 = {
    { 98, function() -- Line: 1
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
            end)(workspace.VFX.CutsceneVFX.Bow);
        end },
    { 108, function() -- Line: 25
            (function(p5) -- Line: 26, Name: Emit
                for _, descendant in ipairs(p5:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u6 = descendant:GetAttribute("EmitDelay") or 0;
                        local u7 = descendant:GetAttribute("EmitCount") or 1;
                        local u8 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 32
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
            end)(workspace.VFX.CutsceneVFX.Items);
        end },
    { 156, function() -- Line: 49
            (function(p9) -- Line: 50, Name: Emit
                for _, descendant in ipairs(p9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u10 = descendant:GetAttribute("EmitDelay") or 0;
                        local u11 = descendant:GetAttribute("EmitCount") or 1;
                        local u12 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 56
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
            end)(workspace.VFX.CutsceneVFX.CamTrans);
        end },
    { 226, function() -- Line: 73
            (function(p13) -- Line: 74, Name: Emit
                for _, descendant in ipairs(p13:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u14 = descendant:GetAttribute("EmitDelay") or 0;
                        local u15 = descendant:GetAttribute("EmitCount") or 1;
                        local u16 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 80
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
            end)(workspace.VFX.CutsceneVFX.CamTrans2);
        end },
    { 260, function() -- Line: 97
            local function Emit(p17) -- Line: 98
                for _, descendant in ipairs(p17:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u18 = descendant:GetAttribute("EmitDelay") or 0;
                        local u19 = descendant:GetAttribute("EmitCount") or 1;
                        local u20 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 104
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
            end;

            Emit(workspace.VFX.CutsceneVFX.Flick);
            Emit(workspace.VFX.CutsceneVFX.CamLines);
        end },
    { 288, function() -- Line: 124
            (function(p21) -- Line: 125, Name: Emit
                for _, descendant in ipairs(p21:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u22 = descendant:GetAttribute("EmitDelay") or 0;
                        local u23 = descendant:GetAttribute("EmitCount") or 1;
                        local u24 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 131
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
            end)(workspace.VFX.CutsceneVFX.Spin1);
        end },
    { 303, function() -- Line: 148
            (function(p25) -- Line: 149, Name: Emit
                for _, descendant in ipairs(p25:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u26 = descendant:GetAttribute("EmitDelay") or 0;
                        local u27 = descendant:GetAttribute("EmitCount") or 1;
                        local u28 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 155
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
            end)(workspace.VFX.CutsceneVFX.Spin1);
        end },
    { 324, function() -- Line: 172
            (function(p29) -- Line: 173, Name: Emit
                for _, descendant in ipairs(p29:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u30 = descendant:GetAttribute("EmitDelay") or 0;
                        local u31 = descendant:GetAttribute("EmitCount") or 1;
                        local u32 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 179
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
            end)(workspace.VFX.CutsceneVFX.Spin1);
        end },
    { 364, function() -- Line: 196
            (function(p33) -- Line: 197, Name: Emit
                for _, descendant in ipairs(p33:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u34 = descendant:GetAttribute("EmitDelay") or 0;
                        local u35 = descendant:GetAttribute("EmitCount") or 1;
                        local u36 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 203
                            -- upvalues: u34 (copy), descendant (copy), u35 (copy), u36 (copy)
                            task.wait(u34);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u35);
                            end;

                            if u36 > 0 then
                                descendant.Enabled = true;
                                task.wait(u36);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.End);
        end },
    { 383, function() -- Line: 220
            local function v41(p37) -- Line: 221
                for _, descendant in ipairs(p37:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u38 = descendant:GetAttribute("EmitDelay") or 0;
                        local u39 = descendant:GetAttribute("EmitCount") or 1;
                        local u40 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 227
                            -- upvalues: u38 (copy), descendant (copy), u39 (copy), u40 (copy)
                            task.wait(u38);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u39);
                            end;

                            if u40 > 0 then
                                descendant.Enabled = true;
                                task.wait(u40);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end;

            v41(workspace.VFX.CutsceneVFX.CamTrans3);
            v41(workspace.VFX.CutsceneVFX.CamLines2);
        end },
    { 452, function() -- Line: 246
            (function(p42) -- Line: 247, Name: Emit
                for _, descendant in ipairs(p42:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u43 = descendant:GetAttribute("EmitDelay") or 0;
                        local u44 = descendant:GetAttribute("EmitCount") or 1;
                        local u45 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 253
                            -- upvalues: u43 (copy), descendant (copy), u44 (copy), u45 (copy)
                            task.wait(u43);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u44);
                            end;

                            if u45 > 0 then
                                descendant.Enabled = true;
                                task.wait(u45);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.D1);
        end },
    { 453, function() -- Line: 270
            (function(p46) -- Line: 271, Name: Emit
                for _, descendant in ipairs(p46:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u47 = descendant:GetAttribute("EmitDelay") or 0;
                        local u48 = descendant:GetAttribute("EmitCount") or 1;
                        local u49 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 277
                            -- upvalues: u47 (copy), descendant (copy), u48 (copy), u49 (copy)
                            task.wait(u47);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u48);
                            end;

                            if u49 > 0 then
                                descendant.Enabled = true;
                                task.wait(u49);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Items);
        end },
    { 484, function() -- Line: 294
            (function(p50) -- Line: 295, Name: Emit
                for _, descendant in ipairs(p50:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u51 = descendant:GetAttribute("EmitDelay") or 0;
                        local u52 = descendant:GetAttribute("EmitCount") or 1;
                        local u53 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 301
                            -- upvalues: u51 (copy), descendant (copy), u52 (copy), u53 (copy)
                            task.wait(u51);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u52);
                            end;

                            if u53 > 0 then
                                descendant.Enabled = true;
                                task.wait(u53);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.D2);
        end },
    { 524, function() -- Line: 318
            (function(p54) -- Line: 319, Name: Emit
                for _, descendant in ipairs(p54:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u55 = descendant:GetAttribute("EmitDelay") or 0;
                        local u56 = descendant:GetAttribute("EmitCount") or 1;
                        local u57 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 325
                            -- upvalues: u55 (copy), descendant (copy), u56 (copy), u57 (copy)
                            task.wait(u55);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u56);
                            end;

                            if u57 > 0 then
                                descendant.Enabled = true;
                                task.wait(u57);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Items);
        end },
    { 602, function() -- Line: 342
            (function(p58) -- Line: 343, Name: Emit
                for _, descendant in ipairs(p58:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u59 = descendant:GetAttribute("EmitDelay") or 0;
                        local u60 = descendant:GetAttribute("EmitCount") or 1;
                        local u61 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 349
                            -- upvalues: u59 (copy), descendant (copy), u60 (copy), u61 (copy)
                            task.wait(u59);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u60);
                            end;

                            if u61 > 0 then
                                descendant.Enabled = true;
                                task.wait(u61);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Items);
        end }
};

return function(u63) -- Line: 367
    -- upvalues: u62 (copy)
    task.spawn(function() -- Line: 368
        -- upvalues: u63 (copy), u62 (ref)
        local v64 = 0;

        while u63:IsPlaying() do
            local CurrentFrame = u63.CurrentFrame;

            for _, v in u62 do
                local v65 = v[1];
                local v66 = v[2];

                if v65 <= CurrentFrame and v64 < v65 then
                    task.spawn(v66);
                end;
            end;

            task.wait();
            v64 = CurrentFrame;
        end;
    end);
end;