  

local u1 = {
    { 25, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Catch1);
        end },
    { 59, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Catch2);
        end },
    { 95, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Catch2);
        end },
    { 148, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Land);
        end },
    { 159, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.CutsceneVFX.FakeCam);
        end },
    { 189, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.CutsceneVFX.KickEmit);
        end },
    { 347, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.CutsceneVFX.HeadTakeOff);
        end }
};

return function(u2) -- Line: 23
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 24
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