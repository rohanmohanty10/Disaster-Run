  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
local u1 = Knit.GetService("RigService");
local u2 = Knit.GetService("ShopService");
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local StatsHandler = require(ReplicatedStorage.ReplicatedModules.StatsHandler);
local ItemData = require(PathShortcuts.ReplicatedModules.ItemData);
local AbilityNameToId = require(ReplicatedStorage.ReplicatedModules.AbilityNameToId);
local LocalPlayer = Players.LocalPlayer;
local u3 = {};
u3.__index = u3;

local function RNG(p4, p5) -- Line: 38
    return Random.new():NextNumber(p4, p5);
end;

local function Lerp(p6, p7, p8) -- Line: 42
    return p6 + (p7 - p6) * p8;
end;

local function toMS(p9) -- Line: 46
    return string.format("%02i:%02i", p9 / 60 % 60, p9 % 60);
end;

function u3.new(p10, p11) -- Line: 50
    -- upvalues: u3 (copy), Trove (copy)
    local u12 = setmetatable({}, u3);
    u12.UI = p10;
    u12.UIEngine = p11;
    u12.Trove = Trove.new();
    u12.Assets = p10.Assets;
    u12.Cache = {
        BannerPosition = 1,
        HourId = nil,
        LastHourId = nil,
        Entries = {},
        RosterRigs = {}
    };
    u12.SpecialRoster = p10.SpecialRoster;
    u12.Abilities = u12.SpecialRoster.Abilities;
    u12.Currencies = p10.Currencies;
    u12.Info = p10.Info;
    u12.Buy = p10.Buy;
    u12.PityProgress = u12.Info.Progress;
    u12.Timer = p10.Timer;
    u12.Close = p10.Close;
    u12.OnePull = u12.Buy.One;
    u12.TenPull = u12.Buy.Ten;
    u12.PoolAsset = u12.Assets.PoolAsset;
    u12.Trove:Connect(u12.Close.MouseButton1Click, function() -- Line: 83
        -- upvalues: u12 (copy)
        u12.UI.Visible = false;
    end);
    u12.Trove:Connect(u12.OnePull.MouseButton1Click, function() -- Line: 87
        -- upvalues: u12 (copy)
        u12:PromptPurchase(u12.Cache.BannerPosition, "One");
    end);
    u12.Trove:Connect(u12.TenPull.MouseButton1Click, function() -- Line: 91
        -- upvalues: u12 (copy)
        u12:PromptPurchase(u12.Cache.BannerPosition, "Ten");
    end);

    return u12;
end;

