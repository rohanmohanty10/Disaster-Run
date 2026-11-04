  

local u2 = {
    { 309, function() -- Line: 1
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Stance = CutsceneVFX:FindFirstChild("Stance");

            if Stance then
                VfxManager.Emit(Stance);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 332, function() -- Line: 16
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local RunStart = CutsceneVFX:FindFirstChild("RunStart");

            if RunStart then
                VfxManager.Emit(RunStart);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 349, function() -- Line: 31
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Run = CutsceneVFX:FindFirstChild("Run");

            if Run then
                VfxManager.Emit(Run);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 437, function() -- Line: 46
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local v1 = CutsceneVFX:FindFirstChild("Run Stop");

            if v1 then
                VfxManager.Emit(v1);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 798, function() -- Line: 61
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Kick = CutsceneVFX:FindFirstChild("Kick");

            if Kick then
                VfxManager.Emit(Kick);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 831, function() -- Line: 76
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Kick2 = CutsceneVFX:FindFirstChild("Kick2");

            if Kick2 then
                VfxManager.Emit(Kick2);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 1020, function() -- Line: 91
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Zoom = CutsceneVFX:FindFirstChild("Zoom");

            if Zoom then
                VfxManager.Emit(Zoom);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 1029, function() -- Line: 106
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Runn = CutsceneVFX:FindFirstChild("Runn");

            if Runn then
                VfxManager.Emit(Runn);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 1190, function() -- Line: 121
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Kick4 = CutsceneVFX:FindFirstChild("Kick4");

            if Kick4 then
                VfxManager.Emit(Kick4);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 1237, function() -- Line: 136
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Kick3 = CutsceneVFX:FindFirstChild("Kick3");

            if Kick3 then
                VfxManager.Emit(Kick3);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end }
};

return function(u3) -- Line: 152
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 153
        -- upvalues: u3 (copy), u2 (ref)
        local v4 = 0;

        while u3:IsPlaying() do
            local CurrentFrame = u3.CurrentFrame;

            for _, v in u2 do
                local v5 = v[1];
                local v6 = v[2];

                if v5 <= CurrentFrame and v4 < v5 then
                    task.spawn(v6);
                end;
            end;

            task.wait();
            v4 = CurrentFrame;
        end;
    end);
end;