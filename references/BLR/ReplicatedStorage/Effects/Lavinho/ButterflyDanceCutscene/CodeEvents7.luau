  

local u1 = {
    { 0, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].ButterflyDancecamvfx1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].ButterflyDancecamvfx2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].ButterflyDancecamvfx1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].ButterflyDancecamvfx2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1, function() -- Line: 25
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 266, function() -- Line: 33
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 278, function() -- Line: 41
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 290, function() -- Line: 49
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 300, function() -- Line: 57
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 311, function() -- Line: 65
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 323, function() -- Line: 73
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 335, function() -- Line: 81
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 345, function() -- Line: 89
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 358, function() -- Line: 97
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 370, function() -- Line: 105
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 382, function() -- Line: 113
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 392, function() -- Line: 121
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemitwelded:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 422, function() -- Line: 129
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydancedirtemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 450, function() -- Line: 137
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end }
};

return function(u2) -- Line: 146
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 147
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