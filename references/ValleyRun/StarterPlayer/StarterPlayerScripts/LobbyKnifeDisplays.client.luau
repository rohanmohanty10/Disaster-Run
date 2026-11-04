 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local ShopConfig = require(Weapons:WaitForChild("ShopConfig"));
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local OfferRules = require(Weapons:WaitForChild("OfferRules"));
local KnifeDisplayRig = require(Weapons:WaitForChild("KnifeDisplayRig"));
local Bundles = require(Weapons:WaitForChild("Bundles"));
local Current = Bundles.Current;

local function baseBundleOf(p1) -- Line: 19
    -- upvalues: Bundles (copy), Current (copy)
    if p1 then
        p1 = p1:GetAttribute("BundleKey");
    end;

    return type(p1) == "string" and Bundles.shown(p1) or Current;
end;

local u2 = { "HexflaskBundle", "SoulbinderBundle" };
local u3 = nil;

local function bundleOf(p4) -- Line: 31
    -- upvalues: u3 (ref), Bundles (copy), Current (copy)
    local v5 = p4 ~= nil and p4 == u3 and Bundles.get("HallowreaperBundle");

    if v5 then
        return v5;
    end;

    if p4 then
        p4 = p4:GetAttribute("BundleKey");
    end;

    return type(p4) == "string" and Bundles.shown(p4) or Current;
end;

local BundlePanel = require(Weapons:WaitForChild("BundlePanel"));
local EmoteCatalog = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local ArmoryNavigation = Weapons:WaitForChild("ArmoryNavigation");
local ArmoryEvent = Weapons:WaitForChild("ArmoryEvent");
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local MapLocator = require(ChickenOrHero.Game:WaitForChild("MapLocator"));
local CharacterClone = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("CharacterClone"));
local u6 = {};
local u7 = {};
local u8 = 0;
local u9 = {};

local function countdownLabel(p10) -- Line: 53
    local v11 = p10:IsA("TextLabel") and type(p10:GetAttribute("CountdownOffer")) == "string";

    return v11;
end;

local function watchCountdowns(p12) -- Line: 56
    -- upvalues: u9 (copy)
    local u13 = {
        labels = {}
    };

    for _, descendant in p12:GetDescendants() do
        local v14 = descendant:IsA("TextLabel") and type(descendant:GetAttribute("CountdownOffer")) == "string";

        if v14 then
            u13.labels[descendant] = true;
        end;
    end;

    u13.added = p12.DescendantAdded:Connect(function(p15) -- Line: 59
        -- upvalues: u13 (copy)
        local v16 = p15:IsA("TextLabel") and type(p15:GetAttribute("CountdownOffer")) == "string";

        if v16 then
            u13.labels[p15] = true;
        end;
    end);
    u13.removing = p12.DescendantRemoving:Connect(function(p17) -- Line: 60
        -- upvalues: u13 (copy)
        u13.labels[p17] = nil;
    end);
    u9[p12] = u13;
end;

local function unwatchCountdowns(p18) -- Line: 63
    -- upvalues: u9 (copy)
    local v19 = u9[p18];

    if not v19 then
        return;
    end;

    u9[p18] = nil;
    v19.added:Disconnect();
    v19.removing:Disconnect();
end;

local Folder = Instance.new("Folder");
Folder.Name = "LocalKnifeDisplays";
Folder.Parent = workspace;
local u20 = {};
local u21 = {};
local u22 = {};
local u23 = {};
local u24 = {
    loaded = false,
    owned = {}
};
local u25 = ShopConfig.binding(game.GameId);
local Audio = ChickenOrHero:WaitForChild("Audio");
local table_clone_ret = table.clone(require(Audio.AudioConfig));
table_clone_ret.MaxVoices = 6;
table_clone_ret.MaxOneShotSeconds = 4;
local u26 = require(Audio.AudioPlayback).new(game.SoundService:WaitForChild("GameAudio"), require(Audio.AudioCatalog), table_clone_ret);
u26.folder.Name = "ShowroomAudioPlayback";
local u27 = {
    Balloon = Color3.fromRGB(255, 147, 197),
    Featured = Color3.fromRGB(192, 143, 255),
    Earnable = Color3.fromRGB(119, 194, 255),
    VIP = Color3.fromRGB(246, 202, 102),
    BonkerBundle = Current.Accent
};
local u28 = {
    Balloon = Color3.fromRGB(61, 29, 55),
    Featured = Color3.fromRGB(42, 25, 67),
    Earnable = Color3.fromRGB(18, 43, 67),
    VIP = Color3.fromRGB(57, 43, 22),
    BonkerBundle = Current.Backdrop
};

local function connect(p29, p30) -- Line: 79
    -- upvalues: u22 (copy)
    table.insert(u22, p29:Connect(p30));
end;

local function chooseSwap() -- Line: 81
    -- upvalues: Bundles (copy), u24 (ref), u6 (copy), Current (copy), u2 (copy)
    local v31 = Bundles.get("HallowreaperBundle");

    if not (v31 and (Bundles.isOnSale(v31) and not Bundles.purchased(v31, u24))) then
        return nil;
    end;

    local v32 = {};

    for i in u6 do
        for _, child in i:GetChildren() do
            if child:IsA("Model") and child:GetAttribute("ShopSlot") == "BonkerBundle" then
                local v33;

                if child then
                    v33 = child:GetAttribute("BundleKey");
                else
                    v33 = child;
                end;

                local v34 = type(v33) == "string" and Bundles.shown(v33) or Current;

                if v34.Key == "HallowreaperBundle" then
                    return nil;
                end;

                v32[v34.Key] = v32[v34.Key] or child;
            end;
        end;
    end;

    for _, v in u2 do
        local v35 = v32[v];
        local v36 = Bundles.get(v);

        if v35 and (v36 and Bundles.purchased(v36, u24)) then
            return v35;
        end;
    end;

    for _, v in u2 do
        if v32[v] then
            return v32[v];
        end;
    end;

    return nil;
end;

local u37 = {};
local u38 = true;
local u39 = nil;

local function emoteSound(p40, p41, p42) -- Line: 103
    -- upvalues: EmoteCatalog (copy)
    if not EmoteCatalog.get(p40) then
        return;
    end;

    local v43, v44, v45 = EmoteCatalog.soundIds(p40);

    for i, v in v43 do
        if (not p42 or i == p42) and (p42 or not v45[i]) then
            local Sound = Instance.new("Sound");
            Sound.Name = "EmoteSound";
            Sound.SoundId = v;
            Sound.Volume = v44[i];
            Sound.RollOffMaxDistance = 60;
            Sound.Parent = p41;
            Sound.Ended:Once(function() -- Line: 111
                -- upvalues: Sound (copy)
                Sound:Destroy();
            end);
            game:GetService("Debris"):AddItem(Sound, 12);
            Sound:Play();
        end;
    end;
end;

local u46 = {
    Equip = true,
    Windup = true,
    Swing = true,
    Dive = true,
    Hit = true,
    Sheath = true,
    Cancel = true
};
local u47 = 0;
local u48 = nil;

for _, v in KnifeDisplayRig.Sequence do
    if not v.held or (v.draw or v.reverse) then
        u37[v.label] = true;
    end;
end;

