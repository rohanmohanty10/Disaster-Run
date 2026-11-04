 
 

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local SeasonPassLevels = require(ReplicatedStorage.Shared.Functions.SeasonPassLevels);
local SeasonPass = require(ReplicatedStorage.Shared.Tables.SeasonPass);
local Items = SeasonPass.Items;
local Attribute = script:GetAttribute("Active");
local v1 = Knit.CreateController({
    Name = "SeasonPass"
});
local u2 = nil;
local u3 = nil;

function v1.KnitInit(p4) -- Line: 28
end;

function v1.PopulateRewards(p5) -- Line: 32
    -- upvalues: Knit (copy), Items (copy), SeasonPass (copy)
    local Controller = Knit.GetController("EmotesController");

    for _, child in p5.UI.BG.Rewards:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    local function populateReward(u6: any, p7: number, p8: any) -- Line: 41
        -- upvalues: Items (ref), Controller (copy)
        if p8[1] ~= "None" then
            if p8[2] > 1 then
                u6.Quantity.Visible = true;
                u6.Quantity.Text = `x{p8[2]}`;
            end;

            local u9 = Items[p8[1]];
            u6.TextFrame.Text.Text = u9.DisplayName;

            if u9.Icon == "" then
                u6.Icon.Visible = false;

                if u9.Emote then
                    task.spawn(function() -- Line: 71
                        -- upvalues: Controller (ref), u6 (copy), u9 (copy)
                        while Controller.CharacterRig == nil do
                            task.wait();
                        end;

                        local v10 = script.EmotePreviewFrame:Clone();
                        v10.Parent = u6;
                        Controller:CreatePreview(u9.Emote, v10, Controller.CharacterRig);
                    end);

                    return;
                end;
            else
                u6.Icon.Image = u9.Icon;

                if p8[1]:match("^Lucky") then
                    script.Rainbow:Clone().Parent = u6.Icon;

                    return;
                end;
            end;

            return;
        end;

        u6:SetAttribute("None", true);
        u6.ImageTransparency = 1;
        u6.TextFrame.Visible = false;
        u6.Icon.Visible = false;
        u6.Glow.Visible = false;
    end;

    for i = 1, SeasonPass.RewardCount do
        local v11 = script.RewardCard:Clone();
        v11.Name = `{i}`;
        v11.LayoutOrder = i;
        v11.Reward.Text = `{i}`;

        if p5.Rebirths == 0 then
            populateReward(v11.FreeBox, i, SeasonPass.FreeTrack[i]);
            populateReward(v11.PremiumBox, i, SeasonPass.PaidTrack[i]);
        else
            populateReward(v11.FreeBox, i, SeasonPass.FreeRebirthTrack[i]);
            populateReward(v11.PremiumBox, i, SeasonPass.PaidRebirthTrack[i]);
        end;

        v11.Parent = p5.UI.BG.Rewards;
        local _ = i;
    end;

    local v12;

    if p5.Rebirths == 0 then
        v12 = SeasonPass.PaidTrack;
    else
        v12 = SeasonPass.PaidRebirthTrack;
    end;

    local v13 = Items[v12[SeasonPass.RewardCount][1]];
    p5.UI.BG.PurpleFrame.NameFrame.NameText.Text = v13.DisplayName;
    p5.UI.BG.PurpleFrame.Icon.Image = v13.Icon;
    p5.UI.BG.PurpleFrame.UnlockText.Text = `[PREMIUM] UNLOCKS AT LVL {SeasonPass.RewardCount}`;
end;

