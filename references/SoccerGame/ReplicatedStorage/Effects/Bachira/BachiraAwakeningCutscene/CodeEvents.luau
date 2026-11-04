  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["NELBachira Awakening VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["NELBachira Awakening VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 6, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkbachirastomp);
        end },
    { 24, function() -- Line: 17
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkbachirastomp1);
        end },
    { 46, function() -- Line: 20
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkbachirastomp2);
        end },
    { 300, function() -- Line: 23
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkstomp);
        end },
    { 374, function() -- Line: 26
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkstomp2);
        end },
    { 432, function() -- Line: 29
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkstomp3);
        end },
    { 793, function() -- Line: 32
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkburst);
        end },
    { 914, function() -- Line: 35
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkbachirastomp3);
        end },
    { 928, function() -- Line: 38
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkbachirastomp4);
        end },
    { 944, function() -- Line: 41
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkbachirastomp5);
        end },
    { 1002, function() -- Line: 44
            shared.vfx.emit(workspace.VFX["NELBachira Awakening VFX"].awkstomp4);
        end },
    { 1100, function() -- Line: 47
            for _, descendant in pairs(workspace.VFX["NELBachira Awakening VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["NELBachira Awakening VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 61
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 62
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