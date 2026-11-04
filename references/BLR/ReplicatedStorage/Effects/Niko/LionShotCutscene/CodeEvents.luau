  

local u1 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX["Lion Shot VFX"].CamVFX, workspace.VFX["Lion Shot VFX"].AwkConstantCameraIs2);
        end },
    { 100, function() -- Line: 8
            shared.vfx.emit(workspace.VFX["Lion Shot VFX"].shotcharge3);
        end },
    { 201, function() -- Line: 11
            shared.vfx.emit(workspace.VFX["Lion Shot VFX"].shot);
        end },
    { 202, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["Lion Shot VFX"].shotcharge2);
        end }
};

return function(u2) -- Line: 19
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 20
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