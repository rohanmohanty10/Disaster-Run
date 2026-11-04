  

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local Signal = require(ReplicatedStorage.Packages.Signal);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local ProductIds = require(ReplicatedStorage.Shared.Configs.ProductIds);
local getProductInfo = require(ReplicatedStorage.Shared.utils.getProductInfo);
local PlrStyles = require(ReplicatedStorage.Shared.PlrStyles);
local Gift = require(ReplicatedStorage.Controllers.UIController.Gift);
local Rarities = require(ReplicatedStorage.Shared.Rarities);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local RngUtil = require(ReplicatedStorage.Shared.RngUtil);
local Gamepasses = require(ReplicatedStorage.Shared.Configs.Gamepasses);
local Popup = require(ReplicatedStorage.Shared.Popup);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local SpawnVFX = require(ReplicatedStorage.Effects.SpawnVFX);
local StylesLotteryController = require(ReplicatedStorage.Shared.StylesLotteryController);
require(ReplicatedStorage.Shared.FormatNumber);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests);
local StyleEventData = require(ReplicatedStorage.Shared.Configs.StyleEventData);
local LimitedStyleDrop = require(ReplicatedStorage.Shared.Configs.LimitedStyleDrop);
local script_LimitedStyleCountdown = require(script.LimitedStyleCountdown);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local NELQuests = require(ReplicatedStorage.Shared.Configs.NELQuests);
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
    Limited = "rbxassetid://83845612021533",
    Event = StyleEventData.RarityImage or "rbxassetid://83845612021533"
};
local Style = ClientGlobals.PlayerGui.Style;
local ScrollingFrame = Style.BG.Slots.ScrollingFrame;
local ScrollingFrame2 = Style.BG.Rarities.ScrollingFrame;
local LimitedInventory = Style.LimitedInventory;
local Items = Style.LimitedInventory.Items;
local StyleQuestsPopup = ClientGlobals.PlayerGui.StyleQuestsPopup;
local LocalPlayer = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local SlotTemplate = ScrollingFrame.SlotTemplate;
SlotTemplate.Parent = nil;
local u3 = game:GetService("RunService"):IsStudio() or require(game:GetService("ReplicatedStorage").Shared.environment).env ~= "Main";
local u4 = false;
local u5 = false;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = false;
local u10 = KnitClient.CreateController({
    Name = "Styles"
});
local u11 = Signal.new();

local function calculateRarityChance(p12: string, p13: string) -- Line: 100
    -- upvalues: StylesLotteryController (copy)
    return StylesLotteryController.GetRarityChance(p12, p13) or 0;
end;

local function calculateStyleChance(p14: string, p15: string, p16: boolean) -- Line: 104
    -- upvalues: StylesLotteryController (copy)
    local StyleChance = StylesLotteryController.GetStyleChance(p14, p15, p16);

    if StyleChance < 0.1 then
        return math.floor(StyleChance * 10000) / 10000;
    end;

    return math.floor(StyleChance * 100) / 100;
end;

local function stopAnimating() -- Line: 113
    -- upvalues: u7 (ref), u6 (ref), LocalPlayer (copy)
    if u7 then
        u7:Stop();
        u7 = nil;
    end;

    u6 = nil;

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end;
end;

local function loadSlotTemplate(u17: any, u18: table) -- Line: 125
    -- upvalues: countStyleMastery (copy), PlayerData (copy), NELQuests (copy), PlrStyles (copy), u2 (copy), ProductIds (copy), getProductInfo (copy)
    local v19 = countStyleMastery(PlayerData.Data, u18.style) >= 4;
    local v20 = v19 and NELQuests[u18.style].NELName or u18.style;
    local v21 = v19 and NELQuests[u18.style].NELRarity or PlrStyles[u18.style].Rarity;
    u17.Lock.Visible = u18.locked and true or false;
    local Outfit = u17:FindFirstChild("Outfit");

    if Outfit then
        local v22;

        if u18.slotId == nil then
            v22 = false;
        else
            v22 = u18.slotOwned == true;
        end;

        Outfit.Visible = v22;
    end;

    u17.Image = u2[v21];
    local v23 = false;

    for _, child in u17:GetChildren() do
        if child:IsA("UIGradient") then
            if child.Name == u18.style then
                child.Enabled = true;
                v23 = true;
            else
                child.Enabled = false;
            end;
        end;
    end;

    if v23 then
        u17.ImageColor3 = Color3.new(1, 1, 1);
    elseif v21 == "Mythic" then
        u17.ImageColor3 = Color3.new(1, 0, 0);
    else
        u17.ImageColor3 = Color3.new(1, 1, 1);
    end;

    if u18.slotId then
        if u18.slotOwned then
            u17.StyleLabel.Text = v20;
            u17.State.Text = u18.equipped and "Equipped" or "Equip";
        else
            u17.StyleLabel.Text = "LOCKED";
            u17.State.Text = "PURCHASE";
        end;

        if u18.slotId > 1 then
            task.spawn(function() -- Line: 179
                -- upvalues: ProductIds (ref), u18 (copy), getProductInfo (ref), u17 (copy)
                local v24 = getProductInfo(ProductIds.StyleSlots[`Slot{u18.slotId}`], Enum.InfoType.Product);
                u17.Price.Text = `{v24.PriceInRobux}`;
            end);
            u17.Price.Visible = u18.slotOwned ~= true;
        end;
    else
        u17.StyleLabel.Text = v20;
        u17.State.Text = u18.equipped and "Equipped" or "Equip";
    end;
end;

local u25 = {
    Style.LimitedInventory,
    Style.BuyLucky,
    Style.BuyMoney,
    Style.BuySpins,
    Style.BuyEventSpins
};

