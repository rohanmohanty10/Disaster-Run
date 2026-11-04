  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("Players");
game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Tweens);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local v2 = Knit.CreateController({
    Name = "Quests"
});
local u3 = tick();

function v2.KnitStart(u4) -- Line: 28
    -- upvalues: Knit (copy), ReplicatedStorage (copy), LocalPlayer (copy), Essentials (copy), Popup (copy), u3 (ref), MarketplaceService (copy)
    u4.QS = Knit.GetService("QuestsService");
    workspace.Quests.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Emotes.Parrot):Play();
    workspace.Quests3.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Emotes.HypeHype):Play();
    workspace.EventSignUp.SignUpNPC.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Emotes.Sheesh):Play();
    local Quests = u4.QS:GetQuests();

    while Quests == nil do
        Quests = u4.QS:GetQuests();
        task.wait(0.25);
    end;

    workspace:WaitForChild("Quests"):WaitForChild("HumanoidRootPart"):WaitForChild("Prox").Triggered:Connect(function(p5) -- Line: 59
        -- upvalues: LocalPlayer (ref)
        if p5 ~= LocalPlayer then
            return;
        end;

        LocalPlayer.PlayerGui.Quests.Enabled = true;
        LocalPlayer.PlayerGui.HUD.Enabled = false;
    end);
    LocalPlayer.PlayerGui.Quests.BG.TopFrame.TrackerFrame.Bar.Gradient.Offset = Vector2.new(Quests.QuestsDone / 8 - 1, 0);
    local u6 = {
        Money = "rbxassetid://123572707549677",
        Flow = "rbxassetid://89367411223809",
        Spin = "rbxassetid://102393117398440"
    };
    local u7 = {
        Spin = "rbxassetid://125339871021518",
        Flow = "rbxassetid://133558083095603",
        Money = "rbxassetid://73450831489751"
    };

    for i, v in pairs(Quests.Quests) do
        local v8 = LocalPlayer.PlayerGui.Quests.BG.BottomFrame.Quests[i];
        v8.ProgressBar.ProgressBarFill.Gradient.Offset = Vector2.new(v.AmountDone / v.Requirements.Amount - 1, 0);
        v8.RewardBox.Image = u6[v.Reward.Name];
        v8.RewardBox.RewardIcon.Image = u7[v.Reward.Name];

        if v.Reward.Name == "Spin" then
            v8.RewardBox.Text.Text = "+" .. tostring(v.Reward.Amount) .. " Spins";
        elseif v.Reward.Name == "Flow" then
            v8.RewardBox.Text.Text = "+" .. tostring(v.Reward.Amount) .. " Flow Spins";
        elseif v.Reward.Name == "Money" then
            v8.RewardBox.Text.Text = "+" .. Essentials:formatNumberWithCommas(v.Reward.Amount) .. " Cash";
        end;

        if v.Requirements.Mission == "Match" then
            v8.Quest.Text = "Play " .. tostring(v.Requirements.Amount) .. " Matches!";
        elseif v.Requirements.Mission == "Goal" then
            v8.Quest.Text = "Score " .. tostring(v.Requirements.Amount) .. " Goals!";
        elseif v.Requirements.Mission == "Assist" then
            v8.Quest.Text = "Score " .. tostring(v.Requirements.Amount) .. " Assists!";
        elseif v.Requirements.Mission == "Steal" then
            v8.Quest.Text = "Steal the ball " .. tostring(v.Requirements.Amount) .. " times!";
        elseif v.Requirements.Mission == "Ankle" then
            v8.Quest.Text = "Do " .. tostring(v.Requirements.Amount) .. " Ankle Breakers!";
        end;

        v8.ClaimButton.Visible = true;
        v8.SkipButton.Visible = true;

        if v.Done == false and (v.AmountDone >= v.Requirements.Amount and v.AmountDone < v.Requirements.Amount + 1) then
            Popup.Popup(LocalPlayer, "FINISHED QUEST!");
        elseif v.Done then
            v8.ClaimButton.Visible = false;
            v8.SkipButton.Visible = false;
        end;
    end;

    u4.Trove:Connect(u4.QS.Quest, function(p9) -- Line: 105
        -- upvalues: Quests (ref), LocalPlayer (ref), u6 (copy), u7 (copy), Essentials (ref), Popup (ref)
        if Quests then
            table.clear(Quests);
        end;

        Quests = p9;

        for i, v in pairs(Quests.Quests) do
            local v10 = LocalPlayer.PlayerGui.Quests.BG.BottomFrame.Quests[i];
            v10.ProgressBar.ProgressBarFill.Gradient.Offset = Vector2.new(v.AmountDone / v.Requirements.Amount - 1, 0);
            v10.RewardBox.Image = u6[v.Reward.Name];
            v10.RewardBox.RewardIcon.Image = u7[v.Reward.Name];

            if v.Reward.Name == "Spin" then
                v10.RewardBox.Text.Text = "+" .. tostring(v.Reward.Amount) .. " Spins";
            elseif v.Reward.Name == "Flow" then
                v10.RewardBox.Text.Text = "+" .. tostring(v.Reward.Amount) .. " Flow Spins";
            elseif v.Reward.Name == "Money" then
                v10.RewardBox.Text.Text = "+" .. Essentials:formatNumberWithCommas(v.Reward.Amount) .. " Cash";
            end;

            if v.Requirements.Mission == "Match" then
                v10.Quest.Text = "Play " .. tostring(v.Requirements.Amount) .. " Matches!";
            elseif v.Requirements.Mission == "Goal" then
                v10.Quest.Text = "Score " .. tostring(v.Requirements.Amount) .. " Goals!";
            elseif v.Requirements.Mission == "Assist" then
                v10.Quest.Text = "Score " .. tostring(v.Requirements.Amount) .. " Assists!";
            elseif v.Requirements.Mission == "Steal" then
                v10.Quest.Text = "Steal the ball " .. tostring(v.Requirements.Amount) .. " times!";
            elseif v.Requirements.Mission == "Ankle" then
                v10.Quest.Text = "Do " .. tostring(v.Requirements.Amount) .. " Ankle Breakers!";
            end;

            v10.ClaimButton.Visible = true;
            v10.SkipButton.Visible = true;

            if v.Done == false and (v.AmountDone >= v.Requirements.Amount and v.AmountDone < v.Requirements.Amount + 1) then
                Popup.Popup(LocalPlayer, "FINISHED QUEST!");
            elseif v.Done then
                v10.ClaimButton.Visible = false;
                v10.SkipButton.Visible = false;
            end;
        end;

        LocalPlayer.PlayerGui.Quests.BG.TopFrame.TrackerFrame.Bar.Gradient.Offset = Vector2.new(Quests.QuestsDone / 8 - 1, 0);
    end);

    for _, child in pairs(LocalPlayer.PlayerGui.Quests.BG.BottomFrame.Quests:GetChildren()) do
        if child:IsA("Frame") ~= false then
            u4.Trove:Connect(child.SkipButton.MouseButton1Click, function() -- Line: 155
                -- upvalues: u3 (ref), MarketplaceService (ref), LocalPlayer (ref), child (copy)
                if u3 > tick() then
                    return;
                end;

                u3 = tick() + 0.2;
                MarketplaceService:PromptProductPurchase(LocalPlayer, child.SkipButton:GetAttribute("ID"));
            end);
            u4.Trove:Connect(child.ClaimButton.MouseButton1Click, function() -- Line: 162
                -- upvalues: u3 (ref), Quests (ref), child (copy), u4 (copy)
                if u3 > tick() then
                    return;
                end;

                u3 = tick() + 0.2;

                if Quests.Quests[child.Name].AmountDone < Quests.Quests[child.Name].Requirements.Amount then
                    return;
                end;

                u4.QS.Quest:Fire(child.Name);
            end);
        end;
    end;

    u4.Trove:Connect(LocalPlayer.PlayerGui.Quests.BG.Refresh.MouseButton1Click, function() -- Line: 174
        -- upvalues: u3 (ref), MarketplaceService (ref), LocalPlayer (ref)
        if u3 > tick() then
            return;
        end;

        u3 = tick() + 0.2;
        MarketplaceService:PromptProductPurchase(LocalPlayer, LocalPlayer.PlayerGui.Quests.BG.Refresh:GetAttribute("ID"));
    end);
    task.spawn(function() -- Line: 181
        -- upvalues: Quests (ref), LocalPlayer (ref), Essentials (ref)
        while task.wait(1) do
            if Quests ~= nil and LocalPlayer.PlayerStats.LastJoin.Value ~= nil then
                LocalPlayer.PlayerGui.Quests.BG.Timer.Text = Essentials:formatCompleteTime(LocalPlayer.PlayerStats.LastJoin.Value + 86400 - os.time()) .. " UNTIL NEXT QUESTS";
            end;
        end;
    end);
    LocalPlayer.PlayerGui.Quests.BG.BottomFrame.Option.NEL.Activated:Connect(function() -- Line: 190
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.PlayerGui.Quests.Enabled = false;
        LocalPlayer.PlayerGui.NewNeoEgoists.Enabled = true;
    end);
end;

function v2.KnitInit(u11) -- Line: 198
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
    u11.Trove = Trove.new();
    u11.Trove:Connect(LocalPlayer.CharacterAdded, function(p12) -- Line: 202
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
        u1 = p12;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u11.Trove:Connect(game.Players.PlayerRemoving, function(p13) -- Line: 207
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u11 (copy)
        if p13 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u11.Trove:Destroy();
        end;
    end);
end;

return v2;