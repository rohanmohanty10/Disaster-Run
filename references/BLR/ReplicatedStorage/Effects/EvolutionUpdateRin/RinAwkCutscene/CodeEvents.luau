  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.StartupReall, workspace.VFX.VFX.BackgroundFX);
        end },
    { 188, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.VFX.cameraemit44);
        end },
    { 246, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.VFX.ScreenEffect);
        end },
    { 251, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFX.cameraemit2);
        end },
    { 253, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.VFX.cameraemit1);
        end },
    { 486, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.VFX.Hit4Emit);
        end },
    { 657, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.VFX.Hit4Emit2);
        end },
    { 789, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.VFX.Hit4Emit4);
        end },
    { 840, function() -- Line: 25
            shared.vfx.emit(workspace.VFX.VFX.Hit4Emit3);
        end },
    { 1303, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.VFX.Atmosphere);
        end },
    { 1339, function() -- Line: 31
            shared.vfx.emit(workspace.VFX.VFX.smokeawesome);
        end },
    { 1408, function() -- Line: 34
            shared.vfx.emit(workspace.VFX.VFX.smokeawesome);
        end },
    { 1491, function() -- Line: 37
            shared.vfx.emit(workspace.VFX.VFX.smokeawesome);
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