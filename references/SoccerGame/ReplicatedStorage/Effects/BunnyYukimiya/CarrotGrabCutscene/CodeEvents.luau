  

local u2 = {
    { 213, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["Carrot Grab VFX"].shotemit3);
        end },
    { 218, function() -- Line: 4
            shared.vfx.emit(workspace.VFX["Carrot Grab VFX"].ScreenEffect);
        end },
    { 239, function() -- Line: 7
            local v1 = nil;

            for _, v in game.Players:GetPlayers() do
                v1 = v.Character;

                if not (v1 and (v1:GetAttribute("CutsceneChar") and v1)) then
                    v1 = nil;
                end;

                if v1 then
                    break;
                end;
            end;

            print(v1);

            if v1 then
                shared.vfx.emit(v1);
            end;
        end },
    { 289, function() -- Line: 21
            shared.vfx.emit(workspace.VFX["Carrot Grab VFX"].jumpemit1);
        end },
    { 312, function() -- Line: 24
            shared.vfx.emit(workspace.VFX["Carrot Grab VFX"].shotemit1);
        end },
    { 468, function() -- Line: 27
            shared.vfx.emit(workspace.VFX["Carrot Grab VFX"].shotemit2);
        end }
};

return function(u3) -- Line: 31
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 32
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