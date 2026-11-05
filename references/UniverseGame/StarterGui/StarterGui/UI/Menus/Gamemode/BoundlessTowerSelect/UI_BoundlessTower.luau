  

 

return function(u1) -- Line: 1
    local Players = game:GetService("Players");
    local TweenService = game:GetService("TweenService");
    local LocalPlayer = Players.LocalPlayer;
    require(u1.KnitPath.Net);
    require(u1.KnitPath.Trove);
    local PathShortcuts = u1.PathShortcuts;
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("StatsHandler"));
    local Knit = u1.Knit;
    local _ = u1.Utils;
    local Parent = script.Parent;
    local Parent2 = Parent.Parent;
    local ClientAssets = PathShortcuts.ClientAssets;

    if PathShortcuts.LinkedPlaces[game.GameId].GameModePlace ~= game.PlaceId then
        return;
    end;

    local Assets = Parent.Assets;
    local u2 = Assets:FindFirstChild("Map"):Clone();
    local Maps = Parent.MapHolder.Maps;
    local TimeIndicator = Parent.TimeIndicator;
    TimeIndicator.Visible = false;
    Knit.OnStart():await();
    local u3 = Knit.GetService("GameModeService");
    local u4 = Knit.GetService("LeaderboardService");
    local u5 = { Color3.fromRGB(180, 255, 139), Color3.fromRGB(255, 180, 94), Color3.fromRGB(255, 114, 170) };
    local u6 = {
        Metro = "rbxassetid://15618030866"
    };
    local u7 = false;
    local u8 = nil;
    local u9 = {};

    local function InitializeBoundlessTowerVoting() -- Line: 48
        -- upvalues: u7 (ref), u1 (copy), Parent2 (copy)
        if u7 then
            return;
        end;

        u7 = true;
        u1.UI:SetAttribute("DraftEnabled", nil);
        u1.UI:SetAttribute("MapPickEnabled", true);
        u1:SetMenu("Gamemode");
        Parent2.BoundlessTowerSelect.Visible = true;
    end;

    local function MakeMapFrame(u10, p11) -- Line: 61
        -- upvalues: u2 (copy), Assets (copy), u5 (copy), u6 (copy), Maps (copy), u1 (copy), u8 (ref), u3 (copy), u9 (copy)
        local v12 = u2:Clone();
        v12.InfoFrame.MapName.Text = u10;

        for _ = 1, p11.Difficulty do
            local v13 = Assets.DifficultyIcon:Clone();
            v13.Parent = v12.InfoFrame.Difficulty;
            v13.Visible = true;

            if u5[p11.Difficulty] then
                v13.ImageColor3 = u5[p11.Difficulty];
            end;
        end;

        for _, v in p11.Enemies do
            local Name = v.Name;
            local v14 = Assets.EnemyEntry:Clone();
            v14.Text = "- " .. Name;
            v14.Parent = v12.InfoFrame.EnemyList.ScrollBar;
            v14.Visible = true;
        end;

        if u6[u10] then
            v12.ImageFrame.Image = u6[u10];
        end;

        if p11.DisplayAsInProgress == true then
            v12.InProgress.Visible = true;
        end;

        v12.VotesIndicator.Text = `{0} Vote(s)`;
        v12.Parent = Maps;
        v12.Visible = true;

        if not p11.DisplayAsInProgress then
            u1:AddHoverCallbacks({
                TweenSize = true,
                PlaySounds = true,
                TweenSizeMultiplier = 1.05,
                Object = v12
            });
            v12.Select.MouseButton1Click:Connect(function() -- Line: 104
                -- upvalues: u8 (ref), u10 (copy), u3 (ref)
                if u8 == u10 then
                    return;
                end;

                u8 = u10;
                u3.Signal:Fire({
                    Handler = "BoundlessTower",
                    Action = "Vote",
                    Selection = u10
                });
            end);
        end;

        u9[u10] = v12;

        return v12;
    end;

    local function ShowMaps(p15) -- Line: 124
        -- upvalues: MakeMapFrame (copy)
        for i, v in p15 do
            MakeMapFrame(i, v);
        end;
    end;

    local function ReplicateVotes(p16) -- Line: 130
        -- upvalues: u9 (copy)
        local Votes = p16.Votes;
        local v17 = {};

        for i, v in u9 do
            if not v17[i] then
                v17[i] = 0;
            end;

            for _, v2 in Votes do
                if v2 == i then
                    v17[i] = v17[i] + 1;
                end;
            end;

            v.VotesIndicator.Text = `{v17[i]} Vote(s)`;
        end;
    end;

    local function Close(p18) -- Line: 150
        -- upvalues: u1 (copy), Parent2 (copy)
        u1.UI:SetAttribute("MapPickEnabled", nil);
        u1:SetMenu(nil);
        Parent2.BoundlessTowerSelect.Visible = false;
    end;

    local function View(p19) -- Line: 156
        -- upvalues: TimeIndicator (copy), u1 (copy), u7 (ref), Parent2 (copy), MakeMapFrame (copy)
        local Choices = p19.Choices;
        local Duration = p19.Duration;
        task.defer(function() -- Line: 160
            -- upvalues: Duration (ref), TimeIndicator (ref)
            print("START VOTE TIMER");
            Duration = math.round(Duration);
            TimeIndicator.Text = `{Duration}s Remaining`;
            TimeIndicator.Visible = true;

            for i = Duration, 1, -1 do
                task.wait(1);
                TimeIndicator.Text = `{i}s Remaining`;
            end;
        end);
        u1.UI:SetAttribute("MapPickEnabled", true);

        if not u7 then
            u7 = true;
            u1.UI:SetAttribute("DraftEnabled", nil);
            u1.UI:SetAttribute("MapPickEnabled", true);
            u1:SetMenu("Gamemode");
            Parent2.BoundlessTowerSelect.Visible = true;
        end;

        for i, v in Choices do
            MakeMapFrame(i, v);
        end;

        pcall(function() -- Line: 177
            -- upvalues: u1 (ref)
            u1.UI.Menus.Currencies.Visible = false;
            u1.UI.Menus.ServerInfo.Visible = false;
        end);
    end;

    local function Transition(p20) -- Line: 183
        -- upvalues: ClientAssets (copy), LocalPlayer (copy), TweenService (copy)
        local Duration = p20.Duration;
        local u21 = ClientAssets.BlackScreen:Clone();
        local BlackScreen = u21.BlackScreen;
        u21.Parent = LocalPlayer:WaitForChild("PlayerGui").Core;
        TweenService:Create(BlackScreen, TweenInfo.new(1), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(Duration or 1);
        local v22 = TweenService:Create(BlackScreen, TweenInfo.new(1), {
            BackgroundTransparency = 1
        });
        v22:Play();
        v22.Completed:Connect(function() -- Line: 198
            -- upvalues: u21 (copy)
            task.wait(1);
            u21:Destroy();
        end);
    end;

    u3.Signal:Connect(function(p23) -- Line: 204
        -- upvalues: View (copy), ReplicateVotes (copy), u1 (copy), Parent2 (copy), Transition (copy)
        local Action = p23.Action;

        if p23.Handler ~= "BoundlessTower" then
            return;
        end;

        if Action == "View" then
            View(p23);

            return;
        end;

        if Action == "ReplicateVotes" then
            ReplicateVotes(p23);

            return;
        end;

        if Action ~= "Close" then
            if Action == "Transition" then
                Transition(p23);
            end;

            return;
        end;

        u1.UI:SetAttribute("MapPickEnabled", nil);
        u1:SetMenu(nil);
        Parent2.BoundlessTowerSelect.Visible = false;
    end);
    u3.Signal:Connect(function(p24) -- Line: 223
        -- upvalues: Transition (copy)
        local _ = p24.Handler;

        if p24.Action == "Transition" then
            Transition(p24);
        end;
    end);
    Parent.SeasonIndicator.Text = (function() -- Line: 232, Name: GetSeasonText
        -- upvalues: u4 (copy)
        local v25 = u4:GetSeasonTimeRemainingString():expect();
        local v26 = u4:GetSeason():expect();
        local v27 = string.match(v26, "%d+");
        local v28 = Random.new((tonumber(v27))):NextInteger(0, 360);
        local v29 = Color3.fromHSV(v28 / 360, 0.5, 0.7);
        local v30 = string.match(v25, "%(Resets at: ([^%)]+)%)");
        local v31 = `<font color="rgb({math.floor(v29.R * 255)},{math.floor(v29.G * 255)},{math.floor(v29.B * 255)})">{v27}</font>`;

        if v30 then
            return `Season {v31} (Resets at: {v30})`;
        end;

        return `Season {v31}`;
    end)();
end;