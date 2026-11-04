  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService");
local CollectionService = game:GetService("CollectionService");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local Popup = require(ReplicatedStorage.Shared.Popup);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local Gift = require(ReplicatedStorage.Controllers.UIController.Gift);
local playerOwnsItem = require(ReplicatedStorage.Shared.utils.playerOwnsItem);
local BundlesData = require(ReplicatedStorage.Shared.Configs.BundlesData);
local Client = require(ReplicatedStorage.Packages.Replion.Client);
local LimitedStockItems = require(ReplicatedStorage.Modules.LimitedStockItems);
local LocalPlayer = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local Bundles = LocalPlayer.PlayerGui:WaitForChild("Bundles");
local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
local PickTeam = LocalPlayer.PlayerGui:WaitForChild("PickTeam");
local WorldTournamentBundles = LocalPlayer.PlayerGui:WaitForChild("WorldTournamentBundles");

local function findAncestorWithTag(p1, p2) -- Line: 27
    -- upvalues: CollectionService (copy)
    local Parent = p1.Parent;

    while Parent do
        if CollectionService:HasTag(Parent, p2) then
            return Parent;
        end;

        Parent = Parent.Parent;
    end;

    return nil;
end;

local v3 = KnitClient.CreateController({
    Name = "Bundles"
});

local function setupStockLabel(u4) -- Line: 43
    -- upvalues: LimitedStockItems (copy), Client (copy), FormatNumber (copy)
    local Attribute = u4:GetAttribute("StockKey");

    if not Attribute then
        return;
    end;

    if not LimitedStockItems[Attribute] then
        u4.Text = "?";

        return;
    end;

    local v5 = Client:WaitReplion("LimitedStockItems");

    if not v5 then
        u4.Text = "?";

        return;
    end;

    local function applyStock(p6: number?) -- Line: 59
        -- upvalues: u4 (copy), FormatNumber (ref)
        u4.Text = `{FormatNumber.Commas(p6 or 0)} Left`;
    end;

    local v7 = v5:Get({ "Stocks", Attribute }) or 0 or 0;
    u4.Text = `{FormatNumber.Commas(v7)} Left`;
    v5:OnChange({ "Stocks", Attribute }, function(p8: number, p9: number?) -- Line: 67
        -- upvalues: u4 (copy), FormatNumber (ref)
        u4.Text = `{FormatNumber.Commas(p8 or 0)} Left`;
    end);
end;

local function setupBuyButton(p10) -- Line: 72
    -- upvalues: BundlesData (copy), PlayerData (copy), CollectionService (copy), MarketplaceService (copy), Popup (copy), playerOwnsItem (copy), LocalPlayer (copy)
    local Attribute = p10:GetAttribute("BundleType");

    if not Attribute then
        return;
    end;

    local Price = p10:FindFirstChild("Price", true);

    if not Price then
        return;
    end;

    local u11 = "[???]";
    local v12 = BundlesData[Attribute];

    if not v12 then
        warn((`invalid bundle {Attribute}`));

        return;
    end;

    if not v12.PurchaseId then
        Price.Text = "TBD";
        p10.Active = false;
        p10.Interactable = false;
        p10.AutoButtonColor = false;

        return;
    end;

    local u13 = v12.BuyLimit or 1;

    local function update() -- Line: 100
        -- upvalues: PlayerData (ref), Attribute (copy), Price (copy), u13 (copy), u11 (ref), CollectionService (ref)
        local v14 = PlayerData:TryIndex({ "BundlePurchases", Attribute }) or 0;

        if Price then
            if u13 == 1 then
                if u13 - v14 > 0 then
                    Price.Text = `{u11}`;
                else
                    Price.Text = "BOUGHT";
                end;
            else
                Price.Text = `{u11} [{u13 - v14} Left]`;
            end;
        end;

        for _, v in CollectionService:GetTagged("BundlePackage") do
            if v:GetAttribute("Type") == Attribute then
                if v14 == 0 then
                    v.Bought.Visible = false;
                else
                    v.Bought.Visible = true;
                end;
            end;
        end;

        local function checkPurchased(p15, p16) -- Line: 124
            -- upvalues: PlayerData (ref)
            local Attribute2 = p15:GetAttribute(p16);

            if Attribute2 then
                return (PlayerData:TryIndex({ "BundlePurchases", Attribute2 }) or 0) > 0;
            end;
        end;

        for _, v in CollectionService:GetTagged("BundleItem") do
            local Attribute2 = v:GetAttribute("Type1");
            local v17;

            if Attribute2 then
                v17 = (PlayerData:TryIndex({ "BundlePurchases", Attribute2 }) or 0) > 0;
            else
                v17 = nil;
            end;

            if v17 then
                local Attribute3 = v:GetAttribute("Type2");
                local v18;

                if Attribute3 then
                    v18 = (PlayerData:TryIndex({ "BundlePurchases", Attribute3 }) or 0) > 0;
                else
                    v18 = nil;
                end;

                if v18 then
                    v.Visible = true;
                else
                    v.Visible = false;
                end;
            else
                v.Visible = false;
            end;
        end;
    end;

    task.spawn(function() -- Line: 146
        -- upvalues: MarketplaceService (ref), BundlesData (ref), Attribute (copy), u11 (ref), update (copy)
        local success, result = pcall(function() -- Line: 147
            -- upvalues: MarketplaceService (ref), BundlesData (ref), Attribute (ref)
            return MarketplaceService:GetProductInfo(BundlesData[Attribute].PurchaseId, Enum.InfoType.Product);
        end);

        if success and result then
            u11 = `{result.PriceInRobux}` or "[???]";
            update();
        end;
    end);
    PlayerData:Observe({ "BundlePurchases", Attribute }, update);
    p10.Activated:Connect(function() -- Line: 158
        -- upvalues: PlayerData (ref), Attribute (copy), u13 (copy), Popup (ref), BundlesData (ref), playerOwnsItem (ref), MarketplaceService (ref), LocalPlayer (ref)
        if u13 <= (PlayerData:TryIndex({ "BundlePurchases", Attribute }) or 0) then
            Popup.Popup(nil, "You have reached the purchase limit for this bundle.");

            return;
        end;

        local v19 = BundlesData[Attribute].Items[1];

        if playerOwnsItem(PlayerData.Data, v19.Type, v19.Name) then
            Popup.Popup(nil, "Buying this again will only give you lucky spins!");
        end;

        MarketplaceService:PromptProductPurchase(LocalPlayer, BundlesData[Attribute].PurchaseId);
    end);
