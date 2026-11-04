  

local u1 = {
    { 157, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.vfx.Stress);
        end },
    { 206, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 396, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 415, function() -- Line: 11
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 428, function() -- Line: 14
            shared.vfx.emit(workspace.VFX.vfx.new);
        end },
    { 435, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 455, function() -- Line: 20
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 481, function() -- Line: 23
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 493, function() -- Line: 26
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 513, function() -- Line: 29
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 533, function() -- Line: 32
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end },
    { 548, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.vfx["1"], workspace.VFX.vfx.ShootMesh);
        end }
};

return function(u2) -- Line: 39
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 40
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