  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["Pass The Ball VFX"].ptbemit1);
        end },
    { 1, function() -- Line: 4
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbbarouaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 2, function() -- Line: 12
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbisagiaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 3, function() -- Line: 20
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].isagicamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].baroucamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 4, function() -- Line: 34
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].baroucamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 211, function() -- Line: 41
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbbarouaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 264, function() -- Line: 49
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].baroucamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 265, function() -- Line: 56
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].isagicamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 450, function() -- Line: 63
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].isagicamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 451, function() -- Line: 70
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].baroucamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 452, function() -- Line: 77
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 486, function() -- Line: 85
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbisagiaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 497, function() -- Line: 93
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbisagiaura2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 560, function() -- Line: 101
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 578, function() -- Line: 109
            shared.vfx.emit(workspace.VFX["Pass The Ball VFX"].ptbbarouemit);
        end },
    { 601, function() -- Line: 112
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].baroucamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 602, function() -- Line: 119
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].isagicamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 651, function() -- Line: 126
            shared.vfx.emit(workspace.VFX["Pass The Ball VFX"].ptbemit2);
        end },
    { 822, function() -- Line: 129
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbenabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 847, function() -- Line: 137
            shared.vfx.emit(workspace.VFX["Pass The Ball VFX"].ptbemit4);
        end },
    { 848, function() -- Line: 140
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbenabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 918, function() -- Line: 148
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].isagicamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].baroucamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 919, function() -- Line: 162
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].ptbisagiaura2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 920, function() -- Line: 170
            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].isagicamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Pass The Ball VFX"].baroucamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 183
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 184
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