end;

local function setupGiftButton(p20) -- Line: 175
    -- upvalues: BundlesData (copy), Gift (copy), LocalPlayer (copy)
    local Attribute = p20:GetAttribute("BundleType");

    if not Attribute then
        return;
    end;

    local v21 = BundlesData[Attribute];

    if not (v21 and v21.GiftId) then
        p20.Visible = false;
        p20.Active = false;
        p20.Interactable = false;

        return;
    end;

    p20.Visible = true;
    p20.Active = true;
    p20.Interactable = true;
    p20:SetAttribute("ID", v21.GiftId);
    p20.Activated:Connect(function() -- Line: 193
        -- upvalues: Gift (ref), LocalPlayer (ref), BundlesData (ref), Attribute (copy)
        if Gift.ButtonDb > tick() then
            return;
        end;

        LocalPlayer.PlayerGui.Gift.Enabled = true;
        Gift.LastID = BundlesData[Attribute].GiftId;
        Gift.LastReceiptID = nil;
    end);
end;

local function bundleItemText(p22) -- Line: 204
    if p22.Type == "LuckyStyleSpins" then
        return `{p22.Amount or 0} Lucky Spins`;
    end;

    return p22.Name;
end;

local u23 = {
    Brazil = {
        rotation = 90,
        colors = { Color3.fromRGB(0, 155, 58), Color3.fromRGB(254, 221, 0) }
    },
    Spain = {
        rotation = 90,
        colors = { Color3.fromRGB(198, 11, 30), Color3.fromRGB(255, 196, 0), Color3.fromRGB(198, 11, 30) }
    },
    Germany = {
        rotation = 90,
        colors = { Color3.fromRGB(40, 40, 40), Color3.fromRGB(221, 0, 0), Color3.fromRGB(255, 206, 0) }
    },
    France = {
        rotation = 0,
        colors = { Color3.fromRGB(0, 85, 164), Color3.fromRGB(240, 240, 240), Color3.fromRGB(239, 65, 53) }
    },
    Argentina = {
        rotation = 90,
        colors = { Color3.fromRGB(108, 171, 221), Color3.fromRGB(245, 245, 245), Color3.fromRGB(108, 171, 221) }
    },
    Portugul = {
        rotation = 0,
        colors = { Color3.fromRGB(0, 102, 0), Color3.fromRGB(218, 41, 28) }
    },
    Norway = {
        rotation = 90,
        colors = { Color3.fromRGB(186, 12, 47), Color3.fromRGB(240, 240, 240), Color3.fromRGB(0, 32, 91) }
    },
    Capeverde = {
        rotation = 90,
        colors = { Color3.fromRGB(0, 64, 140), Color3.fromRGB(240, 240, 240), Color3.fromRGB(207, 32, 47) }
    }
};

