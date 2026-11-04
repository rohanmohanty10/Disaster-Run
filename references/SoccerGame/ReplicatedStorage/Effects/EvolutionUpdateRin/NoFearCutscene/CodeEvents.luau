  

local u16 = {
    { 7, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.Shot1);
        end },
    { 101, function() -- Line: 4
            local v1 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("IsagiPlr") then
                    v1 = v.Character;
                    break;
                end;
            end;

            local v2 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v2 = v.Character;
                    break;
                end;
            end;

            print(v1, v2);
            shared.vfx.emit(v1["Right Leg"].PlayerRightStep1, v2["Right Leg"].PlayerRightStep1);
        end },
    { 114, function() -- Line: 24
            local v3 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("IsagiPlr") then
                    v3 = v.Character;
                    break;
                end;
            end;

            local v4 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v4 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v4["Left Leg"].PlayerLeftStep1, v3["Left Leg"].PlayerLeftStep1);
        end },
    { 125, function() -- Line: 41
            local v5 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("IsagiPlr") then
                    v5 = v.Character;
                    break;
                end;
            end;

            local v6 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v6 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v5["Right Leg"].PlayerRightStep1, v6["Right Leg"].PlayerRightStep1);
        end },
    { 135, function() -- Line: 58
            local v7 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("IsagiPlr") then
                    v7 = v.Character;
                    break;
                end;
            end;

            local v8 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v8 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v8["Left Leg"].PlayerLeftStep1, v7["Left Leg"].PlayerLeftStep1);
        end },
    { 148, function() -- Line: 75
            local v9 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("IsagiPlr") then
                    v9 = v.Character;
                    break;
                end;
            end;

            local v10 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v10 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v9["Right Leg"].PlayerRightStep1, v10["Right Leg"].PlayerRightStep1);
        end },
    { 159, function() -- Line: 92
            local v11 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("IsagiPlr") then
                    v11 = v.Character;
                    break;
                end;
            end;

            local v12 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v12 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v12["Left Leg"].PlayerLeftStep1, v11["Left Leg"].PlayerLeftStep1);
        end },
    { 171, function() -- Line: 109
            local v13 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("IsagiPlr") then
                    v13 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v13["Left Leg"].PlayerLeftStep1);
        end },
    { 221, function() -- Line: 119
            local v14 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("CutsceneChar") then
                    v14 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v14.Highlight, workspace.VFX.VFX.Startup);
        end },
    { 245, function() -- Line: 129
            local v15 = nil;

            for _, v in game.Players:GetPlayers() do
                if v.Character and v.Character:GetAttribute("IsagiPlr") then
                    v15 = v.Character;
                    break;
                end;
            end;

            shared.vfx.emit(v15["Right Leg"].PlayerRightStep1);
        end },
    { 250, function() -- Line: 139
            shared.vfx.emit(workspace.VFX.VFX.Startup2);
        end },
    { 311, function() -- Line: 142
            shared.vfx.emit(workspace.VFX.VFX.BallEmitStart);
        end },
    { 390, function() -- Line: 145
            shared.vfx.emit(workspace.VFX.VFX.Shot2);
        end }
};

return function(u17) -- Line: 149
    -- upvalues: u16 (copy)
    task.spawn(function() -- Line: 150
        -- upvalues: u17 (copy), u16 (ref)
        local v18 = 0;

        while u17:IsPlaying() do
            local CurrentFrame = u17.CurrentFrame;

            for _, v in u16 do
                local v19 = v[1];
                local v20 = v[2];

                if v19 <= CurrentFrame and v18 < v19 then
                    task.spawn(v20);
                end;
            end;

            task.wait();
            v18 = CurrentFrame;
        end;
    end);
end;