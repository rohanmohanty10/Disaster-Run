  

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
    { 12, function() -- Line: 14
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
    { 38, function() -- Line: 30
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1step3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 53, function() -- Line: 38
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
    { 54, function() -- Line: 51
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
    { 55, function() -- Line: 64
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1enabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 62, function() -- Line: 72
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1enabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 71, function() -- Line: 80
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1enabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 78, function() -- Line: 88
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
    { 115, function() -- Line: 104
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1emit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 335, function() -- Line: 112
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
        end },
    { 336, function() -- Line: 125
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
    { 404, function() -- Line: 138
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1emit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 454, function() -- Line: 146
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1step5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 455, function() -- Line: 154
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1emit4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 684, function() -- Line: 162
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1step7:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 721, function() -- Line: 170
            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1emit3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Charles V1 VFX"].charlesv1step6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 808, function() -- Line: 184
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
        end }
};

return function(u2) -- Line: 198
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 199
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