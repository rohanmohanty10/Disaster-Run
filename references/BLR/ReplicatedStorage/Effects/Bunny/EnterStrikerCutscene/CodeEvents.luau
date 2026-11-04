  

local u3 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerdirtemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerawkcamvfx1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerawkcamvfx1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 16, function() -- Line: 20
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerdirtemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 31, function() -- Line: 28
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerdirtemit3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 57, function() -- Line: 36
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerdirtemit4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 78, function() -- Line: 44
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerdirtemit5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 109, function() -- Line: 52
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerdirtemit6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 157, function() -- Line: 60
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikeranalyzeemit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 183, function() -- Line: 68
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
    { 414, function() -- Line: 83
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
        end },
    { 470, function() -- Line: 98
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikeremit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 471, function() -- Line: 106
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerdashenable:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 535, function() -- Line: 114
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikeremit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 536, function() -- Line: 122
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerdashenable:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 544, function() -- Line: 130
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikeranalyzeemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 580, function() -- Line: 138
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikeremit3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 625, function() -- Line: 146
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikeremit4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 675, function() -- Line: 154
            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerawkcamvfx1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Enter Striker VFX"].bunnyenterstrikerawkcamvfx1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u4) -- Line: 168
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 169
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