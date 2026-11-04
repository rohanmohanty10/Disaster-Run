  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearancestep1);

            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.CamVFX.Camera_Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1, function() -- Line: 10
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.CamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 13, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearancestep2);
        end },
    { 160, function() -- Line: 20
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.CamVFX.Camera_Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 165, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearancebgemit2);
        end },
    { 170, function() -- Line: 31
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearancebgemit2);
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.AikuClearanceScopeEmit2);
        end },
    { 337, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearanceemit2);
        end },
    { 397, function() -- Line: 38
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearancebgemit);
        end },
    { 398, function() -- Line: 41
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearanceemit1);
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.AikuClearanceScope);
        end },
    { 399, function() -- Line: 45
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.CamVFX.Scope);
        end },
    { 400, function() -- Line: 48
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 402, function() -- Line: 55
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 404, function() -- Line: 62
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 406, function() -- Line: 69
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 408, function() -- Line: 76
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 410, function() -- Line: 83
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 412, function() -- Line: 90
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 414, function() -- Line: 97
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 416, function() -- Line: 104
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 418, function() -- Line: 111
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 420, function() -- Line: 118
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 422, function() -- Line: 125
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 424, function() -- Line: 132
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 426, function() -- Line: 139
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 428, function() -- Line: 146
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 430, function() -- Line: 153
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 432, function() -- Line: 160
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 434, function() -- Line: 167
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 444, function() -- Line: 174
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 513, function() -- Line: 181
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.CamVFX.Camera_Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 520, function() -- Line: 189
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.AikuClearanceScope:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 680, function() -- Line: 196
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearenceemit3);
        end },
    { 789, function() -- Line: 199
            shared.vfx.emit(workspace.VFX.AikuClearanceVFX.aikuclearanceemit4);
        end },
    { 880, function() -- Line: 202
            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.CamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX.AikuClearanceVFX.CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 216
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 217
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