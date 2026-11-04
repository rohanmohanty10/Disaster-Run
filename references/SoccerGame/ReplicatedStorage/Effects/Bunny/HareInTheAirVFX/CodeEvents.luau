  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheaircamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheaircamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 63, function() -- Line: 14
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheairemit05:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 88, function() -- Line: 22
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheairemit06:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 114, function() -- Line: 30
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheairemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 151, function() -- Line: 38
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheairemit07:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 180, function() -- Line: 46
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheairatmosphereemit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 191, function() -- Line: 54
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheairgoal:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 376, function() -- Line: 62
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheairemit08:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 480, function() -- Line: 70
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheairemit09:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 534, function() -- Line: 78
            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheaircamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Hare In The Air VFX"].hareintheaircamvfx:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 92
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 93
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