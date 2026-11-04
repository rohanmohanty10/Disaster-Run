  

local u1 = {
    { 1, function() -- Line: 1
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
    { 215, function() -- Line: 25
            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydancewings:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydancewings:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Lavinho Butterfly Dance VFX"].butterflydanceemit9:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end }
};

return function(u2) -- Line: 45
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 46
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