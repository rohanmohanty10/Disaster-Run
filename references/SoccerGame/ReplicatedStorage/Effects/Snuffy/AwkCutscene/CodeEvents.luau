  

local u1 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.VFX.BallAura);
        end },
    { 143, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.VFX.Scene1);
            shared.vfx.emit(workspace.VFX.VFX.EndScene);
            shared.vfx.emit(workspace.VFX.VFX.ScreenEffect, workspace.VFX.VFX.SlashScreen1);
        end },
    { 300, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFX.Scene2);
        end },
    { 390, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.VFX.EndScene);
        end }
};

return function(u2) -- Line: 18
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 19
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