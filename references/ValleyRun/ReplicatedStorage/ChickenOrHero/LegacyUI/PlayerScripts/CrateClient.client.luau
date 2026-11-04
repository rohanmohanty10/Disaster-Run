 

 

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local GamepadService = game:GetService("GamepadService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Crates = ChickenOrHero:WaitForChild("Crates");
local Interface = ChickenOrHero:WaitForChild("Interface");
local CrateCatalog = require(Crates:WaitForChild("CrateCatalog"));
local CrateLuck = require(Crates:WaitForChild("CrateLuck"));
local CrateReel = require(Crates:WaitForChild("CrateReel"));
local SkinCatalog = require(ChickenOrHero.Weapons.SkinCatalog);
local EmoteCatalog = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local EmotePose = require(Interface:WaitForChild("EmotePose"));
local EmoteSound = require(Interface:WaitForChild("EmoteSound"));
local CharacterPreview = require(Interface:WaitForChild("CharacterPreview"));
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local ValleyToast = require(ChickenOrHero.Presentation.ValleyToast);
local CurrencyTopUp = require(ChickenOrHero.Weapons:WaitForChild("CurrencyTopUp"));
local ArmoryNavigation = ChickenOrHero.Weapons:WaitForChild("ArmoryNavigation");
local CrateEvent = Crates:WaitForChild("CrateEvent");
local u1 = Panels.screen(LocalPlayer, "Crates", 72);
local u2 = {};

local function connect(p3, p4) -- Line: 49
    -- upvalues: u2 (copy)
    table.insert(u2, p3:Connect(p4));
end;

local u5, u6, u7 = Panels.panel(u1, "Collection", 740, 590);
u7.ZIndex = 11;
local u8 = Panels.text(u6, "Heading", "KNIFE CRATES", 24, 22, 590, 34, 26, Panels.Paper);
u8.Font = Enum.Font.GothamBold;
local u9 = Panels.text(u6, "Subtitle", "One knife per opening. Every outcome and its exact chance is below.", 24, 62, 692, 30, 13, Panels.Muted);
local u10 = Panels.make("Frame", u6, "Knives", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(24, 105),
    Size = UDim2.fromOffset(692, 332)
});
local u11 = Panels.text(u6, "Status", "", 24, 448, 692, 34, 13, Panels.Muted);
local u12 = {};
local u13 = true;

for i, v in {
    {
        "Free",
        "Free",
        1,
        "FREE",
        Color3.fromRGB(150, 112, 30)
    },
    {
        "Gems",
        "Gems",
        1,
        "GEMS",
        Color3.fromRGB(43, 70, 65)
    },
    {
        "Robux",
        "Robux",
        1,
        "CHECKING PRICE",
        Color3.fromRGB(81, 67, 39)
    },
    {
        "Robux3",
        "Robux",
        3,
        "CHECKING PRICE",
        Color3.fromRGB(81, 67, 39)
    },
    {
        "Robux10",
        "Robux",
        10,
        "CHECKING PRICE",
        Color3.fromRGB(81, 67, 39)
    }
} do
    local v14 = Panels.button(u6, v[1], v[4], 24, 489, 160, 42, v[5]);
    v14.TextSize = 18;
    v14.TextWrapped = true;
    local v15 = v[2] == "Free" and "buy-coins" or (v[2] == "Gems" and "buy-gems" or "buy-robux");
    Skin.button(v14, v15, {
        shimmer = false
    });
    u12[i] = {
        currency = v[2],
        count = v[3],
        button = v14,
        skin = v15,
        look = v15
    };
end;

local u16 = Panels.text(u6, "Disclosure", "Duplicates become gems at the amounts shown. Odds never change with ownership.", 24, 539, 692, 28, 11, Panels.Muted);
local u17 = Panels.make("Frame", u6, "Reveal", {
    Visible = false,
    Active = true,
    BorderSizePixel = 0,
    ZIndex = 10,
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Panels.Ink
});
Panels.corner(u17, 14);
local u18 = Panels.text(u17, "Heading", "UNSEALING…", 24, 52, 692, 42, 28, Panels.Gold);
u18.TextXAlignment = Enum.TextXAlignment.Center;
u18.Font = Enum.Font.GothamBold;
local u19 = Panels.make("Frame", u17, "Artwork", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(170, 117),
    Size = UDim2.fromOffset(400, 285)
});
local u20 = Panels.make("Frame", u17, "Results", {
    Visible = false,
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(24, 130),
    Size = UDim2.fromOffset(692, 290)
});
local u21 = Panels.text(u17, "Detail", "", 40, 411, 660, 62, 18, Panels.Paper);
u21.TextXAlignment = Enum.TextXAlignment.Center;
local u22 = Panels.button(u17, "Continue", "CONTINUE", 250, 507, 240, 42);
Skin.button(u22, "primary");

local function soundButton(p23, p24, p25) -- Line: 126
    -- upvalues: Panels (copy), Skin (copy)
    local v26 = Panels.button(p23, p24, "", 0, 0, p25, p25, Color3.fromRGB(36, 56, 70));
    v26.ZIndex = 3;
    Panels.stroke(v26, Panels.Gold, 0.55);
    Skin.button(v26, "dark", {
        radius = UDim.new(1, 0)
    });
    v26.BackgroundTransparency = 0.15;
    Panels.make("ImageLabel", v26, "Icon", {
        BackgroundTransparency = 1,
        Image = "rbxassetid://130344237995259",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.62, 0.62)
    });

    return v26;
end;

local u27 = soundButton(u17, "SoundButton", 40);
local u28 = EmoteSound.new(u27);
local u29 = {
    Common = Skin.Rarity.Common,
    Rare = Skin.Rarity.Rare,
    Epic = Skin.Rarity.Epic,
    Legendary = Skin.Rarity.Legendary,
    Mythical = Skin.Rarity.Mythical
};
local u30 = {};
local u31 = nil;
local u32 = false;
local u33 = 0;
local u34 = {};
local u35 = {};
local u36 = {};
local u37 = {};
local u38 = {};
local u39 = {};
local u40 = 0;
local u41 = {};
local u42 = {};
local u43 = 0;
local u44 = nil;
local u45 = false;
local u46 = (-1 / 0);

local function prize(p47, p48) -- Line: 160
    -- upvalues: CrateCatalog (copy), EmoteCatalog (copy), SkinCatalog (copy)
    local v49 = CrateCatalog.get(p47);

    if not v49 or type(p48) ~= "string" then
        return nil;
    end;

    if v49.Kind ~= "Emote" then
        local v50 = SkinCatalog.get(p48);

        return v50 and {
            kind = "Skin",
            id = p48,
            name = v50.Name,
            rarity = v50.Rarity or "Common"
        } or nil;
    end;

    local v51 = EmoteCatalog.get(p48);

    if not v51 then
        return nil;
    end;

    local v52 = "Common";

    for _, v in v49.Entries do
        if v.Emote == p48 then
            v52 = v.Rarity or v52;
            break;
        end;
    end;

    return {
        kind = "Emote",
        id = p48,
        name = v51.Name,
        rarity = v52
    };
end;

local function percent(p53) -- Line: 184
    return string.format("%.2f", p53):gsub("%.?0+$", "") .. "%";
end;

local TutorialConfig = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("TutorialConfig"));

