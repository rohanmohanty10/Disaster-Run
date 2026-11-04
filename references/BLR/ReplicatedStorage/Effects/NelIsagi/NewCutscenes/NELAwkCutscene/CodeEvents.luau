  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.Folder.trans, workspace.VFX.Folder.wisps);
        end },
    { 24, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.CameraRig.Cam.StompSpeedLines, workspace.VFX.CameraRig.Cam.StompSpeedLines2, workspace.VFX.CameraRig.Cam.StompSpeedLines3);
            shared.vfx.emit(workspace.VFX.Folder.ScreenEffect);
        end },
    { 76, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.CameraRig.Cam.StompSpeedLines, workspace.VFX.CameraRig.Cam.StompSpeedLines2, workspace.VFX.CameraRig.Cam.StompSpeedLines3);
            shared.vfx.emit(workspace.VFX.Folder.ScreenEffect);
        end },
    { 172, function() -- Line: 12
            shared.vfx.emit(workspace.VFX.CameraRig.Cam.StompSpeedLines, workspace.VFX.CameraRig.Cam.StompSpeedLines2, workspace.VFX.CameraRig.Cam.StompSpeedLines3);
            shared.vfx.emit(workspace.VFX.Folder.ScreenEffect);
        end },
    { 327, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.Folder.Crack);
        end }
};

return function(u2) -- Line: 20
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 21
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