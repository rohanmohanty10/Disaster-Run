  

local u3 = {
    { 50, function() -- Line: 1
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace");

                return;
            end;

            local v1 = CutsceneVFX:FindFirstChild("GK BLOCK");

            if v1 then
                VfxManager.Emit(v1);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 193, function() -- Line: 16
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace");

                return;
            end;

            local Flash = CutsceneVFX:FindFirstChild("Flash");

            if Flash then
                VfxManager.Emit(Flash);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 301, function() -- Line: 31
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace");

                return;
            end;

            local SaeBreathe = CutsceneVFX:FindFirstChild("SaeBreathe");

            if SaeBreathe then
                VfxManager.Emit(SaeBreathe);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 334, function() -- Line: 46
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace");

                return;
            end;

            local Dash = CutsceneVFX:FindFirstChild("Dash");

            if Dash then
                VfxManager.Emit(Dash);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 412, function() -- Line: 60
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace");

                return;
            end;

            local Run = CutsceneVFX:FindFirstChild("Run");

            if Run then
                VfxManager.Emit(Run);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 510, function() -- Line: 74
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace");

                return;
            end;

            local v2 = CutsceneVFX:FindFirstChild("Dust Slide");

            if v2 then
                VfxManager.Emit(v2);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 636, function() -- Line: 88
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace");

                return;
            end;

            local Kick = CutsceneVFX:FindFirstChild("Kick");

            if Kick then
                VfxManager.Emit(Kick);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end }
};

return function(u4) -- Line: 103
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 104
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