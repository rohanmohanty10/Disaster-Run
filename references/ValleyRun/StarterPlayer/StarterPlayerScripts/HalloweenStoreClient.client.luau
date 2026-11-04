 

 

local Players = game:GetService("Players");
local ProximityPromptService = game:GetService("ProximityPromptService");
local MarketplaceService = game:GetService("MarketplaceService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local Game = ChickenOrHero:WaitForChild("Game");
local HalloweenShopConfig = require(Game:WaitForChild("HalloweenShopConfig"));
local u1 = nil;

local function screenModule() -- Line: 22
    -- upvalues: u1 (ref), Presentation (copy)
    u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));

    return u1;
end;

local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local SkinCatalog = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("SkinCatalog"));
local EmoteCatalog = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local CrateCatalog = require(ChickenOrHero:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
local u2 = {
    Common = Color3.fromRGB(190, 190, 200),
    Rare = Color3.fromRGB(80, 160, 255),
    Epic = Color3.fromRGB(180, 90, 255),
    Legendary = Color3.fromRGB(255, 196, 40),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local u3 = {
    Unavailable = "This feature is currently not available.",
    Unknown = "This feature is currently not available.",
    InMatch = "You can only shop in the lobby.",
    TooFar = "Walk back to the shop to buy that.",
    Loading = "Your data is still loading. Try again in a moment.",
    Busy = "Still finishing your last purchase.",
    Owned = "You already own that.",
    Restricted = "Candy corn can\'t be bought in your region. Earn it in matches!",
    GemsFull = "Make room in your gem wallet first.",
    Poor = "You don\'t have enough for that yet.",
    Failed = "That didn\'t go through. Check your balance and try again."
};
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = false;
local u8 = false;
local u9 = {};
local u10 = {
    live = false,
    balance = 0,
    endsAt = nil,
    restricted = true,
    owned = {},
    free = {}
};
local u11 = nil;

local function notice(p12) -- Line: 66
    -- upvalues: u1 (ref), Presentation (copy)
    u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
    u1.notice(p12);
end;

local function live() -- Line: 70
    -- upvalues: u4 (ref)
    local v13;

    if u4 == nil then
        v13 = false;
    else
        v13 = u4:GetAttribute("Live") == true;
    end;

    return v13;
end;

local u14 = {};
local u15 = nil;
local u16 = nil;

local function itemOf(p17) -- Line: 77
    -- upvalues: u14 (ref)
    for _, v in u14 do
        if v.id == p17 then
            return v;
        end;
    end;

    return nil;
end;

local u18 = nil;

local function show() -- Line: 88
    -- upvalues: u18 (ref), Presentation (copy)
    if u18 == nil then
        local HalloweenCrateShow = Presentation:FindFirstChild("HalloweenCrateShow");
        local v19, v20;

        if HalloweenCrateShow then
            v19, v20 = pcall(require, HalloweenCrateShow);
        else
            v19 = false;
            v20 = nil;
        end;

        if not v19 then
            v20 = false;
        end;

        u18 = v20;
    end;

    return u18 or nil;
end;

local function rotationKey(p21) -- Line: 102
    -- upvalues: HalloweenShopConfig (copy)
    local v22, v23 = HalloweenShopConfig.rotation(p21);

    return v22.id .. "|" .. v23.id;
end;

local function stock() -- Line: 106
    -- upvalues: HalloweenShopConfig (copy), u15 (ref), u14 (ref)
    local v24 = workspace:FindFirstChild(HalloweenShopConfig.Store);
    local v25 = {};
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v26, v27 = HalloweenShopConfig.rotation(ServerTimeNow);
    u15 = v26.id .. "|" .. v27.id;

    for _, v in HalloweenShopConfig.stock(ServerTimeNow) do
        local table_clone_ret = table.clone(v);

        if type(v.model) == "string" then
            local v28;

            if v24 then
                v28 = v24:FindFirstChild(v.model) or nil;
            else
                v28 = nil;
            end;

            table_clone_ret.model = v28;
        end;

        table.insert(v25, table_clone_ret);
    end;

    u14 = v25;

    return v25;
end;

local function paint() -- Line: 123
    -- upvalues: u5 (ref), u10 (copy), u14 (ref)
    if not u5 then
        return;
    end;

    u5:setBalance(u10.balance);

    if u5.plusButton then
        u5.plusButton.Visible = not u10.restricted;
    end;

    if u10.restricted then
        u5:showPacks(false);
    end;

    for _, v in u14 do
        u5:setOwned(v.id, u10.owned[v.id] == true);

        if u5.setFree then
            u5:setFree(v.id, u10.free[v.id]);
        end;
    end;

    if u5.setEndsAt then
        u5:setEndsAt(u10.endsAt);
    end;
end;

local function prompts() -- Line: 148
    -- upvalues: HalloweenShopConfig (copy)
    local v29 = workspace:FindFirstChild(HalloweenShopConfig.Store);
    local v30 = {};

    for _, v in v29 and v29:GetDescendants() or {} do
        if v:IsA("ProximityPrompt") then
            table.insert(v30, v);
        end;
    end;

    return v30;
end;

local function showPrompts() -- Line: 158
    -- upvalues: u7 (ref), LocalPlayer (copy), prompts (copy)
    local v31 = not u7 and LocalPlayer:GetAttribute("InMatch") ~= true;

    for _, v in prompts() do
        v.Enabled = v31;
    end;
end;

local function release(p32) -- Line: 165
    -- upvalues: u9 (copy), u5 (ref)
    u9[p32] = nil;

    if u5 then
        u5:setBusy(p32, false);
    end;
end;

local function buy(u33) -- Line: 172
    -- upvalues: u14 (ref), HalloweenShopConfig (copy), u1 (ref), Presentation (copy), u4 (ref), u10 (copy), u5 (ref), u9 (copy)
    local v34 = nil;

    for _, v in u14 do
        if v.id == u33 then
            v34 = v;
            break;
        end;
    end;

    if not v34 then
        return;
    end;

    if type(v34.price) ~= "number" then
        local v35 = HalloweenShopConfig.ComingSoon or "This feature is currently not available.";
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice(v35);

        return;
    end;

    local v36;

    if u4 == nil then
        v36 = false;
    else
        v36 = u4:GetAttribute("Live") == true;
    end;

    if not v36 then
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice("This feature is currently not available.");

        return;
    end;

    local v37;

    if type(u10.free[u33]) == "number" then
        v37 = u10.free[u33] > 0;
    else
        v37 = false;
    end;

    if not v37 and u10.balance < v34.price then
        if HalloweenShopConfig.Packs and (HalloweenShopConfig.Currency.field ~= "coins" and not u10.restricted) then
            u5:showPacks(true);

            return;
        end;

        local v38 = "You need " .. v34.price - u10.balance .. " more " .. HalloweenShopConfig.Currency.name .. ".";
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice(v38);

        return;
    end;

    local u39 = {};
    u9[u33] = u39;
    u5:setBusy(u33, true);
    u4:FireServer("Buy", u33);
    task.delay(12, function() -- Line: 200
        -- upvalues: u9 (ref), u33 (copy), u39 (copy), u5 (ref)
        if u9[u33] == u39 then
            local v40 = u33;
            u9[v40] = nil;

            if u5 then
                u5:setBusy(v40, false);
            end;
        end;
    end);
end;

local function build() -- Line: 207
    -- upvalues: u5 (ref), u1 (ref), Presentation (copy), u6 (ref), LocalPlayer (copy), HalloweenShopConfig (copy), u11 (ref), buy (copy), u14 (ref), CrateCatalog (copy), EmoteCatalog (copy), SkinCatalog (copy), u2 (copy), MarketplaceService (copy), u10 (copy)
    if u5 then
        return;
    end;

    u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
    u5 = u1.new();
    u6 = Instance.new("ScreenGui");
    u6.Name = "HalloweenShop";
    u6.ResetOnSpawn = false;
    u6.IgnoreGuiInset = true;
    u6.DisplayOrder = 66;
    u6.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    u5.frame.Parent = u6;
    u6.Parent = LocalPlayer:WaitForChild("PlayerGui");
    u5:setCurrency(HalloweenShopConfig.Currency);
    u5.closeButton.Activated:Connect(function() -- Line: 221
        -- upvalues: u11 (ref)
        u11(false);
    end);
    u5.onBuy = buy;

    function u5.onOdds(p41) -- Line: 226
        -- upvalues: u14 (ref), CrateCatalog (ref), u5 (ref), EmoteCatalog (ref), SkinCatalog (ref), u2 (ref)
        local v42 = nil;

        for _, v in u14 do
            if v.id == p41 then
                v42 = v;
                break;
            end;
        end;

        local v43 = v42 and v42.crate and CrateCatalog.get(v42.crate);

        if not (v43 and (type(v43.Entries) == "table" and u5.showOdds)) then
            return;
        end;

        local v44 = 0;

        for _, v in v43.Entries do
            v44 = v44 + (v.Weight or 0);
        end;

        local v45 = {};

        for _, v in v43.Entries do
            local v46 = nil;

            if v.Emote then
                local v47 = EmoteCatalog.get(v.Emote);
                v46 = v47 and v47.Name or v.Emote;
            elseif v.Skin then
                local v48 = SkinCatalog.get(v.Skin);
                v46 = v48 and v48.Name or v.Skin;
            end;

            local v49 = v44 <= 0 and 0 or (v.Weight or 0) / v44 * 100;
            local v50 = {
                name = string.upper((tostring(v46 or "?"))),
                rarity = v.Rarity,
                color = u2[v.Rarity]
            };
            local v51;

            if v49 >= 10 then
                v51 = string.format("%.1f%%", v49);
            else
                v51 = string.format("%.2f%%", v49);
            end;

            v50.percent = v51;
            v50.weight = v.Weight or 0;
            table.insert(v45, v50);
        end;

        table.sort(v45, function(p52, p53) -- Line: 256
            return p52.weight < p53.weight;
        end);
        u5:showOdds({
            title = v42.name or v43.Name,
            rows = v45
        });
    end;

    function u5.onLocked() -- Line: 261
        -- upvalues: u1 (ref), Presentation (ref)
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice("Candy corn can\'t be bought in your region. Earn it in matches!");
    end;

    if HalloweenShopConfig.Packs then
        u5:setPacks(HalloweenShopConfig.Packs);
        task.spawn(function() -- Line: 269
            -- upvalues: HalloweenShopConfig (ref), MarketplaceService (ref), u5 (ref)
            local v54 = false;
            local v55 = {};

            for _, v in HalloweenShopConfig.Packs do
                local table_clone_ret = table.clone(v);
                local v56;

                if HalloweenShopConfig.packProduct then
                    v56 = HalloweenShopConfig.packProduct(v);
                else
                    v56 = v.productId;
                end;

                if type(v56) == "number" and v56 > 0 then
                    local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v56, Enum.InfoType.Product);

                    if success and (type(result) == "table" and type(result.PriceInRobux) == "number") then
                        v54 = v54 or result.PriceInRobux ~= v.robux;
                        table_clone_ret.robux = result.PriceInRobux;
                    elseif not success then
                        warn("[HalloweenShop] price unavailable for " .. v.id .. ": " .. tostring(result));
                    end;
                end;

                table.insert(v55, table_clone_ret);
            end;

            if v54 and u5 then
                u5:setPacks(v55);
            end;
        end);
    end;

    function u5.onBuyPack(p57) -- Line: 290
        -- upvalues: u10 (ref), u5 (ref), u1 (ref), Presentation (ref), HalloweenShopConfig (ref), MarketplaceService (ref), LocalPlayer (ref)
        if not u10.restricted then
            for _, v in HalloweenShopConfig.Packs or {} do
                if v.id == p57 then
                    local v58;

                    if HalloweenShopConfig.packProduct then
                        v58 = HalloweenShopConfig.packProduct(v);
                    else
                        v58 = v.productId;
                    end;

                    if type(v58) == "number" and v58 > 0 then
                        if not pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, LocalPlayer, v58) then
                            u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
                            u1.notice("The purchase window could not open. Please try again.");

                            return;
                        end;
                    else
                        local v59 = HalloweenShopConfig.ComingSoon or "This feature is currently not available.";
                        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
                        u1.notice(v59);
                    end;

                    return;
                end;
            end;

            return;
        end;

        u5:showPacks(false);
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice("Candy corn can\'t be bought in your region. Earn it in matches!");
    end;
