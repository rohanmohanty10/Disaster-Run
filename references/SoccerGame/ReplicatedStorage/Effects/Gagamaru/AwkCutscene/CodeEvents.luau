  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["Gagamaru Awk"].AwkConstantCameraGagamaru);
        end },
    { 10, function() -- Line: 4
            shared.vfx.emit(workspace.VFX["Gagamaru Awk"].awkemit3);
        end },
    { 25, function() -- Line: 7
            shared.vfx.emit(workspace.VFX["Gagamaru Awk"].awkemit1, workspace.VFX["Gagamaru Awk"].awkemit2);
        end },
    { 236, function() -- Line: 10
            shared.vfx.emit(workspace.VFX["Gagamaru Awk"].awkemit4, workspace.VFX["Gagamaru Awk"].awkemit5);
        end },
    { 283, function() -- Line: 13
            shared.vfx.emit(workspace.VFX["Gagamaru Awk"].awkemit7, workspace.VFX["Gagamaru Awk"].awkemit6);
        end },
    { 376, function() -- Line: 16
            shared.vfx.emit(workspace.VFX["Gagamaru Awk"].Dive, workspace.VFX["Gagamaru Awk"].roarVFX);
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