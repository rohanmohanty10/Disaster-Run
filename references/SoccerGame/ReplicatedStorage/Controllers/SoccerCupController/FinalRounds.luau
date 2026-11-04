  

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local Popup = require(ReplicatedStorage.Shared.Popup);
local BlueLockCupEventData = require(ReplicatedStorage.Shared.Configs.BlueLockCupEventData);
local LocalPlayer = Players.LocalPlayer;
local v1 = KnitClient.CreateController({
    Name = "BlueLockCupController"
});
local u2 = { "GroupA", "GroupB", "GroupC", "GroupD" };
local u3 = { "GroupABanner", "GroupBBanner", "GroupCBanner", "GroupDBanner" };
local TweenInfo_new_ret = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);

local function formatScore(p4) -- Line: 18
    local v5 = tonumber(p4) or 0;

    if v5 >= 1000000000000 then
        return string.format("%.1f Tril", v5 / 1000000000000);
    end;

    if v5 >= 1000000000 then
        return string.format("%.0f Bil", v5 / 1000000000);
    end;

    if v5 >= 1000000 then
        return string.format("%.0f Mil", v5 / 1000000);
    end;

    if v5 >= 1000 then
        return string.format("%.0f K", v5 / 1000);
    end;

    local math_floor_ret = math.floor(v5);

    return tostring(math_floor_ret);
end;

local function formatCountdown(p6) -- Line: 27
    local v7 = tonumber(p6) or 0;
    local math_ceil_ret = math.ceil(v7);
    local math_max_ret = math.max(math_ceil_ret, 0);
    local math_floor_ret = math.floor(math_max_ret / 86400);
    local math_floor_ret2 = math.floor(math_max_ret % 86400 / 3600);
    local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
    local v8 = math_max_ret % 60;

    if math_floor_ret > 0 then
        return ("%dd %02d:%02d:%02d"):format(math_floor_ret, math_floor_ret2, math_floor_ret3, v8);
    end;

    return ("%02d:%02d:%02d"):format(math_floor_ret2, math_floor_ret3, v8);
end;

local function stageDisplayName(p9) -- Line: 37
    return p9 == "QF" and "Quarter Finals" or (p9 == "SF" and "Semi Finals" or (p9 == "F" and "The Final" or "World Tournament"));
end;

local function bannerTextLabel(p10) -- Line: 44
    if p10 then
        p10 = p10:FindFirstChildWhichIsA("TextLabel", true);
    end;

    return p10;
end;

local function createTeamMarker(p11, p12, p13, p14) -- Line: 48
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p13;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(p14, 0.1);
    TextLabel.Size = UDim2.fromScale(0.34, 0.12);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.Text = "YOUR TEAM";
    TextLabel.TextColor3 = Color3.fromRGB(255, 225, 67);
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.TextStrokeTransparency = 0;
    TextLabel.TextScaled = false;
    TextLabel.TextSize = 18;
    TextLabel.TextWrapped = false;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.AutoLocalize = false;
    TextLabel.ZIndex = p12.ZIndex + 2;
    TextLabel.Visible = false;
    TextLabel.Parent = p11;

    return TextLabel;
end;

function v1.SetCenterPage(p15, p16) -- Line: 73
    for _, child in p15.Frames:GetChildren() do
        if child == p15.Frames.FriendLeaderboard or child == p15.Frames.EgoistOfTheWeek then
            child.Visible = true;
        elseif child:IsA("GuiObject") then
            child.Visible = child == p16;
        end;
    end;
end;

function v1.GetDisplayMatch(p17) -- Line: 83
    local State = p17.State;

    if not (State and State.SelectedTeam) then
        return nil;
    end;

    if State.SelectedMatch then
        return State.SelectedMatch;
    end;

    for _, v in State.Matchups or {} do
        if v.TeamA.Name == State.SelectedTeam or v.TeamB.Name == State.SelectedTeam then
            return {
                Revealed = false,
                Index = v.Index,
                TeamA = v.TeamA,
                TeamB = v.TeamB
            };
        end;
    end;

    return nil;
end;

function v1.RenderSelectionRows(p18) -- Line: 100
    -- upvalues: u2 (copy), u3 (copy)
    local State = p18.State;
    local v19 = State and (State.Matchups or {}) or {};
    local v20 = State and (State.DisplayStage or "QF") or "QF";
    local PendingTeam = p18.PendingTeam;

    if not PendingTeam then
        if State then
            PendingTeam = State.SelectedTeam;
        else
            PendingTeam = State;
        end;
    end;

    local SelectTeam = p18.Frames:FindFirstChild("SelectTeam");

    if SelectTeam then
        SelectTeam = SelectTeam:FindFirstChild("GroupStandings");
    end;

    if SelectTeam then
        SelectTeam = SelectTeam:FindFirstChild("GroupSelect");
    end;

    if not SelectTeam then
        return;
    end;

    local v21;

    if State == nil or State.SelectionOpen ~= true then
        v21 = false;
    else
        v21 = State.SelectedTeam == nil;
    end;

    SelectTeam.ConfirmButtons.Visible = v21;

    for i, v in u2 do
        local v22 = SelectTeam[v];
        local v23 = SelectTeam[u3[i]];
        local v24 = v19[i];
        v22.Visible = v24 ~= nil;
        v23.Visible = v24 ~= nil;

        if v24 then
            if v23 then
                v23 = v23:FindFirstChildWhichIsA("TextLabel", true);
            end;

            if v23 then
                v23.Text = v20 == "F" and "FINAL" or v20 .. tostring(i);
            end;

            local v25 = { v24.TeamA, v24.TeamB };

            for i2 = 1, 2 do
                local v26 = v22.ScrollingFrame:FindFirstChild((tostring(i2)));
                local v27 = v25[i2];
                v26.Visible = v27 ~= nil;
                local v28;

                if v27 then
                    v26.List:FindFirstChild("Name").Text = v27.Emoji .. " " .. v27.Name;
                    v26.Num.Text = "#" .. tostring(i2);
                    local v29 = PendingTeam == v27.Name;
                    v26.Checkbox.BackgroundColor3 = v29 and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(25, 28, 38);
                    v26.Checkbox.Tick.Image = v29 and "rbxassetid://18926561608" or "";
                    local v30;

                    if State.SelectionOpen == true then
                        v30 = State.SelectedTeam == nil;
                    else
                        v30 = false;
                    end;

                    v26.Checkbox.Tick.Active = v30;
                    v26.Checkbox.Tick.Interactable = v30;
                    v26.Checkbox.Tick.Selectable = v30;
                    v26.Checkbox.Tick.AutoButtonColor = v30;
                    v26.Checkbox.Tick.HoverImage = v30 and "rbxassetid://18926561608" or "";
                    v26.Checkbox.Tick.PressedImage = v30 and "rbxassetid://18926561608" or "";
                    local SelectionButton = v26:FindFirstChild("SelectionButton");

                    if SelectionButton then
                        SelectionButton.Active = v30;
                        SelectionButton.Interactable = v30;
                    end;

                    p18.RowTeams[v26.Checkbox.Tick] = v27.Name;
                    v28 = i2;
                else
                    v28 = i2;
                end;
            end;
        end;
    end;