local function openSubMenu(p26: userdata?) -- Line: 202
    -- upvalues: u25 (copy)
    for _, v in u25 do
        if v == p26 then
            v.Visible = true;
        else
            v.Visible = false;
        end;
    end;
end;

function u10.SetShownStyle(p27: table, p28: string, p29: boolean?) -- Line: 212
    -- upvalues: u6 (ref), u7 (ref), LocalPlayer (copy), PlrStyles (copy), countStyleMastery (copy), PlayerData (copy), NELQuests (copy), Style (copy), Rarities (copy)
    if p28 ~= u6 then
        if u7 then
            u7:Stop();
            u7 = nil;
        end;

        u6 = nil;

        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Anchored = false;
        end;
    end;

    local v30 = PlrStyles[p28];
    local v31;

    if p29 then
        v31 = v30.Rarity;
        Style.BG.StyleTxt.Text = p28;
    else
        local v32 = countStyleMastery(PlayerData.Data, p28) >= 4;
        local v33;

        if v32 then
            v33 = NELQuests[p28].NELName or p28;
        else
            v33 = p28;
        end;

        v31 = v32 and NELQuests[p28].NELRarity or v30.Rarity;
        Style.BG.StyleTxt.Text = v33;
    end;

    for _, child in Style.BG.StyleTxt:GetChildren() do
        if child:IsA("UIGradient") then
            child.Enabled = child.Name == p28;
        end;
    end;

    local v34 = false;

    for _, child in Style.BG.StyleTxt:GetChildren() do
        if child:IsA("UIGradient") then
            if child.Name == p28 then
                child.Enabled = true;
                v34 = true;
            else
                child.Enabled = false;
            end;
        end;
    end;

    if v34 then
        Style.BG.StyleTxt.TextColor3 = Color3.new(1, 1, 1);
    else
        Style.BG.StyleTxt.TextColor3 = v30.TextColor or Rarities[v31].Color;
    end;

    local Grades = v30.Grades;
    assert(Grades, p28);

    for _, v in { "SHT", "STE", "MOV", "DEF", "SUP" } do
        Style.BG.GradeTable.Values[v].Text = Grades[v];
    end;

    Style.BG.Difficulty.Text = `Difficulty: {Grades.DIFF}`;
    Style.BG.Desc.Text = v30.Desc;
end;

local function styleQuestPopup(p35) -- Line: 264
    -- upvalues: PlayerData (copy), StyleQuestsPopup (copy)
    if not PlayerData.Data.QuestPopUps[p35] then
        for _, child in StyleQuestsPopup:GetChildren() do
            child.Enabled = false;
        end;

        local v36 = StyleQuestsPopup:FindFirstChild(p35);

        if v36 then
            v36.Enabled = true;
        end;
    end;
end;

function u10.OnAcquired(p37: table, p38: string) -- Line: 279
    -- upvalues: PlrStyles (copy), LocalPlayer (copy), Popup (copy), NELQuests (copy), PlayerData (copy), StyleQuestsPopup (copy), SoundManager (copy), ClientGlobals (copy), u7 (ref), u6 (ref), Style (copy), ReplicatedStorage (copy), AnimationController (copy), SpawnVFX (copy), Rarities (copy), u9 (ref), ABTests (copy), KnitClient (copy)
    local v39 = PlrStyles[p38];

    if LocalPlayer:GetAttribute("RNGRestricted") then
        Popup.Popup(LocalPlayer, (`ACQUIRED "{v39.Name or p38}"`));
    else
        Popup.Popup(LocalPlayer, (`SPUN "{v39.Name or p38}"`));
    end;

    if NELQuests[p38] and not PlayerData.Data.QuestPopUps[p38] then
        for _, child in StyleQuestsPopup:GetChildren() do
            child.Enabled = false;
        end;

        local v40 = StyleQuestsPopup:FindFirstChild(p38);

        if v40 then
            v40.Enabled = true;
        end;
    end;

    SoundManager.SpawnSound("Gain", 0.5, ClientGlobals.PlayerGui, 1);

    if u7 then
        u7:Stop();
        u7 = nil;
    end;

    u6 = nil;

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end;

    local v41 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v41 and Style.Enabled then
        if v41.RootPart then
            v41.RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            v41.RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
        end;

        local v42 = ReplicatedStorage.Assets.ReplicatedAnims.Awakening:FindFirstChild(p38);

        if v42 then
            u7 = v41:LoadAnimation(v42);
            u7.Priority = Enum.AnimationPriority.Action4;
            u7:Play();
            AnimationController:Watch(u7);
            u6 = p38;
        end;

        local RootPart = v41.RootPart;

        if RootPart then
            SpawnVFX({
                Vfx = ReplicatedStorage.Assets.Vfx.Unlock,
                Pos = RootPart.CFrame,
                Color = Rarities[v39.Rarity].Color
            });
        end;
    end;

    if not u9 then
        u9 = true;
        local v43 = LocalPlayer.ProfileStats and LocalPlayer.ProfileStats.Spins;

        if v43 and v43.Value == 1 then
            task.spawn(function() -- Line: 328
                -- upvalues: ABTests (ref), LocalPlayer (ref), KnitClient (ref)
                if ABTests.GetAttributeAsync(LocalPlayer, "StarterPack.PromptLocation", "OpeningUI") == "AfterFirstSpin" then
                    task.delay(1, function() -- Line: 331
                        -- upvalues: KnitClient (ref)
                        KnitClient.GetController("StarterPackInterface"):PromptStarterPackForABTest();
                    end);
                end;
            end);
        end;
    end;
end;

