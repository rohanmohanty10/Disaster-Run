  

local u1 = {
    { 0, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlescameffects:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlescameffects:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 5, function() -- Line: 14
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbstep05:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 8, function() -- Line: 22
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbstep06:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 19, function() -- Line: 30
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbstep07:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 25, function() -- Line: 38
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbstep1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 46, function() -- Line: 46
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbsemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 85, function() -- Line: 54
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbstep08:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 101, function() -- Line: 62
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbsemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 138, function() -- Line: 70
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].cameffectSpeedlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 157, function() -- Line: 78
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].cameffectSpeedlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 281, function() -- Line: 86
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbsemit3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 322, function() -- Line: 94
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].cameffectSpeedlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 328, function() -- Line: 102
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlescameffects:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlescameffects:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 329, function() -- Line: 115
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlescameffects2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlescameffects2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 330, function() -- Line: 128
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].cameffectSpeedlines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 331, function() -- Line: 136
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlesfbsemit4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 500, function() -- Line: 144
            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlescameffects2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles Final Boss VFX"].charlescameffects2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 158
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 159
        -- upvalues: u2 (copy), u1 (ref)
        local v3 = 0;

        while u2:IsPlaying() do
            local CurrentFrame = u2.CurrentFrame;

            for _, v in u1 do
                local v4 = v[1];
                local v5 = v[2];

                if v4 <= CurrentFrame and v3 < v4 then
                    task.spawn(v5);
                end;
            end;

            task.wait();
            v3 = CurrentFrame;
        end;
    end);
end;