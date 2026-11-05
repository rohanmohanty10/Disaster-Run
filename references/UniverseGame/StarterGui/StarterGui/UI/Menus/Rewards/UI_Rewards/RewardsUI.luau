  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
Knit.OnStart():await();
task.wait(3);
local u1 = Knit.GetService("ShopService");
local _ = Players.LocalPlayer;
local u2 = {};
u2.__index = u2;

local function RNG(p3, p4) -- Line: 19
    return Random.new():NextNumber(p3, p4);
end;

local function toHMS(p5) -- Line: 23
    return string.format("%02i:%02i:%02i", p5 / 3600, p5 / 60 % 60, p5 % 60);
end;

local function toMins(p6) -- Line: 27
    return p6 / 60;
end;

local function getDayId() -- Line: 31
    local v7 = os.time() / 86400;

    return math.floor(v7);
end;

function u2.new(p8, p9) -- Line: 35
    -- upvalues: u2 (copy), Trove (copy)
    local v10 = setmetatable({}, u2);
    v10.UI = p8;
    v10.UIEngine = p9;
    v10.Trove = Trove.new();
    v10.Tooltip = p9.Util.Tooltip.GetFromParent(p8:FindFirstAncestorWhichIsA("ScreenGui"):FindFirstChild("Screen"));
    v10.Assets = p8.Assets;
    v10.Cache = {
        Elapsed = 0,
        DayId = 0,
        LastNotified = 0,
        RewardFrames = {},
        RewardsNotified = {},
        Rewards = {},
        DailyInfo = {}
    };
    v10.Tabs = p8.Tabs;
    v10.Buttons = p8.Buttons;
    v10.RewardTemplate = v10.Assets.Reward;
    v10.ScrollBar = v10.Tabs.Playtime.ScrollBar;
    v10.InfoLabel = v10.Tabs.Playtime.InfoLabel;
    v10.InfoLabel2 = v10.Tabs.Daily.InfoLabel;
    v10.DailyButtons = v10.Tabs.Daily.Buttons;

    return v10;
end;

function u2.CreateEntry(u11, u12) -- Line: 68
    -- upvalues: u1 (copy)
    local v13 = u11.RewardTemplate:Clone();
    v13.Counter.Text = string.format("%02i:%02i:%02i", u12 / 3600, u12 / 60 % 60, u12 % 60);
    v13.Name = u12;
    v13.Parent = u11.ScrollBar;
    v13.Visible = true;
    v13.LayoutOrder = math.round(u12 / 10);
    table.insert(u11.Cache.RewardFrames, v13);
    v13.Button.MouseButton1Click:Connect(function() -- Line: 78
        -- upvalues: u1 (ref), u12 (copy), u11 (copy)
        local v14 = u1:ClaimPlaytimeReward(u12):expect();

        if v14 and typeof(v14) ~= "string" then
            local v15 = u1:GetPlaytimeRewardInfo():expect();
            u11.Cache.ClaimedRewards = v15.ClaimedRewards;
        end;
    end);
    v13.Button.MouseEnter:Connect(function() -- Line: 86
        -- upvalues: u11 (copy), u12 (copy)
        if u11.Cache.Rewards[tostring(u12)] then
            u11.Tooltip:SetTitle((`Playtime Reward ({u12 / 60 .. " Minutes"})`));
            u11.Tooltip:SetText((`<font color="#d1b3ff">{u11.Cache.Rewards[tostring(u12)]}</font>`));
            u11.Tooltip:Show();
        end;
    end);
    v13.Button.MouseLeave:Connect(function() -- Line: 97
        -- upvalues: u11 (copy)
        u11.Tooltip:Hide();
    end);

    return v13;
end;

