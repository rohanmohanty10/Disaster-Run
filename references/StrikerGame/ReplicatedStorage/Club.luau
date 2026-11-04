 

 

local DataStoreService = game:GetService("DataStoreService");
local HttpService = game:GetService("HttpService");
local InsertService = game:GetService("InsertService");
local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ServerStorage = game:GetService("ServerStorage");
local TextService = game:GetService("TextService");
local packets = require(ReplicatedStorage.packets);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local u1 = {
    [50] = {
        tagText = "Protagonist Syndrome",
        tagColor = { { 0, 85, 255, 255 }, { 1, 255, 85, 255 } }
    },
    [100] = {
        tagText = "World\'s Best",
        tagColor = { { 0, 0, 0, 255 }, { 1, 0, 0, 40 } }
    }
};
local u2 = {};
local u3 = {
    Name = "",
    Chairman = 0,
    Streak = 0,
    Icon = 0,
    LastWin = 0,
    Members = {}
};
local u4 = {};
local u5 = {};
local u6 = 0;
local u7 = {};
local u8 = {
    [10] = {
        money = 2500,
        style_currency = 1500
    },
    [25] = {
        money = 5000,
        style_currency = 3750
    },
    [50] = {
        money = 12500,
        style_currency = 7500
    }
};
local u9 = {
    Club = "",
    Start = 0,
    Active = true
};
local u10 = { "Chairman", "Coach", "Member" };

for _, v in u1 do
    for _, v2 in v.tagColor do
        v2[2] = v2[2] / 255;
        v2[3] = v2[3] / 255;
        v2[4] = v2[4] / 255;
    end;
end;

local club_request = packets.club_request;
local Resources = vfxUtil.getResources();
local u11, u12, u13;

if RunService:IsServer() then
    u11 = DataStoreService:GetDataStore("Clubs");
    u12 = DataStoreService:GetOrderedDataStore("ClubStreaks");
    u13 = require(ServerStorage.profile);
else
    u12 = nil;
    u13 = nil;
    u11 = nil;
end;

local u14;

if RunService:IsClient() then
    u14 = require(ReplicatedStorage.client.replication);
else
    u14 = nil;
end;

local function round(p15: number, p16: number) -- Line: 162
    local v17 = 10 ^ p16;

    return math.round(p15 * v17) / v17;
end;

local function canCall(p18) -- Line: 167
    -- upvalues: RunService (copy), DataStoreService (copy)
    if RunService:IsServer() then
        return DataStoreService:GetRequestBudgetForRequestType(p18) > 0;
    end;

    return false;
end;

local function copy(p19) -- Line: 174
    -- upvalues: copy (copy)
    if typeof(p19) ~= "table" then
        return p19;
    end;

    local v20 = {};

    for i, v in p19 do
        v20[i] = copy(v);
    end;

    return v20;
end;

local function seconds(p21: number) -- Line: 183
    return p21 == 1 and "second" or "seconds";
end;

local function applyStreakDecay(p22) -- Line: 187
    if p22.LastWin and (p22.LastWin > 0 and os.time() - p22.LastWin > 604800) then
        p22.Streak = 0;
    end;

    return p22;
end;

local function getStreakTitleKey(p23: number) -- Line: 196
    return `ms_streak_{p23}`;
end;

local u24 = {
    Invite = {}
};

