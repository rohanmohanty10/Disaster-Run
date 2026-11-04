  

local u13 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.Beams);
        end },
    { 255, function() -- Line: 5
            (function(p1) -- Line: 6, Name: Emit
                for _, descendant in ipairs(p1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u2 = descendant:GetAttribute("EmitDelay") or 0;
                        local u3 = descendant:GetAttribute("EmitCount") or 1;
                        local u4 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 12
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
            end)(workspace.VFX.FlashyGram);
        end },
    { 476, function() -- Line: 30
            (function(p5) -- Line: 31, Name: Emit
                for _, descendant in ipairs(p5:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u6 = descendant:GetAttribute("EmitDelay") or 0;
                        local u7 = descendant:GetAttribute("EmitCount") or 1;
                        local u8 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 37
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
            end)(workspace.VFX.Steal);
        end },
    { 477, function() -- Line: 56
            shared.vfx.emit(workspace.VFX.swirl);
        end },
    { 682, function() -- Line: 59
            (function(p9) -- Line: 60, Name: Emit
                for _, descendant in ipairs(p9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("Highlight"))))) then
                        local u10 = descendant:GetAttribute("EmitDelay") or 0;
                        local u11 = descendant:GetAttribute("EmitCount") or 1;
                        local u12 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 66
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
            end)(workspace.VFX.RUN);
        end }
};

return function(u14) -- Line: 86
    -- upvalues: u13 (copy)
    task.spawn(function() -- Line: 87
        -- upvalues: u14 (copy), u13 (ref)
        local v15 = 0;

        while u14:IsPlaying() do
            local CurrentFrame = u14.CurrentFrame;

            for _, v in u13 do
                local v16 = v[1];
                local v17 = v[2];

                if v16 <= CurrentFrame and v15 < v16 then
                    task.spawn(v17);
                end;
            end;

            task.wait();
            v15 = CurrentFrame;
        end;
    end);
end;