function u10.PerformSpinAnimation(p44: table, p45: string, p46: string) -- Line: 341
    -- upvalues: u5 (ref), StylesLotteryController (copy), PlrStyles (copy), LimitedStyleDrop (copy), StyleEventData (copy), Random_new_ret (copy), SoundManager (copy), ClientGlobals (copy), RngUtil (copy), u11 (copy), u10 (copy), PlayerData (copy)
    u5 = true;
    local RarityChances = StylesLotteryController.GetRarityChances(p45);
    local v47 = {};

    for i, v in PlrStyles do
        if v.Rarity ~= "Dev" then
            if v.Rarity == LimitedStyleDrop.Rarity then
                if p45 == "Lucky" and LimitedStyleDrop.IsRollable(i) then
                    if RarityChances[v.Rarity] or StyleEventData.Enabled and table.find(StyleEventData.Styles, i) then
                        v47[i] = 1;
                    end;
                end;
            elseif v.Unobtainable ~= true then
                if RarityChances[v.Rarity] or StyleEventData.Enabled and table.find(StyleEventData.Styles, i) then
                    v47[i] = 1;
                end;
            end;
        end;
    end;

    local v48 = Random_new_ret:NextInteger(10, 15);
    local v49 = nil;

    for i = 1, v48 do
        SoundManager.SpawnSound("Spin", 0.35, ClientGlobals.PlayerGui, 1);
        local v50;

        repeat
            while true do
                v50 = RngUtil.SelectRandom(v47);

                if PlrStyles[v50].Rarity ~= LimitedStyleDrop.Rarity or LimitedStyleDrop.IsRollable(v50) then
                    break;
                end;

                v47[v50] = nil;
            end;
        until v50 ~= v49;

        p44:SetShownStyle(v50, true);
        local math_clamp_ret = math.clamp(i / v48 / 2, 0, 1.2);
        task.wait(math_clamp_ret);
        v49 = v50;
    end;

    u5 = false;
    u11:Fire();
    u10:SetShownStyle(PlayerData.Data.StyleSlots[PlayerData.Data.StyleSlots.SlotEquipped]);
    u10:OnAcquired(p46);
end;

