 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("SocialService");
game:GetService("HttpService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.TopbarPlus);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local RankingBrackets = require(ReplicatedStorage.Shared.Tables.RankingBrackets);
local WheelItems = require(ReplicatedStorage.Shared.Tables.WheelItems);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles).Styles;
local Zones = require(ReplicatedStorage.Shared.Tables.Zones).Zones;
local IsMatch = require(ReplicatedStorage.Shared.Functions.IsMatch);
local v1 = Knit.CreateController({
    Name = "PartyController"
});
local u2 = nil;
local u3 = nil;
local u4 = {};

function v1.SpawnPlayers(u5) -- Line: 33
    -- upvalues: LocalPlayer (copy), u2 (ref), Effects (copy), u4 (copy), Essentials (copy), Players (copy)
    local Party = LocalPlayer.PlayerGui.Party;
    local Party2 = Party.BG.TabContainer.Party;
    local u6 = {};

    local function invite(p7) -- Line: 40
        -- upvalues: u2 (ref), Effects (ref)
        local v8, v9 = u2:Invite(p7);

        if v8 then
            Effects:Popup("Invited player to party!");

            return;
        end;

        Effects:Popup(v9);
    end;

    local function ConnectionsFunc(u10, u11) -- Line: 49
        -- upvalues: u6 (ref), u2 (ref), Effects (ref), u4 (ref), u5 (copy), Party2 (copy), LocalPlayer (ref), Essentials (ref)
        local u12 = tick();
        u6[u10] = u10.MouseButton1Click:Connect(function() -- Line: 51
            -- upvalues: u12 (ref), u11 (copy), u2 (ref), Effects (ref)
            if u12 > tick() then
                return;
            end;

            u12 = tick() + 1;
            local v13, v14 = u2:Invite(u11);

            if v13 then
                Effects:Popup("Invited player to party!");

                return;
            end;

            Effects:Popup(v14);
        end);
        u6[u10.Name .. "Invite"] = u10.Invite.MouseButton1Click:Connect(function() -- Line: 56
            -- upvalues: u12 (ref), u11 (copy), u2 (ref), Effects (ref)
            if u12 > tick() then
                return;
            end;

            u12 = tick() + 1;
            local v15, v16 = u2:Invite(u11);

            if v15 then
                Effects:Popup("Invited player to party!");

                return;
            end;

            Effects:Popup(v16);
        end);
        u6[u10.Name .. "Accept"] = u10.Accept.MouseButton1Click:Connect(function() -- Line: 61
            -- upvalues: u12 (ref), u4 (ref), u10 (copy), u2 (ref), Effects (ref), u5 (ref), Party2 (ref), LocalPlayer (ref), Essentials (ref)
            if u12 > tick() then
                return;
            end;

            u12 = tick() + 1;

            if not u4[u10.Name] then
                return;
            end;

            local v17, v18, _, v19 = u2:AcceptInvite(u10:GetAttribute("PartyId"));

            if not v17 then
                Effects:Popup(v18);

                return;
            end;

            u10.Accept.Visible = false;
            Effects:Popup("Joined party!");
            u10:SetAttribute("PartyId", nil);
            table.clear(u5.InParty);

            for _, child in Party2.Party:GetChildren() do
                if child.Name ~= LocalPlayer.Name and child:IsA("ImageLabel") then
                    child:Destroy();
                end;
            end;

            for _, v in v18 do
                if not u5.InParty[v] and v ~= LocalPlayer then
                    local v20 = script.PartyPlayer:Clone();
                    v20.Actual.Text = `@{v.Name}`;
                    v20.Display.Text = tostring(v.DisplayName);
                    v20.PlayerBG.PlayerIcon.Image = `rbxthumb://type=AvatarHeadShot&id={v.UserId}&w=180&h=180`;
                    v20.Parent = Party2.Party;
                    v20.LayoutOrder = 2;
                    v20.Name = v.Name;
                    u5.InParty[v] = v;
                end;
            end;

            local PartySize = Party2.PartySize;
            local v21 = Essentials:TableLength(u5.InParty) + 1;
            PartySize.Text = `YOUR PARTY {tostring(v21)}/{u5.maxPartySize}`;
            Party2.Party.Leave.Visible = true;
            Party2.Shard.Text = `Queue Region: {v19}`;

            if v19 == u5.MyShard then
                Party2.Shard.TextColor3 = Color3.new(1, 1, 1);

                return;
            end;

            Party2.Shard.TextColor3 = Color3.new(1, 0, 0);
        end);
        u6[u10.Name .. "Changes"] = u10:GetAttributeChangedSignal("PartyId"):Connect(function() -- Line: 108
            -- upvalues: u10 (copy), u6 (ref)
            if u10:GetAttribute("PartyId") ~= "" then
                u10.Accept.Visible = true;
                u6[u10.Name .. "Changes"]:Disconnect();
                u6[u10.Name .. "Changes"] = nil;
            end;
        end);
    end;

    local function Clear() -- Line: 117
        -- upvalues: Party2 (copy), u6 (ref)
        for _, child in Party2.OptionPlayers:GetChildren() do
            if u6[child] then
                u6[child]:Disconnect();
                u6[child] = nil;
            end;

            if u6[child.Name .. "Accept"] then
                u6[child.Name .. "Accept"]:Disconnect();
                u6[child.Name .. "Accept"] = nil;
            end;

            if u6[child.Name .. "Changes"] then
                u6[child.Name .. "Changes"]:Disconnect();
                u6[child.Name .. "Changes"] = nil;
            end;

            if u6[child.Name .. "Invite"] then
                u6[child.Name .. "Invite"]:Disconnect();
                u6[child.Name .. "Invite"] = nil;
            end;

            if child:IsA("ImageButton") then
                child:Destroy();
            end;
        end;

        u6 = {};
    end;

    local function Lobby() -- Line: 163
        -- upvalues: LocalPlayer (ref), Party2 (copy), u4 (ref), ConnectionsFunc (copy)
        for _, v in game.Players:GetPlayers() do
            if v ~= LocalPlayer and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and not Party2.OptionPlayers:FindFirstChild(v.Name))) then
                local v22 = script.OptionPlayer:Clone();
                v22.Name = v.Name;
                v22.Display.Text = tostring(v.DisplayName);
                v22.PlayerBG.PlayerIcon.Image = `rbxthumb://type=AvatarHeadShot&id={v.UserId}&w=180&h=180`;
                v22.Actual.Text = `@{v.Name}`;
                v22.Parent = Party2.OptionPlayers;
                v22:SetAttribute("PartyId", u4[v.Name]);

                if u4[v.Name] then
                    v22.Accept.Visible = true;
                end;

                if LocalPlayer:IsFriendsWith(v.UserId) then
                    v22.LayoutOrder = 0;
                else
                    v22.LayoutOrder = 1;
                end;

                ConnectionsFunc(v22, v);
            end;
        end;
    end;

    local u25 = {
        All = function() -- Line: 188, Name: SpawnAll
            -- upvalues: Lobby (copy)
            Lobby();
        end,

        Lobby = Lobby,

        Friends = function() -- Line: 130, Name: Friends
            -- upvalues: Players (ref), LocalPlayer (ref), Party2 (copy), u4 (ref), ConnectionsFunc (copy)
            local v23 = {};

            for _, v in Players:GetPlayers() do
                if v ~= LocalPlayer and v:IsFriendsWith(LocalPlayer.UserId) then
                    table.insert(v23, v);
                end;
            end;

            for _, v in v23 do
                if v ~= LocalPlayer and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and not Party2.OptionPlayers:FindFirstChild(v.Name))) then
                    local v24 = script.OptionPlayer:Clone();
                    v24.Name = v.Name;
                    v24.Display.Text = tostring(v.DisplayName);
                    v24.PlayerBG.PlayerIcon.Image = `rbxthumb://type=AvatarHeadShot&id={v.UserId}&w=180&h=180`;
                    v24.Actual.Text = `@{v.Name}`;
                    v24.Parent = Party2.OptionPlayers;
                    v24:SetAttribute("PartyId", u4[v24.Name]);
                    v24.LayoutOrder = 1;

                    if u4[v.Name] then
                        v24.Accept.Visible = true;
                    end;

                    ConnectionsFunc(v24, v);
                end;
            end;
        end
    };
    Lobby();
    Party:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 201
        -- upvalues: Party (copy), Clear (copy), Lobby (copy)
        if Party.Enabled then
            Clear();
            Lobby();
        end;
    end);

    for _, child in Party2.Options:GetChildren() do
        if child:IsA("ImageButton") then
            child.MouseButton1Click:Connect(function() -- Line: 210
                -- upvalues: Clear (copy), u25 (copy), child (copy)
                Clear();
                u25[child.Name]();
            end);
        end;
    end;

    game.Players.PlayerAdded:Connect(function(p26) -- Line: 217
        -- upvalues: Party2 (copy), LocalPlayer (ref), ConnectionsFunc (copy)
        if not p26.Character then
            p26.CharacterAdded:Wait();
        end;

        if not p26.Character:WaitForChild("HumanoidRootPart", 10) then
            return;
        end;

        local v27 = script.OptionPlayer:Clone();
        v27.Name = p26.Name;
        v27.Display.Text = p26.DisplayName;
        v27.Actual.Text = `@{p26.Name}`;
        v27.Parent = Party2.OptionPlayers;

        if LocalPlayer:IsFriendsWith(p26.UserId) then
            v27.LayoutOrder = 0;
        else
            v27.LayoutOrder = 1;
        end;

        ConnectionsFunc(v27, p26);
    end);
    game.Players.PlayerRemoving:Connect(function(p28) -- Line: 236
        -- upvalues: Party2 (copy), u6 (ref)
        for _, child in Party2.OptionPlayers:GetChildren() do
            if u6[child] then
                u6[child]:Disconnect();
                u6[child] = nil;
            end;

            if u6[child.Name .. "Accept"] then
                u6[child.Name .. "Accept"]:Disconnect();
                u6[child.Name .. "Accept"] = nil;
            end;

            if u6[child.Name .. "Changes"] then
                u6[child.Name .. "Changes"]:Disconnect();
                u6[child.Name .. "Changes"] = nil;
            end;

            if u6[child.Name .. "Invite"] then
                u6[child.Name .. "Invite"]:Disconnect();
                u6[child.Name .. "Invite"] = nil;
            end;

            if child.Name == p28.Name then
                child:Destroy();
            end;
        end;
    end);