end;

u11 = function(p60) -- Line: 313
    -- upvalues: u7 (ref), LocalPlayer (copy), u4 (ref), u1 (ref), Presentation (copy), build (copy), HudNavigation (copy), u5 (ref), stock (copy), paint (copy), u8 (ref), u16 (ref), HalloweenShopConfig (copy), u15 (ref), u9 (copy), prompts (copy)
    if p60 == u7 then
        return;
    end;

    if p60 then
        if LocalPlayer:GetAttribute("InMatch") == true then
            return;
        end;

        local v61;

        if u4 == nil then
            v61 = false;
        else
            v61 = u4:GetAttribute("Live") == true;
        end;

        if not v61 then
            u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
            u1.notice("This feature is currently not available.");

            return;
        end;

        build();
        HudNavigation.opening("HalloweenShop");
        u7 = true;
        LocalPlayer:SetAttribute("HalloweenShopOpen", true);
        u5:setItems((stock()));
        paint();
        u5:opened();
        u5.frame.Visible = u8 == false;
        u4:FireServer("Get");
        local u62 = {};
        u16 = u62;
        task.spawn(function() -- Line: 338
            -- upvalues: u7 (ref), u16 (ref), u62 (copy), u5 (ref), HalloweenShopConfig (ref), u15 (ref), stock (ref), paint (ref)
            while u7 and u16 == u62 do
                task.wait(1);

                if u7 and (u16 == u62 and u5) then
                    local ServerTimeNow = workspace:GetServerTimeNow();
                    local v63, v64 = HalloweenShopConfig.rotation(ServerTimeNow);

                    if v63.id .. "|" .. v64.id ~= u15 then
                        u5:setItems((stock()));
                        paint();
                    end;
                end;
            end;
        end);
    else
        u7 = false;
        u8 = false;
        LocalPlayer:SetAttribute("HalloweenShopOpen", nil);

        for i in u9 do
            u9[i] = nil;

            if u5 then
                u5:setBusy(i, false);
            end;
        end;

        if u5 then
            u5.frame.Visible = false;
            u5:closed();
            u5:setItems({});
        end;
    end;

    local v65 = not u7 and LocalPlayer:GetAttribute("InMatch") ~= true;

    for _, v in prompts() do
        v.Enabled = v65;
    end;