local function tutorialFree() -- Line: 191
    -- upvalues: u31 (ref), LocalPlayer (copy), TutorialConfig (copy), u30 (ref)
    local v54;

    if u31 == (LocalPlayer:GetAttribute("TutorialCrate") or TutorialConfig.Crate) and LocalPlayer:GetAttribute("TutorialStep") == "Crate" then
        v54 = (tonumber(u30.free) or 0) > 0;
    else
        v54 = false;
    end;

    return v54;
end;

local function offerShown(p55) -- Line: 198
    -- upvalues: u31 (ref), CrateCatalog (copy), u30 (ref), LocalPlayer (copy), TutorialConfig (copy)
    local v56 = u31 and CrateCatalog.offer(u31, p55.count);

    if not v56 then
        return nil;
    end;

    if p55.currency == "Free" then
        if (tonumber(u30.free) or 0) > 0 then
            local v57;

            if u31 == (LocalPlayer:GetAttribute("TutorialCrate") or TutorialConfig.Crate) and LocalPlayer:GetAttribute("TutorialStep") == "Crate" then
                v57 = (tonumber(u30.free) or 0) > 0;
            else
                v57 = false;
            end;

            if v57 or not v56 then
                v56 = nil;
            end;
        else
            v56 = nil;
        end;

        return v56;
    end;

    if p55.currency == "Gems" then
        local v58;

        if type(v56.Gems) == "number" or type(v56.Coins) == "number" then
            v58 = v56 or nil;
        else
            v58 = nil;
        end;

        return v58;
    end;

    if type(v56.ProductId) ~= "number" or (v56.ProductId <= 0 or not v56) then
        v56 = nil;
    end;

    return v56;
end;

local function layoutResults() -- Line: 213
    -- upvalues: u38 (copy), u20 (copy), u1 (copy)
    local v59 = #u38;

    if v59 == 0 then
        return;
    end;

    local Offset = u20.Size.X.Offset;
    local Offset2 = u20.Size.Y.Offset;
    local v60 = u1.AbsoluteSize.X < 650 and math.min(v59, 2) or math.min(v59, 5);
    local math_ceil_ret = math.ceil(v59 / v60);
    local v61 = (Offset - (v60 - 1) * 10) / v60;
    local math_min_ret = math.min(150, (Offset2 - (math_ceil_ret - 1) * 10) / math_ceil_ret);
    local v62 = (Offset2 - (math_ceil_ret * math_min_ret + (math_ceil_ret - 1) * 10)) / 2;

    for i, v in u38 do
        local v63 = i - 1;
        local v64 = v59 - math.floor(v63 / v60) * v60;
        local math_min_ret2 = math.min(v60, v64);
        v.Size = UDim2.fromOffset(v61, math_min_ret);
        v.Position = UDim2.fromOffset((Offset - (math_min_ret2 * v61 + (math_min_ret2 - 1) * 10)) / 2 + v63 % v60 * (v61 + 10), v62 + math.floor(v63 / v60) * (math_min_ret + 10));
    end;
end;