end;

function v1.Party(u29) -- Line: 250
    -- upvalues: LocalPlayer (copy), Essentials (copy), u2 (ref), Effects (copy), u4 (copy)
    local Party = LocalPlayer.PlayerGui.Party.BG.TabContainer.Party;
    local v30 = script.PartyPlayer:Clone();
    v30.Actual.Text = `@{LocalPlayer.Name}`;
    v30.Display.Text = tostring(LocalPlayer.DisplayName);
    v30.Parent = Party.Party;
    v30.PlayerBG.PlayerIcon.Image = `rbxthumb://AvatarHeadShot&id={LocalPlayer.UserId}&w=180&h=180`;
    v30.LayoutOrder = 1;
    v30.Name = LocalPlayer.Name;
    u29.InParty = {};
    local PartySize = Party.PartySize;
    local v31 = Essentials:TableLength(u29.InParty) + 1;
    PartySize.Text = `YOUR PARTY {tostring(v31)}/{u29.maxPartySize}`;
    u2.Promoted:Connect(function() -- Line: 266
        -- upvalues: Effects (ref)
        Effects:Popup("You are the new leader of the party!");
    end);
    u2.MemberAdded:Connect(function(p32) -- Line: 270
        -- upvalues: u29 (copy), Party (copy), Essentials (ref)
        if u29.InParty[p32] then
            return;
        end;

        local v33 = script.PartyPlayer:Clone();
        v33.Actual.Text = `@{p32.Name}`;
        v33.Display.Text = tostring(p32.DisplayName);
        v33.PlayerBG.PlayerIcon.Image = `rbxthumb://type=AvatarHeadShot&id={p32.UserId}&w=180&h=180`;
        v33.Parent = Party.Party;
        v33.LayoutOrder = 2;
        v33.Name = p32.Name;
        u29.InParty[p32] = p32;
        local PartySize2 = Party.PartySize;
        local v34 = Essentials:TableLength(u29.InParty) + 1;
        PartySize2.Text = `YOUR PARTY {tostring(v34)}/{u29.maxPartySize}`;
        Party.Party.Leave.Visible = true;
    end);
    u2.MemberLeft:Connect(function(p35) -- Line: 286
        -- upvalues: u29 (copy), Party (copy), Essentials (ref)
        u29.InParty[p35] = nil;
        Party.Party:FindFirstChild(p35.Name):Destroy();
        Party.PartySize.Text = `YOUR PARTY {Essentials:TableLength(u29.InParty) + 1}/{u29.maxPartySize}`;

        if Essentials:TableLength(u29.InParty) <= 0 then
            Party.Party.Leave.Visible = false;
        end;
    end);
    u2.InviteReceived:Connect(function(p36, p37) -- Line: 295
        -- upvalues: Effects (ref), Party (copy), u4 (ref)
        Effects:Popup((`{p36} invited you to their party!`));

        for _, child in Party.OptionPlayers:GetChildren() do
            print(child.Name);

            if child.Name == p36.Name then
                local Name = child.Name;
                u4[child.Name] = p37;
                task.delay(55, function() -- Line: 303
                    -- upvalues: u4 (ref), Name (copy)
                    u4[Name] = nil;
                end);
                child:SetAttribute("PartyId", p37);

                return;
            end;
        end;
    end);
    u2.ShardUpdated:Connect(function(p38) -- Line: 312
        -- upvalues: Party (copy), u29 (copy)
        Party.Shard.Text = `Queue Region: {p38}`;

        if p38 == u29.MyShard then
            Party.Shard.TextColor3 = Color3.new(1, 1, 1);

            return;
        end;

        Party.Shard.TextColor3 = Color3.new(1, 0, 0);
    end);
    local u39 = tick();
    Party.Party.Leave.MouseButton1Click:Connect(function() -- Line: 323
        -- upvalues: u39 (ref), u2 (ref), Effects (ref), u29 (copy), Party (copy), LocalPlayer (ref), Essentials (ref)
        if u39 > tick() then
            return;
        end;

        u39 = tick() + 1;
        local v40, v41 = u2:LeaveParty();

        if not v40 then
            Effects:Popup(v41);

            return;
        end;

        table.clear(u29.InParty);

        for _, child in Party.Party:GetChildren() do
            if child:IsA("ImageLabel") and (child.Name ~= "Leave" and child.Name ~= LocalPlayer.Name) then
                child:Destroy();
            end;
        end;

        Party.Party.Leave.Visible = false;
        local PartySize2 = Party.PartySize;
        local v42 = Essentials:TableLength(u29.InParty) + 1;
        PartySize2.Text = `YOUR PARTY {tostring(v42)}/{u29.maxPartySize}`;
    end);
