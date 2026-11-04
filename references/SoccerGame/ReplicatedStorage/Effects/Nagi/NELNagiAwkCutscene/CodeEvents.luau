  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.ConstantCamVFX);
        end },
    { 11, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.VFX.FootSteps.Step1);
        end },
    { 121, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.VFX.ScreenZoom1);
        end },
    { 522, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFX.SkullEmit);
        end }
};

return function(u2) -- Line: 14
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 15
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