local function applyFlagGradient(p24, p25) -- Line: 222
    -- upvalues: u23 (copy)
    local v26 = u23[p25];
    local Sizer = p24:FindFirstChild("Sizer");

    if Sizer then
        Sizer = Sizer:FindFirstChild("bg");
    end;

    if not (v26 and Sizer) then
        return;
    end;

    Sizer.ImageColor3 = Color3.fromRGB(255, 255, 255);
    local FlagGradient = Sizer:FindFirstChild("FlagGradient");

    if not FlagGradient then
        FlagGradient = Instance.new("UIGradient");
        FlagGradient.Name = "FlagGradient";
        FlagGradient.Parent = Sizer;
    end;

    FlagGradient.Rotation = v26.rotation;
    local v27 = #v26.colors;
    local v28 = {};

    for i, v in v26.colors do
        table.insert(v28, ColorSequenceKeypoint.new((i - 1) / (v27 - 1), v));
    end;

    FlagGradient.Color = ColorSequence.new(v28);
end;

local function setupWorldTournamentBundles() -- Line: 243
    -- upvalues: WorldTournamentBundles (copy), BundlesData (copy), applyFlagGradient (copy)
    WorldTournamentBundles.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    local Frame = WorldTournamentBundles.Frame;
    local ScrollingFrame = Frame.BG.ScrollingFrame;
    local Bundles2 = WorldTournamentBundles.Bundles;
    local Darkness = Bundles2.Darkness;
    local u29 = {};

    local function showList() -- Line: 251
        -- upvalues: u29 (copy), Darkness (copy), Frame (copy)
        for _, v in u29 do
            v.Visible = false;
        end;

        Darkness.Visible = false;
        Frame.Visible = true;
    end;

    for i, v in BundlesData do
        local WorldTournamentUI = v.WorldTournamentUI;

        if type(WorldTournamentUI) == "string" then
            local v30 = ScrollingFrame:FindFirstChild(WorldTournamentUI);
            local v31 = `Missing World Tournament list button {WorldTournamentUI}`;
            local v32 = assert(v30, v31);
            applyFlagGradient(v32, WorldTournamentUI);
            local v33 = Bundles2:FindFirstChild(WorldTournamentUI);
            local v34 = `Missing World Tournament detail frame {WorldTournamentUI}`;
            local u35 = assert(v33, v34);
            table.insert(u29, u35);
            u35.Main.Header.Text = string.upper(v.Display);
            local v36 = i;

            for i2, v2 in v.Items do
                local TextLabel = u35.Main.Slots[tostring(i2)].TextLabel;
                local v37;

                if v2.Type == "LuckyStyleSpins" then
                    v37 = `{v2.Amount or 0} Lucky Spins`;
                else
                    v37 = v2.Name;
                end;

                TextLabel.Text = v37;
            end;

            u35.Main.BottomButtons.Robux:SetAttribute("BundleType", v36);
            u35.Main.BottomButtons.Gift:SetAttribute("BundleType", v36);

            local function showDetail() -- Line: 276
                -- upvalues: u29 (copy), Frame (copy), Darkness (copy), u35 (copy)
                for _, v2 in u29 do
                    v2.Visible = false;
                end;

                Frame.Visible = false;
                Darkness.Visible = true;
                u35.Visible = true;
            end;

            v32.Activated:Connect(showDetail);
            v32.Sizer.bg.Activated:Connect(showDetail);
            u35.CloseButton.Activated:Connect(showList);
        end;
    end;

    for _, v in u29 do
        v.Visible = false;
    end;

    Darkness.Visible = false;
    Frame.Visible = true;
    WorldTournamentBundles:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 291
        -- upvalues: WorldTournamentBundles (ref), u29 (copy), Darkness (copy), Frame (copy)
        if WorldTournamentBundles.Enabled then
            for _, v in u29 do
                v.Visible = false;
            end;

            Darkness.Visible = false;
            Frame.Visible = true;
        end;
    end);
end;

