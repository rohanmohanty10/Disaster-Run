  

local u1 = {
    { 1, function() -- Line: 1
            local CamPart = workspace:FindFirstChild("VFX").Cam.CamPart;

            for _, descendant in pairs(CamPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace:FindFirstChild("VFX").Cam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            local nagitapliftambience = workspace:FindFirstChild("VFX").nagitapliftambience;

            for _, descendant in pairs(nagitapliftambience:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            local nagitapliftglow = workspace:FindFirstChild("VFX").nagitapliftglow;

            for _, descendant in pairs(nagitapliftglow:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 268, function() -- Line: 26
            local nagitapliftemit = workspace:FindFirstChild("VFX").nagitapliftemit;

            for _, descendant in pairs(nagitapliftemit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 272, function() -- Line: 34
            local nagitapliftareavfx = workspace:FindFirstChild("VFX").nagitapliftareavfx;

            for _, descendant in pairs(nagitapliftareavfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 273, function() -- Line: 42
            local nagitapliftglow = workspace:FindFirstChild("VFX").nagitapliftglow;

            for _, descendant in pairs(nagitapliftglow:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.01;
                end;
            end;
        end },
    { 498, function() -- Line: 50
            local nagitapliftemit2 = workspace:FindFirstChild("VFX").nagitapliftemit2;

            for _, descendant in pairs(nagitapliftemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            local nagitapliftemit3 = workspace:FindFirstChild("VFX").nagitapliftemit3;

            for _, descendant in pairs(nagitapliftemit3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 594, function() -- Line: 64
            local nagitapliftemit5 = workspace:FindFirstChild("VFX").nagitapliftemit5;

            for _, descendant in pairs(nagitapliftemit5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            local nagitapliftemit52 = workspace:FindFirstChild("VFX").nagitapliftemit5;

            for _, descendant in pairs(nagitapliftemit52:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.5;
                end;
            end;
        end },
    { 844, function() -- Line: 78
            local CamPart = workspace:FindFirstChild("VFX").Cam.CamPart;

            for _, descendant in pairs(CamPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace:FindFirstChild("VFX").Cam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 854, function() -- Line: 91
            local nagitapliftambience = workspace:FindFirstChild("VFX").nagitapliftambience;

            for _, descendant in pairs(nagitapliftambience:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            local nagitapliftglow = workspace:FindFirstChild("VFX").nagitapliftglow;

            for _, descendant in pairs(nagitapliftglow:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            local nagitapliftglow2 = workspace:FindFirstChild("VFX").nagitapliftglow;

            for _, descendant in pairs(nagitapliftglow2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end },
    { 871, function() -- Line: 111
            local nagitapliftenabled2 = workspace:FindFirstChild("VFX").nagitapliftenabled2;

            for _, descendant in pairs(nagitapliftenabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 877, function() -- Line: 119
            local nagitapliftemit6 = workspace:FindFirstChild("VFX").nagitapliftemit6;

            for _, descendant in pairs(nagitapliftemit6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 901, function() -- Line: 127
            local nagitapliftenabled1 = workspace:FindFirstChild("VFX").nagitapliftenabled1;

            for _, descendant in pairs(nagitapliftenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 902, function() -- Line: 135
            local nagitapliftemit4 = workspace:FindFirstChild("VFX").nagitapliftemit4;

            for _, descendant in pairs(nagitapliftemit4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 908, function() -- Line: 143
            local nagitapliftenabled2 = workspace:FindFirstChild("VFX").nagitapliftenabled2;

            for _, descendant in pairs(nagitapliftenabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 939, function() -- Line: 151
            local nagitapliftemit5 = workspace:FindFirstChild("VFX").nagitapliftemit5;

            for _, descendant in pairs(nagitapliftemit5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end },
    { 1004, function() -- Line: 159
            local nagitapliftenabled1 = workspace:FindFirstChild("VFX").nagitapliftenabled1;

            for _, descendant in pairs(nagitapliftenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 168
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 169
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