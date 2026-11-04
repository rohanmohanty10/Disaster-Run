  

local u5 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 30, function() -- Line: 8
            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"].bunnysecretawkemit04:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 38, function() -- Line: 16
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 299, function() -- Line: 31
            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"].bunnysecretawkemit03:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 304, function() -- Line: 39
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 345, function() -- Line: 54
            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"].bunnysecretawkemit05:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            local v3 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v3 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 585, function() -- Line: 75
            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"].bunnysecretawkemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 588, function() -- Line: 83
            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"].bunnysecretawkcrowd:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 647, function() -- Line: 91
            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"].bunnysecretawkcrowd:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 648, function() -- Line: 99
            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Bunny Secret Awk VFX"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            local v4 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v4 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u6) -- Line: 126
    -- upvalues: u5 (copy)
    task.spawn(function() -- Line: 127
        -- upvalues: u6 (copy), u5 (ref)
        local v7 = 0;

        while u6:IsPlaying() do
            local CurrentFrame = u6.CurrentFrame;

            for _, v in u5 do
                local v8 = v[1];
                local v9 = v[2];

                if v8 <= CurrentFrame and v7 < v8 then
                    task.spawn(v9);
                end;
            end;

            task.wait();
            v7 = CurrentFrame;
        end;
    end);
end;