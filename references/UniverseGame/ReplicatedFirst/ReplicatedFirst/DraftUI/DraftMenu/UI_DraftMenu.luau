  

 

return function(u1) -- Line: 2
    require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local v2 = u1.Knit.GetService("AbilityDraftService");
    local Parent = script.Parent;
    local Title = Parent.Title;
    local Desc = Parent.Desc;
    local _ = Parent.BanList;
    local u3 = nil;
    local wait = task.wait;
    v2.Signal:Connect(function(...) -- Line: 20
        -- upvalues: u1 (copy)
        u1.DraftSignal:Fire(...);
    end);

    function u1.PhaseUpdate(p4) -- Line: 24
        -- upvalues: u3 (ref), Title (copy), Desc (copy), u1 (copy)
        local v5;

        if u3 then
            v5 = u3 - os.time();
        else
            v5 = nil;
        end;

        if p4 ~= "BanPhase" then
            if p4 == "PickPhase" then
                Title.Text = `Pick Phase [{v5}]`;
                Desc.Text = "Select an ability to lock in";
                u1.UpdateAllStatus();
            end;

            return;
        end;

        Title.Text = `Ban Phase [{v5}]`;
        Desc.Text = "Select an ability to ban";
        u1.UpdateAllStatus();
    end;

    function u1.SetEndTime(p6) -- Line: 40
        -- upvalues: u3 (ref)
        u3 = p6;
    end;

    u1.DraftSignal:Connect(function(p7, p8) -- Line: 44
        -- upvalues: wait (copy), u1 (copy), Desc (copy)
        if p7 == "PhaseChanged" then
            repeat
                wait(0.1);
            until u1.SetPhase;

            u1.SetPhase(p8);
            u1.PhaseUpdate(p8);

            return;
        end;

        if p7 == "UpdateTimer" then
            u1.SetEndTime(p8);

            return;
        end;

        if p7 == "PlayerStatusUpdated" then
            u1.UpdateStatus(p8.Player, p8.Status);

            return;
        end;

        if p7 == "DraftBanned" then
            Desc.Text = "Waiting for other player to ban";

            return;
        end;

        if p7 == "DraftPicked" then
            Desc.Text = "Waiting for other player to pick";
        end;
    end);
end;