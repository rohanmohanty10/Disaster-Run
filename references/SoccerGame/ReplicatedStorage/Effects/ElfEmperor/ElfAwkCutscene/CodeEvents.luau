  

local u1 = {
    { 38, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx);
        end },
    { 68, function() -- Line: 4
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx1);
        end },
    { 83, function() -- Line: 7
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx2);
        end },
    { 100, function() -- Line: 10
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx3);
        end },
    { 119, function() -- Line: 13
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx4);
        end },
    { 143, function() -- Line: 16
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx5);
        end },
    { 162, function() -- Line: 19
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx6);
        end },
    { 174, function() -- Line: 22
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx7);
        end },
    { 194, function() -- Line: 25
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx8);
        end },
    { 208, function() -- Line: 28
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx9);
        end },
    { 549, function() -- Line: 31
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserstepvfx10);
        end },
    { 767, function() -- Line: 34
            shared.vfx.emit(workspace.VFX["Elf Kaiser Awakening VFX"].kaiserawakeningvfx);
        end }
};

return function(u2) -- Line: 38
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 39
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