end;

local function bought(p66) -- Line: 365
    -- upvalues: u9 (copy), u5 (ref), u3 (copy), u1 (ref), Presentation (copy), u14 (ref), EmoteCatalog (copy), u18 (ref), LocalPlayer (copy), u8 (ref), u7 (ref), SkinCatalog (copy)
    if type(p66.id) == "string" then
        local id = p66.id;
        u9[id] = nil;

        if u5 then
            u5:setBusy(id, false);
        end;
    end;

    if p66.ok ~= true then
        local v67 = u3[p66.reason] or "That didn\'t go through. Check your balance and try again.";
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice(v67);

        return;
    end;

    local id = p66.id;
    local v68 = nil;

    for _, v in u14 do
        if v.id == id then
            v68 = v;
            break;
        end;
    end;

    if p66.kind == "Title" then
        local v69 = string.upper(v68 and (v68.title or v68.name or "Your new title") or "Your new title") .. " is yours! Wear it from MY TITLES in the Journey.";
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice(v69);

        return;
    end;

    if p66.kind == "Emote" then
        local v70 = EmoteCatalog.get(p66.emote or (v68 and v68.emote or ""));
        local v71 = (v70 and v70.Name or "Your new emote") .. " is yours! It\'s on your emote wheel.";
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice(v71);

        return;
    end;

    local v72;

    if type(p66.prize) == "table" then
        v72 = p66.prize or nil;
    else
        v72 = nil;
    end;

    if not v72 then
        return;
    end;

    if u18 == nil then
        local HalloweenCrateShow = Presentation:FindFirstChild("HalloweenCrateShow");
        local v73, v74;

        if HalloweenCrateShow then
            v73, v74 = pcall(require, HalloweenCrateShow);
        else
            v73 = false;
            v74 = nil;
        end;

        if not v73 then
            v74 = false;
        end;

        u18 = v74;
    end;

    local v75 = u18 or nil;
    local Character = LocalPlayer.Character;

    if v75 and (Character and LocalPlayer:GetAttribute("InMatch") ~= true) then
        local u76 = {};
        u8 = u76;

        if u5 then
            u5.frame.Visible = false;
        end;

        local function back() -- Line: 396
            -- upvalues: u8 (ref), u76 (copy), u7 (ref), u5 (ref)
            if u8 == u76 then
                u8 = false;

                if u7 and (u5 and u5.frame) then
                    u5.frame.Visible = true;
                end;
            end;
        end;

        local v77 = v68 and v68.model or nil;

        if typeof(v77) == "Instance" then
            v77 = v77.Name;
        end;

        local v78 = {
            id = p66.receipt,
            model = v77,
            prize = v72,
            at = workspace:GetServerTimeNow()
        };
        local success, result = pcall(v75.play, v78, Character, {
            mine = true,
            onDone = back
        });

        if success then
            task.delay(15, back);

            return;
        end;

        warn("[HalloweenShop] show failed: " .. tostring(result));

        if u8 == u76 then
            u8 = false;

            if u7 and (u5 and u5.frame) then
                u5.frame.Visible = true;
            end;
        end;
    end;

    local v79;

    if v72.kind == "Knife" then
        v79 = SkinCatalog.get(v72.id);
    else
        v79 = EmoteCatalog.get(v72.id);
    end;

    local v80;

    if v79 then
        v80 = v79.Name;
    else
        v80 = tostring(v72.id);
    end;

    if v72.duplicate then
        local v81 = v80 .. " again: +" .. tostring(v72.gems or 0) .. " gems instead.";
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice(v81);

        return;
    end;

    u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
    u1.notice("You got " .. v80 .. "!");
