  

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local Signal = require(ReplicatedStorage.Packages.Signal);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local ProductIds = require(ReplicatedStorage.Shared.Configs.ProductIds);
local getProductInfo = require(ReplicatedStorage.Shared.utils.getProductInfo);
local Flows = require(ReplicatedStorage.Shared.Flows);
local Gift = require(ReplicatedStorage.Controllers.UIController.Gift);
local Rarities = require(ReplicatedStorage.Shared.Rarities);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local RngUtil = require(ReplicatedStorage.Shared.RngUtil);
local Gamepasses = require(ReplicatedStorage.Shared.Configs.Gamepasses);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SpawnVFX = require(ReplicatedStorage.Effects.SpawnVFX);
local FlowLotteryController = require(ReplicatedStorage.Shared.FlowLotteryController);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);
local FlowEffectsManager = require(ReplicatedStorage.Shared.FlowEffectsManager);
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests);
local u1 = nil;
local Random_new_ret = Random.new();
local u2 = {
    Rare = "rbxassetid://115415949340950",
    Epic = "rbxassetid://99013252868230",
    Legendary = "rbxassetid://111618869458274",
    Mythic = "rbxassetid://111618869458274",
    ["World Class"] = "rbxassetid://83845612021533",
    Generational = "rbxassetid://138694945254921",
    Master = "rbxassetid://83845612021533",
    Dev = "rbxassetid://83845612021533",
    Limited = "rbxassetid://83845612021533"
};
local Flow = ClientGlobals.PlayerGui.Flow;
local ScrollingFrame = Flow.BG.Slots.ScrollingFrame;
local ScrollingFrame2 = Flow.BG.Rarities.ScrollingFrame;
local LimitedInventory = Flow.LimitedInventory;
local Items = Flow.LimitedInventory.Items;
local LocalPlayer = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local SlotTemplate = ScrollingFrame.SlotTemplate;
SlotTemplate.Parent = nil;
local u3 = game:GetService("RunService"):IsStudio() or require(game:GetService("ReplicatedStorage").Shared.environment).env ~= "Main";
local u4 = false;
local u5 = false;
local u6 = nil;
local u7 = nil;
local u8 = false;
local u9 = makePlayerModel(true);
u9.Name = "FlowVisualCharacter";
u9.Parent = workspace.GameObjects;
task.spawn(function() -- Line: 95
    -- upvalues: u9 (copy), ReplicatedStorage (copy)
    u9.HumanoidRootPart.CFrame = workspace:WaitForChild("BG").CFrame * CFrame.new(0, 0, -17);
    u9.Humanoid:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims:WaitForChild("Movement"):WaitForChild("Idle")):Play();
end);
local u10 = KnitClient.CreateController({
    Name = "Flows"
});
local u11 = Signal.new();

local function calculateRarityChance(p12: string, p13: string) -- Line: 114
    -- upvalues: FlowLotteryController (copy)
    return FlowLotteryController.GetRarityChance(p12, p13 == "Lucky") or 0;
end;

local function calculateStyleChance(p14: string, p15: string, p16: boolean) -- Line: 118
    -- upvalues: FlowLotteryController (copy)
    local StyleChance = FlowLotteryController.GetStyleChance(p14, p15 == "Lucky", p16);

    if StyleChance < 0.01 then
        return math.floor(StyleChance * 10000) / 10000;
    end;

    return math.floor(StyleChance * 100) / 100;
end;

local function loadSlotTemplate(u17: any, u18: table) -- Line: 127
    -- upvalues: Flows (copy), u2 (copy), ProductIds (copy), getProductInfo (copy)
    local Rarity = Flows[u18.style].Rarity;
    u17.Lock.Visible = u18.locked and true or false;
    u17.Image = u2[Rarity];

    if Rarity == "Mythic" then
        u17.ImageColor3 = Color3.new(1, 0, 0);
    else
        u17.ImageColor3 = Color3.new(1, 1, 1);
    end;

    if u18.slotId then
        if u18.slotOwned then
            u17.StyleLabel.Text = u18.style;
            u17.State.Text = u18.equipped and "Equipped" or "Equip";
        else
            u17.StyleLabel.Text = "LOCKED";
            u17.State.Text = "PURCHASE";
        end;

        if u18.slotId > 1 then
            task.spawn(function() -- Line: 160
                -- upvalues: ProductIds (ref), u18 (copy), getProductInfo (ref), u17 (copy)
                local v19 = getProductInfo(ProductIds.FlowSlots[`Slot{u18.slotId}`], Enum.InfoType.Product);
                u17.Price.Text = `{v19.PriceInRobux}`;
            end);
            u17.Price.Visible = u18.slotOwned ~= true;
        end;
    else
        u17.StyleLabel.Text = u18.style;
        u17.State.Text = u18.equipped and "Equipped" or "Equip";
    end;
end;

