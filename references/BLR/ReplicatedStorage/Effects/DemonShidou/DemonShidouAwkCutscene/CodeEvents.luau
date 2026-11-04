  

local VfxManager = require(game.ReplicatedStorage.VfxManager);
local u1 = {
    { 1, function() -- Line: 3
            for _, descendant in pairs(workspace.VFX["Shidou Skin Awakening VFX"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Skin Awakening VFX"].shidouawkcamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 77, function() -- Line: 16
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Shidou Skin Awakening VFX"].shidouawkemitfinal);
            VfxManager.Emit(workspace.VFX["Shidou Skin Awakening VFX"].shidouawkemit3);
        end },
    { 179, function() -- Line: 20
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Shidou Skin Awakening VFX"].shidouawkemitfinal);
        end },
    { 292, function() -- Line: 23
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Shidou Skin Awakening VFX"].shidouawkemitfinal);
            VfxManager.Emit(workspace.VFX["Shidou Skin Awakening VFX"].shidouawkemit3);
        end },
    { 432, function() -- Line: 27
            for _, descendant in pairs(workspace.VFX["Shidou Skin Awakening VFX"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Shidou Skin Awakening VFX"].shidouawkcamvfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 41
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 42
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