local function layout() -- Line: 234
    -- upvalues: u31 (ref), CrateCatalog (copy), u1 (copy), u12 (copy), offerShown (copy), u6 (copy), u7 (copy), u8 (copy), u9 (copy), u10 (copy), u11 (copy), u16 (copy), u18 (copy), u19 (copy), u22 (copy), u21 (copy), u20 (copy), u27 (copy), u37 (copy), layoutResults (copy)
    local v65 = u31 and CrateCatalog.get(u31);
    local v66 = v65 and #v65.Entries or 8;
    local v67 = v66 > 8;
    local AbsoluteSize = u1.AbsoluteSize;
    local v68 = AbsoluteSize.X < 650;
    local v69 = v67 and not v68 and AbsoluteSize.Y < 560;
    local v70 = v68 and 420 or (v69 and 1000 or 740);
    local v71;

    if v68 then
        v71 = v67 and 3 or 2;
    else
        v71 = v69 and (v66 <= 10 and 5 or 8) or (v67 and 5 or 4);
    end;

    local math_ceil_ret = math.ceil(v66 / v71);
    local math_max_ret = math.max(1, math_ceil_ret);
    local v72;

    if v68 then
        v72 = v67 and 640 or 512;
    else
        v72 = v69 and 290 or (v67 and 460 or 332);
    end;

    local v73 = {};
    local v74 = v68 and 64 or 48;

    for _, v in u12 do
        if offerShown(v) then
            table.insert(v73, v);
        end;
    end;

    local v75 = v68 and math.min(2, #v73) or #v73;
    local math_max_ret2 = math.max(1, v75);
    local math_ceil_ret2 = math.ceil(#v73 / math_max_ret2);
    local math_max_ret3 = math.max(1, math_ceil_ret2);
    local v76 = 105 + v72 + 8;
    local v77 = v76 + 40 + math_max_ret3 * 42 + (math_max_ret3 - 1) * 8;
    local v78 = v77 + 6 + v74 + 12;
    u6.Size = UDim2.fromOffset(v70, v78);
    u6.Scale.Scale = math.min(1, u1.AbsoluteSize.X * 0.94 / v70, u1.AbsoluteSize.Y * 0.94 / v78);
    u7.Position = UDim2.fromOffset(v70 - 60, 16);
    u8.Size = UDim2.fromOffset(v70 - 98, 36);
    u8.TextSize = v68 and 20 or 26;
    u9.Size = UDim2.fromOffset(v70 - 48, 36);
    u10.Size = UDim2.fromOffset(v70 - 48, v72);
    u11.Position = UDim2.fromOffset(24, v76);
    u11.Size = UDim2.fromOffset(v70 - 48, 34);
    local v79 = (v70 - 48 - (math_max_ret2 - 1) * 10) / math_max_ret2;

    for i, v in v73 do
        local v80 = i - 1;
        v.button.Position = UDim2.fromOffset(24 + v80 % math_max_ret2 * (v79 + 10), v76 + 40 + math.floor(v80 / math_max_ret2) * 50);
        v.button.Size = UDim2.fromOffset(v79, 42);
    end;

    u16.Position = UDim2.fromOffset(24, v77 + 6);
    u16.Size = UDim2.fromOffset(v70 - 48, v74);
    u18.Size = UDim2.fromOffset(v70 - 48, 60);
    u18.TextSize = v68 and 21 or 28;
    u19.Position = UDim2.fromOffset(24, 130);
    u19.Size = UDim2.fromOffset(v70 - 48, 260);
    local v81 = v78 - 66;
    u22.Position = UDim2.fromOffset((v70 - 240) / 2, v81);
    u21.Position = UDim2.fromOffset(40, v81 - 84);
    u21.Size = UDim2.fromOffset(v70 - 80, 74);
    u20.Position = UDim2.fromOffset(24, 130);
    u20.Size = UDim2.fromOffset(v70 - 48, (math.max(120, v81 - 84 - 8 - 130)));
    u27.Position = UDim2.fromOffset(v70 - 24 - 48, 138);
    local v82 = (v70 - 48 - (v71 - 1) * 10) / v71;
    local v83 = (v72 - (math_max_ret - 1) * 10) / math_max_ret;

    for i, v in u37 do
        local v84 = i - 1;
        local frame = v.frame;
        frame.Size = UDim2.fromOffset(v82, v83);
        frame.Position = UDim2.fromOffset(v84 % v71 * (v82 + 10), math.floor(v84 / v71) * (v83 + 10));
        frame.Art.Size = UDim2.fromOffset(v82 - 12, v83 - 57);
        frame.NameLabel.Position = UDim2.fromOffset(4, v83 - 55);
        frame.NameLabel.Size = UDim2.fromOffset(v82 - 8, 24);
        frame.Rarity.Position = UDim2.fromOffset(4, v83 - 31);
        frame.Rarity.Size = UDim2.fromOffset(v82 - 8, 24);
        local SoundButton = frame:FindFirstChild("SoundButton");

        if SoundButton then
            SoundButton.Position = UDim2.fromOffset(v82 - 34, 6);
        end;
    end;

    layoutResults();
end;

local PropertyChangedSignal = u1:GetPropertyChangedSignal("AbsoluteSize");
table.insert(u2, PropertyChangedSignal:Connect(layout));
layout();

local function preview(p85, p86) -- Line: 310
    -- upvalues: SkinCatalog (copy), ChickenOrHero (copy), Panels (copy), u36 (copy)
    local v87 = SkinCatalog.get(p86);

    if v87 then
        v87 = ChickenOrHero.Weapons.Models:FindFirstChild(v87.Model);
    end;

    if not v87 then
        return;
    end;

    local v88 = Panels.make("ViewportFrame", p85, "Preview", {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -1),
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(200, 210, 225),
        LightColor = Color3.new(1, 1, 1)
    });
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = v88;
    local Model = Instance.new("Model");
    Model.Parent = WorldModel;
    local Blade = v87:FindFirstChild("Blade");

    if not Blade then
        v88:Destroy();

        return;
    end;

    local v89 = Blade:Clone();
    v89.Transparency = 0;
    v89.CFrame = v87:GetAttribute("PreviewRotation") or CFrame.Angles(-0.3, 0, -0.5);
    v89.Parent = Model;

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
        end;
    end;

    local BoundingBox, v90 = Model:GetBoundingBox();
    Model:PivotTo(Model:GetPivot() - BoundingBox.Position);
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 35;
    Camera.Parent = v88;
    v88.CurrentCamera = Camera;
    local v91 = {
        viewport = v88,
        camera = Camera,
        extent = math.max(v90.X, v90.Y, v90.Z, 0.5)
    };
    table.insert(u36, v91);
end;

local u97 = CrateReel.new(u19, Panels, CrateCatalog, SkinCatalog, u29, preview, {
    icon = "rbxassetid://117630660259402",
    prize = prize,

    hero = function(p92, p93, p94) -- Line: 357, Name: hero
        -- upvalues: LocalPlayer (copy), Panels (copy), CharacterPreview (copy), u28 (copy)
        if not LocalPlayer.Character then
            return nil;
        end;

        local v95 = Panels.make("ViewportFrame", p92, "Preview", {
            BackgroundTransparency = 1,
            LightDirection = Vector3.new(-1, -1, -1),
            Size = UDim2.fromScale(1, 1),
            Ambient = Color3.fromRGB(200, 210, 225),
            LightColor = Color3.new(1, 1, 1)
        });
        local v96 = CharacterPreview.new(v95);
        v96:play(p94.id);
        u28:set(p94.id);

        return v96;
    end
});

local function bonus(p98) -- Line: 374
    return p98 == "Mythical" and "+1 speed · −1.25s item/ability · −0.4s dodge" or (p98 == "Epic" and "+0.35 speed · −0.35s item/ability · −0.1s dodge" or (p98 == "Legendary" and "+0.85 speed · −0.85s item/ability · −0.3s dodge" or "Cosmetic · standard stats"));
end;

local function emoteDisclosure() -- Line: 380
    -- upvalues: CrateCatalog (copy)
    local v99 = CrateCatalog.DuplicateGems or {};

    return ("Duplicates: Common +%d · Rare +%d · Epic +%d · Legendary +%d gems. Odds never change with ownership.\nGems open one crate at a time; ×3 and ×10 openings are Robux only."):format(v99.Common or 10, v99.Rare or 20, v99.Epic or 40, v99.Legendary or 75);
end;

local function render() -- Line: 390
    -- upvalues: u13 (ref), u31 (ref), CrateCatalog (copy), u30 (ref), u32 (ref), u17 (copy), LocalPlayer (copy), EmoteCatalog (copy), u12 (copy), offerShown (copy), TutorialConfig (copy), u41 (copy), u42 (copy), Skin (copy), u11 (copy)
    if not u13 then
        return;
    end;

    local v100 = u31 and CrateCatalog.get(u31);

    if not v100 then
        return;
    end;

    local v101 = v100.Kind == "Emote";
    local v102;

    if u30.loaded == true then
        v102 = not (u30.pending or u32 or (u17.Visible or LocalPlayer:GetAttribute("InMatch")));

        if v102 then
            local v103;

            if v101 then
                v103 = EmoteCatalog.ComingSoon;
            else
                v103 = v101;
            end;

            v102 = not v103;
        end;
    else
        v102 = false;
    end;

    local v104;

    if v102 then
        v104 = u30.allowed == true;
    else
        v104 = v102;
    end;

    for _, v in u12 do
        local v105 = offerShown(v);
        local v106 = false;
        v.button.Visible = v105 ~= nil;

        if v105 and v.currency == "Free" then
            v.button.Text = "FREE: " .. tostring(u30.free);

            if v102 then
                v106 = type(u30.token) == "string";
            else
                v106 = v102;
            end;
        else
            local v107, v108, v109, v110;

            if v105 and v.currency == "Gems" then
                local v111;

                if u31 == (LocalPlayer:GetAttribute("TutorialCrate") or TutorialConfig.Crate) and LocalPlayer:GetAttribute("TutorialStep") == "Crate" then
                    v111 = (tonumber(u30.free) or 0) > 0;
                else
                    v111 = false;
                end;

                if v111 then
                    v.button.Text = "FREE";

                    if v102 then
                        v106 = type(u30.token) == "string";
                    else
                        v106 = v102;
                    end;
                elseif v105 and v.currency == "Gems" then
                    v.button.Text = tostring(v105.Coins or v105.Gems);

                    if v104 then
                        v106 = type(u30.token) == "string";
                    else
                        v106 = v104;
                    end;
                elseif v105 then
                    v107 = u41[v105.ProductId];

                    if v107 == nil or type(v107.PriceInRobux) ~= "number" then
                        v106 = false;
                    else
                        v106 = v107.PriceInRobux >= 0;
                    end;

                    v108 = v106 and utf8.char(57346) .. " " .. v107.PriceInRobux or (u42[v105.ProductId] and "PRICE UNAVAILABLE" or "CHECKING PRICE");
                    v109 = u30.robuxAllowed ~= false;
                    v110 = v.button;

                    if v109 then
                        if v.count > 1 then
                            v108 = "×" .. v.count .. " · " .. v108 or v108;
                        end;
                    else
                        v108 = "UNAVAILABLE";
                    end;

                    v110.Text = v108;

                    if v104 then
                        if v109 then
                            if v106 then
                                v106 = v107.IsForSale == true;
                            end;
                        else
                            v106 = v109;
                        end;
                    else
                        v106 = v104;
                    end;
                end;
            elseif v105 and v.currency == "Gems" then
                v.button.Text = tostring(v105.Coins or v105.Gems);

                if v104 then
                    v106 = type(u30.token) == "string";
                else
                    v106 = v104;
                end;
            elseif v105 then
                v107 = u41[v105.ProductId];

                if v107 == nil or type(v107.PriceInRobux) ~= "number" then
                    v106 = false;
                else
                    v106 = v107.PriceInRobux >= 0;
                end;

                v108 = v106 and utf8.char(57346) .. " " .. v107.PriceInRobux or (u42[v105.ProductId] and "PRICE UNAVAILABLE" or "CHECKING PRICE");
                v109 = u30.robuxAllowed ~= false;
                v110 = v.button;

                if v109 then
                    if v.count > 1 then
                        v108 = "×" .. v.count .. " · " .. v108 or v108;
                    end;
                else
                    v108 = "UNAVAILABLE";
                end;

                v110.Text = v108;

                if v104 then
                    if v109 then
                        if v106 then
                            v106 = v107.IsForSale == true;
                        end;
                    else
                        v106 = v109;
                    end;
                else
                    v106 = v104;
                end;
            end;
        end;

        v.button.Active = v106;
        v.button.AutoButtonColor = v106;
        v.button.TextTransparency = v106 and 0 or 0.45;
        local v112;

        if v105 == nil or v.currency ~= "Gems" then
            v112 = false;
        else
            v112 = v105.Coins ~= nil;
        end;

        local v113 = v106 and (v112 and "buy-coins" or v.skin or "secondary") or "secondary";

        if v.look ~= v113 then
            v.look = v113;
            Skin.button(v.button, v113, {
                shimmer = false
            });
        end;

        local v114;

        if v105 == nil or v.currency ~= "Gems" then
            v114 = false;
        else
            v114 = v.button.Text ~= "FREE";
        end;

        Skin.price(v.button, v114 and (v112 and "coins" or "gems" or nil) or nil, {
            dim = not v106
        });
    end;

    local v115;

    if u32 then
        v115 = "Opening your crate…";
    elseif u30.loaded then
        if u30.allowed == true then
            v115 = v101 and "Your balance: " .. tostring(u30.gems or 0) .. " gems · Emotes you win join My Emotes" or (v100.Coins and "Your balance: " .. tostring(u30.coins or 0) .. " coins · Knives equip from your armory" or "Your balance: " .. tostring(u30.gems or 0) .. " gems · Knives equip from your armory");
        else
            v115 = u30.reason or "Crates are unavailable for this account.";
        end;
    else
        v115 = "Loading your collection…";
    end;

    u11.Text = v115;
end;

local function setBusy(p116) -- Line: 455
    -- upvalues: u32 (ref), u33 (ref), u13 (ref), u17 (copy), render (copy)
    u32 = p116;
    u33 = u33 + 1;

    if p116 then
        local u117 = u33;
        task.delay(12, function() -- Line: 460
            -- upvalues: u13 (ref), u32 (ref), u33 (ref), u117 (copy), u17 (ref), render (ref)
            if u13 and (u32 and (u33 == u117 and not u17.Visible)) then
                u32 = false;
                render();
            end;
        end);
    end;
end;

local function comingSoon() -- Line: 469
    -- upvalues: u46 (ref), ValleyToast (copy)
    if os.clock() - u46 >= 2 then
        u46 = os.clock();
        ValleyToast.show("Coming soon!");
    end;
end;

local function gamepadCursor(p118) -- Line: 478
    -- upvalues: u45 (ref), UserInputService (copy), GamepadService (copy), u6 (copy)
    if p118 then
        if not (u45 or (UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad or GamepadService.GamepadCursorEnabled)) then
            u45 = pcall(GamepadService.EnableGamepadCursor, GamepadService, u6);
        end;
    elseif u45 then
        u45 = false;

        if GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;
    end;
end;

local function clearGrid() -- Line: 495
    -- upvalues: u37 (copy), u10 (copy), u36 (copy)
    for _, v in u37 do
        if v.pose then
            v.pose:destroy();
        end;

        if v.sound then
            v.sound:destroy();
        end;
    end;

    table.clear(u37);
    u10:ClearAllChildren();
    table.clear(u36);
end;

local function clearResults() -- Line: 509
    -- upvalues: u40 (ref), u39 (copy), u38 (copy), u20 (copy), u19 (copy)
    u40 = u40 + 1;

    for _, v in u39 do
        v:Destroy();
    end;

    table.clear(u39);
    table.clear(u38);
    u20:ClearAllChildren();
    u20.Visible = false;
    u19.Visible = true;
end;

local function stopReveal() -- Line: 522
    -- upvalues: u97 (copy), u28 (copy), clearResults (copy)
    u97:cancel();
    u28:set(nil);
    clearResults();
end;

local function buildCard(p119, p120, p121, p122) -- Line: 528
    -- upvalues: u29 (copy), Panels (copy), u10 (copy), Skin (copy), EmotePose (copy), EmoteCatalog (copy), EmoteSound (copy), soundButton (copy), preview (copy), u37 (copy)
    local v123 = p119.kind == "Emote";
    local v124 = u29[p119.rarity] or Panels.Muted;
    local v125 = Panels.make("Frame", u10, p119.id, {
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(25, 40, 52),
        LayoutOrder = p121
    });
    Panels.corner(v125, 10);
    Panels.stroke(v125, v124, 0.5);
    Skin.card(v125, v124, {
        glow = true
    });
    local v126 = Panels.make("Frame", v125, "Art", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(6, 2)
    });
    local v127 = {
        frame = v125
    };

    if v123 then
        local v128 = Panels.make("ImageLabel", v126, "Icon", {
            BackgroundTransparency = 1,
            Image = "rbxassetid://117630660259402",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.8, 0.8),
            ImageColor3 = v124:Lerp(Color3.new(1, 1, 1), 0.35),
            ScaleType = Enum.ScaleType.Fit
        });
        local v129 = Panels.make("ViewportFrame", v126, "Preview", {
            BackgroundTransparency = 1,
            LightDirection = Vector3.new(-1, -1, -1),
            Size = UDim2.fromScale(1, 1),
            Ambient = Color3.fromRGB(200, 210, 225),
            LightColor = Color3.new(1, 1, 1)
        });
        local success, result = pcall(EmotePose.new, v129, p119.id);

        if success and result then
            v128:Destroy();
            v127.pose = result;
        else
            v129:Destroy();
        end;

        if EmoteCatalog.soundId(p119.id) then
            v127.sound = EmoteSound.new((soundButton(v125, "SoundButton", 28)));
            v127.sound:set(p119.id);
        end;
    else
        preview(v126, p119.id);
    end;

    local v130 = Panels.text(v125, "NameLabel", p119.name, 4, 110, 154, 24, 13, Panels.Paper);
    v130.Font = Enum.Font.GothamBold;
    v130.TextXAlignment = Enum.TextXAlignment.Center;
    local v131;

    if v123 then
        v131 = string.upper(p119.rarity) .. " · " .. string.format("%.2f", p120.Weight / p122 * 100):gsub("%.?0+$", "") .. "%";
    else
        v131 = string.upper(p119.rarity) .. " · " .. string.format("%.2f", p120.Weight / 100):gsub("%.?0+$", "") .. "%";
    end;

    local v132 = Panels.text(v125, "Rarity", v131, 4, 136, 154, 24, 11, v124);
    v132.TextXAlignment = Enum.TextXAlignment.Center;

    if v123 then
        for _, v in { v130, v132 } do
            v.TextScaled = true;
            Panels.make("UITextSizeConstraint", v, "Limit", {
                MinTextSize = 8,
                MaxTextSize = v.TextSize
            });
        end;
    end;

    table.insert(u37, v127);
