  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 4
    -- upvalues: ProfileManager (copy), ReplicatedStorage (copy)
    local Executor = p1.Executor;
    local v3 = ProfileManager.Profiles[Executor];

    if p2 == "giftFail" then
        table.clear(v3.Data.SavedGifts);
        v3.Data.SavedGifts[game:GetService("HttpService"):GenerateGUID()] = 2672177201;

        return;
    end;

    if p2 == "shutdown" then
        for _, v in game.Players:GetPlayers() do
            v:Kick((`Server Shutdown by {Executor.Name}`));
        end;

        return;
    end;

    if p2 == "awktest" then
        require(game.ServerScriptService.KnitServer.Services.CustomizationService).Client:EquipAWKOutfit(Executor, 381186011079319);

        return;
    end;

    if p2 == "maxflow" then
        Executor.PlayerStats.FlowBar.Value = 100;

        return;
    end;

    if p2 == "noslots" then
        v3.Data.StyleSlots.MaxSlot = 1;
        v3.Data.FlowSlots.MaxSlot = 1;

        return;
    end;

    if p2 == "rmgp" then
        table.clear(v3.Data.Gamepasses);

        return;
    end;

    if p2 == "givewheelspin" then
        local WheelSpins = v3.Data.WheelSpins;
        WheelSpins.Amount = WheelSpins.Amount + 10;

        return;
    end;

    if p2 == "wheelrewards" then
        require(game.ServerScriptService.KnitServer.Services.SpinwheelService):StartTest();

        return;
    end;

    if p2 == "seasonday" then
        local SalaryService = require(game.ServerScriptService.KnitServer.Services.SalaryService);
        local NEL = v3.Data.NEL;

        if NEL then
            NEL = NEL.LadderQuests;
        end;

        if NEL then
            NEL.DayKey = (NEL.DayKey or 0) - 1;

            for _, v in NEL.Tracks or {} do
                for _, v2 in v.Quests or {} do
                    if v2.LastLoginDay and v2.LastLoginDay > 0 then
                        v2.LastLoginDay = v2.LastLoginDay - 1;
                    end;

                    if v2.LastCreditDay and v2.LastCreditDay > 0 then
                        v2.LastCreditDay = v2.LastCreditDay - 1;
                    end;
                end;
            end;

            SalaryService:ProcessLadderDaily(Executor, v3);
            SalaryService:PushNELState(Executor);
        end;
    else
        if p2 == "seasonhour" then
            local SalaryService = require(game.ServerScriptService.KnitServer.Services.SalaryService);
            SalaryService:AccrueLadderPlaytime(Executor, v3, 3600);
            SalaryService:PushNELState(Executor);

            return;
        end;

        if p2 == "seasonskip" then
            local SalaryService = require(game.ServerScriptService.KnitServer.Services.SalaryService);
            local Popup = require(ReplicatedStorage.Shared.Popup);

            if SalaryService:SkipNextLadderQuest(Executor, v3) then
                SalaryService:PushNELState(Executor);

                return;
            end;

            Popup.Popup(Executor, "No incomplete ladder quests to skip");

            return;
        end;

        if p2 == "seasonset" then
            local SalaryService = require(game.ServerScriptService.KnitServer.Services.SalaryService);
            local Popup = require(ReplicatedStorage.Shared.Popup);
            local v4 = SalaryService:AdvanceLadderQuestSet(Executor, v3);

            if not v4 then
                Popup.Popup(Executor, "Pick a season position first");

                return;
            end;

            Popup.Popup(Executor, "Ladder quests set: " .. v4);
            SalaryService:PushNELState(Executor);

            return;
        end;

        if p2 == "aikusnake" then
            local giveItem = require(game.ServerScriptService.Modules.utils.giveItem);
            require(ReplicatedStorage.Shared.Popup).Popup(Executor, "Granted: " .. giveItem(v3.Data, "GoalEffect", "Aiku Snake"));
            require(game.ServerScriptService.KnitServer.Services.CustomizationService).Client.Customize:Fire(Executor, v3.Data.Customization);

            return;
        end;

        if p2 == "seasonreset" then
            local SalaryService = require(game.ServerScriptService.KnitServer.Services.SalaryService);
            local NEL = v3.Data.NEL;

            if NEL then
                NEL.Season = {
                    Position = "",
                    Rank = "Bench",
                    FixtureIndex = 1,
                    Wins = 0,
                    Losses = 0,
                    SpinsGranted = 0,
                    Tiers = {
                        S = 0,
                        A = 0,
                        B = 0
                    },
                    Fixtures = {}
                };
                NEL.LadderQuests = nil;
                SalaryService:PushNELState(Executor);
            end;
        elseif p2 == "twostepsgrant" then
            require(ReplicatedStorage.Shared.AbilityUtils).grantTwoStepsBehindShotOnPass(Executor, Executor.Character, ReplicatedStorage.Football.Value);
            local Popup = require(ReplicatedStorage.Shared.Popup);

            if Executor:GetAttribute("GrantedTwoStepsBehindShot") then
                Popup.Popup(Executor, "Two Steps Behind shot granted - press B while holding the ball");

                return;
            end;

            Popup.Popup(Executor, "Hold the ball first (grant needs exact possession)");
        end;
    end;
end;