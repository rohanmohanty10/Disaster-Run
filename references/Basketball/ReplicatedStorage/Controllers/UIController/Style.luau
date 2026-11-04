 
 

local AdService = game:GetService("AdService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local MarketplaceService = game:GetService("MarketplaceService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local GetHumDescription = require(ReplicatedStorage.Shared.Utility.GetHumDescription);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local v3 = Knit.CreateController({
    Name = "StyleController"
});
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = "Normal";
local u10 = Trove.new();
local u11 = Trove.new();
local u12 = tick();
local u13 = nil;

function v3.RefreshUI(p14) -- Line: 43
    -- upvalues: LocalPlayer (copy), Styles (copy), u6 (ref), Essentials (copy), Rarities (copy)
    local BG = LocalPlayer.PlayerGui.Style.BG;

    if BG.PlrStyle:FindFirstChildWhichIsA("UIGradient") then
        BG.PlrStyle:FindFirstChildWhichIsA("UIGradient"):Destroy();
    end;

    local Style = LocalPlayer:WaitForChild("Style");

    while Style.Value == "" do
        task.wait();
    end;

    local v15 = script.Gradients:FindFirstChild(Styles.Styles[Style.Value].Rarity);
    local math_max_ret = math.max(u6.Player.Spins, 0);
    local math_max_ret2 = math.max(u6.Player.LuckySpins, 0);
    BG.PlrStyle.Text = string.upper(Styles.Styles[LocalPlayer.Style.Value].UIName or LocalPlayer.Style.Value);
    BG.Desc.Text = Styles.Styles[LocalPlayer.Style.Value].Desc;
    BG.Spin.Left.Text = `{math_max_ret} Spins`;
    BG.LuckySpin.Left.Text = `{math_max_ret2} Spins`;
    BG.CurrencyPitty.Pity.Text = `Pity: {u6.Player.StyleSpinsDone}/50 Done`;
    BG.CurrencyPitty.LuckyPity.Text = `Lucky Pity: {u6.Player.LuckyStyleSpinsDone}/75 Done`;
    BG.CurrencyPitty.BG.Currency.Text = `${Essentials:formatNumberWithCommas(u6.Player.Money)}`;

    if LocalPlayer.Style.Value == "LukaDoncic" then
        BG.PlrStyle.Text = "LUKA DONČIĆ";
    end;

    if u6.Player.AdRarityBoost > 0 then
        BG.AdRarityNote.Text = `Boosted Spins Remaining: {u6.Player.AdRarityBoost}`;
        BG.AdRarityNote.Visible = true;
        BG.WatchAd.Visible = false;
    else
        BG.AdRarityNote.Text = "Boost your regular spin luck by watching an ad!";
        BG.AdRarityNote.Visible = BG.WatchAd.Visible;
    end;

    if u6.Player.Spins <= 0 then
        BG.Spin.Left.Text = "$2000";
    end;

    if Rarities.TextColors[Styles.Styles[Style.Value].Rarity] then
        BG.PlrStyle.TextColor3 = Rarities.TextColors[Styles.Styles[Style.Value].Rarity];
        BG.PlrStyle.UIStroke.Color = Rarities.Colors[Styles.Styles[Style.Value].Rarity];
    elseif v15 then
        v15:Clone().Parent = BG.PlrStyle;
        BG.PlrStyle.TextColor3 = Color3.new(1, 1, 1);
        BG.PlrStyle.UIStroke.Color = Color3.new(0, 0, 0);
    else
        BG.PlrStyle.TextColor3 = Rarities.Colors[Styles.Styles[Style.Value].Rarity];
        BG.PlrStyle.UIStroke.Color = Color3.new(0, 0, 0);
    end;

    local v16 = (LocalPlayer.Style.Value == "Switcher" or (LocalPlayer.Style.Value == "Psychic" or (LocalPlayer.Style.Value == "Referee" or LocalPlayer.Style.Value == "LukaDoncic"))) and true or LocalPlayer.Style.Value == "Genius";
    BG.SwitcherConfirm.Visible = v16;
    BG.SwitcherInput.Visible = v16;
    BG.SwitcherNote.Visible = v16;
    BG.SwitcherCurrentUser.Visible = v16;

    for i = 1, 8 do
        local v17 = BG.Slots[`Slot{tostring(i)}`];
        local v18 = u6.Player.StyleSlots[i];
        local v19;

        if v18 then
            v17.StyleName.Text = Styles.Styles[v18].Name;
            v17.ImageColor3 = Rarities.Colors[Styles.Styles[v18].Rarity];
            v17.EquipTxt.Visible = true;

            if i == u6.Player.StyleSlotEquipped and u6.Player.LimitedStyleEquipped == nil then
                v17.EquipTxt.Text = "EQUIPPED";
            else
                v17.EquipTxt.Text = "EQUIP";
            end;

            v17.Lock.Visible = true;
            v19 = i;
        elseif i <= u6.Player.MaxStyleSlots then
            v17.StyleName.Text = "Empty";
            v17.ImageColor3 = Color3.fromRGB(150, 150, 150);
            v17.Lock.Visible = true;
            v19 = i;
        else
            v17.StyleName.Text = "LOCKED";
            v17.ImageColor3 = Color3.fromRGB(49, 49, 49);
            v17.EquipTxt.Visible = false;
            v17.Lock.Visible = false;
            v19 = i;
        end;
    end;

    for _, child in BG.LimitedStyles.Content:GetChildren() do
        if child:IsA("GuiButton") then
            child.EquipTxt.Text = u6.Player.LimitedStyleEquipped == child.Name and "EQUIPPED" or "EQUIP";
        end;
    end;
end;

function v3.Styles(u20) -- Line: 141
    -- upvalues: LocalPlayer (copy), u6 (ref), u12 (ref), Effects (copy), u4 (ref), MarketplaceService (copy), Knit (copy), ReplicatedStorage (copy), Players (copy), Styles (copy), Rarities (copy), TweenService (copy)
    local BG = LocalPlayer.PlayerGui.Style.BG;
    local u21 = tick();
    local u22 = {
        [2] = 3244604302,
        [3] = 3244604385,
        [4] = 3256886711,
        [5] = 3276711711,
        [6] = 3276711847,
        [7] = 3290503665,
        [8] = 3311664298
    };

    for _, child in BG.Slots:GetChildren() do
        if child:IsA("ImageButton") ~= false then
            local string_sub_ret = string.sub(child.Name, 5, 5);
            local u23 = tonumber(string_sub_ret);

            local function updateLock(p24: boolean) -- Line: 160
                -- upvalues: child (copy)
                if p24 then
                    child.Lock.Image = "rbxassetid://80913328536988";

                    return;
                end;

                child.Lock.Image = "rbxassetid://79577024969254";
            end;

            if u6.Player.LockedSlots.Style[u23] then
                child.Lock.Image = "rbxassetid://80913328536988";
            else
                child.Lock.Image = "rbxassetid://79577024969254";
            end;

            child.MouseButton1Click:Connect(function() -- Line: 170
                -- upvalues: u23 (copy), u6 (ref), u21 (ref), u12 (ref), u20 (copy), Effects (ref), u4 (ref), LocalPlayer (ref), MarketplaceService (ref), u22 (copy)
                if u23 > u6.Player.MaxStyleSlots + 1 then
                    return;
                end;

                if not u6.Player.StyleSlots[u23] then
                    MarketplaceService:PromptProductPurchase(LocalPlayer, u22[u23]);

                    return;
                end;

                if u21 > tick() then
                    return;
                end;

                if u12 > tick() then
                    return;
                end;

                if u23 == u6.Player.StyleSlotEquipped and u6.Player.LimitedStyleEquipped == nil then
                    return;
                end;

                if u20.Party.InQueue then
                    Effects:Popup("Cannot change slots whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

                    return;
                end;

                u21 = tick() + 0.4;
                u4.Slot:Fire(u23);
                LocalPlayer.Style:GetPropertyChangedSignal("Value"):Once(function() -- Line: 190
                    -- upvalues: u20 (ref)
                    u20:RefreshUI();
                end);
            end);
            child.Lock.MouseButton1Click:Connect(function() -- Line: 199
                -- upvalues: u23 (copy), u6 (ref), u4 (ref), Effects (ref), child (copy)
                if u23 > u6.Player.MaxStyleSlots + 1 then
                    return;
                end;

                local v25 = not u6.Player.LockedSlots.Style[u23];
                u4:SetLocked(u23, v25);
                Effects:Popup("Slot " .. (v25 and "locked" or "unlocked") .. "!");

                if v25 then
                    child.Lock.Image = "rbxassetid://80913328536988";

                    return;
                end;

                child.Lock.Image = "rbxassetid://79577024969254";
            end);

            if child:FindFirstChild("Gift") then
                child.Gift.MouseButton1Click:Connect(function() -- Line: 214
                    -- upvalues: Knit (ref), u22 (copy), u23 (copy)
                    Knit.GetController("GiftingController").PromptGiftPlayer(u22[u23]);
                end);
            end;
        end;
    end;

    BG.BuySpins.MouseButton1Click:Connect(function() -- Line: 222
        -- upvalues: Knit (ref)
        Knit.GetController("BuySpinsController").ShowGui(
            "BuyStyleSpins",
            { {
                    ProductId = 2835473863,
                    CashPrice = 499,
                    ImageId = "rbxassetid://111333169806568"
                }, {
                    ProductId = 2839604242,
                    CashPrice = 899,
                    ImageId = "rbxassetid://111333169806568"
                }, {
                    ProductId = 2839604664,
                    CashPrice = 1199,
                    ImageId = "rbxassetid://111333169806568"
                } }
        );
    end);
    BG.Spins.MouseButton1Click:Connect(function() -- Line: 242
        -- upvalues: Knit (ref)
        Knit.GetController("BuySpinsController").ShowGui(
            "BuyLuckyStyleSpins",
            { {
                    ProductId = 2835473941,
                    CashPrice = 999,
                    ImageId = "rbxassetid://111333169806568",
                    IsRainbow = true
                }, {
                    ProductId = 2839604418,
                    CashPrice = 1899,
                    ImageId = "rbxassetid://111333169806568",
                    IsRainbow = true
                }, {
                    ProductId = 2839604737,
                    CashPrice = 2499,
                    ImageId = "rbxassetid://111333169806568",
                    IsRainbow = true
                } }
        );
    end);
    local u26 = nil;
    BG.SwitcherCurrentUser.Text = "Current User: \'N/A\'";
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 269
        -- upvalues: u26 (ref), u6 (ref), BG (copy), Players (ref), u12 (ref), LocalPlayer (ref), u20 (copy)
        if u26 ~= u6.Player.SwitcherStyleOtherUser then
            u26 = u6.Player.SwitcherStyleOtherUser;
            BG.SwitcherCurrentUser.Text = `Current User: '{u6.Player.SwitcherStyleOtherUser and Players:GetNameFromUserIdAsync(u6.Player.SwitcherStyleOtherUser) or "N/A"}'`;
        end;

        if u12 > tick() then
            return;
        end;

        if not LocalPlayer.PlayerGui.Style.Enabled then
            return;
        end;

        u20:RefreshUI();
    end);
    BG.SwitcherConfirm.MouseButton1Click:Connect(function() -- Line: 281
        -- upvalues: u4 (ref), BG (copy)
        u4:ConfirmSwitcherFriend(BG.SwitcherInput.BG.Currency.Text);
        BG.SwitcherInput.BG.Currency.Text = "";
    end);

    local function SetupLimitedStyle(u27: string) -- Line: 288
        -- upvalues: Styles (ref), ReplicatedStorage (ref), Rarities (ref), BG (copy), u6 (ref), u4 (ref)
        local v28 = Styles.Styles[u27];

        if v28 == nil then
            warn("missing style config for " .. u27);

            return;
        end;

        local v29 = ReplicatedStorage.Assets.UI.LimitedStyle:Clone();
        v29.Name = u27;
        v29.StyleName.Text = v28.UIName or v28.Name;
        v29.ImageColor3 = Rarities.Colors[v28.Rarity];
        v29.Parent = BG.LimitedStyles.Content;
        v29.MouseButton1Click:Connect(function() -- Line: 301
            -- upvalues: u6 (ref), u27 (copy), u4 (ref)
            if u6.Player.LimitedStyleEquipped == u27 then
                return;
            end;

            u4.Slot:Fire(u27);
        end);
    end;

    for _, v in u6.Player.LimitedStyles do
        task.spawn(SetupLimitedStyle, v);
    end;

    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 314
        -- upvalues: u6 (ref), BG (copy), SetupLimitedStyle (copy)
        for _, v in u6.Player.LimitedStyles do
            if not BG.LimitedStyles.Content:FindFirstChild(v) then
                task.spawn(SetupLimitedStyle, v);
            end;
        end;
    end);
    BG.LimitedStylesButton.MouseButton1Click:Connect(function() -- Line: 324
        -- upvalues: BG (copy)
        BG.LimitedStyles.Visible = not BG.LimitedStyles.Visible;
    end);
    BG.LimitedStyles.Close.MouseButton1Click:Connect(function() -- Line: 327
        -- upvalues: BG (copy)
        BG.LimitedStyles.Visible = false;
    end);
    LocalPlayer.PlayerGui.Style:GetPropertyChangedSignal("Enabled"):Once(function() -- Line: 331
        -- upvalues: LocalPlayer (ref), BG (copy), TweenService (ref)
        if not LocalPlayer:GetAttribute("HasMigratedLimitedStyle") then
            return;
        end;

        LocalPlayer:SetAttribute("HasMigratedLimitedStyle", nil);
        BG.LimitedStyles.Visible = true;

        for _, child in BG.LimitedStyles.Content:GetChildren() do
            local Fade = child:FindFirstChild("Fade");

            if Fade then
                Fade.BackgroundTransparency = 1;
                TweenService:Create(Fade, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 5, true), {
                    BackgroundTransparency = 0.5
                }):Play();
            end;
        end;
    end);

    if u6.ServerType == "NoLimited" then
        BG.LimitedStylesButton.Visible = false;
    end;
