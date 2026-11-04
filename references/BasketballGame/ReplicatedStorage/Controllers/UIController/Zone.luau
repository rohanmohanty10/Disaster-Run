 
 

local AdService = game:GetService("AdService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local MarketplaceService = game:GetService("MarketplaceService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local GetHumDescription = require(ReplicatedStorage.Shared.Utility.GetHumDescription);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Zone = require(ReplicatedStorage.Effects.Base.Zone);
local u3 = Knit.CreateController({
    Name = "ZoneController"
});
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = Trove.new();
local u10 = "Normal";
local u11 = tick();
local u12 = nil;

function u3.RefreshUI(p13) -- Line: 44
    -- upvalues: LocalPlayer (copy), Zones (copy), u6 (ref), Essentials (copy), Rarities (copy)
    local BG = LocalPlayer.PlayerGui.Zone.BG;

    if BG.PlrZone:FindFirstChildWhichIsA("UIGradient") then
        BG.PlrZone:FindFirstChildWhichIsA("UIGradient"):Destroy();
    end;

    local Zone2 = LocalPlayer:WaitForChild("Zone");

    while Zone2.Value == "" do
        task.wait();
    end;

    local v14 = script.Gradients[Zones.Zones[Zone2.Value].Rarity];
    local math_max_ret = math.max(u6.Player.ZoneSpins, 0);
    local math_max_ret2 = math.max(u6.Player.ZoneLuckySpins, 0);
    BG.PlrZone.Text = string.upper(Zones.Zones[LocalPlayer.Zone.Value].UIName or Zones.Zones[LocalPlayer.Zone.Value].Name);
    BG.Desc.Text = Zones.Zones[LocalPlayer.Zone.Value].Desc;
    BG.Spin.Left.Text = `{math_max_ret} Spins`;
    BG.LuckySpin.Left.Text = `{math_max_ret2} Spins`;
    BG.CurrencyPitty.Pity.Text = `Pity: {u6.Player.ZoneSpinsDone}/50 Done`;
    BG.CurrencyPitty.LuckyPity.Text = `Lucky Pity: {u6.Player.LuckyZoneSpinsDone}/75 Done`;
    BG.CurrencyPitty.BG.Currency.Text = `${Essentials:formatNumberWithCommas(u6.Player.Money)}`;

    if u6.Player.AdRarityBoost > 0 then
        BG.AdRarityNote.Text = `Boosted Spins Remaining: {u6.Player.AdRarityBoost}`;
        BG.AdRarityNote.Visible = true;
        BG.WatchAd.Visible = false;
    else
        BG.AdRarityNote.Text = "Boost your regular spin luck by watching an ad!";
        BG.AdRarityNote.Visible = BG.WatchAd.Visible;
    end;

    if Rarities.TextColors[Zones.Zones[Zone2.Value].Rarity] then
        BG.PlrZone.TextColor3 = Rarities.TextColors[Zones.Zones[Zone2.Value].Rarity];
        BG.PlrZone.UIStroke.Color = Rarities.Colors[Zones.Zones[Zone2.Value].Rarity];
    elseif v14 then
        v14:Clone().Parent = BG.PlrZone;
        BG.PlrZone.TextColor3 = Color3.new(1, 1, 1);
        BG.PlrZone.UIStroke.Color = Color3.new(0, 0, 0);
    else
        BG.PlrZone.TextColor3 = Rarities.Colors[Zones.Zones[Zone2.Value].Rarity];
        BG.PlrZone.UIStroke.Color = Color3.new(0, 0, 0);
    end;

    if u6.Player.ZoneSpins <= 0 then
        BG.Spin.Left.Text = "$2000";
    end;

    for i = 1, 8 do
        local v15 = BG.Slots[`Slot{tostring(i)}`];
        local v16 = u6.Player.ZoneSlots[i];
        local v17;

        if v16 then
            v15.ZoneName.Text = string.upper(Zones.Zones[v16].UIName or Zones.Zones[v16].Name);
            v15.ImageColor3 = Rarities.Colors[Zones.Zones[v16].Rarity];
            v15.EquipTxt.Visible = true;

            if i == u6.Player.ZoneSlotEquipped and u6.Player.LimitedZoneEquipped == nil then
                v15.EquipTxt.Text = "EQUIPPED";
            else
                v15.EquipTxt.Text = "EQUIP";
            end;

            v15.Lock.Visible = true;
            v17 = i;
        elseif i <= u6.Player.MaxZoneSlots then
            v15.ZoneName.Text = "Empty";
            v15.ImageColor3 = Color3.fromRGB(150, 150, 150);
            v15.Lock.Visible = true;
            v17 = i;
        else
            v15.ZoneName.Text = "LOCKED";
            v15.ImageColor3 = Color3.fromRGB(49, 49, 49);
            v15.EquipTxt.Visible = false;
            v15.Lock.Visible = false;
            v17 = i;
        end;
    end;

    for _, child in BG.LimitedZones.Content:GetChildren() do
        if child:IsA("GuiButton") then
            child.EquipTxt.Text = u6.Player.LimitedZoneEquipped == child.Name and "EQUIPPED" or "EQUIP";
        end;
    end;
end;

function u3.Zones(u18) -- Line: 133
    -- upvalues: LocalPlayer (copy), u6 (ref), Effects (copy), u4 (ref), u7 (ref), Zone (copy), MarketplaceService (copy), Knit (copy), ReplicatedStorage (copy), u11 (ref), u3 (copy), Zones (copy), Rarities (copy), TweenService (copy)
    local BG = LocalPlayer.PlayerGui.Zone.BG;
    local u19 = tick();
    local u20 = {
        [2] = 3244604816,
        [3] = 3244604938,
        [4] = 3256886953,
        [5] = 3276711985,
        [6] = 3276712071,
        [7] = 3290503744,
        [8] = 3311664423
    };

    for _, child in BG.Slots:GetChildren() do
        if child:IsA("ImageButton") ~= false then
            local string_sub_ret = string.sub(child.Name, 5, 5);
            local u21 = tonumber(string_sub_ret);

            local function updateLock(p22: boolean) -- Line: 152
                -- upvalues: child (copy)
                if p22 then
                    child.Lock.Image = "rbxassetid://80913328536988";

                    return;
                end;

                child.Lock.Image = "rbxassetid://79577024969254";
            end;

            if u6.Player.LockedSlots.Zone[u21] then
                child.Lock.Image = "rbxassetid://80913328536988";
            else
                child.Lock.Image = "rbxassetid://79577024969254";
            end;

            child.MouseButton1Click:Connect(function() -- Line: 162
                -- upvalues: u21 (copy), u6 (ref), u19 (ref), u18 (copy), Effects (ref), u4 (ref), LocalPlayer (ref), u7 (ref), Zone (ref), MarketplaceService (ref), u20 (copy)
                if u21 > u6.Player.MaxZoneSlots + 1 then
                    return;
                end;

                if not u6.Player.ZoneSlots[u21] then
                    MarketplaceService:PromptProductPurchase(LocalPlayer, u20[u21]);

                    return;
                end;

                if u19 > tick() then
                    return;
                end;

                if u21 == u6.Player.ZoneSlotEquipped and u6.Player.LimitedZoneEquipped == nil then
                    return;
                end;

                if u18.Party.InQueue then
                    Effects:Popup("Cannot change slots whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

                    return;
                end;

                u19 = tick() + 0.4;
                u4.Slot:Fire(u21);
                LocalPlayer.Zone:GetPropertyChangedSignal("Value"):Once(function() -- Line: 181
                    -- upvalues: LocalPlayer (ref), u7 (ref), Zone (ref), u18 (ref), u6 (ref)
                    local Zone2 = LocalPlayer:FindFirstChild("Zone");

                    if Zone2 and u7 then
                        print(Zone2.Value);
                        Zone(u18, {
                            Activate = true,
                            FastClear = true,
                            Char = u7,
                            ZoneType = Zone2.Value,
                            Color = u6.Player.Customization.ZoneColor
                        });
                    end;

                    u18:RefreshUI();
                end);
            end);
            child.Lock.MouseButton1Click:Connect(function() -- Line: 196
                -- upvalues: u21 (copy), u6 (ref), u4 (ref), Effects (ref), child (copy)
                if u21 > u6.Player.MaxZoneSlots + 1 then
                    return;
                end;

                local v23 = not u6.Player.LockedSlots.Zone[u21];
                u4:SetLocked(u21, v23);
                Effects:Popup("Slot " .. (v23 and "locked" or "unlocked") .. "!");

                if v23 then
                    child.Lock.Image = "rbxassetid://80913328536988";

                    return;
                end;

                child.Lock.Image = "rbxassetid://79577024969254";
            end);

            if child:FindFirstChild("Gift") then
                child.Gift.MouseButton1Click:Connect(function() -- Line: 211
                    -- upvalues: Knit (ref), u20 (copy), u21 (copy)
                    Knit.GetController("GiftingController").PromptGiftPlayer(u20[u21]);
                end);
            end;
        end;
    end;

    BG.BuySpins.MouseButton1Click:Connect(function() -- Line: 219
        -- upvalues: Knit (ref)
        Knit.GetController("BuySpinsController").ShowGui(
            "BuyZoneSpins",
            { {
                    ProductId = 2835474063,
                    ImageId = "rbxassetid://71537410313776"
                }, {
                    ProductId = 2839604508,
                    ImageId = "rbxassetid://71537410313776"
                }, {
                    ProductId = 2839604808,
                    ImageId = "rbxassetid://71537410313776"
                } }
        );
    end);
    BG.Spins.MouseButton1Click:Connect(function() -- Line: 239
        -- upvalues: Knit (ref)
        Knit.GetController("BuySpinsController").ShowGui(
            "BuyLuckyZoneSpins",
            { {
                    ProductId = 2835474104,
                    CashPrice = 999,
                    ImageId = "rbxassetid://71537410313776",
                    IsRainbow = true
                }, {
                    ProductId = 2839604580,
                    CashPrice = 1899,
                    ImageId = "rbxassetid://71537410313776",
                    IsRainbow = true
                }, {
                    ProductId = 2839604883,
                    CashPrice = 2499,
                    ImageId = "rbxassetid://71537410313776",
                    IsRainbow = true
                } }
        );
    end);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 263
        -- upvalues: u11 (ref), LocalPlayer (ref), u3 (ref)
        if u11 > tick() then
            return;
        end;

        if not LocalPlayer.PlayerGui.Zone.Enabled then
            return;
        end;

        u3:RefreshUI();
    end);

    local function SetupLimitedZone(u24: string) -- Line: 270
        -- upvalues: Zones (ref), ReplicatedStorage (ref), Rarities (ref), BG (copy), u6 (ref), u18 (copy), Effects (ref), u4 (ref), LocalPlayer (ref), u7 (ref), Zone (ref)
        local v25 = Zones.Zones[u24];

        if v25 == nil then
            return warn((`AllZones.Zones["{u24}"] is nil`));
        end;

        local v26 = ReplicatedStorage.Assets.UI.LimitedStyle:Clone();
        v26.Name = u24;
        v26.StyleName.Text = v25.UIName or v25.Name;
        v26.ImageColor3 = Rarities.Colors[v25.Rarity];
        v26.Parent = BG.LimitedZones.Content;
        v26.MouseButton1Click:Connect(function() -- Line: 282
            -- upvalues: u6 (ref), u24 (copy), u18 (ref), Effects (ref), u4 (ref), LocalPlayer (ref), u7 (ref), Zone (ref)
            if u6.Player.LimitedZoneEquipped == u24 then
                return;
            end;

            if u18.Party.InQueue then
                Effects:Popup("Cannot change slots whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

                return;
            end;

            u4.Slot:Fire(u24);
            LocalPlayer.Zone:GetPropertyChangedSignal("Value"):Once(function() -- Line: 295
                -- upvalues: LocalPlayer (ref), u7 (ref), Zone (ref), u18 (ref), u6 (ref)
                local Zone2 = LocalPlayer:FindFirstChild("Zone");

                if Zone2 and u7 then
                    Zone(u18, {
                        Activate = true,
                        FastClear = true,
                        Char = u7,
                        ZoneType = Zone2.Value,
                        Color = u6.Player.Customization.ZoneColor
                    });
                end;

                u18:RefreshUI();
            end);
        end);
    end;

    for _, v in u6.Player.LimitedZones do
        task.spawn(SetupLimitedZone, v);
    end;

    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 310
        -- upvalues: u6 (ref), BG (copy), SetupLimitedZone (copy)
        for _, v in u6.Player.LimitedZones do
            if not BG.LimitedZones.Content:FindFirstChild(v) then
                task.spawn(SetupLimitedZone, v);
            end;
        end;
    end);
    BG.LimitedZonesButton.MouseButton1Click:Connect(function() -- Line: 320
        -- upvalues: BG (copy)
        BG.LimitedZones.Visible = not BG.LimitedZones.Visible;
    end);
    BG.LimitedZones.Close.MouseButton1Click:Connect(function() -- Line: 323
        -- upvalues: BG (copy)
        BG.LimitedZones.Visible = false;
    end);
    LocalPlayer.PlayerGui.Zone:GetPropertyChangedSignal("Enabled"):Once(function() -- Line: 327
        -- upvalues: LocalPlayer (ref), BG (copy), TweenService (ref)
        if not LocalPlayer:GetAttribute("HasMigratedLimitedZone") then
            return;
        end;

        LocalPlayer:SetAttribute("HasMigratedLimitedZone", nil);
        BG.LimitedZones.Visible = true;

        for _, child in BG.LimitedZones.Content:GetChildren() do
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
        BG.LimitedZonesButton.Visible = false;
    end;
end;

function u3.Spin(u27) -- Line: 360
    -- upvalues: LocalPlayer (copy), Zones (copy), Rarities (copy), u6 (ref), Effects (copy), u11 (ref), u9 (copy), MarketplaceService (copy), Knit (copy), u4 (ref), AdService (copy), u12 (ref), u8 (ref), Essentials (copy), GetUnixTime (copy), SfxManager (copy), u7 (ref), Zone (copy), TweenService (copy)
    local BG = LocalPlayer.PlayerGui.Zone.BG;
    local u28 = true;

    local function shouldConfirm() -- Line: 364
        -- upvalues: u28 (ref), Zones (ref), LocalPlayer (ref), Rarities (ref), BG (copy)
        if u28 then
            if Zones.Zones[LocalPlayer.Zone.Value].Rarity ~= "Mythic" and (Zones.Zones[LocalPlayer.Zone.Value].Rarity ~= "Legendary" and (table.find(Rarities.Limited, Zones.Zones[LocalPlayer.Zone.Value].Rarity) == nil and Zones.Zones[LocalPlayer.Zone.Value].Rarity ~= "Miracle")) then
                return false;
            end;

            BG.Confirm.Visible = true;

            return true;
        end;

        if Zones.Zones[LocalPlayer.Zone.Value].Rarity ~= "Mythic" and (table.find(Rarities.Limited, Zones.Zones[LocalPlayer.Zone.Value].Rarity) == nil and Zones.Zones[LocalPlayer.Zone.Value].Rarity ~= "Miracle") then
            return false;
        end;

        BG.Confirm.Visible = true;

        return true;
    end;

    BG.Spin.MouseButton1Click:Connect(function() -- Line: 382
        -- upvalues: LocalPlayer (ref), u6 (ref), Effects (ref), u27 (copy), u28 (ref), u11 (ref), u9 (ref), MarketplaceService (ref), Knit (ref), shouldConfirm (copy), u4 (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            return;
        end;

        if u6.Player.LockedSlots.Zone[u6.Player.ZoneSlotEquipped] then
            Effects:Popup("This slot is locked!", 1, Color3.new(1, 0.458824, 0.466667));

            return;
        end;

        if u27.Party.InQueue then
            Effects:Popup("Cannot spin whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

            return;
        end;

        u28 = true;

        if u11 > tick() then
            if u6.Player.CanSkipSpins or u27.Bursting then
                u9:Clean();

                return;
            end;

            if u6.Policy then
                return;
            end;

            MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1070782960);

            return;
        end;

        if u6.Player.LimitedZoneEquipped ~= nil then
            Effects:Popup("Cannot spin with a limited zone equipped!", 5, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u6.Player.ZoneSpins <= 0 and u6.Player.Money < 2000 then
            Knit.GetController("BuySpinsController").ShowGui(
                "BuyZoneSpins",
                { {
                        ProductId = 2835474063,
                        ImageId = "rbxassetid://71537410313776"
                    }, {
                        ProductId = 2839604508,
                        ImageId = "rbxassetid://71537410313776"
                    }, {
                        ProductId = 2839604808,
                        ImageId = "rbxassetid://71537410313776"
                    } }
            );

            return;
        end;

        if shouldConfirm() then
            return;
        end;

        u11 = tick() + 10;

        if u6.Player.ZoneSpins > 0 then
            local Player = u6.Player;
            Player.ZoneSpins = Player.ZoneSpins - 1;
        end;

        if u6.Player.AdRarityBoost == 0 then
            local Player = u6.Player;
            Player.ZoneSpinsDone = Player.ZoneSpinsDone + 1;
        else
            local Player = u6.Player;
            Player.AdRarityBoost = Player.AdRarityBoost - 1;
        end;

        u27:RefreshUI();
        u4.Spin:Fire();
    end);
    BG.LuckySpin.MouseButton1Click:Connect(function() -- Line: 460
        -- upvalues: LocalPlayer (ref), u6 (ref), Effects (ref), u27 (copy), u28 (ref), u11 (ref), u9 (ref), MarketplaceService (ref), Knit (ref), shouldConfirm (copy), u4 (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            return;
        end;

        if u6.Player.LockedSlots.Zone[u6.Player.ZoneSlotEquipped] then
            Effects:Popup("This slot is locked!", 1, Color3.new(1, 0.458824, 0.466667));

            return;
        end;

        if u27.Party.InQueue then
            Effects:Popup("Cannot spin whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u27.Bursting then
            Effects:Popup("Can\'t spin luckies whilst bursting!", 1, Color3.fromRGB(255, 0, 0));

            return;
        end;

        u28 = false;

        if u11 > tick() then
            if u6.Player.CanSkipSpins then
                u9:Clean();

                return;
            end;

            if u6.Policy then
                return;
            end;

            MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1070782960);

            return;
        end;

        if u6.Player.LimitedZoneEquipped ~= nil then
            Effects:Popup("Cannot spin with a limited zone equipped!", 5, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u6.Player.ZoneLuckySpins <= 0 then
            Knit.GetController("BuySpinsController").ShowGui(
                "BuyLuckyZoneSpins",
                { {
                        ProductId = 2835474104,
                        CashPrice = 999,
                        ImageId = "rbxassetid://71537410313776",
                        IsRainbow = true
                    }, {
                        ProductId = 2839604580,
                        CashPrice = 1899,
                        ImageId = "rbxassetid://71537410313776",
                        IsRainbow = true
                    }, {
                        ProductId = 2839604883,
                        CashPrice = 2499,
                        ImageId = "rbxassetid://71537410313776",
                        IsRainbow = true
                    } }
            );

            return;
        end;

        if shouldConfirm() then
            return;
        end;

        u11 = tick() + 10;
        local Player = u6.Player;
        Player.ZoneLuckySpins = Player.ZoneLuckySpins - 1;
        u27:RefreshUI();
        u4.Spin:Fire(true);
    end);
    BG.Confirm.Yes.MouseButton1Click:Connect(function() -- Line: 540
        -- upvalues: u6 (ref), Effects (ref), u27 (copy), u11 (ref), BG (copy), u28 (ref), u4 (ref)
        if u6.Player.LimitedZoneEquipped ~= nil then
            Effects:Popup("Cannot spin with a limited zone equipped!", 5, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u6.Player.LockedSlots.Zone[u6.Player.ZoneSlotEquipped] then
            Effects:Popup("This slot is locked!", 1, Color3.new(1, 0.458824, 0.466667));

            return;
        end;

        if u27.Party.InQueue then
            Effects:Popup("Cannot spin whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

            return;
        end;

        if u11 > tick() then
            return;
        end;

        u11 = tick() + 10;
        BG.Confirm.Visible = false;

        if u28 then
            local Player = u6.Player;
            Player.ZoneSpins = Player.ZoneSpins - 1;

            if u6.Player.AdRarityBoost == 0 then
                local Player2 = u6.Player;
                Player2.ZoneSpinsDone = Player2.ZoneSpinsDone + 1;
            else
                local Player2 = u6.Player;
                Player2.AdRarityBoost = Player2.AdRarityBoost - 1;
            end;
        else
            local Player = u6.Player;
            Player.ZoneLuckySpins = Player.ZoneLuckySpins - 1;
        end;

        u27:RefreshUI();

        if u28 then
            u4.Spin:Fire();

            return;
        end;

        u4.Spin:Fire(true);
    end);
    BG.Confirm.No.MouseButton1Click:Connect(function() -- Line: 583
        -- upvalues: BG (copy)
        BG.Confirm.Visible = false;
    end);
    (function() -- Line: 587, Name: setupAds
        -- upvalues: Knit (ref), BG (copy), u6 (ref), AdService (ref)
        local Controller = Knit.GetController("VideoAdController");

        local function showAd(p29) -- Line: 590
            -- upvalues: BG (ref), u6 (ref)
            BG.WatchAd.Visible = p29;
            BG.AdRarityNote.Visible = p29 or u6.Player.AdRarityBoost > 0;
        end;

        local u30 = false;
        BG.WatchAd.Activated:Connect(function() -- Line: 596
            -- upvalues: u30 (ref), BG (ref), u6 (ref), Controller (copy)
            if u30 then
                return;
            end;

            u30 = true;
            BG.WatchAd.Visible = false;
            BG.AdRarityNote.Visible = u6.Player.AdRarityBoost > 0;
            Controller:ShowAd();
            u30 = false;
        end);
        Controller.AdAvailabilityChanged:Connect(showAd);
        local AdAvailable = Controller.AdAvailable;
        BG.WatchAd.Visible = AdAvailable;
        BG.AdRarityNote.Visible = AdAvailable or u6.Player.AdRarityBoost > 0;
        task.spawn(function() -- Line: 610
            -- upvalues: AdService (ref), BG (ref)
            AdService:RegisterAdOpportunityAsync(BG.WatchAd, 193251517820518);
        end);
    end)();
    (function() -- Line: 617, Name: setupBursting
        -- upvalues: Knit (ref), u27 (copy), BG (copy), u12 (ref), u6 (ref), Effects (ref), MarketplaceService (ref), LocalPlayer (ref)
        local Service = Knit.GetService("SpinBurstService");
        Service.Bursting:Connect(function(p31) -- Line: 620
            -- upvalues: u27 (ref), BG (ref), u12 (ref)
            u27.Bursting = p31;
            BG.SpinBurst.Visible = not p31;
            BG.SpinBurst.FirstFree.Visible = false;

            if not p31 then
                u12(BG.Rarities.NormalRarities, true);
                u12(BG.Rarities.LuckyRarities, false);
                u12(BG.Rarities.BoostedRarities, false);
            end;
        end);
        local u32 = false;
        BG.SpinBurst.FirstFree.Visible = not u6.Player.FreeSpinBurstUsed;
        BG.SpinBurst.Activated:Connect(function() -- Line: 637
            -- upvalues: u27 (ref), Effects (ref), BG (ref), u12 (ref), u32 (ref), Service (copy), u6 (ref), MarketplaceService (ref), LocalPlayer (ref)
            if u27.Party.InQueue then
                Effects:Popup("Can\'t start bursting whilst in queue!", 1, Color3.fromRGB(255, 0, 0));

                return;
            end;

            BG.BurstCheckNotice.Visible = true;
            u12(BG.Rarities.NormalRarities, false);
            u12(BG.Rarities.LuckyRarities, false);
            u12(BG.Rarities.BoostedRarities, true);

            if u32 then
                u32 = false;
                BG.BurstCheckNotice.Visible = false;
                BG.SpinBurst.Visible = false;
                Service:ClaimFreeBurst();

                return;
            end;

            if u6.Player.FreeSpinBurstUsed then
                MarketplaceService:PromptProductPurchase(LocalPlayer, 3381177164);
                MarketplaceService.PromptProductPurchaseFinished:Once(function(p33, p34, p35) -- Line: 664
                    -- upvalues: u12 (ref), BG (ref)
                    if not p35 then
                        u12(BG.Rarities.NormalRarities, true);
                        u12(BG.Rarities.LuckyRarities, false);
                        u12(BG.Rarities.BoostedRarities, false);
                    end;

                    BG.BurstCheckNotice.Visible = false;
                    BG.SpinBurst.Visible = not p35;
                end);

                return;
            end;

            u32 = true;
            BG.SpinBurst.FirstFree.Text = "CLICK AGAIN!";
            task.delay(5, function() -- Line: 680
                -- upvalues: u32 (ref), BG (ref), u12 (ref)
                if not u32 then
                    return;
                end;

                BG.SpinBurst.FirstFree.Text = "FIRST ONE FREE!";
                u32 = false;
                BG.BurstCheckNotice.Visible = false;
                u12(BG.Rarities.NormalRarities, true);
                u12(BG.Rarities.LuckyRarities, false);
                u12(BG.Rarities.BoostedRarities, false);
            end);
        end);
    end)();
    u4.Spin:Connect(function(u36: boolean) -- Line: 702
        -- upvalues: u27 (copy), u8 (ref), BG (copy), u28 (ref), Knit (ref), Essentials (ref), Zones (ref), GetUnixTime (ref), Rarities (ref), SfxManager (ref), u9 (ref), LocalPlayer (ref), u7 (ref), Zone (ref), u6 (ref), u11 (ref), TweenService (ref)
        local math_random_ret = math.random(25, 35);
        u27:StopRig();
        u8.WaitSpin:Play();
        u8.WaitSpinStart:Play();
        local TextLabel = BG[u28 and "Spin" or "LuckySpin"].TextLabel;
        TextLabel.Text = "SKIP";
        u9:Add((task.spawn(function() -- Line: 712
            -- upvalues: Knit (ref), Essentials (ref), Zones (ref), GetUnixTime (ref), Rarities (ref), math_random_ret (copy), BG (ref), SfxManager (ref), u9 (ref)
            local Service = Knit.GetService("LimitedTimeRarityService");
            local v37 = Essentials:DeepCopy(Zones.Zones);

            for i, v in v37 do
                local v38 = Service.Package:Get().RarityTimes[v.Rarity];

                if v38 then
                    local v39 = v38 < GetUnixTime();

                    if table.find(Rarities.Limited, v.Rarity) ~= nil and v39 then
                        v37[i] = nil;
                    end;
                end;
            end;

            for i = 1, math_random_ret do
                local v40 = Essentials:TableLength(v37);
                local math_random_ret2 = math.random(1, v40);
                local v41 = 1;
                local v42 = "";

                for i2, _ in v37 do
                    if math_random_ret2 == v41 then
                        v42 = i2;
                        break;
                    end;

                    v41 = v41 + 1;
                end;

                if BG.PlrZone:FindFirstChildWhichIsA("UIGradient") then
                    BG.PlrZone:FindFirstChildWhichIsA("UIGradient"):Destroy();
                end;

                local v43 = script.Gradients[Zones.Zones[v42].Rarity];
                BG.PlrZone.Text = string.upper(Zones.Zones[v42].Name);
                BG.Desc.Text = Zones.Zones[v42].Desc;

                if Rarities.TextColors[Zones.Zones[v42].Rarity] then
                    BG.PlrZone.TextColor3 = Rarities.TextColors[Zones.Zones[v42].Rarity];
                    BG.PlrZone.UIStroke.Color = Rarities.Colors[Zones.Zones[v42].Rarity];
                else
                    v43:Clone().Parent = BG.PlrZone;
                    BG.PlrZone.TextColor3 = Color3.new(1, 1, 1);
                    BG.PlrZone.UIStroke.Color = Color3.new(0, 0, 0);
                end;

                SfxManager:playSound({
                    Sound = "Spin",
                    Parent = workspace
                });
                task.wait(i / math_random_ret / 4);
            end;

            u9:Clean();
        end)));
        u9:Add(function() -- Line: 768
            -- upvalues: SfxManager (ref), u27 (ref), LocalPlayer (ref), u7 (ref), Zone (ref), u6 (ref), u11 (ref), TextLabel (copy), u36 (copy), BG (ref), TweenService (ref)
            SfxManager:playSound({
                Sound = "UnlockStyle",
                Parent = workspace
            });
            u27:RefreshUI();
            u27:StopRig();
            local Zone2 = LocalPlayer:FindFirstChild("Zone");

            if Zone2 and u7 then
                Zone(u27, {
                    Activate = true,
                    FastClear = true,
                    Char = u7,
                    ZoneType = Zone2.Value,
                    Color = u6.Player.Customization.ZoneColor
                });
            end;

            u11 = tick();
            TextLabel.Text = "SPIN";

            if u36 then
                BG.LimitedZones.Visible = true;
                local Fade = BG.LimitedZones.Content:WaitForChild(LocalPlayer.Zone.Value).Fade;
                Fade.BackgroundTransparency = 1;
                TweenService:Create(Fade, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 5, true), {
                    BackgroundTransparency = 0.5
                }):Play();
            end;
        end);
    end);
end;

function u3.StopRig(p44) -- Line: 801
    -- upvalues: u8 (ref)
    for i, v in u8 do
        if i ~= "Idle" then
            v:Stop();
        end;
    end;
end;

function u3.UI(u45) -- Line: 808
    -- upvalues: LocalPlayer (copy), Knit (copy), RunService (copy), TweenService (copy), u6 (ref), u7 (ref), Zone (copy), ReplicatedStorage (copy), u5 (ref)
    local BG = LocalPlayer.PlayerGui.InGame.BG;
    local Controller = Knit.GetController("KeybindsController");
    local u46 = tick();
    RunService.Heartbeat:Connect(function(p47) -- Line: 814
        -- upvalues: u46 (ref), TweenService (ref), BG (copy), u6 (ref), LocalPlayer (ref), Controller (copy)
        if u46 + 0.35 <= tick() then
            u46 = tick();
            TweenService:Create(BG.Bars.ZoneBar.Bar.UIGradient, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Offset = Vector2.new(-0.7 + u6.CharValues.ZoneBar * 0.01, 0)
            }):Play();
        end;

        local Bar = BG.Bars.ZoneBar.Bar;
        Bar.ImageColor3 = Color3.fromHex(u6.Player.Customization.ZoneColor);

        if u6.CharValues.InZone then
            LocalPlayer.PlayerGui.Mobile.NoBall.Zone.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Ball.Zone.Visible = false;
            Bar.Key2.Visible = false;
            Bar.Input.Visible = false;
            local Key = Bar.Key;
            local math_round_ret = math.round(u6.CharValues.ZoneBar);
            Key.Text = `{tostring(math_round_ret)}%`;

            return;
        end;

        if u6.CharValues.ZoneBar < 30 then
            LocalPlayer.PlayerGui.Mobile.NoBall.Zone.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Ball.Zone.Visible = false;
            Bar.Key2.Visible = false;
            Bar.Input.Visible = false;
            local Key = Bar.Key;
            local math_round_ret = math.round(u6.CharValues.ZoneBar);
            Key.Text = `{tostring(math_round_ret)}%`;

            return;
        end;

        LocalPlayer.PlayerGui.Mobile.NoBall.Zone.Visible = true;
        LocalPlayer.PlayerGui.Mobile.Ball.Zone.Visible = true;

        if Controller.GetPlatform() == "Touchscreen" then
            Bar.Key2.Visible = false;
            Bar.Input.Visible = false;
            Bar.Key.Text = "ZONE IS READY";

            return;
        end;

        Bar.Key2.Visible = true;
        Bar.Input.Visible = true;
        Bar.Key.Text = "PRESS";
        Bar.Key2.Text = "TO ACTIVATE";
        Bar.Input.Image = Controller.GetKeybindIcon("Zone");
    end);
    local BG2 = LocalPlayer.PlayerGui.Zone.BG;
    local ZoneColor = u6.Player.Customization.ZoneColor;

    local function UpdatePreviews() -- Line: 867
        -- upvalues: u6 (ref), BG2 (copy), ZoneColor (ref), LocalPlayer (ref), u7 (ref), Zone (ref), u45 (copy)
        local ZoneColor2 = u6.Player.Customization.ZoneColor;
        local v48 = ZoneColor2 == "" and Color3.fromHSV(1, 0, 1) or Color3.fromHex(ZoneColor2);
        BG2.ZoneColor.Preview.BackgroundColor3 = v48;
        BG2.ZoneColor.Title.Text = `Zone Color ({u6.Player.ZoneColorSpins} Spins Left)`;

        if ZoneColor ~= ZoneColor2 then
            local Zone2 = LocalPlayer:FindFirstChild("Zone");

            if Zone2 and u7 then
                Zone(u45, {
                    Activate = true,
                    FastClear = true,
                    Char = u7,
                    ZoneType = Zone2.Value,
                    Color = u6.Player.Customization.ZoneColor
                });
            end;

            ZoneColor = ZoneColor2;
        end;
    end;

    ReplicatedStorage.Controllers.NewData.Changed:Connect(UpdatePreviews);
    task.spawn(UpdatePreviews);
    BG2.ZoneColor.Buttons.Reroll.MouseButton1Click:Connect(function() -- Line: 889
        -- upvalues: u5 (ref)
        u5:RandomizeZoneColor();
    end);
    BG2.ZoneColor.Buttons.Gift.MouseButton1Click:Connect(function() -- Line: 892
        -- upvalues: Knit (ref)
        Knit.GetController("GiftingController").PromptGiftPlayer(3403078506);
    end);
end;

function u3.Odds(u49) -- Line: 898
    -- upvalues: Knit (copy), LocalPlayer (copy), u10 (ref), u12 (ref), Trove (copy), Rarities (copy), Zones (copy), RunService (copy), Effects (copy), u4 (ref), u6 (ref), ReplicatedStorage (copy), GetUnixTime (copy)
    local Controller = Knit.GetController("UIController");
    local BG = LocalPlayer.PlayerGui.Zone.BG;
    local NormalRarities = BG.Rarities.NormalRarities;

    local function changeFolder(p50, p51) -- Line: 905
        -- upvalues: NormalRarities (ref), u10 (ref)
        if p51 then
            NormalRarities = p50;
        end;

        for _, child in p50:GetChildren() do
            if child:IsA("GuiObject") then
                child.Visible = p51;
            end;
        end;

        for _, child in p50:GetChildren() do
            if string.match(child.Name, "Zone") then
                child:Destroy();
            end;
        end;

        if p51 then
            u10 = string.match(p50.Name, "Normal") and "Normal" or "Lucky";
        end;
    end;

    u12 = changeFolder;
    BG.LuckyOdds.MouseButton1Click:Connect(function() -- Line: 925
        -- upvalues: changeFolder (copy), BG (copy)
        changeFolder(BG.Rarities.NormalRarities, false);
        changeFolder(BG.Rarities.LuckyRarities, true);
    end);
    BG.NormalOdds.MouseButton1Click:Connect(function() -- Line: 929
        -- upvalues: changeFolder (copy), BG (copy)
        changeFolder(BG.Rarities.NormalRarities, true);
        changeFolder(BG.Rarities.LuckyRarities, false);
    end);
    local Service = Knit.GetService("LimitedTimeRarityService");
    local u52 = Trove.new();
    local u53 = {};
    local u54 = Trove.new();
    local u55 = tick();

    local function CreateRarityTitle(p56, p57, p58) -- Line: 940
        -- upvalues: u52 (copy), Rarities (ref), u10 (ref), u54 (copy), Zones (ref), BG (copy), RunService (ref), u55 (ref), Effects (ref), u4 (ref), u6 (ref)
        local u59 = p57[2] >= 0.005 and math.round(p57[2] * 100) or math.round(p57[2] * 10000) / 100;
        local v60 = u52:Add(script.RarityTitle:Clone());
        v60.LayoutOrder = p56 * 100;
        v60.Name = p57[1];
        v60.Percentage.Text = `({u59}%)`;
        v60.TextLabel.Text = p57[1];
        v60.TimeLeft.Visible = table.find(Rarities.Limited, p57[1]);
        v60.Visible = string.match(p58.Name, u10) ~= nil;
        local v61 = script.Gradients:FindFirstChild(p57[1]):Clone();

        if not v61:GetAttribute("DontModify") then
            local v62 = {};
            local v63, v64, v65 = v61.Color.Keypoints[1].Value:ToHSV();
            v62[1] = v61.Color.Keypoints[1];
            v62[2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(v63, math.max(v64 - 0.6, 0), v65));
            v61.Color = ColorSequence.new(v62);
        end;

        v61.Parent = v60;

        if Rarities.TextColors[p57[1]] then
            v60.TextLabel.TextColor3 = Rarities.TextColors[p57[1]];
        else
            script.Gradients:FindFirstChild(p57[1]):Clone().Parent = v60.TextLabel;
            v60.TextLabel.TextColor3 = Color3.new(1, 1, 1);
        end;

        local u66 = p57[1];
        local LayoutOrder = v60.LayoutOrder;
        local u67 = "";

        local function ReloadRarity(p68) -- Line: 979
            -- upvalues: u54 (ref), Zones (ref), u66 (copy), BG (ref), u10 (ref), LayoutOrder (copy), RunService (ref), u67 (ref), u59 (copy), Rarities (ref), u55 (ref), Effects (ref), u4 (ref), ReloadRarity (copy)
            if p68 then
                u54:Clean();
            end;

            local v69 = {};

            for _, v in Zones.Zones do
                if v.Rarity == u66 then
                    table.insert(v69, v.Name);
                end;
            end;

            for _, v in Zones.Zones do
                if v.Rarity == u66 then
                    local u70 = p68 and u54:Add(script.RarityTemplate:Clone()) or BG.Rarities[`{u10}Rarities`]:FindFirstChild(v.Name);

                    if p68 then
                        u70.LayoutOrder = LayoutOrder + 1;
                        u70.Name = v.Name;
                        u70.Parent = BG.Rarities[`{u10}Rarities`];
                    end;

                    if v.New then
                        if p68 then
                            local u71 = nil;
                            u71 = RunService.PreRender:Connect(function(p72) -- Line: 1010
                                -- upvalues: u70 (copy), u71 (ref)
                                if u70.Parent == nil then
                                    u71:Disconnect();

                                    return;
                                end;

                                local v73 = tick() * 5;
                                local v74 = math.sin(v73) * 0.05;
                                u70.NewText.Size = UDim2.fromScale(v74 + 0.3, v74 + 0.5);
                            end);
                        end;
                    elseif u70:FindFirstChild("NewText") then
                        u70.NewText:Destroy();
                    end;

                    local v75 = v.Name == u67 and u59 * 2 or u59;
                    local v76 = table.find(v69, u67) and #v69 + 1 or #v69;
                    local v77 = math.round(v75 / v76 * (u59 > 0.1 and 100 or 10000)) / (u59 > 0.1 and 100 or 10000);

                    if u67 == v.Name then
                        u70.Text = `> {v.UIName or v.Name} - {v77}% <`;
                    else
                        u70.Text = `{v.UIName or v.Name} - {v77}%`;
                    end;

                    if Rarities.TextColors[v.Rarity] then
                        u70.TextColor3 = Rarities.TextColors[v.Rarity];
                        u70.UIStroke.Color = Rarities.Colors[v.Rarity];
                    else
                        if p68 then
                            script.Gradients:FindFirstChild(v.Rarity):Clone().Parent = u70;
                        end;

                        u70.TextColor3 = Color3.new(1, 1, 1);
                        u70.UIStroke.Color = Color3.new(0, 0, 0);
                    end;

                    if p68 then
                        u54:Connect(u70.MouseButton1Click, function() -- Line: 1043
                            -- upvalues: u55 (ref), u67 (ref), v (copy), Effects (ref), u4 (ref), ReloadRarity (ref)
                            if u55 > tick() then
                                return;
                            end;

                            u55 = tick() + 0.25;
                            u67 = v.Name;
                            Effects:Popup((`Higher chance to get {v.UIName or v.Name}`));
                            u4.BoostedZone:Fire(v.Name);
                            ReloadRarity();
                        end);
                    end;
                end;
            end;
        end;

        v60.MouseButton1Click:Connect(function() -- Line: 1058
            -- upvalues: u67 (ref), u6 (ref), ReloadRarity (copy)
            u67 = u6.Player.BoostedZone;
            ReloadRarity(true);
        end);
        v60.Parent = p58;
    end;

    local function ReloadRarities() -- Line: 1067
        -- upvalues: u52 (copy), Rarities (ref), Service (copy), CreateRarityTitle (copy), BG (copy), u53 (copy)
        u52:Clean();
        local ExpiredRarities = Rarities.GetExpiredRarities(Service.Package:Get());

        for i, v in Rarities.ComputePercentages(Rarities.Odds, ExpiredRarities) do
            CreateRarityTitle(i, v, BG.Rarities.NormalRarities);
        end;

        for i, v in Rarities.ComputePercentages(Rarities.LuckyOdds, ExpiredRarities) do
            CreateRarityTitle(i, v, BG.Rarities.LuckyRarities);
        end;

        for i, v in Rarities.ComputePercentages(Rarities.SlightyLuckyOdds, ExpiredRarities) do
            CreateRarityTitle(i, v, BG.Rarities.BoostedRarities);
        end;

        table.clear(u53);

        for _, v in Rarities.Limited do
            table.insert(u53, BG.Rarities.LuckyRarities:FindFirstChild(v));
            table.insert(u53, BG.Rarities.NormalRarities:FindFirstChild(v));
            table.insert(u53, BG.Rarities.BoostedRarities:FindFirstChild(v));
        end;
    end;

    ReloadRarities();
    changeFolder(BG.Rarities.NormalRarities, true);
    changeFolder(BG.Rarities.LuckyRarities, false);
    local u78 = Trove.new();
    local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
    Service.Package:Observe(function(u79) -- Line: 1099
        -- upvalues: ReloadRarities (copy), u78 (copy), u49 (copy), u53 (copy), GetUnixTime (ref), NormalRarities (ref), Zones (ref), u6 (ref), RunService (ref), NumberUtil (copy), u54 (copy), Controller (copy), LocalPlayer (ref)
        if not u79.RarityTimes then
            return;
        end;

        ReloadRarities();
        u78:Clean();
        u49.ActiveLimitedZones = {};
        local v80 = false;

        for _, v in u53 do
            if u79.RarityTimes[v.Name] == nil then
                v.Visible = false;
                warn((`Package.RarityTimes[{v.Name}] is nil!`));
            else
                local v81 = GetUnixTime() > u79.RarityTimes[v.Name];
                v:SetAttribute("NotVisible", v81 or nil);
                local v82 = not v81 and v:IsDescendantOf(NormalRarities);
                v.Visible = v82;

                if not v81 then
                    local u83 = v;

                    for _, v2 in Zones.Zones do
                        if v2.Rarity == u83.Name and not table.find(u6.Player.LimitedZones, v2.Name) then
                            table.insert(u49.ActiveLimitedZones, v2.Name);
                            v80 = true;
                        end;
                    end;

                    local u84 = nil;
                    local u85 = nil;
                    u85 = u78:Add(RunService.Heartbeat:Connect(function() -- Line: 1139
                        -- upvalues: u79 (copy), u83 (copy), GetUnixTime (ref), u84 (ref), NumberUtil (ref), u85 (ref), u54 (ref)
                        local v86 = u79.RarityTimes[u83.Name] - GetUnixTime();
                        local math_max_ret = math.max(v86, 0);

                        if math_max_ret == u84 then
                            return;
                        end;

                        u84 = math_max_ret;
                        local v87 = "LIMITED TIME: " .. NumberUtil.AdaptiveClockString(math_max_ret);
                        u83.TimeLeft.Text = v87;

                        if math_max_ret == 0 then
                            u83:SetAttribute("NotVisible", true);
                            u83.Visible = false;
                            u85:Disconnect();
                            u54:Clean();
                        end;
                    end));
                end;
            end;
        end;

        Controller:Alert(LocalPlayer.PlayerGui.HUD.Buttons:FindFirstChild("Zone"), v80);
    end);
end;

function u3.Input(p88) -- Line: 1172
    -- upvalues: u6 (ref), LocalPlayer (copy), u4 (ref), Knit (copy), UserInputService (copy)
    if u6.ServerType == "Tutorial" then
        LocalPlayer.PlayerGui.InGame.BG.Bars.Visible = false;

        return;
    end;

    local u89 = tick();

    local function Activate() -- Line: 1179
        -- upvalues: u6 (ref), u89 (ref), u4 (ref)
        if u6.CharValues.InZone then
            return;
        end;

        if u6.CharValues.ZoneBar < 30 then
            return;
        end;

        if u89 > tick() then
            return;
        end;

        u89 = tick() + 0.5;
        u4.Activate:Fire();
    end;

    LocalPlayer.PlayerGui.Mobile.NoBall.Zone.MouseButton1Click:Connect(function() -- Line: 1188
        -- upvalues: u6 (ref), u89 (ref), u4 (ref)
        if u6.CharValues.InZone then
            return;
        end;

        if u6.CharValues.ZoneBar < 30 then
            return;
        end;

        if u89 > tick() then
            return;
        end;

        u89 = tick() + 0.5;
        u4.Activate:Fire();
    end);
    LocalPlayer.PlayerGui.Mobile.Ball.Zone.MouseButton1Click:Connect(function() -- Line: 1191
        -- upvalues: u6 (ref), u89 (ref), u4 (ref)
        if u6.CharValues.InZone then
            return;
        end;

        if u6.CharValues.ZoneBar < 30 then
            return;
        end;

        if u89 > tick() then
            return;
        end;

        u89 = tick() + 0.5;
        u4.Activate:Fire();
    end);
    local Controller = Knit.GetController("KeybindsController");
    UserInputService.InputBegan:Connect(function(p90, p91) -- Line: 1197
        -- upvalues: Controller (copy), u6 (ref), u89 (ref), u4 (ref)
        if p91 then
            return;
        end;

        if Controller.IsInputValid(p90, "Zone") then
            if u6.CharValues.InZone then
                return;
            end;

            if u6.CharValues.ZoneBar < 30 then
                return;
            end;

            if u89 > tick() then
                return;
            end;

            u89 = tick() + 0.5;
            u4.Activate:Fire();
        end;
    end);
end;

function u3.KnitStart(u92) -- Line: 1205
    -- upvalues: Knit (copy), u4 (ref), u5 (ref), u6 (ref), u7 (ref), ReplicatedStorage (copy), u8 (ref), GetHumDescription (copy), LocalPlayer (copy), Zone (copy)
    u92.Party = Knit.GetController("PartyController");
    local Controller = Knit.GetController("UIController");
    u4 = Knit.GetService("ZoneService");
    u5 = Knit.GetService("CustomizationService");
    u6 = Knit.GetController("Network");
    local script_SpinFolder = script.SpinFolder;
    u7 = ReplicatedStorage.Assets.Misc.TemplateRig:Clone();
    u7.Parent = workspace;
    u8 = {
        Idle = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Movement.Idle),
        WaitSpin = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Stuns.WaitSpin),
        WaitSpinStart = u7.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Stuns.WaitSpinStart)
    };
    u7.Parent = script;
    task.spawn(function() -- Line: 1226
        -- upvalues: GetHumDescription (ref), LocalPlayer (ref), u7 (ref), u8 (ref), script_SpinFolder (copy), u92 (copy), Zone (ref), u6 (ref), Controller (copy)
        local v93 = GetHumDescription.FromUserId(LocalPlayer.UserId);
        u7.Parent = workspace;
        u7.Humanoid:ApplyDescription(v93);
        u7.Parent = script;

        for _, v in u8 do
            v.Priority = Enum.AnimationPriority.Action3;
        end;

        u8.WaitSpin.Priority = Enum.AnimationPriority.Action;
        u8.Idle.Priority = Enum.AnimationPriority.Idle;
        u8.Idle:Play();
        u7.Name = "ZoneRig";
        u7.HumanoidRootPart.Anchored = true;
        u7.HumanoidRootPart.CFrame = script_SpinFolder.Part.CFrame * CFrame.new(0, 0, 15) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        LocalPlayer.PlayerGui.Zone:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1244
            -- upvalues: LocalPlayer (ref), u92 (ref), u7 (ref), script_SpinFolder (ref), Zone (ref), u6 (ref), Controller (ref)
            if LocalPlayer.PlayerGui.Zone.Enabled then
                u92:RefreshUI();
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                workspace.CurrentCamera.CFrame = u7.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                script_SpinFolder.Parent = workspace;
                u7.Parent = workspace;
                local Zone2 = LocalPlayer:FindFirstChild("Zone");

                if Zone2 and u7 then
                    Zone(u92, {
                        Activate = true,
                        FastClear = true,
                        Char = u7,
                        ZoneType = Zone2.Value,
                        Color = u6.Player.Customization.ZoneColor
                    });
                end;
            else
                script_SpinFolder.Parent = script;
                u7.Parent = script;

                if u92.ActiveLimitedZones then
                    local v94 = false;

                    for _, v in u92.ActiveLimitedZones do
                        if not table.find(u6.Player.LimitedZones, v) then
                            v94 = true;
                            break;
                        end;
                    end;

                    Controller:Alert(LocalPlayer.PlayerGui.HUD.Buttons:FindFirstChild("Zone"), v94);
                end;
            end;
        end);
    end);
    u92:Odds();
    u92:Zones();
    u92:Input();
    u92:RefreshUI();
    u92:UI();
    u92:Spin();
end;

function u3.KnitInit(u95) -- Line: 1286
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref), u6 (ref), Zones (copy), ReplicatedStorage (copy)
    LocalPlayer.CharacterAdded:Connect(function(p96) -- Line: 1287
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p96;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    LocalPlayer.Zone:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1293
        -- upvalues: u95 (copy), u6 (ref), LocalPlayer (ref), Zones (ref)
        if u95.Borrowing then
            return;
        end;

        if not (table.find(u6.Player.LimitedZones, LocalPlayer.Zone.Value) or table.find(u6.Player.ZoneSlots, LocalPlayer.Zone.Value)) then
            local v97 = tick();

            repeat
                task.wait();
            until tick() - v97 > 2 or (table.find(u6.Player.LimitedZones, LocalPlayer.Zone.Value) or table.find(u6.Player.ZoneSlots, LocalPlayer.Zone.Value));

            if tick() - v97 > 2 then
                LocalPlayer:Kick(Zones.Zones[LocalPlayer.Zone.Value].Rarity == "Dev" and "You\'re not supposed to see this." or "You don\'t have that zone.");
            end;
        end;
    end);
    ReplicatedStorage.Remotes.Borrow.OnClientEvent:Connect(function(p98) -- Line: 1305
        -- upvalues: u95 (copy)
        if p98.Zone then
            u95.Borrowing = true;
        end;
    end);
end;

return u3;