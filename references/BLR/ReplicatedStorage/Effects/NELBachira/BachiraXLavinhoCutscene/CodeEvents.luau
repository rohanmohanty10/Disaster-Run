  

local u3 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Bachira Chem VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bachira Chem VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep1);
        end },
    { 76, function() -- Line: 17
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep2);
        end },
    { 341, function() -- Line: 20
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].defenderstep1);
        end },
    { 354, function() -- Line: 23
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].defenderstep2);
        end },
    { 376, function() -- Line: 26
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].defenderstep3);
        end },
    { 412, function() -- Line: 29
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].defenderstep4);
        end },
    { 431, function() -- Line: 32
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].defenderstep5);
        end },
    { 462, function() -- Line: 35
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].lavinhcatchemit4);
        end },
    { 519, function() -- Line: 38
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].lavinhcatchemit);
        end },
    { 644, function() -- Line: 41
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].lavinhoenablemit);
        end },
    { 734, function() -- Line: 44
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep3);
        end },
    { 770, function() -- Line: 47
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep4);
        end },
    { 825, function() -- Line: 50
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].lavinhostartupemit1);
        end },
    { 891, function() -- Line: 53
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].lavinhcatchemit2);
        end },
    { 921, function() -- Line: 56
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].lavinhcatchemit3);
        end },
    { 934, function() -- Line: 59
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep5);
        end },
    { 947, function() -- Line: 62
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracatchemit);
        end },
    { 973, function() -- Line: 65
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachirastartupemit);
        end },
    { 974, function() -- Line: 68
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
    { 978, function() -- Line: 84
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep6);
        end },
    { 985, function() -- Line: 87
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep7);
        end },
    { 995, function() -- Line: 90
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep8);
        end },
    { 1012, function() -- Line: 93
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep9);
        end },
    { 1019, function() -- Line: 96
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].defenderstep6);
        end },
    { 1093, function() -- Line: 99
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep10);
        end },
    { 1113, function() -- Line: 102
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep11);
        end },
    { 1119, function() -- Line: 105
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracembasicstep12);
        end },
    { 1162, function() -- Line: 108
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracatchemit2);
        end },
    { 1190, function() -- Line: 111
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracatchemit3);
        end },
    { 1215, function() -- Line: 114
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracatchemit4);
        end },
    { 1295, function() -- Line: 117
            shared.vfx.emit(workspace.VFX["Bachira Chem VFX"].bachiracatchemit5);
        end },
    { 1320, function() -- Line: 120
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

            for _, descendant in pairs(workspace.VFX["Bachira Chem VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bachira Chem VFX"].CamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u4) -- Line: 147
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 148
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