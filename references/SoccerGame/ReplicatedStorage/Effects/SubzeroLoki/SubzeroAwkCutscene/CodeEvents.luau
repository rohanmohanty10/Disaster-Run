  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].lockedtoplayer:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].tunnel:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].lockedtocam:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].lockedtocam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["bc flat speedlines"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 56, function() -- Line: 31
            shared.vfx.emit(workspace.VFX["Loki Awk VFX"].lokiemit1);
        end },
    { 88, function() -- Line: 34
            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].lockedtoplayer:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 199, function() -- Line: 42
            shared.vfx.emit(workspace.VFX["Loki Awk VFX"].lokiemit2);
        end },
    { 236, function() -- Line: 45
            shared.vfx.emit(workspace.VFX["Loki Awk VFX"].lokiemit2);
        end },
    { 258, function() -- Line: 48
            shared.vfx.emit(workspace.VFX["Loki Awk VFX"].lokiemit3);
        end },
    { 393, function() -- Line: 51
            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].lockedtoplayer:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].tunnel:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].lockedtocam:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Loki Awk VFX"].lockedtocam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["bc flat speedlines"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 82
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 83
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