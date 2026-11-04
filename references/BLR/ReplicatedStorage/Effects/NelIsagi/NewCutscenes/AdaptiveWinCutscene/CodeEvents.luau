  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFXFolder.ConstantCamVFX);
            shared.vfx.emit(workspace.VFX.VFXFolder.ScreenZoom1);
        end },
    { 7, function() -- Line: 6
            shared.vfx.emit(workspace.VFX.VFXFolder.VStep1);
        end },
    { 8, function() -- Line: 9
            shared.vfx.emit(workspace.VFX.VFXFolder.DustSlideTrail);
        end },
    { 58, function() -- Line: 12
            shared.vfx.emit(workspace.VFX.VFXFolder.Vstep2);
        end },
    { 565, function() -- Line: 15
            shared.vfx.emit(workspace.VFX.VFXFolder.Startup);
        end },
    { 700, function() -- Line: 18
            shared.vfx.emit(workspace.VFX.VFXFolder.Startup);
        end },
    { 810, function() -- Line: 21
            shared.vfx.emit(workspace.VFX.VFXFolder.Tap1);
        end },
    { 839, function() -- Line: 24
            shared.vfx.emit(workspace.VFX.VFXFolder.ShotEmit);
        end }
};

return function(u2) -- Line: 28
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 29
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