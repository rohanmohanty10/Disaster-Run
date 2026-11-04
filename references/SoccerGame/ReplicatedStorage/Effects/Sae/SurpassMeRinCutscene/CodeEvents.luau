  

local u1 = {
    { 90, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.VFX.RunSpecs2);
        end },
    { 121, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.VFX.WindGust2);
        end },
    { 126, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.VFX.PushAway);
        end },
    { 127, function() -- Line: 11
            shared.vfx.emit(workspace.VFX.VFX["24/7Wind"]);
        end },
    { 130, function() -- Line: 14
            shared.vfx.emit(workspace.VFX.VFX.awesome);
        end },
    { 502, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.VFX.CamZoom2, workspace.VFX.VFX.Background);
        end },
    { 582, function() -- Line: 20
            shared.vfx.emit(workspace.VFX.VFX.BallControl3);
        end },
    { 587, function() -- Line: 23
            shared.vfx.emit(workspace.VFX.VFX.BallControl3);
        end },
    { 677, function() -- Line: 26
            shared.vfx.emit(workspace.VFX.VFX.Dash2);
        end },
    { 682, function() -- Line: 29
            shared.vfx.emit(workspace.VFX.VFX.EyeFX);
        end },
    { 686, function() -- Line: 32
            shared.vfx.emit(workspace.VFX.VFX.Shot);
        end },
    { 942, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.VFX.steeeep11);
        end },
    { 966, function() -- Line: 38
            shared.vfx.emit(workspace.VFX.VFX.steeeep12);
        end },
    { 1031, function() -- Line: 41
            shared.vfx.emit(workspace.VFX.VFX.CamZoom3, workspace.VFX.VFX.BallShot, workspace.VFX.VFX.BallTrail);
        end }
};

return function(u2) -- Line: 46
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 47
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