function u2.SetUpDailyButtons(u16) -- Line: 104
    -- upvalues: u1 (copy)
    for _, child in u16.DailyButtons:GetChildren() do
        if child:IsA("Frame") then
            local u17 = string.match(child.Name, "%d+");
            child.Button.MouseButton1Click:Connect(function() -- Line: 109
                -- upvalues: u1 (ref), u17 (copy), u16 (copy)
                local v18 = u1:ClaimDailyReward((tonumber(u17))):expect();

                if v18 and typeof(v18) ~= "string" then
                    local v19 = u1:GetDailyRewardInfo():expect();
                    u16.Cache.DailyInfo.ClaimedRewards = v19.ClaimedRewards;
                end;
            end);
            child.Button.MouseEnter:Connect(function() -- Line: 117
                -- upvalues: u16 (copy), u17 (copy)
                if u16.Cache.DailyInfo.RewardInfo[tonumber(u17)] then
                    local v20;

                    if u17 == "1" then
                        v20 = u17 .. " Day";
                    else
                        v20 = u17 .. " Days";
                    end;

                    u16.Tooltip:SetTitle((`Daily Reward ({v20})`));
                    u16.Tooltip:SetText((`<font color="#d1b3ff">{u16.Cache.DailyInfo.RewardInfo[tonumber(u17)]}</font>`));
                    u16.Tooltip:Show();
                end;
            end);
            child.Button.MouseLeave:Connect(function() -- Line: 126
                -- upvalues: u16 (copy)
                u16.Tooltip:Hide();
            end);
        end;
    end;
end;

