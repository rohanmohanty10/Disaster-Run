  

local u1 = {
    { 0, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlescameffectvar2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlescameffectvar2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 11, function() -- Line: 14
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1step1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 25, function() -- Line: 22
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1step2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 37, function() -- Line: 30
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1step3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 52, function() -- Line: 38
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1enabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 53, function() -- Line: 46
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlescameffectvar2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlescameffectvar2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 54, function() -- Line: 59
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlescameffectvar1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlescameffectvar1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 59, function() -- Line: 72
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1enabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 80, function() -- Line: 80
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1enabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 81, function() -- Line: 88
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1enabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 105, function() -- Line: 96
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1step4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 114, function() -- Line: 104
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1emit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 407, function() -- Line: 112
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlestauntemit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 505, function() -- Line: 120
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlescameffectvar1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlescameffectvar1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 134
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 135
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