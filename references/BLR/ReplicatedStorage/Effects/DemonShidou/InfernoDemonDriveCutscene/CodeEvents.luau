  

local VfxManager = require(game.ReplicatedStorage.VfxManager);
local u1 = {
    { 1, function() -- Line: 3
            for _, descendant in pairs(workspace.VFX["Inferno Dragon Drive VFX"].infernodragondrivecamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Inferno Dragon Drive VFX"].infernodragondrivecamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 45, function() -- Line: 16
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Inferno Dragon Drive VFX"].shidouinfernodriveemit1);
        end },
    { 142, function() -- Line: 19
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Inferno Dragon Drive VFX"].shidouinfernodriveemit2);
        end },
    { 520, function() -- Line: 22
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Inferno Dragon Drive VFX"].shidouinfernodriveemit3);
        end },
    { 584, function() -- Line: 25
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Inferno Dragon Drive VFX"].shidouinfernodriveemit4);
        end },
    { 628, function() -- Line: 28
            for _, descendant in pairs(workspace.VFX["Inferno Dragon Drive VFX"].infernodragondrivecamVFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Inferno Dragon Drive VFX"].infernodragondrivecamVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 42
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 43
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