  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local u1 = Knit.GetService("AchievementService");
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local LocalPlayer = Players.LocalPlayer;
local u2 = Color3.fromRGB(55, 255, 0);
local u3 = Color3.fromRGB(255, 255, 255);
local u4 = {};
u4.__index = u4;

local function RNG(p5, p6) -- Line: 22
    return Random.new():NextNumber(p5, p6);
end;

local function Count(p7) -- Line: 26
    local v8 = 0;

    for _, _ in p7 do
        v8 = v8 + 1;
    end;

    return v8;
end;

function Round(p9, p10)
    local v11 = 10 ^ (p10 or 0);

    return math.floor(p9 * v11 + 0.5) / v11;
end;

local function ExpandEntry(p12) -- Line: 39
    p12:SetAttribute("Expanded", true);
    p12.Rewards.Visible = true;

    for _, child in p12.Rewards:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = true;
        else
            child:IsA("UIPadding");
        end;
    end;
end;

local function CollapseEntry(p13) -- Line: 51
    p13:SetAttribute("Expanded", false);
    p13.Rewards.Visible = false;

    for _, child in p13.Rewards:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = false;
        else
            child:IsA("UIPadding");
        end;
    end;
end;

local function ToggleEntry(p14) -- Line: 63
    -- upvalues: CollapseEntry (copy), ExpandEntry (copy)
    if p14:GetAttribute("Expanded") then
        CollapseEntry(p14);

        return;
    end;

    ExpandEntry(p14);
end;

function u4.new(p15, p16) -- Line: 71
    -- upvalues: u4 (copy), Trove (copy)
    local v17 = setmetatable({}, u4);
    v17.UI = p15;
    v17.UIEngine = p16;
    v17.Trove = Trove.new();
    v17.Assets = p15.Assets;
    v17.Cache = {
        CurrentTab = nil,
        CurrentFilter = "All",
        InitialLoad = true,
        Achievements = {},
        ClaimedData = {},
        ProgressData = {},
        Tabs = {},
        PreviousProgressData = {}
    };
    v17.Entry = v17.Assets.Achievement;
    v17.Reward = v17.Assets.Reward;
    v17.Tab = v17.Assets.Tab;
    v17.TabButton = v17.Assets.TabButton;
    v17.Tabs = v17.UI.Tabs;
    v17.Filters = v17.UI.Filters;
    v17.Buttons = v17.UI.Buttons;

    return v17;
end;

function u4.FormatReward(p18, p19) -- Line: 101
    if p19 == "UShards" then
        return `<font color="#00aaff">{p18.UIEngine.CurrencyString}</font>`;
    end;

    if p19 == "UCoins" then
        return `<font color="#ffff00">{p18.UIEngine.UCoinsString}</font>`;
    end;

    if p19 == "TraitRerolls" then
        return "<font color=\"#b694ff\">Trait Reroll</font>";
    end;

    if p19 == "Title" or not p18.UIEngine:GetItemText(p19) then
        return p19;
    end;

    return p18.UIEngine:GetItemText(p19);
end;

function u4.FormatDescription(p20, p21, p22) -- Line: 117
    for i, v in p22 do
        p21 = string.gsub(p21, `<{i}>`, v);
    end;

    return p21;
end;