function u24.GetRank(p25) -- Line: 204
    -- upvalues: u24 (copy), u10 (copy)
    if typeof(p25) == "Instance" then
        if p25:IsA("StringValue") then
            return p25.Value;
        end;

        local v26 = p25:IsA("Player") and u24.GetMemberInfo(p25);

        if v26 then
            return v26.Rank;
        end;
    end;

    if typeof(p25) == "table" and p25.Rank then
        return p25.Rank;
    end;

    return u10[#u10];
end;

function u24.GetRankInPlace(p27) -- Line: 223
    -- upvalues: u10 (copy), u24 (copy)
    return table.find(u10, u24.GetRank(p27)) or #u10;
end;

function u24.IsRankAbove(p28, p29) -- Line: 227
    -- upvalues: u24 (copy)
    return u24.GetRankInPlace(p28) < u24.GetRankInPlace(p29);
end;

function u24.GetMemberInfo(p30: userdata) -- Line: 231
    -- upvalues: RunService (copy), u24 (copy)
    if not RunService:IsClient() then
        local ClubData, v31 = u24.GetClubData(p30);

        if ClubData and v31 then
            for _, v in ipairs(ClubData.Members) do
                if v.Id == p30.UserId then
                    return v;
                end;
            end;
        end;

        return;
    end;

    local club = p30:FindFirstChild("club");

    if not (club and club:IsA("StringValue")) then
        return;
    end;

    local Value = club.Value;

    if Value == "" then
        return;
    end;

    for _, child in script.Cache:GetChildren() do
        if child.Name == Value then
            for _, child2 in child.Members:GetChildren() do
                if child2.Name == tostring(p30.UserId) then
                    return {
                        Rank = child2.Value,
                        Id = tonumber(child2.Name),
                        Name = child2:GetAttribute("Username"),
                        MVP = child2:GetAttribute("MVPs")
                    };
                end;
            end;
        end;
    end;
end;

function u24.GetClubName(p32: string) -- Line: 267
    return p32:gsub("[^a-zA-Z]", ""):lower();
end;

function u24.Notify(p33: string, p34: userdata?) -- Line: 271
    -- upvalues: RunService (copy), u14 (ref), Resources (copy), packets (copy)
    if RunService:IsClient() then
        u14.notification(p33, nil, Resources.notisound);

        return;
    end;

    packets.bytenet_replication.sendTo({
        name = "notification",
        content = { p33, nil, Resources.notisound }
    }, p34);
end;

function u24.Invite.Key(p35: userdata, p36: userdata) -- Line: 282
    return `{p35.UserId}-{p36.UserId}`;
end;

function u24.Debounce(u37: userdata, p38: userdata?) -- Line: 286
    -- upvalues: u5 (copy), u24 (copy), u2 (copy)
    local v39 = u5[u37];

    if v39 then
        local v40 = 5 - (os.clock() - v39);
        u24.Notify(`Please wait {math.round(v40 * 100) / 100} {v40 == 1 and "second" or "seconds"}. (rate limit)`, u37);

        return false;
    end;

    local v41 = p38 and u2[u24.Invite.Key(u37, p38)];

    if v41 then
        if v41.Active then
            u24.Notify(`You already invited {p38.Name}.`, u37);
        else
            local v42 = 15 - (os.clock() - v41.Start);
            u24.Notify(`Please wait {math.round(v42 * 100) / 100} {v42 == 1 and "second" or "seconds"}. (recently declined)`, u37);
        end;

        return false;
    end;

    u5[u37] = os.clock();
    task.delay(5, function() -- Line: 314
        -- upvalues: u5 (ref), u37 (copy)
        u5[u37] = nil;
    end);

    return true;
end;

function u24.Create(u43: string, u44: userdata, p45: table) -- Line: 321
    -- upvalues: RunService (copy), club_request (copy), u24 (copy), u13 (ref), MarketplaceService (copy), InsertService (copy), TextService (copy), DataStoreService (copy), u11 (ref), copy (copy), u3 (copy)
    if RunService:IsClient() then
        club_request.send({
            name = "Create",
            content = { u43, p45 }
        });

        return;
    end;

    if typeof(u43) ~= "string" or typeof(p45) ~= "table" then
        u24.Notify("Invalid request", u44);

        return;
    end;

    if string.len(u43) > 20 then
        u24.Notify((`Max character limit reached ({#u43}/{20})`));

        return;
    end;

    local icon = p45.icon;

    if typeof(icon) ~= "number" then
        u24.Notify("Invalid request", u44);

        return;
    end;

    local Data = u13.getData(u44);

    if not Data then
        u24.Notify("Data hasn\'t loaded yet", u44);

        return;
    end;

    local Data2 = Data.profile.Data;

    if Data2.club ~= "" then
        u24.Notify("You\'re already in a club!", u44);

        return;
    end;

    if Data2.money < 10000 then
        u24.Notify("You cannot afford to purchase a club!", u44);

        return;
    end;

    local ClubName = u24.GetClubName(u43);

    if ClubName == "" then
        u24.Notify("Invalid name given", u44);

        return;
    end;

    if not u24.Debounce(u44) then
        return;
    end;

    local success, result = pcall(function() -- Line: 376
        -- upvalues: MarketplaceService (ref), icon (ref)
        return MarketplaceService:GetProductInfoAsync(icon, Enum.InfoType.Asset);
    end);

    if not success or result.AssetTypeId ~= Enum.AssetType.Image.Value then
        icon = nil;

        if result.AssetTypeId == Enum.AssetType.Decal.Value then
            local success2, result2 = pcall(function() -- Line: 383
                -- upvalues: InsertService (ref), result (copy)
                return InsertService:LoadAsset(result.AssetId);
            end);

            if success2 then
                local v46 = result2:FindFirstChildWhichIsA("Decal");

                if v46 then
                    icon = tonumber(v46.Texture:match("%d+$"));
                end;
            end;
        end;

        if not icon then
            u24.Notify("Invalid icon image", u44);

            return;
        end;
    end;

    u24.Notify("Filtering club name...", u44);
    local success2, result2 = pcall(function() -- Line: 401
        -- upvalues: TextService (ref), u43 (copy), u44 (copy)
        return TextService:FilterStringAsync(u43, u44.UserId):GetNonChatStringForBroadcastAsync();
    end);

    if success2 and result2 ~= u43 then
        u24.Notify("The name provided is unable to be used. (filtered)", u44);

        return;
    end;

    if not success2 then
        u24.Notify("Unable to filter name. (rate limit)", u44);
        warn((`Unable to create club with the name "{u43}": {result2}`));

        return;
    end;

    local GetAsync = Enum.DataStoreRequestType.GetAsync;
    local v47;

    if RunService:IsServer() then
        v47 = DataStoreService:GetRequestBudgetForRequestType(GetAsync) > 0;
    else
        v47 = false;
    end;

    if v47 then
        local SetIncrementAsync = Enum.DataStoreRequestType.SetIncrementAsync;
        local v48;

        if RunService:IsServer() then
            v48 = DataStoreService:GetRequestBudgetForRequestType(SetIncrementAsync) > 0;
        else
            v48 = false;
        end;

        if v48 then
            u24.Notify("Checking club availability...", u44);
            local success3, result3 = pcall(function() -- Line: 422
                -- upvalues: u11 (ref), ClubName (copy)
                return u11:GetAsync(ClubName);
            end);

            if not success3 or result3 then
                u24.Notify("A club with the name provided already exists!", u44);

                return;
            end;

            u24.Notify("Creating club...", u44);
            local u49 = copy(u3);
            u49.Name = u43;
            u49.Chairman = u44.UserId;
            u49.Icon = icon;
            table.insert(u49.Members, {
                Rank = "Chairman",
                MVP = 0,
                Name = u44.Name,
                Id = u44.UserId
            });
            local success4, result4 = pcall(function() -- Line: 445
                -- upvalues: u11 (ref), ClubName (copy), u49 (copy)
                u11:SetAsync(ClubName, u49);
            end);

            if not success4 then
                u24.Notify("Unable to create club. (rate limit)", u44);
                warn((`Unable to SetAsync for club "{u43}": {result4}`));

                return;
            end;

            Data:change("money", Data2.money - 10000, {
                force = true
            });
            Data:change("club", ClubName);
            u24.Notify(`Successfully created club: "{u43}"`, u44);
            u24.UpdateClub(ClubName, u49);

            return;
        end;
    end;

    u24.Notify("Unable to create club. (rate limit)", u44);
end;

function u24.UpdateClub(p50: string, p51: any) -- Line: 465
    -- upvalues: RunService (copy), u4 (copy), ServerStorage (copy)
    if not RunService:IsServer() then
        return;
    end;

    u4[p50] = p51;

    if not p51 then
        local v52 = script.Cache:FindFirstChild(p50);

        if v52 then
            v52:Destroy();
        end;

        return;
    end;

    local v53 = script.Cache:FindFirstChild(p50);

    if not v53 then
        v53 = ServerStorage.club:Clone();
        v53.Name = p50;
        v53.Parent = script.Cache;
        local Folder = Instance.new("Folder");
        Folder.Name = "Members";
        Folder.Parent = v53;
    end;

    v53.name.Value = p51.Name;
    v53.icon.Value = p51.Icon;
    v53.streak.Value = p51.Streak or 0;
    local v54 = {};

    for i, v in ipairs(p51.Members) do
        local v55 = v53:FindFirstChild((tostring(v.Id))) or script.Member:Clone();
        v55.Value = v.Rank;
        v55.Name = tostring(v.Id);
        v55:SetAttribute("Placement", i);
        v55:SetAttribute("Username", v.Name);
        v55:SetAttribute("MVPs", v.MVP);
        v55.Parent = v53.Members;
        table.insert(v54, v55.Name);
    end;

    for _, child in ipairs(v53.Members:GetChildren()) do
        if not table.find(v54, child.Name) then
            child:Destroy();
        end;
    end;
end;

function u24.UpdateBillboards(p56: string?, p57: number?, p58: number?) -- Line: 515
    -- upvalues: RunService (copy)
    if not RunService:IsServer() then
        return;
    end;

    local Billboards = workspace.map.map:FindFirstChild("Billboards");

    if Billboards then
        for _, child in Billboards:GetChildren() do
            local SurfaceGui = child.Screen.SurfaceGui;
            local v59 = tostring(p58 or "");
            local v60;

            if p58 then
                if p58 > 1 then
                    v60 = "WINNING STREAK";
                else
                    v60 = "PREVIOUS VICTOR";
                    v59 = "";
                end;
            else
                v60 = "EXHIBITION MATCH";
            end;

            SurfaceGui.Icon.Image = `rbxassetid://{p57 or 139677019336862}`;
            SurfaceGui.BottomText.Text = v60;
            SurfaceGui.Streak.Text = v59;
            SurfaceGui.ClubName.Text = string.upper(p56 or "striker game");
        end;
    end;
end;

function u24.RecordWin(p61: userdata) -- Line: 541
    -- upvalues: RunService (copy), u24 (copy), u13 (ref), DataStoreService (copy), u11 (ref), u12 (ref)
    if not RunService:IsServer() then
        return;
    end;

    local ClubData, u62 = u24.GetClubData(p61);

    if not (ClubData and u62) then
        warn((`Unable to record win for {p61.Name}: no club`));

        return;
    end;

    if not u13.canDataChange(p61) then
        warn((`Unable to record win for {u62}: invalid server`));

        return;
    end;

    local GetAsync = Enum.DataStoreRequestType.GetAsync;
    local v63;

    if RunService:IsServer() then
        v63 = DataStoreService:GetRequestBudgetForRequestType(GetAsync) > 0;
    else
        v63 = false;
    end;

    if v63 then
        local SetIncrementAsync = Enum.DataStoreRequestType.SetIncrementAsync;
        local v64;

        if RunService:IsServer() then
            v64 = DataStoreService:GetRequestBudgetForRequestType(SetIncrementAsync) > 0;
        else
            v64 = false;
        end;

        if v64 then
            local success, result = pcall(function() -- Line: 560
                -- upvalues: u11 (ref), u62 (copy)
                u11:UpdateAsync(u62, function(p65) -- Line: 561
                    if p65 then
                        if p65.LastWin and (p65.LastWin > 0 and os.time() - p65.LastWin > 604800) then
                            p65.Streak = 0;
                        end;

                        p65.Streak = (p65.Streak or 0) + 1;
                        p65.LastWin = os.time();

                        return p65;
                    end;
                end);
            end);

            if not success then
                warn((`Unable to UpdateAsync streak for club "{u62}" during RecordWin: {result}`));

                return;
            end;

            local success2, result2 = pcall(function() -- Line: 575
                -- upvalues: u11 (ref), u62 (copy)
                return u11:GetAsync(u62);
            end);

            if success2 and result2 then
                u24.UpdateClub(u62, result2);
            end;

            local u66 = success2 and (result2 and result2.Streak) or 0;
            local success3, result3 = pcall(function() -- Line: 585
                -- upvalues: u12 (ref), u62 (copy), u66 (copy)
                u12:SetAsync(u62, u66);
            end);

            if success3 then
                print((`Successfully SetAsync streak leaderboard for club "{u62}": {u66}`));
            else
                warn((`Unable to SetAsync streak leaderboard for club "{u62}": {result3}`));
            end;

            u24.CheckStreakMilestones(u62, u66);

            return;
        end;
    end;

    warn((`Unable to record win for club "{u62}": rate limited`));
end;

function u24.RecordLoss(p67: userdata) -- Line: 597
    -- upvalues: RunService (copy), u24 (copy), u13 (ref), DataStoreService (copy), u11 (ref), u12 (ref)
    if not RunService:IsServer() then
        return;
    end;

    local ClubData, u68 = u24.GetClubData(p67);

    if not (ClubData and u68) then
        return;
    end;

    if not u13.canDataChange(p67) then
        return;
    end;

    local GetAsync = Enum.DataStoreRequestType.GetAsync;
    local v69;

    if RunService:IsServer() then
        v69 = DataStoreService:GetRequestBudgetForRequestType(GetAsync) > 0;
    else
        v69 = false;
    end;

    if v69 then
        local SetIncrementAsync = Enum.DataStoreRequestType.SetIncrementAsync;
        local v70;

        if RunService:IsServer() then
            v70 = DataStoreService:GetRequestBudgetForRequestType(SetIncrementAsync) > 0;
        else
            v70 = false;
        end;

        if v70 then
            local success, result = pcall(function() -- Line: 612
                -- upvalues: u11 (ref), u68 (copy)
                u11:UpdateAsync(u68, function(p71) -- Line: 613
                    if p71 then
                        p71.Streak = 0;

                        return p71;
                    end;
                end);
            end);

            if not success then
                warn((`Unable to UpdateAsync streak for club "{u68}" during RecordLoss: {result}`));

                return;
            end;

            local success2, result2 = pcall(function() -- Line: 625
                -- upvalues: u12 (ref), u68 (copy)
                u12:SetAsync(u68, 0);
            end);

            if not success2 then
                warn((`Unable to SetAsync streak leaderboard for club "{u68}": {result2}`));
            end;

            local success3, result3 = pcall(function() -- Line: 632
                -- upvalues: u11 (ref), u68 (copy)
                return u11:GetAsync(u68);
            end);

            if success3 and result3 then
                u24.UpdateClub(u68, result3);
            end;

            u24.CheckStreakMilestones(u68, 0);

            return;
        end;
    end;

    warn((`Unable to record loss for club "{u68}": rate limited`));
end;

function u24.CheckStreakMilestones(p72: string, p73: number, p74: table?) -- Line: 643
    -- upvalues: Players (copy), u24 (copy), u13 (ref), u1 (copy), HttpService (copy)
    if not p74 then
        p74 = {};

        for _, v in Players:GetPlayers() do
            local _, v75 = u24.GetClubData(v);

            if v75 == p72 then
                table.insert(p74, v);
            end;
        end;
    end;

    for _, v in p74 do
        local Data = u13.getData(v);

        if Data then
            local special_titles = Data.profile.Data.storage.special_titles;
            local v76 = false;

            for i, v2 in u1 do
                local v77 = `ms_streak_{i}`;

                if i <= p73 then
                    special_titles[v77] = HttpService:JSONEncode(v2);
                    v76 = true;
                elseif special_titles[v77] then
                    special_titles[v77] = nil;
                    v76 = true;
                end;
            end;

            if v76 then
                Data:change("storage.special_titles", special_titles);
            end;
        end;
    end;
end;

function u24.RefreshTopClubs() -- Line: 677
    -- upvalues: RunService (copy), u6 (ref), u12 (ref), u7 (ref)
    if not RunService:IsServer() then
        return;
    end;

    if os.time() - u6 < 300 then
        return;
    end;

    local success, result = pcall(function() -- Line: 681
        -- upvalues: u12 (ref)
        return u12:GetSortedAsync(false, 25);
    end);

    if not success then
        warn((`Unable to fetch top clubs leaderboard: {result}`));

        return;
    end;

    u7 = {};
    u6 = os.time();
    local CurrentPage = result:GetCurrentPage();

    for i, v in ipairs(CurrentPage) do
        table.insert(u7, {
            club = v.key,
            streak = v.value,
            rank = i
        });
    end;
end;

function u24.GetTopClubs() -- Line: 699
    -- upvalues: u24 (copy), u7 (ref)
    u24.RefreshTopClubs();

    return u7;
end;

function u24.GetTopClubMultiplier(p78: userdata) -- Line: 704
    -- upvalues: u13 (ref), u24 (copy)
    local Data = u13.getData(p78);

    if not Data then
        return 1;
    end;

    local club = Data.profile.Data.club;

    if not club or club == "" then
        return 1;
    end;

    local TopClubs = u24.GetTopClubs();

    for _, v in ipairs(TopClubs) do
        if v.club == club then
            if v.rank >= 1 and v.rank <= 5 then
                return 2;
            end;

            if v.rank >= 6 and v.rank <= 10 then
                return 1.5;
            end;

            if v.rank >= 11 and v.rank <= 25 then
                return 1.25;
            end;
        end;
    end;

    return 1;
end;

function u24.AddMVP(u79: userdata) -- Line: 725
    -- upvalues: RunService (copy), ReplicatedStorage (copy), u24 (copy), u13 (ref), u11 (ref), u8 (copy), Players (copy)
    if not RunService:IsServer() then
        return;
    end;

    local MVC = ReplicatedStorage.MVC;
    local ClubData, u80 = u24.GetClubData(u79);

    if not (ClubData and u80) then
        MVC.ClubName.Value = "";
        MVC.Streak.Value = 0;
        MVC.Icon.Value = 0;
        u24.UpdateBillboards();

        return;
    end;

    local v81 = script.Cache:FindFirstChild(u80);

    if not v81 then
        return;
    end;

    MVC.Streak.Value = MVC.ClubName.Value == ClubData.Name and (MVC.Streak.Value + 1 or 1) or 1;
    MVC.ClubName.Value = v81.name.Value;
    MVC.Icon.Value = v81.icon.Value;
    u24.UpdateBillboards(MVC.ClubName.Value, MVC.Icon.Value, MVC.Streak.Value);

    if not u13.canDataChange(u79) then
        return;
    end;

    local success, result = pcall(function() -- Line: 755
        -- upvalues: u11 (ref), u80 (copy), u79 (copy)
        u11:UpdateAsync(u80, function(p82) -- Line: 756
            -- upvalues: u79 (ref)
            if p82 then
                for _, v in ipairs(p82.Members) do
                    if v.Id == u79.UserId then
                        v.MVP = v.MVP + 1;

                        return p82;
                    end;
                end;

                return p82;
            end;
        end);
    end);

    if not success then
        warn((`Unable to UpdateAsync MVP for "{u79.Name}" in club "{u80}": {result}`));

        return;
    end;

    local success2, result2 = pcall(function() -- Line: 773
        -- upvalues: u11 (ref), u80 (copy)
        return u11:GetAsync(u80);
    end);

    if success2 and result2 then
        u24.UpdateClub(u80, result2);
    end;

    local v83 = u8[MVC.Streak.Value];

    if v83 and #Players:GetPlayers() >= 6 then
        for _, v in Players:GetPlayers() do
            if not u13.canDataChange(v, "money") then
                return;
            end;

            if not u13.canDataChange(v, "style_currency") then
                return;
            end;

            local Data = u13.getData(v);

            if Data then
                local Data2 = Data.profile.Data;

                if Data2.club == u80 then
                    Data:change("money", Data2.money + v83.money);
                    Data:change("style_currency", Data2.style_currency + v83.style_currency);
                end;
            end;
        end;
    end;
end;

function u24.Leave(u84: userdata?) -- Line: 796
    -- upvalues: RunService (copy), club_request (copy), u24 (copy), DataStoreService (copy), u11 (ref), Players (copy), u13 (ref), u4 (copy)
    if RunService:IsClient() then
        club_request.send({
            name = "Leave",
            content = {}
        });

        return;
    end;

    if u84 then
        if not u24.Debounce(u84) then
            return;
        end;

        local GetAsync = Enum.DataStoreRequestType.GetAsync;
        local v85;

        if RunService:IsServer() then
            v85 = DataStoreService:GetRequestBudgetForRequestType(GetAsync) > 0;
        else
            v85 = false;
        end;

        if not v85 then
            u24.Notify("Unable to leave club. (rate limit)", u84);

            return;
        end;

        local SetIncrementAsync = Enum.DataStoreRequestType.SetIncrementAsync;
        local v86;

        if RunService:IsServer() then
            v86 = DataStoreService:GetRequestBudgetForRequestType(SetIncrementAsync) > 0;
        else
            v86 = false;
        end;

        if not v86 then
            u24.Notify("Unable to leave club. (rate limit)", u84);

            return;
        end;

        local ClubData, u87 = u24.GetClubData(u84, true);

        if not (ClubData and u87) then
            return;
        end;

        if ClubData.Chairman == u84.UserId then
            local success, result = pcall(function() -- Line: 820
                -- upvalues: u11 (ref), u87 (copy)
                u11:RemoveAsync(u87);
            end);

            if not success then
                u24.Notify("Unable to disband club. (rate limit)", u84);
                warn((`Unable to RemoveAsync for club "{u87}" during Leave: {result}`));

                return;
            end;

            for _, v in ipairs(ClubData.Members) do
                local PlayerByUserId = Players:GetPlayerByUserId(v.Id);

                if PlayerByUserId and PlayerByUserId ~= u84 then
                    local Data = u13.getData(PlayerByUserId);

                    if Data then
                        Data:change("club", "");
                    end;

                    u24.Notify("Your club has been disbanded by the chairman.", PlayerByUserId);
                end;
            end;

            u4[u87] = nil;
            local v88 = script.Cache:FindFirstChild(u87);

            if v88 then
                v88:Destroy();
            end;

            u24.Notify(`You've disbanded "{ClubData.Name}".`, u84);
        else
            local success, result = pcall(function() -- Line: 850
                -- upvalues: u11 (ref), u87 (copy), u84 (copy)
                u11:UpdateAsync(u87, function(p89) -- Line: 851
                    -- upvalues: u84 (ref)
                    if p89 then
                        for i, v in ipairs(p89.Members) do
                            if v.Id == u84.UserId then
                                table.remove(p89.Members, i);

                                return p89;
                            end;
                        end;

                        return p89;
                    end;
                end);
            end);

            if not success then
                u24.Notify("Unable to leave club. (rate limit)", u84);
                warn((`Unable to UpdateAsync for club "{u87}" during Leave: {result}`));

                return;
            end;

            local success2, result2 = pcall(function() -- Line: 869
                -- upvalues: u11 (ref), u87 (copy)
                return u11:GetAsync(u87);
            end);

            if success2 and result2 then
                u24.UpdateClub(u87, result2);
            end;

            u24.Notify(`You've left "{ClubData.Name}".`, u84);
        end;

        local Data = u13.getData(u84);

        if Data then
            Data:change("club", "");
        end;
    end;
end;

function u24.Kick(u90: number, p91: userdata?) -- Line: 887
    -- upvalues: RunService (copy), club_request (copy), u24 (copy), DataStoreService (copy), Players (copy), u13 (ref), u11 (ref)
    if RunService:IsClient() then
        club_request.send({
            name = "Kick",
            content = { u90 }
        });

        return;
    end;

    if p91 then
        if not u24.Debounce(p91) then
            return;
        end;

        local GetAsync = Enum.DataStoreRequestType.GetAsync;
        local v92;

        if RunService:IsServer() then
            v92 = DataStoreService:GetRequestBudgetForRequestType(GetAsync) > 0;
        else
            v92 = false;
        end;

        if not v92 then
            u24.Notify("Unable to update club. (rate limit)", p91);

            return;
        end;

        local SetIncrementAsync = Enum.DataStoreRequestType.SetIncrementAsync;
        local v93;

        if RunService:IsServer() then
            v93 = DataStoreService:GetRequestBudgetForRequestType(SetIncrementAsync) > 0;
        else
            v93 = false;
        end;

        if not v93 then
            u24.Notify("Unable to update club. (rate limit)", p91);

            return;
        end;

        local ClubData, u94 = u24.GetClubData(p91, true);

        if not (ClubData and u94) then
            return;
        end;

        local v95 = nil;
        local v96 = false;

        for _, v in ipairs(ClubData.Members) do
            if v95 or v.Id ~= p91.UserId then
                if v.Id == u90 then
                    v96 = u24.IsRankAbove(v95 or p91, v) and true or v96;
                    break;
                end;
            else
                v95 = v;
            end;
        end;

        if not v96 then
            u24.Notify("You can\'t kick this member.", p91);

            return;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(u90);

        if PlayerByUserId then
            u24.Notify(`You've been kicked from "{ClubData.Name}".`, PlayerByUserId);
            local Data = u13.getData(PlayerByUserId);

            if Data then
                Data:change("club", "");
            end;
        end;

        local success, result = pcall(function() -- Line: 937
            -- upvalues: u11 (ref), u94 (copy), u90 (copy)
            u11:UpdateAsync(u94, function(p97) -- Line: 938
                -- upvalues: u90 (ref)
                if p97 then
                    for i, v in ipairs(p97.Members) do
                        if v.Id == u90 then
                            table.remove(p97.Members, i);

                            return p97;
                        end;
                    end;

                    return p97;
                end;
            end);
        end);

        if not success then
            u24.Notify("Unable to update club. (rate limit)", p91);
            warn((`Unable to UpdateAsync for club "{u94}" during Kick: {result}`));

            return;
        end;

        local success2, result2 = pcall(function() -- Line: 956
            -- upvalues: u11 (ref), u94 (copy)
            return u11:GetAsync(u94);
        end);

        if success2 and result2 then
            u24.UpdateClub(u94, result2);
        end;

        u24.Notify(`{Players:GetNameFromUserIdAsync(u90)} has been kicked from the club.`, p91);
    end;
end;

function u24.GetClubInfo(u98: string) -- Line: 968
    -- upvalues: u4 (copy), RunService (copy), u11 (ref), u24 (copy)
    local v99 = u4[u98];

    if v99 then
        return {
            Name = v99.Name,
            Icon = v99.Icon
        };
    end;

    if RunService:IsServer() then
        local success, result = pcall(function() -- Line: 975
            -- upvalues: u11 (ref), u98 (copy)
            return u11:GetAsync(u98);
        end);

        if success and result then
            u24.UpdateClub(u98, result);

            return {
                Name = result.Name,
                Icon = result.Icon
            };
        end;
    else
        local v100 = script.Cache:FindFirstChild(u98);

        if v100 then
            return {
                Name = v100.name.Value,
                Icon = v100.icon.Value
            };
        end;
    end;

    return nil;
end;

function u24.GetClubData(p101: userdata, p102: boolean?) -- Line: 992
    -- upvalues: u13 (ref), u4 (copy), u11 (ref), u24 (copy)
    local Data = u13.getData(p101);

    if not Data then
        return;
    end;

    local club = Data.profile.Data.club;

    if not club or club == "" then
        return;
    end;

    if not p102 and u4[club] then
        return u4[club], club;
    end;

    local success, result = pcall(function() -- Line: 1009
        -- upvalues: u11 (ref), club (copy)
        return u11:GetAsync(club);
    end);

    if not success then
        return;
    end;

    u24.UpdateClub(club, result);

    if typeof(result) == "table" and typeof(result.Members) == "table" then
        local v103 = false;

        for _, v in ipairs(result.Members) do
            if v.Id == p101.UserId then
                v103 = true;
                break;
            end;
        end;

        if not v103 then
            u24.Notify("You have been kicked from the club.", p101);
            Data:change("club", "");

            return;
        end;
    elseif not result then
        u24.Notify("Club has been disbanded.", p101);
        Data:change("club", "");
    end;

    return result, club;
end;

function u24.Invite.Send(p104: userdata, p105: userdata?) -- Line: 1038
    -- upvalues: RunService (copy), club_request (copy), Players (copy), u24 (copy), u13 (ref), copy (copy), u9 (copy), u2 (copy)
    if RunService:IsClient() then
        club_request.send({
            name = "Invite.Send",
            content = { p104 }
        });

        return;
    end;

    if p105 then
        if not p105:IsDescendantOf(Players) then
            return;
        end;

        local ClubInvites = p105:FindFirstChild("ClubInvites");

        if not ClubInvites then
            return;
        end;

        if not u24.Debounce(p104, p105) then
            return;
        end;

        local Data = u13.getData(p105);

        if not Data then
            return;
        end;

        local club = Data.profile.Data.club;

        if club and club ~= "" then
            u24.Notify(`{p105.Name} is already in a club!`, p104);

            return;
        end;

        local ClubData, v106 = u24.GetClubData(p104);

        if not (ClubData and v106) then
            u24.Notify(`{p104.Name} is not in a club!`, p105);

            return;
        end;

        local v107 = u24.Invite.Key(p104, p105);
        local v108 = copy(u9);
        v108.Club = v106;
        local ObjectValue = Instance.new("ObjectValue");
        ObjectValue.Name = v106;
        ObjectValue.Value = p104;
        ObjectValue.Parent = ClubInvites;
        v108.Object = ObjectValue;
        u2[v107] = v108;
        u24.Notify(`Invited {p105.Name} to the club!`, p104);
    end;
end;

function u24.Invite.Remove(u109: string) -- Line: 1096
    -- upvalues: u2 (copy)
    local v110 = u2[u109];

    if v110.Object then
        v110.Object:Destroy();
    end;

    v110.Start = os.clock();
    v110.Active = false;
    task.delay(15, function() -- Line: 1106
        -- upvalues: u2 (ref), u109 (copy)
        u2[u109] = nil;
    end);
end;

function u24.Invite.Accept(p111: userdata, u112: userdata) -- Line: 1111
    -- upvalues: RunService (copy), club_request (copy), Players (copy), u24 (copy), u2 (copy), u13 (ref), DataStoreService (copy), u11 (ref)
    if RunService:IsClient() then
        club_request.send({
            name = "Invite.Accept",
            content = { p111 }
        });

        return;
    end;

    if p111 then
        local Value = p111.Value;

        if not (Value and Value:IsDescendantOf(Players)) then
            u24.Notify("The inviter is no longer in the game.", u112);

            return;
        end;

        local v113 = u24.Invite.Key(Value, u112);
        local v114 = u2[v113];

        if not (v114 and v114.Active) then
            u24.Notify("This invite is no longer valid.", u112);

            return;
        end;

        local Data = u13.getData(u112);

        if not Data then
            u24.Notify("Data hasn\'t loaded yet.", u112);

            return;
        end;

        local Data2 = Data.profile.Data;

        if Data2.club and Data2.club ~= "" then
            u24.Notify("You\'re already in a club!", u112);

            return;
        end;

        local Club = v114.Club;
        local GetAsync = Enum.DataStoreRequestType.GetAsync;
        local v115;

        if RunService:IsServer() then
            v115 = DataStoreService:GetRequestBudgetForRequestType(GetAsync) > 0;
        else
            v115 = false;
        end;

        if not v115 then
            u24.Notify("Unable to join club. (rate limit)", u112);

            return;
        end;

        local SetIncrementAsync = Enum.DataStoreRequestType.SetIncrementAsync;
        local v116;

        if RunService:IsServer() then
            v116 = DataStoreService:GetRequestBudgetForRequestType(SetIncrementAsync) > 0;
        else
            v116 = false;
        end;

        if not v116 then
            u24.Notify("Unable to join club. (rate limit)", u112);

            return;
        end;

        local success, result = pcall(function() -- Line: 1154
            -- upvalues: u11 (ref), Club (copy), u112 (copy)
            u11:UpdateAsync(Club, function(p117) -- Line: 1155
                -- upvalues: u112 (ref)
                if p117 then
                    table.insert(p117.Members, {
                        Rank = "Member",
                        MVP = 0,
                        Name = u112.Name,
                        Id = u112.UserId
                    });

                    return p117;
                end;
            end);
        end);

        if not success then
            u24.Notify("Unable to join club. (rate limit)", u112);
            warn((`Unable to UpdateAsync for club "{Club}" during Invite.Accept: {result}`));

            return;
        end;

        local success2, result2 = pcall(function() -- Line: 1168
            -- upvalues: u11 (ref), Club (copy)
            return u11:GetAsync(Club);
        end);

        if success2 and result2 then
            u24.UpdateClub(Club, result2);
        end;

        Data:change("club", Club);
        u24.Invite.Remove(v113);

        if result2 then
            Club = result2.Name or Club;
        end;

        u24.Notify(`You've joined "{Club}"!`, u112);
        u24.Notify(`{u112.Name} has joined your club!`, Value);
    end;
end;

function u24.Invite.Decline(p118: userdata) -- Line: 1185
    -- upvalues: RunService (copy), club_request (copy)
    if RunService:IsClient() then
        club_request.send({
            name = "Invite.Decline",
            content = { p118 }
        });
    end;
end;

function u24.Invite.RemoveAll(p119: userdata) -- Line: 1194
    -- upvalues: u2 (copy), u24 (copy)
    local v120 = tostring(p119.UserId);

    for i in u2 do
        local v121 = i;

        for _, v in ipairs(string.split(i, "-")) do
            if v == v120 then
                u24.Invite.Remove(v121);
                break;
            end;
        end;
    end;
end;

function u24.Invite.Validate(p122: userdata, p123: userdata) -- Line: 1206
    local v124;

    if typeof(p122) == "Instance" then
        v124 = p122:IsA("ObjectValue") and p122.Parent;

        if v124 then
            if p122.Parent.Name == "ClubInvites" then
                v124 = p122.Parent.Parent and p122.Parent.Parent == p123;
            else
                v124 = false;
            end;
        end;
    else
        v124 = false;
    end;

    return v124;
end;

if RunService:IsServer() then
    local u140 = {
        Create = function(p125, p126) -- Line: 1215
            -- upvalues: u24 (copy)
            u24.Create(p125[1], p126, p125[2]);
        end,

        Leave = function(p127, p128) -- Line: 1221
            -- upvalues: u24 (copy)
            u24.Leave(p128);
        end,

        Kick = function(p129, p130) -- Line: 1225
            -- upvalues: u24 (copy)
            local v131 = p129[1];

            if typeof(v131) == "number" and v131 == v131 then
                u24.Kick(v131, p130);
            end;
        end,

        ["Invite.Send"] = function(p132, p133) -- Line: 1234
            -- upvalues: u24 (copy)
            if typeof(p132[1]) == "Instance" and p132[1]:IsA("Player") then
                u24.Invite.Send(p133, p132[1]);
            end;
        end,

        ["Invite.Decline"] = function(p134, p135) -- Line: 1240
            -- upvalues: u24 (copy)
            local v136 = p134[1];

            if u24.Invite.Validate(v136, p135) then
                u24.Invite.Remove(u24.Invite.Key(v136.Value, p135));
            end;
        end,

        ["Invite.Accept"] = function(p137, p138) -- Line: 1247
            -- upvalues: u24 (copy)
            local v139 = p137[1];

            if u24.Invite.Validate(v139, p138) then
                u24.Invite.Accept(v139, p138);
            end;
        end
    };
    club_request.listen(function(p141, p142) -- Line: 1256
        -- upvalues: u140 (copy)
        if u140[p141.name] then
            u140[p141.name](p141.content, p142);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p143) -- Line: 1264
        -- upvalues: u24 (copy)
        u24.Invite.RemoveAll(p143);
    end);
end;

return u24;