function u10.KnitStart(p51) -- Line: 395
    -- upvalues: u1 (ref), KnitClient (copy), PlayerData (copy), StyleQuestsPopup (copy), SlotTemplate (copy), ScrollingFrame (copy), Gift (copy), ProductIds (copy), PlrStyles (copy), u5 (ref), u11 (copy), loadSlotTemplate (copy), Items (copy), Style (copy), LimitedInventory (copy), u25 (copy), u10 (copy), Popup (copy), LocalPlayer (copy), Rarities (copy), u4 (ref), u7 (ref), u6 (ref), StyleEventData (copy), u3 (copy), MarketplaceService (copy), Gamepasses (copy), StylesLotteryController (copy), LimitedStyleDrop (copy), FormatNumber (copy), u8 (ref), ScrollingFrame2 (copy), ReplicatedStorage (copy), script_LimitedStyleCountdown (copy), getProductInfo (copy), ABTests (copy), Players (copy), Essentials (copy), AnimationController (copy), u9 (ref)
    u1 = KnitClient.GetService("StyleService");
    PlayerData:WaitForLoaded();

    for _, descendant in StyleQuestsPopup:GetDescendants() do
        if descendant.Name == "Exit" and descendant:IsA("GuiButton") then
            local u52 = descendant:FindFirstAncestorOfClass("ScreenGui");
            descendant.Activated:Connect(function() -- Line: 405
                -- upvalues: u52 (copy)
                u52.Enabled = false;
            end);
        end;
    end;

    for i = 1, 8 do
        local u53 = SlotTemplate:Clone();
        u53.LayoutOrder = i;
        u53.Gift.Visible = true;
        u53.Parent = ScrollingFrame;
        u53.Activated:Connect(function() -- Line: 418
            -- upvalues: u1 (ref), i (copy)
            u1.Slot:Fire((`Slot{i}`));
        end);
        Gift:RegisterButton(u53.Gift.Gift, ProductIds.StyleSlots[`Slot{i}Gift`]);
        u53.Outfit.Activated:Connect(function() -- Line: 422
            -- upvalues: PlayerData (ref), i (copy), PlrStyles (ref), KnitClient (ref)
            if PlayerData.Data.StyleSlots.MaxSlot < i then
                return;
            end;

            local v54 = PlayerData.Data.StyleSlots[`Slot{i}`];

            if not PlrStyles[v54] then
                return;
            end;

            KnitClient.GetController("Customization"):OpenForStyleOutfit(v54);
        end);

        local function update() -- Line: 433
            -- upvalues: u5 (ref), u11 (ref), loadSlotTemplate (ref), u53 (copy), PlayerData (ref), i (copy)
            if u5 then
                u11:Wait();
            end;

            loadSlotTemplate(u53, {
                style = PlayerData.Data.StyleSlots[`Slot{i}`],
                slotOwned = i <= PlayerData.Data.StyleSlots.MaxSlot,
                slotId = i,
                locked = PlayerData.Data.StyleSlots.Locked[`Slot{i}`] == true,
                equipped = PlayerData.Data.StyleSlots.SlotEquipped == `Slot{i}`
            });
        end;

        PlayerData:Observe({ "StyleSlots", (`Slot{i}`) }, update);
        PlayerData:Observe({ "StyleSlots", "MaxSlot" }, update);
        PlayerData:Observe({ "StyleSlots", "SlotEquipped" }, update);
        PlayerData:Observe({ "StyleSlots", "Locked" }, update);
        PlayerData:Observe({ "StyleQuestData" }, update);
        workspace:GetAttributeChangedSignal("RefreshSlotPrices"):Connect(update);
        local _ = i;
    end;

    for i, v in PlrStyles do
        if v.Rarity == "Limited" then
            local u55 = SlotTemplate:Clone();
            u55.SizeConstraint = Enum.SizeConstraint.RelativeXX;
            u55.Size = UDim2.fromScale(0.22, 0.22);
            u55.Gift.Visible = false;
            u55.Parent = Items;
            u55.Activated:Connect(function() -- Line: 468
                -- upvalues: u1 (ref), i (copy)
                u1.EquipLimited:Fire(i);
            end);

            local function v58() -- Line: 472
                -- upvalues: loadSlotTemplate (ref), u55 (copy), i (copy), PlayerData (ref)
                local v56 = {
                    style = i
                };
                local v57;

                if PlayerData.Data.StyleSlots.SlotEquipped == "Slot0" then
                    v57 = PlayerData.Data.StyleSlots.Slot0 == i;
                else
                    v57 = false;
                end;

                v56.equipped = v57;
                loadSlotTemplate(u55, v56);
                u55.Visible = PlayerData.Data.StyleSlots.LimitedInventory[i] and true or false;
            end;

            PlayerData:Observe({ "StyleSlots", "LimitedInventory", i }, v58);
            PlayerData:Observe({ "StyleSlots", "SlotEquipped" }, v58);
            PlayerData:Observe({ "StyleSlots", "Slot0" }, v58);
        end;
    end;

    Style.BG.Limiteds.Activated:Connect(function() -- Line: 491
        -- upvalues: LimitedInventory (ref), u25 (ref)
        local v59 = LimitedInventory;

        for _, v in u25 do
            if v == v59 then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    PlayerData:Observe({ "StyleSlots" }, function() -- Line: 496
        -- upvalues: u5 (ref), u10 (ref), PlayerData (ref)
        if u5 then
            return;
        end;

        u10:SetShownStyle(PlayerData.Data.StyleSlots[PlayerData.Data.StyleSlots.SlotEquipped]);
    end);

    local function setupSpinButton(u60: userdata, u61: string, u62: table) -- Line: 504
        -- upvalues: u5 (ref), PlayerData (ref), Popup (ref), LocalPlayer (ref), PlrStyles (ref), Rarities (ref), u1 (ref), u4 (ref), u10 (ref), u7 (ref), u6 (ref)
        local u63 = false;
        local u64 = 0;
        u60.Activated:Connect(function() -- Line: 512
            -- upvalues: u64 (ref), u5 (ref), PlayerData (ref), Popup (ref), LocalPlayer (ref), PlrStyles (ref), Rarities (ref), u63 (ref), u1 (ref), u61 (copy), u4 (ref), u10 (ref), u7 (ref), u6 (ref)
            if time() - u64 < 0.5 then
                return;
            end;

            u64 = time();

            if u5 then
                return;
            end;

            if PlayerData.Data.StyleSlots.SlotEquipped == "Slot0" then
                Popup.Popup(LocalPlayer, "You have no slot selected!");

                return;
            end;

            if PlayerData.Data.Settings.SpinOffWarning then
                local Rarity = PlrStyles[PlayerData.Data.StyleSlots[PlayerData.Data.StyleSlots.SlotEquipped]].Rarity;

                if Rarities[Rarity].Priority >= Rarities.Mythic.Priority then
                    if not u63 then
                        u63 = true;
                        Popup.Popup(LocalPlayer, string.format("This is a \"%s\" — tap again to confirm!", Rarity:upper()));
                        task.delay(2, function() -- Line: 544
                            -- upvalues: u63 (ref)
                            u63 = false;
                        end);

                        return;
                    end;

                    u63 = false;
                end;
            end;

            u5 = true;
            local success, result = pcall(function() -- Line: 558
                -- upvalues: u1 (ref), u61 (ref)
                return u1:SpinStyle(u61);
            end);
            u5 = false;

            if not (success and result) then
                return;
            end;

            if not u4 then
                u10:PerformSpinAnimation(u61, result);

                return;
            end;

            if u7 then
                u7:Stop();
                u7 = nil;
            end;

            u6 = nil;

            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.Anchored = false;
            end;

            u10:OnAcquired(result);
        end);
        u60.Label.Text = u62.get();
        PlayerData:Listen(u62.watch, function() -- Line: 577
            -- upvalues: u60 (copy), u62 (copy)
            u60.Label.Text = u62.get();
        end);
    end;

    local u65 = LocalPlayer:GetAttribute("RNGRestricted") == true;
    setupSpinButton(Style.BG.Spin, "Normal", {
        watch = { { "Spins" }, { "Money" } },

        get = function() -- Line: 586, Name: get
            -- upvalues: u65 (copy), PlayerData (ref), Style (ref)
            if u65 then
                if PlayerData.Data.Spins == 0 then
                    Style.BG.SpinsLeft.Text = `BUYS LEFT: {PlayerData.Data.Money // 2500}`;

                    return "BUY $2,500";
                end;

                Style.BG.SpinsLeft.Text = "";

                return `BUY ({PlayerData.Data.Spins})`;
            end;

            if PlayerData.Data.Spins == 0 then
                Style.BG.SpinsLeft.Text = `SPINS LEFT: {PlayerData.Data.Money // 2500}`;

                return "SPIN $2,500";
            end;

            Style.BG.SpinsLeft.Text = "";

            return `SPINS LEFT: {PlayerData.Data.Spins}`;
        end
    });
    setupSpinButton(Style.BG.LuckySpins, "Lucky", {
        watch = { "LuckySpins" },

        get = function() -- Line: 607, Name: get
            -- upvalues: Style (ref), PlayerData (ref), u65 (copy)
            Style.BG.BuyLuckySpins2.Visible = PlayerData.Data.LuckySpins < 100;

            if u65 then
                return `PREMIUM BUY ({PlayerData.Data.LuckySpins})`;
            end;

            return `LUCKY SPINS: {PlayerData.Data.LuckySpins}`;
        end
    });

    if StyleEventData.Enabled and LocalPlayer:GetAttribute("RNGRestricted") ~= true then
        setupSpinButton(Style.BG.EventSpins, "Event", {
            watch = {
                { "EventSpins" },
                { StyleEventData.Event }
            },

            get = function() -- Line: 619, Name: get
                -- upvalues: PlayerData (ref), StyleEventData (ref)
                local v66 = PlayerData.Data.EventSpins[StyleEventData.Event];

                return `{string.upper(StyleEventData.SPIN_DISPLAY_NAME)} SPINS: {v66}`;
            end
        });
    end;

    local function setSkipping(p67) -- Line: 628
        -- upvalues: u4 (ref), Style (ref)
        u4 = p67;
        Style.BG.SkipSpins.Label.Text = `SKIP SPINS: {p67 and "ON" or "OFF"}`;
    end;

    local v68 = u3;
    u4 = v68;
    Style.BG.SkipSpins.Label.Text = `SKIP SPINS: {v68 and "ON" or "OFF"}`;
    Style.BG.SkipSpins.Activated:Connect(function() -- Line: 633
        -- upvalues: u3 (ref), PlayerData (ref), u4 (ref), Style (ref), MarketplaceService (ref), LocalPlayer (ref), Gamepasses (ref)
        if not (u3 or PlayerData.Data.Gamepasses.SkipSpins) then
            MarketplaceService:PromptGamePassPurchase(LocalPlayer, Gamepasses.SkipSpins.ID);

            return;
        end;

        local v69 = not u4;
        u4 = v69;
        Style.BG.SkipSpins.Label.Text = `SKIP SPINS: {v69 and "ON" or "OFF"}`;
    end);

    if LocalPlayer:GetAttribute("RNGRestricted") == nil then
        LocalPlayer:GetAttributeChangedSignal("RNGRestricted"):Wait();
    end;

    local u70 = LocalPlayer:GetAttribute("RNGRestricted") == true;
    local v71 = (function() -- Line: 652, Name: findRevampFrame
        -- upvalues: Style (ref)
        for _, v in { Style.BG.Rarities, Style.BG } do
            for _, child in v:GetChildren() do
                if child.Name == "Revamp" and child:IsA("Frame") then
                    return child;
                end;
            end;
        end;

        return nil;
    end)();
    local u72;

    if v71 then
        u72 = v71:FindFirstChild("ScrollingFrame");
    else
        u72 = v71;
    end;

    local u73 = {
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
    local u74 = {
        Normal = {},
        Lucky = {}
    };
    local u75 = "Normal";

    local function updateRevampList() -- Line: 680
        -- upvalues: u72 (copy), u74 (copy), u75 (ref), u73 (copy), Style (ref)
        if not u72 then
            return;
        end;

        local v76 = u74[u75] or {};

        for i = 1, 5 do
            local v77 = u72:FindFirstChild((tostring(i)));
            local v78;

            if v77 then
                local v79 = v76[i];

                if v79 then
                    local Text = v77:FindFirstChild("Text");

                    if Text then
                        Text.Text = v79.Name;
                    end;

                    local v80 = u73[v79.Rarity];

                    if v80 then
                        v77.Image = v80.Image;
                        v77.ImageColor3 = v80.ImageColor3;
                    end;

                    local v81 = v77:FindFirstChildWhichIsA("UIGradient");

                    if v81 then
                        v81:Destroy();
                    end;

                    local v82 = Style.BG.Rarities.ScrollingFrame:FindFirstChild(v79.Rarity);

                    if v82 then
                        local v83 = v82:FindFirstChildWhichIsA("UIGradient");

                        if v83 then
                            v83:Clone().Parent = v77;
                            v78 = i;
                        else
                            v78 = i;
                        end;
                    else
                        v78 = i;
                    end;
                else
                    local Text = v77:FindFirstChild("Text");

                    if Text then
                        Text.Text = "";
                    end;

                    v77.Image = "";
                    v78 = i;
                end;
            else
                v78 = i;
            end;
        end;
    end;

    if u70 then
        if v71 then
            v71.Visible = true;
        end;

        if v71 then
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
            TextButton.Parent = v71;
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
            TextLabel.Parent = v71;
            local u84 = false;
            TextButton.Activated:Connect(function() -- Line: 773
                -- upvalues: u84 (ref), TextLabel (copy)
                u84 = not u84;
                TextLabel.Visible = u84;
            end);
            TextButton.MouseEnter:Connect(function() -- Line: 777
                -- upvalues: TextLabel (copy)
                TextLabel.Visible = true;
            end);
            TextButton.MouseLeave:Connect(function() -- Line: 780
                -- upvalues: TextLabel (copy), u84 (ref)
                TextLabel.Visible = u84;
            end);
        end;

        task.spawn(function() -- Line: 786
            -- upvalues: u1 (ref), u74 (copy), updateRevampList (copy)
            local PrerolledStyles = u1:GetPrerolledStyles();

            if type(PrerolledStyles) == "table" then
                u74.Normal = PrerolledStyles.Normal or {};
                u74.Lucky = PrerolledStyles.Lucky or {};
                updateRevampList();
            end;
        end);
        u1.PrerolledUpdate:Connect(function(p85) -- Line: 795
            -- upvalues: u74 (copy), updateRevampList (copy)
            if type(p85) == "table" then
                u74.Normal = p85.Normal or {};
                u74.Lucky = p85.Lucky or {};
            end;

            updateRevampList();
        end);
        Style:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 803
            -- upvalues: Style (ref), updateRevampList (copy)
            if Style.Enabled then
                updateRevampList();
            end;
        end);
    elseif v71 then
        v71.Visible = false;
    end;

    local u86 = "Normal";
    local u87 = nil;
    local u88 = {};
    local u89 = {};
    local Rarities2 = Style.BG:FindFirstChild("Rarities");

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

    local function updateChanceList() -- Line: 838
        -- upvalues: u89 (copy), StylesLotteryController (ref), u86 (ref), u70 (copy), LimitedStyleDrop (ref), FormatNumber (ref), u88 (copy), StyleEventData (ref), PlrStyles (ref), u87 (ref), u8 (ref), Style (ref)
        for i, v in u89 do
            if StylesLotteryController.RarityCanBeSpun(u86, i) then
                v.Visible = true;
            else
                v.Visible = false;
            end;

            if u70 then
                v.Text.Text = v:GetAttribute("DisplayName") or i:upper();
            else
                local Text = v.Text;
                local v90 = v:GetAttribute("DisplayName") or i:upper();
                local v91 = (StylesLotteryController.GetRarityChance(i, u86) or 0) * 100;
                Text.Text = `{v90} - [{math.floor(v91) / 100}%]`;
            end;

            if i == LimitedStyleDrop.Rarity and LimitedStyleDrop.IsActive() then
                local Text = v.Text;
                local Text2 = Text.Text;
                local AdaptiveClockString = FormatNumber.AdaptiveClockString;
                local v92 = LimitedStyleDrop.GetEndTime() - os.time();
                Text.Text = Text2 .. ` - {AdaptiveClockString((math.max(0, v92)))}`;
            end;
        end;

        for i, v in u88 do
            local v93 = StyleEventData.Enabled and table.find(StyleEventData.Styles, i) and "Event" or PlrStyles[i].Rarity;
            local v94;

            if v93 == LimitedStyleDrop.Rarity then
                if u86 == "Lucky" then
                    v94 = LimitedStyleDrop.IsRollable(i);
                else
                    v94 = false;
                end;
            else
                v94 = not PlrStyles[i].Unobtainable;
            end;

            if v93 == u87 and (v94 and StylesLotteryController.RarityCanBeSpun(u86, v93)) then
                v.Visible = true;
            else
                v.Visible = false;
            end;

            local StyleChance = StylesLotteryController.GetStyleChance(v93, u86, u8 == i);
            local v95;

            if StyleChance < 0.1 then
                v95 = math.floor(StyleChance * 10000) / 10000;
            else
                v95 = math.floor(StyleChance * 100) / 100;
            end;

            local v96 = u8 == i and "🟢 " or "";

            if u70 then
                v.Text = `{v96}{i}`;
            else
                v.Text = `{v96}{i} - {v95}%`;
            end;
        end;

        if not u70 then
            if u86 == "Normal" then
                Style.BG.BuySpins.Visible = true;
                Style.BG.BuyLuckySpins.Visible = false;
                Style.BG.BuyLuckySpins2.Visible = true;
                Style.BG.BuyEventSpins.Visible = true;
                Style.BG.BuyEventSpins2.Visible = false;
            elseif u86 == "Event" then
                Style.BG.BuySpins.Visible = false;
                Style.BG.BuyLuckySpins.Visible = false;
                Style.BG.BuyLuckySpins2.Visible = true;
                Style.BG.BuyEventSpins.Visible = true;
                Style.BG.BuyEventSpins2.Visible = true;
            else
                Style.BG.BuySpins.Visible = false;
                Style.BG.BuyLuckySpins.Visible = true;
                Style.BG.BuyLuckySpins2.Visible = true;
                Style.BG.BuyEventSpins.Visible = true;
                Style.BG.BuyEventSpins2.Visible = false;
            end;
        end;

        if not StyleEventData.Enabled then
            Style.BG.BuyEventSpins.Visible = false;
            Style.BG.BuyEventSpins2.Visible = false;
        end;
    end;

    local Event = ScrollingFrame2:FindFirstChild("Event");

    if StyleEventData.Enabled then
        Event:SetAttribute("DisplayName", StyleEventData.RarityDisplay);
    else
        Event.Visible = false;
    end;

    local function createStyleButtons(p97, u98) -- Line: 934
        -- upvalues: ReplicatedStorage (ref), Rarities (ref), PlrStyles (ref), ScrollingFrame2 (ref), u70 (copy), u1 (ref), u8 (ref), Popup (ref), LocalPlayer (ref), updateChanceList (copy), u88 (copy)
        local v99 = ReplicatedStorage.Assets.UI.Item:Clone();
        v99.LayoutOrder = Rarities[p97 or PlrStyles[u98].Rarity].Priority * 100 + 5;
        v99.TextXAlignment = Enum.TextXAlignment.Right;
        v99.Parent = ScrollingFrame2;
        v99.Activated:Connect(function() -- Line: 939
            -- upvalues: u70 (ref), u1 (ref), u98 (copy), u8 (ref), Popup (ref), LocalPlayer (ref), updateChanceList (ref)
            if not u70 then
                u1:SetTargetRollStyle(u98);
                u8 = u98;
                Popup.Popup(LocalPlayer, (`Selected "{u98}"! Chances increased slightly.`));
            end;

            updateChanceList();
        end);
        u88[u98] = v99;
    end;

    for i in PlrStyles do
        local Enabled = StyleEventData.Enabled;

        if Enabled then
            Enabled = table.find(StyleEventData.Styles, i) and "Event";
        end;

        createStyleButtons(Enabled, i);
    end;

    for i in Rarities do
        local v100 = ScrollingFrame2:FindFirstChild(i);

        if v100 then
            v100.LayoutOrder = Rarities[i].Priority * 100;
            v100.Activated:Connect(function() -- Line: 962
                -- upvalues: u87 (ref), i (copy), updateChanceList (copy)
                local v101;

                if u87 == i then
                    v101 = nil;
                else
                    v101 = i;
                end;

                u87 = v101;
                updateChanceList();
            end);
            u89[i] = v100;
        end;
    end;

    updateChanceList();
    script_LimitedStyleCountdown(Style, updateChanceList);

    local function setEventButtonState(p102) -- Line: 973
        -- upvalues: u70 (copy), Style (ref)
        if u70 then
            p102 = false;
        end;

        Style.BG.Rarities.EventOdds.Visible = p102;
        Style.BG.EventSpins.Visible = p102;
        Style.BG.BuyEventSpins.Visible = p102;
    end;

    local Enabled = StyleEventData.Enabled;

    if u70 then
        Enabled = false;
    end;

    Style.BG.Rarities.EventOdds.Visible = Enabled;
    Style.BG.EventSpins.Visible = Enabled;
    Style.BG.BuyEventSpins.Visible = Enabled;
    Style.BG.Rarities.EventOdds.Activated:Connect(function() -- Line: 983
        -- upvalues: u86 (ref), u87 (ref), updateChanceList (copy)
        u86 = "Event";
        u87 = nil;
        updateChanceList();
    end);
    Style.BG.Rarities.LuckyOdds.Activated:Connect(function() -- Line: 990
        -- upvalues: u86 (ref), u87 (ref), u75 (ref), updateChanceList (copy), updateRevampList (copy)
        u86 = "Lucky";
        u87 = nil;
        u75 = "Lucky";
        updateChanceList();
        updateRevampList();
    end);
    Style.BG.Rarities.Odds.Activated:Connect(function() -- Line: 998
        -- upvalues: u86 (ref), u87 (ref), u75 (ref), updateChanceList (copy), updateRevampList (copy)
        u86 = "Normal";
        u87 = nil;
        u75 = "Normal";
        updateChanceList();
        updateRevampList();
    end);
    local Revamp = Style.BG.Rarities:FindFirstChild("Revamp");

    if Revamp then
        Revamp.Visible = false;
    end;

    if u70 then
        local Text = Style.BG.Rarities.Odds:FindFirstChild("Text");

        if Text and Text:IsA("TextLabel") then
            Text.Text = "NORMAL";
        end;

        local Text2 = Style.BG.Rarities.LuckyOdds:FindFirstChild("Text");

        if Text2 and Text2:IsA("TextLabel") then
            Text2.Text = "PREMIUM";
        end;
    end;

    local function updateLockState() -- Line: 1019
        -- upvalues: PlayerData (ref), Style (ref)
        local StyleSlots = PlayerData.Data.StyleSlots;

        if StyleSlots.SlotEquipped == "Slot0" then
            Style.BG.LockSlot.Visible = false;

            return;
        end;

        Style.BG.LockSlot.Visible = true;

        if StyleSlots.Locked[StyleSlots.SlotEquipped] then
            Style.BG.LockSlot.Image = "rbxassetid://110336058460550";
            Style.BG.LockSlot.Text.Text = "UNLOCK";

            return;
        end;

        Style.BG.LockSlot.Image = "rbxassetid://72009258674014";
        Style.BG.LockSlot.Text.Text = "LOCK";
    end;

    Style.BG.LockSlot.Activated:Connect(function() -- Line: 1037
        -- upvalues: u5 (ref), PlayerData (ref), Popup (ref), LocalPlayer (ref), u1 (ref)
        if u5 then
            return;
        end;

        local StyleSlots = PlayerData.Data.StyleSlots;

        if StyleSlots.Locked[StyleSlots.SlotEquipped] then
            Popup.Popup(LocalPlayer, (`Unlocked {StyleSlots.SlotEquipped}`));
            u1.LockSlot:Fire(StyleSlots.SlotEquipped, false);

            return;
        end;

        Popup.Popup(LocalPlayer, (`Locked {StyleSlots.SlotEquipped}`));
        u1.LockSlot:Fire(StyleSlots.SlotEquipped, true);
    end);
    PlayerData:Listen({ "StyleSlots" }, updateLockState);
    updateLockState();

    local function loadStore(p103, u104) -- Line: 1056
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref), getProductInfo (ref), Gift (ref)
        for _, v in p103 do
            if v:IsA("GuiObject") then
                local Name = v.Name;
                v.Button.Activated:Connect(function() -- Line: 1063
                    -- upvalues: MarketplaceService (ref), LocalPlayer (ref), u104 (copy), Name (copy)
                    MarketplaceService:PromptProductPurchase(LocalPlayer, u104[`Buy{Name}`]);
                end);

                if not u104[`Buy{Name}`] then
                    warn(p103, Name);
                end;

                task.spawn(function() -- Line: 1069
                    -- upvalues: v (copy), getProductInfo (ref), u104 (copy), Name (copy)
                    v.Button.Text.Text = "Buy";
                    local v105 = getProductInfo(u104[`Buy{Name}`], Enum.InfoType.Product);
                    v.Button.Text.Text = `{v105.PriceInRobux}`;
                end);

                if v:FindFirstChild("Gift") then
                    Gift:RegisterButton(v.Gift, u104[`Gift{Name}`]);
                end;
            end;
        end;
    end;

    task.spawn(function() -- Line: 1080
        -- upvalues: ProductIds (ref), ABTests (ref), Players (ref), loadStore (copy), Style (ref)
        local table_clone_ret = table.clone(ProductIds.LuckySpins);
        local Attribute = ABTests.GetAttribute(Players.LocalPlayer, "LuckySpinsVariant", "Control");

        if Attribute == "Variant1" then
            table_clone_ret.Buy1 = 3463902645;
            table_clone_ret.Buy5 = 3463902895;
            table_clone_ret.Buy20 = 3463903315;
        elseif Attribute == "Variant2" then
            table_clone_ret.Buy1 = 3463903761;
            table_clone_ret.Buy5 = 3463904362;
            table_clone_ret.Buy20 = 3463904890;
        end;

        loadStore(Style.BuyLucky.Frame:GetChildren(), table_clone_ret);
    end);
    loadStore(Style.BuySpins.Frame:GetChildren(), ProductIds.NormalSpins);
    loadStore(Style.BuyMoney.Frame:GetChildren(), ProductIds.Money);
    loadStore(Style.BuyEventSpins.Frame:GetChildren(), ProductIds.EventSpins);

    if u70 then
        local Text = Style.BG.BuyLuckySpins:FindFirstChild("Text");

        if Text and Text:IsA("TextLabel") then
            Text.Text = "BUY PREMIUM BUYS";
        end;

        for _, child in Style.BuyLucky.Frame:GetChildren() do
            if child:IsA("GuiObject") then
                local v106 = tonumber(child.Name) or 0;
                local Text2 = child:FindFirstChild("Text");

                if Text2 and Text2:IsA("TextLabel") then
                    Text2.Text = string.format("%d PREMIUM %s", v106, v106 == 1 and "BUY" or "BUYS");
                end;
            end;
        end;

        local Text2 = Style.BG.BuySpins:FindFirstChild("Text");

        if Text2 and Text2:IsA("TextLabel") then
            Text2.Text = "BUY BUYS";
        end;

        for _, descendant in Style.BuySpins:GetDescendants() do
            if descendant:IsA("TextLabel") and (descendant.Name == "Title" or (descendant.Name == "Header" or descendant.Name == "Name")) then
                descendant.Text = "BUYS";
            end;
        end;

        for _, child in Style.BuySpins.Frame:GetChildren() do
            if child:IsA("GuiObject") then
                local v107 = tonumber(child.Name) or 0;
                local Text3 = child:FindFirstChild("Text");

                if Text3 and Text3:IsA("TextLabel") then
                    Text3.Text = string.format("%d %s", v107, v107 == 1 and "BUY" or "BUYS");
                end;
            end;
        end;
    end;

    PlayerData:Observe({ "Money" }, function(p108) -- Line: 1142
        -- upvalues: Style (ref), Essentials (ref)
        Style.BG.Money.Currency.Text = `{Essentials:formatNumberWithCommas(p108)}`;
    end);
    Style.BG.BuySpins.Activated:Connect(function() -- Line: 1146
        -- upvalues: Style (ref), u25 (ref)
        local BuySpins = Style.BuySpins;

        for _, v in u25 do
            if v == BuySpins then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    Style.BG.BuyLuckySpins.Activated:Connect(function() -- Line: 1149
        -- upvalues: Style (ref), u25 (ref)
        local BuyLucky = Style.BuyLucky;

        for _, v in u25 do
            if v == BuyLucky then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    Style.BG.BuyLuckySpins2.Activated:Connect(function() -- Line: 1152
        -- upvalues: Style (ref), u25 (ref)
        local BuyLucky = Style.BuyLucky;

        for _, v in u25 do
            if v == BuyLucky then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    Style.BG.Money.Activated:Connect(function() -- Line: 1155
        -- upvalues: Style (ref), u25 (ref)
        local BuyMoney = Style.BuyMoney;

        for _, v in u25 do
            if v == BuyMoney then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    Style.BG.BuyEventSpins.Activated:Connect(function() -- Line: 1158
        -- upvalues: Style (ref), u25 (ref)
        local BuyEventSpins = Style.BuyEventSpins;

        for _, v in u25 do
            if v == BuyEventSpins then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);
    Style.BG.BuyEventSpins2.Activated:Connect(function() -- Line: 1161
        -- upvalues: Style (ref), u25 (ref)
        local BuyEventSpins = Style.BuyEventSpins;

        for _, v in u25 do
            if v == BuyEventSpins then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end);

    for _, v in {
        LimitedInventory.Close2,
        Style.BuyLucky.Exit,
        Style.BuySpins.Exit,
        Style.BuyMoney.Exit,
        Style.BuyEventSpins.Exit
    } do
        v.Activated:Connect(function() -- Line: 1172
            -- upvalues: u25 (ref)
            for _, v2 in u25 do
                if v2 == nil then
                    v2.Visible = true;
                else
                    v2.Visible = false;
                end;
            end;
        end);
    end;

    task.spawn(function() -- Line: 1177
        -- upvalues: Style (ref), FormatNumber (ref)
        while true do
            local SaleTag = Style.BG.Slots.SaleTag;
            local Attribute = workspace:GetAttribute("SlotsDiscountTimer");

            if Attribute and DateTime.now().UnixTimestamp < Attribute then
                SaleTag.Visible = true;
                SaleTag.Sale.Text = `Sale: {workspace:GetAttribute("SlotsDiscountRate") or 25}%`;
                SaleTag.Timer.Text = FormatNumber.LongClockString(Attribute - DateTime.now().UnixTimestamp);
            else
                SaleTag.Visible = false;
            end;

            task.wait(1);
        end;
    end);
    Style:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1193
        -- upvalues: AnimationController (ref), u25 (ref), u9 (ref), Style (ref), ABTests (ref), LocalPlayer (ref), KnitClient (ref)
        AnimationController:StopAnims();

        for _, v in u25 do
            if v == nil then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;

        if u9 then
            return;
        end;

        if not Style.Enabled and ABTests.GetAttributeAsync(LocalPlayer, "StarterPack.PromptLocation", "OpeningUI") == "AfterClosingStyleUI" then
            task.delay(0.5, function() -- Line: 1201
                -- upvalues: KnitClient (ref)
                KnitClient.GetController("StarterPackInterface"):PromptStarterPackForABTest();
            end);
        end;
    end);
end;

return u10;