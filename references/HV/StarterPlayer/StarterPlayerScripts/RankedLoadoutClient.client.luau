 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local RankedConfig = require(ChickenOrHero.Game:WaitForChild("RankedConfig"));

if not RankedConfig.LoadoutEnabled or require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).Ranked ~= true then
    return;
end;

local RankedLoadout = require(ChickenOrHero.Game:WaitForChild("RankedLoadout"));
local GearCatalog = require(ChickenOrHero.Gear.GearCatalog);
local Skin = require(ChickenOrHero:WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Palette = Skin.Palette;
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local EquipmentHudLayoutLegacy = require(ChickenOrHero.Presentation:WaitForChild("EquipmentHudLayoutLegacy"));
local RankedLoadoutEvent = ChickenOrHero.Game:WaitForChild("RankedLoadoutEvent");
local Loadout = RankedConfig.Loadout;
local Coin = Skin.Assets.Coin;
local Color3_fromRGB_ret = Color3.fromRGB(205, 210, 222);
local u1 = {
    {
        key = "Runner",
        title = "RUNNER ABILITY",
        accent = Color3.fromRGB(255, 196, 64)
    },
    {
        key = "Catcher",
        title = "CHASER ABILITY",
        accent = Color3.fromRGB(255, 86, 96)
    },
    {
        key = "Item",
        title = "ITEM",
        accent = Color3.fromRGB(86, 220, 128)
    }
};
local u2 = {};

local function connect(p3, p4) -- Line: 49
    -- upvalues: u2 (copy)
    table.insert(u2, p3:Connect(p4));
end;

local u5 = Panels.screen(LocalPlayer, "RankedLoadout", 66);

local function label(p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17) -- Line: 56
    -- upvalues: Panels (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p7;
    TextLabel:SetAttribute("SelfManagedText", true);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromOffset(p9, p10);
    TextLabel.Size = UDim2.fromOffset(p11, p12);
    TextLabel.Text = p8;
    TextLabel.TextColor3 = p14;
    TextLabel.Font = p15 or Enum.Font.GothamBold;
    TextLabel.TextScaled = false;
    TextLabel.TextSize = p13;
    TextLabel.TextWrapped = p17 == true;
    TextLabel.TextXAlignment = p16 or Enum.TextXAlignment.Left;
    local v18;

    if p17 then
        v18 = Enum.TextYAlignment.Top;
    else
        v18 = Enum.TextYAlignment.Center;
    end;

    TextLabel.TextYAlignment = v18;
    TextLabel.ZIndex = 4;
    Panels.make("UIStroke", TextLabel, "TextStroke", {
        Thickness = 1.5,
        Color = Color3.new(0, 0, 0),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    });
    TextLabel.Parent = p6;

    return TextLabel;
end;

local function button(p19, p20, p21, p22, p23, p24, p25, p26, p27) -- Line: 80
    -- upvalues: Panels (copy), Skin (copy)
    local v28 = Panels.button(p19, p20, p21, p22, p23, p24, p25, Panels.Ink);
    v28:SetAttribute("SelfManagedText", true);
    v28.TextScaled = false;
    v28.TextSize = p27 or 16;
    v28.Font = Enum.Font.GothamBlack;
    v28.ZIndex = 4;
    Skin.button(v28, p26);

    return v28;
end;

local u29 = button(u5, "Open", "RANKED LOADOUT", 0, 0, 220, 42, "primary", 17);
u29.AnchorPoint = Vector2.new(0.5, 1);
u29.Position = UDim2.new(0.5, 0, 1, -150);
u29.Visible = false;
local u30, u31, v32 = Panels.panel(u5, "Panel", 820, 564);
u31.ClipsDescendants = true;
v32.Position = UDim2.fromOffset(774, 14);
v32.Size = UDim2.fromOffset(32, 30);
v32.TextSize = 22;
v32.ZIndex = 6;
local PropertyChangedSignal = u5:GetPropertyChangedSignal("AbsoluteSize");
table.insert(u2, PropertyChangedSignal:Connect(function() -- Line: 145, Name: fit
    -- upvalues: u5 (copy), u31 (copy)
    local AbsoluteSize = u5.AbsoluteSize;
    u31.Scale.Scale = math.min(1.15, AbsoluteSize.X * 0.96 / 820, AbsoluteSize.Y * 0.94 / 564);
end));
local AbsoluteSize = u5.AbsoluteSize;
u31.Scale.Scale = math.min(1.15, AbsoluteSize.X * 0.96 / 820, AbsoluteSize.Y * 0.94 / 564);
label(u31, "Eyebrow", "RANKED", 24, 12, 200, 18, 16, Palette.gold, Enum.Font.GothamBlack);
local v33 = label(u31, "Heading", "LOADOUT", 24, 28, 300, 40, 36, Palette.text, Enum.Font.GothamBlack);
Panels.make("UIGradient", v33, "Shine", {
    Rotation = 90,
    Color = ColorSequence.new(Palette.text, Palette.gold)
});
local u34 = label(u31, "Sub", "", 24, 70, 520, 20, 16, Color3_fromRGB_ret);
local v35 = Panels.make("Frame", u31, "Timer", {
    BackgroundTransparency = 0.45,
    BorderSizePixel = 0,
    ZIndex = 2,
    Position = UDim2.fromOffset(532, 18),
    Size = UDim2.fromOffset(230, 32),
    BackgroundColor3 = Color3.new(0, 0, 0)
});
Panels.corner(v35, 16);
local u36 = label(v35, "Text", "", 0, 0, 230, 32, 18, Palette.text, Enum.Font.GothamBlack, Enum.TextXAlignment.Center);
local u37 = label(u31, "Left", "100", 546, 58, 130, 34, 32, Palette.gold, Enum.Font.GothamBlack, Enum.TextXAlignment.Right);
label(u31, "LeftCaption", "CREDITS LEFT", 684, 66, 112, 20, 15, Palette.text, Enum.Font.GothamBlack);
local v38 = {
    Runner = {},
    Catcher = {},
    Item = {}
};

local function tile(p39, p40, p41, p42, p43, p44, p45) -- Line: 90
    -- upvalues: Panels (copy), Palette (copy), Skin (copy)
    local v46 = Panels.make("TextButton", p39, p40, {
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0,
        ZIndex = 2,
        Position = UDim2.fromOffset(p41, p42),
        Size = UDim2.fromOffset(p43, p44),
        BackgroundColor3 = Palette.row
    });
    v46:SetAttribute("SelfManagedText", true);
    Panels.corner(v46, 10);
    Skin.card(v46, p45);

    return v46;
end;

local function image(p47, p48, p49, p50, p51, p52) -- Line: 105
    -- upvalues: Panels (copy)
    return Panels.make("ImageLabel", p47, p48, {
        BackgroundTransparency = 1,
        ZIndex = 3,
        Position = UDim2.fromOffset(p50, p51),
        Size = UDim2.fromOffset(p52, p52),
        Image = p49 or "",
        ScaleType = Enum.ScaleType.Fit
    });
end;

local u53 = true;

local function placeOpener() -- Line: 122
    -- upvalues: GuiService (copy), u5 (copy), LocalPlayer (copy), UserInputService (copy), EquipmentHudLayoutLegacy (copy), u29 (copy)
    local Y = GuiService:GetGuiInset().Y;
    local v54 = u5.IgnoreGuiInset and 0 or Y;
    local HUD = LocalPlayer.PlayerGui:FindFirstChild("HUD");
    local v55;

    if HUD then
        v55 = HUD:FindFirstChild("MainFrame");
    else
        v55 = HUD;
    end;

    if v55 then
        v55 = v55:FindFirstChild("BarMainFrame");
    end;

    local v56;

    if v55 then
        if v55.AbsoluteSize.Y > 0 then
            v56 = v55.AbsolutePosition.Y + (HUD.IgnoreGuiInset and 0 or Y);
        else
            v56 = false;
        end;
    else
        v56 = v55;
    end;

    if not UserInputService.TouchEnabled then
        v56 = EquipmentHudLayoutLegacy.rowTop() or v56;
    end;

    if not v56 then
        return;
    end;

    local v57;

    if v55 then
        v57 = v55.AbsolutePosition.X + v55.AbsoluteSize.X / 2;
    else
        v57 = u5.AbsoluteSize.X / 2;
    end;

    u29.Position = UDim2.fromOffset(v57, v56 - v54 - 8);
end;

for i, v in Loadout.Abilities do
    local v58 = GearCatalog.get(i);

    if v58 and (v58.Kind == "Ability" and v38[v58.UseRole]) then
        table.insert(v38[v58.UseRole], {
            id = i,
            cost = v,
            def = v58
        });
    end;
end;

for i, v in Loadout.Items do
    local v59 = GearCatalog.get(i);

    if v59 and v59.Kind == "Item" then
        table.insert(v38.Item, {
            id = i,
            cost = v,
            def = v59
        });
    end;
end;

for _, v in v38 do
    table.sort(v, function(p60, p61) -- Line: 185
        if p60.cost == p61.cost then
            return p60.id < p61.id;
        end;

        return p60.cost > p61.cost;
    end);
end;

local u62 = RankedLoadout.resolve(nil);
local u63 = false;
local u64 = nil;
local u65 = 0;
local u66 = "Runner";
local u67 = false;
local u68 = {};
local u69 = nil;
local u70 = nil;

local function slotCost(p71, p72) -- Line: 201
    -- upvalues: Loadout (copy)
    return p72 ~= "Item" and (Loadout.Abilities[p71[p72]] or 0) or (Loadout.Items[p71.Item] or 0) * p71.Uses;
end;

local function refuse(p73) -- Line: 207
    -- upvalues: u64 (ref), u65 (ref), u69 (ref)
    local v74 = os.clock() + 2.5;
    u64 = p73;
    u65 = v74;
    u69();
end;

local function change(p75) -- Line: 212
    -- upvalues: u63 (ref), Session (copy), u64 (ref), u65 (ref), u69 (ref), u62 (ref), RankedLoadout (copy), RankedConfig (copy), RankedLoadoutEvent (copy)
    if u63 or Session:GetAttribute("RankedLoadoutOpen") ~= true then
        local v76 = os.clock() + 2.5;
        u64 = "Loadouts are locked for this match.";
        u65 = v76;
        u69();

        return false;
    end;

    local table_clone_ret = table.clone(u62);
    p75(table_clone_ret);
    local v77 = RankedLoadout.clean(table_clone_ret);
    local v78 = RankedLoadout.cost(v77) - RankedConfig.Credits;

    if v78 <= 0 then
        u62 = v77;
        u69();
        RankedLoadoutEvent:FireServer("Set", u62);

        return true;
    end;

    local v79 = ("Need %d more credits. Lower another slot first."):format(v78);
    local v80 = os.clock() + 2.5;
    u64 = v79;
    u65 = v80;
    u69();

    return false;
end;

local function picked(p81) -- Line: 231
    -- upvalues: u67 (ref), u1 (copy), u70 (ref)
    if not u67 then
        return;
    end;

    for i, v in u1 do
        if v.key == p81 and u1[i + 1] then
            u70(u1[i + 1].key);

            if u1[i + 1].key == "Item" then
                u67 = false;
            end;

            return;
        end;
    end;
end;

local u82 = {};

for i, v in u1 do
    local v83 = tile(u31, "Slot" .. v.key, 24, 104 + (i - 1) * 131, 250, 118, v.accent);
    label(v83, "Title", i .. "  " .. v.title, 12, 10, 170, 18, 15, v.accent, Enum.Font.GothamBlack);
    local v84 = label(v83, "Cost", "0", 168, 8, 70, 22, 20, Palette.gold, Enum.Font.GothamBlack, Enum.TextXAlignment.Right);
    local v85 = image(v83, "Icon", "", 12, 42, 58);
    local v86 = label(v83, "Name", "", 80, 46, 162, 24, 18, Palette.text, Enum.Font.GothamBlack);
    local v87 = label(v83, "Sub", "", 80, 72, 162, 18, 14, Color3_fromRGB_ret);
    table.insert(u2, v83.Activated:Connect(function() -- Line: 255
        -- upvalues: u67 (ref), u70 (ref), v (copy)
        u67 = false;
        u70(v.key);
    end));
    u82[v.key] = {
        row = v83,
        cost = v84,
        icon = v85,
        name = v86,
        sub = v87
    };
end;

local u88 = button(u31, "Ready", "READY", 24, 494, 250, 52, "primary", 24);
local v89 = Panels.make("Frame", u31, "Picker", {
    BorderSizePixel = 0,
    ZIndex = 1,
    Position = UDim2.fromOffset(290, 104),
    Size = UDim2.fromOffset(506, 442),
    BackgroundColor3 = Palette.row
});
Panels.corner(v89, 12);
Skin.card(v89);
local u90 = label(v89, "Title", "", 16, 8, 260, 26, 22, Palette.text, Enum.Font.GothamBlack);
local u91 = label(v89, "Hint", "", 230, 10, 260, 22, 14, Color3_fromRGB_ret, Enum.Font.GothamBold, Enum.TextXAlignment.Right);
Panels.make("Frame", v89, "Divider", {
    BorderSizePixel = 0,
    ZIndex = 2,
    Position = UDim2.fromOffset(16, 352),
    Size = UDim2.fromOffset(474, 2),
    BackgroundColor3 = Color3.fromRGB(70, 70, 76)
});
local u92 = label(v89, "DetailTitle", "", 16, 360, 474, 22, 17, Palette.text, Enum.Font.GothamBlack);
local u93 = label(v89, "DetailText", "", 16, 386, 474, 50, 16, Color3_fromRGB_ret, Enum.Font.GothamBold, nil, true);
local u94 = {
    Runner = {},
    Catcher = {},
    Item = {}
};

local function optionCard(p95, u96, u97, p98) -- Line: 291
    -- upvalues: tile (copy), image (copy), label (copy), Palette (copy), Coin (copy), Color3_fromRGB_ret (copy), u68 (copy), u62 (ref), change (copy), picked (copy), u69 (ref), u2 (copy), u94 (copy)
    local v99 = tile(p95, u97 and (u97.id or "None") or "None", (p98 - 1) % 4 * 121, (p98 - 1) // 4 * 102, 111, 92);
    local v100 = {
        card = v99,
        option = u97
    };

    if u97 then
        image(v99, "Icon", u97.def.IconImage, 35.5, 4, 40);
        v100.name = label(v99, "Name", u97.def.Name, 3, 43, 105, 28, 13, Palette.text, Enum.Font.GothamBlack, Enum.TextXAlignment.Center, true);
        v100.coin = image(v99, "Coin", Coin, 30.5, 71, 17);
        v100.cost = label(v99, "Cost", tostring(u97.cost), 49.5, 70, 64, 20, 17, Palette.gold, Enum.Font.GothamBlack);
    else
        label(v99, "Glyph", "⊘", 0, 6, 111, 36, 30, Color3_fromRGB_ret, Enum.Font.GothamBlack, Enum.TextXAlignment.Center);
        v100.name = label(v99, "Name", "NONE", 4, 44, 103, 22, 14, Color3_fromRGB_ret, Enum.Font.GothamBlack, Enum.TextXAlignment.Center);
        v100.cost = label(v99, "Cost", "", 0, 68, 111, 20, 14, Color3_fromRGB_ret, Enum.Font.GothamBold, Enum.TextXAlignment.Center);
    end;

    table.insert(u2, v99.Activated:Connect(function() -- Line: 305
        -- upvalues: u68 (ref), u96 (copy), u97 (copy), u62 (ref), change (ref), picked (ref), u69 (ref)
        u68[u96] = u97;

        if u97 and u62[u96] ~= u97.id then
            if change(function(p101) -- Line: 308
                -- upvalues: u96 (ref), u97 (ref)
                p101[u96] = u97.id;

                if u96 == "Item" and p101.Uses == 0 then
                    p101.Uses = 1;
                end;
            end) then
                picked(u96);
            end;
        elseif u97 then
            change(function(p102) -- Line: 317
                -- upvalues: u96 (ref)
                p102[u96] = "";
            end);
        else
            change(function(p103) -- Line: 321
                -- upvalues: u96 (ref)
                p103[u96] = "";

                if u96 == "Item" then
                    p103.Uses = 0;
                end;
            end);
            picked(u96);
        end;

        u69();
    end));
    table.insert(u2, v99.MouseEnter:Connect(function() -- Line: 331
        -- upvalues: u68 (ref), u96 (copy), u97 (copy), u69 (ref)
        u68[u96] = u97;
        u69();
    end));
    table.insert(u94[u96], v100);
end;

local u104 = {};

for _, v in { "Runner", "Catcher", "Item" } do
    local v105 = Panels.make("Frame", v89, v .. "Page", {
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 2,
        Position = UDim2.fromOffset(16, 42),
        Size = UDim2.fromOffset(474, 292)
    });
    local v106 = v;

    for i, v2 in v38[v] do
        optionCard(v105, v106, v2, i);
    end;

    optionCard(v105, v106, nil, #v38[v106] + 1);
    u104[v106] = v105;
end;

local v107 = (#v38.Item + 1 + 3) // 4 * 102 + 6;
label(u104.Item, "UsesTitle", "USES", 0, v107, 60, 36, 18, Palette.text, Enum.Font.GothamBlack);
local u118 = (function(p108, p109, p110, p111, u112) -- Line: 353, Name: stepper
    -- upvalues: button (copy), label (copy), Palette (copy), u2 (copy)
    local v113 = button(p108, p109 .. "Minus", "−", p110, p111, 40, 36, "secondary", 22);
    local v114 = label(p108, p109 .. "Value", "0", p110 + 42, p111, 44, 36, 20, Palette.text, Enum.Font.GothamBlack, Enum.TextXAlignment.Center);
    local v115 = button(p108, p109 .. "Plus", "+", p110 + 88, p111, 40, 36, "secondary", 22);
    table.insert(u2, v113.Activated:Connect(function() -- Line: 357
        -- upvalues: u112 (copy)
        u112(-1);
    end));
    table.insert(u2, v115.Activated:Connect(function() -- Line: 360
        -- upvalues: u112 (copy)
        u112(1);
    end));

    return v114;
end)(u104.Item, "Uses", 60, v107, function(u116) -- Line: 369
    -- upvalues: change (copy), Loadout (copy)
    change(function(p117) -- Line: 370
        -- upvalues: u116 (copy), Loadout (ref)
        p117.Uses = math.clamp(p117.Uses + u116, 0, Loadout.MaxUses);
    end);
end);
local u119 = label(u104.Item, "UsesSum", "", 200, v107, 274, 36, 18, Palette.gold, Enum.Font.GothamBlack);

u70 = function(p120) -- Line: 377
    -- upvalues: u66 (ref), u104 (copy), u69 (ref)
    u66 = p120;

    for i, v in u104 do
        v.Visible = i == p120;
    end;

    u69();
end;

local function lobby() -- Line: 385
    -- upvalues: LocalPlayer (copy)
    local v121;

    if LocalPlayer:GetAttribute("ClientReady") == true then
        v121 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v121 = false;
    end;

    return v121;
end;

local u122 = { "ArmoryOpen", "JourneyOpen", "SettingsOpen", "UpdateLogOpen", "ServerBrowserOpen", "MapVoteOpen", "MatchSummaryVisible", "AdminConsoleActive", "ScreenPresentationActive", "TutorialActive", "StarterPackOpen", "EventIntroActive", "AlbieTalking" };

local function blocked() -- Line: 403
    -- upvalues: u122 (copy), LocalPlayer (copy)
    for _, v in u122 do
        if LocalPlayer:GetAttribute(v) then
            return true;
        end;
    end;

    return false;
end;

local function available() -- Line: 411
    -- upvalues: Session (copy), LocalPlayer (copy)
    local v123;

    if Session:GetAttribute("RankedLoadoutOpen") == true and LocalPlayer:GetAttribute("ClientReady") == true then
        v123 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v123 = false;
    end;

    return v123;
end;

local u124 = setmetatable({}, {
    __mode = "k"
});

local function look(p125, p126, p127) -- Line: 417
    -- upvalues: u124 (copy), Skin (copy), Palette (copy)
    local v128 = u124[p125];

    if v128 and (v128.on == p126 and v128.dimmed == p127) then
        return;
    end;

    u124[p125] = {
        on = p126,
        dimmed = p127
    };
    Skin.select(p125, p126, Palette.gold);
    Skin.dim(p125, p127);
end;

u69 = function() -- Line: 427
    -- upvalues: u53 (ref), RankedConfig (copy), RankedLoadout (copy), u62 (ref), u37 (copy), Palette (copy), u1 (copy), u82 (copy), Loadout (copy), GearCatalog (copy), look (copy), u66 (ref), u90 (copy), u91 (copy), u94 (copy), u118 (copy), u119 (copy), u68 (copy), u92 (copy), u93 (copy), u64 (ref), u65 (ref), u34 (copy), Session (copy), u63 (ref), u36 (copy)
    if not u53 then
        return;
    end;

    local v129 = RankedConfig.Credits - RankedLoadout.cost(u62);
    u37.Text = tostring(v129);
    local v130;

    if v129 == 0 then
        v130 = Palette.green;
    else
        v130 = Palette.gold;
    end;

    u37.TextColor3 = v130;

    for _, v in u1 do
        local v131 = u82[v.key];
        local v132 = u62;
        local key = v.key;
        local v133;

        if key == "Item" then
            v133 = (Loadout.Items[v132.Item] or 0) * v132.Uses;
        else
            v133 = Loadout.Abilities[v132[key]] or 0;
        end;

        v131.cost.Text = tostring(v133);
        local v134 = GearCatalog.get(u62[v.key]);
        v131.icon.Image = v134 and (v134.IconImage or "") or "";
        v131.name.Text = not v134 and "NONE" or v134.Name;
        local sub = v131.sub;
        local v135;

        if v134 then
            if v.key == "Item" then
                v135 = u62.Uses .. (u62.Uses == 1 and " use" or " uses");
            else
                v135 = ("%ds cooldown"):format(v134.Cooldown or 0);
            end;
        else
            v135 = "Tap to pick one";
        end;

        sub.Text = v135;
        local v136;

        if v131.name.Text == "NONE" then
            v136 = Palette.textSecondary;
        else
            v136 = Palette.text;
        end;

        v131.name.TextColor3 = v136;
        look(v131.row, u66 == v.key, false);
    end;

    local v137 = nil;

    for _, v in u1 do
        if v.key == u66 then
            v137 = v;
        end;
    end;

    u90.Text = v137.title;
    u90.TextColor3 = v137.accent;
    u91.Text = u66 == "Item" and "Price per use" or "Tap to pick · tap again to remove";

    if u94[u66] then
        local v138 = u62[u66];
        local v139 = u62;
        local v140 = u66;
        local v141;

        if v140 == "Item" then
            v141 = (Loadout.Items[v139.Item] or 0) * v139.Uses;
        else
            v141 = Loadout.Abilities[v139[v140]] or 0;
        end;

        for _, v in u94[u66] do
            local option = v.option;
            local v142;

            if option then
                v142 = v138 == option.id;
            else
                v142 = v138 == "";
            end;

            if option then
                local v143 = option.cost * (u66 ~= "Item" and 1 or math.max(1, u62.Uses)) - v141 - v129;
                local v144 = v142 or v143 <= 0;
                local cost = v.cost;
                local v145;

                if v144 then
                    v145 = tostring(option.cost);
                else
                    v145 = "NEED " .. v143;
                end;

                cost.Text = v145;
                local v146;

                if v144 then
                    v146 = Palette.gold;
                else
                    v146 = Palette.danger;
                end;

                v.cost.TextColor3 = v146;
                v.coin.Visible = v144;
                v.cost.Position = UDim2.fromOffset(v144 and 49.5 or 0, 70);
                v.cost.Size = UDim2.fromOffset(v144 and 64 or 111, 20);
                local v147;

                if v144 then
                    v147 = Enum.TextXAlignment.Left;
                else
                    v147 = Enum.TextXAlignment.Center;
                end;

                v.cost.TextXAlignment = v147;
                look(v.card, v142, not v142 and v143 > 0);
            else
                v.cost.Text = v141 <= 0 and "" or "saves " .. v141;
                look(v.card, v142, false);
            end;
        end;
    end;

    u118.Text = tostring(u62.Uses);
    local v148;

    if u62.Item == "" then
        v148 = "Pick an item first";
    else
        local v149 = u62;
        v148 = ("%d × %d = %d CREDITS"):format(u62.Uses, Loadout.Items[u62.Item] or 0, (Loadout.Items[v149.Item] or 0) * v149.Uses);
    end;

    u119.Text = v148;
    local v150 = u68[u66];

    if v150 == nil and u94[u66] then
        for _, v in u94[u66] do
            if v.option and v.option.id == u62[u66] then
                v150 = v.option;
            end;
        end;
    end;

    if v150 then
        local def = v150.def;
        local v151;

        if def.Kind == "Item" then
            v151 = ("%s  ·  %d CREDITS A USE  ·  %ds COOLDOWN"):format(def.Name, v150.cost, def.Cooldown or 0);
        else
            v151 = ("%s  ·  %d CREDITS  ·  %ds COOLDOWN"):format(def.Name, v150.cost, def.Cooldown or 0);
        end;

        u92.Text = v151;
        u93.Text = def.Description or "";
    else
        u92.Text = "NONE";
        u93.Text = "Leave this slot empty and spend the credits somewhere else.";
    end;

    if u64 and os.clock() < u65 then
        u34.Text = u64;
        u34.TextColor3 = Palette.danger;
    else
        u34.Text = ("Same %d credits for everyone. What you own doesn\'t count."):format(RankedConfig.Credits);
        u34.TextColor3 = Palette.textSecondary;
    end;

    local Attribute = Session:GetAttribute("Phase");
    local Attribute2 = Session:GetAttribute("EndsAt");
    local v152;

    if type(Attribute2) == "number" and Attribute2 > 0 then
        local v153 = Attribute2 - workspace:GetServerTimeNow();
        local math_ceil_ret = math.ceil(v153);
        v152 = math.max(0, math_ceil_ret);
    else
        v152 = nil;
    end;

    if u63 or Session:GetAttribute("RankedLoadoutOpen") ~= true then
        u36.Text = "LOCKED";
        u36.TextColor3 = Palette.textSecondary;

        return;
    end;

    if Attribute == "Countdown" and v152 then
        u36.Text = ("LOCKS IN %ds"):format(v152);
        u36.TextColor3 = Palette.danger;

        return;
    end;

    if Attribute ~= "RankedLoadout" or not v152 then
        if Attribute == "RankedLoadout" then
            u36.Text = ("%d / %d READY"):format(Session:GetAttribute("RankedReady") or 0, Session:GetAttribute("RankedReadyNeed") or 1);
            u36.TextColor3 = Palette.gold;

            return;
        end;

        u36.Text = "LOCKS AS THE MATCH STARTS";
        u36.TextColor3 = Palette.text;

        return;
    end;

    u36.Text = ("MAP VOTE IN %ds"):format(v152);
    local v154;

    if v152 <= 5 then
        v154 = Palette.danger;
    else
        v154 = Palette.text;
    end;

    u36.TextColor3 = v154;
end;

local u155 = false;
local u156 = nil;

local function hide() -- Line: 538
    -- upvalues: u30 (copy), LocalPlayer (copy), GuiService (copy), u5 (copy), u156 (ref)
    if u30.Visible then
        u30.Visible = false;
        LocalPlayer:SetAttribute("RankedLoadoutOpen", nil);

        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u5) then
            GuiService.SelectedObject = u156 and (u156.Parent and u156) or nil;
        end;
    end;
end;

local function show(p157) -- Line: 547
    -- upvalues: Session (copy), LocalPlayer (copy), u30 (copy), HudNavigation (copy), u156 (ref), GuiService (copy), u155 (ref), u67 (ref), u68 (copy), u70 (ref), u5 (copy), u31 (copy), u69 (ref), RankedLoadoutEvent (copy), UserInputService (copy), u88 (copy)
    local v158;

    if Session:GetAttribute("RankedLoadoutOpen") == true and LocalPlayer:GetAttribute("ClientReady") == true then
        v158 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v158 = false;
    end;

    if not v158 or u30.Visible then
        return;
    end;

    HudNavigation.opening("RankedLoadout");
    u156 = GuiService.SelectedObject;

    if p157 then
        u155 = false;
        u67 = true;
        table.clear(u68);
        u70("Runner");
    end;

    u30.Visible = true;
    LocalPlayer:SetAttribute("RankedLoadoutOpen", true);
    local AbsoluteSize2 = u5.AbsoluteSize;
    u31.Scale.Scale = math.min(1.15, AbsoluteSize2.X * 0.96 / 820, AbsoluteSize2.Y * 0.94 / 564);
    u69();
    RankedLoadoutEvent:FireServer("Get");

    if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        GuiService.SelectedObject = u88;
    end;
end;

table.insert(u2, u29.Activated:Connect(function() -- Line: 568
    -- upvalues: show (copy)
    show(false);
end));
table.insert(u2, v32.Activated:Connect(hide));
table.insert(u2, u88.Activated:Connect(function() -- Line: 572
    -- upvalues: u155 (ref), RankedLoadoutEvent (copy), u30 (copy), LocalPlayer (copy), GuiService (copy), u5 (copy), u156 (ref)
    u155 = true;
    RankedLoadoutEvent:FireServer("Ready");

    if u30.Visible then
        u30.Visible = false;
        LocalPlayer:SetAttribute("RankedLoadoutOpen", nil);

        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u5) then
            GuiService.SelectedObject = u156 and (u156.Parent and u156) or nil;
        end;
    end;
end));
table.insert(u2, HudNavigation.Opening.Event:Connect(function(p159) -- Line: 577
    -- upvalues: u30 (copy), LocalPlayer (copy), GuiService (copy), u5 (copy), u156 (ref)
    if p159 ~= "RankedLoadout" and u30.Visible then
        u30.Visible = false;
        LocalPlayer:SetAttribute("RankedLoadoutOpen", nil);

        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u5) then
            GuiService.SelectedObject = u156 and (u156.Parent and u156) or nil;
        end;
    end;
end));
local u160 = {
    [Enum.KeyCode.One] = 1,
    [Enum.KeyCode.Two] = 2,
    [Enum.KeyCode.Three] = 3
};
table.insert(u2, UserInputService.InputBegan:Connect(function(p161, p162) -- Line: 584
    -- upvalues: u30 (copy), LocalPlayer (copy), GuiService (copy), u5 (copy), u156 (ref), u1 (copy), u66 (ref), u160 (copy), u67 (ref), u70 (ref)
    if not u30.Visible then
        return;
    end;

    if p161.KeyCode == Enum.KeyCode.Escape or p161.KeyCode == Enum.KeyCode.ButtonB then
        if u30.Visible then
            u30.Visible = false;
            LocalPlayer:SetAttribute("RankedLoadoutOpen", nil);

            if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u5) then
                GuiService.SelectedObject = u156 and (u156.Parent and u156) or nil;
            end;
        end;

        return;
    end;

    if p162 then
        return;
    end;

    local v163 = nil;

    for i, v in u1 do
        if v.key == u66 then
            v163 = i;
        end;
    end;

    local v164;

    if u160[p161.KeyCode] then
        v164 = u160[p161.KeyCode];
    elseif p161.KeyCode == Enum.KeyCode.ButtonL1 then
        v164 = math.max(1, v163 - 1);
    else
        if p161.KeyCode ~= Enum.KeyCode.ButtonR1 then
            return;
        end;

        v164 = math.min(#u1, v163 + 1);
    end;

    u67 = false;
    u70(u1[v164].key);
end));
table.insert(u2, RankedLoadoutEvent.OnClientEvent:Connect(function(p165, p166) -- Line: 613
    -- upvalues: u62 (ref), RankedLoadout (copy), u63 (ref), u155 (ref), u88 (copy), u64 (ref), u65 (ref), u69 (ref)
    if p165 == "State" and type(p166) == "table" then
        u62 = RankedLoadout.clean(p166.loadout);
        u63 = p166.locked == true;
        u155 = p166.ready == true;
        u88.Text = u155 and "READY  ✓" or "READY";

        if p166.message then
            local message = p166.message;
            local v167 = os.clock() + 2.5;
            u64 = message;
            u65 = v167;
            u69();
        end;

        u69();
    end;
end));
local u168 = false;
local u169 = nil;
local u170 = false;

local function autoOpen() -- Line: 629
    -- upvalues: Session (copy), LocalPlayer (copy), u170 (ref), u168 (ref), u122 (copy), u30 (copy), u169 (ref), show (copy)
    local v171;

    if Session:GetAttribute("RankedLoadoutOpen") == true and LocalPlayer:GetAttribute("ClientReady") == true then
        v171 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v171 = false;
    end;

    if v171 and not u170 then
        u168 = true;
    end;

    u170 = v171;

    if v171 then
        local v172 = false;

        for _, v in u122 do
            if LocalPlayer:GetAttribute(v) then
                v172 = true;
                break;
            end;
        end;

        if not (v172 or u30.Visible) then
            local Attribute = Session:GetAttribute("RankedPickId");

            if Session:GetAttribute("Phase") ~= "RankedLoadout" or u169 == Attribute then
                if u168 then
                    u168 = false;
                    show(true);
                end;

                return;
            end;

            u169 = Attribute;
            u168 = false;
            show(true);
        end;
    end;
end;

local AttributeChangedSignal = Session:GetAttributeChangedSignal("RankedLoadoutOpen");
table.insert(u2, AttributeChangedSignal:Connect(function() -- Line: 648
    -- upvalues: RankedLoadoutEvent (copy)
    RankedLoadoutEvent:FireServer("Get");
end));
local u173 = 0;
table.insert(u2, RunService.Heartbeat:Connect(function(p174) -- Line: 652
    -- upvalues: u173 (ref), autoOpen (copy), Session (copy), LocalPlayer (copy), u29 (copy), u30 (copy), u122 (copy), u155 (ref), placeOpener (copy), GuiService (copy), u5 (copy), u156 (ref), u69 (ref)
    u173 = u173 + p174;

    if u173 < 0.2 then
        return;
    end;

    u173 = 0;
    autoOpen();
    local v175;

    if Session:GetAttribute("RankedLoadoutOpen") == true and LocalPlayer:GetAttribute("ClientReady") == true then
        v175 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v175 = false;
    end;

    local v176;

    if v175 then
        v176 = not u30.Visible;

        if v176 then
            local v177 = false;

            for _, v in u122 do
                if LocalPlayer:GetAttribute(v) then
                    v177 = true;
                    break;
                end;
            end;

            v176 = not v177;
        end;
    else
        v176 = v175;
    end;

    u29.Visible = v176;
    u29.Text = u155 and "LOADOUT  ✓" or "RANKED LOADOUT";

    if u29.Visible then
        placeOpener();
    end;

    if u30.Visible then
        if v175 then
            local v178 = false;

            for _, v in u122 do
                if LocalPlayer:GetAttribute(v) then
                    v178 = true;
                    break;
                end;
            end;

            if v178 then
                if u30.Visible then
                    u30.Visible = false;
                    LocalPlayer:SetAttribute("RankedLoadoutOpen", nil);

                    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u5) then
                        GuiService.SelectedObject = u156 and (u156.Parent and u156) or nil;
                    end;
                end;
            else
                u69();
            end;
        elseif u30.Visible then
            u30.Visible = false;
            LocalPlayer:SetAttribute("RankedLoadoutOpen", nil);

            if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u5) then
                GuiService.SelectedObject = u156 and (u156.Parent and u156) or nil;
            end;
        end;
    end;
end));
script.Destroying:Connect(function() -- Line: 673
    -- upvalues: u53 (ref), u2 (copy), u30 (copy), LocalPlayer (copy), GuiService (copy), u5 (copy), u156 (ref)
    u53 = false;

    for _, v in u2 do
        v:Disconnect();
    end;

    if u30.Visible then
        u30.Visible = false;
        LocalPlayer:SetAttribute("RankedLoadoutOpen", nil);

        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u5) then
            GuiService.SelectedObject = u156 and (u156.Parent and u156) or nil;
        end;
    end;

    u5:Destroy();
end);
u70("Runner");
RankedLoadoutEvent:FireServer("Get");