local u20 = {
    Flow.LimitedInventory,
    Flow.BuyLucky,
    Flow.BuyMoney,
    Flow.BuySpins
};

local function openSubMenu(p21: userdata?) -- Line: 182
    -- upvalues: u20 (copy)
    for _, v in u20 do
        if v == p21 then
            v.Visible = true;
        else
            v.Visible = false;
        end;
    end;
end;

function u10.SetShownStyle(p22: table, p23: string, p24: boolean?) -- Line: 192
    -- upvalues: u7 (ref), Flows (copy), Flow (copy), Rarities (copy), FlowEffectsManager (copy), u9 (copy)
    if u7 then
        u7:Destroy();
        u7 = nil;
    end;

    local v25 = Flows[p23];
    Flow.BG.StyleTxt.TextColor3 = Rarities[v25.Rarity].Color;
    Flow.BG.StyleTxt.Text = v25.Name or p23;

    for _, child in Flow.BG.StyleTxt:GetChildren() do
        if child:IsA("UIGradient") then
            child.Enabled = child.Name == p23;
        end;
    end;

    Flow.BG.Desc.Text = v25.Desc;

    if not p24 then
        u7 = FlowEffectsManager:Load(u9, p23, false);
    end;
end;

function u10.OnAcquired(p26: table, p27: string) -- Line: 215
    -- upvalues: Flows (copy), Popup (copy), LocalPlayer (copy), SoundManager (copy), ClientGlobals (copy), SpawnVFX (copy), ReplicatedStorage (copy), u9 (copy), Rarities (copy), u8 (ref), ABTests (copy), KnitClient (copy)
    local v28 = Flows[p27];
    Popup.Popup(LocalPlayer, (`SPUN "{v28.Name or p27}"`));
    SoundManager.SpawnSound("Gain", 0.5, ClientGlobals.PlayerGui, 1);
    local v29 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v29 and v29.RootPart then
        SpawnVFX({
            Vfx = ReplicatedStorage.Assets.Vfx.Unlock,
            Pos = u9.HumanoidRootPart.CFrame,
            Color = Rarities[v28.Rarity].Color
        });
    end;

    if not u8 then
        u8 = true;
        local v30 = LocalPlayer.ProfileStats and LocalPlayer.ProfileStats.FlowSpins;

        if v30 and v30.Value == 1 then
            task.spawn(function() -- Line: 238
                -- upvalues: ABTests (ref), LocalPlayer (ref), KnitClient (ref)
                if ABTests.GetAttributeAsync(LocalPlayer, "StarterPack.PromptLocation", "OpeningUI") == "AfterFirstSpin" then
                    task.delay(1, function() -- Line: 241
                        -- upvalues: KnitClient (ref)
                        KnitClient.GetController("StarterPackInterface"):PromptStarterPackForABTest();
                    end);
                end;
            end);
        end;
    end;
end;

function u10.PerformSpinAnimation(p31: table, p32: string) -- Line: 251
    -- upvalues: u5 (ref), Flows (copy), Random_new_ret (copy), SoundManager (copy), ClientGlobals (copy), RngUtil (copy), u11 (copy), u10 (copy), PlayerData (copy)
    u5 = true;
    local v33 = {
        Easter = true,
        ["Easter Flow"] = true
    };
    local v34 = {};

    for i, v in Flows do
        if v.Rarity ~= "Dev" and (v.Unobtainable ~= true and not v33[i]) then
            v34[i] = 1;
        end;
    end;

    local v35 = Random_new_ret:NextInteger(10, 15);

    for i = 1, v35 do
        SoundManager.SpawnSound("Spin", 0.35, ClientGlobals.PlayerGui, 1);
        p31:SetShownStyle(RngUtil.SelectRandom(v34), true);
        local math_clamp_ret = math.clamp(i / v35 / 2, 0, 1.2);
        task.wait(math_clamp_ret);
        local _ = i;
    end;

    u5 = false;
    u11:Fire();
    u10:SetShownStyle(PlayerData.Data.FlowSlots[PlayerData.Data.FlowSlots.SlotEquipped]);
    u10:OnAcquired(p32);
end;