end;

function v1.CancelMatchTweens(p31) -- Line: 150
    if not p31.MatchVisual then
        return;
    end;

    for _, v in { "FillTween", "ATween", "BTween", "AFade", "BFade" } do
        local v32 = p31.MatchVisual[v];

        if v32 then
            v32:Cancel();
        end;
    end;
end;

function v1.RenderSelectedMatch(p33) -- Line: 158
    -- upvalues: formatScore (copy), TweenService (copy), TweenInfo_new_ret (copy)
    local DisplayMatch = p33:GetDisplayMatch();

    if not DisplayMatch then
        return;
    end;

    if not p33.MatchVisual then
        return;
    end;

    local Bar = p33.Frames.AfterSelectingTeam.CurrentTeamVs.MatchResults.Bar;
    local CountryName1 = Bar.GameStats.Game1Country.CountryName1;
    local CountryName12 = Bar.GameStats.Game2Country.CountryName1;
    Bar.CountryName1.Text = "VS";
    p33.TeamAMarker.Visible = p33.State.SelectedTeam == DisplayMatch.TeamA.Name;
    p33.TeamBMarker.Visible = p33.State.SelectedTeam == DisplayMatch.TeamB.Name;
    local MatchVisual = p33.MatchVisual;
    local v34 = tostring(p33.State.DisplayStage) .. ":" .. tostring(DisplayMatch.Index);

    if MatchVisual.Key ~= v34 then
        p33:CancelMatchTweens();
        MatchVisual.Key = v34;
        MatchVisual.A.Value = 0;
        MatchVisual.B.Value = 0;
        Bar.Fill.Size = UDim2.new(0.5, 0, Bar.Fill.Size.Y.Scale, Bar.Fill.Size.Y.Offset);
        Bar.Fill.Position = UDim2.new(0.75, 0, Bar.Fill.Position.Y.Scale, Bar.Fill.Position.Y.Offset);
        Bar.RedBillTotal.Text = "";
        Bar.BlueBilLotal.Text = "";
        Bar.RedBillTotal.TextTransparency = 1;
        Bar.RedBillTotal.TextStrokeTransparency = 1;
        Bar.BlueBilLotal.TextTransparency = 1;
        Bar.BlueBilLotal.TextStrokeTransparency = 1;
    end;

    local v35;

    if DisplayMatch.Revealed == true and DisplayMatch.TeamA.Points ~= nil then
        v35 = DisplayMatch.TeamB.Points ~= nil;
    else
        v35 = false;
    end;

    if not v35 then
        CountryName1.Text = DisplayMatch.TeamA.Emoji .. " " .. DisplayMatch.TeamA.Name;
        CountryName12.Text = DisplayMatch.TeamB.Emoji .. " " .. DisplayMatch.TeamB.Name;
        Bar.RedBillTotal.Text = "";
        Bar.BlueBilLotal.Text = "";

        return;
    end;

    p33:CancelMatchTweens();
    local math_clamp_ret = math.clamp(DisplayMatch.TeamA.Percent or 50, 0, 100);
    local math_clamp_ret2 = math.clamp(DisplayMatch.TeamB.Percent or 100 - math_clamp_ret, 0, 100);
    CountryName1.Text = ("%s %s - %d%%"):format(DisplayMatch.TeamA.Emoji, DisplayMatch.TeamA.Name, (math.floor(math_clamp_ret + 0.5)));
    CountryName12.Text = ("%s %s - %d%%"):format(DisplayMatch.TeamB.Emoji, DisplayMatch.TeamB.Name, (math.floor(math_clamp_ret2 + 0.5)));
    Bar.RedBillTotal.Text = formatScore(MatchVisual.A.Value) .. " Total";
    Bar.BlueBilLotal.Text = formatScore(MatchVisual.B.Value) .. " Total";
    MatchVisual.FillTween = TweenService:Create(Bar.Fill, TweenInfo_new_ret, {
        Size = UDim2.new(math_clamp_ret2 / 100, 0, Bar.Fill.Size.Y.Scale, Bar.Fill.Size.Y.Offset),
        Position = UDim2.new(1 - math_clamp_ret2 / 200, 0, Bar.Fill.Position.Y.Scale, Bar.Fill.Position.Y.Offset)
    });
    MatchVisual.ATween = TweenService:Create(MatchVisual.A, TweenInfo_new_ret, {
        Value = DisplayMatch.TeamA.Points
    });
    MatchVisual.BTween = TweenService:Create(MatchVisual.B, TweenInfo_new_ret, {
        Value = DisplayMatch.TeamB.Points
    });
    MatchVisual.AFade = TweenService:Create(Bar.RedBillTotal, TweenInfo_new_ret, {
        TextTransparency = 0,
        TextStrokeTransparency = 0
    });
    MatchVisual.BFade = TweenService:Create(Bar.BlueBilLotal, TweenInfo_new_ret, {
        TextTransparency = 0,
        TextStrokeTransparency = 0
    });
    MatchVisual.FillTween:Play();
    MatchVisual.ATween:Play();
    MatchVisual.BTween:Play();
    MatchVisual.AFade:Play();
    MatchVisual.BFade:Play();
end;

function v1.RenderEgoist(p36) -- Line: 225
    local State = p36.State;
    local Bar = p36.Frames.EgoistOfTheWeek.Bar;
    local v37 = State and State.TopPercent and (math.clamp((100 - State.TopPercent) / 100, 0, 1) or 0) or 0;
    Bar.Fill.Size = UDim2.new(Bar.Fill.Size.X.Scale, Bar.Fill.Size.X.Offset, v37, 0);
    Bar.Fill.Position = UDim2.new(Bar.Fill.Position.X.Scale, Bar.Fill.Position.X.Offset, 1 - v37 / 2, 0);
    local Rank = p36.Frames.EgoistOfTheWeek.TeamQuestsBanner:FindFirstChild("Rank");

    if Rank then
        Rank.Text = State and (State.Rank and "#" .. tostring(State.Rank)) or "-";
    end;
end;

function v1.RenderFriendLeaderboard(p38, p39) -- Line: 235
    if not p38.FriendTemplate then
        return;
    end;

    local ScrollingFrame = p38.Frames.FriendLeaderboard.ScrollingFrame;

    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    for i, v in p39 or {} do
        local v40 = p38.FriendTemplate:Clone();
        v40.Name = "Player" .. tostring(v.UserId);
        v40.LayoutOrder = i;
        v40.ProfileIMG.PlayerID.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100"):format(v.UserId);
        v40.PlayerName.Text = v.Name .. "  -  " .. tostring(v.Points);
        local v41 = v;

        for i2 = 1, 4 do
            local v42 = v40.SelectedGroups:FindFirstChild("Flag" .. tostring(i2));
            local v43;

            if v42 then
                v42.Text = v41.Flags[i2] or "";
                v42.Visible = v41.Flags[i2] ~= nil;
                v43 = i2;
            else
                v43 = i2;
            end;
        end;

        v40.Visible = true;
        v40.Parent = ScrollingFrame;
    end;
