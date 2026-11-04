  

local u1 = {
    { 215, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.vfx.camvfx1);
        end },
    { 281, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.vfx.camvfx2);
        end },
    { 285, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.vfx.Attachments);
        end },
    { 408, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.vfx.crack1);
        end },
    { 456, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.vfx["Flame part"]);
        end },
    { 695, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.vfx.Pass);
        end },
    { 745, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.vfx.crack2);
        end },
    { 861, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.vfx.Land);
        end },
    { 864, function() -- Line: 25
            shared.vfx.emit(workspace.VFX.vfx.Pass2);
        end },
    { 865, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.vfx.camvfx1, workspace.VFX.vfx.Lines);
        end },
    { 990, function() -- Line: 31
            shared.vfx.emit(workspace.VFX.vfx.camvfx2);
        end },
    { 998, function() -- Line: 34
            shared.vfx.emit(workspace.VFX.vfx.ShotTest);
        end },
    { 1041, function() -- Line: 37
            shared.vfx.emit(workspace.VFX.vfx.crack2);
        end }
};

return function(u2) -- Line: 41
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 42
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