end;

function v1.Play(u43) -- Line: 344
    -- upvalues: Knit (copy), LocalPlayer (copy), Trove (copy), u2 (ref), u3 (ref), GetUnixTime (copy), Effects (copy), Essentials (copy), RunService (copy)
    local Service = Knit.GetService("MatchmakingService");
    local Party = LocalPlayer.PlayerGui.Party;
    local Party2 = Party.BG.TabContainer.Party;
    local u44 = tick();
    local u45 = Trove.new();
    local u46 = nil;
    local PartySizes = u2:GetPartySizes();
    Party2.Play.MouseButton1Click:Connect(function() -- Line: 355
        -- upvalues: u3 (ref), GetUnixTime (ref), u44 (ref), u46 (ref), Effects (ref), u2 (ref), Party2 (copy), Party (copy)
        if u3.Player.MatchmakingInfo.BannedUntil > GetUnixTime() then
            return;
        end;

        if u44 > tick() then
            return;
        end;

        u44 = tick() + 0.15;

        if not u46 then
            Party.GamemodePicker.Visible = true;

            return;
        end;

        Effects:Popup("Cancelling match search..");
        local v47, v48 = u2:LeaveMatchQueue();
        u44 = tick() + 0.15;

        if v47 then
            Party2.Play.TextLabel.Text = "PLAY";

            return;
        end;

        Effects:Popup(v48);
    end);

    for _, child in Party.GamemodePicker.Gamemodes:GetChildren() do
        if child:IsA("ImageButton") then
            child.MouseButton1Click:Connect(function() -- Line: 382
                -- upvalues: Essentials (ref), u43 (copy), PartySizes (copy), child (copy), Effects (ref), Party (copy), u2 (ref), u44 (ref), u46 (ref), u45 (copy), Party2 (copy)
                if Essentials:TableLength(u43.InParty) + 1 > PartySizes[child.Name] then
                    Effects:Popup("Too many people in party for this gamemode!");

                    return;
                end;

                Party.GamemodePicker.Visible = false;
                Effects:Popup("Starting match search...");
                local v49, v50 = u2:QueueForMatch(child.Name);
                u44 = tick() + 0.15;

                if v49 then
                    Party2.Play.TextLabel.Text = "CANCEL";
                    u44 = tick() + 0.15;

                    return;
                end;

                if u46 then
                    u46:Destroy();
                    u46 = nil;
                end;

                u45:Clean();
                Effects:Popup(v50);
                Party2.Play.TextLabel.Text = "PLAY";
            end);
        end;
    end;

    Service.TicketLocked:Connect(function() -- Line: 409
        -- upvalues: u45 (copy), RunService (ref), u46 (ref)
        u45:Clean();
        RunService.Heartbeat:Wait();
        u46.Past.Text = "RESERVING SERVER...";
    end);
    Service.TicketError:Connect(function(p51) -- Line: 415
        -- upvalues: u43 (copy), u46 (ref), u45 (copy), Effects (ref), u44 (ref), Party2 (copy)
        u43.InQueue = false;

        if u46 then
            u46:Destroy();
            u46 = nil;
        end;

        u45:Clean();
        Effects:Popup(p51);
        u44 = tick();
        Party2.Play.TextLabel.Text = "PLAY";
    end);
    Service.TicketStarted:Connect(function(p52, p53) -- Line: 429
        -- upvalues: u43 (copy), u45 (copy), u46 (ref), LocalPlayer (ref), Essentials (ref), RunService (ref)
        u43.InQueue = true;
        u45:Clean();
        u46 = script.Queue:Clone();
        u46.Parent = LocalPlayer.PlayerGui.Misc;
        u46.Txt.Text = `Looking for {p53} match...`;
        u46.Estimated.Text = "";

        if p52 > 0 then
            u46.Estimated.Text = "Estimated time: " .. Essentials:formatTime(p52);
        end;

        local os_time_ret = os.time();
        u45:Connect(RunService.Heartbeat, function() -- Line: 444
            -- upvalues: u46 (ref), Essentials (ref), os_time_ret (copy)
            u46.Past.Text = Essentials:formatTime(os.time() - os_time_ret);
        end);
    end);
    Service.TicketCancelled:Connect(function() -- Line: 449
        -- upvalues: u43 (copy), u45 (copy), u46 (ref), Party2 (copy)
        u43.InQueue = false;
        u45:Clean();

        if u46 then
            u46:Destroy();
            u46 = nil;
        end;

        Party2.Play.TextLabel.Text = "PLAY";
    end);
