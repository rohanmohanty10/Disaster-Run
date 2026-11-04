  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.ScreenZoom1);
            shared.vfx.emit(workspace.VFX.VFX.ConstantCamera);
        end },
    { 110, function() -- Line: 6
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Highlight);
        end },
    { 140, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.VFX.ArtificialZone);
            shared.vfx.emit(workspace.VFX.VFX.CardEmit);
        end },
    { 146, function() -- Line: 21
            shared.vfx.emit(workspace.VFX.VFX.Step1);
        end },
    { 163, function() -- Line: 24
            shared.vfx.emit(workspace.VFX.VFX.Step2);
        end },
    { 180, function() -- Line: 27
            shared.vfx.emit(workspace.VFX.VFX.Step3);
        end },
    { 206, function() -- Line: 30
            shared.vfx.emit(workspace.VFX.VFX.Step4);
        end },
    { 218, function() -- Line: 33
            shared.vfx.emit(workspace.VFX.VFX.JumpEmit);
        end },
    { 503, function() -- Line: 36
            shared.vfx.emit(workspace.VFX.VFX.Shot);
        end }
};

return function(u3) -- Line: 40
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 41
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