local function aura(u49) -- Line: 118
    -- upvalues: Weapons (copy), u37 (copy)
    local VowbreakerFX = Weapons:FindFirstChild("VowbreakerFX");
    local blade = u49.blade;

    if not (VowbreakerFX and (VowbreakerFX:FindFirstChild("Knife") and (blade and blade:IsA("BasePart")))) then
        return nil;
    end;

    local u50 = VowbreakerFX.Knife:Clone();
    u50.Parent = blade;
    local PetalsPink = u50:FindFirstChild("PetalsPink");

    if PetalsPink then
        PetalsPink.Parent = blade;
    end;

    local function set() -- Line: 124
        -- upvalues: u37 (ref), u49 (copy), u50 (copy), PetalsPink (copy)
        local v51 = not u37[u49.model:GetAttribute("PreviewAction") or "IDLE"];

        for _, child in u50:GetChildren() do
            if child:IsA("ParticleEmitter") or child:IsA("Light") then
                child.Enabled = v51;
            end;
        end;

        if PetalsPink then
            PetalsPink.Enabled = v51;
        end;
    end;

    set();

    return u49.model:GetAttributeChangedSignal("PreviewAction"):Connect(set);
end;

local function comma(p52) -- Line: 132
    local math_floor_ret = math.floor(p52);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function flagshipNamed(p53) -- Line: 135
    -- upvalues: ShopConfig (copy)
    for _, v in ShopConfig.Flagships do
        if v.SkinId == p53 then
            return true;
        end;
    end;

    return false;
end;

local function flagshipOf(p54) -- Line: 139
    -- upvalues: ShopConfig (copy)
    if p54 then
        p54 = p54.Name;
    end;

    for _, v in ShopConfig.Flagships do
        if v.SkinId == p54 then
            return v;
        end;
    end;

    return ShopConfig.featured(workspace:GetServerTimeNow());
end;

local function ownStand(p55) -- Line: 145
    -- upvalues: u6 (copy)
    for i in u6 do
        local v56 = i:FindFirstChild(p55);

        if v56 and v56:GetAttribute("ShopSlot") == "Featured" then
            return true;
        end;
    end;

    return false;
end;

local function covered() -- Line: 154
    -- upvalues: ownStand (copy), ShopConfig (copy)
    return ownStand(ShopConfig.featured(workspace:GetServerTimeNow()).SkinId);
end;

local function info(p57, p58) -- Line: 157
    -- upvalues: ShopConfig (copy), u3 (ref), Bundles (copy), Current (copy)
    if p57 == "Balloon" then
        return "BalloonDagger", nil, "FREE · BRING A FRIEND";
    end;

    if p57 ~= "Featured" then
        if p57 ~= "BonkerBundle" then
            if p57 == "VIP" then
                return ShopConfig.Passes.VIP.RewardSkinId, "VIP", "VIP EXCLUSIVE";
            end;

            return ShopConfig.Earnable.SkinId, nil, "EARN WITH GEMS";
        end;

        local v59 = p58 ~= nil and p58 == u3 and Bundles.get("HallowreaperBundle");

        if not v59 then
            if p58 then
                p58 = p58:GetAttribute("BundleKey");
            end;

            v59 = type(p58) == "string" and Bundles.shown(p58) or Current;
        end;

        return v59.SkinId, nil, "LIMITED BUNDLE";
    end;

    if p58 then
        p58 = p58.Name;
    end;

    local v60;

    for _, v in ShopConfig.Flagships do
        if v.SkinId == p58 then
            v60 = v;
            break;
        end;
    end;

    v60 = ShopConfig.featured(workspace:GetServerTimeNow());

    return v60.SkinId, v60.OfferKey, "ROBUX EXCLUSIVE";
end;

local function permitted() -- Line: 164
    -- upvalues: LocalPlayer (copy)
    local v61;

    if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true) then
        v61 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
    else
        v61 = false;
    end;

    return v61;
end;

local u62 = { "ArmoryOpen", "BalloonOfferOpen", "BundleOfferOpen", "BundleShowcaseOpen", "FootballEventOpen", "TeamEventCelebrating", "EventKnivesOpen" };

local function quiet() -- Line: 171
    -- upvalues: u62 (copy), LocalPlayer (copy)
    for _, v in u62 do
        if LocalPlayer:GetAttribute(v) == true then
            return true;
        end;
    end;

    return false;
end;

local function open(p63, p64) -- Line: 175
    -- upvalues: LocalPlayer (copy), Weapons (copy), u3 (ref), Bundles (copy), Current (copy), BundlePanel (copy), u24 (ref), ArmoryNavigation (copy)
    local v65;

    if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true) then
        v65 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
    else
        v65 = false;
    end;

    if not v65 then
        return;
    end;

    local v66;

    if p64 then
        v66 = p64.Name;
    else
        v66 = p64;
    end;

    if p63 == "Featured" and (v66 == "Football" or v66 == "Futbol") then
        local success, result = pcall(require, Weapons:FindFirstChild("EventKnivesOffer"));

        if success and (type(result) == "table" and (result.active() and result.details(v66))) then
            return;
        end;
    end;

    if p63 ~= "BonkerBundle" then
        ArmoryNavigation:Fire(p63);

        return;
    end;

    local v67 = p64 ~= nil and p64 == u3 and Bundles.get("HallowreaperBundle");

    if not v67 then
        if p64 then
            p64 = p64:GetAttribute("BundleKey");
        end;

        v67 = type(p64) == "string" and Bundles.shown(p64) or Current;
    end;

    BundlePanel.open(Bundles.purchased(v67, u24), v67.Key, "3d_display");
end;

local Color3_fromRGB_ret = Color3.fromRGB(12, 14, 22);
local Color3_fromRGB_ret2 = Color3.fromRGB(96, 222, 128);
local Color3_fromRGB_ret3 = Color3.fromRGB(88, 92, 104);
local u68 = {
    ["NOT ON SALE"] = true,
    ["OFFER ENDED"] = true,
    ["NOT AVAILABLE YET"] = true,
    ["COMING SOON"] = true,
    ["CHECKING PRICE…"] = true
};

local function text(p69, p70, p71, p72, p73, p74, p75) -- Line: 193
    -- upvalues: Color3_fromRGB_ret (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p70;
    TextLabel.Text = p71;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Size = p72;
    TextLabel.Position = p73;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = p75 or Enum.Font.GothamBold;
    TextLabel.TextColor3 = p74;
    TextLabel.TextScaled = true;
    TextLabel.TextWrapped = true;
    TextLabel.TextStrokeTransparency = 0.35;
    TextLabel.TextStrokeColor3 = Color3_fromRGB_ret;
    TextLabel.Parent = p69;

    return TextLabel;
end;

local function panel(p76, p77, p78, p79, p80, p81, p82) -- Line: 199
    local Frame = Instance.new("Frame");
    Frame.Name = p77;
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Size = p78;
    Frame.Position = p79;
    Frame.BackgroundColor3 = p80;
    Frame.BackgroundTransparency = p81 or 0;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p76;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(p82 or 1, 0);
    UICorner.Parent = Frame;

    return Frame;
end;

local function sheen(p83, p84) -- Line: 206
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1), p84);
    UIGradient.Rotation = 90;
    UIGradient.Parent = p83;

    return UIGradient;
end;

local function edge(p85, p86, p87, p88) -- Line: 209
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p86;
    UIStroke.Thickness = p87;
    UIStroke.Transparency = p88 or 0;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = p85;

    return UIStroke;
end;

