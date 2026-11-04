  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionawkcamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 98, function() -- Line: 14
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionshotemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 269, function() -- Line: 22
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionshotscytheemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 279, function() -- Line: 30
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionshotscytheenable2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 337, function() -- Line: 38
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionshotscytheenable3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 365, function() -- Line: 46
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionshotemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 366, function() -- Line: 54
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionshotscytheenable3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 399, function() -- Line: 62
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionshotscytheenable2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 400, function() -- Line: 70
            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Reaper Sae Execution Shot VFX"].executionawkcamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 84
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 85
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