end;

function v3.Spin(u30) -- Line: 364
    -- upvalues: LocalPlayer (copy), Styles (copy), Rarities (copy), u6 (ref), Effects (copy), u12 (ref), u11 (copy), MarketplaceService (copy), Knit (copy), u4 (ref), AdService (copy), u13 (ref), u8 (ref), Essentials (copy), GetUnixTime (copy), SfxManager (copy), u10 (copy), ReplicatedStorage (copy), u7 (ref), TweenService (copy)
    local BG = LocalPlayer.PlayerGui.Style.BG;
    local u31 = true;

    local function shouldConfirm() -- Line: 368
        -- upvalues: u31 (ref), Styles (ref), LocalPlayer (ref), Rarities (ref), BG (copy)
        if u31 then
            if Styles.Styles[LocalPlayer.Style.Value].Rarity ~= "Mythic" and (Styles.Styles[LocalPlayer.Style.Value].Rarity ~= "Legendary" and (table.find(Rarities.Limited, Styles.Styles[LocalPlayer.Style.Value].Rarity) == nil and Styles.Styles[LocalPlayer.Style.Value].Rarity ~= "Miracle")) then
                return false;
            end;

            BG.Confirm.Visible = true;

            return true;
        end;

        if Styles.Styles[LocalPlayer.Style.Value].Rarity ~= "Mythic" and (table.find(Rarities.Limited, Styles.Styles[LocalPlayer.Style.Value].Rarity) == nil and Styles.Styles[LocalPlayer.Style.Value].Rarity ~= "Miracle") then
            return false;
        end;

        BG.Confirm.Visible = true;

        return true;
    end;

    BG.Spin.MouseButton1Click:Connect(function() -- Line: 386
        -- upvalues: LocalPlayer (ref), u6 (ref), Effects (ref), u30 (copy), u31 (ref), u12 (ref), u11 (ref), MarketplaceService (ref), Knit (ref), shouldConfirm (copy), u4 (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            return;
        end;

        if u6.Player.LockedSlots.Style[u6.Player.StyleSlotEquipped] then
            Effects:Popup("This slot is locked!", 1, Color3.new(1, 0.458824, 0.466667));

            return;
        end;

        if u30.Party.InQueue then
            Effects:Popup("Cannot spin whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

            return;
        end;

        u31 = true;

        if u12 > tick() then
            if u6.Player.CanSkipSpins or u30.Bursting then
                u11:Clean();

                return;
            end;

            if u6.Policy then
                return;
            end;

            MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1070782960);

            return;
        end;

        if u6.Player.LimitedStyleEquipped ~= nil then
            Effects:Popup("Cannot spin with a limited style equipped!", 5, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u6.Player.Spins <= 0 and u6.Player.Money < 2000 then
            Knit.GetController("BuySpinsController").ShowGui(
                "BuyStyleSpins",
                { {
                        ProductId = 2835473863,
                        CashPrice = 499,
                        ImageId = "rbxassetid://111333169806568"
                    }, {
                        ProductId = 2839604242,
                        CashPrice = 899,
                        ImageId = "rbxassetid://111333169806568"
                    }, {
                        ProductId = 2839604664,
                        CashPrice = 1199,
                        ImageId = "rbxassetid://111333169806568"
                    } }
            );

            return;
        end;

        if shouldConfirm() then
            return;
        end;

        u12 = tick() + 10;

        if u6.Player.Spins > 0 then
            local Player = u6.Player;
            Player.Spins = Player.Spins - 1;
        end;

        if u6.Player.AdRarityBoost == 0 then
            local Player = u6.Player;
            Player.StyleSpinsDone = Player.StyleSpinsDone + 1;
        else
            local Player = u6.Player;
            Player.AdRarityBoost = Player.AdRarityBoost - 1;
        end;

        u30:RefreshUI();
        u4.Spin:Fire(false, "FroggyWoggy");
    end);
    BG.LuckySpin.MouseButton1Click:Connect(function() -- Line: 465
        -- upvalues: LocalPlayer (ref), u6 (ref), Effects (ref), u30 (copy), u31 (ref), u12 (ref), u11 (ref), MarketplaceService (ref), Knit (ref), shouldConfirm (copy), u4 (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            return;
        end;

        if u6.Player.LockedSlots.Style[u6.Player.StyleSlotEquipped] then
            Effects:Popup("This slot is locked!", 1, Color3.new(1, 0.458824, 0.466667));

            return;
        end;

        if u30.Party.InQueue then
            Effects:Popup("Cannot spin whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u30.Bursting then
            Effects:Popup("Can\'t spin luckies whilst bursting!", 1, Color3.fromRGB(255, 0, 0));

            return;
        end;

        u31 = false;

        if u12 > tick() then
            if u6.Player.CanSkipSpins then
                u11:Clean();

                return;
            end;

            if u6.Policy then
                return;
            end;

            MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1070782960);

            return;
        end;

        if u6.Player.LimitedStyleEquipped ~= nil then
            Effects:Popup("Cannot spin with a limited style equipped!", 5, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u6.Player.LuckySpins <= 0 then
            Knit.GetController("BuySpinsController").ShowGui(
                "BuyLuckyStyleSpins",
                { {
                        ProductId = 2835473941,
                        CashPrice = 999,
                        ImageId = "rbxassetid://111333169806568",
                        IsRainbow = true
                    }, {
                        ProductId = 2839604418,
                        CashPrice = 1899,
                        ImageId = "rbxassetid://111333169806568",
                        IsRainbow = true
                    }, {
                        ProductId = 2839604737,
                        CashPrice = 2499,
                        ImageId = "rbxassetid://111333169806568",
                        IsRainbow = true
                    } }
            );

            return;
        end;

        if shouldConfirm() then
            return;
        end;

        u12 = tick() + 10;
        local Player = u6.Player;
        Player.LuckySpins = Player.LuckySpins - 1;
        u30:RefreshUI();
        u4.Spin:Fire(true, "FroggyWoggy");
    end);
    BG.Confirm.Yes.MouseButton1Click:Connect(function() -- Line: 545
        -- upvalues: u6 (ref), Effects (ref), u30 (copy), u12 (ref), BG (copy), u31 (ref), u4 (ref)
        if u6.Player.LimitedStyleEquipped ~= nil then
            Effects:Popup("Cannot spin with a limited style equipped!", 5, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u6.Player.LockedSlots.Style[u6.Player.StyleSlotEquipped] then
            Effects:Popup("This slot is locked!", 1, Color3.new(1, 0.458824, 0.466667));

            return;
        end;

        if u30.Party.InQueue then
            Effects:Popup("Cannot spin whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u12 > tick() then
            return;
        end;

        u12 = tick() + 10;
        BG.Confirm.Visible = false;

        if u31 then
            local Player = u6.Player;
            Player.Spins = Player.Spins - 1;

            if u6.Player.AdRarityBoost == 0 then
                local Player2 = u6.Player;
                Player2.StyleSpinsDone = Player2.StyleSpinsDone + 1;
            else
                local Player2 = u6.Player;
                Player2.AdRarityBoost = Player2.AdRarityBoost - 1;
            end;
        else
            local Player = u6.Player;
            Player.LuckySpins = Player.LuckySpins - 1;
        end;

        u30:RefreshUI();

        if u31 then
            u4.Spin:Fire(false, "FroggyWoggy");

            return;
        end;

        u4.Spin:Fire(true, "FroggyWoggy");
    end);
    BG.Confirm.No.MouseButton1Click:Connect(function() -- Line: 589
        -- upvalues: BG (copy)
        BG.Confirm.Visible = false;
    end);
    (function() -- Line: 593, Name: setupAds
        -- upvalues: Knit (ref), BG (copy), u6 (ref), AdService (ref)
        local Controller = Knit.GetController("VideoAdController");

        local function showAd(p32) -- Line: 596
            -- upvalues: BG (ref), u6 (ref)
            BG.WatchAd.Visible = p32;
            BG.AdRarityNote.Visible = p32 or u6.Player.AdRarityBoost > 0;
        end;

        local u33 = false;
        BG.WatchAd.Activated:Connect(function() -- Line: 602
            -- upvalues: u33 (ref), BG (ref), u6 (ref), Controller (copy)
            if u33 then
                return;
            end;

            u33 = true;
            BG.WatchAd.Visible = false;
            BG.AdRarityNote.Visible = u6.Player.AdRarityBoost > 0;
            Controller:ShowAd();
            u33 = false;
        end);
        Controller.AdAvailabilityChanged:Connect(showAd);
        local AdAvailable = Controller.AdAvailable;
        BG.WatchAd.Visible = AdAvailable;
        BG.AdRarityNote.Visible = AdAvailable or u6.Player.AdRarityBoost > 0;
        task.spawn(function() -- Line: 616
            -- upvalues: AdService (ref), BG (ref)
            AdService:RegisterAdOpportunityAsync(BG.WatchAd, 341905260952773);
        end);
    end)();
    (function() -- Line: 623, Name: setupBursting
        -- upvalues: Knit (ref), u30 (copy), BG (copy), u13 (ref), u6 (ref), Effects (ref), MarketplaceService (ref), LocalPlayer (ref)
        local Service = Knit.GetService("SpinBurstService");
        Service.Bursting:Connect(function(p34) -- Line: 626
            -- upvalues: u30 (ref), BG (ref), u13 (ref)
            u30.Bursting = p34;
            BG.SpinBurst.Visible = not p34;
            BG.SpinBurst.FirstFree.Visible = false;

            if not p34 then
                u13(BG.Rarities.NormalRarities, true);
                u13(BG.Rarities.LuckyRarities, false);
                u13(BG.Rarities.BoostedRarities, false);
            end;
        end);
        local u35 = false;
        BG.SpinBurst.FirstFree.Visible = not u6.Player.FreeSpinBurstUsed;
        BG.SpinBurst.Activated:Connect(function() -- Line: 643
            -- upvalues: u30 (ref), Effects (ref), BG (ref), u13 (ref), u35 (ref), Service (copy), u6 (ref), MarketplaceService (ref), LocalPlayer (ref)
            if u30.Party.InQueue then
                Effects:Popup("Can\'t start bursting whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

                return;
            end;

            BG.BurstCheckNotice.Visible = true;
            u13(BG.Rarities.NormalRarities, false);
            u13(BG.Rarities.LuckyRarities, false);
            u13(BG.Rarities.BoostedRarities, true);

            if u35 then
                u35 = false;
                BG.BurstCheckNotice.Visible = false;
                BG.SpinBurst.Visible = false;
                Service:ClaimFreeBurst();

                return;
            end;

            if u6.Player.FreeSpinBurstUsed then
                MarketplaceService:PromptProductPurchase(LocalPlayer, 3381177164);
                MarketplaceService.PromptProductPurchaseFinished:Once(function(p36, p37, p38) -- Line: 670
                    -- upvalues: u13 (ref), BG (ref)
                    if not p38 then
                        u13(BG.Rarities.NormalRarities, true);
                        u13(BG.Rarities.LuckyRarities, false);
                        u13(BG.Rarities.BoostedRarities, false);
                    end;

                    BG.BurstCheckNotice.Visible = false;
                    BG.SpinBurst.Visible = not p38;
                end);

                return;
            end;

            u35 = true;
            BG.SpinBurst.FirstFree.Text = "CLICK AGAIN!";
            task.delay(5, function() -- Line: 686
                -- upvalues: u35 (ref), BG (ref), u13 (ref)
                if not u35 then
                    return;
                end;

                BG.SpinBurst.FirstFree.Text = "FIRST ONE FREE!";
                u35 = false;
                BG.BurstCheckNotice.Visible = false;
                u13(BG.Rarities.NormalRarities, true);
                u13(BG.Rarities.LuckyRarities, false);
                u13(BG.Rarities.BoostedRarities, false);
            end);
        end);
    end)();
    u4.Spin:Connect(function(u39: boolean) -- Line: 708
        -- upvalues: u30 (copy), u8 (ref), BG (copy), u31 (ref), Knit (ref), Essentials (ref), Styles (ref), GetUnixTime (ref), Rarities (ref), SfxManager (ref), u11 (ref), u10 (ref), ReplicatedStorage (ref), u7 (ref), LocalPlayer (ref), u12 (ref), TweenService (ref)
        local math_random_ret = math.random(25, 35);
        u30:StopRig();
        u8.WaitSpin:Play();
        u8.WaitSpinStart:Play();
        time();
        local TextLabel = BG[u31 and "Spin" or "LuckySpin"].TextLabel;
        TextLabel.Text = "SKIP";
        u11:Add((task.spawn(function() -- Line: 721
            -- upvalues: Knit (ref), Essentials (ref), Styles (ref), GetUnixTime (ref), Rarities (ref), math_random_ret (copy), BG (ref), SfxManager (ref), u11 (ref)
            local Service = Knit.GetService("LimitedTimeRarityService");
            local v40 = Essentials:DeepCopy(Styles.Styles);

            for i, v in v40 do
                local v41 = Service.Package:Get().RarityTimes[v.Rarity];

                if v41 then
                    local v42 = v41 < GetUnixTime();

                    if table.find(Rarities.Limited, v.Rarity) ~= nil and v42 then
                        v40[i] = nil;
                    end;
                end;
            end;

            for i = 1, math_random_ret do
                local v43 = Essentials:TableLength(v40);
                local math_random_ret2 = math.random(1, v43);
                local v44 = 1;
                local v45 = "";

                for _, v in v40 do
                    if math_random_ret2 == v44 then
                        v45 = v.Name;
                        break;
                    end;

                    v44 = v44 + 1;
                end;

                if BG.PlrStyle:FindFirstChildWhichIsA("UIGradient") then
                    BG.PlrStyle:FindFirstChildWhichIsA("UIGradient"):Destroy();
                end;

                local v46 = script.Gradients[Styles.Styles[v45].Rarity];
                BG.PlrStyle.Text = string.upper(v45);
                BG.Desc.Text = Styles.Styles[v45].Desc;

                if v45 == "LukaDoncic" then
                    BG.PlrStyle.Text = "LUKA DONČIĆ";
                end;

                if Rarities.TextColors[Styles.Styles[v45].Rarity] then
                    BG.PlrStyle.TextColor3 = Rarities.TextColors[Styles.Styles[v45].Rarity];
                    BG.PlrStyle.UIStroke.Color = Rarities.Colors[Styles.Styles[v45].Rarity];
                else
                    v46:Clone().Parent = BG.PlrStyle;
                    BG.PlrStyle.TextColor3 = Color3.new(1, 1, 1);
                    BG.PlrStyle.UIStroke.Color = Color3.new(0, 0, 0);
                end;

                SfxManager:playSound({
                    Sound = "Spin",
                    Parent = workspace
                });
                task.wait(i / math_random_ret / 4);
            end;

            u11:Clean();
        end)));
        u11:Add(function() -- Line: 781
            -- upvalues: SfxManager (ref), u30 (ref), u10 (ref), ReplicatedStorage (ref), u7 (ref), Rarities (ref), Styles (ref), LocalPlayer (ref), u8 (ref), u12 (ref), TextLabel (copy), u39 (copy), BG (ref), TweenService (ref)
            SfxManager:playSound({
                Sound = "UnlockStyle",
                Parent = workspace
            });
            u30:RefreshUI();
            u30:StopRig();
            u10:Clean();
            require(ReplicatedStorage.Effects.SpawnVFX)(u30, {
                CFrame = u7.HumanoidRootPart.CFrame,
                Vfx = ReplicatedStorage.Assets.VFX.NewStyle,
                Color = Rarities.Colors[Styles.Styles[LocalPlayer.Style.Value].Rarity]
            });
            u8[LocalPlayer.Style.Value]:Play();
            u12 = tick();
            TextLabel.Text = "SPIN";

            if u39 then
                BG.LimitedStyles.Visible = true;
                local Fade = BG.LimitedStyles.Content:WaitForChild(LocalPlayer.Style.Value).Fade;
                Fade.BackgroundTransparency = 1;
                TweenService:Create(Fade, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 5, true), {
                    BackgroundTransparency = 0.5
                }):Play();
            end;
        end);
    end);
end;

function v3.StopRig(p47) -- Line: 814
    -- upvalues: u8 (ref)
    if u8 == nil then
        return;
    end;

    for i, v in u8 do
        if i ~= "Idle" then
            v:Stop();
        end;
    end;
end;

function v3.Odds(u48) -- Line: 825
    -- upvalues: Knit (copy), LocalPlayer (copy), u9 (ref), u13 (ref), Trove (copy), Rarities (copy), Styles (copy), RunService (copy), Effects (copy), u4 (ref), u6 (ref), u5 (ref), GetUnixTime (copy), NumberUtil (copy)
    local Controller = Knit.GetController("UIController");
    local BG = LocalPlayer.PlayerGui.Style.BG;
    local NormalRarities = BG.Rarities.NormalRarities;

    local function changeFolder(p49, p50) -- Line: 832
        -- upvalues: NormalRarities (ref), u9 (ref)
        if p50 then
            NormalRarities = p49;
        end;

        for _, child in p49:GetChildren() do
            if not child:GetAttribute("NotVisible") and child:IsA("GuiObject") then
                child.Visible = p50;
            end;
        end;

        for _, child in p49:GetChildren() do
            if string.match(child.Name, "Style") then
                child:Destroy();
            end;
        end;

        if p50 then
            u9 = string.match(p49.Name, "Normal") and "Normal" or "Lucky";
        end;
    end;

    u13 = changeFolder;
    BG.LuckyOdds.MouseButton1Click:Connect(function() -- Line: 856
        -- upvalues: changeFolder (copy), BG (copy)
        changeFolder(BG.Rarities.NormalRarities, false);
        changeFolder(BG.Rarities.LuckyRarities, true);
    end);
    BG.NormalOdds.MouseButton1Click:Connect(function() -- Line: 860
        -- upvalues: changeFolder (copy), BG (copy)
        changeFolder(BG.Rarities.NormalRarities, true);
        changeFolder(BG.Rarities.LuckyRarities, false);
    end);
    local u51 = Trove.new();
    local u52 = {};
    local u53 = Trove.new();
    local u54 = tick();

    local function CreateRarityTitle(p55, p56, p57) -- Line: 870
        -- upvalues: u51 (copy), Rarities (ref), u9 (ref), u53 (copy), Styles (ref), BG (copy), RunService (ref), u54 (ref), Effects (ref), u4 (ref), u6 (ref)
        local u58 = p56[2] >= 0.005 and math.round(p56[2] * 100) or math.round(p56[2] * 10000) / 100;
        local v59 = u51:Add(script.RarityTitle:Clone());
        v59.LayoutOrder = p55 * 100;
        v59.Name = p56[1];
        v59.Percentage.Text = `({u58}%)`;
        v59.TextLabel.Text = p56[1];
        v59.TimeLeft.Visible = table.find(Rarities.Limited, p56[1]) ~= nil;
        v59.Visible = string.match(p57.Name, u9) ~= nil;
        local v60 = script.Gradients:FindFirstChild(p56[1]):Clone();

        if not v60:GetAttribute("DontModify") then
            local v61 = {};
            local v62, v63, v64 = v60.Color.Keypoints[1].Value:ToHSV();
            v61[1] = v60.Color.Keypoints[1];
            v61[2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(v62, math.max(v63 - 0.6, 0), v64));
            v60.Color = ColorSequence.new(v61);
        end;

        v60.Parent = v59;

        if Rarities.TextColors[p56[1]] then
            v59.TextLabel.TextColor3 = Rarities.TextColors[p56[1]];
        else
            script.Gradients:FindFirstChild(p56[1]):Clone().Parent = v59.TextLabel;
            v59.TextLabel.TextColor3 = Color3.new(1, 1, 1);
        end;

        local u65 = p56[1];
        local LayoutOrder = v59.LayoutOrder;
        local u66 = "";

        local function ReloadRarity(p67) -- Line: 909
            -- upvalues: u53 (ref), Styles (ref), u65 (copy), BG (ref), u9 (ref), LayoutOrder (copy), RunService (ref), u66 (ref), u58 (copy), Rarities (ref), u54 (ref), Effects (ref), u4 (ref), ReloadRarity (copy)
            if p67 then
                u53:Clean();
            end;

            local v68 = {};

            for _, v in Styles.Styles do
                if v.Rarity == u65 then
                    table.insert(v68, v.Name);
                end;
            end;

            for _, v in Styles.Styles do
                if v.Rarity == u65 then
                    local u69 = p67 and u53:Add(script.RarityTemplate:Clone()) or BG.Rarities[`{u9}Rarities`]:FindFirstChild(v.Name);

                    if p67 then
                        u69.LayoutOrder = LayoutOrder + 1;
                        u69.Name = v.Name;
                        u69.Parent = BG.Rarities[`{u9}Rarities`];
                    end;

                    if v.New then
                        if p67 then
                            local u70 = nil;
                            u70 = RunService.PreRender:Connect(function() -- Line: 940
                                -- upvalues: u69 (copy), u70 (ref)
                                if u69.Parent == nil then
                                    u70:Disconnect();

                                    return;
                                end;

                                local v71 = tick() * 5;
                                local v72 = math.sin(v71) * 0.05;
                                u69.NewText.Size = UDim2.fromScale(v72 + 0.3, v72 + 0.5);
                            end);
                        end;
                    elseif u69:FindFirstChild("NewText") then
                        u69.NewText:Destroy();
                    end;

                    local v73 = v.Name == u66 and u58 * 2 or u58;
                    local v74 = table.find(v68, u66) and #v68 + 1 or #v68;
                    local v75 = math.round(v73 / v74 * (u58 > 0.1 and 100 or 10000)) / (u58 > 0.1 and 100 or 10000);

                    if u66 == v.Name then
                        u69.Text = `> {v.UIName or v.Name} - {v75}% <`;
                    else
                        u69.Text = `{v.UIName or v.Name} - {v75}%`;
                    end;

                    if Rarities.TextColors[v.Rarity] then
                        u69.TextColor3 = Rarities.TextColors[v.Rarity];
                        u69.UIStroke.Color = Rarities.Colors[v.Rarity];
                    else
                        if p67 then
                            script.Gradients:FindFirstChild(v.Rarity):Clone().Parent = u69;
                        end;

                        u69.TextColor3 = Color3.new(1, 1, 1);
                        u69.UIStroke.Color = Color3.new(0, 0, 0);
                    end;

                    if p67 then
                        u53:Connect(u69.MouseButton1Click, function() -- Line: 973
                            -- upvalues: u54 (ref), u66 (ref), v (copy), Effects (ref), u4 (ref), ReloadRarity (ref)
                            if u54 > tick() then
                                return;
                            end;

                            u54 = tick() + 0.25;
                            u66 = v.Name;
                            Effects:Popup((`Higher chance to get {v.UIName or v.Name}`));
                            u4.BoostedStyle:Fire(v.Name);
                            ReloadRarity();
                        end);
                    end;
                end;
            end;
        end;

        v59.MouseButton1Click:Connect(function() -- Line: 988
            -- upvalues: u66 (ref), u6 (ref), ReloadRarity (copy)
            u66 = u6.Player.BoostedStyle;
            ReloadRarity(true);
        end);
        v59.Parent = p57;
    end;

    local function ReloadRarities() -- Line: 997
        -- upvalues: u51 (copy), Rarities (ref), u5 (ref), CreateRarityTitle (copy), BG (copy), u52 (copy)
        u51:Clean();
        local ExpiredRarities = Rarities.GetExpiredRarities(u5.Package:Get());

        for i, v in Rarities.ComputePercentages(Rarities.Odds, ExpiredRarities) do
            CreateRarityTitle(i, v, BG.Rarities.NormalRarities);
        end;

        for i, v in Rarities.ComputePercentages(Rarities.LuckyOdds, ExpiredRarities) do
            CreateRarityTitle(i, v, BG.Rarities.LuckyRarities);
        end;

        for i, v in Rarities.ComputePercentages(Rarities.SlightyLuckyOdds, ExpiredRarities) do
            CreateRarityTitle(i, v, BG.Rarities.BoostedRarities);
        end;

        table.clear(u52);

        for _, v in Rarities.Limited do
            table.insert(u52, BG.Rarities.LuckyRarities:FindFirstChild(v));
            table.insert(u52, BG.Rarities.NormalRarities:FindFirstChild(v));
            table.insert(u52, BG.Rarities.BoostedRarities:FindFirstChild(v));
        end;
    end;

    ReloadRarities();
    changeFolder(BG.Rarities.NormalRarities, true);
    changeFolder(BG.Rarities.LuckyRarities, false);
    local u76 = Trove.new();
    u5.Package:Observe(function(u77) -- Line: 1028
        -- upvalues: ReloadRarities (copy), u76 (copy), u48 (copy), u52 (copy), GetUnixTime (ref), NormalRarities (ref), Styles (ref), u6 (ref), RunService (ref), NumberUtil (ref), u53 (copy), Controller (copy), LocalPlayer (ref)
        if not u77.RarityTimes then
            return;
        end;

        ReloadRarities();
        u76:Clean();
        u48.ActiveLimitedStyles = {};
        local v78 = false;

        for _, v in u52 do
            if u77.RarityTimes[v.Name] == nil then
                v.Visible = false;
                warn((`Package.RarityTimes[{v.Name}] is nil!`));
            else
                local v79 = GetUnixTime() > u77.RarityTimes[v.Name];
                v:SetAttribute("NotVisible", v79 or nil);
                local v80 = not v79 and v:IsDescendantOf(NormalRarities);
                v.Visible = v80;

                if not v79 then
                    local u81 = v;

                    for _, v2 in Styles.Styles do
                        if v2.Rarity == u81.Name and not table.find(u6.Player.LimitedStyles, v2.Name) then
                            table.insert(u48.ActiveLimitedStyles, v2.Name);
                            v78 = true;
                        end;
                    end;

                    local u82 = nil;
                    local u83 = nil;
                    u83 = u76:Add(RunService.Heartbeat:Connect(function() -- Line: 1068
                        -- upvalues: u77 (copy), u81 (copy), GetUnixTime (ref), u82 (ref), NumberUtil (ref), u83 (ref), u53 (ref)
                        local v84 = u77.RarityTimes[u81.Name] - GetUnixTime();
                        local math_max_ret = math.max(v84, 0);

                        if math_max_ret == u82 then
                            return;
                        end;

                        u82 = math_max_ret;
                        local v85 = "LIMITED TIME: " .. NumberUtil.AdaptiveClockString(math_max_ret);
                        u81.TimeLeft.Text = v85;

                        if math_max_ret == 0 then
                            u81:SetAttribute("NotVisible", true);
                            u81.Visible = false;
                            u83:Disconnect();
                            u53:Clean();
                        end;
                    end));
                end;
            end;
        end;

        Controller:Alert(LocalPlayer.PlayerGui.HUD.Buttons:FindFirstChild("Style"), v78);
    end);
end;

function v3.KnitStart(u86) -- Line: 1101
    -- upvalues: Knit (copy), u4 (ref), u5 (ref), u6 (ref), u7 (ref), ReplicatedStorage (copy), u8 (ref), GetHumDescription (copy), LocalPlayer (copy)
    u86.Party = Knit.GetController("PartyController");
    local Controller = Knit.GetController("UIController");
    u4 = Knit.GetService("StyleService");
    u5 = Knit.GetService("LimitedTimeRarityService");
    u6 = Knit.GetController("Network");
    local script_SpinFolder = script.SpinFolder;
    u7 = ReplicatedStorage.Assets.Misc.TemplateRig:Clone();
    u7.Parent = workspace;
    u8 = {
        Idle = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Movement.Idle),
        WaitSpin = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Stuns.WaitSpin),
        WaitSpinStart = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Stuns.WaitSpinStart),
        Phantom = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets:WaitForChild("StyleAnimations"):WaitForChild("Phantom").Ability1),
        Star = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Star").Ability2),
        Sniper = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Sniper").Ability1),
        Clutch = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Clutch").Ability1),
        Ace = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Ace").Awakening),
        Flash = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Flash").Awakening),
        Giant = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Giant").ChargeL),
        Playmaker = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Playmaker").NutmegL),
        Jackpot = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Jackpot").Awakening),
        Chuck = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Chuck").Awakening),
        Lock = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Lock").Awakening),
        Copycat = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Copycat").Awakening),
        Perfection = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Perfection").Awakening),
        Emperor = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Emperor").Awakening),
        BasketballGod = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("BasketballGod").ReverseDunk),
        Fetch = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Fetch").Dive),
        Quick = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Quick").Awakening),
        Gold = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Gold").Awakening),
        Tatlis = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Tatlis").YoureMine),
        Chrollo = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Chrollo").Chaos),
        LazyWorker = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("LazyWorker").Awakening),
        UncleSam = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("UncleSam").CannonPass),
        Switcher = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Switcher").Switch2),
        Cyber = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Cyber").Projectile),
        Psychic = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Psychic").OrdinaryShot),
        Rubberman = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Rubberman").Awakening),
        Spider = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Spider").Awakening),
        Symbiote = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Symbiote").Awakening),
        Vampire = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Vampire").TimeStop),
        Referee = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Referee").ThreeStepShot),
        BasketballUnc = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("BasketballUnc").CaneEffect),
        Joker = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Joker").LaughBreaker),
        Ghost = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Joker").LaughBreaker),
        Silver = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Silver").Awakening),
        Popstar = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Popstar").SoulStrings),
        King = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("King").NoLookPassL),
        Air = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Air").Fadeaway),
        Eclipse = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Eclipse").SkyKatana),
        LukaDoncic = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("LukaDoncic").Stepback),
        Dealer = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Dealer").BlinkDeal),
        Genius = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Genius").SlowIQ),
        HonoredOne = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("HonoredOne").Awakening),
        CurseKing = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("CurseKing").SlashLayup),
        Judgement = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Judgement").GavelDunk),
        Johnny = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Judgement").GavelDunk),
        Goat = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Goat").AuraShot),
        Valentine = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Valentine").Duplication),
        Thief = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Thief").Awakening),
        Alien = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Alien").AlienDribble),
        KingOfNYC = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("KingOfNYC").Redline),
        ChrolloV2 = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("ChrolloV2").BanditDribble),
        TatlisV2 = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("TatlisV2").PhantomStep),
        Izure = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Izure").FastStep),
        ScaryMonster = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("ScaryMonster").BulletPressure),
        Kira = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("Kira").WrittenFate),
        PerfectionV2 = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations:WaitForChild("PerfectionV2").PerfectDribbleR)
    };
    u7.Parent = script;
    task.spawn(function() -- Line: 1179
        -- upvalues: GetHumDescription (ref), LocalPlayer (ref), u7 (ref), u8 (ref), script_SpinFolder (copy), u86 (copy), u6 (ref), Controller (copy)
        local v87 = GetHumDescription.FromUserId(LocalPlayer.UserId);
        u7.Parent = workspace;
        u7.Humanoid:ApplyDescription(v87);
        u7.Parent = script;

        for _, v in u8 do
            v.Priority = Enum.AnimationPriority.Action3;
        end;

        u8.WaitSpin.Priority = Enum.AnimationPriority.Action;
        u8.Idle.Priority = Enum.AnimationPriority.Idle;
        u8.Idle:Play();
        u7.Name = "StyleRig";
        u7.HumanoidRootPart.Anchored = true;
        u7.HumanoidRootPart.CFrame = script_SpinFolder.Part.CFrame * CFrame.new(0, 0, 15) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        LocalPlayer.PlayerGui.Style:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1197
            -- upvalues: LocalPlayer (ref), u86 (ref), u7 (ref), script_SpinFolder (ref), u6 (ref), Controller (ref)
            if LocalPlayer.PlayerGui.Style.Enabled then
                u86:RefreshUI();
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                workspace.CurrentCamera.CFrame = u7.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                script_SpinFolder.Parent = workspace;
                u7.Parent = workspace;

                return;
            end;

            script_SpinFolder.Parent = script;
            u7.Parent = script;

            if u86.ActiveLimitedStyles then
                local v88 = false;

                for _, v in u86.ActiveLimitedStyles do
                    if not table.find(u6.Player.LimitedStyles, v) then
                        v88 = true;
                        break;
                    end;
                end;

                Controller:Alert(LocalPlayer.PlayerGui.HUD.Buttons:FindFirstChild("Style"), v88);
            end;
        end);
    end);
    u86:Odds();
    u86:Styles();
    u86:RefreshUI();
    u86:Spin();
