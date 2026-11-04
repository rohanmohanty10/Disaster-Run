  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.vfx.wisps, workspace.VFX.vfx.trans, workspace.VFX.vfx.camvfx2, workspace.VFX.vfx.ScreenEffect, workspace.VFX.vfx.BodyIntensity);
        end },
    { 4, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.vfx.emit1);
        end },
    { 57, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.vfx.emit2);
        end },
    { 64, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.EnableCircle.step);
        end },
    { 128, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.vfx.trans);
        end },
    { 132, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.EnableCircle, workspace.VFX.CYBERPUNK, workspace.VFX.Ground);
        end },
    { 340, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.vfx["Stadium Lights"], workspace.VFX.vfx.trans);
        end },
    { 346, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.vfx.RootFX);
        end }
};

return function(u2) -- Line: 26
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 27
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