end;

function v1.MatchHistory(p54) -- Line: 461
    -- upvalues: LocalPlayer (copy), u3 (ref), RunService (copy), RankingBrackets (copy), NumberUtil (copy), Styles (copy), Zones (copy)
    local Party = LocalPlayer.PlayerGui.Party;
    local MatchHistory = Party.BG.TabContainer.MatchHistory;
    local v55 = true;

    for i, v in u3.Player.Ranked do
        if MatchHistory.Gamemode:FindFirstChild(i) == nil then
            local u56 = script.TabButton:Clone();
            u56.Name = i;
            u56.TabButtonText.Text = i:upper();
            u56.Activated:Connect(function() -- Line: 473
                -- upvalues: MatchHistory (copy), u56 (ref)
                for _, child in MatchHistory.SubTabContainer:GetChildren() do
                    if child:IsA("Frame") then
                        child.Visible = child.Name == u56.Name;
                    end;
                end;
            end);
            u56.Parent = MatchHistory.Gamemode;
        end;

        local u57 = MatchHistory.SubTabContainer:FindFirstChild(i);

        if u57 == nil then
            u57 = script.MatchHistoryTab:Clone();
            u57.Name = i;
            u57.GamemodeName.Text = i:upper();
            u57.Parent = MatchHistory.SubTabContainer;
            u57.Visible = v55;
            RunService.PreRender:Connect(function(p58) -- Line: 491
                -- upvalues: Party (copy), u57 (ref)
                if not Party.Enabled then
                    return;
                end;

                local Glow = u57.RankFrame.Glow;
                Glow.Rotation = Glow.Rotation + 30 * p58;
            end);
            RunService.PreRender:Connect(function() -- Line: 499
                -- upvalues: Party (copy), v (copy), RankingBrackets (ref), u57 (ref), NumberUtil (ref)
                if not Party.Enabled then
                    return;
                end;

                if v.RR <= 1799 or v.LastPlayed + RankingBrackets.Decay.Grace > os.time() then
                    u57.DecayAlert.Visible = false;

                    return;
                end;

                u57.DecayAlert.Visible = true;
                local v59;

                if v.NextDecay == 0 then
                    v59 = v.LastPlayed + RankingBrackets.Decay.Grace + RankingBrackets.Decay.Time;
                else
                    v59 = v.NextDecay;
                end;

                local v60 = v59 - os.time();
                local math_min_ret = math.min(RankingBrackets.Decay.Rate, v.RR - 1799);
                local math_max_ret = math.max(math_min_ret, 0);

                if math_max_ret == 0 then
                    warn("decay rate is 0? should be at least 1...");
                end;

                if v60 <= 0 then
                    u57.DecayAlert.Text = `[Grace Period] You will lose {math_max_ret} RR unless you play a match now.`;
                    local DecayAlert = u57.DecayAlert;
                    local v61;

                    if os.time() % 2 == 0 then
                        v61 = Color3.new(1, 1, 1);
                    else
                        v61 = Color3.new(1, 0, 0);
                    end;

                    DecayAlert.TextColor3 = v61;

                    return;
                end;

                u57.DecayAlert.Text = `You will lose {math_max_ret} RR in {NumberUtil.AdaptiveClockString(v60)} unless you play a match.`;

                if RankingBrackets.Decay.Time // 2 <= v60 then
                    u57.DecayAlert.TextColor3 = Color3.new(1, 1, 1);

                    return;
                end;

                if v60 >= 86400 then
                    u57.DecayAlert.TextColor3 = Color3.new(1, 1, 0);

                    return;
                end;

                u57.DecayAlert.TextColor3 = Color3.new(1, 0, 0);
            end);
        end;

        local RankFrame = u57.RankFrame;
        local RR = v.RR;
        local v62, v63;

        if RR == -1 then
            v62 = nil;
            v63 = "Unplaced";
        else
            v63, v62 = RankingBrackets:GetRankFromRR(RR);
        end;

        local v64;

        if v62 then
            v64 = RankingBrackets.Icons[v63][v62];
        else
            v64 = RankingBrackets.Icons[v63];
        end;

        RankFrame.Icon.Image = v64;

        if v62 then
            RankFrame.RankText.Text = `{v63:upper()} {string.rep("I", v62)}`;
        else
            RankFrame.RankText.Text = v63:upper();
        end;

        RankFrame.RankText.TextColor3 = Color3.fromHex(RankingBrackets.ChatTags[v63][2]);

        if RR == -1 then
            local MatchesUntilPlacement = u3.Player.Ranked[i].MatchesUntilPlacement;
            RankFrame.RatingText.Text = `{MatchesUntilPlacement} MATCH{MatchesUntilPlacement > 1 and "ES" or ""} NEEDED`;
        elseif RankingBrackets:GetMaxRR() <= RR then
            RankFrame.RatingText.Text = `{RR} RR`;
        else
            local RRToNextRank, v65 = RankingBrackets:GetRRToNextRank(RR);
            RankFrame.RatingText.Text = `{RRToNextRank}/{v65} RR`;
        end;

        local v66 = i;

        for _, child in u57.History:GetChildren() do
            if child:IsA("ImageLabel") then
                child:Destroy();
            end;
        end;

        for _, v2 in v.History do
            local v67;

            if v2.Decay then
                v67 = script.MatchHistoryDecay:Clone();
            elseif v2.Penalty then
                v67 = script.MatchHistoryPenalty:Clone();
            elseif v2.Support then
                v67 = script.MatchHistorySupport:Clone();
            elseif v2.Won then
                v67 = script.MatchHistoryWin:Clone();
            else
                v67 = script.MatchHistoryLoss:Clone();
            end;

            local FinalRR = v2.FinalRR;
            local v68, v69;

            if FinalRR == -1 then
                v68 = nil;
                v69 = "Unplaced";
            else
                v69, v68 = RankingBrackets:GetRankFromRR(FinalRR);
            end;

            local v70;

            if v68 then
                v70 = RankingBrackets.Icons[v69][v68];
            else
                v70 = RankingBrackets.Icons[v69];
            end;

            v67.RankIcon.Image = v70;

            if v2.Won ~= nil then
                if v2.PlayerTeam == "Home" then
                    v67.ScoreText.Text = `{v2.Scores.Home}-{v2.Scores.Away}`;
                else
                    v67.ScoreText.Text = `{v2.Scores.Away}-{v2.Scores.Home}`;
                end;

                local v71 = Styles[v2.Style];
                local v72 = Zones[v2.Zone];
                v67.StyleInfo.StyleText.Text = (v71.UIName or v71.Name):upper();
                v67.StyleInfo.ZoneText.Text = (v72.UIName or v72.Name):upper();

                if v66 == "1v1" then
                    v67.StyleInfo.StyleText:Destroy();
                    v67.StyleInfo.ZoneText.Position = UDim2.fromScale(0, 0);
                    v67.StyleInfo.ZoneText.Size = UDim2.fromScale(1, 1);
                end;

                v67.MatchMVPText.Visible = v2.MatchMVP;
                v67.TeamMVPText.Visible = v2.TeamMVP and not v2.MatchMVP;
            end;

            if v2.RRAdjustment == nil then
                v67.PointsText.Visible = false;
            elseif v2.RRAdjustment > 0 then
                v67.PointsText.Text = `+{v2.RRAdjustment}`;
            else
                v67.PointsText.Text = `-{math.abs(v2.RRAdjustment)}`;
            end;

            v67.Parent = u57.History;
        end;

        v55 = false;
    end;
