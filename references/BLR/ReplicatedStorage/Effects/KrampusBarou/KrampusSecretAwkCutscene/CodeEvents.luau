  

local u2 = {
    { 3, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.lift);
        end },
    { 37, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.Kick);
        end },
    { 70, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.trap);
        end },
    { 225, function() -- Line: 10
            local v1 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character:GetAttribute("CutsceneChar") then
                    v1 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v1["Right Arm"].arm);
        end },
    { 290, function() -- Line: 20
            shared.vfx.emit(workspace.VFX.Bow);
        end }
};

return function(u3) -- Line: 24
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 25
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