local function billboard(p89, p90, p91, p92) -- Line: 215
    -- upvalues: ShopConfig (copy), PlayerGui (copy)
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "LobbyKnife_" .. p90;
    BillboardGui.Adornee = p89;
    BillboardGui.Size = UDim2.fromScale(p91.X, p91.Y);
    BillboardGui.StudsOffsetWorldSpace = p92;
    BillboardGui.AlwaysOnTop = false;
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = ShopConfig.Display.MaxDistance;
    BillboardGui.Active = true;
    BillboardGui.ResetOnSpawn = false;
    BillboardGui.Parent = PlayerGui;

    return BillboardGui;
end;

local function priceText(p93) -- Line: 221
    -- upvalues: u3 (ref), Bundles (copy), Current (copy), u24 (ref), OfferRules (copy), u23 (copy), ShopConfig (copy), LocalPlayer (copy), SkinCatalog (copy), u25 (copy)
    if p93.slot == "BonkerBundle" then
        local stand = p93.stand;
        local v94 = stand ~= nil and stand == u3 and Bundles.get("HallowreaperBundle");

        if not v94 then
            if stand then
                stand = stand:GetAttribute("BundleKey");
            end;

            v94 = type(stand) == "string" and Bundles.shown(stand) or Current;
        end;

        if Bundles.purchased(v94, u24) then
            return "OWNED  ·  VIEW";
        end;

        if not OfferRules.active(v94, workspace:GetServerTimeNow()) then
            return "OFFER ENDED";
        end;

        local v95 = u23[Bundles.productId(v94)];

        if v95 == false then
            return "VIEW BUNDLE";
        end;

        if type(v95) ~= "table" then
            return "CHECKING PRICE…";
        end;

        if not v95.IsForSale or type(v95.PriceInRobux) ~= "number" then
            return "NOT ON SALE";
        end;

        local utf8_char_ret = utf8.char(57346);
        local math_floor_ret = math.floor(v95.PriceInRobux);

        return utf8_char_ret .. " " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "  ·  VIEW";
    end;

    local slot = p93.slot;
    local stand = p93.stand;
    local v96, v97;

    if slot == "Balloon" then
        v96 = "BalloonDagger";
        v97 = nil;
    elseif slot == "Featured" then
        if stand then
            stand = stand.Name;
        end;

        local v98;

        for _, v in ShopConfig.Flagships do
            if v.SkinId == stand then
                v98 = v;
                break;
            end;
        end;

        v98 = ShopConfig.featured(workspace:GetServerTimeNow());
        v96 = v98.SkinId;
        v97 = v98.OfferKey;
    elseif slot == "BonkerBundle" then
        local v99 = stand ~= nil and stand == u3 and Bundles.get("HallowreaperBundle");

        if not v99 then
            if stand then
                stand = stand:GetAttribute("BundleKey");
            end;

            v99 = type(stand) == "string" and Bundles.shown(stand) or Current;
        end;

        v96 = v99.SkinId;
        v97 = nil;
    elseif slot == "VIP" then
        v96 = ShopConfig.Passes.VIP.RewardSkinId;
        v97 = "VIP";
    else
        v96 = ShopConfig.Earnable.SkinId;
        v97 = nil;
    end;

    local v100;

    if (u24.owned or {})[v96] == true then
        v100 = true;
    elseif p93.slot == "VIP" then
        v100 = LocalPlayer:GetAttribute("HasVIP") == true;
    else
        v100 = false;
    end;

    if v100 then
        return "OWNED  ·  VIEW";
    end;

    if p93.slot == "Balloon" then
        return "FREE  ·  CLAIM";
    end;

    local v101;

    if p93.slot == "Featured" then
        local stand2 = p93.stand;

        if stand2 then
            stand2 = stand2.Name;
        end;

        for _, v in ShopConfig.Flagships do
            if v.SkinId == stand2 then
                v101 = v;
                break;
            end;
        end;

        v101 = ShopConfig.featured(workspace:GetServerTimeNow());

        if not v101 then
            if p93.slot == "Earnable" then
                v101 = ShopConfig.Earnable;
            else
                v101 = false;
            end;
        end;
    elseif p93.slot == "Earnable" then
        v101 = ShopConfig.Earnable;
    else
        v101 = false;
    end;

    if v101 then
        local v102 = OfferRules.status(v101, workspace:GetServerTimeNow());

        if v102 ~= "Active" then
            return v102 == "Expired" and "OFFER ENDED" or "NOT AVAILABLE YET";
        end;
    end;

    if p93.slot == "Earnable" then
        local v103 = SkinCatalog.get(v96);
        local v104;

        if v103 then
            v104 = v103.Offer;
        else
            v104 = v103;
        end;

        if not (v103 and (v103.Available and (v104 and v104.Currency == "gems"))) then
            return "COMING SOON";
        end;

        local math_floor_ret = math.floor(v104.Price);

        return "◆  " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "  ·  VIEW";
    end;

    local v105 = u25.PassIds[v97];

    if not v105 or v105 <= 0 then
        return "COMING SOON";
    end;

    local v106 = u23[v105];

    if v106 == false then
        return "VIEW IN SHOP";
    end;

    if type(v106) ~= "table" then
        return "CHECKING PRICE…";
    end;

    if not v106.IsForSale then
        return "NOT ON SALE";
    end;

    if type(v106.PriceInRobux) ~= "number" then
        return "VIEW IN SHOP";
    end;

    local math_floor_ret = math.floor(v106.PriceInRobux);

    return " " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "  ·  VIEW";
end;

local function update() -- Line: 255
    -- upvalues: u20 (copy), priceText (copy), u68 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), u27 (copy), u28 (copy), LocalPlayer (copy), ShopConfig (copy), u3 (ref), Bundles (copy), Current (copy), OfferRules (copy)
    for _, v in u20 do
        local v107, v108;
        local v109 = 0;

        while true do
            if v109 == 0 then
                v109 = -1;
                local v110 = priceText(v);

                if v.button.Text ~= v110 then
                    v.button.Text = v110;
                    local v111 = v110:sub(1, 5) == "OWNED";
                    local v112 = u68[v110] == true;
                    v.button.BackgroundColor3 = v111 and Color3_fromRGB_ret2 or v112 and Color3_fromRGB_ret3 or (v.color or u27[v.slot]);
                    v.button.TextColor3 = v111 and Color3.fromRGB(14, 44, 24) or v112 and Color3.fromRGB(228, 231, 238) or (v.dark or u28[v.slot]);
                    v.live = not v111 and not v112;
                end;

                local prompt = v.prompt;
                local v113;

                if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true) then
                    v113 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
                else
                    v113 = false;
                end;

                prompt.Enabled = v113;

                if v.slot ~= "Featured" then
                    v108 = v;
                    v109 = 1;
                    continue;
                end;

                local stand = v.stand;

                if stand then
                    stand = stand.Name;
                end;

                v108 = v;

                for _, v2 in ShopConfig.Flagships do
                    if v2.SkinId == stand then
                        v107 = v2;
                        break;
                    end;
                end;

                v107 = ShopConfig.featured(workspace:GetServerTimeNow());

                if not v107 then
                    v109 = 1;
                    continue;
                end;

                v109 = 2;
                continue;
            elseif v109 == 1 then
                v109 = -1;
                v107 = v108.slot == "Earnable" and ShopConfig.Earnable;

                if not v107 then
                    if v108.slot == "BonkerBundle" then
                        local stand = v108.stand;
                        v107 = stand ~= nil and stand == u3 and Bundles.get("HallowreaperBundle");

                        if not v107 then
                            if stand then
                                stand = stand:GetAttribute("BundleKey");
                            end;

                            v107 = type(stand) == "string" and Bundles.shown(stand) or Current;
                        end;
                    else
                        v107 = false;
                    end;
                end;

                v109 = 2;
                continue;
            elseif v109 == 2 then
                v109 = -1;
                v108.timer.Text = v107 and OfferRules.countdown(v107, workspace:GetServerTimeNow()) or "";
                v108.timerPill.Visible = v108.timer.Text ~= "";
                local button = v108.button;
                local v114;

                if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true) then
                    v114 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
                else
                    v114 = false;
                end;

                button.Interactable = v114;
                v108.button.AutoButtonColor = v108.button.Interactable;
                break;
            else
                break;
            end;
        end;
    end;