end;

local function fetchPrices(u133, u134) -- Line: 598
    -- upvalues: u42 (copy), CrateCatalog (copy), u41 (copy), MarketplaceService (copy), u13 (ref), u5 (copy), u31 (ref), u43 (ref), render (copy)
    table.clear(u42);

    for _, v in { 1, 3, 10 } do
        local u135 = CrateCatalog.offer(u133, v);

        if u135 then
            u135 = u135.ProductId;
        end;

        local v136;

        if type(u135) == "number" then
            v136 = u41[u135];
        else
            v136 = false;
        end;

        if type(u135) == "number" and (u135 > 0 and (not v136 or os.clock() - v136.at > 300)) then
            task.spawn(function() -- Line: 605
                -- upvalues: MarketplaceService (ref), u135 (copy), u13 (ref), u41 (ref), u42 (ref), u5 (ref), u31 (ref), u133 (copy), u43 (ref), u134 (copy), render (ref)
                local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u135, Enum.InfoType.Product);

                if not u13 then
                    return;
                end;

                if success and type(result) == "table" then
                    u41[u135] = {
                        PriceInRobux = result.PriceInRobux,
                        IsForSale = result.IsForSale,
                        at = os.clock()
                    };
                elseif not u41[u135] then
                    u42[u135] = true;
                end;

                if u5.Visible and (u31 == u133 and u43 == u134) then
                    render();
                end;
            end);
        end;
    end;