function u3.DisplayRoster(u13, p14) -- Line: 98
    -- upvalues: StatsHandler (copy), Players (copy), LocalPlayer (copy), AnimationHandler (copy), AbilityNameToId (copy)
    local v15 = u13:GetCurrentRosterRigs(p14 or 1);

    if not v15 then
        return;
    end;

    local v16 = {
        Epic = {},
        Legendary = {}
    };

    for _, child in u13.Abilities:GetChildren() do
        if child:IsA("ViewportFrame") then
            table.insert(v16[child.Name], child);
            local v17 = child:FindFirstChildWhichIsA("WorldModel");

            if v17 then
                v17:ClearAllChildren();
            else
                Instance.new("WorldModel").Parent = child;
            end;
        end;
    end;

    local function Setup(p18, u19) -- Line: 121
        -- upvalues: StatsHandler (ref), Players (ref), LocalPlayer (ref), AnimationHandler (ref), AbilityNameToId (ref), u13 (copy)
        local v20 = p18:FindFirstChildWhichIsA("WorldModel");

        if not v20 then
            v20 = Instance.new("WorldModel");
            v20.Parent = p18;
        end;

        u19.Parent = v20;
        local v21 = { "StandHumanoidRootPart", "HumanoidRootPart" };
        local v22 = StatsHandler.GetStats(u19.Name);

        if string.find(u19.Name:lower(), "hamon") then
            table.insert(v21, "Stand Torso");
        end;

        if v22.Stats and (v22.Stats.Summon and v22.Stats.Summon.LeaveParts) then
            for _, v in v22.Stats.Summon.LeaveParts do
                table.insert(v21, v);
            end;
        end;

        if u19:FindFirstChild("Stand") then
            for _, descendant in pairs(u19.Stand:GetDescendants()) do
                if (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and not table.find(v21, descendant.Name) then
                    descendant.Transparency = 0;
                end;
            end;
        end;

        local Camera = Instance.new("Camera");
        Camera.CFrame = CFrame.new(0, 0, -7.5) * CFrame.Angles(0, 3.141592653589793, 0);
        Camera.Parent = v20;
        Camera.FieldOfView = 50;
        p18.CurrentCamera = Camera;
        pcall(function() -- Line: 163
            -- upvalues: Players (ref), LocalPlayer (ref), u19 (copy)
            local v23 = Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId);
            u19:FindFirstChildOfClass("Humanoid"):ApplyDescription(v23);
        end);
        pcall(function() -- Line: 167
            -- upvalues: AnimationHandler (ref), u19 (copy)
            local v24 = AnimationHandler.CreateAnimationByName(u19.Name, nil, "SummonedIdle");
            local v25 = AnimationHandler.CreateAnimationByName(u19.Name, nil, "Summoned-Idle");
            local v26 = AnimationHandler.CreateAnimationByName(u19.Name, nil, "Idle");

            if v24 then
                u19:FindFirstChildOfClass("Humanoid"):LoadAnimation(v24):Play();
            end;

            if v25 then
                u19:FindFirstChildOfClass("Humanoid"):LoadAnimation(v25):Play();
            end;

            if v26 then
                u19:FindFirstChildOfClass("Humanoid"):LoadAnimation(v26):Play();
            end;
        end);
        local v27 = AbilityNameToId.GetAbilityId(u19.Name);
        p18.Title.Text = u13.UIEngine:GetItemText((`ABILITY_{v27}`));
    end;

    local Roster = u13.Cache.PoolData.Roster;

    for i, v in v15 do
        local v28 = v16[i];

        for i2, v2 in Roster[i] do
            Setup(v28[i2], v[v2]:Clone());
        end;
    end;
end;

function u3.GetCurrentRosterRigs(p29, p30) -- Line: 203
    -- upvalues: u1 (copy)
    local Roster = p29.Cache.PoolData.Roster;
    local v31 = p29.Cache.RosterRigs.Epic or {};
    local v32 = p29.Cache.RosterRigs.Legendary or {};
    local v33 = false;

    for _, v in Roster.Epic do
        if not v31[v] then
            v33 = true;
        end;
    end;

    for _, v in Roster.Legendary do
        if not v32[v] then
            v33 = true;
        end;
    end;

    if not v33 then
        return p29.Cache.RosterRigs;
    end;

    for i, v in u1:RequestRosterDisplayRigs(p30):expect() or {} do
        if not p29.Cache.RosterRigs[i] then
            p29.Cache.RosterRigs[i] = {};
        end;

        for _, v2 in v do
            local Name = v2.Name;

            if not p29.Cache.RosterRigs[i][Name] then
                p29.Cache.RosterRigs[i][Name] = v2:Clone();
            end;
        end;
    end;

    return p29.Cache.RosterRigs;
end;

function u3.UpdateCurrencies(p34) -- Line: 240
    -- upvalues: u2 (copy)
    local v35 = u2:GetCurrencyType("UPoints"):expect();
    local v36 = u2:GetCurrencyType("UShards"):expect();
    local v37 = p34.UIEngine:AbbreviateNumber(v35);
    local v38 = p34.UIEngine:AbbreviateNumber(v36);
    p34.Currencies.PremiumCurrency.Text = `<font color="rgb(255,200,100)">{v37} {p34.UIEngine.PremiumCurrencyString}</font>`;
    p34.Currencies.Currency.Text = `<font color="rgb(75,170,255)">{v38} {p34.UIEngine.CurrencyString}</font>`;
