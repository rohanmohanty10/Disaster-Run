  

local u1 = {
    { 386, function() -- Line: 4
            shared.vfx.emit(workspace["Charles & Loki Chemical Reaction VFX"].charlesemit1);
        end },
    { 486, function() -- Line: 10
            shared.vfx.emit(workspace["Charles & Loki Chemical Reaction VFX"].charlesemit2);
        end },
    { 661, function() -- Line: 16
            shared.vfx.emit(workspace["Charles & Loki Chemical Reaction VFX"].lokiemit1);
        end },
    { 662, function() -- Line: 22
            for _, descendant in pairs(workspace["Charles & Loki Chemical Reaction VFX"].lockedtoplayer:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 793, function() -- Line: 33
            for _, descendant in pairs(workspace["Charles & Loki Chemical Reaction VFX"].lockedtoplayer:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 840, function() -- Line: 43
            shared.vfx.emit(workspace["Charles & Loki Chemical Reaction VFX"].lokiemit2);
        end },
    { 909, function() -- Line: 49
            shared.vfx.emit(workspace["Charles & Loki Chemical Reaction VFX"].lokiemit3);
        end },
    { 1193, function() -- Line: 55
            shared.vfx.emit(workspace["Charles & Loki Chemical Reaction VFX"].lokiemit4);
        end },
    { 1255, function() -- Line: 61
            shared.vfx.emit(workspace["Charles & Loki Chemical Reaction VFX"].lokiemit5);
        end },
    { 1270, function() -- Line: 67
            for _, descendant in pairs(workspace["Charles & Loki Chemical Reaction VFX"].lockedtoplayer:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1334, function() -- Line: 77
            for _, descendant in pairs(workspace["Charles & Loki Chemical Reaction VFX"].lockedtoplayer:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 88
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 89
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