end;

function v1.Rewards(p73) -- Line: 661
    -- upvalues: LocalPlayer (copy), Effects (copy), RankingBrackets (copy), WheelItems (copy), RunService (copy), Knit (copy), Trove (copy), GetUnixTime (copy), NumberUtil (copy)
    local Party = LocalPlayer.PlayerGui.Party;
    local RankRewardsFrame = Party.BG.TabContainer.Rewards.RankRewardsFrame;
    local u74 = { "...?", "What, you thought we\'d tell you?", "It\'s a mystery for a reason!", "Are... you gonna keep clicking?", "You know, there\'s much better ways to spend your time.", "You could be scoring a 3-pointer.", "You could be getting a buzzer beater.", "You could be playing the game.", "You choose to keep pressing the button?", "The outcome won\'t change.", "You\'ll just keep hearing me.", "I\'m not going to tell you what it is.", "Stop it.", "Go away.", "Play the game.", "PLAY THE GAME!!!", "PLAY THE GAME!!!", "PLAY THE GAME!!!", "PLAY THE GAME!!!", "tatlis was here", "PLAY THE GAME!!!" };
    local u75 = 0;
    RankRewardsFrame.Parent.MysteryCosmeticButton.Activated:Connect(function() -- Line: 689
        -- upvalues: u75 (ref), u74 (copy), Effects (ref)
        u75 = u75 + 1;

        if #u74 < u75 then
            u75 = #u74;
        end;

        Effects:Popup(u74[u75], 3);
    end);

    for _, child in RankRewardsFrame.RanksFrame:GetChildren() do
        if child:IsA("ImageLabel") then
            local v76 = RankingBrackets.Icons[child.Name];

            if typeof(v76) == "table" then
                child.Icon.Image = v76[3];
            else
                child.Icon.Image = v76;
            end;

            local v77 = child;
            local v78 = 0;

            for i, v in RankingBrackets.BracketRewards[child.Name] do
                if i:sub(1, 7) ~= "Mystery" then
                    local v79 = script.RewardBox:Clone();

                    if WheelItems.Icons[i] then
                        v79.Icon.Image = WheelItems.Icons[i];

                        if i:match("^Lucky") then
                            script.Rainbow:Clone().Parent = v79.Icon;
                        end;
                    else
                        v79.Icon.Visible = false;

                        if i == "StyleSlot" then
                            v79.Label.Text = "Style Slot";
                        elseif i == "ZoneSlot" then
                            v79.Label.Text = "Zone Slot";
                        elseif i == "ChatTag" then
                            v79.Label.Text = "Chat Tag";
                        else
                            v79.Label.Text = i;
                        end;

                        v79.Label.Visible = true;
                    end;

                    if typeof(v) ~= "string" and v > 1 then
                        v79.Quantity.Text = `x{v}`;
                        v79.Quantity.Visible = true;
                    end;

                    v79.ZIndex = 999 - v78;
                    v78 = v78 + 1;
                    v79.Parent = v77.RewardFrame;
                end;
            end;
        end;
    end;

    RunService.PreRender:Connect(function(p80) -- Line: 750
        -- upvalues: Party (copy), RankRewardsFrame (copy)
        if not Party.Enabled then
            return;
        end;

        for _, child in RankRewardsFrame.RanksFrame:GetChildren() do
            if child:IsA("ImageLabel") then
                local Glow = child.Glow;
                Glow.Rotation = Glow.Rotation + 30 * p80;
            end;
        end;
    end);
    local Service = Knit.GetService("RankedSeasonService");
    local u81 = Trove.new();

    local function SeasonTimer(u82) -- Line: 766
        -- upvalues: u81 (copy), RunService (ref), GetUnixTime (ref), RankRewardsFrame (copy), NumberUtil (ref)
        u81:Clean();
        local u83 = nil;
        u81:Add(RunService.Heartbeat:Connect(function() -- Line: 771
            -- upvalues: GetUnixTime (ref), u83 (ref), u82 (copy), RankRewardsFrame (ref), NumberUtil (ref)
            local v84 = GetUnixTime();

            if v84 == u83 then
                return;
            end;

            u83 = v84;
            local v85 = u82.SeasonTime - v84;
            RankRewardsFrame.Parent.SeasonTimer.Text = `Season {u82.SeasonNumber} {v85 > 0 and "ends in " .. NumberUtil.AdaptiveClockString(v85) or "has ended"}.`;
        end));
    end;

    local u86 = Service.SeasonTimer:Get();

    if u86 ~= nil then
        u81:Clean();
        local u87 = nil;
        u81:Add(RunService.Heartbeat:Connect(function() -- Line: 771
            -- upvalues: GetUnixTime (ref), u87 (ref), u86 (copy), RankRewardsFrame (copy), NumberUtil (ref)
            local v88 = GetUnixTime();

            if v88 == u87 then
                return;
            end;

            u87 = v88;
            local v89 = u86.SeasonTime - v88;
            RankRewardsFrame.Parent.SeasonTimer.Text = `Season {u86.SeasonNumber} {v89 > 0 and "ends in " .. NumberUtil.AdaptiveClockString(v89) or "has ended"}.`;
        end));
    end;

    Service.SeasonTimer:Observe(SeasonTimer);
