  

local u2 = {
    { 413, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.vfx.Charge);
        end },
    { 502, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.vfx.Charge);
        end },
    { 614, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.vfx.Charge);
            shared.vfx.emit(workspace.VFX.vfx.Dash);
        end },
    { 818, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.vfx.CamZoom2);
        end },
    { 1024, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.vfx.StartupSimple);
        end },
    { 1075, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.vfx.StartupSimple);
        end },
    { 1124, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.vfx.StartupWeak);
        end },
    { 1235, function() -- Line: 25
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.vfx.Shot);
            shared.vfx.emit(workspace.VFX.vfx.BallTrail);
            local ball = workspace.VFX:FindFirstChild("ball");

            if ball then
                ball = ball:FindFirstChild("Highlight");
            end;

            if v1 then
                v1 = v1:FindFirstChild("Highlight");
            end;

            if ball and v1 then
                shared.vfx.emit(ball, v1);
            end;
        end },
    { 1351, function() -- Line: 45
            shared.vfx.emit(workspace.VFX.vfx.StartupWeak);
        end },
    { 1451, function() -- Line: 48
            shared.vfx.emit(workspace.VFX.vfx.StartupWeak);
        end }
};

return function(u3) -- Line: 53
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 54
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