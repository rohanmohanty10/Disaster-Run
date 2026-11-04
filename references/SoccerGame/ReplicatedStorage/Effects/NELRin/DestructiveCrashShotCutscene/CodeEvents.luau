  

local VfxManager = require(game.ReplicatedStorage.VfxManager);
local u1 = {
    { 14, function() -- Line: 3
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Step1);
        end },
    { 36, function() -- Line: 7
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Step1);
        end },
    { 46, function() -- Line: 11
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Step);
        end },
    { 67, function() -- Line: 15
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Stomp);
        end },
    { 142, function() -- Line: 19
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Lines);
        end },
    { 253, function() -- Line: 23
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Kick);
        end },
    { 268, function() -- Line: 27
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Crash Shot"].BALL);
        end }
};

return function(u2) -- Line: 32
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 33
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