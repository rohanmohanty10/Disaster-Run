  

local u3 = {
    { 1, function() -- Line: 2
            for _, descendant in pairs(workspace.VFX["Bloodmoon Orbit VFX"].bloodmoonorbitaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bloodmoon Orbit VFX"].rinbocamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bloodmoon Orbit VFX"].rinbocamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 468, function() -- Line: 34
            shared.vfx.emit(workspace.VFX["Bloodmoon Orbit VFX"].bloodmoonorbitemit1);
        end },
    { 546, function() -- Line: 37
            shared.vfx.emit(workspace.VFX["Bloodmoon Orbit VFX"].bloodmoonorbitemit2);
        end },
    { 562, function() -- Line: 40
            shared.vfx.emit(workspace.VFX["Bloodmoon Orbit VFX"].bloodmoonorbitemit3);
        end },
    { 645, function() -- Line: 43
            shared.vfx.emit(workspace.VFX["Bloodmoon Orbit VFX"].bloodmoonorbitemit4);
        end },
    { 875, function() -- Line: 46
            shared.vfx.emit(workspace.VFX["Bloodmoon Orbit VFX"].bloodmoonorbitemit5);
        end },
    { 907, function() -- Line: 49
            shared.vfx.emit(workspace.VFX["Bloodmoon Orbit VFX"].bloodmoonorbitemit6);
        end },
    { 979, function() -- Line: 52
            for _, descendant in pairs(workspace.VFX["Bloodmoon Orbit VFX"].bloodmoonorbitaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 980, function() -- Line: 60
            for _, descendant in pairs(workspace.VFX["Bloodmoon Orbit VFX"].rinbocamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bloodmoon Orbit VFX"].rinbocamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u4) -- Line: 87
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 88
        -- upvalues: u4 (copy), u3 (ref)
        local v5 = 0;

        while u4:IsPlaying() do
            local CurrentFrame = u4.CurrentFrame;

            for _, v in u3 do
                local v6 = v[1];
                local v7 = v[2];

                if v6 <= CurrentFrame and v5 < v6 then
                    task.spawn(v7);
                end;
            end;

            task.wait();
            v5 = CurrentFrame;
        end;
    end);
end;