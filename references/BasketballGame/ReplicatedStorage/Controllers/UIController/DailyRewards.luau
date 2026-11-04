 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
game:GetService("UserInputService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
game:GetService("ContentProvider");
local Knit = require(ReplicatedStorage.Packages.Knit);
local DailyRewards = require(ReplicatedStorage.Shared.Tables.DailyRewards);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local DailyRewards2 = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("DailyRewards");
local u1 = Trove.new();
local u2 = {
    Emotes = "Emote",
    ZoneSpins = "Zone Spins",
    LuckySpins = "Lucky Style Spins",
    TrailColorSpins = "Trail Color Spins",
    ZoneColorSpins = "Zone Color Spins"
};
local u3 = Knit.CreateController({
    Name = "DailyRewardsController",
    HasSomethingToClaim = false
});

function u3.UpdateButton(u4: number) -- Line: 42
    -- upvalues: Knit (copy), DailyRewards (copy), GetUnixTime (copy), DailyRewards2 (copy), u2 (copy), u1 (copy), RunService (copy), u3 (copy), Effects (copy), Essentials (copy)
    local Controller = Knit.GetController("Network");
    local v5 = DailyRewards[u4];
    local string_split_ret = string.split(v5.DataIndex, " ");
    local v6 = string_split_ret[#string_split_ret];
    local v7 = GetUnixTime();
    local u8 = DailyRewards2.Content.Content:FindFirstChild("Reward" .. u4);
    u8.Title.Text = `DAY {u4}`;
    u8.Value.Text = `{v5.Value} {u2[v6] or v6}`;

    if v5.DataIndex ~= "Emotes" then
        u8.Icon.Image = `rbxassetid://{v5.ImageId or 82949801556287}`;

        if v5.IsRainbow then
            script.Rainbow:Clone().Parent = u8.Icon;
        elseif u8.Icon:FindFirstChild("Rainbow") then
            u8.Icon.Rainbow:Destroy();
        end;
    end;

    local v9 = (Controller.Player.DailyRewardStreak - 1) % #DailyRewards + 1;

    local function SetupClaimable() -- Line: 69
        -- upvalues: u8 (copy), u1 (ref), Knit (ref), u4 (copy), RunService (ref), u3 (ref), Effects (ref)
        u8.Claim.Label.Text = "CLAIM!";
        u8.Claim.Visible = true;
        u1:Add(u8.Claim.MouseButton1Click:Connect(function() -- Line: 73
            -- upvalues: Knit (ref), u4 (ref), RunService (ref), u3 (ref), Effects (ref)
            if not Knit.GetService("DailyRewardsService"):ClaimDailyReward(u4) then
                Effects:Popup("Couldn\'t Claim Daily Reward", 2, Color3.fromRGB(255, 0, 0));

                return;
            end;

            RunService.PreAnimation:Wait();
            u3.RefreshGui();
        end));
    end;

    u8.Claim.Visible = false;
    u8.Claimed.Visible = false;
    u8.Darkened.Visible = false;

    if u4 > v9 then
        if u4 == v9 + 1 then
            if not Controller.Player.LastDailyRewardClaimed or v7 - Controller.Player.LastDailyRewardClaimed >= 86400 then
                u8.Claim.Label.Text = "CLAIM!";
                u8.Claim.Visible = true;
                u1:Add(u8.Claim.MouseButton1Click:Connect(function() -- Line: 73
                    -- upvalues: Knit (ref), u4 (copy), RunService (ref), u3 (ref), Effects (ref)
                    if not Knit.GetService("DailyRewardsService"):ClaimDailyReward(u4) then
                        Effects:Popup("Couldn\'t Claim Daily Reward", 2, Color3.fromRGB(255, 0, 0));

                        return;
                    end;

                    RunService.PreAnimation:Wait();
                    u3.RefreshGui();
                end));

                return;
            end;

            local u10 = nil;
            u1:Add(RunService.Heartbeat:Connect(function() -- Line: 104
                -- upvalues: Controller (copy), u3 (ref), GetUnixTime (ref), u10 (ref), Essentials (ref), u8 (copy)
                if not Controller.Player.LastDailyRewardClaimed then
                    u3.RefreshGui();

                    return;
                end;

                local v11 = 86400 - (GetUnixTime() - Controller.Player.LastDailyRewardClaimed);

                if v11 == u10 then
                    return;
                end;

                u10 = v11;
                local v12 = Essentials:formatCompleteTime(v11);
                u8.Claim.Label.Text = v12;
                u8.Claim.Visible = true;

                if v11 > 0 then
                    return;
                end;

                u3.RefreshGui();
            end));
        end;

        return;
    end;

    if Controller.Player.DailyRewardsClaimed[tostring(u4)] == true then
        u8.Claimed.Visible = true;
        u8.Darkened.Visible = true;

        return;
    end;

    u8.Claim.Label.Text = "CLAIM!";
    u8.Claim.Visible = true;
    u1:Add(u8.Claim.MouseButton1Click:Connect(function() -- Line: 73
        -- upvalues: Knit (ref), u4 (copy), RunService (ref), u3 (ref), Effects (ref)
        if not Knit.GetService("DailyRewardsService"):ClaimDailyReward(u4) then
            Effects:Popup("Couldn\'t Claim Daily Reward", 2, Color3.fromRGB(255, 0, 0));

            return;
        end;

        RunService.PreAnimation:Wait();
        u3.RefreshGui();
    end));
end;

function u3.RefreshGui() -- Line: 133
    -- upvalues: u1 (copy), DailyRewards (copy), u3 (copy), Knit (copy), DailyRewards2 (copy)
    u1:Clean();

    for i = 1, #DailyRewards do
        u3.UpdateButton(i);
        local _ = i;
    end;

    local Controller = Knit.GetController("Network");
    local v13 = (Controller.Player.DailyRewardStreak - 1) % #DailyRewards + 1;
    local v14 = Controller.Player.DailyRewardStreak % 35;
    DailyRewards2.Content.MainFrame.Streak.Label.Text = `{Controller.Player.DailyRewardStreak} DAY{Controller.Player.DailyRewardStreak > 1 and "S" or ""} STREAK`;
    DailyRewards2.Content.Progress.BarBG.BarFill.UIGradient.Offset = Vector2.new(math.clamp(v14 / 7, 0, 5) / 5 - 1, 0);
    local v15 = false;

    for i = 1, v13 do
        if not Controller.Player.DailyRewardsClaimed[tostring(i)] then
            v15 = true;
            break;
        end;

        local _ = i;
    end;

    for _, child in pairs(DailyRewards2.Content.Progress:GetChildren()) do
        if child:IsA("ImageLabel") and child:FindFirstChild("CheckIcon") then
            if tonumber(child.Name) then
                local v16 = tonumber(child.Name);
                local math_floor_ret = math.floor(v14 / 7);

                if v16 <= math.clamp(math_floor_ret, 0, 5) then
                    child.CheckIcon.Visible = true;
                else
                    child.CheckIcon.Visible = false;
                end;
            else
                child.CheckIcon.Visible = false;
            end;
        end;
    end;

    u3.HasSomethingToClaim = v15;
end;

function u3.KnitInit(p17) -- Line: 169
    -- upvalues: DailyRewards2 (copy), MarketplaceService (copy), LocalPlayer (copy)
    DailyRewards2.Content.SkipDay.MouseButton1Click:Connect(function() -- Line: 170
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        MarketplaceService:PromptProductPurchase(LocalPlayer, 2936270625);
    end);
    DailyRewards2.Content.SkipAll.MouseButton1Click:Connect(function() -- Line: 173
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        MarketplaceService:PromptProductPurchase(LocalPlayer, 2936274836);
    end);
end;

function u3.KnitStart(p18) -- Line: 178
    -- upvalues: Knit (copy), u3 (copy), LocalPlayer (copy), DailyRewards2 (copy), ReplicatedStorage (copy), Effects (copy)
    local InLoadingScreen = game:GetService("ReplicatedFirst"):WaitForChild("InLoadingScreen");

    while InLoadingScreen.Value == true do
        InLoadingScreen.Changed:Wait();
    end;

    if Knit.GetService("CustomServerService"):GetGamemode() ~= "Normal" then
        return;
    end;

    u3.RefreshGui();
    local Controller = Knit.GetController("UIController");

    local function TryPromptKeybinds() -- Line: 193
        -- upvalues: Knit (ref), LocalPlayer (ref), Controller (copy)
        if Knit.GetController("Network").Player.PromptedKeybindPassing then
            return;
        end;

        local Service = Knit.GetService("SettingsService");

        if Knit.GetController("KeybindsController").GetPlatform() == "Keyboard" then
            local KeybindPassingPrompt = LocalPlayer.PlayerGui.KeybindPassingPrompt;
            KeybindPassingPrompt.BG.Yes.MouseButton1Click:Once(function() -- Line: 206
                -- upvalues: KeybindPassingPrompt (copy), Controller (ref), Service (copy)
                KeybindPassingPrompt.Enabled = false;
                Controller:Focus(false);
                Service:UpdateSetting("KeybindPassing", true);
                Service:StopPromptingKeybindPassing(true);
            end);
            KeybindPassingPrompt.BG.No.MouseButton1Click:Once(function() -- Line: 213
                -- upvalues: KeybindPassingPrompt (copy), Controller (ref), Service (copy)
                KeybindPassingPrompt.Enabled = false;
                Controller:Focus(false);
                Service:StopPromptingKeybindPassing(false);
            end);
            KeybindPassingPrompt.Enabled = true;
            Controller:Focus(true, KeybindPassingPrompt.BG);
        end;
    end;

    local Controller2 = Knit.GetController("Network");

    if Controller2.ServerType == "Normal" and u3.HasSomethingToClaim then
        DailyRewards2.Enabled = true;
        Controller:Focus(true, DailyRewards2.Content);
        task.wait(0.1);
        LocalPlayer.PlayerGui.HUD.Enabled = false;
    end;

    local DailyRewardStreak = Controller2.Player.DailyRewardStreak;
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 244
        -- upvalues: Controller2 (copy), DailyRewardStreak (ref), u3 (ref)
        if Controller2.Player.DailyRewardStreak ~= DailyRewardStreak then
            DailyRewardStreak = Controller2.Player.DailyRewardStreak;
            u3.RefreshGui();
        end;
    end);
    Knit.GetService("DailyRewardsService").OnRewardClaimed:Connect(function(p19) -- Line: 252
        -- upvalues: Effects (ref)
        Effects:Popup(p19, 5, Color3.fromRGB(0, 255, 0));
    end);
end;

return u3;