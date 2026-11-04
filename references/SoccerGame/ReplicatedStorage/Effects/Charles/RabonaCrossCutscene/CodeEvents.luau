  

local u3 = {
    { 8, function() -- Line: 1
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Tackle = CutsceneVFX:FindFirstChild("Tackle");

            if Tackle then
                VfxManager.Emit(Tackle);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 41, function() -- Line: 16
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Tackle2 = CutsceneVFX:FindFirstChild("Tackle2");

            if Tackle2 then
                VfxManager.Emit(Tackle2);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 97, function() -- Line: 31
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Dash = CutsceneVFX:FindFirstChild("Dash");

            if Dash then
                VfxManager.Emit(Dash);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 115, function() -- Line: 46
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local v1 = CutsceneVFX:FindFirstChild("Dust Slide");

            if v1 then
                VfxManager.Emit(v1);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 191, function() -- Line: 61
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local CamTran = CutsceneVFX:FindFirstChild("CamTran");

            if CamTran then
                VfxManager.Emit(CamTran);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 193, function() -- Line: 76
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Enable = CutsceneVFX:FindFirstChild("Enable");

            if Enable then
                VfxManager.Emit(Enable);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 194, function() -- Line: 91
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Specs = CutsceneVFX:FindFirstChild("Specs");

            if Specs then
                VfxManager.Emit(Specs);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 195, function() -- Line: 106
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local Sphere2 = CutsceneVFX:FindFirstChild("Sphere2");

            if Sphere2 then
                VfxManager.Emit(Sphere2);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 281, function() -- Line: 121
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");
            local v2 = CutsceneVFX and CutsceneVFX:FindFirstChild("Notice");

            if v2 then
                VfxManager.Emit(v2);
            end;
        end },
    { 392, function() -- Line: 132
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local CamTran = CutsceneVFX:FindFirstChild("CamTran");

            if CamTran then
                VfxManager.Emit(CamTran);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end },
    { 673, function() -- Line: 147
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
    { 863, function() -- Line: 162
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
    { 922, function() -- Line: 177
            local VfxManager = require(game.ReplicatedStorage.VfxManager);
            local CutsceneVFX = workspace.VFX:FindFirstChild("CutsceneVFX");

            if not CutsceneVFX then
                warn("Folder \'Shidou x Sae\' not found in workspace.VFX");

                return;
            end;

            local BOOM = CutsceneVFX:FindFirstChild("BOOM");

            if BOOM then
                VfxManager.Emit(BOOM);

                return;
            end;

            warn("Part \'Sae Flick\' not found in \'Shidou x Sae\'");
        end }
};

return function(u4) -- Line: 193
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 194
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