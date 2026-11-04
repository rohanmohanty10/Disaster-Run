  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Clause Clash VFX"].snow1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Clause Clash VFX"].lockedtocam:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Clause Clash VFX"].lockedtocam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 4, function() -- Line: 20
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit1);
        end },
    { 25, function() -- Line: 23
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit1);
        end },
    { 48, function() -- Line: 26
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit1);
        end },
    { 374, function() -- Line: 29
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit3);
        end },
    { 387, function() -- Line: 32
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit2);
        end },
    { 399, function() -- Line: 35
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit4);
        end },
    { 420, function() -- Line: 38
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit5);
        end },
    { 483, function() -- Line: 41
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit6);
        end },
    { 549, function() -- Line: 44
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit6);
        end },
    { 616, function() -- Line: 47
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit7);
        end },
    { 740, function() -- Line: 50
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit8);
        end },
    { 849, function() -- Line: 53
            shared.vfx.emit(workspace.VFX["Clause Clash VFX"].lavinhoemit9);
        end },
    { 883, function() -- Line: 56
            for _, descendant in pairs(workspace.VFX["Clause Clash VFX"].snow1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Clause Clash VFX"].lockedtocam:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Clause Clash VFX"].lockedtocam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 76
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 77
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