end;

function v1.HandleTabs(p90) -- Line: 794
    -- upvalues: LocalPlayer (copy)
    local Party = LocalPlayer.PlayerGui.Party;

    for _, child in Party.BG.TabOptions.Screens:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 800
                -- upvalues: Party (copy), child (copy)
                for _, child2 in Party.BG.TabContainer:GetChildren() do
                    if child2:IsA("Frame") then
                        child2.Visible = child2.Name == child.Name;
                    end;
                end;
            end);
        end;
    end;
end;

local function showUI() -- Line: 809
    -- upvalues: LocalPlayer (copy)
    local Party = LocalPlayer.PlayerGui.Party;
    Party.PenaltyNotice.Visible = false;
    Party.GamemodePicker.Visible = false;
    Party.BG.Visible = true;
end;

local function formatPenalty() -- Line: 817
    -- upvalues: LocalPlayer (copy), u3 (ref), GetUnixTime (copy), NumberUtil (copy)
    local Party = LocalPlayer.PlayerGui.Party;

    if not u3.Player.MatchmakingInfo.BriefedOnPenalties then
        Party.PenaltyNotice.ConfirmBG.Message.Text = "Ranked has a penalty system for bad sportsmanship and rule violations. By playing ranked games, you agree to play fair and to <b>play the matches you are given</b>.";

        return;
    end;

    local BannedUntil = u3.Player.MatchmakingInfo.BannedUntil;
    local BannedOn = u3.Player.MatchmakingInfo.BannedOn;
    local DistrustFactor = u3.Player.MatchmakingInfo.DistrustFactor;
    local v91 = GetUnixTime() < BannedUntil;
    print(u3.Player.MatchmakingInfo);
    local BanReason = u3.Player.MatchmakingInfo.BanReason;
    local v92 = BanReason == "abandoned" and "for abandoning a match" or (BanReason == "noShow" and "for not showing up to your match" or (BanReason == "staff" and "for breaking the game rules" or "for abandoning a match"));
    local v93;

    if DistrustFactor <= 10 then
        v93 = `You have received a penalty {v92}. Receiving further penalties <font color="#ff0000">will result in matchmaking cooldowns</font>. Please play fairly in future.`;
    elseif v91 then
        v93 = `You were issued a cooldown {v92} with <b>{NumberUtil.AdaptiveClockString(BannedUntil - BannedOn)}</b> remaining. Please play fairly in future, or <font color="#ff0000">further penalties will be applied</font>.`;
    else
        v93 = `You were issued a cooldown {v92}, but it has now expired. Please play fairly in future, or <font color="#ff0000">further penalties will be applied</font>.`;
    end;

    Party.PenaltyNotice.ConfirmBG.Message.Text = v93;
