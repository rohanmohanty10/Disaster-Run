  

local u1 = {
    { 13, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFXCutscene.Cam1);
            shared.vfx.emit(workspace.VFX.VFXCutscene.CamZoom);
            shared.vfx.emit(workspace.VFX.VFXCutscene.Dash);
        end },
    { 55, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.VFXCutscene.Step1);
        end },
    { 145, function() -- Line: 11
            shared.vfx.emit(workspace.VFX.VFXCutscene.FinalStep);
        end },
    { 265, function() -- Line: 14
            shared.vfx.emit(workspace.VFX.VFXCutscene.BallAura3);
        end },
    { 451, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.VFXCutscene.EndDribble);
        end }
};

return function(u2) -- Line: 21
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 22
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