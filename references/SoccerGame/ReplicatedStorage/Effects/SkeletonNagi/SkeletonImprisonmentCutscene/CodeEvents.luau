  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonprisoncamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonprisoncamVFX2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonprisoncamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonprisoncamVFX2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 11, function() -- Line: 25
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentemit1);
        end },
    { 112, function() -- Line: 28
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentdemit1);
        end },
    { 127, function() -- Line: 31
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"]:FindFirstChild("skeletonimprisonmentdemit2"));
        end },
    { 399, function() -- Line: 34
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentemit2);
        end },
    { 466, function() -- Line: 37
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentemit3);
        end },
    { 555, function() -- Line: 40
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentshotemit1);
        end },
    { 598, function() -- Line: 43
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentshotemit2);
        end },
    { 609, function() -- Line: 46
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentshotemit3);
        end },
    { 622, function() -- Line: 49
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentshotemit4);
        end },
    { 633, function() -- Line: 52
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentshotemit5);
        end },
    { 755, function() -- Line: 55
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentdemit3);
        end },
    { 902, function() -- Line: 58
            shared.vfx.emit(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonimprisonmentshotemit6);
        end },
    { 991, function() -- Line: 61
            for _, descendant in pairs(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonprisoncamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonprisoncamVFX2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonprisoncamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Skeleton Nagi Prison VFX"].skeletonprisoncamVFX2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 86
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 87
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