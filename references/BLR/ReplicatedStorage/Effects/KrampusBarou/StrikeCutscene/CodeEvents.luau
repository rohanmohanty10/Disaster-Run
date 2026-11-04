  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].CamVFX1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].CamVFX1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1, function() -- Line: 14
            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].krampusstrikeaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 420, function() -- Line: 22
            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].krampusstrikeaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 425, function() -- Line: 30
            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].CamVFX1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].CamVFX1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 426, function() -- Line: 43
            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].CamVFX2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].CamVFX2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 494, function() -- Line: 56
            shared.vfx.emit(workspace.VFX["Krampus Strike VFX"].krampusstrikeemit1);
        end },
    { 519, function() -- Line: 59
            shared.vfx.emit(workspace.VFX["Krampus Strike VFX"].krampusstrikeemit1);
        end },
    { 702, function() -- Line: 62
            shared.vfx.emit(workspace.VFX["Krampus Strike VFX"].krampusstrikeemit2);
        end },
    { 738, function() -- Line: 65
            shared.vfx.emit(workspace.VFX["Krampus Strike VFX"].krampusstrikeemit3);
        end },
    { 778, function() -- Line: 68
            shared.vfx.emit(workspace.VFX["Krampus Strike VFX"].krampusstrikeemit3);
        end },
    { 852, function() -- Line: 71
            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].CamVFX2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Krampus Strike VFX"].CamVFX2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 85
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 86
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