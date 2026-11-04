  

local u1 = {
    { 89, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.KICK);
        end },
    { 227, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.VFX.Dribble2);
        end },
    { 253, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.VFX["Heel Centre"]);
        end },
    { 427, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFX.FinalKickEmit);
        end },
    { 567, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.VFX.flashstpe);
        end },
    { 575, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.VFX.step);
        end },
    { 617, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.VFX.stepp);
        end },
    { 850, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.VFX.Jump);
        end },
    { 990, function() -- Line: 25
            shared.vfx.emit(workspace.VFX.VFX.ccc);
        end },
    { 1035, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.VFX.GroundFX);
        end }
};

return function(u2) -- Line: 32
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 33
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