end;

local function load(u137) -- Line: 624
    -- upvalues: CrateCatalog (copy), u97 (copy), u28 (copy), clearResults (copy), u31 (ref), u43 (ref), u30 (ref), u44 (ref), u32 (ref), u33 (ref), u17 (copy), u8 (copy), u9 (copy), clearGrid (copy), CrateLuck (copy), prize (copy), buildCard (copy), ValleyToast (copy), u16 (copy), layout (copy), render (copy), CrateEvent (copy), u13 (ref), u5 (copy), fetchPrices (copy)
    local v138 = CrateCatalog.get(u137);
    u97:cancel();
    u28:set(nil);
    clearResults();
    u31 = u137;
    u43 = u43 + 1;
    local u139 = u43;
    u30 = {};
    u44 = nil;
    u32 = false;
    u33 = u33 + 1;
    u17.Visible = false;
    local v140 = v138.Kind == "Emote";
    u8.Text = v140 and "EMOTE CRATE" or "KNIFE CRATES";
    u9.Text = v140 and "ONE EMOTE PER OPENING" or "One knife per opening. Every outcome and its exact chance is below.";
    u9.Font = v140 and Enum.Font.GothamBold or Enum.Font.Gotham;
    clearGrid();
    local v141 = 0;

    for _, v in v138.Entries do
        v141 = v141 + v.Weight;
    end;

    local v142 = CrateLuck.weights(v138, CrateLuck.current());

    for i, v in v138.Entries do
        local v143 = prize(u137, v.Emote or v.Skin);

        if v143 then
            local table_clone_ret = table.clone(v);
            table_clone_ret.Weight = v142[i];
            buildCard(v143, table_clone_ret, i, (math.max(v141, 1)));
        end;
    end;

    local v144 = u9;
    v144.Text = v144.Text .. CrateLuck.tag();

    if CrateLuck.current() > 0 then
        ValleyToast.show(CrateLuck.Notice);
    end;

    local v145;

    if v140 then
        local v146 = CrateCatalog.DuplicateGems or {};
        v145 = ("Duplicates: Common +%d · Rare +%d · Epic +%d · Legendary +%d gems. Odds never change with ownership.\nGems open one crate at a time; ×3 and ×10 openings are Robux only."):format(v146.Common or 10, v146.Rare or 20, v146.Epic or 40, v146.Legendary or 75) or "Duplicates: Common +10 · Rare +20 · Epic +40 · Legendary +75 · Mythical +150 gems.\nEpic: +0.35 speed / −0.35s timers / −0.1s dodge · Legendary: +0.85 / −0.85s / −0.3s · Mythical: +1 / −1.25s / −0.4s.";
    else
        v145 = "Duplicates: Common +10 · Rare +20 · Epic +40 · Legendary +75 · Mythical +150 gems.\nEpic: +0.35 speed / −0.35s timers / −0.1s dodge · Legendary: +0.85 / −0.85s / −0.3s · Mythical: +1 / −1.25s / −0.4s.";
    end;

    u16.Text = v145;
    layout();
    render();
    CrateEvent:FireServer("Open", u137);

    for i = 1, 2 do
        task.delay(i * 0.6, function() -- Line: 664
            -- upvalues: u13 (ref), u5 (ref), u43 (ref), u139 (copy), u31 (ref), u137 (copy), u30 (ref), CrateEvent (ref)
            if u13 and (u5.Visible and (u43 == u139 and (u31 == u137 and u30.loaded == nil))) then
                CrateEvent:FireServer("Open", u137);
            end;
        end);
        local _ = i;
    end;

    fetchPrices(u137, u139);
end;

for _, v in CrateLuck.watch(function() -- Line: 674
    -- upvalues: u13 (ref), u5 (copy), u31 (ref), u17 (copy), load (copy)
    if u13 and (u5.Visible and (u31 and not u17.Visible)) then
        load(u31);
    end;
end) do
    table.insert(u2, v);
end;

local function hide() -- Line: 682
    -- upvalues: u43 (ref), u97 (copy), u28 (copy), clearResults (copy), clearGrid (copy), u31 (ref), u32 (ref), u33 (ref), u17 (copy), u5 (copy), LocalPlayer (copy), u45 (ref), GamepadService (copy)
    u43 = u43 + 1;
    u97:cancel();
    u28:set(nil);
    clearResults();
    clearGrid();
    u31 = nil;
    u32 = false;
    u33 = u33 + 1;
    u17.Visible = false;
    u5.Visible = false;
    LocalPlayer:SetAttribute("CrateOpen", nil);

    if u45 then
        u45 = false;

        if GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;
    end;
end;

local function show(p147) -- Line: 695
    -- upvalues: u13 (ref), CrateCatalog (copy), LocalPlayer (copy), EmoteCatalog (copy), u5 (copy), u31 (ref), u17 (copy), load (copy), HudNavigation (copy), u45 (ref), UserInputService (copy), GamepadService (copy), u6 (copy)
    if not u13 then
        return false;
    end;

    local v148 = CrateCatalog.get(p147);

    if not v148 or (LocalPlayer:GetAttribute("InMatch") or v148.Kind == "Emote" and EmoteCatalog.ComingSoon) then
        return false;
    end;

    if u5.Visible then
        if u31 ~= p147 and not u17.Visible then
            load(p147);
        end;

        return u31 == p147;
    end;

    HudNavigation.opening("Crates");
    u5.Visible = true;
    LocalPlayer:SetAttribute("CrateOpen", true);
    task.defer(function() -- Line: 714
        -- upvalues: u13 (ref), u5 (ref), u45 (ref), UserInputService (ref), GamepadService (ref), u6 (ref)
        if u13 and (u5.Visible and not (u45 or (UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad or GamepadService.GamepadCursorEnabled))) then
            u45 = pcall(GamepadService.EnableGamepadCursor, GamepadService, u6);
        end;
    end);
    load(p147);

    return true;
end;

