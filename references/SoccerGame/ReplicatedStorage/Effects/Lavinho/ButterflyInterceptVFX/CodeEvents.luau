  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretwings:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecreawkcamvfx1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecreawkcamvfx2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecreawkcamvfx1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecreawkcamvfx2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 68, function() -- Line: 31
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretawkemit04:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 141, function() -- Line: 39
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretwings:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 142, function() -- Line: 46
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretwings:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 143, function() -- Line: 54
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretawkemit05:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 213, function() -- Line: 62
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretawkemit06:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 246, function() -- Line: 70
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretawkemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 275, function() -- Line: 78
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretawkemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 440, function() -- Line: 86
            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecreawkcamvfx1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecreawkcamvfx2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecreawkcamvfx1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecreawkcamvfx2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Secret Awk VFX"].lavinhoawksecretwings:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 116
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 117
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