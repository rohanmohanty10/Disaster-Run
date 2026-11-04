  

local u1 = {
    { 26, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.Model.snuffy["Right Leg"]);
        end },
    { 43, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.Model.snuffy.Particles);
        end },
    { 52, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.Model.snuffy["Left Leg"]);
        end },
    { 68, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.Model.snuffy["Right Leg"]);
        end },
    { 86, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.Model.snuffy["Left Leg"]);
        end },
    { 104, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.Model.snuffy["Right Leg"]);
        end },
    { 119, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.Model.snuffy["Left Leg"]);
        end },
    { 137, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.Model.snuffy["Right Leg"]);
        end },
    { 242, function() -- Line: 25
            shared.vfx.emit(workspace.VFX.Model.enemy3["Right Leg"]);
        end },
    { 504, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.VFX.Bump1);
        end },
    { 613, function() -- Line: 31
            shared.vfx.emit(workspace.VFX.VFX.Push1);
        end },
    { 622, function() -- Line: 34
            shared.vfx.emit(workspace.VFX.VFX.CameraShot2.SpeedLines);
        end },
    { 869, function() -- Line: 37
            shared.vfx.emit(workspace.VFX.Model.snuffy["Left Leg"]);
        end },
    { 871, function() -- Line: 40
            shared.vfx.emit(workspace.VFX.Model.snuffy["Left Leg"]);
        end },
    { 873, function() -- Line: 43
            shared.vfx.emit(workspace.VFX.Model.snuffy["Left Leg"]);
        end },
    { 992, function() -- Line: 46
            shared.vfx.emit(workspace.VFX.VFX.BlockEmit);
            shared.vfx.emit(workspace.VFX.Model.enemy3.PlayerHighlight);
        end },
    { 1069, function() -- Line: 51
            shared.vfx.emit(workspace.VFX.VFX.Fall);
        end },
    { 1306, function() -- Line: 54
            shared.vfx.emit(workspace.VFX.VFX.PoseEmit);
            shared.vfx.emit(workspace.VFX.Model.enemy3.PlayerHighlight);
        end }
};

return function(u2) -- Line: 60
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 61
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