function u4.CreateEntry(u23, u24) -- Line: 127
    -- upvalues: Trove (copy), CollapseEntry (copy), ExpandEntry (copy), ItemData (copy), LocalPlayer (copy)
    local u25 = u23.Entry:Clone();
    u25.Title.Text = u24.Name;
    u25.Name = u24.Id;
    local v26 = Trove.new();
    v26:Add(u25);
    v26:Connect(u25.RewardButton.MouseButton1Click, function() -- Line: 135
        -- upvalues: u25 (copy), CollapseEntry (ref), ExpandEntry (ref)
        local v27 = u25;

        if v27:GetAttribute("Expanded") then
            CollapseEntry(v27);

            return;
        end;

        ExpandEntry(v27);
    end);
    v26:Connect(u25.MouseButton1Click, function() -- Line: 139
        -- upvalues: u23 (copy), u24 (copy)
        if not u23:IsCompleted(u24.Id) then
            return;
        end;

        u23.UIEngine.NewPrompt({
            Title = "Claim Achievement?",
            Text = "Are you sure you want to claim this achievement?",
            Delay = 1.5,
            Options = { "Yes", "No" },

            Callback = function(p28) -- Line: 150, Name: Callback
                -- upvalues: u23 (ref), u24 (ref)
                if p28.Choice ~= 1 then
                    return;
                end;

                u23.UIEngine:PlaySound("Click");
                u23:ClaimAchievement(u24.Id);
            end
        });
    end);

    local function AddReward(p29, p30) -- Line: 158
        -- upvalues: u23 (copy), ItemData (ref), LocalPlayer (ref), u25 (copy)
        local v31 = u23.Reward:Clone();
        v31.NameLabel.Text = u23:FormatReward(p29);
        v31.AmountLabel.Text = p30;

        if p29 == "Title" and ItemData.GetTitle(p30) then
            local v32 = ItemData.GetTitle(p30);
            local v33 = v32.DisplayName or v32.Name;

            if v32.NameCallback then
                v33 = v32.NameCallback(v32, {
                    Player = LocalPlayer
                });
            end;

            v31.AmountLabel.TextColor3 = v32.Color or v31.AmountLabel.TextColor3;
            v31.AmountLabel.Text = v33;
        end;

        v31.Parent = u25.Rewards;
    end;

    if u24.Rewards then
        for i, v in u24.Rewards do
            if typeof(v) == "number" or typeof(v) == "string" then
                AddReward(i, v);
            elseif typeof(v) == "table" then
                for i2, v2 in v do
                    AddReward(i2, v2);
                end;
            end;
        end;
    end;

    local v34 = u23:FormatDescription(u24.Description, u24.Requirements);
    u25.Description.Text = v34;
    local v35 = u24.Category or "General";

    if not u23:GetTab(v35) then
        u23:CreateTab(v35);
    end;

    u25.Parent = u23:GetTab(v35);
    u25.Visible = true;
    local Color = ItemData.GetRarityData(u24.Rarity or 1).Color;

    if Color then
        u25.UIStroke.Color = Color;
        u25.Title.TextColor3 = Color;
    end;

    u23.Cache.Achievements[u24.Id] = {
        u25,
        v26,
        u24,
        false
    };
    u23:UpdateAchievement(u24.Id);
end;

function u4.ClearEntries(p36) -- Line: 215
    for _, v in p36.Cache.Achievements do
        if v[2] then
            v[2]:Destroy();
            table.clear(v[3]);
        end;

        table.clear(v);
    end;

    table.clear(p36.Cache.Achievements);
end;

function u4.ClaimAchievement(p37, p38) -- Line: 227
    -- upvalues: u1 (copy)
    local v39 = u1:ClaimAchievement(p38):expect();
    local v40 = {
        AlreadyClaimed = {
            Title = "Already Claimed",
            Text = "You have already claimed the rewards from this achievement"
        },
        InvalidSpace = {
            Title = "Insufficient Space",
            Text = "Your inventory does not have enough space to claim the rewards of this achievement, try making some space"
        }
    };

    if typeof(v39) ~= "string" or not v40[v39] then
        return;
    end;

    p37.UIEngine.NewPrompt({
        Title = v40[v39].Title,
        Text = v40[v39].Text,
        Options = { "OK" },

        Callback = function(p41) -- Line: 249, Name: Callback
            return true;
        end
    });
end;

function u4.GetTab(p42, p43) -- Line: 259
    return p42.Tabs:FindFirstChild(p43);
end;