function v3.KnitStart(p38) -- Line: 298
    -- upvalues: LocalPlayer (copy), KnitClient (copy), WorldTournamentBundles (copy), setupWorldTournamentBundles (copy), CollectionService (copy), HUD (copy), setupBuyButton (copy), setupGiftButton (copy), setupStockLabel (copy), FormatNumber (copy), PickTeam (copy), Bundles (copy)
    task.spawn(function() -- Line: 299
        -- upvalues: LocalPlayer (ref), KnitClient (ref), WorldTournamentBundles (ref)
        local HUD2 = LocalPlayer.PlayerGui:WaitForChild("HUD", 10);

        if HUD2 then
            HUD2 = HUD2:WaitForChild("BundleButtons", 5);
        end;

        if HUD2 then
            HUD2 = HUD2:FindFirstChild("EgosShop");
        end;

        if not HUD2 then
            return;
        end;

        HUD2.Activated:Connect(function() -- Line: 304
            -- upvalues: KnitClient (ref), WorldTournamentBundles (ref)
            local success, result = pcall(KnitClient.GetController, "BlueLockCupController");

            if success and (result and result.OpenBundles) then
                result:OpenBundles();

                return;
            end;

            WorldTournamentBundles.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            WorldTournamentBundles.Enabled = true;
        end);
    end);
    setupWorldTournamentBundles();
    local u39 = {};

    for _, v in CollectionService:GetTagged("BundleContainer") do
        local Attribute = v:GetAttribute("BundleId");

        if Attribute and v:IsDescendantOf(LocalPlayer.PlayerGui) then
            u39[Attribute] = v;
        end;
    end;

    for _, child in HUD.BundleButtons:GetChildren() do
        if child:IsA("GuiButton") then
            local Attribute = child:GetAttribute("BundleId");

            if Attribute then
                Attribute = u39[Attribute];
            end;

            if Attribute then
                local function toggleBundle() -- Line: 332
                    -- upvalues: u39 (copy), Attribute (copy)
                    for _, v in pairs(u39) do
                        if v ~= Attribute then
                            v.Enabled = false;
                        end;
                    end;

                    Attribute.Enabled = not Attribute.Enabled;
                end;

                child.Activated:Connect(toggleBundle);
                local bg = child:FindFirstChild("bg");

                if bg and bg:IsA("GuiButton") then
                    bg.Activated:Connect(toggleBundle);
                end;
            end;
        end;
    end;

    for _, v in CollectionService:GetTagged("BundleCloseButton") do
        local Parent = v.Parent;
        local v40 = v;

        while true do
            if not Parent then
                Parent = nil;
                break;
            end;

            if CollectionService:HasTag(Parent, "BundleContainer") then
                break;
            end;

            Parent = Parent.Parent;
        end;

        if Parent then
            v40.Activated:Connect(function() -- Line: 351
                -- upvalues: Parent (copy)
                Parent.Enabled = false;
            end);
        end;
    end;

    for _, v in ipairs(CollectionService:GetTagged("BundleBuyButton")) do
        setupBuyButton(v);
    end;

    for _, v in ipairs(CollectionService:GetTagged("BundleGiftButton")) do
        setupGiftButton(v);
    end;

    CollectionService:GetInstanceAddedSignal("BundleBuyButton"):Connect(setupBuyButton);
    CollectionService:GetInstanceAddedSignal("BundleGiftButton"):Connect(setupGiftButton);

    for _, v in CollectionService:GetTagged("BundleStock") do
        task.spawn(setupStockLabel, v);
    end;

    CollectionService:GetInstanceAddedSignal("BundleStock"):Connect(function(p41) -- Line: 369
        -- upvalues: setupStockLabel (ref)
        task.spawn(setupStockLabel, p41);
    end);
    task.spawn(function() -- Line: 373
        -- upvalues: FormatNumber (ref), CollectionService (ref)
        while true do
            local v42 = (workspace:GetAttribute("bundleTimer") or (workspace:GetAttribute("updateTimer") or workspace:GetServerTimeNow() + 60)) - workspace:GetServerTimeNow();
            local math_max_ret = math.max(0, v42);
            local v43 = math_max_ret > 0 and FormatNumber.AdaptiveClockString(math_max_ret) or "ENDING SOON";

            for _, v in CollectionService:GetTagged("BundleTimerLabel") do
                if v:IsA("TextLabel") then
                    v.Text = v43;
                end;
            end;

            task.wait(1);
        end;
    end);
    PickTeam:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 388
        -- upvalues: PickTeam (ref), Bundles (ref)
        if PickTeam.Enabled then
            for _, child in Bundles:GetChildren() do
                child.Enabled = false;
            end;
        end;
    end);
end;

return v3;