end;

function v3.KnitInit(u89) -- Line: 1232
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref), u6 (ref), Styles (copy), ReplicatedStorage (copy)
    LocalPlayer.CharacterAdded:Connect(function(p90) -- Line: 1233
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p90;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    LocalPlayer.Style:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1239
        -- upvalues: u89 (copy), u6 (ref), LocalPlayer (ref), Styles (ref)
        if u89.Borrowing then
            return;
        end;

        if not (table.find(u6.Player.LimitedStyles, LocalPlayer.Style.Value) or table.find(u6.Player.StyleSlots, LocalPlayer.Style.Value)) then
            local v91 = tick();

            repeat
                task.wait();
            until tick() - v91 > 2 or (table.find(u6.Player.LimitedStyles, LocalPlayer.Style.Value) or table.find(u6.Player.StyleSlots, LocalPlayer.Style.Value));

            if tick() - v91 > 2 then
                LocalPlayer:Kick(Styles.Styles[LocalPlayer.Style.Value].Rarity == "Dev" and "You\'re not supposed to see this." or "You don\'t have that style.");
            end;
        end;
    end);
    ReplicatedStorage.Remotes.Borrow.OnClientEvent:Connect(function(p92) -- Line: 1251
        -- upvalues: u89 (copy)
        if p92.Style then
            u89.Borrowing = true;
        end;
    end);
end;

return v3;