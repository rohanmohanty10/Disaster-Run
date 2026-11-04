  

local u10 = {
    { 24, function() -- Line: 1
            local v1 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v1 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Torso);
        end },
    { 201, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.REA);
        end },
    { 224, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.FRE);
        end },
    { 260, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.GRTEA);
        end },
    { 287, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.GTRAR);
        end },
    { 329, function() -- Line: 25
            local v2 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v2 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v2.Torso);
        end },
    { 363, function() -- Line: 37
            local v3 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v3 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v3.Torso);
        end },
    { 371, function() -- Line: 49
            local v4 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v4 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v4.Torso);
        end },
    { 380, function() -- Line: 61
            local v5 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v5 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v5.Torso);
        end },
    { 389, function() -- Line: 73
            local v6 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v6 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v6.Torso);
        end },
    { 398, function() -- Line: 85
            local v7 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v7 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v7.Torso);
        end },
    { 407, function() -- Line: 97
            local v8 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v8 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v8.Torso);
        end },
    { 522, function() -- Line: 109
            local v9 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v9 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v9.Torso);
        end },
    { 587, function() -- Line: 121
            shared.vfx.emit(workspace.VFX.KICK);
        end }
};

return function(u11) -- Line: 125
    -- upvalues: u10 (copy)
    task.spawn(function() -- Line: 126
        -- upvalues: u11 (copy), u10 (ref)
        local v12 = 0;

        while u11:IsPlaying() do
            local CurrentFrame = u11.CurrentFrame;

            for _, v in u10 do
                local v13 = v[1];
                local v14 = v[2];

                if v13 <= CurrentFrame and v12 < v13 then
                    task.spawn(v14);
                end;
            end;

            task.wait();
            v12 = CurrentFrame;
        end;
    end);
end;