function u4.CreateTab(u44, u45) -- Line: 263
    local v46 = u44.Tab:Clone();
    v46.Parent = u44.Tabs;
    v46.Name = u45;
    local v47 = u44.TabButton:Clone();
    v47.Visible = true;
    v47.Text = u45;
    v47.Name = u45;
    v47.Parent = u44.Buttons;
    v47.MouseButton1Click:Connect(function() -- Line: 274
        -- upvalues: u44 (copy), u45 (copy)
        u44:SetTab(u45);
    end);
    local v48 = #u44.Tabs:GetChildren();

    for _, child in u44.Buttons:GetChildren() do
        if child:IsA("TextButton") then
            child.Size = UDim2.new(1 / v48, 0, 1, 0);
        end;
    end;

    local v49 = 0;

    for _, _ in u44.Cache.Tabs do
        v49 = v49 + 1;
    end;

    if v49 == 0 then
        u44:SetTab(u45);
    end;

    u44.Cache.Tabs[u45] = u45;

    return v46;
end;

function u4.SetTab(p50, p51) -- Line: 291
    -- upvalues: u2 (copy), u3 (copy)
    local CurrentTab = p50.Cache.CurrentTab;

    if CurrentTab ~= p51 then
        if not CurrentTab then
            local v52 = p50.Buttons:FindFirstChild(p51);
            v52.TextColor3 = u2;
            v52.BackgroundTransparency = 0.1;
            p50:GetTab(p51).Visible = true;
            p50.Cache.CurrentTab = p51;

            return;
        end;

        local v53 = p50.Buttons:FindFirstChild(p51);
        v53.TextColor3 = u2;
        v53.BackgroundTransparency = 0.1;
        p50:GetTab(p51).Visible = true;
        local v54 = p50.Buttons:FindFirstChild(CurrentTab);
        v54.TextColor3 = u3;
        v54.BackgroundTransparency = 0.8;
        p50:GetTab(CurrentTab).Visible = false;
        p50.Cache.CurrentTab = p51;
    end;
end;

function u4.GetProgress(p55, p56) -- Line: 318
    -- upvalues: ItemData (copy)
    local ProgressData = p55.Cache.ProgressData;

    return ItemData.GetAchievement(p56).ProgressCallback(ProgressData);
end;

function u4.CreateAchievement(p57, p58, p59) -- Line: 326
    -- upvalues: ItemData (copy), TableUtil (copy)
    local v60 = ItemData.GetAchievement(p58);

    if not v60 then
        return;
    end;

    local v61 = TableUtil.Reconcile(v60, p59);
    v61.Id = p58;
    p57:CreateEntry(v61);
end;

function u4.SetClaimed(p62, p63) -- Line: 336
    local v64 = p62.Cache.Achievements[p63];

    if not v64 then
        return;
    end;

    v64[4] = true;
    v64[1].LayoutOrder = 99999;
    v64[1]:FindFirstChild("ClaimedFrame").Visible = true;
    p62:SetFilter(p62.Cache.CurrentFilter);
end;

function u4.IsCompleted(p65, p66) -- Line: 347
    local v67 = p65:GetProgress(p66);

    if not v67 then
        return;
    end;

    local v68 = p65.Cache.Achievements[p66];

    if not v68 then
        return;
    end;

    local v69 = v68[3];

    if v69.Requirements then
        return math.clamp(v67, 0, v69.Requirements.Amount) / v69.Requirements.Amount == 1;
    end;
end;

function u4.UpdateAchievement(p70, p71) -- Line: 360
    local v72 = p70:GetProgress(p71);

    if not v72 then
        return;
    end;

    local v73 = p70.Cache.Achievements[p71];

    if not v73 then
        return;
    end;

    local v74 = v73[3];

    if not v74.Requirements then
        return;
    end;

    local v75 = v73[1];
    local v76 = math.clamp(v72, 0, v74.Requirements.Amount);
    local v77 = v76 / v74.Requirements.Amount;
    v75.LayoutOrder = tonumber(string.match(p71, "%d+")) or 0;
    v75.Progress.BarText.Text = `{v76} / {v74.Requirements.Amount}`;
    v75.Progress.Bar.Size = UDim2.new(v77, 0, 1, 0);

    for i in p70.Cache.ClaimedData do
        if i == p71 then
            p70:SetClaimed(p71);

            return;
        end;
    end;

    v75.ClaimedFrame.Visible = false;