end;

function v1.OpenUI(p94) -- Line: 862
    -- upvalues: Knit (copy), LocalPlayer (copy), IsMatch (copy), u3 (ref), formatPenalty (copy)
    local Controller = Knit.GetController("UIController");
    local Service = Knit.GetService("CustomServerService");
    local Party = LocalPlayer.PlayerGui.Party;
    local Gamemode = Service:GetGamemode();

    if Party.Enabled then
        return;
    end;

    if IsMatch(Gamemode) then
        return;
    end;

    Party.Enabled = true;
    LocalPlayer.PlayerGui.HUD.Enabled = false;
    LocalPlayer.PlayerGui.InGame.Enabled = false;

    if u3.Player.MatchmakingInfo.UnreadPenaltyMessage or not u3.Player.MatchmakingInfo.BriefedOnPenalties then
        formatPenalty();
        Party.BG.Visible = false;
        Party.GamemodePicker.Visible = false;
        Party.PenaltyNotice.Visible = true;
    else
        local Party2 = LocalPlayer.PlayerGui.Party;
        Party2.PenaltyNotice.Visible = false;
        Party2.GamemodePicker.Visible = false;
        Party2.BG.Visible = true;
    end;

    Controller:Focus(true, Party);
end;

function v1.KnitStart(u95) -- Line: 890
    -- upvalues: u3 (ref), Knit (copy), u2 (ref), LocalPlayer (copy), RunService (copy), GetUnixTime (copy), NumberUtil (copy), Effects (copy), ReplicatedStorage (copy)
    u95.InQueue = false;
    u3 = Knit.GetController("Network");
    u2 = Knit.GetService("PartyService");
    u95.maxPartySize = u2:GetPartySize();
    local Service = Knit.GetService("MatchmakingService");
    local Party = LocalPlayer.PlayerGui.Party;
    Knit.GetController("UIController");
    Knit.GetService("CustomServerService"):GetGamemode();
    Party.PenaltyNotice.Yes.Activated:Connect(function() -- Line: 908
        -- upvalues: LocalPlayer (ref), u3 (ref), Service (copy)
        local Party2 = LocalPlayer.PlayerGui.Party;
        Party2.PenaltyNotice.Visible = false;
        Party2.GamemodePicker.Visible = false;
        Party2.BG.Visible = true;

        if u3.Player.MatchmakingInfo.BriefedOnPenalties then
            Service:AcknowledgePenalty();

            return;
        end;

        Service:AcceptBrief();
    end);
    Party.BG.Close.MouseButton1Click:Connect(function() -- Line: 918
        -- upvalues: Party (copy), LocalPlayer (ref)
        Party.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = LocalPlayer.Team == game.Teams.Visitor;
        LocalPlayer.PlayerGui.InGame.Enabled = LocalPlayer.Team ~= game.Teams.Visitor;
    end);
    u95.MyShard = u2:GetMyShard();
    Party.BG.TabContainer.Party.Shard.Text = `Queue Region: {u95.MyShard}`;
    Party.BG.TabContainer.Party.Quests.MouseButton1Click:Connect(function() -- Line: 930
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.PlayerGui.EventQuests.Enabled = true;
    end);
    LocalPlayer.PlayerGui.EventQuests:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 933
        -- upvalues: Party (copy), LocalPlayer (ref)
        Party.Enabled = not LocalPlayer.PlayerGui.EventQuests.Enabled;
    end);
    Party.GamemodePicker.CloseButton.Activated:Connect(function() -- Line: 937
        -- upvalues: Party (copy)
        Party.GamemodePicker.Visible = false;
    end);
    RunService.PreRender:Connect(function() -- Line: 941
        -- upvalues: u3 (ref), GetUnixTime (ref), Party (copy), NumberUtil (ref)
        local v96 = u3.Player.MatchmakingInfo.BannedUntil - GetUnixTime();
        local Play = Party.BG.TabContainer.Party.Play;

        if v96 <= 0 then
            Play.Active = true;
            Play.ImageColor3 = Color3.new(1, 1, 1);

            return;
        end;

        Play.Active = false;
        Play.ImageColor3 = Color3.new(0.5, 0.5, 0.5);
        Play.TextLabel.Text = NumberUtil.AdaptiveClockString(v96);
    end);
    Service.SafeToLeave:Connect(function() -- Line: 956
        -- upvalues: u2 (ref), LocalPlayer (ref), u3 (ref), Effects (ref)
        if u2:AmILeader() then
            local PartyShard = u2:GetPartyShard();
            LocalPlayer.PlayerGui.InGame.BG.Shard.Text = `Queue Region: {PartyShard}`;
            LocalPlayer.PlayerGui.InGame.BG.Shard.Visible = true;
            LocalPlayer.PlayerGui.InGame.BG.Requeue.Visible = true;
            local u97 = false;
            local u98 = false;
            LocalPlayer.PlayerGui.InGame.BG.Requeue.Activated:Connect(function() -- Line: 966
                -- upvalues: u97 (ref), u98 (ref), u2 (ref), u3 (ref), Effects (ref), LocalPlayer (ref)
                if u97 then
                    return;
                end;

                u97 = true;
                local v99, v100;

                if u98 then
                    v99, v100 = u2:LeaveMatchQueue();
                else
                    v99, v100 = u2:QueueForMatch(u3.Gamemode:sub(7));
                end;

                if v99 then
                    u98 = not u98;
                    LocalPlayer.PlayerGui.InGame.BG.Requeue.TextLabel.Text = u98 and "CANCEL" or "REQUEUE";
                else
                    Effects:Popup(v100);
                end;

                u97 = false;
            end);
        end;
    end);
    u95:Party();
    u95:SpawnPlayers();
    u95:Rewards();
    u95:MatchHistory();
    u95:Play();
    u95:HandleTabs();
    local _ = u3.Player.Ranked;
    local u101 = {};

    local function RankedChanged() -- Line: 1000
        -- upvalues: u3 (ref), u101 (copy)
        local v102 = false;

        for i, v in u3.Player.Ranked do
            local v103 = u101[i];

            if not (v103 and (v103[1] == v and (v103[2] == v.RR and (v103[3] == v.History and v103[4] == v.MatchesUntilPlacement)))) then
                u101[i] = {
                    v,
                    v.RR,
                    v.History,
                    v.MatchesUntilPlacement
                };
                v102 = true;
            end;
        end;

        return v102;
    end;

    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 1015
        -- upvalues: RankedChanged (copy), u95 (copy)
        if RankedChanged() then
            u95:MatchHistory();
        end;
    end);
    local u104 = 0;
    RunService.PreRender:Connect(function(p105) -- Line: 1024
        -- upvalues: Party (copy), u104 (ref)
        if not Party.Enabled then
            return;
        end;

        u104 = u104 + 0.03333333333333333 * p105;
        u104 = u104 % 1;
        Party.BG.Pattern.Position = UDim2.fromOffset(-u104 * 500 - 1000, -u104 * 500 - 1000);
    end);
end;

return v1;