  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.STEP1);
        end },
    { 55, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.STEP2);
        end },
    { 85, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.STEP3);
        end },
    { 117, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.STEP4);
        end },
    { 337, function() -- Line: 13
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.CameraRig.Cam["11"]["4"], workspace.VFX.CameraRig.Cam["11"]["3"], workspace.VFX.CameraRig.Cam["11"]["2"], workspace.VFX.CameraRig.Cam["11"]["1"], v1.Torso.Attachment);
            shared.vfx.emit(workspace.VFX.YELL);
        end }
};

return function(u3) -- Line: 25
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 26
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