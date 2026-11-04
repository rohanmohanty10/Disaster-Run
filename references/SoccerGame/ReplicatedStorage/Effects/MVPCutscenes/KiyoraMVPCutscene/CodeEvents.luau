  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.ConstantCamera);
        end },
    { 115, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.VFX.StartupSimple);
        end },
    { 182, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.VFX.StartupSimple2);
        end },
    { 219, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFX["Lift Up"]);
        end },
    { 313, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.VFX.VictoryShine);
        end }
};

return function(u2) -- Line: 17
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 18
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