function v1.DataUpdate(p14) -- Line: 117
    -- upvalues: LocalPlayer (copy), SeasonPassLevels (copy), SeasonPass (copy), NumberUtil (copy)
    local SeasonPassCurrency = LocalPlayer.PlayerGui.SeasonPassCurrency;
    local v15, v16, v17 = SeasonPassLevels(p14.SeasonPassData.XP);
    local math_min_ret = math.min(v15, SeasonPass.RewardCount);
    p14.UI.BG.LevelText.Text = `LVL {math_min_ret}`;

    if math_min_ret == SeasonPass.RewardCount then
        p14.UI.BG.XPBar.XPAmount.Text = "MAX!";
        p14.UI.BG.XPBar.BarFill.UIGradient.Offset = Vector2.new(0, 0);
        p14.UI.BG.PurpleFrame.Visible = false;
        p14.UI.BG.RebirthFrame.Visible = p14.Rebirths < SeasonPass.MaxRebirths;
    else
        p14.UI.BG.XPBar.XPAmount.Text = `{v16}/{v17}`;
        p14.UI.BG.XPBar.BarFill.UIGradient.Offset = Vector2.new(math.clamp(v16 / v17, 0, 1) - 1, 0);
        p14.UI.BG.PurpleFrame.Visible = true;
        p14.UI.BG.RebirthFrame.Visible = false;
    end;

    if p14.Rebirths == SeasonPass.MaxRebirths then
        p14.UI.BG.RebirthBar.Count.Text = "MAX!";
    else
        p14.UI.BG.RebirthBar.Count.Text = `{p14.Rebirths}/{SeasonPass.MaxRebirths}`;
    end;

    p14.UI.BG.CurrencyCounter.Amount.Text = NumberUtil.WithCommas(p14.SeasonPassData.Currency);
    SeasonPassCurrency.BG.CurrencyCounter.Amount.Text = NumberUtil.WithCommas(p14.SeasonPassData.Currency);

    for _, child in p14.UI.BG.Rewards:GetChildren() do
        if child:IsA("Frame") then
            child.PremiumBox.LockedOverlay.Visible = not p14.SeasonPassData.Premium;
        end;
    end;

    if math_min_ret > 0 then
        for i = 1, math_min_ret do
            if not p14.UI.BG.Rewards[`{i}`].FreeBox:GetAttribute("None") then
                p14.UI.BG.Rewards[`{i}`].FreeBox.ClaimedOverlay.Visible = true;
            end;

            local v18;

            if p14.SeasonPassData.Premium then
                p14.UI.BG.Rewards[`{i}`].PremiumBox.ClaimedOverlay.Visible = true;
                v18 = i;
            else
                v18 = i;
            end;
        end;
    end;

    p14.UI.BG.UnlockButton.Visible = not p14.SeasonPassData.Premium;
end;