end;

local function remove(p115) -- Line: 272
    -- upvalues: u20 (copy), u39 (ref), u26 (copy), KnifeDisplayRig (copy)
    local v116 = u20[p115];

    if not v116 then
        return;
    end;

    u20[p115] = nil;
    v116.activated:Disconnect();
    v116.triggered:Disconnect();

    if v116.aura then
        v116.aura:Disconnect();
    end;

    v116.spin:Cancel();
    v116.pulse:Cancel();

    if v116.newPulse then
        v116.newPulse:Cancel();
    end;

    if u39 == v116 then
        u39 = nil;

        for i in u26.voices do
            u26:remove(i);
        end;
    end;

    for _, v in v116.labels do
        v:Destroy();
    end;

    KnifeDisplayRig.destroy(v116.rig);

    if p115.Parent then
        for i, v in v116.hiddenVisuals or {} do
            if i.Parent then
                i.Transparency = v;
            end;
        end;

        for _, descendant in p115:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = 0;
            end;
        end;
    end;
end;

local function hide(p117) -- Line: 284
    local v118 = {};

    for _, descendant in p117:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = 1;
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            v118[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    return v118;
end;

local function scatter(p119, p120) -- Line: 293
    -- upvalues: u3 (ref), Bundles (copy), Current (copy), ChickenOrHero (copy), Folder (copy)
    local v121 = p119 ~= nil and p119 == u3 and Bundles.get("HallowreaperBundle");

    if not v121 then
        local v122;

        if p119 then
            v122 = p119:GetAttribute("BundleKey");
        else
            v122 = p119;
        end;

        v121 = type(v122) == "string" and Bundles.shown(v122) or Current;
    end;

    local Item = v121.Item;

    if Item then
        Item = ChickenOrHero.Gear.Assets:FindFirstChild(Item);
    end;

    if not (Item and Item:IsA("BasePart")) then
        return nil;
    end;

    local v123 = p119:FindFirstChild("Left Leg");
    local v124 = v123 and (v123:IsA("BasePart") and v123.Position.Y - v123.Size.Y / 2) or p120.Position.Y - 3;
    local Folder2 = Instance.new("Folder");
    Folder2.Name = "BundlePeels";
    local Random_new = Random.new;
    local v125 = math.abs(p120.Position.X) * 7 + math.abs(p120.Position.Z) * 13;
    local v126 = Random_new((math.floor(v125)));

    for i = 1, 9 do
        local v127 = i / 9 * 3.141592653589793 * 2 + v126:NextNumber(-0.25, 0.25);
        local v128 = v126:NextNumber(2.3, 3.5);
        local v129 = Item:Clone();
        v129.Anchored = true;
        v129.CanCollide = false;
        v129.CanQuery = false;
        v129.CanTouch = false;
        v129.CastShadow = false;
        v129.CFrame = CFrame.new(p120.Position.X + math.cos(v127) * v128, v124 + v129.Size.Y / 2, p120.Position.Z + math.sin(v127) * v128) * CFrame.Angles(0, v126:NextNumber(0, 6.283185307179586), 0);
        v129.Parent = Folder2;
        local _ = i;
    end;

    Folder2.Parent = Folder;

    return Folder2;
end;

local function completeStand(p130) -- Line: 311
    for _, v in { "Humanoid", "HumanoidRootPart", "Torso", "Head", "Right Arm", "Left Arm", "Right Leg", "Left Leg" } do
        if not p130:FindFirstChild(v) then
            return false;
        end;
    end;

    return true;
end;

local function add(u131) -- Line: 317
    -- upvalues: u38 (ref), u6 (copy), u27 (copy), completeStand (copy), u21 (copy), add (copy), OfferRules (copy), u3 (ref), Bundles (copy), Current (copy), hide (copy), ShopConfig (copy), ownStand (copy), remove (copy), SkinCatalog (copy), Weapons (copy), KnifeDisplayRig (copy), u48 (ref), Folder (copy), u28 (copy), PlayerGui (copy), panel (copy), Color3_fromRGB_ret (copy), text (copy), TweenService (copy), u39 (ref), LocalPlayer (copy), u62 (copy), emoteSound (copy), u46 (copy), u26 (copy), aura (copy), scatter (copy), open (copy), u20 (copy), update (copy)
    if not (u38 and (u6[u131.Parent] and u131:IsA("Model"))) then
        return;
    end;

    local Attribute = u131:GetAttribute("ShopSlot");

    if not u27[Attribute] then
        return;
    end;

    if not completeStand(u131) then
        if not u21[u131] then
            u21[u131] = true;
            task.spawn(function() -- Line: 325
                -- upvalues: u38 (ref), u6 (ref), u131 (copy), completeStand (ref), u21 (ref), add (ref)
                local v132 = os.clock() + 10;

                while u38 and (u6[u131.Parent] and (not completeStand(u131) and os.clock() < v132)) do
                    task.wait(0.1);
                end;

                u21[u131] = nil;

                if u38 and (u6[u131.Parent] and completeStand(u131)) then
                    add(u131);
                end;
            end);
        end;

        return;
    end;

    if Attribute == "BonkerBundle" then
        local active = OfferRules.active;
        local v133 = u131 ~= nil and u131 == u3 and Bundles.get("HallowreaperBundle");

        if not v133 then
            local v134;

            if u131 then
                v134 = u131:GetAttribute("BundleKey");
            else
                v134 = u131;
            end;

            v133 = type(v134) == "string" and Bundles.shown(v134) or Current;
        end;

        if not active(v133, workspace:GetServerTimeNow()) then
            hide(u131);

            return;
        end;
    end;

    if Attribute == "Featured" then
        local Name = u131.Name;
        local v135 = false;

        for _, v in ShopConfig.Flagships do
            if v.SkinId == Name then
                v135 = true;
                break;
            end;
        end;

        if not v135 and ownStand(ShopConfig.featured(workspace:GetServerTimeNow()).SkinId) then
            remove(u131);
            hide(u131);

            return;
        end;
    end;

    local v136, v137;

    if Attribute == "Balloon" then
        v136 = "BalloonDagger";
        v137 = "FREE · BRING A FRIEND";
    elseif Attribute == "Featured" then
        local v138;

        if u131 then
            v138 = u131.Name;
        else
            v138 = u131;
        end;

        local v139;

        for _, v in ShopConfig.Flagships do
            if v.SkinId == v138 then
                v139 = v;
                break;
            end;
        end;

        v139 = ShopConfig.featured(workspace:GetServerTimeNow());
        v136 = v139.SkinId;
        local _ = v139.OfferKey;
        v137 = "ROBUX EXCLUSIVE";
    elseif Attribute == "BonkerBundle" then
        local v140 = u131 ~= nil and u131 == u3 and Bundles.get("HallowreaperBundle");

        if not v140 then
            local v141;

            if u131 then
                v141 = u131:GetAttribute("BundleKey");
            else
                v141 = u131;
            end;

            v140 = type(v141) == "string" and Bundles.shown(v141) or Current;
        end;

        v136 = v140.SkinId;
        v137 = "LIMITED BUNDLE";
    elseif Attribute == "VIP" then
        v136 = ShopConfig.Passes.VIP.RewardSkinId;
        v137 = "VIP EXCLUSIVE";
    else
        v136 = ShopConfig.Earnable.SkinId;
        v137 = "EARN WITH GEMS";
    end;

    local u142 = SkinCatalog.get(v136);
    local v143;

    if u142 then
        v143 = Weapons.Models:FindFirstChild(u142.Model);
    else
        v143 = u142;
    end;

    local success, result = pcall(KnifeDisplayRig.create, u48 or u131, u131, v143);

    if not success then
        warn("Lobby knife display:", result);

        return;
    end;

    remove(u131);
    result.model.Parent = Folder;
    local v144 = hide(u131);
    local v145 = Attribute == "BonkerBundle";
    local v146;

    if v145 then
        local v147 = u131 ~= nil and u131 == u3 and Bundles.get("HallowreaperBundle");

        if not v147 then
            local v148;

            if u131 then
                v148 = u131:GetAttribute("BundleKey");
            else
                v148 = u131;
            end;

            v147 = type(v148) == "string" and Bundles.shown(v148) or Current;
        end;

        v146 = v147.Emote or nil;
    else
        v146 = nil;
    end;

    KnifeDisplayRig.animate(result, ({
        Balloon = 14,
        Earnable = 1,
        Featured = 4,
        VIP = 9,
        BonkerBundle = 1
    })[Attribute], v136, v146 and { v146 } or nil, v145);
    local v149 = u27[Attribute];
    local v150 = u28[Attribute];

    if Attribute == "BonkerBundle" then
        local v151 = u131 ~= nil and u131 == u3 and Bundles.get("HallowreaperBundle");

        if not v151 then
            local v152;

            if u131 then
                v152 = u131:GetAttribute("BundleKey");
            else
                v152 = u131;
            end;

            v151 = type(v152) == "string" and Bundles.shown(v152) or Current;
        end;

        v149 = v151.Accent or v149;
        local v153 = u131 ~= nil and u131 == u3 and Bundles.get("HallowreaperBundle");

        if not v153 then
            local v154;

            if u131 then
                v154 = u131:GetAttribute("BundleKey");
            else
                v154 = u131;
            end;

            v153 = type(v154) == "string" and Bundles.shown(v154) or Current;
        end;

        v150 = v153.Backdrop or v150;
    end;

    local root = result.root;
    local Vector2_new_ret = Vector2.new(6.6, 2.8);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "LobbyKnife_" .. Attribute .. "_Title";
    BillboardGui.Adornee = root;
    BillboardGui.Size = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 4.9, 0);
    BillboardGui.AlwaysOnTop = false;
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = ShopConfig.Display.MaxDistance;
    BillboardGui.Active = true;
    BillboardGui.ResetOnSpawn = false;
    BillboardGui.Parent = PlayerGui;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Glow";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://129028976496842";
    ImageLabel.ImageColor3 = v149;
    ImageLabel.ImageTransparency = 0.4;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(1.3, 1.7);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.52);
    ImageLabel.ZIndex = 0;
    ImageLabel.Parent = BillboardGui;
    local v155 = panel(BillboardGui, "Badge", UDim2.fromScale(0.66, 0.2), UDim2.fromScale(0.5, 0.11), v149);
    v155.ZIndex = 3;
    local v156 = v149:Lerp(Color3_fromRGB_ret, 0.35);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1), v156);
    UIGradient.Rotation = 90;
    UIGradient.Parent = v155;
    local v157 = text(v155, "Category", v137, UDim2.fromScale(0.9, 0.74), UDim2.fromScale(0.5, 0.5), v150, Enum.Font.GothamBlack);
    v157.TextStrokeTransparency = 1;
    v157.ZIndex = 4;
    local v158 = panel(BillboardGui, "Plate", UDim2.fromScale(1, 0.52), UDim2.fromScale(0.5, 0.5), v150, 0.08, 0.22);
    v158.ZIndex = 1;
    local Color3_fromRGB_ret4 = Color3.fromRGB(120, 120, 130);
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3_fromRGB_ret4);
    UIGradient2.Rotation = 90;
    UIGradient2.Parent = v158;
    local UIGradient3 = Instance.new("UIGradient");
    UIGradient3.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v149), ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, v149) });
    local Color3_new_ret = Color3.new(1, 1, 1);
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_new_ret;
    UIStroke.Thickness = 2;
    UIStroke.Transparency = 0;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = v158;
    UIGradient3.Parent = UIStroke;
    text(v158, "KnifeName", u142 and (u142.Name or "NEXT GEM KNIFE") or "NEXT GEM KNIFE", UDim2.fromScale(0.92, 0.56), UDim2.fromScale(0.5, 0.38), Color3.new(1, 1, 1), Enum.Font.GothamBlack).ZIndex = 2;
    local v159 = text(v158, "DemoAction", "PREVIEW · IDLE", UDim2.fromScale(0.86, 0.24), UDim2.fromScale(0.5, 0.79), Color3.fromRGB(214, 219, 228));
    v159.ZIndex = 2;
    local v160 = panel(BillboardGui, "TimerPill", UDim2.fromScale(0.58, 0.19), UDim2.fromScale(0.5, 0.89), v150, 0.05);
    v160.ZIndex = 3;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = v149;
    UIStroke2.Thickness = 1.5;
    UIStroke2.Transparency = 0;
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke2.Parent = v160;
    local v161 = text(v160, "OfferTimer", "", UDim2.fromScale(0.88, 0.7), UDim2.fromScale(0.5, 0.5), v149);
    v161.ZIndex = 4;
    local root2 = result.root;
    local Vector2_new_ret2 = Vector2.new(4.4, 0.95);
    local v162 = result.root.CFrame.LookVector * 0.9 + Vector3.new(0, -2.8, 0);
    local BillboardGui2 = Instance.new("BillboardGui");
    BillboardGui2.Name = "LobbyKnife_" .. Attribute .. "_Price";
    BillboardGui2.Adornee = root2;
    BillboardGui2.Size = UDim2.fromScale(Vector2_new_ret2.X, Vector2_new_ret2.Y);
    BillboardGui2.StudsOffsetWorldSpace = v162;
    BillboardGui2.AlwaysOnTop = false;
    BillboardGui2.LightInfluence = 0;
    BillboardGui2.MaxDistance = ShopConfig.Display.MaxDistance;
    BillboardGui2.Active = true;
    BillboardGui2.ResetOnSpawn = false;
    BillboardGui2.Parent = PlayerGui;
    BillboardGui2.AlwaysOnTop = true;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "ViewOffer";
    TextButton.AnchorPoint = Vector2.new(0.5, 0.5);
    TextButton.Position = UDim2.fromScale(0.5, 0.5);
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.BackgroundColor3 = v149;
    TextButton.BorderSizePixel = 0;
    TextButton.Text = "";
    TextButton.TextColor3 = v150;
    TextButton.Font = Enum.Font.GothamBlack;
    TextButton.TextScaled = true;
    TextButton.Parent = BillboardGui2;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = TextButton;
    local Color3_fromRGB_ret5 = Color3.fromRGB(175, 175, 175);
    local UIGradient4 = Instance.new("UIGradient");
    UIGradient4.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3_fromRGB_ret5);
    UIGradient4.Rotation = 90;
    UIGradient4.Parent = TextButton;
    local Color3_new_ret2 = Color3.new(1, 1, 1);
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = Color3_new_ret2;
    UIStroke3.Thickness = 2;
    UIStroke3.Transparency = 0.15;
    UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke3.Parent = TextButton;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0.08, 0);
    UIPadding.PaddingRight = UDim.new(0.08, 0);
    UIPadding.PaddingTop = UDim.new(0.2, 0);
    UIPadding.PaddingBottom = UDim.new(0.2, 0);
    UIPadding.Parent = TextButton;
    local v163 = TweenService:Create(UIGradient3, TweenInfo.new(2.6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Rotation = 360
    });
    local v164 = TweenService:Create(UIStroke3, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.7
    });
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Name = "ViewKnife";
    ProximityPrompt.ActionText = Attribute == "Balloon" and "Get free dagger" or (Attribute == "BonkerBundle" and "View bundle" or "View in shop");
    local v165;

    if Attribute == "BonkerBundle" then
        local v166 = u131 ~= nil and u131 == u3 and Bundles.get("HallowreaperBundle");

        if not v166 then
            local v167;

            if u131 then
                v167 = u131:GetAttribute("BundleKey");
            else
                v167 = u131;
            end;

            v166 = type(v167) == "string" and Bundles.shown(v167) or Current;
        end;

        v165 = v166.Name or (u142 and (u142.Name or "Gem knives") or "Gem knives");
    else
        v165 = u142 and (u142.Name or "Gem knives") or "Gem knives";
    end;

    ProximityPrompt.ObjectText = v165;
    ProximityPrompt.MaxActivationDistance = ShopConfig.Display.PromptDistance;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.HoldDuration = 0;
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
    ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonX;
    ProximityPrompt.Exclusivity = Enum.ProximityPromptExclusivity.OneGlobally;
    ProximityPrompt.UIOffset = Vector2.new(0, 70);
    ProximityPrompt.Parent = result.root;
    local u168 = {
        live = false,
        spinning = false,
        pulsing = false,
        color = v149,
        dark = v150,
        slot = Attribute,
        stand = u131,
        skin = v136,
        rig = result,
        labels = { BillboardGui, BillboardGui2 },
        button = TextButton,
        prompt = ProximityPrompt,
        timer = v161,
        timerPill = v160,
        demo = v159,
        hiddenVisuals = v144,
        spin = v163,
        pulse = v164,
        ring = UIStroke3
    };

    if Attribute == "Featured" then
        local Name = u131.Name;
        local v169 = false;

        for _, v in ShopConfig.Flagships do
            if v.SkinId == Name then
                v169 = true;
                break;
            end;
        end;

        if not v169 then
            local isNew = ShopConfig.isNew;
            local v170;

            if u131 then
                v170 = u131.Name;
            else
                v170 = u131;
            end;

            local v171;

            for _, v in ShopConfig.Flagships do
                if v.SkinId == v170 then
                    v171 = v;
                    break;
                end;
            end;

            v171 = ShopConfig.featured(workspace:GetServerTimeNow());

            if isNew(v171, workspace:GetServerTimeNow()) then
                local root3 = result.root;
                local Vector2_new_ret3 = Vector2.new(4.2, 1.7);
                local BillboardGui3 = Instance.new("BillboardGui");
                BillboardGui3.Name = "LobbyKnife_" .. Attribute .. "_New";
                BillboardGui3.Adornee = root3;
                BillboardGui3.Size = UDim2.fromScale(Vector2_new_ret3.X, Vector2_new_ret3.Y);
                BillboardGui3.StudsOffsetWorldSpace = Vector3.new(0, 7.3, 0);
                BillboardGui3.AlwaysOnTop = false;
                BillboardGui3.LightInfluence = 0;
                BillboardGui3.MaxDistance = ShopConfig.Display.MaxDistance;
                BillboardGui3.Active = true;
                BillboardGui3.ResetOnSpawn = false;
                BillboardGui3.Parent = PlayerGui;
                local v172 = text(BillboardGui3, "New", "NEW", UDim2.fromScale(1, 1), UDim2.fromScale(0.5, 0.5), Color3.fromRGB(255, 214, 48), Enum.Font.GothamBlack);
                v172.TextStrokeTransparency = 0;
                v172.TextStrokeColor3 = Color3.fromRGB(60, 36, 0);
                local UIScale = Instance.new("UIScale");
                UIScale.Parent = v172;
                u168.newPulse = TweenService:Create(UIScale, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    Scale = 1.12
                });
                table.insert(u168.labels, BillboardGui3);
            end;
        end;
    end;

    function u168.cue(p173) -- Line: 393
        -- upvalues: u39 (ref), u168 (copy), LocalPlayer (ref), u62 (ref), emoteSound (ref), result (copy), u142 (copy), u46 (ref), u26 (ref)
        if u39 == u168 then
            local v174;

            if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true) then
                v174 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
            else
                v174 = false;
            end;

            if v174 then
                local v175 = false;

                for _, v in u62 do
                    if LocalPlayer:GetAttribute(v) == true then
                        v175 = true;
                        break;
                    end;
                end;

                if not v175 then
                    local v176, v177 = p173:match("^EmoteSound:([^:]+):?(%d*)$");

                    if v176 then
                        emoteSound(v176, result.root, (tonumber(v177)));

                        return;
                    end;

                    local v178 = u142 and (p173 == "Hit" and u142.HitSoundProfile or (u142.SoundProfile or "BaseDagger")) or "BaseDagger";
                    local v179;

                    if u46[p173] then
                        v179 = "Knife_" .. v178 .. "_" .. p173 or p173;
                    else
                        v179 = p173;
                    end;

                    u26:one(v179, result.root, u46[p173] and 0.65 or 0.2);
                end;
            end;
        end;
    end;

    if Attribute == "BonkerBundle" then
        u168.fixedDemo = true;
        v159.RichText = true;
        local v180 = u131 ~= nil and u131 == u3 and Bundles.get("HallowreaperBundle");

        if not v180 then
            local v181;

            if u131 then
                v181 = u131:GetAttribute("BundleKey");
            else
                v181 = u131;
            end;

            v180 = type(v181) == "string" and Bundles.shown(v181) or Current;
        end;

        if v180.Ability == "BrokenVow" then
            u168.aura = aura(result);
        end;

        v159.Text = v180.StandLine;
        local v182 = v180.Item and scatter(u131, result.root);

        if v182 then
            table.insert(u168.labels, v182);
        end;
    end;

    u168.activated = TextButton.Activated:Connect(function() -- Line: 409
        -- upvalues: open (ref), Attribute (copy), u131 (copy)
        open(Attribute, u131);
    end);
    u168.triggered = ProximityPrompt.Triggered:Connect(function() -- Line: 410
        -- upvalues: open (ref), Attribute (copy), u131 (copy)
        open(Attribute, u131);
    end);
    u20[u131] = u168;
    update();
