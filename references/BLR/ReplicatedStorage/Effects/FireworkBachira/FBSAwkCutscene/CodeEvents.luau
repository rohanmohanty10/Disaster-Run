  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Bachira Secret Awk "].lockedtocam:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bachira Secret Awk "].lockedtocam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 38, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["Bachira Secret Awk "].secretawkemit1);
        end },
    { 435, function() -- Line: 17
            shared.vfx.emit(workspace.VFX["Bachira Secret Awk "].secretawkemit2);
            shared.vfx.emit(workspace.VFX["Bachira Secret Awk "].secretawkemit3);
        end },
    { 784, function() -- Line: 21
            shared.vfx.emit(workspace.VFX["Bachira Secret Awk "].secretawkemit4);
            shared.vfx.emit(workspace.VFX["Bachira Secret Awk "].secretawkemit5);
        end },
    { 794, function() -- Line: 25
            shared.vfx.emit(workspace.VFX["Bachira Secret Awk "].secretawkfireworkblue);
            shared.vfx.emit(workspace.VFX["Bachira Secret Awk "].secretawkfireworkyello);
        end },
    { 900, function() -- Line: 29
            for _, descendant in pairs(workspace.VFX["Bachira Secret Awk "].lockedtocam:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bachira Secret Awk "].lockedtocam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 43
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 44
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