function u10.KnitStart(p36) -- Line: 282
    -- upvalues: u1 (ref), KnitClient (copy), PlayerData (copy), SlotTemplate (copy), ScrollingFrame (copy), Gift (copy), ProductIds (copy), u5 (ref), u11 (copy), loadSlotTemplate (copy), Flows (copy), Items (copy), Flow (copy), LimitedInventory (copy), u20 (copy), u10 (copy), Popup (copy), LocalPlayer (copy), Rarities (copy), u4 (ref), u3 (copy), MarketplaceService (copy), Gamepasses (copy), FlowLotteryController (copy), u6 (ref), ReplicatedStorage (copy), ScrollingFrame2 (copy), getProductInfo (copy), FormatNumber (copy), TweenService (copy), u9 (copy), u8 (ref), ABTests (copy)
    u1 = KnitClient.GetService("FlowService");
    p36.FlowService = u1;
    PlayerData:WaitForLoaded();

    for i = 1, 7 do
        local u37 = SlotTemplate:Clone();
        u37.LayoutOrder = i;
        u37.Gift.Visible = true;
        u37.Parent = ScrollingFrame;
        u37.Activated:Connect(function() -- Line: 294
            -- upvalues: u1 (ref), i (copy)
            u1.Slot:Fire((`Slot{i}`));
        end);
        Gift:RegisterButton(u37.Gift.Gift, ProductIds.FlowSlots[`Slot{i}Gift`]);

        local function update() -- Line: 299
            -- upvalues: u5 (ref), u11 (ref), loadSlotTemplate (ref), u37 (copy), PlayerData (ref), i (copy)
            if u5 then
                u11:Wait();
            end;

            loadSlotTemplate(u37, {
                style = PlayerData.Data.FlowSlots[`Slot{i}`],
                slotOwned = i <= PlayerData.Data.FlowSlots.MaxSlot,
                slotId = i,
                locked = PlayerData.Data.FlowSlots.Locked[`Slot{i}`] == true,
                equipped = PlayerData.Data.FlowSlots.SlotEquipped == `Slot{i}`
            });
        end;

        PlayerData:Observe({ "FlowSlots", (`Slot{i}`) }, update);
        PlayerData:Observe({ "FlowSlots", "MaxSlot" }, update);
        PlayerData:Observe({ "FlowSlots", "SlotEquipped" }, update);
        PlayerData:Observe({ "FlowSlots", "Locked" }, update);
        workspace:GetAttributeChangedSignal("RefreshSlotPrices"):Connect(update);
        local _ = i;
    end;

    for i, v in Flows do
        if v.Rarity == "Limited" then
            local u38 = SlotTemplate:Clone();
            u38.SizeConstraint = Enum.SizeConstraint.RelativeXX;
            u38.Size = UDim2.fromScale(0.22, 0.22);
            u38.Gift.Visible = false;
            u38.Parent = Items;
            u38.Activated:Connect(function() -- Line: 333
                -- upvalues: u1 (ref), i (copy)
                u1.EquipLimited:Fire(i);
            end);

            local function v41() -- Line: 337
                -- upvalues: loadSlotTemplate (ref), u38 (copy), i (copy), PlayerData (ref)
                local v39 = {
                    style = i
                };
                local v40;

                if PlayerData.Data.FlowSlots.SlotEquipped == "Slot0" then
                    v40 = PlayerData.Data.FlowSlots.Slot0 == i;
                else
                    v40 = false;
                end;

                v39.equipped = v40;
                loadSlotTemplate(u38, v39);
                u38.Visible = PlayerData.Data.FlowSlots.LimitedInventory[i] and true or false;
            end;

            PlayerData:Observe({ "FlowSlots", "LimitedInventory", i }, v41);
            PlayerData:Observe({ "FlowSlots", "SlotEquipped" }, v41);
            PlayerData:Observe({ "FlowSlots", "Slot0" }, v41);
        end;
    end;

    Flow.BG.Limiteds.Activated:Connect(function() -- Line: 354
        -- upvalues: LimitedInventory (ref), u20 (ref)
        local v42 = LimitedInventory;

        for _, v in u20 do
            if v == v42 then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    PlayerData:Observe({ "FlowSlots" }, function() -- Line: 359
        -- upvalues: u5 (ref), u10 (ref), PlayerData (ref)
        if u5 then
            return;
        end;

        u10:SetShownStyle(PlayerData.Data.FlowSlots[PlayerData.Data.FlowSlots.SlotEquipped]);
    end);

    local function setupSpinButton(u43: userdata, u44: string, u45: table) -- Line: 367
        -- upvalues: u5 (ref), PlayerData (ref), Popup (ref), LocalPlayer (ref), Flows (ref), Rarities (ref), u1 (ref), u4 (ref), u10 (ref)
        local u46 = false;
        local u47 = 0;
        u43.Activated:Connect(function() -- Line: 374
            -- upvalues: u47 (ref), u5 (ref), PlayerData (ref), Popup (ref), LocalPlayer (ref), u46 (ref), Flows (ref), Rarities (ref), u1 (ref), u44 (copy), u4 (ref), u10 (ref)
            if time() - u47 < 0.5 then
                return;
            end;

            u47 = time();

            if u5 then
                return;
            end;

            if PlayerData.Data.FlowSlots.SlotEquipped == "Slot0" then
                Popup.Popup(LocalPlayer, "You have no slot selected!");

                return;
            end;

            if u46 or not PlayerData.Data.Settings.SpinOffWarning then
                if u46 and time() - u46 < 1 then
                    return;
                end;
            else
                local Rarity = Flows[PlayerData.Data.FlowSlots[PlayerData.Data.FlowSlots.SlotEquipped]].Rarity;

                if Rarities[Rarity].Priority >= Rarities.Mythic.Priority then
                    local v48 = time();
                    u46 = v48;
                    Popup.Popup(LocalPlayer, (`This is a "{Rarity:upper()}" are you sure?`));
                    task.wait(2);

                    if u46 == v48 then
                        u46 = false;
                    end;

                    return;
                end;
            end;

            u46 = false;
            u5 = true;
            local _, result = pcall(function() -- Line: 411
                -- upvalues: u1 (ref), u44 (ref)
                return u1:SpinFlow(u44);
            end);
            u5 = false;

            if not result then
                return;
            end;

            if u4 then
                u10:OnAcquired(result);

                return;
            end;

            u10:PerformSpinAnimation(result);
        end);
        u43.Label.Text = u45.get();
        PlayerData:Listen(u45.watch, function() -- Line: 426
            -- upvalues: u43 (copy), u45 (copy)
            u43.Label.Text = u45.get();
        end);
    end;

    local u49 = LocalPlayer:GetAttribute("RNGRestricted") == true;
    setupSpinButton(Flow.BG.Spin, "Normal", {
        watch = { { "FlowSpins" }, { "Money" } },

        get = function() -- Line: 434, Name: get
            -- upvalues: u49 (copy), PlayerData (ref), Flow (ref)
            if u49 then
                if PlayerData.Data.FlowSpins == 0 then
                    Flow.BG.SpinsLeft.Text = `BUYS LEFT: {PlayerData.Data.Money // 2000}`;

                    return "BUY $2,000";
                end;

                Flow.BG.SpinsLeft.Text = "";

                return `BUY ({PlayerData.Data.FlowSpins})`;
            end;

            if PlayerData.Data.FlowSpins == 0 then
                Flow.BG.SpinsLeft.Text = `SPINS LEFT: {PlayerData.Data.Money // 2000}`;

                return "SPIN $2,000";
            end;

            Flow.BG.SpinsLeft.Text = "";

            return `SPINS LEFT: {PlayerData.Data.FlowSpins}`;
        end
    });
    setupSpinButton(Flow.BG.LuckySpins, "Lucky", {
        watch = { "LuckyFlowSpins" },

        get = function() -- Line: 455, Name: get
            -- upvalues: Flow (ref), PlayerData (ref), u49 (copy)
            Flow.BG.BuyLuckySpins2.Visible = PlayerData.Data.LuckyFlowSpins < 100;

            if u49 then
                return `PREMIUM BUY ({PlayerData.Data.LuckyFlowSpins})`;
            end;

            return `LUCKY SPINS: {PlayerData.Data.LuckyFlowSpins}`;
        end
    });

    local function setSkipping(p50) -- Line: 465
        -- upvalues: u4 (ref), Flow (ref)
        u4 = p50;
        Flow.BG.SkipSpins.Label.Text = `SKIP SPINS: {p50 and "ON" or "OFF"}`;
    end;

    local v51 = u3;
    u4 = v51;
    Flow.BG.SkipSpins.Label.Text = `SKIP SPINS: {v51 and "ON" or "OFF"}`;
    Flow.BG.SkipSpins.Activated:Connect(function() -- Line: 470
        -- upvalues: u3 (ref), PlayerData (ref), u4 (ref), Flow (ref), MarketplaceService (ref), LocalPlayer (ref), Gamepasses (ref)
        if not (u3 or PlayerData.Data.Gamepasses.SkipSpins) then
            MarketplaceService:PromptGamePassPurchase(LocalPlayer, Gamepasses.SkipSpins.ID);

            return;
        end;

        local v52 = not u4;
        u4 = v52;
        Flow.BG.SkipSpins.Label.Text = `SKIP SPINS: {v52 and "ON" or "OFF"}`;
    end);

    if LocalPlayer:GetAttribute("RNGRestricted") == nil then
        LocalPlayer:GetAttributeChangedSignal("RNGRestricted"):Wait();
    end;

    local u53 = LocalPlayer:GetAttribute("RNGRestricted") == true;
    local v54 = (function() -- Line: 489, Name: findRevampFrame
        -- upvalues: Flow (ref)
        for _, v in { Flow.BG.Rarities, Flow.BG } do
            for _, child in v:GetChildren() do
                if child.Name == "Revamp" and child:IsA("Frame") then
                    return child;
                end;
            end;
        end;

        return nil;
    end)();
    local u55;

    if v54 then
        u55 = v54:FindFirstChild("ScrollingFrame");
    else
        u55 = v54;
    end;

    local u56 = {
        Rare = {
            Image = "rbxassetid://119110849320130",
            ImageColor3 = Color3.new(1, 1, 1)
        },
        Epic = {
            Image = "rbxassetid://100993557368832",
            ImageColor3 = Color3.new(1, 1, 1)
        },
        Legendary = {
            Image = "rbxassetid://129207016857060",
            ImageColor3 = Color3.new(1, 1, 1)
        },
        Mythic = {
            Image = "rbxassetid://129207016857060",
            ImageColor3 = Color3.fromRGB(255, 6, 6)
        },
        ["World Class"] = {
            Image = "rbxassetid://139736919389363",
            ImageColor3 = Color3.new(1, 1, 1)
        },
        Master = {
            Image = "rbxassetid://139736919389363",
            ImageColor3 = Color3.new(1, 1, 1)
        },
        Limited = {
            Image = "rbxassetid://139736919389363",
            ImageColor3 = Color3.new(1, 1, 1)
        },
        Generational = {
            Image = "rbxassetid://139736919389363",
            ImageColor3 = Color3.new(1, 1, 1)
        },
        Event = {
            Image = "rbxassetid://139736919389363",
            ImageColor3 = Color3.new(1, 1, 1)
        }
    };
    local u57 = {
        Normal = {},
        Lucky = {}
    };
    local u58 = "Normal";

    local function updateRevampList() -- Line: 517
        -- upvalues: u55 (copy), u57 (copy), u58 (ref), u56 (copy)
        if not u55 then
            return;
        end;

        local v59 = u57[u58] or {};

        for i = 1, 5 do
            local v60 = u55:FindFirstChild((tostring(i)));
            local v61;

            if v60 then
                local v62 = v59[i];

                if v62 then
                    local Text = v60:FindFirstChild("Text");

                    if Text then
                        Text.Text = v62.Name;
                    end;

                    local v63 = u56[v62.Rarity];

                    if v63 then
                        v60.Image = v63.Image;
                        v60.ImageColor3 = v63.ImageColor3;
                        v61 = i;
                    else
                        v61 = i;
                    end;
                else
                    local Text = v60:FindFirstChild("Text");

                    if Text then
                        Text.Text = "";
                    end;

                    v60.Image = "";
                    v61 = i;
                end;
            else
                v61 = i;
            end;
        end;
    end;

    if u53 then
        if v54 then
            v54.Visible = true;
        end;

        if v54 then
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "PrerollInfoButton";
            TextButton.Position = UDim2.new(0.4, 0, -0.155, 0);
            TextButton.Size = UDim2.new(0, 21, 0, 21);
            TextButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
            TextButton.BackgroundTransparency = 0.25;
            TextButton.Text = "?";
            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255);
            TextButton.Font = Enum.Font.GothamBold;
            TextButton.TextSize = 14;
            TextButton.ZIndex = 6;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(1, 0);
            UICorner.Parent = TextButton;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Thickness = 1.5;
            UIStroke.Color = Color3.fromRGB(255, 255, 255);
            UIStroke.Transparency = 0.4;
            UIStroke.Parent = TextButton;
            TextButton.Parent = v54;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "PrerollInfoLabel";
            TextLabel.AnchorPoint = Vector2.new(1, 1);
            TextLabel.Position = UDim2.new(1, 0, -0.17, -4);
            TextLabel.Size = UDim2.new(0, 235, 0, 78);
            TextLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 15);
            TextLabel.BackgroundTransparency = 0.1;
            TextLabel.TextColor3 = Color3.fromRGB(235, 235, 235);
            TextLabel.Font = Enum.Font.Gotham;
            TextLabel.TextSize = 13;
            TextLabel.TextWrapped = true;
            TextLabel.Text = "Items shown are the results of the next 5 pack openings. Upon opening a pack, items move upward and the next item will be shown.";
            TextLabel.Visible = false;
            TextLabel.ZIndex = 7;
            local UICorner2 = Instance.new("UICorner");
            UICorner2.CornerRadius = UDim.new(0, 6);
            UICorner2.Parent = TextLabel;
            local UIStroke2 = Instance.new("UIStroke");
            UIStroke2.Thickness = 1.5;
            UIStroke2.Color = Color3.fromRGB(255, 255, 255);
            UIStroke2.Transparency = 0.5;
            UIStroke2.Parent = TextLabel;
            local UIPadding = Instance.new("UIPadding");
            UIPadding.PaddingLeft = UDim.new(0, 8);
            UIPadding.PaddingRight = UDim.new(0, 8);
            UIPadding.PaddingTop = UDim.new(0, 6);
            UIPadding.PaddingBottom = UDim.new(0, 6);
            UIPadding.Parent = TextLabel;
            TextLabel.Parent = v54;
            local u64 = false;
            TextButton.Activated:Connect(function() -- Line: 599
                -- upvalues: u64 (ref), TextLabel (copy)
                u64 = not u64;
                TextLabel.Visible = u64;
            end);
            TextButton.MouseEnter:Connect(function() -- Line: 603
                -- upvalues: TextLabel (copy)
                TextLabel.Visible = true;
            end);
            TextButton.MouseLeave:Connect(function() -- Line: 606
                -- upvalues: TextLabel (copy), u64 (ref)
                TextLabel.Visible = u64;
            end);
        end;

        task.spawn(function() -- Line: 612
            -- upvalues: u1 (ref), u57 (copy), updateRevampList (copy)
            local PrerolledFlows = u1:GetPrerolledFlows();

            if type(PrerolledFlows) == "table" then
                u57.Normal = PrerolledFlows.Normal or {};
                u57.Lucky = PrerolledFlows.Lucky or {};
                updateRevampList();
            end;
        end);
        u1.PrerolledUpdate:Connect(function(p65) -- Line: 621
            -- upvalues: u57 (copy), updateRevampList (copy)
            if type(p65) == "table" then
                u57.Normal = p65.Normal or {};
                u57.Lucky = p65.Lucky or {};
            end;

            updateRevampList();
        end);
        Flow:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 629
            -- upvalues: Flow (ref), updateRevampList (copy)
            if Flow.Enabled then
                updateRevampList();
            end;
        end);
    elseif v54 then
        v54.Visible = false;
    end;

    local u66 = "Normal";
    local u67 = nil;
    local u68 = {};
    local u69 = {};
    local Rarities2 = Flow.BG:FindFirstChild("Rarities");

    if Rarities2 and not Rarities2:FindFirstChild("OddsDisclaimer") then
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "OddsDisclaimer";
        TextLabel.BackgroundTransparency = 1;
        TextLabel.AnchorPoint = Vector2.new(1, 0);
        TextLabel.Position = UDim2.new(0.145744264, 2, 0.569130719, 167);
        TextLabel.Size = UDim2.new(0, 205, 0, 34);
        TextLabel.Font = Enum.Font.Gotham;
        TextLabel.TextScaled = true;
        TextLabel.TextWrapped = true;
        TextLabel.TextColor3 = Color3.fromRGB(235, 235, 235);
        TextLabel.ZIndex = 5;
        TextLabel.Text = "Odds are rounded to 2 decimal places and may not total exactly 100%.";
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = 1.5;
        UIStroke.Parent = TextLabel;
        TextLabel.Parent = Rarities2;
    end;

    local function updateChanceList() -- Line: 664
        -- upvalues: u69 (copy), FlowLotteryController (ref), u66 (ref), u53 (copy), u68 (copy), Flows (ref), u67 (ref), u6 (ref), Flow (ref)
        for i, v in u69 do
            if FlowLotteryController.RarityCanBeSpun(u66, i) then
                v.Visible = true;
            else
                v.Visible = false;
            end;

            if u53 then
                v.Text.Text = i:upper();
            else
                local Text = v.Text;
                local v70 = i:upper();
                local v71 = (FlowLotteryController.GetRarityChance(i, u66 == "Lucky") or 0) * 100;
                Text.Text = `{v70} - [{math.floor(v71) / 100}%]`;
            end;
        end;

        for i, v in u68 do
            local Rarity = Flows[i].Rarity;

            if Rarity == u67 and not Flows[i].Unobtainable then
                v.Visible = true;
            else
                v.Visible = false;
            end;

            local StyleChance = FlowLotteryController.GetStyleChance(Rarity, u66 == "Lucky", u6 == i);
            local v72;

            if StyleChance < 0.01 then
                v72 = math.floor(StyleChance * 10000) / 10000;
            else
                v72 = math.floor(StyleChance * 100) / 100;
            end;

            local v73 = u6 == i and "🟢 " or "";

            if u53 then
                v.Text = `{v73}{i}`;
            else
                v.Text = `{v73}{i} - {v72}%`;
            end;
        end;

        if u53 then
            return;
        end;

        if u66 == "Normal" then
            Flow.BG.BuySpins.Visible = true;
            Flow.BG.BuyLuckySpins.Visible = false;

            return;
        end;

        Flow.BG.BuySpins.Visible = false;
        Flow.BG.BuyLuckySpins.Visible = true;
    end;

    for i in Flows do
        local v74 = ReplicatedStorage.Assets.UI.Item:Clone();
        v74.LayoutOrder = Rarities[Flows[i].Rarity].Priority * 100 + 5;
        v74.TextXAlignment = Enum.TextXAlignment.Right;
        v74.Parent = ScrollingFrame2;
        v74.Activated:Connect(function() -- Line: 718
            -- upvalues: u53 (copy), u1 (ref), i (copy), u6 (ref), Popup (ref), LocalPlayer (ref), updateChanceList (copy)
            if not u53 then
                u1:SetTargetRollStyle(i);
                u6 = i;
                Popup.Popup(LocalPlayer, (`Selected "{i}"! Chances increased slightly.`));
            end;

            updateChanceList();
        end);
        u68[i] = v74;
    end;

    for i in Rarities do
        local v75 = ScrollingFrame2:FindFirstChild(i);

        if v75 then
            v75.LayoutOrder = Rarities[i].Priority * 100;
            v75.Activated:Connect(function() -- Line: 735
                -- upvalues: u67 (ref), i (copy), updateChanceList (copy)
                local v76;

                if u67 == i then
                    v76 = nil;
                else
                    v76 = i;
                end;

                u67 = v76;
                updateChanceList();
            end);
            u69[i] = v75;
        end;
    end;

    updateChanceList();
    Flow.BG.Rarities.LuckyOdds.Activated:Connect(function() -- Line: 744
        -- upvalues: u66 (ref), u67 (ref), u58 (ref), updateChanceList (copy), updateRevampList (copy)
        u66 = "Lucky";
        u67 = nil;
        u58 = "Lucky";
        updateChanceList();
        updateRevampList();
    end);
    Flow.BG.Rarities.Odds.Activated:Connect(function() -- Line: 752
        -- upvalues: u66 (ref), u67 (ref), u58 (ref), updateChanceList (copy), updateRevampList (copy)
        u66 = "Normal";
        u67 = nil;
        u58 = "Normal";
        updateChanceList();
        updateRevampList();
    end);
    local Revamp = Flow.BG.Rarities:FindFirstChild("Revamp");

    if Revamp then
        Revamp.Visible = false;
    end;

    if u53 then
        local Text = Flow.BG.Rarities.Odds:FindFirstChild("Text");

        if Text and Text:IsA("TextLabel") then
            Text.Text = "NORMAL";
        end;

        local Text2 = Flow.BG.Rarities.LuckyOdds:FindFirstChild("Text");

        if Text2 and Text2:IsA("TextLabel") then
            Text2.Text = "PREMIUM";
        end;
    end;

    local function updateLockState() -- Line: 773
        -- upvalues: PlayerData (ref), Flow (ref)
        local FlowSlots = PlayerData.Data.FlowSlots;

        if FlowSlots.SlotEquipped == "Slot0" then
            Flow.BG.LockSlot.Visible = false;

            return;
        end;

        Flow.BG.LockSlot.Visible = true;

        if FlowSlots.Locked[FlowSlots.SlotEquipped] then
            Flow.BG.LockSlot.Image = "rbxassetid://110336058460550";
            Flow.BG.LockSlot.Text.Text = "UNLOCK";

            return;
        end;

        Flow.BG.LockSlot.Image = "rbxassetid://72009258674014";
        Flow.BG.LockSlot.Text.Text = "LOCK";
    end;

    Flow.BG.LockSlot.Activated:Connect(function() -- Line: 791
        -- upvalues: u5 (ref), PlayerData (ref), Popup (ref), LocalPlayer (ref), u1 (ref)
        if u5 then
            return;
        end;

        local FlowSlots = PlayerData.Data.FlowSlots;

        if FlowSlots.Locked[FlowSlots.SlotEquipped] then
            Popup.Popup(LocalPlayer, (`Unlocked {FlowSlots.SlotEquipped}`));
            u1.LockSlot:Fire(FlowSlots.SlotEquipped, false);

            return;
        end;

        Popup.Popup(LocalPlayer, (`Locked {FlowSlots.SlotEquipped}`));
        u1.LockSlot:Fire(FlowSlots.SlotEquipped, true);
    end);
    PlayerData:Listen({ "FlowSlots" }, updateLockState);
    updateLockState();

    local function loadStore(p77, u78) -- Line: 810
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref), getProductInfo (ref), Gift (ref)
        for _, v in p77 do
            if v:IsA("GuiObject") then
                local Name = v.Name;
                v.Button.Activated:Connect(function() -- Line: 817
                    -- upvalues: MarketplaceService (ref), LocalPlayer (ref), u78 (copy), Name (copy)
                    MarketplaceService:PromptProductPurchase(LocalPlayer, u78[`Buy{Name}`]);
                end);

                if not u78[`Buy{Name}`] then
                    warn(p77, Name);
                end;

                task.spawn(function() -- Line: 823
                    -- upvalues: v (copy), getProductInfo (ref), u78 (copy), Name (copy)
                    v.Button.Text.Text = "Buy";
                    local v79 = getProductInfo(u78[`Buy{Name}`], Enum.InfoType.Product);
                    v.Button.Text.Text = `{v79.PriceInRobux}`;
                end);

                if v:FindFirstChild("Gift") then
                    Gift:RegisterButton(v.Gift, u78[`Gift{Name}`]);
                end;
            end;
        end;
    end;

    loadStore(Flow.BuyLucky.Frame:GetChildren(), ProductIds.LuckyFlowSpins);
    loadStore(Flow.BuySpins.Frame:GetChildren(), ProductIds.NormalFlowSpins);
    loadStore(Flow.BuyMoney.Frame:GetChildren(), ProductIds.Money);

    if u53 then
        local Text = Flow.BG.BuyLuckySpins:FindFirstChild("Text");

        if Text and Text:IsA("TextLabel") then
            Text.Text = "BUY PREMIUM BUYS";
        end;

        for _, child in Flow.BuyLucky.Frame:GetChildren() do
            if child:IsA("GuiObject") then
                local v80 = tonumber(child.Name) or 0;
                local Text2 = child:FindFirstChild("Text");

                if Text2 and Text2:IsA("TextLabel") then
                    Text2.Text = string.format("%d PREMIUM %s", v80, v80 == 1 and "BUY" or "BUYS");
                end;
            end;
        end;

        local Text2 = Flow.BG.BuySpins:FindFirstChild("Text");

        if Text2 and Text2:IsA("TextLabel") then
            Text2.Text = "BUY BUYS";
        end;

        for _, descendant in Flow.BuySpins:GetDescendants() do
            if descendant:IsA("TextLabel") and (descendant.Name == "Title" or (descendant.Name == "Header" or descendant.Name == "Name")) then
                descendant.Text = "BUYS";
            end;
        end;

        for _, child in Flow.BuySpins.Frame:GetChildren() do
            if child:IsA("GuiObject") then
                local v81 = tonumber(child.Name) or 0;
                local Text3 = child:FindFirstChild("Text");

                if Text3 and Text3:IsA("TextLabel") then
                    Text3.Text = string.format("%d %s", v81, v81 == 1 and "BUY" or "BUYS");
                end;
            end;
        end;
    end;

    PlayerData:Observe({ "Money" }, function(p82) -- Line: 875
        -- upvalues: Flow (ref), FormatNumber (ref)
        Flow.BG.Money.Currency.Text = `{FormatNumber.Commas(p82)}`;
    end);
    Flow.BG.BuySpins.Activated:Connect(function() -- Line: 879
        -- upvalues: Flow (ref), u20 (ref)
        local BuySpins = Flow.BuySpins;

        for _, v in u20 do
            if v == BuySpins then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    Flow.BG.BuyLuckySpins.Activated:Connect(function() -- Line: 882
        -- upvalues: Flow (ref), u20 (ref)
        local BuyLucky = Flow.BuyLucky;

        for _, v in u20 do
            if v == BuyLucky then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    Flow.BG.BuyLuckySpins2.Activated:Connect(function() -- Line: 885
        -- upvalues: Flow (ref), u20 (ref)
        local BuyLucky = Flow.BuyLucky;

        for _, v in u20 do
            if v == BuyLucky then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    Flow.BG.Money.Activated:Connect(function() -- Line: 888
        -- upvalues: Flow (ref), u20 (ref)
        local BuyMoney = Flow.BuyMoney;

        for _, v in u20 do
            if v == BuyMoney then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);

    for _, v in {
        LimitedInventory.Close2,
        Flow.BuyLucky.Exit,
        Flow.BuySpins.Exit,
        Flow.BuyMoney.Exit
    } do
        v.Activated:Connect(function() -- Line: 898
            -- upvalues: u20 (ref)
            for _, v2 in u20 do
                if v2 == nil then
                    v2.Visible = true;
                else
                    v2.Visible = false;
                end;
            end;
        end);
    end;

    task.spawn(function() -- Line: 903
        -- upvalues: Flow (ref), FormatNumber (ref)
        while true do
            local SaleTag = Flow.BG.Slots.SaleTag;
            local Attribute = workspace:GetAttribute("SlotsDiscountTimer");

            if Attribute and DateTime.now().UnixTimestamp < Attribute then
                SaleTag.Visible = true;
                SaleTag.Sale.Text = `Sale: {workspace:GetAttribute("SlotsDiscountRate") or 25}%`;
                SaleTag.Timer.Text = FormatNumber.LongClockString(Attribute - DateTime.now().UnixTimestamp, false);
            else
                SaleTag.Visible = false;
            end;

            task.wait(1);
        end;
    end);
    Flow:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 919
        -- upvalues: u20 (ref), Flow (ref), TweenService (ref), u9 (ref), u8 (ref), ABTests (ref), LocalPlayer (ref), KnitClient (ref)
        for _, v in u20 do
            if v == nil then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;

        if Flow.Enabled then
            TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = u9.HumanoidRootPart.CFrame * CFrame.new(0, 0, -13) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0)
            }):Play();
        end;

        if u8 then
            return;
        end;

        if not Flow.Enabled and ABTests.GetAttributeAsync(LocalPlayer, "StarterPack.PromptLocation", "OpeningUI") == "AfterClosingStyleUI" then
            task.delay(0.5, function() -- Line: 939
                -- upvalues: KnitClient (ref)
                KnitClient.GetController("StarterPackInterface"):PromptStarterPackForABTest();
            end);
        end;
    end);
    Flow.BG.Limiteds.Visible = true;
end;

return u10;