end;

local function rebuild() -- Line: 413
    -- upvalues: u6 (copy), add (copy)
    for i in u6 do
        for _, child in i:GetChildren() do
            add(child);
        end;
    end;
end;

local function reswap() -- Line: 417
    -- upvalues: chooseSwap (copy), u3 (ref), u6 (copy), add (copy)
    local v183 = chooseSwap();

    if v183 == u3 then
        return;
    end;

    local v184 = u3;
    u3 = v183;

    for _, v in { v184, v183 } do
        if v and (v.Parent and u6[v.Parent]) then
            add(v);
        end;
    end;
end;

local function refreshStands() -- Line: 423
    -- upvalues: MapLocator (copy), u8 (ref), u7 (copy), Folder (copy), u9 (copy), watchCountdowns (copy), u6 (copy), u20 (copy), remove (copy), add (copy), u21 (copy), reswap (copy)
    local v185 = {};
    local v186 = MapLocator.lobby();

    if v186 then
        v186 = v186:FindFirstChild("KnifeDisplays") or v186:FindFirstChild("Interactables");
    end;

    if v186 then
        v185[v186] = true;
    end;

    if u8 <= os.clock() then
        u8 = os.clock() + 2;
        table.clear(u7);
        local v187 = {};

        for _, child in workspace:GetChildren() do
            local v188;

            if child == Folder then
                v188 = false;
            else
                v188 = child:FindFirstChild("CharacterDisplays");
            end;

            if v188 then
                table.insert(u7, v188);
                v187[child] = true;

                if not u9[child] then
                    watchCountdowns(child);
                end;
            end;
        end;

        for i in u9 do
            if not v187[i] then
                local v189 = u9[i];

                if v189 then
                    u9[i] = nil;
                    v189.added:Disconnect();
                    v189.removing:Disconnect();
                end;
            end;
        end;
    end;

    for _, v in u7 do
        if v.Parent then
            v185[v] = true;
        end;
    end;

    for i, v in u6 do
        if not v185[i] then
            u6[i] = nil;
            v[1]:Disconnect();
            v[2]:Disconnect();
            local v190 = i;
            local v191 = {};

            for i2, _ in u20 do
                if i2.Parent == v190 or not i2.Parent then
                    table.insert(v191, i2);
                end;
            end;

            for _, v2 in v191 do
                remove(v2);
            end;
        end;
    end;

    for i in v185 do
        if not u6[i] then
            u6[i] = { i.ChildAdded:Connect(add), i.ChildRemoved:Connect(remove) };
        end;

        for _, child in i:GetChildren() do
            if not (u20[child] or u21[child]) then
                add(child);
            end;
        end;
    end;

    reswap();
