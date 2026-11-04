  

local u2 = {
    { 239, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Zone1Emit);
        end },
    { 369, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.CutsceneVFX.FootStep1);
        end },
    { 403, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.CutsceneVFX.BallTap1);
        end },
    { 431, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Dribble);
        end },
    { 577, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.Cam.CamPart["A lot"]["Speed "]);
        end },
    { 629, function() -- Line: 16
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Head.FACE);
        end },
    { 640, function() -- Line: 26
            shared.vfx.emit(workspace.VFX.CutsceneVFX.Dribble2);
        end }
};

return function(u3) -- Line: 30
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 31
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