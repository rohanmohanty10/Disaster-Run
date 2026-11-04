  

local u1 = {
    { 30, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.CutsceneVFX.LandEmit);
        end },
    { 219, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.CutsceneVFX.BreatheVFX2);
        end },
    { 286, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.CutsceneVFX.BreatheVFX2);
        end },
    { 329, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.CutsceneVFX.BreatheVFX2);
        end },
    { 411, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.CutsceneVFX.KickEmit);
        end },
    { 483, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Impact1);
        end },
    { 510, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Impact2);
        end },
    { 675, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.CutsceneVFX.AfterImage1);
        end },
    { 743, function() -- Line: 25
            shared.vfx.emit(workspace.VFX.CutsceneVFX.AfterImage2);
        end },
    { 853, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Punch1);
        end },
    { 875, function() -- Line: 31
            shared.vfx.emit(workspace.VFX.CutsceneVFX.AfterImage3);
        end },
    { 927, function() -- Line: 34
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Impact3);
        end },
    { 954, function() -- Line: 37
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Impact3);
        end },
    { 1031, function() -- Line: 40
            shared.vfx.emit(workspace.VFX.CutsceneVFX.AfterImage4);
        end },
    { 1260, function() -- Line: 43
            shared.vfx.emit(workspace.VFX.CutsceneVFX.PresentImpact);
        end },
    { 1359, function() -- Line: 46
            shared.vfx.emit(workspace.VFX.CutsceneVFX.LandEmit);
        end }
};

return function(u2) -- Line: 50
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 51
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