end;

function u3.GetTimeRemainingInfo(p39) -- Line: 251
    local v40 = tick();
    local v41 = v40 / 3600;
    local v42 = math.floor(v40 / 3600);
    local v43 = {
        Progress = math.clamp(1 - (v41 - v42), 0, 1)
    };
    local v44 = (60 - (0 + 60 * (v41 - v42))) * 60;
    v43.Remaining = string.format("%02i:%02i", v44 / 60 % 60, v44 % 60);

    return v43;
end;

function u3.DisplayLootPool(u45, p46) -- Line: 264
    -- upvalues: ItemData (copy)
    local PoolData = u45.Cache.PoolData;

    for _, v in PoolData.Rosters do
        if tonumber(v.BannerPosition) == p46 then
            PoolData.Roster = v.Roster;
        end;
    end;

    local List = u45.Info.List;

    for _, child in pairs(List:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy();
        end;
    end;

    task.defer(function() -- Line: 279
        -- upvalues: PoolData (copy), u45 (copy), List (copy), ItemData (ref)
        local v47 = 0;

        for _, v in PoolData.WeightPool do
            v47 = v47 + v;
        end;

        for i, v in PoolData.WeightPool do
            local v48 = v / v47 * 100;

            if i == "Mythic" then
                local u49 = u45.PoolAsset:Clone();
                u49.Visible = true;
                u49.LayoutOrder = v * -1;
                u49.Text = `<b>{(i or "") .. ` • {PoolData.RewardInfo[i] > 1 and `(1 - {PoolData.RewardInfo[i]} Shards)` or "(1 Shard)"}` .. ": " .. string.format("%.2f", v48)}%</b>`;
                u49.BackgroundTransparency = 1;
                u49.Parent = List;
                task.spawn(function() -- Line: 298
                    -- upvalues: u49 (copy)
                    while u49.Parent do
                        local v50 = DateTime.now().UnixTimestampMillis / 1000 % 5 / 5;
                        u49.TextColor3 = Color3.fromHSV(v50, 1, 1);
                        task.wait();
                    end;
                end);
            else
                local v51 = u45.PoolAsset:Clone();
                v51.Visible = true;
                v51.BackgroundTransparency = 1;
                local v52 = i or "";
                local v53 = ItemData.GetRarityByName(i);
                local v54, v55;

                if v53 then
                    v54 = `<font color="#{v53.Color:ToHex()}"><b>`;
                    v55 = `</b> • {PoolData.RewardInfo[i] > 1 and (`(1 - {PoolData.RewardInfo[i]} Shards)` or "(1 Shard)") or "(1 Shard)"}</font>`;
                    v52 = v54 .. v52 .. v55;
                else
                    v54 = "";
                    v55 = "";
                end;

                v51.LayoutOrder = v * -1;
                v51.Text = v52 .. ": " .. string.format("%.2f", v48) .. "%";
                v51.Parent = List;
                local v56 = v / #PoolData.Roster[i] / v47 * 100;

                for _, v2 in PoolData.Roster[i] do
                    if v53 then
                        v54 = `<font color="#{v53.Color:ToHex()}">`;
                        v55 = "</font>";
                        v52 = v54 .. v52 .. v55;
                    end;

                    local v57 = u45.PoolAsset:Clone();
                    v57.Visible = true;
                    v57.LayoutOrder = (v - 1) * -1;
                    v57.Text = v54 .. v2 .. " Shard" .. v55 .. "  -  " .. string.format("%.2f", v56) .. "%";
                    v57.Parent = List;
                end;
            end;
        end;
    end);
end;

function u3.DisplayPrices(p58) -- Line: 350
    -- upvalues: ItemData (copy)
    local AbilityGacha = ItemData.AbilityGacha;
    p58.OnePull.Currency.Text = `<font color="rgb(75,170,255)">{AbilityGacha.UShards} {p58.UIEngine.CurrencyString}</font>`;
    p58.OnePull.PremiumCurrency.Text = `<font color="rgb(255,200,100)">{AbilityGacha.UPoints} {p58.UIEngine.PremiumCurrencyString}</font>`;
    p58.TenPull.Currency.Text = `<font color="rgb(75,170,255)">{AbilityGacha.UShards * 10} {p58.UIEngine.CurrencyString}</font>`;
    p58.TenPull.PremiumCurrency.Text = `<font color="rgb(255,200,100)">{AbilityGacha.UPoints * 10} {p58.UIEngine.PremiumCurrencyString}</font>`;
end;

function u3.PromptPurchase(u59, u60, p61) -- Line: 360
    -- upvalues: ItemData (copy), u2 (copy)
    local AbilityGacha = ItemData.AbilityGacha;
    local u62 = p61 == "One" and 1 or 10;
    u59.UIEngine.NewPrompt({
        Text = "Choose a currency to buy pulls with",
        Title = `Purchase {p61 == "One" and "1 pull" or "10 pulls"}`,
        RichText = { 2, 3 },
        Options = { "Cancel", `<font color="rgb(75,170,255)">{AbilityGacha.UShards * u62} {u59.UIEngine.CurrencyString}</font>`, `<font color="rgb(255,200,100)">{AbilityGacha.UPoints * u62} {u59.UIEngine.PremiumCurrencyString}</font>` },

        Callback = function(p63) -- Line: 373, Name: Callback
            -- upvalues: u59 (copy), u2 (ref), u60 (copy), u62 (copy), ItemData (ref)
            u59.UIEngine:PlaySound("Click");

            if p63.Choice == 1 then
                return;
            end;

            local v64 = p63.Choice == 3 and "UPoints" or "UShards";
            local v65 = u2:RollBanner(u60, v64, u62):expect();

            if type(v65) ~= "table" then
                if v65 == "NotEnough" then
                    u59.UIEngine.NewPrompt({
                        Title = "Purchase Failed",
                        Text = `Not enough {v64}`
                    });

                    return;
                end;

                if v65 ~= "InvalidBanner" then
                    u59.UIEngine.NewPrompt({
                        Title = "Purchase Failed",
                        Text = "Please retry after a few seconds"
                    });

                    return;
                end;

                u59.UIEngine.NewPrompt({
                    Title = "Purchase Failed",
                    Text = "The banner you selected is no longer available"
                });
                task.spawn(function() -- Line: 392
                    -- upvalues: u59 (ref)
                    u59:LoadBanners();
                end);

                return;
            end;

            u59:UpdateCurrencies();
            local v66 = 1;
            local v67 = {
                Mythic = 1,
                Legendary = 2,
                Epic = 3,
                Rare = 4,
                Uncommon = 5,
                Common = 6
            };
            local v68 = {};
            local v69 = "";

            for _, v in v65 do
                if ItemData.GetAbility(v.AbilityId) then
                    local v70 = ItemData.GetRarityByName(v.Rarity);
                    local v71 = ItemData.GetRarityValueByName(v.Rarity);

                    if v71 then
                        if v66 >= v71 then
                            v71 = v66;
                        end;
                    else
                        v71 = v66;
                    end;

                    local v72 = {
                        String = `<font color="#{v70.Color:ToHex():upper()}">{v.AbilityName} Shard</font> [x{v.Shards}]\n`,
                        Rarity = v67[v.Rarity]
                    };
                    table.insert(v68, v72);
                    v66 = v71;
                end;
            end;

            table.sort(v68, function(p73, p74) -- Line: 434
                return p73.Rarity < p74.Rarity;
            end);

            for i = 1, #v68 do
                v69 = v69 .. v68[i].String;
            end;

            table.clear(v68);
            u59.UIEngine:OpenBriefcaseAnim(v66);
            u59.UIEngine.NewPrompt({
                Title = "You pulled the following Items",
                Text = v69
            });
        end
    });
end;

function u3.LoadBanners(u75) -- Line: 454
    -- upvalues: u2 (copy)
    local u76 = u2:RequestBannerInfo():expect();
    table.sort(u76.Rosters, function(p77, p78) -- Line: 457
        return tonumber(p78.BannerPosition) > tonumber(p77.BannerPosition);
    end);
    u75.Cache.PoolData = u76;
    local success, result = pcall(function() -- Line: 464
        -- upvalues: u76 (copy), u75 (copy)
        if not u76.Rosters[u75.Cache.BannerPosition] then
            u75.Cache.BannerPosition = 1;
            u75:DisplayLootPool(u75.Cache.BannerPosition);
            u75:DisplayRoster(u75.Cache.BannerPosition);
        end;
    end);

    if not success then
        warn(result);
    end;

    for _, child in u75.UI.Banners:GetChildren() do
        if child:IsA("TextButton") then
            child:Destroy();
        end;
    end;

    for _, v in u76.Rosters do
        local u79 = tonumber(v.BannerPosition);
        local u80 = u75.Assets.BannerTest:Clone();
        u80.Text = u79 == 1 and "Default Banner" or (v.Name or `Limited Banner {u79}`);
        u80.LayoutOrder = u79;
        u80.Visible = true;
        u80.Parent = u75.UI.Banners;

        if u79 == u75.Cache.BannerPosition then
            u80.TextColor3 = Color3.new(0, 1, 0);
        end;

        u80.MouseButton1Click:Connect(function() -- Line: 492
            -- upvalues: u75 (copy), u80 (copy), u79 (copy)
            for _, child in u75.UI.Banners:GetChildren() do
                if child:IsA("TextButton") and child ~= u80 then
                    child.TextColor3 = Color3.new(1, 1, 1);
                end;
            end;

            u80.TextColor3 = Color3.new(0, 1, 0);
            u75.Cache.BannerPosition = u79;
            u75:DisplayLootPool(u79);
            u75:DisplayRoster(u79);
        end);
    end;

    u75.UI.Banners.CanvasSize = UDim2.fromOffset(0, u75.UI.Banners.UIListLayout.AbsoluteContentSize.Y + 200);
end;

function u3.Update(p81) -- Line: 511
    -- upvalues: u2 (copy)
    local v82 = u2:GetPityInfo():expect();
    local Cache = p81.Cache;
    local v83 = tick() / 3600;
    Cache.LastHourId = math.floor(v83);
    local v84 = p81:GetTimeRemainingInfo();
    p81.Timer.Text = v84.Remaining;
    p81.Timer.Progress.Bar.Size = UDim2.new(v84.Progress, 0, 1, 0);
    p81.Timer.Progress.Bar.Gradient.Offset = Vector2.new(1 - v84.Progress, 0);
    p81.Info.PullTotal.Text = `Total Pulls: <font color="rgb(0,255,127)">{v82.AbilityBannerTotalRolls}</font>`;
end;

function u3.Load(u85) -- Line: 530
    u85.UI.Visible = true;
    u85:DisplayPrices();
    u85:UpdateCurrencies();
    u85:LoadBanners();
    task.spawn(function() -- Line: 537
        -- upvalues: u85 (copy)
        while u85.UI.Visible do
            if u85.Cache.HourId ~= u85.Cache.LastHourId then
                task.delay(1.25, function() -- Line: 543
                    -- upvalues: u85 (ref)
                    u85:LoadBanners();
                    u85:DisplayLootPool(u85.Cache.BannerPosition);
                    u85:DisplayRoster(u85.Cache.BannerPosition);
                end);
                u85.Cache.HourId = u85.Cache.LastHourId;
            end;

            u85:Update();
            task.wait(1);
        end;
    end);
end;

return u3;