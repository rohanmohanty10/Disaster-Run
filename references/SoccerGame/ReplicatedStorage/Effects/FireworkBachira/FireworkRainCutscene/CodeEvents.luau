  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Bachira Firework Rain VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bachira Firework Rain VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 103, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["Bachira Firework Rain VFX"].fireworklaunchVFX);
        end },
    { 157, function() -- Line: 17
            shared.vfx.emit(workspace.VFX["Bachira Firework Rain VFX"].fireworklaunchVFX);
        end },
    { 800, function() -- Line: 20
            shared.vfx.emit(workspace.VFX["Bachira Firework Rain VFX"].vfxemit1);
        end },
    { 801, function() -- Line: 23
            shared.vfx.emit(workspace.VFX["Bachira Firework Rain VFX"].fireworkrainvfx1);
        end },
    { 851, function() -- Line: 26
            shared.vfx.emit(workspace.VFX["Bachira Firework Rain VFX"].fireworkrainvfx1);
        end },
    { 894, function() -- Line: 29
            shared.vfx.emit(workspace.VFX["Bachira Firework Rain VFX"].fireworkrainvfx1);
        end },
    { 1090, function() -- Line: 32
            for _, descendant in pairs(workspace.VFX["Bachira Firework Rain VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bachira Firework Rain VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 46
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 47
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