local function revealOne(u149, u150) -- Line: 723
    -- upvalues: clearResults (copy), u32 (ref), u33 (ref), u13 (ref), u17 (copy), render (copy), u18 (copy), CrateLuck (copy), Panels (copy), u21 (copy), CrateCatalog (copy), u22 (copy), u97 (copy), u29 (copy)
    clearResults();
    u32 = true;
    u33 = u33 + 1;
    local u151 = u33;
    task.delay(12, function() -- Line: 460
        -- upvalues: u13 (ref), u32 (ref), u33 (ref), u151 (copy), u17 (ref), render (ref)
        if u13 and (u32 and (u33 == u151 and not u17.Visible)) then
            u32 = false;
            render();
        end;
    end);
    u17.Visible = true;
    render();
    u18.Text = (u150.kind == "Emote" and "UNSEALING YOUR EMOTE…" or "UNSEALING YOUR KNIFE…") .. CrateLuck.revealTag();
    u18.TextColor3 = Panels.Gold;
    u21.Text = CrateCatalog.get(u149.crate).Name;
    u22.Visible = false;
    u97:play(u149, function() -- Line: 732
        -- upvalues: u150 (copy), u18 (ref), u29 (ref), Panels (ref), u21 (ref), u149 (copy), u22 (ref)
        local v152 = u150.kind == "Emote" and string.upper(u150.name) or u150.name;
        u18.Text = string.upper(u150.rarity) .. " · " .. v152;
        u18.TextColor3 = u29[u150.rarity] or Panels.Gold;
        local v153 = u149.duplicate and "Already collected · +" .. tostring(u149.gems or 0) .. " gems";

        if not v153 then
            if u150.kind == "Emote" then
                v153 = "Added to your emotes";
            else
                local rarity = u150.rarity;
                v153 = "Added to your armory\n" .. (rarity == "Mythical" and "+1 speed · −1.25s item/ability · −0.4s dodge" or (rarity == "Epic" and "+0.35 speed · −0.35s item/ability · −0.1s dodge" or (rarity == "Legendary" and "+0.85 speed · −0.85s item/ability · −0.3s dodge" or "Cosmetic · standard stats")));
            end;
        end;

        u21.Text = v153;
        u22.Visible = true;
    end);
end;

local function resultSound(p154, p155, p156, p157) -- Line: 743
    -- upvalues: SoundService (copy), u39 (copy)
    local Sound = Instance.new("Sound");
    Sound.Name = p154;
    Sound.SoundId = "rbxassetid://" .. p155;
    Sound.Volume = p156;
    Sound.PlaybackSpeed = p157 or 1;
    Sound.Parent = SoundService;
    table.insert(u39, Sound);

    return Sound;
end;

local function resultCell(p158, p159, p160) -- Line: 754
    -- upvalues: u29 (copy), Panels (copy), u20 (copy), Skin (copy), Theme (copy), u38 (copy)
    local v161 = u29[p159.rarity] or Panels.Muted;
    local u162 = Panels.make("Frame", u20, "Result" .. p158, {
        Visible = false,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(25, 40, 52),
        LayoutOrder = p158
    });
    Panels.corner(u162, 10);
    Panels.stroke(u162, v161, 0.5);
    Skin.card(u162, v161);
    Panels.make("UIScale", u162, "Pop", {});
    Panels.make("Frame", u162, "RarityLine", {
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -5),
        Size = UDim2.new(1, 0, 0, 5),
        BackgroundColor3 = v161
    });

    local function label(p163, p164, p165, p166, p167, p168, p169) -- Line: 772
        -- upvalues: Panels (ref), u162 (copy), Skin (ref)
        local v170 = Panels.make("TextLabel", u162, p163, {
            BackgroundTransparency = 1,
            TextScaled = true,
            TextWrapped = true,
            Position = UDim2.fromScale(0.05, p165),
            Size = UDim2.fromScale(0.9, p166),
            Text = p164,
            TextColor3 = p168,
            Font = p169 or Enum.Font.Gotham
        });
        Panels.make("UITextSizeConstraint", v170, "Limit", {
            MinTextSize = 8,
            MaxTextSize = p167
        });
        Skin.textStroke(v170, 1);

        return v170;
    end;

    label("NameLabel", p159.name, 0.1, 0.36, 15, Panels.Paper, Enum.Font.GothamBold);
    label("Rarity", string.upper(p159.rarity), 0.48, 0.17, 11, v161, Enum.Font.GothamBold);
    label("State", p160.duplicate and ("DUPLICATE · +" .. tostring(p160.gems or 0) .. " GEMS" or "NEW") or "NEW", 0.68, 0.17, 11, p160.duplicate and Panels.Muted or Theme.Mint, Enum.Font.GothamBold);
    table.insert(u38, u162);

    return u162;
end;