end;

local function expire() -- Line: 455
    -- upvalues: u20 (copy), OfferRules (copy), u3 (ref), Bundles (copy), Current (copy), remove (copy), hide (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();

    for i, v in u20 do
        if v.slot == "BonkerBundle" then
            local active = OfferRules.active;
            local v192 = i ~= nil and i == u3 and Bundles.get("HallowreaperBundle");

            if not v192 then
                local v193;

                if i then
                    v193 = i:GetAttribute("BundleKey");
                else
                    v193 = i;
                end;

                v192 = type(v193) == "string" and Bundles.shown(v193) or Current;
            end;

            if not active(v192, ServerTimeNow) then
                remove(i);
                hide(i);
            end;
        end;
    end;
end;

local function dress(u194) -- Line: 461
    -- upvalues: u47 (ref), CharacterClone (copy), u38 (ref), LocalPlayer (copy), Players (copy), u48 (ref), rebuild (copy)
    u47 = u47 + 1;
    local u195 = u47;
    task.spawn(function() -- Line: 463
        -- upvalues: u194 (copy), CharacterClone (ref), u38 (ref), u195 (copy), u47 (ref), LocalPlayer (ref), Players (ref), u48 (ref), rebuild (ref)
        local Humanoid = u194:WaitForChild("Humanoid", 8);

        if not Humanoid then
            return;
        end;

        local v196 = nil;

        for i = 1, CharacterClone.RETRIES do
            local v197 = os.clock() + 8;

            while u38 and (u195 == u47 and (LocalPlayer.Character == u194 and (not LocalPlayer:HasAppearanceLoaded() and os.clock() < v197))) do
                task.wait(0.1);
            end;

            if not (u38 and (u195 == u47 and LocalPlayer.Character == u194)) then
                return;
            end;

            local success, result = pcall(function() -- Line: 470
                -- upvalues: Humanoid (copy), Players (ref)
                local AppliedDescription = Humanoid:GetAppliedDescription();
                local v198 = Players:CreateHumanoidModelFromDescriptionAsync(AppliedDescription, Enum.HumanoidRigType.R6);
                AppliedDescription:Destroy();

                return v198;
            end);

            if not u38 or u195 ~= u47 then
                if success and result then
                    result:Destroy();
                end;

                return;
            end;

            if success and CharacterClone.dressed(result) then
                if u48 then
                    u48:Destroy();
                end;

                u48 = result;
                rebuild();

                return;
            end;

            if success and result then
                result:Destroy();
            end;

            v196 = success and "the avatar came out blank" or result;

            if i < CharacterClone.RETRIES then
                task.wait(CharacterClone.RETRY_SECONDS);
            end;
        end;

        warn("Lobby avatar preview unavailable; keeping display rigs:", v196);
    end);
end;

refreshStands();
table.insert(u22, LocalPlayer.CharacterAdded:Connect(dress));
table.insert(u22, ArmoryEvent.OnClientEvent:Connect(function(p199, p200) -- Line: 489
    -- upvalues: u24 (ref), reswap (copy), update (copy)
    if p199 == "State" and type(p200) == "table" then
        u24 = p200;
        reswap();
        update();
    end;
end));
local OnClientEvent = Audio:WaitForChild("Events").OnClientEvent;
table.insert(u22, OnClientEvent:Connect(function(p201, p202) -- Line: 491
    -- upvalues: u20 (copy), KnifeDisplayRig (copy)
    local v203 = p201 == "DisplayBonk" and u20[p202];

    if v203 then
        KnifeDisplayRig.strike(v203.rig);
    end;
end));

for _, v in { "HasVIP", "ClientReady", "InMatch", "ScreenPresentationActive", "AdminRefreshActive" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u22, AttributeChangedSignal:Connect(update));
end;

local u204 = 0;
local SkinId = ShopConfig.featured(workspace:GetServerTimeNow()).SkinId;
local u205 = ShopConfig.isNew(ShopConfig.featured(workspace:GetServerTimeNow()), workspace:GetServerTimeNow());
local u206 = false;
table.insert(u22, RunService.PreAnimation:Connect(function() -- Line: 499
    -- upvalues: u20 (copy), KnifeDisplayRig (copy)
    for _, v in u20 do
        KnifeDisplayRig.preAnimation(v.rig);
    end;
end));
table.insert(u22, RunService.PreSimulation:Connect(function(p207) -- Line: 500
    -- upvalues: u204 (ref), refreshStands (copy), expire (copy), u26 (copy), update (copy), u9 (copy), ShopConfig (copy), OfferRules (copy), ownStand (copy), SkinId (ref), u205 (ref), u206 (ref), rebuild (copy), LocalPlayer (copy), u20 (copy), u62 (copy), u39 (ref), KnifeDisplayRig (copy)
    u204 = u204 + p207;

    if u204 > 0.2 then
        u204 = 0;
        refreshStands();
        expire();
        u26:update();
        update();

        for _, v in u9 do
            for i in v.labels do
                local v208 = ShopConfig.flagship(i:GetAttribute("CountdownOffer"));
                local v209 = v208 and OfferRules.countdown(v208, workspace:GetServerTimeNow()) or "";

                if v209 == "OFFER ENDED" and type(i:GetAttribute("CountdownEnded")) == "string" then
                    v209 = i:GetAttribute("CountdownEnded");
                end;

                if i.Text ~= v209 then
                    i.Text = v209;
                end;
            end;
        end;

        local v210 = ShopConfig.featured(workspace:GetServerTimeNow());
        local v211 = ShopConfig.isNew(v210, workspace:GetServerTimeNow());
        local v212 = ownStand(ShopConfig.featured(workspace:GetServerTimeNow()).SkinId);

        if v210.SkinId ~= SkinId or (v211 ~= u205 or v212 ~= u206) then
            SkinId = v210.SkinId;
            u205 = v211;
            u206 = v212;
            rebuild();
        end;

        local v213 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
        local SoundDistance = ShopConfig.Display.SoundDistance;
        local v214 = nil;

        for _, v in u20 do
            local v215 = v213 and ((v213.Position - v.rig.root.Position).Magnitude or (1 / 0)) or (1 / 0);
            v.near = v215 < ShopConfig.Display.AnimationDistance;
            local v216;

            if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true) then
                v216 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
            else
                v216 = false;
            end;

            if v216 then
                v216 = v215 < ShopConfig.Display.MaxDistance;
            end;

            if v216 ~= v.spinning then
                v.spinning = v216;

                if v216 then
                    v.spin:Play();
                else
                    v.spin:Pause();
                end;

                if v.newPulse then
                    if v216 then
                        v.newPulse:Play();
                    else
                        v.newPulse:Pause();
                    end;
                end;
            end;

            if v216 then
                v216 = v.live;
            end;

            if v216 ~= v.pulsing then
                v.pulsing = v216;

                if v216 then
                    v.pulse:Play();
                else
                    v.pulse:Cancel();
                    v.ring.Transparency = 0.15;
                end;
            end;

            local v217;

            if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true) then
                v217 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
            else
                v217 = false;
            end;

            if v217 then
                local v218 = v;
                local v219 = false;

                for _, v2 in u62 do
                    if LocalPlayer:GetAttribute(v2) == true then
                        v219 = true;
                        break;
                    end;
                end;

                if not v219 and v215 < SoundDistance then
                    v214 = v218;
                    SoundDistance = v215;
                end;
            end;
        end;

        if v214 ~= u39 then
            for i in u26.voices do
                u26:remove(i);
            end;

            u39 = v214;
        end;
    end;

    for _, v in u20 do
        KnifeDisplayRig.step(v.rig, v.near ~= false, p207, u39 == v, v.cue);

        if not v.fixedDemo then
            local v220 = "PREVIEW · " .. (v.rig.model:GetAttribute("PreviewAction") or "IDLE");

            if v.demo.Text ~= v220 then
                v.demo.Text = v220;
            end;
        end;
    end;
end));
rebuild();