end;

function v1.RefreshFriends(u44) -- Line: 259
    if u44.FetchingFriends then
        return;
    end;

    u44.FetchingFriends = true;
    task.spawn(function() -- Line: 262
        -- upvalues: u44 (copy)
        local FriendLeaderboard = u44.Service:GetFriendLeaderboard();
        u44.FetchingFriends = false;

        if type(FriendLeaderboard) == "table" then
            u44:RenderFriendLeaderboard(FriendLeaderboard);
        end;
    end);
end;

function v1.ConfirmPendingTeam(u45) -- Line: 269
    -- upvalues: Popup (copy)
    if not (u45.State and u45.State.SelectionOpen) then
        Popup.Popup(nil, "Team selection is not open");

        return;
    end;

    if not u45.PendingTeam then
        Popup.Popup(nil, "Select one team first");

        return;
    end;

    local PendingTeam = u45.PendingTeam;
    task.spawn(function() -- Line: 279
        -- upvalues: u45 (copy), PendingTeam (copy), Popup (ref)
        local v46 = u45.Service:SelectTournamentTeam(PendingTeam);

        if type(v46) ~= "table" then
            Popup.Popup(nil, (tostring(v46)));

            return;
        end;

        u45.PendingTeam = nil;
        u45.ActiveTab = u45.State and u45.State.DisplayStage == "F" and "Home" or "MatchScore";
        u45:ApplyState(v46);
    end);
end;

