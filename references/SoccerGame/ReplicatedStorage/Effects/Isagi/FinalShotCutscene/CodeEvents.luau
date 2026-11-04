  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.puzzlevfx1);
        end },
    { 1, function() -- Line: 4
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].AwkConstantCameraIs2, workspace.VFX["Isagi Last Shot VFX"].AwkConstantCameraIs, workspace.VFX["Isagi Last Shot VFX"].ConstantCameraIs2);
        end },
    { 2, function() -- Line: 7
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1);
        end },
    { 3, function() -- Line: 17
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].dirt1);
        end },
    { 27, function() -- Line: 20
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].dirt2);
        end },
    { 43, function() -- Line: 23
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].dirt3);
        end },
    { 69, function() -- Line: 26
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].dirt4);
        end },
    { 71, function() -- Line: 29
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].TransitionPuzzle);
        end },
    { 82, function() -- Line: 32
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].isagiemit4);
        end },
    { 87, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.Ball.BALL);
        end },
    { 88, function() -- Line: 38
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].isagiemit3);
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].isagiemit2);
        end },
    { 192, function() -- Line: 42
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].isagiemit4);
        end },
    { 635, function() -- Line: 45
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].isagiemit5);
        end },
    { 685, function() -- Line: 48
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].isagiemit6);
        end },
    { 733, function() -- Line: 51
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].isagiemit6);
        end },
    { 782, function() -- Line: 54
            shared.vfx.emit(workspace.VFX["Isagi Last Shot VFX"].isagiemit6);
        end }
};

return function(u3) -- Line: 58
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 59
        -- upvalues: u3 (copy), u2 (ref)
        local v4 = 0;

        while u3:IsPlaying() do
            local CurrentFrame = u3.CurrentFrame;

            for _, v in u2 do
                local v5 = v[1];
                local v6 = v[2];

                if v5 <= CurrentFrame and v4 < v5 then
                    task.spawn(v6);
                end;
            end;

            task.wait();
            v4 = CurrentFrame;
        end;
    end);
end;