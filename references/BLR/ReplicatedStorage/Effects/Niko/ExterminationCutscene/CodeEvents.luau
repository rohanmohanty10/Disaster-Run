  

local u1 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.VFX.CamZoom);
        end },
    { 5, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.VFX.BlockShot);
        end },
    { 159, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.VFX.BodyCoreEnable);
        end }
};

return function(u2) -- Line: 13
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 14
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