function v1.WireSelectCountry(u47) -- Line: 291
    -- upvalues: BlueLockCupEventData (copy), TweenService (copy), Popup (copy)
    local SelectCountry = u47.Frames:FindFirstChild("SelectCountry");

    if not SelectCountry then
        return nil;
    end;

    if u47.SelectCountryWired then
        return SelectCountry;
    end;

    u47.SelectCountryWired = true;
    u47.CountryFrames = {};

    for _, v in BlueLockCupEventData.FinalRounds.Final.Teams do
        local v48 = SelectCountry:FindFirstChild(v);
        local v49;

        if v48 then
            v49 = v48:FindFirstChild("TeamDetection");
        else
            v49 = v48;
        end;

        if v48 and v49 then
            if not v48:FindFirstChild("SelectStroke") then
                local UIStroke = Instance.new("UIStroke");
                UIStroke.Name = "SelectStroke";
                UIStroke.Thickness = 0;
                UIStroke.Color = Color3.fromRGB(255, 215, 60);
                UIStroke.Transparency = 1;
                UIStroke.Parent = v48;
            end;

            local FlagImage = v48:FindFirstChild("FlagImage");

            if FlagImage then
                FlagImage:Destroy();
            end;

            local Country = v48:FindFirstChild("Country");

            if Country then
                Country.Visible = true;
            end;

            local HoverScale = v48:FindFirstChild("HoverScale");

            if not HoverScale then
                HoverScale = Instance.new("UIScale");
                HoverScale.Name = "HoverScale";
                HoverScale.Parent = v48;
            end;

            v49.MouseEnter:Connect(function() -- Line: 320
                -- upvalues: TweenService (ref), HoverScale (ref)
                TweenService:Create(HoverScale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 1.06
                }):Play();
            end);
            v49.MouseLeave:Connect(function() -- Line: 323
                -- upvalues: TweenService (ref), HoverScale (ref)
                TweenService:Create(HoverScale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();
            end);
            u47.CountryFrames[v] = v48;
            v49.Activated:Connect(function() -- Line: 327
                -- upvalues: u47 (copy), Popup (ref), v (copy)
                if not (u47.State and u47.State.SelectionOpen) then
                    Popup.Popup(nil, "Team selection is not open");

                    return;
                end;

                if u47.State.SelectedTeam then
                    Popup.Popup(nil, "Your team is already locked!");

                    return;
                end;

                if u47.PendingTeam == v then
                    u47:ConfirmPendingTeam();

                    return;
                end;

                u47.PendingTeam = v;
                Popup.Popup(nil, "Click " .. v .. " again to confirm your pick. Picks are FINAL!");
                u47:RenderSelectCountry();
            end);
        end;
    end;

    return SelectCountry;
end;

function v1.RenderSelectCountry(p50) -- Line: 349
    if not p50.CountryFrames then
        return;
    end;

    for i, v in p50.CountryFrames do
        local SelectStroke = v:FindFirstChild("SelectStroke");

        if SelectStroke then
            local v51 = p50.PendingTeam == i;
            SelectStroke.Thickness = v51 and 6 or 0;
            SelectStroke.Transparency = v51 and 0 or 1;
        end;
    end;
end;

function v1.GetHubFrame(p52, p53) -- Line: 361
    if p53 == "Brazil" then
        return p52.Frames.TeamHubBrazil;
    end;

    if p53 == "Spain" then
        return p52.Frames.TeamHubSpain;
    end;

    return nil;
end;

function v1.UpdateFinalDayLabel(p54) -- Line: 367
    -- upvalues: formatCountdown (copy)
    local v55 = p54.State and p54.State.Final;

    if not v55 then
        return;
    end;

    local MatchText = p54.Frames.MainScore.MatchEndsIn.MatchText;

    if v55.Champion then
        MatchText.Text = string.upper(v55.Champion) .. " WIN THE WORLD TOURNAMENT!";

        return;
    end;

    if p54.FinalDayEndsAt then
        MatchText.Text = ("Day %d/%d Ends In: %s"):format(v55.DayIndex or 0, v55.DayCount or 7, formatCountdown(p54.FinalDayEndsAt - os.clock()));

        return;
    end;

    MatchText.Text = "The Final Starts Soon";
end;

function v1.RenderFinalHome(p56) -- Line: 380
    -- upvalues: formatScore (copy)
    local State = p56.State;

    if State then
        State = State.Final;
    end;

    if not State or type(State.Teams) ~= "table" then
        return;
    end;

    local v57 = State.Teams[1];
    local v58 = State.Teams[2];

    if not (v57 and v58) then
        return;
    end;

    local MatchResults = p56.Frames.MainScore.CurrentTeamVs.MatchResults;
    local v59 = State.Multipliers and (State.Multipliers[v57.Name] or 1) or 1;
    local v60 = State.Multipliers and (State.Multipliers[v58.Name] or 1) or 1;
    MatchResults.CountryFlag1.Text = v57.Emoji or "";
    MatchResults.CountryFlag2.Text = v58.Emoji or "";
    MatchResults.Country1Name.Text = v57.Name .. (v59 > 1 and (" %gx"):format(v59) or "");
    MatchResults.Country2Name.Text = v58.Name .. (v60 > 1 and (" %gx"):format(v60) or "");
    local Bar = MatchResults.Bar;
    Bar.BackgroundTransparency = 0;
    local v61 = Bar:FindFirstChildOfClass("UIGradient");

    if v61 then
        v61.Enabled = true;
        v61.Color = ColorSequence.new(Color3.fromRGB(24, 24, 24), Color3.fromRGB(0, 170, 0));
        Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    else
        Bar.BackgroundColor3 = Color3.fromRGB(38, 189, 86);
    end;

    local Fill = Bar:FindFirstChild("Fill");

    if Fill then
        Fill.BackgroundTransparency = 0;
        local v62 = Fill:FindFirstChildOfClass("UIGradient");

        if v62 then
            v62.Enabled = true;
            v62.Color = ColorSequence.new(Color3.fromRGB(24, 24, 24), Color3.fromRGB(255, 0, 0));
            Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        else
            Fill.BackgroundColor3 = Color3.fromRGB(224, 52, 52);
        end;
    end;

    local v63 = State.DayWins or {};
    Bar.GameStats.MainScore.Text = ("%d - %d"):format(v63[v57.Name] or 0, v63[v58.Name] or 0);
    local DayStandings = State.DayStandings;
    local v64 = DayStandings and DayStandings.TeamA and (DayStandings.TeamA.Points or 0) or 0;
    local v65 = DayStandings and DayStandings.TeamB and (DayStandings.TeamB.Points or 0) or 0;
    Bar.GameModeScore.GameModeText.Text = "Score";
    Bar.GameModeScore.GameModeScore.Text = formatScore(v64) .. " - " .. formatScore(v65);
    local v66 = DayStandings and (DayStandings.TeamA and DayStandings.TeamA.Percent) or 50;
    local v67 = 100 - v66;
    Bar.Country1Chance.Text = ("%d%% %s"):format(math.floor(v66 + 0.5), v57.Name);
    Bar.Country2Chance.Text = ("%d%% %s"):format(math.floor(v67 + 0.5), v58.Name);
    Bar.Fill.Size = UDim2.new(v67 / 100, 0, Bar.Fill.Size.Y.Scale, Bar.Fill.Size.Y.Offset);
    Bar.Fill.Position = UDim2.new(1 - v67 / 200, 0, Bar.Fill.Position.Y.Scale, Bar.Fill.Position.Y.Offset);
    p56:UpdateFinalDayLabel();
end;

local u68 = {
    LuckyStyleSpins = "rbxassetid://125339871021518",
    LuckyFlowSpins = "rbxassetid://125339871021518"
};

function v1.EnsureShopBuilt(u69, p70) -- Line: 437
    if u69.ShopTiles then
        return;
    end;

    local EgosWorldShop = u69.Frames.EgosWorldShop;
    local ScrollingFrame = EgosWorldShop:FindFirstChild("ScrollingFrame");

    if not ScrollingFrame then
        return;
    end;

    local v71 = {};

    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("Frame") and tonumber(child.Name) then
            v71[tonumber(child.Name)] = child;
        end;
    end;

    local v72 = v71[1];

    if not v72 then
        return;
    end;

    for i = 1, #p70 do
        local v73 = v71[i];

        if not v73 then
            v73 = v72:Clone();
            v73.Name = tostring(i);
            v73.Parent = ScrollingFrame;
            v71[i] = v73;
        end;

        v73.LayoutOrder = i;
        local _ = i;
    end;

    for i = #p70 + 1, #v71 do
        local v74;

        if v71[i] then
            v71[i].Visible = false;
            v74 = i;
        else
            v74 = i;
        end;
    end;

    u69.ShopTiles = v71;
    u69.ShopTileItems = {};

    for i = 1, #p70 do
        local u75 = v71[i];
        u75.EgoCoins.Activated:Connect(function() -- Line: 467
            -- upvalues: u69 (copy), u75 (copy)
            local v76 = u69.ShopTileItems[u75];

            if v76 then
                u69:AttemptPurchase(v76);
            end;
        end);
        u75.Robux.Activated:Connect(function() -- Line: 471
            -- upvalues: u69 (copy), u75 (copy)
            local v77 = u69.ShopTileItems[u75];

            if v77 then
                u69:PromptRobuxPurchase(v77);
            end;
        end);
        local _ = i;
    end;

    local WorldCoinsLabel = EgosWorldShop:FindFirstChild("WorldCoinsLabel");

    if WorldCoinsLabel then
        WorldCoinsLabel:Destroy();
    end;

    local EgoCoins = EgosWorldShop:FindFirstChild("EgoCoins");

    if EgoCoins then
        EgoCoins = EgoCoins:FindFirstChild("List");
    end;

    u69.ShopCoinsLabel = EgoCoins and EgoCoins:FindFirstChild("Currency") or nil;
end;

function v1.RenderShop(p78) -- Line: 483
    -- upvalues: u68 (copy)
    local v79 = p78.State and p78.State.Final;

    if not v79 or type(v79.ShopItems) ~= "table" then
        return;
    end;

    p78:EnsureShopBuilt(v79.ShopItems);

    if not p78.ShopTiles then
        return;
    end;

    for i, v in v79.ShopItems do
        local v80 = p78.ShopTiles[i];

        if v80 then
            v80.Visible = true;
            p78.ShopTileItems[v80] = v.Id;
            v80.ItemName.Text = v.Name;
            local Vector = v80:FindFirstChild("Vector");

            if Vector then
                if Vector:GetAttribute("DefaultImage") == nil then
                    Vector:SetAttribute("DefaultImage", Vector.Image);
                end;

                local Image = v.Image;

                if type(Image) ~= "string" or Image == "" then
                    Image = u68[v.Category];
                end;

                if type(Image) == "string" and (Image ~= "" and tonumber(Image)) then
                    Image = "rbxassetid://" .. Image;
                end;

                if type(Image) ~= "string" or (Image == "" or not Image) then
                    Image = Vector:GetAttribute("DefaultImage");
                end;

                Vector.Image = Image;
            end;

            local v81;

            if v.Owned then
                v81 = "OWNED";
            elseif v79.ShopOpen then
                if (v.MaxPurchases or 1) > 1 then
                    v81 = ("%d Ego Coins (%d left)"):format(v.Price, v.Remaining or 0);
                else
                    v81 = ("%d Ego Coins"):format(v.Price);
                end;
            else
                v81 = "CLOSED";
            end;

            v80.EgoCoins.TextLabel.Text = v81;
            local v82;

            if v.RobuxProductId == nil then
                v82 = false;
            else
                v82 = not v.Owned and v79.ShopOpen == true;
            end;

            v80.Robux.Visible = v82;

            if v82 then
                v80.Robux.TextLabel.Text = "" .. tostring(v.RobuxPrice or v.Price);
            end;

            if v.Featured then
                local v83 = v80:FindFirstChildOfClass("UIStroke");

                if v83 then
                    v83.Color = Color3.fromRGB(255, 215, 60);
                    v83.Thickness = 3;
                end;

                local FeaturedScale = v80:FindFirstChild("FeaturedScale");

                if not FeaturedScale then
                    FeaturedScale = Instance.new("UIScale");
                    FeaturedScale.Name = "FeaturedScale";
                    FeaturedScale.Parent = v80;
                end;

                FeaturedScale.Scale = 1.08;
            end;
        end;
    end;

    if p78.ShopCoinsLabel then
        local ShopCoinsLabel = p78.ShopCoinsLabel;
        local v84 = tonumber(v79.WorldCoins) or 0;
        local math_floor_ret = math.floor(v84);
        ShopCoinsLabel.Text = tostring(math_floor_ret);
    end;
end;

function v1.AttemptPurchase(u85, u86) -- Line: 544
    -- upvalues: Popup (copy)
    if u85.Purchasing then
        return;
    end;

    u85.Purchasing = true;
    task.spawn(function() -- Line: 547
        -- upvalues: u85 (copy), u86 (copy), Popup (ref)
        local v87 = u85.Service:PurchaseShopItem(u86);
        u85.Purchasing = false;

        if type(v87) ~= "table" then
            Popup.Popup(nil, (tostring(v87)));

            return;
        end;

        Popup.Popup(nil, "PURCHASED: " .. table.concat(v87.Granted or {}, ", "), 4);
        u85:RefreshState();
    end);
end;

function v1.PromptRobuxPurchase(p88, p89) -- Line: 559
    -- upvalues: MarketplaceService (copy), Players (copy)
    local v90 = p88.State and p88.State.Final;

    if not v90 then
        return;
    end;

    local v91 = nil;

    for _, v in v90.ShopItems or {} do
        if v.Id == p89 then
            v91 = v;
            break;
        end;
    end;

    if not (v91 and (v91.RobuxProductId and not v91.Owned)) then
        return;
    end;

    MarketplaceService:PromptProductPurchase(Players.LocalPlayer, v91.RobuxProductId);
end;

function v1.RenderTeamHub(p92) -- Line: 573
    -- upvalues: u68 (copy)
    local State = p92.State;
    local v93;

    if State then
        v93 = State.Final;
    else
        v93 = State;
    end;

    local v94 = State and State.Selections and State.Selections.F;

    if v94 then
        v94 = p92:GetHubFrame(v94);
    end;

    if not (v93 and v94) then
        return;
    end;

    local v95 = {};

    for _, child in v94.Background.ScrollingFrame:GetChildren() do
        if child:IsA("Frame") and child.Name == "QuestTemplate" then
            table.insert(v95, child);
        end;
    end;

    table.sort(v95, function(p96, p97) -- Line: 585
        return p96.LayoutOrder < p97.LayoutOrder;
    end);

    for i, v in v93.Quests or {} do
        local v98 = v95[i];

        if not v98 then
            break;
        end;

        v98.Visible = true;
        v98.HeaderText.Text = v.Title;
        local Bar = v98.Main.Bar;
        local Fill = Bar.Fill;

        if Fill.AnchorPoint.X ~= 0 then
            Fill.AnchorPoint = Vector2.new(0, Fill.AnchorPoint.Y);
        end;

        Fill.Position = UDim2.new(0, 0, Fill.Position.Y.Scale, Fill.Position.Y.Offset);
        local v99 = (v.Progress or 0) / math.max(v.Goal or 1, 1);
        local math_clamp_ret = math.clamp(v99, 0, 1);
        local v100;

        if (v.Claims or 0) > 0 then
            v100 = not v.Repeatable;
        else
            v100 = false;
        end;

        Bar.Fill.Size = UDim2.new(v100 and 1 or math_clamp_ret, 0, Bar.Fill.Size.Y.Scale, Bar.Fill.Size.Y.Offset);
        Bar.RedBillTotal.Text = ("%d %s"):format(v.Progress or 0, v.Unit or "");
        local Reward = v98.Main.Reward;
        local Vector = Reward:FindFirstChild("Vector");

        if Vector then
            if Vector:GetAttribute("DefaultImage") == nil then
                Vector:SetAttribute("DefaultImage", Vector.Image);
            end;

            local Image = v.Image;

            if type(Image) ~= "string" or Image == "" then
                Image = u68[v.Reward and v.Reward.Category];
            end;

            if type(Image) == "string" and (Image ~= "" and tonumber(Image)) then
                Image = "rbxassetid://" .. Image;
            end;

            if type(Image) ~= "string" or (Image == "" or not Image) then
                Image = Vector:GetAttribute("DefaultImage");
            end;

            Vector.Image = Image;
        end;

        local v101 = v.Reward or {};
        local v102 = v101.Reward or tostring(v101.Amount or "") .. " " .. tostring(v101.Category or "");

        if not v100 then
            v100 = v.Repeatable and (v.Claims or 0) > 0;
        end;

        local LockedText = Reward.LockedText;

        if not LockedText:GetAttribute("SizedUp") then
            LockedText:SetAttribute("SizedUp", true);
            LockedText.AnchorPoint = Vector2.new(0.5, 0.5);
            LockedText.Position = UDim2.new(0.5, 0, 0.5, 0);
            LockedText.Size = UDim2.new(1.9, 0, 0.6, 0);
            LockedText.ZIndex = LockedText.ZIndex + 2;
        end;

        if LockedText:GetAttribute("BaseColorR") == nil then
            LockedText:SetAttribute("BaseColorR", LockedText.TextColor3.R);
            LockedText:SetAttribute("BaseColorG", LockedText.TextColor3.G);
            LockedText:SetAttribute("BaseColorB", LockedText.TextColor3.B);
            LockedText:SetAttribute("BaseStrokeTransparency", LockedText.TextStrokeTransparency);
        end;

        Reward.ClaimedText.Visible = false;
        LockedText.Visible = true;

        if v100 then
            LockedText.Text = v.Repeatable and "Claimed x" .. tostring(v.Claims) or "Claimed";
            LockedText.TextColor3 = Color3.fromRGB(255, 255, 255);
            LockedText.TextStrokeColor3 = Color3.fromRGB(10, 60, 22);
            LockedText.TextStrokeTransparency = 0;
            Reward.ImageColor3 = Color3.fromRGB(88, 214, 110);
        else
            LockedText.Text = v102;
            LockedText.TextColor3 = Color3.new(LockedText:GetAttribute("BaseColorR"), LockedText:GetAttribute("BaseColorG"), LockedText:GetAttribute("BaseColorB"));
            LockedText.TextStrokeTransparency = LockedText:GetAttribute("BaseStrokeTransparency");
            Reward.ImageColor3 = Color3.fromRGB(255, 255, 255);
        end;
    end;
end;

function v1.Render(p103) -- Line: 653
    local State = p103.State;

    if not State then
        return;
    end;

    local v104 = State.DisplayStage == "F";

    if p103.PendingStage == State.DisplayStage then
        if State.SelectedTeam then
            if not p103.ActiveTab then
                p103.ActiveTab = v104 and "Home" or "MatchScore";
            end;
        elseif p103.ActiveTab ~= "Shop" then
            p103.ActiveTab = "Home";
        end;
    else
        p103.PendingStage = State.DisplayStage;
        p103.PendingTeam = nil;
        p103.ActiveTab = State.SelectedTeam and (v104 and "Home" or "MatchScore") or "Home";
    end;

    p103:RenderSelectionRows();

    if v104 then
        if p103.ActiveTab == "Shop" then
            p103:SetCenterPage(p103.Frames.EgosWorldShop);
            p103:RenderShop();
        elseif p103.ActiveTab == "TeamHub" and (State.Selections and State.Selections.F) then
            p103:SetCenterPage(p103:GetHubFrame(State.Selections.F));
            p103:RenderTeamHub();
        elseif State.SelectedTeam then
            p103.PendingTeam = nil;
            p103:SetCenterPage(p103.Frames.MainScore);
            p103:RenderFinalHome();
        else
            local v105;

            if State.SelectionOpen then
                v105 = p103:WireSelectCountry() or nil;
            else
                v105 = nil;
            end;

            if v105 then
                p103:SetCenterPage(v105);
                p103:RenderSelectCountry();
            else
                p103:SetCenterPage(p103.Frames.MainScore);
                p103:RenderFinalHome();
            end;
        end;
    elseif p103.ActiveTab == "MatchScore" and State.SelectedTeam then
        p103.PendingTeam = nil;
        p103:SetCenterPage(p103.Frames.AfterSelectingTeam);
        p103:RenderSelectedMatch();
    else
        local SelectTeam = p103.Frames:FindFirstChild("SelectTeam");

        if SelectTeam then
            p103:SetCenterPage(SelectTeam);
        end;
    end;

    p103:RenderEgoist();
    p103:RefreshFriends();
end;

function v1.UpdateTimer(p106) -- Line: 704
    -- upvalues: formatCountdown (copy)
    if not (p106.TimerLabel and p106.State) then
        return;
    end;

    if p106.StageEndsAt then
        local Stage = p106.State.Stage;
        p106.TimerLabel.Text = (Stage == "QF" and "Quarter Finals" or (Stage == "SF" and "Semi Finals" or (Stage == "F" and "The Final" or "World Tournament"))) .. " End In: " .. formatCountdown(p106.StageEndsAt - os.clock());
    elseif p106.EventStartsAt then
        local NextStage = p106.State.NextStage;
        p106.TimerLabel.Text = (NextStage == "QF" and "Quarter Finals" or (NextStage == "SF" and "Semi Finals" or (NextStage == "F" and "The Final" or "World Tournament"))) .. " Start In: " .. formatCountdown(p106.EventStartsAt - os.clock());
    elseif p106.State.Ended then
        local v107 = p106.State.Final and p106.State.Final.Champion;
        p106.TimerLabel.Text = v107 and string.upper(v107) .. " ARE WORLD CHAMPIONS!" or "World Tournament Complete";
    else
        p106.TimerLabel.Text = "Updating Tournament Bracket...";
    end;

    if p106.Main.Visible and p106.State.Final then
        p106:UpdateFinalDayLabel();
    end;
end;

function v1.ApplyState(p108, p109) -- Line: 721
    if type(p109) ~= "table" then
        return;
    end;

    p108.State = p109;
    local v110;

    if p109.StageEndsIn then
        v110 = os.clock() + p109.StageEndsIn or nil;
    else
        v110 = nil;
    end;

    p108.StageEndsAt = v110;
    local v111;

    if p109.EventStartsIn then
        v111 = os.clock() + p109.EventStartsIn or nil;
    else
        v111 = nil;
    end;

    p108.EventStartsAt = v111;
    p108.FinalDayEndsAt = p109.Final and (p109.Final.DayEndsIn and os.clock() + p109.Final.DayEndsIn) or nil;
    p108:UpdateTimer();

    if p108.Main.Visible then
        p108:Render();
    end;
end;

function v1.RefreshState(u112) -- Line: 731
    if u112.FetchingState then
        return;
    end;

    u112.FetchingState = true;
    task.spawn(function() -- Line: 734
        -- upvalues: u112 (copy)
        local State = u112.Service:GetState();
        u112.FetchingState = false;
        u112:ApplyState(State);
    end);
end;

function v1.Open(p113) -- Line: 741
    p113.Gui.Enabled = true;
    p113.Main.Visible = true;

    if p113.Darkness then
        p113.Darkness.Visible = true;
    end;

    if p113.Hud then
        p113.Hud.Enabled = false;
    end;

    p113:RefreshState();

    if p113.State then
        p113:Render();
    end;
end;

function v1.Close(p114) -- Line: 750
    p114.Main.Visible = false;

    if p114.Darkness then
        p114.Darkness.Visible = false;
    end;

    if p114.Hud then
        p114.Hud.Enabled = true;
    end;

    p114.Gui.Enabled = false;
end;

function v1.OpenBundles(p115) -- Line: 757
    if not p115.BundleGui then
        return;
    end;

    p115.ReturnToCupOnBundleClose = p115.Main.Visible == true;
    p115.Main.Visible = false;

    if p115.Hud then
        p115.Hud.Enabled = false;
    end;

    p115.BundleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    p115.BundleGui.Enabled = true;
end;

function v1.CloseBundles(p116) -- Line: 766
    if not p116.BundleGui then
        return;
    end;

    p116.BundleGui.Enabled = false;

    if p116.ReturnToCupOnBundleClose then
        p116.Main.Visible = true;

        if p116.Darkness then
            p116.Darkness.Visible = true;
        end;

        if p116.Hud then
            p116.Hud.Enabled = false;
        end;

        p116:RefreshState();

        if p116.State then
            p116:Render();
        end;
    elseif p116.Hud then
        p116.Hud.Enabled = true;
    end;
end;

function v1.KnitStart(u117) -- Line: 780
    -- upvalues: KnitClient (copy), Popup (copy), LocalPlayer (copy), createTeamMarker (copy), formatScore (copy), u2 (copy), ReplicatedStorage (copy)
    u117.Service = KnitClient.GetService("BlueLockCupService");
    task.spawn(function() -- Line: 783
        -- upvalues: u117 (copy), Popup (ref)
        local BlueLockCup = workspace:WaitForChild("GameObjects"):WaitForChild("LobbyNPCs"):WaitForChild("BlueLockCup", 30);

        if BlueLockCup then
            BlueLockCup = BlueLockCup:WaitForChild("HumanoidRootPart", 5);
        end;

        if BlueLockCup then
            BlueLockCup = BlueLockCup:WaitForChild("Prox", 5);
        end;

        if BlueLockCup then
            BlueLockCup.Triggered:Connect(function() -- Line: 789
                -- upvalues: u117 (ref), Popup (ref)
                if not u117.Main then
                    Popup.Popup(nil, "World Cup UI is still loading...");

                    return;
                end;

                if u117.Main.Visible then
                    u117:Close();

                    return;
                end;

                u117:Open();
            end);
        end;
    end);
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    u117.Gui = PlayerGui:WaitForChild("BlueLockWorldCup");
    u117.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    u117.Main = u117.Gui:WaitForChild("BluelockWorldCup");
    u117.Frames = u117.Main:WaitForChild("Frames");
    u117.Darkness = u117.Gui:FindFirstChild("DarknessForFrames(Optional)");
    u117.Hud = PlayerGui:FindFirstChild("HUD");
    u117.BundleGui = PlayerGui:WaitForChild("WorldTournamentBundles", 5);

    if u117.BundleGui then
        u117.BundleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        u117.BundleGui.Enabled = false;
    end;

    u117.Main.Visible = false;

    if u117.Darkness then
        u117.Darkness.Visible = false;
    end;

    u117.RowTeams = {};
    local Header = u117.Main:FindFirstChild("Header");
    local v118;

    if Header then
        v118 = Header:FindFirstChild("TextLabel");
    else
        v118 = Header;
    end;

    if v118 then
        v118.Position = UDim2.new(v118.Position.X.Scale, v118.Position.X.Offset, 0.36, 0);
        v118.Size = UDim2.new(v118.Size.X.Scale, v118.Size.X.Offset, 0.4, 0);
        local StageTimer = Header:FindFirstChild("StageTimer");

        if not StageTimer then
            StageTimer = v118:Clone();
            StageTimer.Name = "StageTimer";
            StageTimer.Parent = Header;
        end;

        StageTimer.Position = UDim2.new(v118.Position.X.Scale, v118.Position.X.Offset, 0.72, 0);
        StageTimer.Size = UDim2.new(v118.Size.X.Scale, v118.Size.X.Offset, 0.28, 0);
        StageTimer.TextXAlignment = Enum.TextXAlignment.Left;
        StageTimer.TextYAlignment = Enum.TextYAlignment.Center;
        StageTimer.TextScaled = true;
        StageTimer.AutoLocalize = false;
        u117.TimerLabel = StageTimer;
    end;

    local FriendLeaderboard = u117.Frames:FindFirstChild("FriendLeaderboard");

    if FriendLeaderboard then
        FriendLeaderboard = FriendLeaderboard:FindFirstChild("ScrollingFrame");
    end;

    local v119;

    if FriendLeaderboard then
        v119 = FriendLeaderboard:FindFirstChild("1");
    else
        v119 = FriendLeaderboard;
    end;

    if v119 then
        u117.FriendTemplate = v119:Clone();
        u117.FriendTemplate.Parent = nil;

        for _, child in FriendLeaderboard:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;
    end;

    pcall(function() -- Line: 845
        -- upvalues: u117 (copy), createTeamMarker (ref), formatScore (ref)
        local Bar = u117.Frames.AfterSelectingTeam.CurrentTeamVs.MatchResults.Bar;
        local Parent = Bar.Parent;
        local CountryName1 = Bar.GameStats.Game1Country.CountryName1;
        u117.TeamAMarker = createTeamMarker(Parent, CountryName1, "YourTeamA", 0.2);
        u117.TeamBMarker = createTeamMarker(Parent, CountryName1, "YourTeamB", 0.8);
        u117.MatchVisual = {
            A = Instance.new("NumberValue"),
            B = Instance.new("NumberValue")
        };
        u117.MatchVisual.A:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 852
            -- upvalues: Bar (copy), formatScore (ref), u117 (ref)
            Bar.RedBillTotal.Text = formatScore(u117.MatchVisual.A.Value) .. " Total";
        end);
        u117.MatchVisual.B:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 855
            -- upvalues: Bar (copy), formatScore (ref), u117 (ref)
            Bar.BlueBilLotal.Text = formatScore(u117.MatchVisual.B.Value) .. " Total";
        end);
    end);
    local SelectTeam = u117.Frames:FindFirstChild("SelectTeam");

    if SelectTeam then
        SelectTeam = SelectTeam:FindFirstChild("GroupStandings");
    end;

    if SelectTeam then
        SelectTeam = SelectTeam:FindFirstChild("GroupSelect");
    end;

    local function selectTeamFromRow(p120) -- Line: 863
        -- upvalues: u117 (copy), Popup (ref)
        if not (u117.State and u117.State.SelectionOpen) then
            Popup.Popup(nil, "Team selection is not open yet");

            return;
        end;

        local v121 = u117.RowTeams[p120];

        if v121 then
            u117.PendingTeam = v121;
            u117:RenderSelectionRows();
        end;
    end;

    if SelectTeam then
        for _, v in u2 do
            local v122 = SelectTeam:FindFirstChild(v);

            if v122 then
                v122 = v122:FindFirstChild("ScrollingFrame");
            end;

            if v122 then
                for i = 1, 2 do
                    local v123 = v122:FindFirstChild((tostring(i)));
                    local v124;

                    if v123 then
                        local Tick = v123.Checkbox.Tick;
                        local SelectionButton = v123:FindFirstChild("SelectionButton");

                        if not SelectionButton then
                            SelectionButton = Instance.new("TextButton");
                            SelectionButton.Name = "SelectionButton";
                            SelectionButton.AnchorPoint = Vector2.new(0.5, 0.5);
                            SelectionButton.Position = UDim2.fromScale(0.5, 0.5);
                            SelectionButton.Size = UDim2.fromScale(1, 1);
                            SelectionButton.BackgroundTransparency = 1;
                            SelectionButton.Text = "";
                            SelectionButton.AutoButtonColor = false;
                            SelectionButton.Selectable = false;
                            SelectionButton.ZIndex = math.max(v123.ZIndex, Tick.ZIndex) + 1;
                            SelectionButton.Parent = v123;
                        end;

                        SelectionButton.Activated:Connect(function() -- Line: 898
                            -- upvalues: Tick (copy), u117 (copy), Popup (ref)
                            if not (u117.State and u117.State.SelectionOpen) then
                                Popup.Popup(nil, "Team selection is not open yet");

                                return;
                            end;

                            local v125 = u117.RowTeams[Tick];

                            if v125 then
                                u117.PendingTeam = v125;
                                u117:RenderSelectionRows();
                            end;
                        end);
                        Tick.Activated:Connect(function() -- Line: 901
                            -- upvalues: Tick (copy), u117 (copy), Popup (ref)
                            if not (u117.State and u117.State.SelectionOpen) then
                                Popup.Popup(nil, "Team selection is not open yet");

                                return;
                            end;

                            local v126 = u117.RowTeams[Tick];

                            if v126 then
                                u117.PendingTeam = v126;
                                u117:RenderSelectionRows();
                            end;
                        end);
                        v124 = i;
                    else
                        v124 = i;
                    end;
                end;
            end;
        end;

        local ConfirmButtons = SelectTeam:FindFirstChild("ConfirmButtons");

        if ConfirmButtons then
            ConfirmButtons.Activated:Connect(function() -- Line: 910
                -- upvalues: u117 (copy)
                u117:ConfirmPendingTeam();
            end);
        end;
    end;

    local List = u117.Main.BottomButtons.List;
    local WorldCupHome = List:FindFirstChild("WorldCupHome");

    if WorldCupHome then
        WorldCupHome.Activated:Connect(function() -- Line: 919
            -- upvalues: u117 (copy)
            u117.ActiveTab = "Home";

            if u117.State then
                u117:Render();
            end;
        end);
    end;

    local GroupStage = List:FindFirstChild("GroupStage");

    if GroupStage then
        GroupStage.Activated:Connect(function() -- Line: 926
            -- upvalues: u117 (copy), Popup (ref)
            if not (u117.State and u117.State.SelectedTeam) then
                Popup.Popup(nil, "Select a team first");

                return;
            end;

            u117.ActiveTab = "MatchScore";
            u117:Render();
        end);
    end;

    local WorldCalender = List:FindFirstChild("WorldCalender");

    if WorldCalender then
        WorldCalender.Activated:Connect(function() -- Line: 937
            -- upvalues: u117 (copy)
            u117:OpenBundles();
        end);
    end;

    local TeamHub = List:FindFirstChild("TeamHub");

    if TeamHub then
        TeamHub.Activated:Connect(function() -- Line: 943
            -- upvalues: u117 (copy), Popup (ref)
            if not u117.State or u117.State.DisplayStage ~= "F" then
                Popup.Popup(nil, "Team Hubs unlock during the Final");

                return;
            end;

            if u117.State.Selections and u117.State.Selections.F then
                u117.ActiveTab = "TeamHub";
                u117:Render();

                return;
            end;

            Popup.Popup(nil, "Pick your Final team first");
            u117.ActiveTab = "Home";
            u117:Render();
        end);
    end;

    local EgosWorldShop = List:FindFirstChild("EgosWorldShop");

    if EgosWorldShop then
        EgosWorldShop.Activated:Connect(function() -- Line: 960
            -- upvalues: u117 (copy), Popup (ref)
            if not u117.State or u117.State.DisplayStage ~= "F" then
                Popup.Popup(nil, "The Egos World Shop opens during the Final");

                return;
            end;

            u117.ActiveTab = "Shop";
            u117:Render();
        end);
    end;

    local CupBundles = List:FindFirstChild("CupBundles");

    if not CupBundles and (WorldCupHome and u117.BundleGui) then
        CupBundles = WorldCupHome:Clone();
        CupBundles.Name = "CupBundles";
        CupBundles.LayoutOrder = (EgosWorldShop and EgosWorldShop.LayoutOrder or WorldCupHome.LayoutOrder) + 1;
        local ReminderText = CupBundles:FindFirstChild("ReminderText", true);

        if ReminderText then
            ReminderText.Visible = false;
        end;

        local v127 = CupBundles:FindFirstChildWhichIsA("TextLabel", true);

        if v127 then
            v127.Text = "Cup Bundles";
        end;

        CupBundles.Parent = List;
    end;

    if CupBundles then
        CupBundles.Activated:Connect(function() -- Line: 981
            -- upvalues: u117 (copy)
            u117:OpenBundles();
        end);
    end;

    local v128 = u117.BundleGui and u117.BundleGui:FindFirstChild("Frame");
    local v129 = v128 and v128:FindFirstChild("BG") and v128.BG:FindFirstChild("Close");

    if v129 then
        v129.Activated:Connect(function() -- Line: 988
            -- upvalues: u117 (copy)
            u117:CloseBundles();
        end);
    end;

    u117.Main.Header.CloseButton.Activated:Connect(function() -- Line: 992
        -- upvalues: u117 (copy)
        u117:Close();
    end);
    local RE = ReplicatedStorage.Packages.Knit.Services.BlueLockCupService.RE;
    RE.StateChanged.OnClientEvent:Connect(function() -- Line: 997
        -- upvalues: u117 (copy)
        u117:RefreshState();
    end);
    RE.RewardsGranted.OnClientEvent:Connect(function(p130) -- Line: 1000
        -- upvalues: Popup (ref), u117 (copy)
        for _, v in p130 do
            local v131 = v.Granted and (table.concat(v.Granted, ", ") or "") or "";

            if v.Type == "StageWin" then
                local Popup2 = Popup.Popup;
                local string_upper_ret = string.upper(v.Team or "YOUR TEAM");
                local Stage = v.Stage;
                Popup2(nil, ("%s WON THE %s! %s"):format(string_upper_ret, string.upper(Stage == "QF" and "Quarter Finals" or (Stage == "SF" and "Semi Finals" or (Stage == "F" and "The Final" or "World Tournament"))), v131), 4);
            elseif v.Type == "Champion" then
                Popup.Popup(nil, ("%s ARE WORLD CHAMPIONS! %s"):format(string.upper(v.Team or "YOUR TEAM"), v131), 5);
            elseif v.Type == "Quest" then
                Popup.Popup(nil, ("QUEST COMPLETE: %s! %s"):format(string.upper(v.Title or "TEAM HUB QUEST"), v131), 4);
            elseif v.Type == "Weekly" then
                Popup.Popup(nil, "EGOIST OF THE WEEK: " .. v131, 4);
            end;
        end;

        u117:RefreshState();
    end);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 1026
        -- upvalues: u117 (copy), LocalPlayer (ref)
        if u117.Main.Visible and (LocalPlayer.Team and LocalPlayer.Team.Name ~= "Visitor") then
            u117:Close();
        end;
    end);
    u117:RefreshState();
    task.spawn(function() -- Line: 1031
        -- upvalues: u117 (copy)
        local v132 = 0;

        while true do
            task.wait(1);
            u117:UpdateTimer();

            if u117.EventStartsAt and os.clock() >= u117.EventStartsAt then
                u117.EventStartsAt = nil;
                u117:RefreshState();
            end;

            if u117.StageEndsAt and os.clock() >= u117.StageEndsAt then
                u117.StageEndsAt = nil;
                u117:RefreshState();
            end;

            if u117.FinalDayEndsAt and os.clock() >= u117.FinalDayEndsAt then
                u117.FinalDayEndsAt = nil;
                u117:RefreshState();
            end;

            if u117.Main.Visible then
                v132 = v132 + 1;

                if (u117.State and u117.State.RefreshInterval or 30) <= v132 then
                    u117:RefreshState();
                    v132 = 0;
                end;
            end;
        end;
    end);
end;

return v1;