function u2.Update(u21) -- Line: 134
    -- upvalues: u1 (copy)
    local Cache = u21.Cache;
    Cache.Elapsed = Cache.Elapsed + 1;
    local v22 = os.time() / 86400;

    if math.floor(v22) == u21.Cache.DayId then
        if os.clock() - 0 > 60 then
            local v23 = u1:GetDailyRewardInfo():expect();
            u21.Cache.DailyInfo = v23;
        end;
    else
        local v24 = u1:GetPlaytimeRewardInfo():expect();
        local v25 = u1:GetDailyRewardInfo():expect();
        u21.Cache.DailyInfo = v25;
        table.clear(u21.Cache.RewardsNotified);
        u21.Cache.Rewards = v24.RewardInfo;
        u21.Cache.Elapsed = v24.Elapsed;
        u21.Cache.DayId = v24.DayId;
        u21.Cache.ClaimedRewards = v24.ClaimedRewards;
    end;

    local u26 = { u21.UI.Parent.Menu.Rewards };
    local u27 = false;

    local function UpdateIndiactors() -- Line: 162
        -- upvalues: u21 (copy), u27 (ref), u26 (copy)
        if not u21.UIEngine.ToggleMenuButtonIndicator then
            warn("#");

            return;
        end;

        if u27 then
            u21.UIEngine:ToggleMenuButtonIndicator("RewardsUI", true);

            for i = 1, #u26 do
                u21.UIEngine:AddButtonIndicator(u26[i]);
            end;

            return;
        end;

        u21.UIEngine:ToggleMenuButtonIndicator("RewardsUI", false);

        for i = 1, #u26 do
            u21.UIEngine:RemoveButtonIndicator(u26[i]);
        end;
    end;

    for _, child in u21.DailyButtons:GetChildren() do
        if child:IsA("Frame") then
            local v28 = tonumber(string.match(child.Name, "%d+"));

            if table.find(u21.Cache.DailyInfo.ClaimedRewards, v28) then
                child.Button.ClaimText.Visible = false;
                child.Button.ClaimedText.Visible = true;
                child.Button.BackgroundColor3 = Color3.fromRGB(23, 23, 23);
            elseif v28 <= u21.Cache.DailyInfo.LoginCount then
                child.Button.ClaimText.Visible = true;
                child.Button.ClaimedText.Visible = false;
                child.Button.BackgroundColor3 = Color3.fromRGB(202, 148, 255);

                if not table.find(u21.Cache.RewardsNotified, v28) then
                    table.insert(u21.Cache.RewardsNotified, v28);
                    task.spawn(function() -- Line: 193
                        -- upvalues: u21 (copy)
                        u21.UIEngine:CreateMiddleNotification({
                            NumericalContent = "1",
                            NumericalSuffix = "Daily Reward Available",
                            Verb = "",
                            Subject = "Claim it in rewards menu!"
                        });
                    end);
                    u21.UIEngine:PlaySound("xp_gain");
                end;

                u27 = true;
            elseif u21.Cache.DailyInfo.LoginCount < v28 then
                child.Button.ClaimText.Visible = false;
                child.Button.ClaimedText.Visible = false;
                child.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50):Lerp(Color3.fromRGB(111, 111, 111), u21.Cache.DailyInfo.LoginCount / v28);
            end;
        end;
    end;

    for _, v in u21.Cache.RewardFrames do
        local v29 = tonumber(v.Name);

        if table.find(u21.Cache.ClaimedRewards, v29) then
            v.Button.ClaimText.Visible = false;
            v.Button.ClaimedText.Visible = true;
            v.Button.BackgroundColor3 = Color3.fromRGB(23, 23, 23);
            v.Counter.Text = string.format("%02i:%02i:%02i", 0, 0, 0);
        elseif v29 <= u21.Cache.Elapsed then
            v.Button.ClaimText.Visible = true;
            v.Button.ClaimedText.Visible = false;
            v.Button.BackgroundColor3 = Color3.fromRGB(202, 148, 255);
            v.Counter.Text = string.format("%02i:%02i:%02i", 0, 0, 0);

            if not table.find(u21.Cache.RewardsNotified, v29) then
                table.insert(u21.Cache.RewardsNotified, v29);
                task.spawn(function() -- Line: 229
                    -- upvalues: u21 (copy)
                    u21.UIEngine:CreateMiddleNotification({
                        NumericalContent = "1",
                        NumericalSuffix = "Playtime Reward Available",
                        Verb = "",
                        Subject = "Claim it in rewards menu!"
                    });
                end);
                u21.UIEngine:PlaySound("xp_gain");
            end;

            u27 = true;
        elseif u21.Cache.Elapsed < v29 then
            local v30 = v29 - u21.Cache.Elapsed;
            v.Button.ClaimText.Visible = false;
            v.Button.ClaimedText.Visible = false;
            v.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50):Lerp(Color3.fromRGB(202, 148, 255), u21.Cache.Elapsed / v29);
            v.Counter.Text = string.format("%02i:%02i:%02i", v30 / 3600, v30 / 60 % 60, v30 % 60);
        end;
    end;

    UpdateIndiactors();
    local Elapsed = u21.Cache.Elapsed;
    u21.InfoLabel.Text = `Today's playtime: {string.format("%02i:%02i:%02i", Elapsed / 3600, Elapsed / 60 % 60, Elapsed % 60)}`;
    local InfoLabel2 = u21.InfoLabel2;
    local LoginCount = u21.Cache.DailyInfo.LoginCount;
    local v31 = (u21.Cache.DailyInfo.LastLogin + 1) * 86400 - os.time();
    InfoLabel2.Text = `Days logged in: {LoginCount} (Next reward in {string.format("%02i:%02i:%02i", v31 / 3600, v31 / 60 % 60, v31 % 60)})`;
end;

function u2.Load(p32) -- Line: 258
    -- upvalues: u1 (copy)
    local v33 = u1:GetPlaytimeRewardInfo():expect();
    local v34 = u1:GetDailyRewardInfo():expect();
    p32.Cache.DailyInfo = v34;
    p32.Cache.Rewards = v33.RewardInfo;
    p32.Cache.Elapsed = v33.Elapsed;
    p32.Cache.DayId = v33.DayId;
    p32.Cache.ClaimedRewards = v33.ClaimedRewards;

    for i = 1, #v33.Rewards do
        p32:CreateEntry(v33.Rewards[i]);
    end;

    p32:SetUpDailyButtons();
    p32.UIEngine.BindToClock("UpdatePlaytimeRewardsClient", 1, "PreRender", p32.Update, p32);
end;

return u2;