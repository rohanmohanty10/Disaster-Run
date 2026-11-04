 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local TutorialConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("TutorialConfig"));
local HudNavigation = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local SkinCatalog = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("SkinCatalog"));
local MapLocator = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("MapLocator"));
local ArmoryEvent = ChickenOrHero.Weapons:WaitForChild("ArmoryEvent");
local CrateCatalog = require(ChickenOrHero:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
local HalloweenCrateShow = require(ChickenOrHero.Presentation:WaitForChild("HalloweenCrateShow"));
local u1 = nil;
local u2 = nil;

local function setCrate() -- Line: 24
    -- upvalues: u1 (ref), CrateCatalog (copy), LocalPlayer (copy), TutorialConfig (copy), u2 (ref)
    u1 = CrateCatalog.get(LocalPlayer:GetAttribute("TutorialCrate") or TutorialConfig.Crate);
    local v3;

    if u1 == nil then
        v3 = false;
    else
        v3 = u1.Halloween == true;
    end;

    u2 = v3;
end;

u1 = CrateCatalog.get(LocalPlayer:GetAttribute("TutorialCrate") or TutorialConfig.Crate);
local v4;

if u1 == nil then
    v4 = false;
else
    v4 = u1.Halloween == true;
end;

u2 = v4;
LocalPlayer:GetAttributeChangedSignal("TutorialCrate"):Connect(setCrate);
local Color3_fromRGB_ret = Color3.fromRGB(255, 214, 92);
local Color3_fromRGB_ret2 = Color3.fromRGB(110, 235, 120);
local Color3_fromRGB_ret3 = Color3.fromRGB(14, 20, 28);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local UserInputService = game:GetService("UserInputService");
local u5 = {};
local u6 = nil;
local u7 = nil;
local u8 = {};
local u9 = nil;
local u10 = nil;
local u11 = nil;

local function on(p12, p13) -- Line: 52
    -- upvalues: u5 (copy)
    table.insert(u5, p12:Connect(p13));
end;

local function shown(p14) -- Line: 60
    -- upvalues: PlayerGui (copy)
    if not (p14 and p14:IsA("GuiObject")) then
        return false;
    end;

    local v15 = p14;

    while p14 and p14 ~= PlayerGui do
        if p14:IsA("GuiObject") and not p14.Visible then
            return false;
        end;

        if p14:IsA("LayerCollector") and not p14.Enabled then
            return false;
        end;

        p14 = p14.Parent;
    end;

    local v16;

    if p14 == PlayerGui and v15.AbsoluteSize.X > 1 then
        v16 = v15.AbsoluteSize.Y > 1;
    else
        v16 = false;
    end;

    return v16;
end;

local function child(p17, ...) -- Line: 76
    for _, v in { ... } do
        if p17 then
            p17 = p17:FindFirstChild(v);
        end;
    end;

    return p17;
end;

local function newKnife() -- Line: 85
    -- upvalues: LocalPlayer (copy), u8 (ref)
    local Attribute = LocalPlayer:GetAttribute("TutorialKnife");

    if type(Attribute) == "string" and u8[Attribute] ~= false then
        return Attribute;
    end;

    return nil;
end;

local function menuPath() -- Line: 94
    -- upvalues: PlayerGui (copy), child (copy), shown (copy)
    local ValleyHUD = PlayerGui:FindFirstChild("ValleyHUD");
    local v18 = child(ValleyHUD, "DrawerClip", "Panel", "Navigation", "Inventory");

    if v18 and (v18.Active and shown(v18)) then
        return v18, "KNIVES";
    end;

    if ValleyHUD then
        ValleyHUD = ValleyHUD:FindFirstChild("MenuToggle");
    end;

    return shown(ValleyHUD) and ValleyHUD and ValleyHUD or nil, "MENU";
end;

local function cardButton(p19, p20, p21) -- Line: 105
    -- upvalues: shown (copy)
    for _, descendant in p19:GetDescendants() do
        if descendant.Name == "GearShop" then
            local v22 = descendant:FindFirstChild(p20);
            local v23;

            if v22 then
                v23 = v22:FindFirstChild(p21);
            else
                v23 = v22;
            end;

            if shown(v23) then
                return v23, v22;
            end;
        end;
    end;

    return nil;
end;

local function storeCrateBuy() -- Line: 120
    -- upvalues: LocalPlayer (copy), u1 (ref), child (copy), PlayerGui (copy), shown (copy)
    if LocalPlayer:GetAttribute("HalloweenShopOpen") ~= true or not u1 then
        return nil;
    end;

    local v24 = child(PlayerGui, "HalloweenShop", "HalloweenShop", "Stage");
    local string_upper_ret = string.upper(u1.Name);

    for _, v in v24 and v24:GetChildren() or {} do
        local Buy = v:FindFirstChild("Buy");

        if Buy then
            local v25 = v;

            for _, descendant in v:GetDescendants() do
                if descendant:IsA("TextLabel") and descendant.Text == string_upper_ret then
                    return shown(Buy) and Buy and Buy or nil, v25;
                end;
            end;
        end;
    end;

    return nil;
end;

local function resolve(p26) -- Line: 140
    -- upvalues: HalloweenCrateShow (copy), u2 (ref), storeCrateBuy (copy), LocalPlayer (copy), child (copy), PlayerGui (copy), shown (copy), menuPath (copy), u8 (ref), SkinCatalog (copy), TutorialConfig (copy), cardButton (copy)
    if HalloweenCrateShow.activeMine() > 0 then
        return nil;
    end;

    if u2 then
        if p26 == "Crate" then
            local v27, v28 = storeCrateBuy();

            if v27 then
                return v27, "FREE", v28;
            end;

            return nil;
        end;

        local v29;

        if LocalPlayer:GetAttribute("HalloweenShopOpen") == true then
            v29 = child(PlayerGui, "HalloweenShop", "HalloweenShop", "Stage", "CloseButton");
        else
            v29 = false;
        end;

        if v29 and shown(v29) then
            return v29, "CLOSE";
        end;
    end;

    local Crates = PlayerGui:FindFirstChild("Crates");
    local v30;

    if Crates then
        v30 = Crates:FindFirstChild("Free", true);
    else
        v30 = Crates;
    end;

    local v31;

    if Crates then
        v31 = Crates:FindFirstChild("Close", true);
    else
        v31 = Crates;
    end;

    local v32;

    if Crates then
        v32 = Crates:FindFirstChild("Continue", true);
    else
        v32 = Crates;
    end;

    if shown(v32) then
        return v32, "CONTINUE";
    end;

    local v33;

    if Crates then
        v33 = Crates:FindFirstChild("Reveal", true);
    else
        v33 = Crates;
    end;

    if shown(v33) then
        return nil;
    end;

    if p26 == "Crate" then
        if Crates then
            Crates = child(Crates, "CollectionShade", "Collection", "Gems");
        end;

        if shown(Crates) then
            return Crates, "FREE";
        end;

        if shown(v30) then
            return v30, "FREE";
        end;

        return nil;
    end;

    if shown(v31) then
        return v31, "CLOSE";
    end;

    local v34 = child(PlayerGui:FindFirstChild("ValleyArmory"), "Overlay", "Canvas");

    if LocalPlayer:GetAttribute("ArmoryOpen") ~= true or not v34 then
        return menuPath();
    end;

    local Tabs = v34:FindFirstChild("Tabs");

    if p26 ~= "Knife" then
        local v35 = p26 == "RunnerAbility" and TutorialConfig.RunnerAbility or (p26 == "ChaserAbility" and TutorialConfig.ChaserAbility or TutorialConfig.Item);
        local v36, v37 = cardButton(v34, v35, p26 == "BuyAdrenaline" and "Coins" or "Gems");

        if v36 then
            return v36, "FREE", v37;
        end;

        local v38, v39 = cardButton(v34, v35, "Equip");

        if v38 then
            return v38, "EQUIP", v39;
        end;

        local v40 = (p26 == "RunnerAbility" or p26 == "ChaserAbility") and "Abilities" or "Items";

        return child(Tabs, v40), string.upper(v40);
    end;

    local KnifeCollection = v34:FindFirstChild("KnifeCollection");

    if not shown(KnifeCollection) then
        return child(Tabs, "Inventory"), "MY KNIVES";
    end;

    local Attribute = LocalPlayer:GetAttribute("TutorialKnife");

    if type(Attribute) ~= "string" or u8[Attribute] == false then
        Attribute = nil;
    end;

    local v41;

    if Attribute then
        v41 = KnifeCollection:FindFirstChild(Attribute, true);
    else
        v41 = Attribute;
    end;

    local v42 = child(v34, "Details", "Action");

    if Attribute then
        Attribute = SkinCatalog.get(Attribute);
    end;

    local v43 = false;

    for _, descendant in (v34:FindFirstChild("Details") or KnifeCollection):GetDescendants() do
        if Attribute and (descendant:IsA("TextLabel") and string.upper(descendant.Text) == string.upper(Attribute.Name)) then
            v43 = true;
            break;
        end;
    end;

    if v43 and shown(v42) then
        return v42, "EQUIP", v41;
    end;

    local v44;

    if v41 then
        v44 = v41:FindFirstChild("Pick") or v41;
    else
        v44 = v41;
    end;

    return shown(v44) and v44 and v44 or nil, "YOUR NEW KNIFE", v41;
end;

local function make(p45, p46, p47) -- Line: 236
    local Instance_new_ret = Instance.new(p45);

    for i, v in p47 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p46;

    return Instance_new_ret;
end;

local function label(p48, p49) -- Line: 245
    -- upvalues: Font_new_ret (copy)
    p49.BackgroundTransparency = 1;
    p49.FontFace = p49.FontFace or Font_new_ret;
    local TextLabel = Instance.new("TextLabel");

    for i, v in p49 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p48;

    return TextLabel;
end;

local function gradient(p50, p51, p52) -- Line: 251
    local v53 = {
        Rotation = 90,
        Color = ColorSequence.new(p51, p52)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v53 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = p50;

    return UIGradient;
end;

local function objectiveCard(p54) -- Line: 256
    -- upvalues: Color3_fromRGB_ret (copy), Font_new_ret2 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret (copy), TutorialConfig (copy)
    local v55 = {
        Name = "Objective",
        BackgroundTransparency = 0.04,
        ZIndex = 8,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 84),
        Size = UDim2.fromOffset(440, 68),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v55 do
        Frame[i] = v;
    end;

    Frame.Parent = p54;
    local v56 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v56 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v57 = {
        Thickness = 2,
        Transparency = 0.1,
        Color = Color3_fromRGB_ret
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v57 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local Color3_fromRGB_ret4 = Color3.fromRGB(44, 56, 76);
    local Color3_fromRGB_ret5 = Color3.fromRGB(15, 20, 30);
    local v58 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret4, Color3_fromRGB_ret5)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v58 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    local v59 = {
        Name = "Badge",
        ZIndex = 9,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 12, 0.5, 0),
        Size = UDim2.fromOffset(44, 44),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v59 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v60 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v60 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v61 = {
        Thickness = 2,
        Color = Color3.fromRGB(130, 86, 12)
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v61 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame2;
    local Color3_fromRGB_ret6 = Color3.fromRGB(255, 238, 150);
    local Color3_fromRGB_ret7 = Color3.fromRGB(240, 168, 38);
    local v62 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret6, Color3_fromRGB_ret7)
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v62 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame2;
    local UIScale2 = Instance.new("UIScale");

    for i, v in {} do
        UIScale2[i] = v;
    end;

    UIScale2.Parent = Frame2;
    local v63 = {
        TextSize = 24,
        Text = "1",
        ZIndex = 10,
        Size = UDim2.fromScale(1, 1),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret3,
        BackgroundTransparency = 1
    };
    v63.FontFace = v63.FontFace or Font_new_ret;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v63 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame2;
    local v64 = {
        Name = "Title",
        TextSize = 12,
        Text = "FIRST STEPS",
        ZIndex = 9,
        Position = UDim2.fromOffset(68, 8),
        Size = UDim2.new(1, -82, 0, 14),
        TextColor3 = Color3_fromRGB_ret,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1
    };
    v64.FontFace = v64.FontFace or Font_new_ret;
    local TextLabel2 = Instance.new("TextLabel");

    for i, v in v64 do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = Frame;
    local v65 = {
        Name = "Count",
        TextSize = 11,
        Text = "",
        ZIndex = 9,
        Position = UDim2.fromOffset(68, 8),
        Size = UDim2.new(1, -82, 0, 14),
        TextColor3 = Color3.fromRGB(160, 172, 190),
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1
    };
    v65.FontFace = v65.FontFace or Font_new_ret;
    local TextLabel3 = Instance.new("TextLabel");

    for i, v in v65 do
        TextLabel3[i] = v;
    end;

    TextLabel3.Parent = Frame;
    local v66 = {
        Name = "Text",
        TextScaled = true,
        Text = "",
        ZIndex = 9,
        Position = UDim2.new(0, 68, 0.5, -10),
        Size = UDim2.new(1, -82, 0, 22),
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1
    };
    v66.FontFace = v66.FontFace or Font_new_ret;
    local TextLabel4 = Instance.new("TextLabel");

    for i, v in v66 do
        TextLabel4[i] = v;
    end;

    TextLabel4.Parent = Frame;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 20,
        MinTextSize = 11
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = TextLabel4;
    local v67 = {
        Name = "Progress",
        BackgroundTransparency = 1,
        ZIndex = 9,
        Position = UDim2.new(0, 68, 1, -13),
        Size = UDim2.new(1, -82, 0, 6)
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v67 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local v68 = {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local UIListLayout = Instance.new("UIListLayout");

    for i, v in v68 do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame3;
    local v69 = #TutorialConfig.Steps;
    local v70 = {};

    for i = 1, v69 do
        local v71 = {
            BorderSizePixel = 0,
            ZIndex = 9,
            LayoutOrder = i,
            Size = UDim2.new(1 / v69, (v69 - 1) * -4 / v69, 1, 0),
            BackgroundColor3 = Color3.fromRGB(64, 76, 96)
        };
        local Frame4 = Instance.new("Frame");

        for i2, v in v71 do
            Frame4[i2] = v;
        end;

        Frame4.Parent = Frame3;
        local v72 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner3 = Instance.new("UICorner");

        for i2, v in v72 do
            UICorner3[i2] = v;
        end;

        UICorner3.Parent = Frame4;
        v70[i] = Frame4;
    end;

    return {
        banner = Frame,
        scale = UIScale,
        pop = UIScale2,
        number = TextLabel,
        count = TextLabel3,
        text = TextLabel4,
        pips = v70
    };
end;

local function build() -- Line: 348
    -- upvalues: objectiveCard (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret (copy), PlayerGui (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "TutorialGuide";
    ScreenGui.ClipToDeviceSafeArea = false;
    ScreenGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
    ScreenGui:SetAttribute("SelfManagedText", true);
    ScreenGui:SetAttribute("LightsOutKeep", true);
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 250;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    local v73 = objectiveCard(ScreenGui);
    v73.gui = ScreenGui;
    v73.dim = {};

    for i = 1, 4 do
        local dim = v73.dim;
        local v74 = {
            Name = "Dim",
            Active = false,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 1,
            BackgroundColor3 = Color3.new(0, 0, 0)
        };
        local Frame = Instance.new("Frame");

        for i2, v in v74 do
            Frame[i2] = v;
        end;

        Frame.Parent = ScreenGui;
        dim[i] = Frame;
    end;

    local function outline(p75, p76, p77, p78) -- Line: 380
        -- upvalues: ScreenGui (copy)
        local Frame = Instance.new("Frame");

        for i, v in {
            BackgroundTransparency = 1,
            Visible = false,
            Name = p75,
            ZIndex = p78
        } do
            Frame[i] = v;
        end;

        Frame.Parent = ScreenGui;
        local UICorner = Instance.new("UICorner");

        for i, v in {} do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame;
        local UIStroke = Instance.new("UIStroke");

        for i, v in {
            Color = p76,
            Thickness = p77
        } do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = Frame;

        return Frame, UICorner, UIStroke;
    end;

    local v79, v80, v81 = outline("Highlight", Color3_fromRGB_ret, 3, 3);
    v73.hole = v79;
    v73.holeCorner = v80;
    v73.holeStroke = v81;
    local v82, v83, v84 = outline("Glow", Color3_fromRGB_ret, 8, 2);
    v73.glow = v82;
    v73.glowCorner = v83;
    v73.glowStroke = v84;
    local v85, v86, v87 = outline("Button", Color3_fromRGB_ret, 2, 3);
    v73.ring = v85;
    v73.ringCorner = v86;
    v73.ringStroke = v87;
    local v88, v89, v90 = outline("Ripple", Color3.new(1, 1, 1), 2, 3);
    v73.ripple = v88;
    v73.rippleCorner = v89;
    v73.rippleStroke = v90;
    local v91, v92, v93 = outline("Card", Color3_fromRGB_ret2, 3, 3);
    v73.card = v91;
    v73.cardCorner = v92;
    v73.cardStroke = v93;
    local v94 = {
        Name = "Pointer",
        BackgroundTransparency = 1,
        Image = "rbxassetid://129313102318934",
        Visible = false,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(52, 52),
        ImageColor3 = Color3_fromRGB_ret
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v94 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = ScreenGui;
    v73.pointer = ImageLabel;
    local pointer = v73.pointer;
    local v95 = {
        Name = "Shadow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://129313102318934",
        ImageTransparency = 0.55,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 3),
        Size = UDim2.fromScale(1.08, 1.08),
        ImageColor3 = Color3.new(0, 0, 0)
    };
    local ImageLabel2 = Instance.new("ImageLabel");

    for i, v in v95 do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = pointer;
    local v96 = {
        Name = "Hint",
        Visible = false,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, 30),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v96 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    v73.hint = Frame;
    local hint = v73.hint;
    local v97 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v97 do
        UICorner[i] = v;
    end;

    UICorner.Parent = hint;
    local hint2 = v73.hint;
    local v98 = {
        Thickness = 2,
        Color = Color3.fromRGB(110, 70, 8)
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v98 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = hint2;
    local hint3 = v73.hint;
    local v99 = {
        PaddingLeft = UDim.new(0, 14),
        PaddingRight = UDim.new(0, 14)
    };
    local UIPadding = Instance.new("UIPadding");

    for i, v in v99 do
        UIPadding[i] = v;
    end;

    UIPadding.Parent = hint3;
    local hint4 = v73.hint;
    local Color3_fromRGB_ret4 = Color3.fromRGB(255, 236, 150);
    local Color3_fromRGB_ret5 = Color3.fromRGB(242, 176, 48);
    local v100 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret4, Color3_fromRGB_ret5)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v100 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = hint4;
    local hint5 = v73.hint;
    local v101 = {
        TextSize = 15,
        Text = "",
        ZIndex = 7,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromScale(0, 1),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret3,
        BackgroundTransparency = 1
    };
    v101.FontFace = v101.FontFace or Font_new_ret;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v101 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = hint5;
    v73.hintText = TextLabel;
    ScreenGui.Parent = PlayerGui;

    return v73;
end;

local function crateStand() -- Line: 439
    -- upvalues: u2 (ref), MapLocator (copy), u1 (ref)
    local v102;

    if u2 then
        v102 = workspace:FindFirstChild("HalloweenStore");
    else
        v102 = MapLocator.interactable(u1 and u1.WorldModel or "BasicCrate");
    end;

    local v103;

    if v102 then
        v103 = v102:FindFirstChildWhichIsA("ProximityPrompt", true);
    else
        v103 = v102;
    end;

    if v103 then
        v103 = v103.Parent;
    end;

    local v104;

    if u2 and (v102 and u1) then
        v104 = v102:FindFirstChild(u1.WorldModel) or nil;
    else
        v104 = nil;
    end;

    if not (v103 and (v103:IsA("Attachment") and v103)) then
        v103 = nil;
    end;

    return v102, v103, v104;
end;

local function showWorld(p105) -- Line: 446
    -- upvalues: LocalPlayer (copy), crateStand (copy), u7 (ref), showWorld (copy), Color3_fromRGB_ret (copy), Font_new_ret2 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret (copy)
    local v106 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    local v107, v108, v109 = crateStand();

    if not (p105 and (v106 and v108)) then
        if u7 then
            u7.from:Destroy();
            u7.to:Destroy();
            u7.marker:Destroy();

            if u7.markerAt then
                u7.markerAt:Destroy();
            end;

            u7 = nil;
        end;

        return;
    end;

    if u7 and (u7.anchor == v108 and u7.from.Parent == v106) then
        return;
    end;

    showWorld(false);
    local Attachment = Instance.new("Attachment");

    for i, v in {
        Name = "TutorialFrom",
        Position = Vector3.new(0, -2.6, 0)
    } do
        Attachment[i] = v;
    end;

    Attachment.Parent = v106;
    local Attachment2 = Instance.new("Attachment");

    for i, v in {
        Name = "TutorialTo"
    } do
        Attachment2[i] = v;
    end;

    Attachment2.Parent = v108;
    local v110 = {
        Name = "TutorialGuide",
        LightEmission = 0,
        LightInfluence = 0,
        Width0 = 3.2,
        Width1 = 3.2,
        FaceCamera = true,
        Segments = 1,
        Texture = "rbxassetid://129313102318934",
        TextureLength = 3.2,
        TextureSpeed = 1.6,
        Attachment0 = Attachment,
        Attachment1 = Attachment2,
        Color = ColorSequence.new(Color3_fromRGB_ret),
        TextureMode = Enum.TextureMode.Wrap,
        Transparency = NumberSequence.new(0)
    };
    local Beam = Instance.new("Beam");

    for i, v in v110 do
        Beam[i] = v;
    end;

    Beam.Parent = Attachment;
    local v111;

    if v107 then
        v111 = v107:FindFirstChild("Sign");
    else
        v111 = v107;
    end;

    local v112 = not (v111 and v111:IsA("BillboardGui")) and Vector3.new(-7, 0, 0) or v111.StudsOffsetWorldSpace - Vector3.new(3.4, 0, 0);
    local v113 = nil;

    if v109 then
        local v114 = nil;

        for _, descendant in v109:GetDescendants() do
            if descendant:IsA("BasePart") and (not v114 or descendant.Size.Magnitude > v114.Size.Magnitude) then
                v114 = descendant;
            end;
        end;

        if v114 then
            local BoundingBox, v115 = v109:GetBoundingBox();
            v113 = Instance.new("Attachment");

            for i, v in {
                Name = "TutorialMarkerAt"
            } do
                v113[i] = v;
            end;

            v113.Parent = v114;
            v113.WorldPosition = BoundingBox.Position + Vector3.new(0, v115.Y / 2 + 2.2, 0);
        end;
    end;

    local v116 = {
        Name = "TutorialMarker",
        LightInfluence = 0,
        MaxDistance = 400,
        Adornee = v113,
        Size = UDim2.fromScale(5.2, 3.4),
        StudsOffsetWorldSpace = v113 and Vector3.new(0, 0, 0) or v112
    };
    local BillboardGui = Instance.new("BillboardGui");

    for i, v in v116 do
        BillboardGui[i] = v;
    end;

    BillboardGui.Parent = v113 or (v107 or v108);
    BillboardGui:SetAttribute("LightsOutKeep", true);
    local v117 = {
        Name = "Pill",
        Size = UDim2.fromScale(1, 0.62),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v117 do
        Frame[i] = v;
    end;

    Frame.Parent = BillboardGui;
    local v118 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v118 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v119 = {
        Thickness = 3,
        Color = Color3.fromRGB(110, 70, 8)
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v119 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local Color3_fromRGB_ret4 = Color3.fromRGB(255, 236, 150);
    local Color3_fromRGB_ret5 = Color3.fromRGB(242, 176, 48);
    local v120 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret4, Color3_fromRGB_ret5)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v120 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v121 = {
        Text = "FREE",
        TextScaled = true,
        Position = UDim2.fromScale(0.08, 0.1),
        Size = UDim2.fromScale(0.84, 0.8),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret3,
        BackgroundTransparency = 1
    };
    v121.FontFace = v121.FontFace or Font_new_ret;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v121 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame;
    local v122 = {
        Name = "Arrow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://129313102318934",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.6),
        Size = UDim2.fromScale(0.42, 0.4),
        ImageColor3 = Color3_fromRGB_ret,
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v122 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = BillboardGui;
    u7 = {
        from = Attachment,
        to = Attachment2,
        marker = BillboardGui,
        markerAt = v113,
        anchor = v108,
        base = v112
    };
end;

local u123 = nil;

local function scrollIntoView(p124, p125) -- Line: 550
    -- upvalues: u123 (ref), u11 (ref), TweenService (copy)
    local v126 = p124:FindFirstAncestorWhichIsA("ScrollingFrame");

    if not (v126 and (not u123 or u123.PlaybackState ~= Enum.PlaybackState.Playing)) then
        return;
    end;

    local AbsolutePosition = p124.AbsolutePosition;
    local AbsoluteSize = p124.AbsoluteSize;
    local AbsolutePosition2 = v126.AbsolutePosition;
    local AbsoluteSize2 = v126.AbsoluteSize;
    local CanvasPosition = v126.CanvasPosition;
    local v127 = AbsolutePosition - AbsolutePosition2 + CanvasPosition;

    if AbsolutePosition.Y < AbsolutePosition2.Y or AbsolutePosition.Y + AbsoluteSize.Y > AbsolutePosition2.Y + AbsoluteSize2.Y then
        local v128;

        if p125 == "top" then
            v128 = v127.Y - 4;
        else
            v128 = v127.Y + AbsoluteSize.Y / 2 - AbsoluteSize2.Y * (p125 and 0.5 or 0.6);
        end;

        CanvasPosition = Vector2.new(CanvasPosition.X, (math.max(0, v128)));
    end;

    if AbsolutePosition.X < AbsolutePosition2.X or AbsolutePosition.X + AbsoluteSize.X > AbsolutePosition2.X + AbsoluteSize2.X then
        CanvasPosition = Vector2.new(math.max(0, v127.X + AbsoluteSize.X / 2 - AbsoluteSize2.X * 0.5), CanvasPosition.Y);
    end;

    if CanvasPosition ~= v126.CanvasPosition then
        u11 = p124;
        u123 = TweenService:Create(v126, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CanvasPosition = CanvasPosition
        });
        u123:Play();
    end;
end;

local function screenPosition(p129) -- Line: 574
    -- upvalues: u6 (ref)
    return p129.AbsolutePosition - u6.gui.AbsolutePosition;
end;

local function radius(p130) -- Line: 579
    local v131 = p130:FindFirstChildWhichIsA("UICorner");

    if not v131 then
        return 8;
    end;

    local CornerRadius = v131.CornerRadius;

    return CornerRadius.Offset + CornerRadius.Scale * math.min(p130.AbsoluteSize.X, p130.AbsoluteSize.Y);
end;

local function place(p132, p133, p134, p135, p136, p137, p138) -- Line: 588
    p132.Position = UDim2.fromOffset(p134, p135);
    p132.Size = UDim2.fromOffset(p136, p137);

    if p133 then
        p133.CornerRadius = UDim.new(0, p138);
    end;
end;

local function clipped(p139, p140, p141, p142, p143) -- Line: 597
    -- upvalues: u6 (ref)
    local v144 = p139:FindFirstAncestorWhichIsA("ScrollingFrame");

    if not (v144 and v144.ClipsDescendants) then
        return p140, p141, p142, p143;
    end;

    local v145 = v144.AbsolutePosition - u6.gui.AbsolutePosition;
    local AbsoluteSize = v144.AbsoluteSize;
    local math_max_ret = math.max(p140, v145.X - 6);
    local math_max_ret2 = math.max(p141, v145.Y - 6);
    local math_min_ret = math.min(p140 + p142, v145.X + AbsoluteSize.X + 6);
    local math_min_ret2 = math.min(p141 + p143, v145.Y + AbsoluteSize.Y + 6);

    return math_max_ret, math_max_ret2, math.max(0, math_min_ret - math_max_ret), math.max(0, math_min_ret2 - math_max_ret2);
end;

local u146 = nil;
local u147 = 0;
local u148 = 0;
local u149 = false;

local function matchChanged() -- Line: 614
    -- upvalues: LocalPlayer (copy), u146 (ref), u147 (ref), u148 (ref), u149 (ref)
    if LocalPlayer:GetAttribute("InMatch") ~= true then
        if u146 then
            local v150 = os.clock() + 10;
            u146 = "recap";
            u148 = v150;
            u149 = false;
        end;

        return;
    end;

    local v151 = os.clock() + 4;
    u146 = "note";
    u147 = v151;
end;

local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u5, AttributeChangedSignal:Connect(matchChanged));

if LocalPlayer:GetAttribute("InMatch") == true then
    u146 = "note";
    u147 = os.clock() + 4;
elseif u146 then
    u146 = "recap";
    u148 = os.clock() + 10;
    u149 = false;
end;

local function guideHidden(p152) -- Line: 623
    -- upvalues: u146 (ref), u147 (ref), LocalPlayer (copy), u149 (ref), u148 (ref)
    if u146 == "note" then
        return u147 <= p152;
    end;

    if u146 ~= "recap" then
        return false;
    end;

    if LocalPlayer:GetAttribute("MatchSummaryVisible") == true then
        u149 = true;

        return true;
    end;

    if not u149 and u148 > p152 then
        return true;
    end;

    u146 = nil;

    return false;
end;

local u153 = nil;
local u154 = 0;
local u155 = nil;
local u156 = nil;
local u157 = 0;
local u158 = nil;
local u159 = 0;

local function step(p160) -- Line: 648
    -- upvalues: u155 (ref), u146 (ref), u147 (ref), LocalPlayer (copy), u149 (ref), u148 (ref), u6 (ref), crateStand (copy), u7 (ref), u154 (ref), u157 (ref), u156 (ref), TutorialConfig (copy), u1 (ref), Color3_fromRGB_ret (copy), TweenService (copy), resolve (copy), u9 (ref), u10 (ref), u153 (ref), scrollIntoView (copy), shown (copy), child (copy), PlayerGui (copy), showWorld (copy), HalloweenCrateShow (copy), u159 (ref), clipped (copy), u158 (ref), UserInputService (copy)
    local math_clamp_ret = math.clamp(p160 - (u155 or p160), 0, 0.1);
    u155 = p160;
    local v161;

    if u146 == "note" then
        v161 = u147 <= p160;
    elseif u146 == "recap" then
        if LocalPlayer:GetAttribute("MatchSummaryVisible") == true then
            u149 = true;
            v161 = true;
        elseif u149 or u148 <= p160 then
            u146 = nil;
            v161 = false;
        else
            v161 = true;
        end;
    else
        v161 = false;
    end;

    if u6.gui.Enabled == v161 then
        u6.gui.Enabled = not v161;

        if v161 then
            if LocalPlayer.Character then
                LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
            end;

            local _, _, _ = crateStand();

            if u7 then
                u7.from:Destroy();
                u7.to:Destroy();
                u7.marker:Destroy();

                if u7.markerAt then
                    u7.markerAt:Destroy();
                end;

                u7 = nil;
            end;
        else
            u154 = 0;
        end;
    end;

    if v161 then
        return;
    end;

    local Attribute = LocalPlayer:GetAttribute("TutorialStep");
    local AbsoluteSize = u6.gui.AbsoluteSize;

    if p160 < u157 then
        Attribute = u156 or Attribute;
    end;

    if u154 <= p160 and u157 <= p160 then
        u154 = p160 + 0.15;
        local v162 = TutorialConfig.index(Attribute) or 1;
        local v163 = LocalPlayer:GetAttribute("InMatch") == true;
        u6.number.Text = tostring(v162);
        u6.count.Text = ("STEP %d OF %d"):format(v162, #TutorialConfig.Steps);
        local text = u6.text;
        local v164;

        if v163 then
            v164 = "The tutorial continues after this match";
        elseif Attribute == "Crate" then
            v164 = TutorialConfig.Text.Crate:format(u1 and u1.Name or "Crate");
        else
            v164 = TutorialConfig.Text[Attribute] or "";
        end;

        text.Text = v164;

        for i, v in u6.pips do
            v.BackgroundColor3 = i < v162 and Color3_fromRGB_ret or (i == v162 and Color3.fromRGB(255, 244, 200) or Color3.fromRGB(64, 76, 96));
        end;

        if u156 ~= Attribute then
            u156 = Attribute;
            u6.pop.Scale = 0.5;
            TweenService:Create(u6.pop, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end;

        local v165, v166, v167;

        if v163 then
            v165 = nil;
            v166 = nil;
            v167 = nil;
        else
            v165, v166, v167 = resolve(Attribute);
        end;

        u9 = v165;
        u10 = v166;
        u153 = v167;

        if u9 then
            local v168 = u9:FindFirstAncestorWhichIsA("ScrollingFrame");
            local v169;

            if v167 == nil then
                v169 = false;
            else
                v169 = u9:IsDescendantOf(v167) and v168 ~= nil;
            end;

            local v170 = v169 and (v167.AbsoluteSize.Y <= v168.AbsoluteSize.Y - 12 and true or "top") or v169;

            if not v169 then
                v167 = u9;
            end;

            scrollIntoView(v167, v170);
        end;

        local v171 = (LocalPlayer:GetAttribute("ArmoryOpen") == true or (LocalPlayer:GetAttribute("HalloweenShopOpen") == true or LocalPlayer:GetAttribute("OutbreakOpen") == true)) and true or shown(child(PlayerGui, "Crates", "CollectionShade"));
        local v172 = AbsoluteSize.Y < 500 and true or AbsoluteSize.X < 700;
        local v173 = v172 and 300 or 440;
        local v174 = v172 and 40 or (v171 and 60 or 68);
        u6.banner.Size = UDim2.fromOffset(v173, v174);
        local math_clamp_ret2 = math.clamp((AbsoluteSize.X - 24) / v173, 0.6, v172 and 0.8 or 1);
        u6.scale.Scale = math_clamp_ret2;
        local banner = u6.banner;
        banner.Badge.Size = UDim2.fromOffset(v172 and 30 or 44, v172 and 30 or 44);
        banner.Badge.Position = UDim2.new(0, v172 and 6 or 12, 0.5, 0);
        u6.number.TextSize = v172 and 17 or 24;
        banner.Title.Visible = not v172;
        u6.count.Visible = not v172;
        banner.Progress.Visible = not v172;
        local text2 = u6.text;
        local v175;

        if v172 then
            v175 = UDim2.new(0, 44, 0, 4);
        else
            v175 = UDim2.new(0, 68, 0.5, -10);
        end;

        text2.Position = v175;
        local text3 = u6.text;
        local v176;

        if v172 then
            v176 = UDim2.new(1, -52, 1, -8);
        else
            v176 = UDim2.new(1, -82, 0, 22);
        end;

        text3.Size = v176;
        local v177 = (v171 or v172) and 4 or 84;
        local v178 = AbsoluteSize.Y - v174 * math_clamp_ret2 - (v172 and 44 or 14);

        if v165 and v165.Parent then
            local v179 = v165.AbsolutePosition - u6.gui.AbsolutePosition;
            local AbsoluteSize2 = v165.AbsoluteSize;
            local v180 = AbsoluteSize.X / 2 - v173 * math_clamp_ret2 / 2;
            local v181;

            if v179.X < v180 + v173 * math_clamp_ret2 and (v180 < v179.X + AbsoluteSize2.X and v179.Y < v177 + v174 * math_clamp_ret2 + 60) then
                v181 = v177 < v179.Y + AbsoluteSize2.Y;
            else
                v181 = false;
            end;

            if not v181 then
                v178 = v177;
            end;
        else
            v178 = v177;
        end;

        banner.Position = UDim2.new(0.5, 0, 0, v178);
        local v182;

        if Attribute == "Crate" and u9 == nil then
            v182 = not v171;

            if v182 then
                if HalloweenCrateShow.activeMine() == 0 then
                    v182 = LocalPlayer:GetAttribute("InMatch") ~= true;
                else
                    v182 = false;
                end;
            end;
        else
            v182 = false;
        end;

        showWorld(v182);
    end;

    if p160 < u157 then
        u9 = nil;
        u153 = nil;
    end;

    local v183;

    if u9 == nil then
        v183 = false;
    else
        v183 = shown(u9);
    end;

    local v184 = (math.sin(p160 * 5) + 1) / 2;
    local math_min_ret = math.min(1, math_clamp_ret * 14);
    u159 = u159 + ((v183 and u10 ~= "CONTINUE" and 1 or 0) - u159) * math.min(1, math_clamp_ret * 8);

    if v183 then
        local v185 = u9.AbsolutePosition - u6.gui.AbsolutePosition;
        local AbsoluteSize2 = u9.AbsoluteSize;
        local v186 = u9;
        local v187;

        if u153 == nil then
            v187 = false;
        else
            v187 = u9:IsDescendantOf(u153) and shown(u153);
        end;

        local v188, v189;

        if v187 then
            v186 = u153;
            v188 = u153.AbsolutePosition - u6.gui.AbsolutePosition;
            v189 = u153.AbsoluteSize;
        else
            v189 = AbsoluteSize2;
            v188 = v185;
        end;

        local v190, v191, v192, v193 = clipped(v186, v188.X - 6, v188.Y - 6, v189.X + 12, v189.Y + 12);
        local v194 = {};
        local v195 = v186:FindFirstChildWhichIsA("UICorner");
        local v196;

        if v195 then
            local CornerRadius = v195.CornerRadius;
            v196 = CornerRadius.Offset + CornerRadius.Scale * math.min(v186.AbsoluteSize.X, v186.AbsoluteSize.Y);
        else
            v196 = 8;
        end;

        v194[1], v194[2], v194[3], v194[4], v194[5] = v190, v191, v192, v193, v196 + 6;

        if u158 then
            for i = 1, 5 do
                local v197 = u158;
                v197[i] = v197[i] + (v194[i] - u158[i]) * math_min_ret;
                local _ = i;
            end;
        else
            u158 = v194;
        end;

        local v198 = u158[1];
        local v199 = u158[2];
        local v200 = u158[3];
        local v201 = u158[4];
        local v202 = u158[5];
        local v203 = u6.dim[1];
        local X = AbsoluteSize.X;
        v203.Position = UDim2.fromOffset(0, 0);
        v203.Size = UDim2.fromOffset(X, v199);
        local v204 = u6.dim[2];
        local X2 = AbsoluteSize.X;
        local v205 = AbsoluteSize.Y - v199 - v201;
        v204.Position = UDim2.fromOffset(0, v199 + v201);
        v204.Size = UDim2.fromOffset(X2, v205);
        local v206 = u6.dim[3];
        v206.Position = UDim2.fromOffset(0, v199);
        v206.Size = UDim2.fromOffset(v198, v201);
        local v207 = u6.dim[4];
        local v208 = AbsoluteSize.X - v198 - v200;
        v207.Position = UDim2.fromOffset(v198 + v200, v199);
        v207.Size = UDim2.fromOffset(v208, v201);

        for _, v in u6.dim do
            v.Visible = true;
            v.BackgroundTransparency = 1 - u159 * 0.55;
        end;

        u6.hole.Visible = true;
        local hole = u6.hole;
        local holeCorner = u6.holeCorner;
        hole.Position = UDim2.fromOffset(v198, v199);
        hole.Size = UDim2.fromOffset(v200, v201);

        if holeCorner then
            holeCorner.CornerRadius = UDim.new(0, v202);
        end;

        u6.holeStroke.Thickness = v184 + 3;
        u6.glow.Visible = true;
        local glow = u6.glow;
        local glowCorner = u6.glowCorner;
        local v209 = v202 + 2;
        glow.Position = UDim2.fromOffset(v198 - 2, v199 - 2);
        glow.Size = UDim2.fromOffset(v200 + 4, v201 + 4);

        if glowCorner then
            glowCorner.CornerRadius = UDim.new(0, v209);
        end;

        u6.glowStroke.Transparency = (1 - v184) * 0.35 + 0.55;
        u6.ring.Visible = v187;

        if v187 then
            local ring = u6.ring;
            local ringCorner = u6.ringCorner;
            local v210 = v185.X - 3;
            local v211 = v185.Y - 3;
            local v212 = AbsoluteSize2.X + 6;
            local v213 = AbsoluteSize2.Y + 6;
            local v214 = u9;
            local v215 = v214:FindFirstChildWhichIsA("UICorner");
            local v216;

            if v215 then
                local CornerRadius = v215.CornerRadius;
                v216 = CornerRadius.Offset + CornerRadius.Scale * math.min(v214.AbsoluteSize.X, v214.AbsoluteSize.Y);
            else
                v216 = 8;
            end;

            local v217 = v216 + 3;
            ring.Position = UDim2.fromOffset(v210, v211);
            ring.Size = UDim2.fromOffset(v212, v213);

            if ringCorner then
                ringCorner.CornerRadius = UDim.new(0, v217);
            end;

            u6.ringStroke.Transparency = v184 * 0.4 + 0.1;
        end;

        local v218 = p160 % 1.4 / 1.4;
        local v219 = 4 + v218 * 18;
        u6.ripple.Visible = true;
        local ripple = u6.ripple;
        local rippleCorner = u6.rippleCorner;
        local v220 = v185.X - v219;
        local v221 = v185.Y - v219;
        local v222 = AbsoluteSize2.X + v219 * 2;
        local v223 = AbsoluteSize2.Y + v219 * 2;
        local v224 = u9;
        local v225 = v224:FindFirstChildWhichIsA("UICorner");
        local v226;

        if v225 then
            local CornerRadius = v225.CornerRadius;
            v226 = CornerRadius.Offset + CornerRadius.Scale * math.min(v224.AbsoluteSize.X, v224.AbsoluteSize.Y);
        else
            v226 = 8;
        end;

        local v227 = v226 + v219;
        ripple.Position = UDim2.fromOffset(v220, v221);
        ripple.Size = UDim2.fromOffset(v222, v223);

        if rippleCorner then
            rippleCorner.CornerRadius = UDim.new(0, v227);
        end;

        u6.rippleStroke.Transparency = 0.25 + v218 * 0.75;
        local math_sin_ret = math.sin(p160 * 4);
        local v228 = math.abs(math_sin_ret) * 8;
        local v229 = u6.banner.AbsolutePosition.Y - u6.gui.AbsolutePosition.Y;
        local v230 = v199 - 30 - 44 - 16 > math.max(8, (v229 >= AbsoluteSize.Y / 2 and 0 or v229 + u6.banner.AbsoluteSize.Y) + 4);
        local v231 = v185.X + AbsoluteSize2.X / 2;
        local v232;

        if v230 then
            v232 = v199 - 30 - v228;
        else
            v232 = v199 + v201 + 30 + v228;
        end;

        u6.pointer.Visible = true;
        u6.pointer.Rotation = v230 and 0 or 180;
        u6.pointer.Position = UDim2.fromOffset(v231, v232);
        u6.hint.Visible = u10 ~= nil;

        if u10 then
            u6.hintText.Text = (UserInputService.TouchEnabled and not UserInputService.MouseEnabled and "TAP " or "CLICK ") .. u10;
            local v233 = u6.hint.AbsoluteSize.X / 2;
            local hint = u6.hint;
            local UDim2_fromOffset = UDim2.fromOffset;
            local math_max_ret = math.max(v233 + 8, AbsoluteSize.X - v233 - 8);
            local math_clamp_ret2 = math.clamp(v231, v233 + 8, math_max_ret);
            local v234;

            if v230 then
                v234 = v232 - 44;
            else
                v234 = v232 + 44;
            end;

            hint.Position = UDim2_fromOffset(math_clamp_ret2, v234);
        end;
    else
        u158 = nil;

        for _, v in u6.dim do
            v.Visible = false;
        end;

        u6.hole.Visible = false;
        u6.glow.Visible = false;
        u6.ring.Visible = false;
        u6.ripple.Visible = false;
        u6.pointer.Visible = false;
        u6.hint.Visible = false;
    end;

    if v183 then
        if u153 == nil then
            v183 = false;
        else
            v183 = not u9:IsDescendantOf(u153) and shown(u153);
        end;
    end;

    u6.card.Visible = v183;

    if v183 then
        local v235 = u153.AbsolutePosition - u6.gui.AbsolutePosition;
        local AbsoluteSize2 = u153.AbsoluteSize;
        local card = u6.card;
        local cardCorner = u6.cardCorner;
        local v236 = v235.X - 4;
        local v237 = v235.Y - 4;
        local v238 = AbsoluteSize2.X + 8;
        local v239 = AbsoluteSize2.Y + 8;
        local v240 = u153;
        local v241 = v240:FindFirstChildWhichIsA("UICorner");
        local v242;

        if v241 then
            local CornerRadius = v241.CornerRadius;
            v242 = CornerRadius.Offset + CornerRadius.Scale * math.min(v240.AbsoluteSize.X, v240.AbsoluteSize.Y);
        else
            v242 = 8;
        end;

        local v243 = v242 + 4;
        card.Position = UDim2.fromOffset(v236, v237);
        card.Size = UDim2.fromOffset(v238, v239);

        if cardCorner then
            cardCorner.CornerRadius = UDim.new(0, v243);
        end;

        u6.cardStroke.Transparency = v184 * 0.35 + 0.15;
    end;

    if u7 then
        local math_sin_ret = math.sin(p160 * 3);
        local v244 = math.abs(math_sin_ret) * 0.6;

        if u7.markerAt then
            u7.marker.StudsOffset = Vector3.new(0, v244, 0);

            return;
        end;

        u7.marker.StudsOffsetWorldSpace = u7.base - Vector3.new(v244, 0, 0);
    end;
end;

local u245 = nil;

local function stop() -- Line: 847
    -- upvalues: u245 (ref), LocalPlayer (copy), crateStand (copy), u7 (ref), u6 (ref), u9 (ref), u153 (ref), u11 (ref), u158 (ref), u155 (ref), u156 (ref), u159 (ref)
    if u245 then
        u245:Disconnect();
        u245 = nil;
    end;

    if LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    end;

    local _, _, _ = crateStand();

    if u7 then
        u7.from:Destroy();
        u7.to:Destroy();
        u7.marker:Destroy();

        if u7.markerAt then
            u7.markerAt:Destroy();
        end;

        u7 = nil;
    end;

    if u6 then
        u6.gui:Destroy();
        u6 = nil;
    end;

    u9 = nil;
    u153 = nil;
    u11 = nil;
    u158 = nil;
    u155 = nil;
    u156 = nil;
    u159 = 0;
end;

local function refresh() -- Line: 860
    -- upvalues: LocalPlayer (copy), u245 (ref), crateStand (copy), u7 (ref), u6 (ref), u9 (ref), u153 (ref), u11 (ref), u158 (ref), u155 (ref), u156 (ref), u159 (ref), build (copy), ArmoryEvent (copy), RunService (copy), step (copy)
    local v246;

    if LocalPlayer:GetAttribute("TutorialActive") == true then
        v246 = LocalPlayer:GetAttribute("TutorialStep") ~= nil;
    else
        v246 = false;
    end;

    if v246 then
        if not u6 then
            u6 = build();
            ArmoryEvent:FireServer("Get");
        end;

        if not u245 then
            u245 = RunService.RenderStepped:Connect(function() -- Line: 871
                -- upvalues: step (ref), u245 (ref), LocalPlayer (ref), crateStand (ref), u7 (ref), u6 (ref), u9 (ref), u153 (ref), u11 (ref), u158 (ref), u155 (ref), u156 (ref), u159 (ref)
                local success, result = pcall(step, os.clock());

                if not success then
                    warn("[Tutorial] guide failed:", result);

                    if u245 then
                        u245:Disconnect();
                        u245 = nil;
                    end;

                    if LocalPlayer.Character then
                        LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
                    end;

                    local _, _, _ = crateStand();

                    if u7 then
                        u7.from:Destroy();
                        u7.to:Destroy();
                        u7.marker:Destroy();

                        if u7.markerAt then
                            u7.markerAt:Destroy();
                        end;

                        u7 = nil;
                    end;

                    if u6 then
                        u6.gui:Destroy();
                        u6 = nil;
                    end;

                    u9 = nil;
                    u153 = nil;
                    u11 = nil;
                    u158 = nil;
                    u155 = nil;
                    u156 = nil;
                    u159 = 0;
                end;
            end);
        end;

        return;
    end;

    if u245 then
        u245:Disconnect();
        u245 = nil;
    end;

    if LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    end;

    local _, _, _ = crateStand();

    if u7 then
        u7.from:Destroy();
        u7.to:Destroy();
        u7.marker:Destroy();

        if u7.markerAt then
            u7.markerAt:Destroy();
        end;

        u7 = nil;
    end;

    if u6 then
        u6.gui:Destroy();
        u6 = nil;
    end;

    u9 = nil;
    u153 = nil;
    u11 = nil;
    u158 = nil;
    u155 = nil;
    u156 = nil;
    u159 = 0;
end;

local function done(p247) -- Line: 882
    -- upvalues: u245 (ref), LocalPlayer (copy), crateStand (copy), u7 (ref), u6 (ref), u9 (ref), u153 (ref), u11 (ref), u158 (ref), u155 (ref), u156 (ref), u159 (ref), HudNavigation (copy), TutorialConfig (copy), Color3_fromRGB_ret (copy), Font_new_ret2 (copy), Font_new_ret (copy), Color3_fromRGB_ret3 (copy), UserInputService (copy), RunService (copy), child (copy), PlayerGui (copy), shown (copy), TweenService (copy)
    if u245 then
        u245:Disconnect();
        u245 = nil;
    end;

    if LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    end;

    local _, _, _ = crateStand();

    if u7 then
        u7.from:Destroy();
        u7.to:Destroy();
        u7.marker:Destroy();

        if u7.markerAt then
            u7.markerAt:Destroy();
        end;

        u7 = nil;
    end;

    if u6 then
        u6.gui:Destroy();
        u6 = nil;
    end;

    u9 = nil;
    u153 = nil;
    u11 = nil;
    u158 = nil;
    u155 = nil;
    u156 = nil;
    u159 = 0;
    LocalPlayer:SetAttribute("TutorialFinishing", true);
    task.wait(1.5);
    HudNavigation.opening("TutorialDone");
    local v248 = type(p247) == "string" and p247 and p247 or TutorialConfig.DoneText;
    local string_match_ret, v249 = string.match(v248, "^(.-!)%s*(.*)$");
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "TutorialDone";
    ScreenGui.ClipToDeviceSafeArea = false;
    ScreenGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
    ScreenGui:SetAttribute("SelfManagedText", true);
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 250;
    local v250 = {
        BackgroundTransparency = 0.04,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.3),
        Size = UDim2.fromOffset(460, 104),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v250 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v251 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v251 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v252 = {
        Thickness = 3,
        Color = Color3_fromRGB_ret
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v252 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local Color3_fromRGB_ret4 = Color3.fromRGB(44, 56, 76);
    local Color3_fromRGB_ret5 = Color3.fromRGB(15, 20, 30);
    local v253 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret4, Color3_fromRGB_ret5)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v253 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0.4
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    local math_clamp_ret = math.clamp((workspace.CurrentCamera.ViewportSize.X - 24) / 460, 0.6, 1);
    local v254 = {
        TextScaled = true,
        Position = UDim2.fromOffset(16, 14),
        Size = UDim2.new(1, -32, 0, 40),
        FontFace = Font_new_ret2,
        Text = string.upper(string_match_ret or v248),
        TextColor3 = Color3_fromRGB_ret,
        BackgroundTransparency = 1
    };
    v254.FontFace = v254.FontFace or Font_new_ret;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v254 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame;
    local v255 = {
        TextScaled = true,
        Position = UDim2.fromOffset(16, 58),
        Size = UDim2.new(1, -32, 0, 30),
        Text = v249 or "",
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1
    };
    v255.FontFace = v255.FontFace or Font_new_ret;
    local TextLabel2 = Instance.new("TextLabel");

    for i, v in v255 do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = Frame;
    local Frame2 = Instance.new("Frame");

    for i, v in {
        Name = "Loadout",
        BackgroundTransparency = 1,
        Visible = false
    } do
        Frame2[i] = v;
    end;

    Frame2.Parent = ScreenGui;
    local v256 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v256 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v257 = {
        Thickness = 3,
        Color = Color3_fromRGB_ret
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v257 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame2;
    local v258 = {
        Name = "LoadoutTag",
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 1),
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, 28),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v258 do
        Frame3[i] = v;
    end;

    Frame3.Parent = ScreenGui;
    local v259 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v259 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame3;
    local v260 = {
        Thickness = 2,
        Color = Color3.fromRGB(110, 70, 8)
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v260 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = Frame3;
    local v261 = {
        PaddingLeft = UDim.new(0, 14),
        PaddingRight = UDim.new(0, 14)
    };
    local UIPadding = Instance.new("UIPadding");

    for i, v in v261 do
        UIPadding[i] = v;
    end;

    UIPadding.Parent = Frame3;
    local Color3_fromRGB_ret6 = Color3.fromRGB(255, 236, 150);
    local Color3_fromRGB_ret7 = Color3.fromRGB(242, 176, 48);
    local v262 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret6, Color3_fromRGB_ret7)
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v262 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame3;
    local v263 = {
        TextSize = 14,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromScale(0, 1),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret3,
        Text = "YOUR LOADOUT  ·  " .. (UserInputService.TouchEnabled and not UserInputService.MouseEnabled and "TAP" or "CLICK") .. " TO CHANGE",
        BackgroundTransparency = 1
    };
    v263.FontFace = v263.FontFace or Font_new_ret;
    local TextLabel3 = Instance.new("TextLabel");

    for i, v in v263 do
        TextLabel3[i] = v;
    end;

    TextLabel3.Parent = Frame3;
    local u264 = { { "AbilityControls", "Use" }, { "AbilityControls", "ChaserEquipped" }, { "GearControls", "Use" } };
    local u275 = RunService.RenderStepped:Connect(function() -- Line: 957
        -- upvalues: u264 (copy), child (ref), PlayerGui (ref), shown (ref), ScreenGui (copy), Frame2 (copy), Frame3 (copy), UICorner2 (copy), UIStroke2 (copy), UserInputService (ref)
        local v265 = nil;
        local v266 = nil;
        local v267 = nil;
        local v268 = nil;

        for _, v in u264 do
            local v269 = child(PlayerGui, v[1], v[2]);

            if shown(v269) then
                local v270 = v269.AbsolutePosition - ScreenGui.AbsolutePosition;
                local AbsoluteSize = v269.AbsoluteSize;
                v265 = math.min(v265 or v270.X, v270.X);
                v266 = math.min(v266 or v270.Y, v270.Y);
                v267 = math.max(v267 or v270.X + AbsoluteSize.X, v270.X + AbsoluteSize.X);
                v268 = math.max(v268 or v270.Y + AbsoluteSize.Y, v270.Y + AbsoluteSize.Y);
            end;
        end;

        Frame2.Visible = v265 ~= nil;
        Frame3.Visible = v265 ~= nil;

        if v265 then
            local v271 = os.clock() * 5;
            local v272 = (math.sin(v271) + 1) / 2;
            Frame2.Position = UDim2.fromOffset(v265 - 8, v266 - 8);
            Frame2.Size = UDim2.fromOffset(v267 - v265 + 16, v268 - v266 + 16);
            UICorner2.CornerRadius = UDim.new(0, 18);
            UIStroke2.Thickness = v272 + 3;
            UIStroke2.Transparency = v272 * 0.4 + 0.1;
            local v273 = os.clock() * 4;
            local math_sin_ret = math.sin(v273);
            local v274 = math.abs(math_sin_ret) * 4;

            if UserInputService.TouchEnabled then
                Frame3.AnchorPoint = Vector2.new(1, 0.5);
                Frame3.Position = UDim2.fromOffset(v265 - 14 - v274, (v266 + v268) / 2);

                return;
            end;

            Frame3.AnchorPoint = Vector2.new(0.5, 1);
            Frame3.Position = UDim2.fromOffset((v265 + v267) / 2, v266 - 14 - v274);
        end;
    end);
    ScreenGui.Destroying:Connect(function() -- Line: 989
        -- upvalues: u275 (copy)
        u275:Disconnect();
    end);
    ScreenGui.Parent = PlayerGui;
    TweenService:Create(UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = math_clamp_ret
    }):Play();
    task.delay(6, function() -- Line: 994
        -- upvalues: ScreenGui (copy), TweenService (ref), UIScale (copy), LocalPlayer (ref)
        if ScreenGui.Parent then
            TweenService:Create(UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Scale = 0
            }):Play();
            task.wait(0.35);
            ScreenGui:Destroy();
        end;

        LocalPlayer:SetAttribute("TutorialFinishing", nil);
    end);
end;

table.insert(u5, ArmoryEvent.OnClientEvent:Connect(function(p276, p277) -- Line: 1004
    -- upvalues: u8 (ref)
    if p276 == "State" and (type(p277) == "table" and type(p277.owned) == "table") then
        u8 = p277.owned;
    end;
end));
local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("TutorialActive");
table.insert(u5, AttributeChangedSignal2:Connect(refresh));
local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("TutorialStep");
table.insert(u5, AttributeChangedSignal3:Connect(function() -- Line: 1010
    -- upvalues: u11 (ref), u154 (ref), u156 (ref), u157 (ref), refresh (copy)
    u11 = nil;
    u154 = 0;

    if u156 ~= nil then
        u157 = os.clock() + 1.2;
    end;

    refresh();
end));
task.spawn(function() -- Line: 1019
    -- upvalues: ChickenOrHero (copy), done (copy), u5 (copy)
    local TutorialEvent = ChickenOrHero.Game:WaitForChild("TutorialEvent", 60);

    if TutorialEvent then
        table.insert(u5, TutorialEvent.OnClientEvent:Connect(function(p278, p279) -- Line: 1022
            -- upvalues: done (ref)
            if p278 == "Done" then
                done(p279);
            end;
        end));
    end;
end);
refresh();
script.Destroying:Connect(function() -- Line: 1031
    -- upvalues: u5 (copy), u245 (ref), LocalPlayer (copy), crateStand (copy), u7 (ref), u6 (ref), u9 (ref), u153 (ref), u11 (ref), u158 (ref), u155 (ref), u156 (ref), u159 (ref)
    for _, v in u5 do
        v:Disconnect();
    end;

    table.clear(u5);

    if u245 then
        u245:Disconnect();
        u245 = nil;
    end;

    if LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    end;

    local _, _, _ = crateStand();

    if u7 then
        u7.from:Destroy();
        u7.to:Destroy();
        u7.marker:Destroy();

        if u7.markerAt then
            u7.markerAt:Destroy();
        end;

        u7 = nil;
    end;

    if u6 then
        u6.gui:Destroy();
        u6 = nil;
    end;

    u9 = nil;
    u153 = nil;
    u11 = nil;
    u158 = nil;
    u155 = nil;
    u156 = nil;
    u159 = 0;
    LocalPlayer:SetAttribute("TutorialFinishing", nil);
end);