function v1.KnitStart(u19) -- Line: 170
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), Attribute (copy), LocalPlayer (copy), ReplicatedStorage (copy), Effects (copy), MarketplaceService (copy), SeasonPassLevels (copy), SeasonPass (copy)
    u2 = Knit.GetController("Network");
    u3 = Knit.GetController("PromptController");
    u19.Active = Attribute;

    if not Attribute then
        return;
    end;

    u19.UI = LocalPlayer.PlayerGui:WaitForChild("SeasonPass");
    local SeasonPassCurrency = LocalPlayer.PlayerGui:WaitForChild("SeasonPassCurrency");
    local Button = LocalPlayer.PlayerGui:WaitForChild("HUD").Bundles.SeasonPass.Button;
    u19.SeasonPassData = u2.Player.SeasonPass;
    u19.Rebirths = u19.SeasonPassData.Rebirths;
    u19:PopulateRewards();
    u19:DataUpdate();
    local u20 = nil;
    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 189
        -- upvalues: u2 (ref), u19 (copy), u20 (ref)
        local SeasonPass2 = u2.Player.SeasonPass;
        local v21 = `{SeasonPass2.XP}|{SeasonPass2.Currency}|{SeasonPass2.Premium}|{SeasonPass2.Rebirths}|{u19.Rebirths}`;

        if SeasonPass2 == u19.SeasonPassData and v21 == u20 then
            return;
        end;

        u20 = v21;

        if u19.SeasonPassData ~= u2.SeasonPass then
            u19.SeasonPassData = u2.Player.SeasonPass;
            u19:DataUpdate();

            if u19.Rebirths ~= u19.SeasonPassData.Rebirths then
                u19.Rebirths = u19.SeasonPassData.Rebirths;
                u19:PopulateRewards();
            end;
        end;
    end);
    u19.UI.BG.UnlockButton.Activated:Connect(function() -- Line: 210
        -- upvalues: u2 (ref), Effects (ref), MarketplaceService (ref), LocalPlayer (ref)
        if u2.Policy then
            Effects:Popup("This purchase is not available for your region.");

            return;
        end;

        MarketplaceService:PromptProductPurchase(LocalPlayer, 3311175649);
    end);
    u19.UI.BG.GiftButton.Activated:Connect(function() -- Line: 214
        -- upvalues: Knit (ref)
        Knit.GetController("GiftingController").PromptGiftPlayer(3311175649);
    end);
    u19.UI.BG.RebirthFrame.RebirthButton.Activated:Connect(function() -- Line: 219
        -- upvalues: Knit (ref), Effects (ref)
        local v22, v23 = Knit.GetService("SeasonPassService"):Rebirth();
        local v24;

        if v22 then
            v24 = Color3.new(0, 1, 0);
        else
            v24 = Color3.new(1, 0, 0);
        end;

        Effects:Popup(v23, 3, v24);
    end);
    u19.UI.BG.PurpleFrame.BuySkipsButton.Activated:Connect(function() -- Line: 226
        -- upvalues: SeasonPassLevels (ref), u19 (copy), SeasonPass (ref), Knit (ref)
        local v25 = SeasonPassLevels(u19.SeasonPassData.XP);
        local v26 = {};

        for _, v in { { 3312498763, 1 }, { 3312499949, 5 }, { 3312500464, 15 } } do
            if v25 + v[2] <= SeasonPass.RewardCount then
                table.insert(v26, {
                    ProductId = v[1],
                    ImageId = SeasonPass.Items.Currency.Icon
                });
            end;
        end;

        Knit.GetController("BuySpinsController").ShowGui("BuyPassSkips", v26, true);
    end);
    u19.UI.BG.TabButtonsFrame.QuestsButton.Activated:Connect(function() -- Line: 250
        -- upvalues: u19 (copy), LocalPlayer (ref)
        u19.UI.Enabled = false;
        LocalPlayer.PlayerGui.Quests.Enabled = true;
    end);
    u19.UI.BG.TabButtonsFrame.CratesButton.Activated:Connect(function() -- Line: 255
        -- upvalues: u19 (copy), LocalPlayer (ref)
        u19.UI.Enabled = false;
        LocalPlayer.PlayerGui.Crates.Enabled = true;
    end);
    u19.UI.BG.TabButtonsFrame.CrateSpinsButton.Activated:Connect(function() -- Line: 260
        -- upvalues: u19 (copy), LocalPlayer (ref)
        u19.UI.Enabled = false;
        LocalPlayer.PlayerGui.CrateSpins.Enabled = true;
    end);
    u19.UI.BG.CloseButton.Activated:Connect(function() -- Line: 265
        -- upvalues: u19 (copy), LocalPlayer (ref)
        u19.UI.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = true;
    end);
    u19.UI.BG.CurrencyCounter.PlusButton.Activated:Connect(function() -- Line: 270
        -- upvalues: u19 (copy), LocalPlayer (ref)
        u19.UI.Enabled = false;
        LocalPlayer.PlayerGui.SeasonPassCurrency.Enabled = true;
    end);
    Button.Activated:Connect(function() -- Line: 275
        -- upvalues: u19 (copy), LocalPlayer (ref)
        u19.UI.Enabled = true;
        LocalPlayer.PlayerGui.HUD.Enabled = false;
    end);
    SeasonPassCurrency.BG.TabButtonsFrame.SeasonPassButton.Activated:Connect(function() -- Line: 280
        -- upvalues: SeasonPassCurrency (copy), LocalPlayer (ref)
        SeasonPassCurrency.Enabled = false;
        LocalPlayer.PlayerGui.SeasonPass.Enabled = true;
    end);
    SeasonPassCurrency.BG.TabButtonsFrame.QuestsButton.Activated:Connect(function() -- Line: 285
        -- upvalues: SeasonPassCurrency (copy), LocalPlayer (ref)
        SeasonPassCurrency.Enabled = false;
        LocalPlayer.PlayerGui.Quests.Enabled = true;
    end);
    SeasonPassCurrency.BG.TabButtonsFrame.CratesButton.Activated:Connect(function() -- Line: 290
        -- upvalues: SeasonPassCurrency (copy), LocalPlayer (ref)
        SeasonPassCurrency.Enabled = false;
        LocalPlayer.PlayerGui.Crates.Enabled = true;
    end);
    SeasonPassCurrency.BG.CloseButton.Activated:Connect(function() -- Line: 295
        -- upvalues: SeasonPassCurrency (copy), LocalPlayer (ref)
        SeasonPassCurrency.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = true;
    end);

    for _, child in pairs(SeasonPassCurrency.BG.MainFrame.Content:GetChildren()) do
        if child:IsA("ImageLabel") then
            task.spawn(function() -- Line: 302
                -- upvalues: u3 (ref), child (copy), u2 (ref), Effects (ref), MarketplaceService (ref), LocalPlayer (ref)
                local v27 = u3.RepeatGetProductInfo(child:GetAttribute("ProductId"), Enum.InfoType.Product);
                child.RobuxButton.Text.Text = v27.PriceInRobux;
                child.RobuxButton.Activated:Connect(function() -- Line: 306
                    -- upvalues: u2 (ref), Effects (ref), MarketplaceService (ref), LocalPlayer (ref), child (ref)
                    if u2.Policy then
                        Effects:Popup("This purchase is not available for your region.");

                        return;
                    end;

                    MarketplaceService:PromptProductPurchase(LocalPlayer, child:GetAttribute("ProductId"));
                end);
            end);
        end;
    end;
end;

return v1;