  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Popup);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Tweens);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.environment);
local u1 = false;
local LocalPlayer = Players.LocalPlayer;
local v2 = Knit.CreateController({
    Name = "DailyRewards"
});

function v2.Refresh(p3) -- Line: 20
    local DailyRewardsStreak = p3.PlayerData.DailyRewardsStreak;
    local DailyRewardsRedeemable = p3.PlayerData.DailyRewardsRedeemable;

    for _, child in ipairs(p3.Screen.Frame.Contents:GetChildren()) do
        local v4 = tostring(child);
        local v5 = tonumber(v4);
        local v6;

        if v5 < DailyRewardsStreak then
            v6 = true;
        elseif v5 == DailyRewardsStreak then
            v6 = not DailyRewardsRedeemable;
        else
            v6 = false;
        end;

        child.Claimed.Visible = v6;
        local v7;

        if v5 == DailyRewardsStreak then
            v7 = DailyRewardsRedeemable;
        else
            v7 = false;
        end;

        child.Claim.Visible = v7;
    end;
end;

function v2.KnitStart(u8) -- Line: 31
    -- upvalues: Knit (copy), ReplicatedStorage (copy), LocalPlayer (copy), MarketplaceService (copy), u1 (ref), Essentials (copy)
    u8.DailyRewardsService = Knit.GetService("DailyRewardsService");
    u8.PlayerData = u8.DailyRewardsService:GetPlayerData();

    while not u8.PlayerData do
        u8.PlayerData = u8.DailyRewardsService:GetPlayerData();
        task.wait(0.3);
    end;

    ReplicatedStorage.KnitClient.Loaded.Event:Once(function() -- Line: 40
        -- upvalues: u8 (copy), LocalPlayer (ref)
        if u8.PlayerData.JoinedBefore == true then
            local DailyRewardsRedeemable = u8.PlayerData.DailyRewardsRedeemable;
            LocalPlayer.PlayerGui.HUD.Enabled = not DailyRewardsRedeemable;
            u8.Screen.Enabled = DailyRewardsRedeemable;
            game:GetService("UserInputService").InputBegan:Connect(function(p9) -- Line: 46
                -- upvalues: u8 (ref)
                if p9.KeyCode == Enum.KeyCode.ButtonB and u8.Screen.Enabled then
                    u8.Screen.Enabled = false;
                end;
            end);
            task.delay(10, function() -- Line: 52
                -- upvalues: u8 (ref)
                if u8.Screen.Enabled then
                    local v10 = u8.DailyRewardsService:Redeem();

                    if v10 then
                        u8.PlayerData = v10;
                        u8:Refresh();
                    end;

                    u8.Screen.Enabled = false;
                end;
            end);
        end;
    end);
    u8.Screen:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 66
        -- upvalues: u8 (copy), LocalPlayer (ref)
        if u8.Screen.Enabled == false then
            if LocalPlayer.Team == game.Teams.Visitor then
                LocalPlayer.PlayerGui.HUD.Enabled = true;

                return;
            end;

            LocalPlayer.PlayerGui.InGameUI.Enabled = true;

            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    end);
    u8.Screen.Frame.SkipDayButton.MouseButton1Click:Connect(function() -- Line: 82
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        MarketplaceService:PromptProductPurchase(LocalPlayer, 2362904741);
    end);
    u8.Screen.Frame.SkipAllButton.MouseButton1Click:Connect(function() -- Line: 86
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        MarketplaceService:PromptProductPurchase(LocalPlayer, 2362917830);
    end);
    u8:Refresh();
    u8.DailyRewardsService.Reedemed:Connect(function(p11) -- Line: 91
        -- upvalues: u8 (copy)
        u8.PlayerData = p11;
        u8:Refresh();
    end);

    for _, child in ipairs(u8.Screen.Frame.Contents:GetChildren()) do
        child.Claim.MouseButton1Click:Connect(function() -- Line: 97
            -- upvalues: u1 (ref), u8 (copy)
            if not u1 then
                u1 = true;
                local v12 = u8.DailyRewardsService:Redeem();

                if v12 then
                    u8.PlayerData = v12;
                    u8:Refresh();
                end;

                u1 = false;
            end;
        end);
    end;

    task.spawn(function() -- Line: 110
        -- upvalues: u8 (copy), Essentials (ref)
        while wait(1) do
            if u8.PlayerData then
                local Timer = u8.Screen.Frame.Timer;
                local v13 = 86400 - (DateTime.now().UnixTimestamp - u8.PlayerData.DailyRewardsTimestamp);
                Timer.Text = `{Essentials:formatCompleteTime((math.max(0, v13)))} UNTIL NEXT REWARD`;
            end;
        end;
    end);
end;

function v2.KnitInit(p14) -- Line: 119
    -- upvalues: LocalPlayer (copy)
    p14.Screen = LocalPlayer.PlayerGui:WaitForChild("DailyRewards");
end;

return v2;