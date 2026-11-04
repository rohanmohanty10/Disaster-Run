 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
require(ReplicatedStorage.Shared.Tables.StatsSettings);
local LevelRewards = require(ReplicatedStorage.Shared.Tables.LevelRewards);
local v3 = Knit.CreateController({
    Name = "LevelRewardsController"
});
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;

function v3.KnitStart(p9) -- Line: 31
    -- upvalues: u8 (ref), LocalPlayer (copy), u4 (ref), Knit (copy), u5 (ref), u6 (ref), u7 (ref), LevelRewards (copy), ReplicatedStorage (copy), NumberUtil (copy), Effects (copy), MarketplaceService (copy), SfxManager (copy), RunService (copy)
    u8 = LocalPlayer.PlayerGui:WaitForChild("LevelRewards");
    u4 = Knit.GetController("Network");
    u5 = Knit.GetService("StatsService");
    u6 = Knit.GetService("LevelRewardsService");
    u7 = Knit.GetService("MatchService");
    local u10 = 0;
    local u11 = 0;
    local u12 = 0;
    local u13 = { 3272821251, 3272846858, 3272847367 };

    local function populate(p14) -- Line: 49
        -- upvalues: LevelRewards (ref), u8 (ref), ReplicatedStorage (ref), NumberUtil (ref)
        local v15;

        if p14 then
            v15 = LevelRewards.BoostedRewards;
        else
            v15 = LevelRewards.Rewards;
        end;

        for _, child in u8.BG.Rewards.Content:GetChildren() do
            if child:IsA("ImageLabel") then
                child:Destroy();
            end;
        end;

        for _, v in v15 do
            local v16 = v[4];
            local string_find_ret = string.find(v[1], "Lucky");
            local v17 = ReplicatedStorage.Assets.UI:FindFirstChild((`{string_find_ret and "Mythic" or "Legendary"}Display`)):Clone();
            v17.Name = v[2];
            v17.LayoutOrder = -v16;
            v17.Icon.Image = LevelRewards.Icons[v[1]];
            v17.Reward.Text = string.upper((`{NumberUtil.TruncateNumber(v[3][1], 1)}-{NumberUtil.TruncateNumber(v[3][2], 1)} {v[2]}`));
            v17.Chance.Text = string.upper((`{v16}%`));
            v17.Parent = u8.BG.Rewards.Content;

            if string_find_ret then
                v17.Icon.Rainbow.Enabled = true;
            end;
        end;

        if p14 then
            u8.BG.Rewards.TextLabel.Text = "BONUS REWARDS";

            return;
        end;

        u8.BG.Rewards.TextLabel.Text = "REWARDS";
    end;

    local function spin(p18) -- Line: 83
        -- upvalues: u11 (ref), u12 (ref), u10 (ref), u13 (copy), populate (copy), Effects (ref), MarketplaceService (ref), LocalPlayer (ref), u6 (ref), u8 (ref), LevelRewards (ref), SfxManager (ref), u4 (ref)
        if u11 == 0 and (u12 == 0 and u10 < #u13) then
            populate(true);
            Effects:Popup("Showing bonus reward chances!", 3);
            MarketplaceService:PromptProductPurchase(LocalPlayer, u13[u10 + 1]);

            return;
        end;

        local v19, v20 = u6:Spin(p18);

        if p18 then
            u12 = u12 - 1;
        else
            u11 = u11 - 1;
        end;

        if not v19 then
            return;
        end;

        u8.BG.Spin.Visible = false;
        u8.BG.Close.Visible = false;
        local math_random_ret = math.random(25, 35);

        for i = 1, math_random_ret do
            local v21 = LevelRewards.Rewards[math.random(1, #LevelRewards.Rewards)];
            local math_random_ret2 = math.random(v21[3][1], v21[3][2]);
            local v22 = LevelRewards.Icons[v21[1]];
            local v23 = v21[2];
            local string_find_ret = string.find(v21[1], "Lucky");
            u8.BG.RewardIcon.Image = v22;
            u8.BG.RewardIcon.Rainbow.Enabled = string_find_ret;
            u8.BG.RewardName.Text = `{math_random_ret2} {v23}`;

            if string_find_ret then
                u8.BG.RewardSun.ImageColor3 = Color3.fromHex("#ff5050");
            else
                u8.BG.RewardSun.ImageColor3 = Color3.new(1, 1, 1);
            end;

            SfxManager:playSound({
                Sound = "Spin",
                Parent = workspace
            });
            task.wait(i / math_random_ret / 4);
            local _ = i;
        end;

        u8.BG.Close.Visible = true;
        SfxManager:playSound({
            Sound = "UnlockStyle",
            Parent = workspace
        });
        local v24 = LevelRewards.Icons[v19[1]];
        local v25 = v19[2];
        local string_find_ret = string.find(v19[1], "Lucky");
        u8.BG.RewardIcon.Rainbow.Enabled = string_find_ret;

        if string_find_ret then
            u8.BG.RewardSun.ImageColor3 = Color3.fromHex("#ff5050");
        else
            u8.BG.RewardSun.ImageColor3 = Color3.new(1, 1, 1);
        end;

        u8.BG.RewardIcon.Image = v24;
        u8.BG.RewardName.Text = `{v20} {v25}`;

        if u11 == 0 and (u12 == 0 and (u10 < #u13 and not u4.Policy)) then
            u8.BG.Spin.CloseText.Text = "BONUS REWARD";
            u8.BG.Spin.Visible = true;

            return;
        end;

        if u11 <= 0 and u12 <= 0 then
            u8.BG.Spin.Visible = false;

            return;
        end;

        u8.BG.Spin.CloseText.Text = `SPIN (x{u11 + u12})`;
        u8.BG.Spin.Visible = true;
    end;

    u7.EndMatch:Connect(function() -- Line: 161
        -- upvalues: ReplicatedStorage (ref), u11 (ref), u4 (ref), u12 (ref), u8 (ref), u10 (ref), spin (copy)
        ReplicatedStorage.GameValues.State:GetPropertyChangedSignal("Value"):Wait();
        u11 = u4.Player.LevelSpins;
        u12 = u4.Player.BonusLevelSpins;

        if u11 == 0 and u12 == 0 then
            return;
        end;

        u8.Enabled = true;
        u10 = 0;
        spin(u12 > 0);
    end);
    u8.BG.Close.Activated:Connect(function() -- Line: 175
        -- upvalues: u8 (ref)
        u8.Enabled = false;
    end);
    u8.BG.Spin.Activated:Connect(function() -- Line: 179
        -- upvalues: spin (copy), u12 (ref)
        spin(u12 > 0);
    end);
    RunService.PreRender:Connect(function(p26) -- Line: 183
        -- upvalues: u8 (ref)
        if not u8.Enabled then
            return;
        end;

        local RewardSun = u8.BG.RewardSun;
        RewardSun.Rotation = RewardSun.Rotation + 90 * p26;
    end);
    u6.BonusReward:Connect(function() -- Line: 191
        -- upvalues: u10 (ref), u12 (ref), spin (copy)
        u10 = u10 + 1;
        u12 = u12 + 1;
        spin(true);
    end);
    populate(false);
end;

function v3.KnitInit(p27) -- Line: 200
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    LocalPlayer.CharacterAdded:Connect(function(p28) -- Line: 201
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p28;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
end;

return v3;