end;

local function watch(p82) -- Line: 430
    -- upvalues: LocalPlayer (copy), Players (copy), u18 (ref), Presentation (copy)
    if type(p82) ~= "table" or LocalPlayer:GetAttribute("InMatch") == true then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(tonumber(p82.user) or 0);

    if u18 == nil then
        local HalloweenCrateShow = Presentation:FindFirstChild("HalloweenCrateShow");
        local v83, v84;

        if HalloweenCrateShow then
            v83, v84 = pcall(require, HalloweenCrateShow);
        else
            v83 = false;
            v84 = nil;
        end;

        if not v83 then
            v84 = false;
        end;

        u18 = v84;
    end;

    local v85 = u18 or nil;

    if PlayerByUserId and (PlayerByUserId ~= LocalPlayer and (PlayerByUserId.Character and v85)) then
        local success, result = pcall(v85.play, p82, PlayerByUserId.Character, {
            mine = false
        });

        if not success then
            warn("[HalloweenShop] show failed: " .. tostring(result));
        end;
    end;
end;

ProximityPromptService.PromptTriggered:Connect(function(p86, p87) -- Line: 444
    -- upvalues: LocalPlayer (copy), HalloweenShopConfig (copy), u4 (ref), u11 (ref), u1 (ref), Presentation (copy)
    if p87 ~= LocalPlayer then
        return;
    end;

    local v88 = workspace:FindFirstChild(HalloweenShopConfig.Store);

    if v88 and p86:IsDescendantOf(v88) then
        local v89;

        if u4 == nil then
            v89 = false;
        else
            v89 = u4:GetAttribute("Live") == true;
        end;

        if v89 then
            u11(true);

            return;
        end;

        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice("This feature is currently not available.");
    end;
end);
HudNavigation.Opening.Event:Connect(function(p90) -- Line: 457
    -- upvalues: u11 (ref)
    if p90 ~= "HalloweenShop" then
        u11(false);
    end;
end);
ChickenOrHero:WaitForChild("Weapons"):WaitForChild("ArmoryNavigation").Event:Connect(function(p91) -- Line: 464
    -- upvalues: u11 (ref), u7 (ref), u5 (ref), u14 (ref)
    local v92;

    if type(p91) == "string" then
        v92 = p91:match("^HalloweenCrate:(.+)$");
    else
        v92 = false;
    end;

    if not v92 then
        return;
    end;

    u11(true);

    if not (u7 and (u5 and u5.onOdds)) then
        return;
    end;

    for _, v in u14 do
        if v.kind == "Crate" and v.crate == v92 then
            u5.onOdds(v.id);

            return;
        end;
    end;
end);
UserInputService.InputBegan:Connect(function(p93) -- Line: 480
    -- upvalues: u7 (ref), u11 (ref)
    if u7 and p93.KeyCode == Enum.KeyCode.Escape then
        u11(false);
    end;
end);
LocalPlayer:GetAttributeChangedSignal("CandyCorn"):Connect(function() -- Line: 487
    -- upvalues: LocalPlayer (copy), u10 (copy), u5 (ref)
    local Attribute = LocalPlayer:GetAttribute("CandyCorn");

    if type(Attribute) == "number" and Attribute ~= u10.balance then
        u10.balance = Attribute;

        if u5 then
            u5:setBalance(Attribute);
        end;
    end;
end);
LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 496
    -- upvalues: LocalPlayer (copy), u11 (ref), u18 (ref), u7 (ref), prompts (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        u11(false);
        local v94 = u18 or nil;

        if v94 and v94.stopAll then
            v94.stopAll();
        end;
    end;

    local v95 = not u7 and LocalPlayer:GetAttribute("InMatch") ~= true;

    for _, v in prompts() do
        v.Enabled = v95;
    end;
end);
workspace.DescendantAdded:Connect(function(p96) -- Line: 507
    -- upvalues: showPrompts (copy)
    if p96:IsA("ProximityPrompt") then
        task.defer(showPrompts);
    end;
end);
u4 = Game:WaitForChild("HalloweenShopEvent");
u4:GetAttributeChangedSignal("Live"):Connect(function() -- Line: 514
    -- upvalues: u4 (ref), u7 (ref), u11 (ref), u1 (ref), Presentation (copy)
    local v97;

    if u4 == nil then
        v97 = false;
    else
        v97 = u4:GetAttribute("Live") == true;
    end;

    if not v97 and u7 then
        u11(false);
        u1 = u1 or require(Presentation:WaitForChild("HalloweenShopScreen"));
        u1.notice("This feature is currently not available.");
    end;
end);
u4.OnClientEvent:Connect(function(p98, p99) -- Line: 520
    -- upvalues: u10 (copy), paint (copy), bought (copy), watch (copy)
    if type(p99) ~= "table" then
        return;
    end;

    if p98 ~= "State" then
        if p98 == "Bought" then
            bought(p99);

            return;
        end;

        if p98 == "Show" then
            watch(p99);
        end;

        return;
    end;

    u10.live = p99.live == true;
    u10.balance = type(p99.balance) ~= "number" and 0 or p99.balance;
    u10.owned = type(p99.owned) ~= "table" and {} or p99.owned;
    u10.free = type(p99.free) ~= "table" and {} or p99.free;
    local v100;

    if type(p99.endsAt) == "number" then
        v100 = p99.endsAt;
    else
        v100 = nil;
    end;

    u10.endsAt = v100;
    u10.restricted = p99.restricted ~= false;
    paint();
end);
local v101 = not u7 and LocalPlayer:GetAttribute("InMatch") ~= true;

for _, v in prompts() do
    v.Enabled = v101;
end;