end;

function u4.UpdateAchievements(p78) -- Line: 389
    -- upvalues: u1 (copy)
    local v79 = u1:GetAchievementProgress():expect();
    local v80 = u1:GetClaimedAchievements():expect();
    p78.Cache.ProgressData = v79;
    p78.Cache.ClaimedData = v80;

    for i, _ in p78.Cache.Achievements do
        p78:UpdateAchievement(i);
        local v81 = p78:GetProgress(i) or 0;
        p78.Cache.PreviousProgressData[i] = v81;
    end;

    p78.Cache.InitialLoad = false;
end;

function u4.SetFilter(u82, p83) -- Line: 405
    -- upvalues: u2 (copy), u3 (copy)
    local v88 = {
        All = function() -- Line: 407, Name: All
            return true;
        end,

        Progress = function(p84) -- Line: 410, Name: Progress
            -- upvalues: u82 (copy)
            local v85 = u82.Cache.Achievements[p84];
            local v86 = u82:GetProgress(p84);

            if v86 then
                if u82:GetProgress(p84) > 0 then
                    v86 = v85[4] ~= true;
                else
                    v86 = false;
                end;
            end;

            return v86;
        end,

        Claimed = function(p87) -- Line: 414, Name: Claimed
            -- upvalues: u82 (copy)
            return u82.Cache.Achievements[p87][4] == true;
        end
    };

    for i, v in u82.Cache.Achievements do
        if v88[p83](i) then
            v[1].Visible = true;
        else
            v[1].Visible = false;
        end;
    end;

    if u82.Cache.CurrentFilter ~= p83 then
        local v89 = u82.Filters:FindFirstChild(p83);
        v89.BackgroundTransparency = 0.3;
        v89.TextColor3 = u2;
        local v90 = u82.Filters:FindFirstChild(u82.Cache.CurrentFilter);
        v90.BackgroundTransparency = 0.5;
        v90.TextColor3 = u3;
        u82.Cache.CurrentFilter = p83;
    end;
end;

function u4.OnAchievementCompleted(p91, p92) -- Line: 441
    -- upvalues: ItemData (copy)
    local BestAchievement = p92.BestAchievement;
    local AllCompletedAchievements = p92.AllCompletedAchievements;
    local Count2 = p92.Count;
    local v93 = ItemData.GetRarityData(BestAchievement.Rarity);
    local v94 = v93 and v93.Color or Color3.fromRGB(255, 255, 255);
    local v95;

    if Count2 == 1 then
        v95 = BestAchievement.Name;
    else
        local v96 = {};

        for _, v in AllCompletedAchievements do
            table.insert(v96, v.Name);
        end;

        v95 = table.concat(v96, ", ");
    end;

    local v97 = {
        NumericalSuffix = "COMPLETED",
        DisableStacking = true,
        NumericalContent = Count2,
        Verb = "Achievement" .. (Count2 > 1 and "s" or ""),
        Subject = v95,
        SubjectColor = v94,
        NumericalContentColor = v94,
        VerbColor = Color3.fromRGB(255, 255, 255)
    };
    p91.UIEngine:CreateMiddleNotification(v97);
end;

function u4.Load(u98) -- Line: 474
    -- upvalues: u1 (copy)
    for i, v in u1:GetAchievementsInfo():expect() do
        u98:CreateAchievement(i, v);
    end;

    for _, child in u98.Filters:GetChildren() do
        if child:IsA("TextButton") then
            child.MouseButton1Click:Connect(function() -- Line: 483
                -- upvalues: u98 (copy), child (copy)
                u98:SetFilter(child.Name);
            end);
        end;
    end;

    u98:UpdateAchievements();
    u1.AchievementUpdated:Connect(function() -- Line: 489
        -- upvalues: u98 (copy)
        u98:UpdateAchievements();
    end);
    u1.AchievementCompleted:Connect(function(p99) -- Line: 493
        -- upvalues: u98 (copy)
        u98:OnAchievementCompleted(p99);
    end);
end;

return u4;