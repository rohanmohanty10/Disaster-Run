  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkcam1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkcam1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkatmosphere:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 10, function() -- Line: 20
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkstep1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 28, function() -- Line: 28
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkstep2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 100, function() -- Line: 36
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkcam1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkcam1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 101, function() -- Line: 49
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkcam2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkcam2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 167, function() -- Line: 62
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkchainedemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 242, function() -- Line: 70
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeauraenabledstart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 390, function() -- Line: 78
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeauraenabledstart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 663, function() -- Line: 110
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeauraenabledmain:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 665, function() -- Line: 126
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeemittransitio0n:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 789, function() -- Line: 134
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeauraenabled:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeauraenabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 790, function() -- Line: 148
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeauraenabledmain:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 909, function() -- Line: 156
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeauraenabled:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawksaeauraenabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1001, function() -- Line: 170
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkendemit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1030, function() -- Line: 178
            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkcam2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkcam2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Awk VFX"].shidouawkatmosphere:GetDescendants()) do
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