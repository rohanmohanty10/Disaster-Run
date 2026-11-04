  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["NELBachira Secret Awakening"].crosshairemit2);
        end },
    { 168, function() -- Line: 4
            shared.vfx.emit(workspace.VFX["NELBachira Secret Awakening"].nelbachirasecretawk);
        end },
    { 476, function() -- Line: 7
            shared.vfx.emit(workspace.VFX["NELBachira Secret Awakening"].crosshairemit1);
        end },
    { 643, function() -- Line: 10
            shared.vfx.emit(workspace.VFX["NELBachira Secret Awakening"].nelbachirasecretawk1);
        end },
    { 652, function() -- Line: 13
            shared.vfx.emit(workspace.VFX["NELBachira Secret Awakening"].nelbachirasecretawk2);
        end },
    { 745, function() -- Line: 16
            shared.vfx.emit(workspace.VFX["NELBachira Secret Awakening"].nelbachirasecretawk4);
        end },
    { 971, function() -- Line: 19
            shared.vfx.emit(workspace.VFX["NELBachira Secret Awakening"].nelbachirasecretawk3);
        end }
};

return function(u2) -- Line: 24
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 25
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