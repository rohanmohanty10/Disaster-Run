  

local u3 = {
    { 106, function() -- Line: 1
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Head.Emit);
        end },
    { 152, function() -- Line: 11
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Step1);
        end },
    { 162, function() -- Line: 14
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Step2);
        end },
    { 175, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Step3);
        end },
    { 263, function() -- Line: 20
            shared.vfx.emit(workspace.VFX.CutsceneVFX["Step!"]);
        end },
    { 307, function() -- Line: 23
            shared.vfx.emit(workspace.VFX.Ball.BALL);
        end },
    { 315, function() -- Line: 26
            shared.vfx.emit(workspace.VFX.Cam.CamPart["A lot"]["Speed "]);
        end },
    { 332, function() -- Line: 29
            shared.vfx.emit(workspace.VFX.Dribble1);
        end },
    { 338, function() -- Line: 32
            shared.vfx.emit(workspace.VFX.Dribble2);
        end },
    { 350, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.Dribble2);
        end },
    { 374, function() -- Line: 38
            shared.vfx.emit(workspace.VFX.Dribble2);
        end },
    { 379, function() -- Line: 41
            shared.vfx.emit(workspace.VFX.Dribble14);
        end },
    { 405, function() -- Line: 44
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Dribble);
        end },
    { 544, function() -- Line: 47
            shared.vfx.emit(workspace.VFX.CutsceneVFX.swirl);
        end },
    { 647, function() -- Line: 50
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v2.Head, v2["Left Arm"], v2["Left Leg"], v2["Right Arm"], v2["Right Leg"]);
        end },
    { 692, function() -- Line: 62
            shared.vfx.emit(workspace.VFX.CutsceneVFX.BallStomp);
        end },
    { 982, function() -- Line: 65
            shared.vfx.emit(workspace.VFX.CutsceneVFX.FinalKickEmit);
        end }
};

return function(u4) -- Line: 69
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 70
        -- upvalues: u4 (copy), u3 (ref)
        local v5 = 0;

        while u4:IsPlaying() do
            local CurrentFrame = u4.CurrentFrame;

            for _, v in u3 do
                local v6 = v[1];
                local v7 = v[2];

                if v6 <= CurrentFrame and v5 < v6 then
                    task.spawn(v7);
                end;
            end;

            task.wait();
            v5 = CurrentFrame;
        end;
    end);
end;