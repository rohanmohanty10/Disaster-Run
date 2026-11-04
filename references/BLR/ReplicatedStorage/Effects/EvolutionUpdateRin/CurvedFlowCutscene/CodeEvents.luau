  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.Land);
        end },
    { 10, function() -- Line: 4
            local v1 = nil;

            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v1 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.Ball.Highlight, v1.Highlight);
            shared.vfx.emit(workspace.VFX.Enable1["White&BlackBGLines"]);
        end },
    { 124, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.VFX.Attachments.Eye_Emit);
            shared.vfx.emit(workspace.VFX.Enable1["White&BlackBGLines"]);
        end },
    { 518, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.VFX.Attachments.Eye_Emit2);
            shared.vfx.emit(workspace.VFX.Enable1["White&BlackBGLines2"]);
        end },
    { 595, function() -- Line: 27
            shared.vfx.emit(workspace.VFX.VFX.Spinning2, workspace.VFX.CurveShot);
        end },
    { 640, function() -- Line: 30
            shared.vfx.emit(workspace.VFX.VFX.Spinning2, workspace.VFX.CurveShot);
        end }
};

return function(u3) -- Line: 34
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 35
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