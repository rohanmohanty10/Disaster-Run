  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.ScreenEffect);
        end },
    { 103, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.AuraEmit1);
        end },
    { 203, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.CameraRig.Cam.v1, workspace.VFX.CameraRig.Cam.v2Test);
        end },
    { 205, function() -- Line: 10
            shared.vfx.emit(workspace.VFX["21"]);
        end },
    { 295, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.kick);
        end },
    { 371, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.e2);
        end }
};

return function(u2) -- Line: 20
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 21
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