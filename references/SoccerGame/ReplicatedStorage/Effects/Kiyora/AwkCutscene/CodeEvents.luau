  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.awakeningVFX.AwkConstantCamera);
            shared.vfx.emit(workspace.VFX.awakeningVFX.ConstantCamera);
            shared.vfx.emit(workspace.VFX.awakeningVFX.awakeningthingemit2);
        end },
    { 471, function() -- Line: 6
            shared.vfx.emit(workspace.VFX.awakeningVFX.step1);
        end },
    { 485, function() -- Line: 9
            shared.vfx.emit(workspace.VFX.awakeningVFX.step2);
        end },
    { 501, function() -- Line: 12
            shared.vfx.emit(workspace.VFX.awakeningVFX.step3);
        end },
    { 517, function() -- Line: 15
            shared.vfx.emit(workspace.VFX.awakeningVFX.step4);
        end },
    { 536, function() -- Line: 18
            shared.vfx.emit(workspace.VFX.awakeningVFX.step5);
        end },
    { 556, function() -- Line: 21
            shared.vfx.emit(workspace.VFX.awakeningVFX.step6);
        end },
    { 575, function() -- Line: 24
            shared.vfx.emit(workspace.VFX.awakeningVFX.awakeningthingemit);
        end }
};

return function(u2) -- Line: 28
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 29
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