  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Krampus Barou Awk VFX"].krampusflooraura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 618, function() -- Line: 9
            shared.vfx.emit(workspace.VFX["Krampus Barou Awk VFX"].krampusawkemit2);
        end },
    { 669, function() -- Line: 12
            shared.vfx.emit(workspace.VFX["Krampus Barou Awk VFX"].krampusawkemit);

            for _, descendant in pairs(workspace.VFX["Krampus Barou Awk VFX"].krampusaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 918, function() -- Line: 21
            shared.vfx.emit(workspace.VFX["Krampus Barou Awk VFX"].krampusawkemit3);
        end },
    { 1030, function() -- Line: 24
            shared.vfx.emit(workspace.VFX["Krampus Barou Awk VFX"].krampusawkemit3);
        end },
    { 1095, function() -- Line: 27
            shared.vfx.emit(workspace.VFX["Krampus Barou Awk VFX"].krampusawkemit4);
        end },
    { 1218, function() -- Line: 30
            for _, descendant in pairs(workspace.VFX["Krampus Barou Awk VFX"].krampusaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Krampus Barou Awk VFX"].krampusflooraura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 45
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 46
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