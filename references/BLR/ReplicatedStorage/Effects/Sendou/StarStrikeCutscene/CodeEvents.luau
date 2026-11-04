  

local u1 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.starstrikeVFX["24/7Wind"]);
        end },
    { 108, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.starstrikeVFX.Shot);
        end },
    { 237, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.starstrikeVFX.trailingmodel);
        end },
    { 238, function() -- Line: 11
            shared.vfx.emit(workspace.VFX.starstrikeVFX.step1);
        end },
    { 256, function() -- Line: 14
            shared.vfx.emit(workspace.VFX.starstrikeVFX.step2);
        end },
    { 275, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.starstrikeVFX.step3);
        end },
    { 290, function() -- Line: 20
            shared.vfx.emit(workspace.VFX.starstrikeVFX.step4);
        end },
    { 308, function() -- Line: 23
            shared.vfx.emit(workspace.VFX.starstrikeVFX.step5);
        end },
    { 324, function() -- Line: 26
            shared.vfx.emit(workspace.VFX.starstrikeVFX.step6);
        end },
    { 348, function() -- Line: 29
            shared.vfx.emit(workspace.VFX.starstrikeVFX.Shot3);
        end },
    { 349, function() -- Line: 32
            shared.vfx.emit(workspace.VFX.starstrikeVFX.WindGust2);
        end },
    { 432, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.starstrikeVFX.Jump);
        end }
};

return function(u2) -- Line: 40
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 41
        -- upvalues: u2 (copy), u1 (ref)
        local v3 = 0;

        while u2:IsPlaying() do
            local CurrentFrame = u2.CurrentFrame;

            for _, v in u1 do
                if v[1] <= CurrentFrame and v3 < v[1] then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v3 = CurrentFrame;
        end;
    end);
end;