if LocalPlayer.Character then
    local Character = LocalPlayer.Character;
    u47 = u47 + 1;
    local u221 = u47;
    task.spawn(function() -- Line: 463
        -- upvalues: Character (copy), CharacterClone (copy), u38 (ref), u221 (copy), u47 (ref), LocalPlayer (copy), Players (copy), u48 (ref), rebuild (copy)
        local Humanoid = Character:WaitForChild("Humanoid", 8);

        if not Humanoid then
            return;
        end;

        local v222 = nil;

        for i = 1, CharacterClone.RETRIES do
            local v223 = os.clock() + 8;

            while u38 and (u221 == u47 and (LocalPlayer.Character == Character and (not LocalPlayer:HasAppearanceLoaded() and os.clock() < v223))) do
                task.wait(0.1);
            end;

            if not (u38 and (u221 == u47 and LocalPlayer.Character == Character)) then
                return;
            end;

            local success, result = pcall(function() -- Line: 470
                -- upvalues: Humanoid (copy), Players (ref)
                local AppliedDescription = Humanoid:GetAppliedDescription();
                local v224 = Players:CreateHumanoidModelFromDescriptionAsync(AppliedDescription, Enum.HumanoidRigType.R6);
                AppliedDescription:Destroy();

                return v224;
            end);

            if not u38 or u221 ~= u47 then
                if success and result then
                    result:Destroy();
                end;

                return;
            end;

            if success and CharacterClone.dressed(result) then
                if u48 then
                    u48:Destroy();
                end;

                u48 = result;
                rebuild();

                return;
            end;

            if success and result then
                result:Destroy();
            end;

            v222 = success and "the avatar came out blank" or result;

            if i < CharacterClone.RETRIES then
                task.wait(CharacterClone.RETRY_SECONDS);
            end;
        end;

        warn("Lobby avatar preview unavailable; keeping display rigs:", v222);
    end);
