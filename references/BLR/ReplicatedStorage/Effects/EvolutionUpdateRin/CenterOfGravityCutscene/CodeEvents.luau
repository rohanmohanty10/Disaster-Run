  

local u1 = {
    { 10, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.Start2);
        end },
    { 44, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.VFX.ScreenEffect2, workspace.VFX.VFX["24/7Wind"], workspace.VFX.VFX.River);
        end },
    { 231, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.VFX.CamZoom);
        end },
    { 235, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFX.Start2, workspace.VFX.VFX.awesome1);
        end },
    { 237, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.VFX.beamsstaybit);
        end }
};

return function(u2) -- Line: 17
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 18
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