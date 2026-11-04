  

local u4 = {
    { 191, function() -- Line: 1
            local v1 = nil;

            for _, v in game.Players:GetPlayers() do
                local Character = v.Character;

                if Character:GetAttribute("CutsceneChar") then
                    v1 = Character;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Torso);
        end },
    { 434, function() -- Line: 14
            local v2 = nil;

            for _, v in game.Players:GetPlayers() do
                local Character = v.Character;

                if Character:GetAttribute("CutsceneChar") then
                    v2 = Character;
                    break;
                end;
            end;

            shared.vfx.emit(v2.Torso);
        end },
    { 435, function() -- Line: 27
            local v3 = nil;

            for _, v in game.Players:GetPlayers() do
                local Character = v.Character;

                if Character:GetAttribute("CutsceneChar") then
                    v3 = Character;
                    break;
                end;
            end;

            shared.vfx.emit(v3.Head, v3["Left Arm"], v3["Left Leg"], v3["Right Arm"], v3["Right Leg"]);
        end }
};

return function(u5) -- Line: 41
    -- upvalues: u4 (copy)
    task.spawn(function() -- Line: 42
        -- upvalues: u5 (copy), u4 (ref)
        local v6 = 0;

        while u5:IsPlaying() do
            local CurrentFrame = u5.CurrentFrame;

            for _, v in u4 do
                local v7 = v[1];
                local v8 = v[2];

                if v7 <= CurrentFrame and v6 < v7 then
                    task.spawn(v8);
                end;
            end;

            task.wait();
            v6 = CurrentFrame;
        end;
    end);
end;