local function revealMany(u171) -- Line: 803
    -- upvalues: CrateCatalog (copy), u97 (copy), u28 (copy), clearResults (copy), u32 (ref), u33 (ref), u13 (ref), u17 (copy), render (copy), u19 (copy), u20 (copy), u22 (copy), u18 (copy), CrateLuck (copy), Panels (copy), u21 (copy), u40 (ref), prize (copy), resultCell (copy), layoutResults (copy), SoundService (copy), u39 (copy), u38 (copy), TweenService (copy)
    local v172 = CrateCatalog.get(u171.crate);
    u97:cancel();
    u28:set(nil);
    clearResults();
    u32 = true;
    u33 = u33 + 1;
    local u173 = u33;
    task.delay(12, function() -- Line: 460
        -- upvalues: u13 (ref), u32 (ref), u33 (ref), u173 (copy), u17 (ref), render (ref)
        if u13 and (u32 and (u33 == u173 and not u17.Visible)) then
            u32 = false;
            render();
        end;
    end);
    u17.Visible = true;
    u19.Visible = false;
    u20.Visible = true;
    u22.Visible = false;
    local u174 = #u171.prizes;
    u18.Text = ("UNSEALING %d CRATES…"):format(u174) .. CrateLuck.revealTag();
    u18.TextColor3 = Panels.Gold;
    u21.Text = v172.Name;
    render();
    local u175 = u40;
    local u176 = 0;
    local u177 = 0;

    for i, v in u171.prizes do
        local v178;

        if type(v) == "table" then
            v178 = prize(u171.crate, v.emote or v.skin);
        else
            v178 = false;
        end;

        if v178 then
            resultCell(i, v178, v);

            if v.duplicate then
                u176 = u176 + 1;
                u177 = u177 + (tonumber(v.gems) or 0);
            end;
        end;
    end;

    layoutResults();
    local Sound = Instance.new("Sound");
    Sound.Name = "CrateTick";
    Sound.SoundId = "rbxassetid://" .. 10128760939;
    Sound.Volume = 0.16;
    Sound.PlaybackSpeed = 1.1;
    Sound.Parent = SoundService;
    table.insert(u39, Sound);
    local Sound2 = Instance.new("Sound");
    Sound2.Name = "CrateReward";
    Sound2.SoundId = "rbxassetid://" .. 82803453482376;
    Sound2.Volume = 0.42;
    Sound2.PlaybackSpeed = 1;
    Sound2.Parent = SoundService;
    table.insert(u39, Sound2);
    local Sound3 = Instance.new("Sound");
    Sound3.Name = "CrateOpen";
    Sound3.SoundId = "rbxassetid://" .. 10128766965;
    Sound3.Volume = 0.3;
    Sound3.PlaybackSpeed = 0.8;
    Sound3.Parent = SoundService;
    table.insert(u39, Sound3);
    Sound3:Play();
    local v179 = #u38 > 3 and 0.18 or 0.35;

    for i, v in u38 do
        task.delay(0.4 + (i - 1) * v179, function() -- Line: 836
            -- upvalues: u13 (ref), u40 (ref), u175 (copy), v (copy), TweenService (ref), Sound (copy), i (copy)
            if not (u13 and (u40 == u175 and v.Parent)) then
                return;
            end;

            v.Visible = true;
            v.Pop.Scale = 0.6;
            TweenService:Create(v.Pop, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            Sound.PlaybackSpeed = 0.9 + i * 0.04;
            Sound.TimePosition = 0;
            Sound:Play();
        end);
    end;

    task.delay(0.4 + #u38 * v179 + 0.2, function() -- Line: 848
        -- upvalues: u13 (ref), u40 (ref), u175 (copy), Sound2 (copy), u171 (copy), u177 (ref), u18 (ref), u174 (copy), u21 (ref), u176 (ref), u22 (ref)
        if not u13 or u40 ~= u175 then
            return;
        end;

        Sound2:Play();
        local v180 = tonumber(u171.gems) or u177;
        u18.Text = ("%d CRATES OPENED"):format(u174);
        u21.Text = u176 == 0 and ("All %d are new"):format(u174) or ("%d new · %d duplicate%s · +%d gems"):format(u174 - u176, u176, u176 == 1 and "" or "s", v180);
        u22.Visible = true;
    end);
end;

table.insert(u2, u7.Activated:Connect(hide));
table.insert(u2, u22.Activated:Connect(function() -- Line: 867
    -- upvalues: u17 (copy), u97 (copy), u28 (copy), clearResults (copy), u32 (ref), u33 (ref), render (copy), u31 (ref), CrateEvent (copy)
    if not u17.Visible then
        return;
    end;

    u97:cancel();
    u28:set(nil);
    clearResults();
    u17.Visible = false;
    u32 = false;
    u33 = u33 + 1;
    render();

    if u31 then
        CrateEvent:FireServer("Open", u31);
    end;
end));

for _, v in u12 do
    table.insert(u2, v.button.Activated:Connect(function() -- Line: 880
        -- upvalues: v (copy), u32 (ref), u31 (ref), u5 (copy), LocalPlayer (copy), TutorialConfig (copy), u30 (ref), u33 (ref), u13 (ref), u17 (copy), render (copy), CrateEvent (copy), offerShown (copy), HudNavigation (copy), CurrencyTopUp (copy)
        if not (v.button.Active and (not u32 and (u31 and u5.Visible))) then
            return;
        end;

        if v.currency == "Gems" then
            local v181;

            if u31 == (LocalPlayer:GetAttribute("TutorialCrate") or TutorialConfig.Crate) and LocalPlayer:GetAttribute("TutorialStep") == "Crate" then
                v181 = (tonumber(u30.free) or 0) > 0;
            else
                v181 = false;
            end;

            if v181 then
                u32 = true;
                u33 = u33 + 1;
                local u182 = u33;
                task.delay(12, function() -- Line: 460
                    -- upvalues: u13 (ref), u32 (ref), u33 (ref), u182 (copy), u17 (ref), render (ref)
                    if u13 and (u32 and (u33 == u182 and not u17.Visible)) then
                        u32 = false;
                        render();
                    end;
                end);
                render();
                CrateEvent:FireServer("OpenFree", u31, u30.token);

                return;
            end;
        end;

        if v.currency == "Gems" then
            local v183 = offerShown(v);
            local wallet = HudNavigation.wallet;

            if v183 and v183.Coins then
                local math_max_ret = math.max(u30.coins or 0, wallet.loaded and wallet.coins or 0);

                if math_max_ret < v183.Coins then
                    CurrencyTopUp.prompt("coins", v183.Coins, math_max_ret);

                    return;
                end;
            else
                local math_max_ret = math.max(u30.gems or 0, wallet.loaded and wallet.gems or 0);

                if v183 and math_max_ret < v183.Gems then
                    CurrencyTopUp.prompt("gems", v183.Gems, math_max_ret);

                    return;
                end;
            end;
        end;

        u32 = true;
        u33 = u33 + 1;
        local u184 = u33;
        task.delay(12, function() -- Line: 460
            -- upvalues: u13 (ref), u32 (ref), u33 (ref), u184 (copy), u17 (ref), render (ref)
            if u13 and (u32 and (u33 == u184 and not u17.Visible)) then
                u32 = false;
                render();
            end;
        end);
        render();

        if v.currency == "Free" then
            CrateEvent:FireServer("OpenFree", u31, u30.token);

            return;
        end;

        if v.currency == "Gems" then
            CrateEvent:FireServer("BuyGems", u31, u30.token);

            return;
        end;

        CrateEvent:FireServer("Prompt", u31, nil, v.count);
    end));
end;

table.insert(u2, CrateEvent.OnClientEvent:Connect(function(p185, p186) -- Line: 920
    -- upvalues: u31 (ref), u30 (ref), layout (copy), u5 (copy), u44 (ref), ValleyToast (copy), render (copy), u17 (copy), u32 (ref), u33 (ref), u11 (copy), u34 (copy), u35 (copy), CrateEvent (copy), prize (copy), LocalPlayer (copy), show (copy), CrateCatalog (copy), revealMany (copy), revealOne (copy)
    if p185 == "State" and (type(p186) == "table" and p186.crate == u31) then
        local v187 = (tonumber(u30.free) or 0) > 0;
        u30 = p186;

        if v187 ~= ((tonumber(p186.free) or 0) > 0) then
            layout();
        end;

        if u5.Visible and (p186.loaded and (p186.allowed ~= true and (type(p186.reason) == "string" and (p186.reason ~= "" and p186.reason ~= u44)))) then
            u44 = p186.reason;
            ValleyToast.show(p186.reason);
        end;

        render();

        return;
    end;

    if p185 ~= "Notice" then
        if p185 == "Result" and (type(p186) == "table" and (p186.id ~= nil and not u34[p186.id])) then
            u34[p186.id] = true;
            table.insert(u35, p186.id);

            if #u35 > 128 then
                u34[table.remove(u35, 1)] = nil;
            end;

            CrateEvent:FireServer("Ack", p186.id);
            local v188 = prize(p186.crate, p186.emote or p186.skin);

            if not v188 then
                return;
            end;

            local v189;

            if type(p186.prizes) == "table" then
                v189 = #p186.prizes > 1;
            else
                v189 = false;
            end;

            if not u17.Visible then
                u32 = false;
                u33 = u33 + 1;
            end;

            if LocalPlayer:GetAttribute("InMatch") or (u17.Visible or not show(p186.crate)) then
                ValleyToast.show(v189 and ("Opened %d %ss"):format(#p186.prizes, CrateCatalog.get(p186.crate).Name) or "Crate unlocked: " .. v188.name);

                return;
            end;

            if v189 then
                revealMany(p186);

                return;
            end;

            revealOne(p186, v188);
        end;

        return;
    end;

    if not u17.Visible then
        u32 = false;
        u33 = u33 + 1;
    end;

    render();

    if u5.Visible then
        u11.Text = tostring(p186);
    end;

    ValleyToast.show((tostring(p186)));
end));
table.insert(u2, MarketplaceService.PromptProductPurchaseFinished:Connect(function(p190, p191) -- Line: 980
    -- upvalues: CrateCatalog (copy), LocalPlayer (copy), u31 (ref), u17 (copy), u32 (ref), u33 (ref), render (copy), CrateEvent (copy)
    local v192 = CrateCatalog.ProductGrants[p191];

    if p190 == LocalPlayer.UserId and (u31 and (v192 and v192.Crate == u31)) then
        if not u17.Visible then
            u32 = false;
            u33 = u33 + 1;
        end;

        render();
        CrateEvent:FireServer("Get", v192.Crate);
    end;
end));
table.insert(u2, ProximityPromptService.PromptTriggered:Connect(function(p193, p194) -- Line: 990
    -- upvalues: LocalPlayer (copy), CrateCatalog (copy), EmoteCatalog (copy), u46 (ref), ValleyToast (copy), show (copy)
    if p194 == LocalPlayer and p193.Name == "CratePrompt" then
        local Attribute = p193:GetAttribute("CrateId");
        local v195 = CrateCatalog.get(Attribute);

        if v195 and (v195.Kind == "Emote" and EmoteCatalog.ComingSoon) then
            if os.clock() - u46 >= 2 then
                u46 = os.clock();
                ValleyToast.show("Coming soon!");
            end;

            return;
        end;

        show(Attribute);
    end;
end));
table.insert(u2, ArmoryNavigation.Event:Connect(function(p196) -- Line: 1002
    -- upvalues: LocalPlayer (copy), ValleyToast (copy), show (copy), EmoteCatalog (copy), u46 (ref)
    local v197;

    if type(p196) == "string" then
        v197 = string.match(p196, "^Crate:(%w+)$");
    else
        v197 = false;
    end;

    if v197 then
        if LocalPlayer:GetAttribute("InMatch") then
            ValleyToast.show("Open crates in the lobby.");

            return;
        end;

        show(v197);

        return;
    end;

    if p196 ~= "EmoteCrate" then
        return;
    end;

    if EmoteCatalog.ComingSoon then
        if os.clock() - u46 >= 2 then
            u46 = os.clock();
            ValleyToast.show("Coming soon!");
        end;
    else
        if LocalPlayer:GetAttribute("InMatch") then
            ValleyToast.show("Open the Emote Crate in the lobby.");

            return;
        end;

        show("Emote");
    end;
end));
table.insert(u2, HudNavigation.Opening.Event:Connect(function(p198) -- Line: 1024
    -- upvalues: u43 (ref), u97 (copy), u28 (copy), clearResults (copy), clearGrid (copy), u31 (ref), u32 (ref), u33 (ref), u17 (copy), u5 (copy), LocalPlayer (copy), u45 (ref), GamepadService (copy)
    if p198 ~= "Crates" then
        u43 = u43 + 1;
        u97:cancel();
        u28:set(nil);
        clearResults();
        clearGrid();
        u31 = nil;
        u32 = false;
        u33 = u33 + 1;
        u17.Visible = false;
        u5.Visible = false;
        LocalPlayer:SetAttribute("CrateOpen", nil);

        if u45 then
            u45 = false;

            if GamepadService.GamepadCursorEnabled then
                pcall(GamepadService.DisableGamepadCursor, GamepadService);
            end;
        end;
    end;
end));
table.insert(u2, UserInputService.InputBegan:Connect(function(p199) -- Line: 1029
    -- upvalues: u5 (copy), u43 (ref), u97 (copy), u28 (copy), clearResults (copy), clearGrid (copy), u31 (ref), u32 (ref), u33 (ref), u17 (copy), LocalPlayer (copy), u45 (ref), GamepadService (copy)
    if u5.Visible and (p199.KeyCode == Enum.KeyCode.Escape or p199.KeyCode == Enum.KeyCode.ButtonB) then
        u43 = u43 + 1;
        u97:cancel();
        u28:set(nil);
        clearResults();
        clearGrid();
        u31 = nil;
        u32 = false;
        u33 = u33 + 1;
        u17.Visible = false;
        u5.Visible = false;
        LocalPlayer:SetAttribute("CrateOpen", nil);

        if u45 then
            u45 = false;

            if GamepadService.GamepadCursorEnabled then
                pcall(GamepadService.DisableGamepadCursor, GamepadService);
            end;
        end;
    end;
end));
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u2, AttributeChangedSignal:Connect(function() -- Line: 1034
    -- upvalues: LocalPlayer (copy), u43 (ref), u97 (copy), u28 (copy), clearResults (copy), clearGrid (copy), u31 (ref), u32 (ref), u33 (ref), u17 (copy), u5 (copy), u45 (ref), GamepadService (copy)
    if LocalPlayer:GetAttribute("InMatch") then
        u43 = u43 + 1;
        u97:cancel();
        u28:set(nil);
        clearResults();
        clearGrid();
        u31 = nil;
        u32 = false;
        u33 = u33 + 1;
        u17.Visible = false;
        u5.Visible = false;
        LocalPlayer:SetAttribute("CrateOpen", nil);

        if u45 then
            u45 = false;

            if GamepadService.GamepadCursorEnabled then
                pcall(GamepadService.DisableGamepadCursor, GamepadService);
            end;
        end;
    end;
end));
table.insert(u2, LocalPlayer.CharacterRemoving:Connect(hide));
local u200 = 0;
table.insert(u2, RunService.RenderStepped:Connect(function(p201) -- Line: 1041
    -- upvalues: u5 (copy), u200 (ref), u17 (copy), u97 (copy), u36 (copy)
    if not u5.Visible then
        return;
    end;

    u200 = u200 + p201;

    if u17.Visible then
        u97:step(p201);
    end;

    for i = #u36, 1, -1 do
        local v202 = u36[i];
        local v203;

        if v202.viewport.Parent then
            if v202.viewport.Parent.Visible then
                local v204 = u200 * 0.3;
                local camera = v202.camera;
                local CFrame_lookAt = CFrame.lookAt;
                local v205 = math.sin(v204) * v202.extent * 1.9;
                local v206 = v202.extent * 0.4;
                local v207 = math.cos(v204) * v202.extent * 1.9;
                camera.CFrame = CFrame_lookAt(Vector3.new(v205, v206, v207), Vector3.new(0, 0, 0));
                v203 = i;
            else
                v203 = i;
            end;
        else
            table.remove(u36, i);
            v203 = i;
        end;
    end;
end));
script.Destroying:Connect(function() -- Line: 1062
    -- upvalues: u13 (ref), u2 (copy), u43 (ref), u97 (copy), u28 (copy), clearResults (copy), clearGrid (copy), u31 (ref), u32 (ref), u33 (ref), u17 (copy), u5 (copy), LocalPlayer (copy), u45 (ref), GamepadService (copy), u1 (copy)
    u13 = false;

    for _, v in u2 do
        v:Disconnect();
    end;

    table.clear(u2);
    u43 = u43 + 1;
    u97:cancel();
    u28:set(nil);
    clearResults();
    clearGrid();
    u31 = nil;
    u32 = false;
    u33 = u33 + 1;
    u17.Visible = false;
    u5.Visible = false;
    LocalPlayer:SetAttribute("CrateOpen", nil);

    if u45 then
        u45 = false;

        if GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;
    end;

    u28:destroy();
    u1:Destroy();
end);