end;

ArmoryEvent:FireServer("Get");
task.spawn(function() -- Line: 549
    -- upvalues: ShopConfig (copy), u25 (copy), u23 (copy), MarketplaceService (copy), u38 (ref), update (copy), Bundles (copy)
    local v225 = { "VIP" };

    for _, v in ShopConfig.Flagships do
        table.insert(v225, v.OfferKey);
    end;

    for _, v in v225 do
        local v226 = u25.PassIds[v];

        if v226 and (v226 > 0 and u23[v226] == nil) then
            local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v226, Enum.InfoType.GamePass);

            if not u38 then
                return;
            end;

            u23[v226] = success and result and result or false;
            update();
        end;
    end;

    for _, v in Bundles.shopList() do
        if u23[Bundles.productId(v)] == nil then
            local GetProductInfoAsync = MarketplaceService.GetProductInfoAsync;
            local v227 = Bundles.productId(v);
            local success, result = pcall(GetProductInfoAsync, MarketplaceService, v227, Enum.InfoType.Product);

            if not u38 then
                return;
            end;

            if not success then
                warn("[" .. v.Key .. "] stand price unavailable: " .. tostring(result));
            end;

            u23[Bundles.productId(v)] = success and result and result or false;
            update();
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 569
    -- upvalues: u38 (ref), u47 (ref), u22 (copy), u6 (copy), u9 (copy), u20 (copy), remove (copy), u48 (ref), u26 (copy), Folder (copy)
    u38 = false;
    u47 = u47 + 1;

    for _, v in u22 do
        v:Disconnect();
    end;

    for _, v in u6 do
        v[1]:Disconnect();
        v[2]:Disconnect();
    end;

    for i in u9 do
        local v228 = u9[i];

        if v228 then
            u9[i] = nil;
            v228.added:Disconnect();
            v228.removing:Disconnect();
        end;
    end;

    local v229 = {};

    for i in u20 do
        table.insert(v229, i);
    end;

    for _, v in v229 do
        remove(v);
    end;

    if u48 then
        u48:Destroy();
    end;

    u26:destroy();
    Folder:Destroy();
end);