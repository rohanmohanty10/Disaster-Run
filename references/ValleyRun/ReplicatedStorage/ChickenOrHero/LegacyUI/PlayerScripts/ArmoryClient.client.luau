 

 

local HudNavigation = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local ValleyToast = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast"));
local ArmoryEvent = Weapons:WaitForChild("ArmoryEvent");
u1.state = {
    loaded = false,
    coins = 0,
    gems = 0,
    owned = {},
    equipped = SkinCatalog.Default
};
u1.built = false;

local function canOpen() -- Line: 28
    -- upvalues: LocalPlayer (copy)
    local v2;

    if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and (LocalPlayer:GetAttribute("TutorialRouting") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true)) then
        v2 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
    else
        v2 = false;
    end;

    return v2;
end;

local function available() -- Line: 35
    -- upvalues: u1 (copy), canOpen (copy), HudNavigation (copy)
    if not u1.live then
        local v3 = canOpen();
        HudNavigation.setAvailable("Shop", v3);
        HudNavigation.setAvailable("Inventory", v3);
        HudNavigation.setAvailable("Abilities", v3);
        HudNavigation.setAvailable("Items", v3);
    end;
end;

for _, v in { "ClientReady", "InMatch", "TutorialRouting", "ScreenPresentationActive", "AdminRefreshActive" } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(available);
end;

local function likeRewardShown() -- Line: 48
    -- upvalues: LocalPlayer (copy)
    local v4 = LocalPlayer:FindFirstChildOfClass("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("LikeReward");
    local v5;

    if v4 then
        v5 = v4:FindFirstChild("PanelShade");
    else
        v5 = v4;
    end;

    local v6;

    if v5 == nil then
        v6 = false;
    else
        v6 = v4.Enabled and v5.Visible == true;
    end;

    return v6;
end;

ArmoryEvent.OnClientEvent:Connect(function(p7, p8) -- Line: 53
    -- upvalues: u1 (copy), HudNavigation (copy), LocalPlayer (copy), ValleyToast (copy)
    if u1.live or (p7 ~= "State" or type(p8) ~= "table") then
        return;
    end;

    u1.state = p8;
    HudNavigation.setWallet(p8.loaded, p8.coins, p8.gems);

    if type(p8.message) == "string" and p8.message ~= "" then
        local v9 = LocalPlayer:FindFirstChildOfClass("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("LikeReward");
        local v10;

        if v9 then
            v10 = v9:FindFirstChild("PanelShade");
        else
            v10 = v9;
        end;

        local v11;

        if v10 == nil then
            v11 = false;
        else
            v11 = v9.Enabled and v10.Visible == true;
        end;

        if not v11 then
            ValleyToast.show(p8.message);
        end;
    end;
end);

local function whenBuilt(p12) -- Line: 63
    -- upvalues: u1 (copy)
    if u1.live then
        return;
    end;

    u1.after = p12;

    if u1.built then
        return;
    end;

    task.spawn(function() -- Line: 71
        -- upvalues: u1 (ref)
        u1.build();
        local after = u1.after;
        u1.after = nil;

        if after then
            after();
        end;
    end);
end;

local function open(u13) -- Line: 80
    -- upvalues: HudNavigation (copy), u1 (copy)
    local function v14() -- Line: 81
        -- upvalues: HudNavigation (ref), u13 (copy)
        HudNavigation.activate(u13);
    end;

    if u1.live then
        return;
    end;

    u1.after = v14;

    if u1.built then
        return;
    end;

    task.spawn(function() -- Line: 71
        -- upvalues: u1 (ref)
        u1.build();
        local after = u1.after;
        u1.after = nil;

        if after then
            after();
        end;
    end);
end;

HudNavigation.register("Shop", function() -- Line: 85
    -- upvalues: HudNavigation (copy), u1 (copy)
    local u15 = "Shop";

    local function v16() -- Line: 81
        -- upvalues: HudNavigation (ref), u15 (copy)
        HudNavigation.activate(u15);
    end;

    if u1.live then
        return;
    end;

    u1.after = v16;

    if u1.built then
        return;
    end;

    task.spawn(function() -- Line: 71
        -- upvalues: u1 (ref)
        u1.build();
        local after = u1.after;
        u1.after = nil;

        if after then
            after();
        end;
    end);
end);
HudNavigation.register("Inventory", function() -- Line: 88
    -- upvalues: HudNavigation (copy), u1 (copy)
    local u17 = "Inventory";

    local function v18() -- Line: 81
        -- upvalues: HudNavigation (ref), u17 (copy)
        HudNavigation.activate(u17);
    end;

    if u1.live then
        return;
    end;

    u1.after = v18;

    if u1.built then
        return;
    end;

    task.spawn(function() -- Line: 71
        -- upvalues: u1 (ref)
        u1.build();
        local after = u1.after;
        u1.after = nil;

        if after then
            after();
        end;
    end);
end);
HudNavigation.register("Abilities", function() -- Line: 91
    -- upvalues: HudNavigation (copy), u1 (copy)
    local u19 = "Abilities";

    local function v20() -- Line: 81
        -- upvalues: HudNavigation (ref), u19 (copy)
        HudNavigation.activate(u19);
    end;

    if u1.live then
        return;
    end;

    u1.after = v20;

    if u1.built then
        return;
    end;

    task.spawn(function() -- Line: 71
        -- upvalues: u1 (ref)
        u1.build();
        local after = u1.after;
        u1.after = nil;

        if after then
            after();
        end;
    end);
end);
HudNavigation.register("Items", function() -- Line: 94
    -- upvalues: HudNavigation (copy), u1 (copy)
    local u21 = "Items";

    local function v22() -- Line: 81
        -- upvalues: HudNavigation (ref), u21 (copy)
        HudNavigation.activate(u21);
    end;

    if u1.live then
        return;
    end;

    u1.after = v22;

    if u1.built then
        return;
    end;

    task.spawn(function() -- Line: 71
        -- upvalues: u1 (ref)
        u1.build();
        local after = u1.after;
        u1.after = nil;

        if after then
            after();
        end;
    end);
end);
Weapons:WaitForChild("ArmoryNavigation").Event:Connect(function(u23) -- Line: 97
    -- upvalues: Weapons (copy), u1 (copy)
    if u23 == "Emotes" or (u23 == "Featured" or (u23 == "Earnable" or u23 == "VIP")) then
        local function v24() -- Line: 99
            -- upvalues: Weapons (ref), u23 (copy)
            Weapons.ArmoryNavigation:Fire(u23);
        end;

        if u1.live then
            return;
        end;

        u1.after = v24;

        if u1.built then
            return;
        end;

        task.spawn(function() -- Line: 71
            -- upvalues: u1 (ref)
            u1.build();
            local after = u1.after;
            u1.after = nil;

            if after then
                after();
            end;
        end);
    end;
end);
UserInputService.InputBegan:Connect(function(p25, p26) -- Line: 104
    -- upvalues: u1 (copy), UserInputService (copy), HudNavigation (copy)
    if u1.live or (p26 or UserInputService:GetFocusedTextBox()) then
        return;
    end;

    if p25.KeyCode == Enum.KeyCode.N or p25.KeyCode == Enum.KeyCode.ButtonY then
        local u27 = "Inventory";

        local function v28() -- Line: 81
            -- upvalues: HudNavigation (ref), u27 (copy)
            HudNavigation.activate(u27);
        end;

        if u1.live then
            return;
        end;

        u1.after = v28;

        if u1.built then
            return;
        end;

        task.spawn(function() -- Line: 71
            -- upvalues: u1 (ref)
            u1.build();
            local after = u1.after;
            u1.after = nil;

            if after then
                after();
            end;
        end);
    end;
end);
LocalPlayer:SetAttribute("ArmoryOpen", false);
available();
task.spawn(function() -- Line: 114
    -- upvalues: u1 (copy), ArmoryEvent (copy)
    while not (u1.live or u1.state.loaded) do
        ArmoryEvent:FireServer("Get");
        task.wait(3);
    end;
end);

function u1.build() -- Line: 121
    -- upvalues: u1 (copy), LocalPlayer (copy), GuiService (copy), UserInputService (copy), HudNavigation (copy), TweenService (copy), RunService (copy)
    if u1.built then
        return;
    end;

    u1.built = true;
    local os_clock_ret = os.clock();

    local function pace() -- Line: 129
        -- upvalues: os_clock_ret (ref)
        if os.clock() - os_clock_ret >= 0.006 then
            task.wait();
            os_clock_ret = os.clock();
        end;
    end;

    local ChickenOrHero2 = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
    local Weapons2 = ChickenOrHero2:WaitForChild("Weapons");
    local SkinCatalog2 = require(Weapons2:WaitForChild("SkinCatalog"));
    local ArmoryEvent2 = Weapons2:WaitForChild("ArmoryEvent");
    local PresentationCues = ChickenOrHero2:WaitForChild("Audio"):WaitForChild("PresentationCues");
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local Screens = ChickenOrHero2:WaitForChild("LegacyUI"):WaitForChild("Screens");

    for _, v in { "ValleyArmory", "ValleyArmoryShade" } do
        local v29 = Screens:FindFirstChild(v);

        if v29 and not PlayerGui:FindFirstChild(v) then
            v29:Clone().Parent = PlayerGui;
        end;

        if os.clock() - os_clock_ret >= 0.006 then
            task.wait();
            os_clock_ret = os.clock();
        end;
    end;

    local ValleyArmory = PlayerGui:WaitForChild("ValleyArmory");
    local ValleyArmoryShade = PlayerGui:WaitForChild("ValleyArmoryShade");
    local Canvas = ValleyArmory.Overlay.Canvas;
    local Dock = ValleyArmory.Dock;
    local u30 = { "Shop", "Abilities", "Items", "Inventory", "Emotes" };
    local u31 = {
        Shop = 64,
        Abilities = 100,
        Items = 66,
        Inventory = 116,
        Emotes = 84
    };

    for _, v in { { "OldUIReskin", "Skin" }, { "Presentation", "ArmoryStyle" }, { "Interface", "PreviewButton" }, { "Weapons", "BundlePanel" }, { "Weapons", "GiftClient" }, { "Weapons", "EventKnivesOffer" }, { "Weapons", "StorefrontClient" }, { "Gear", "GearCatalog" }, { "Gear", "GearStoreClient" }, { "Weapons", "EmoteStoreClient" }, { "Weapons", "DailyEmoteOffers" }, { "Progression", "JourneyConfig" } } do
        require(ChickenOrHero2:WaitForChild(v[1]):WaitForChild(v[2]));

        if os.clock() - os_clock_ret >= 0.006 then
            task.wait();
            os_clock_ret = os.clock();
        end;
    end;

    local ArmoryStyle = require(ChickenOrHero2:WaitForChild("Presentation"):WaitForChild("ArmoryStyle"));
    local Skin = require(ChickenOrHero2:WaitForChild("OldUIReskin"):WaitForChild("Skin"));
    local ValleyToast2 = require(ChickenOrHero2.Presentation:WaitForChild("ValleyToast"));
    local EmoteCatalog = require(ChickenOrHero2:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
    local EmoteStoreClient = require(Weapons2:WaitForChild("EmoteStoreClient"));
    local CurrencyTopUp = require(Weapons2:WaitForChild("CurrencyTopUp"));
    local KnifeIconCopy = require(Weapons2:WaitForChild("KnifeIconCopy"));
    local GamepadService = game:GetService("GamepadService");
    local v32 = Canvas.Tabs.Shop:Clone();
    v32.Name = "Abilities";
    v32.Text = "ABILITIES";
    v32.Parent = Canvas.Tabs;
    local v33 = Canvas.Tabs.Shop:Clone();
    v33.Name = "Items";
    v33.Text = "ITEMS";
    v33.Parent = Canvas.Tabs;
    local v34 = Canvas.Tabs.Shop:Clone();
    v34.Name = "Emotes";
    v34.Text = "EMOTES";
    v34:SetAttribute("Dimmed", EmoteCatalog.ComingSoon == true);
    v34.Parent = Canvas.Tabs;
    Canvas.Tabs.Shop.Text = "SHOP";
    Canvas.Tabs.Inventory.Text = "MY KNIVES";

    if os.clock() - os_clock_ret >= 0.006 then
        task.wait();
        os_clock_ret = os.clock();
    end;

    ArmoryStyle.apply(ValleyArmory);

    if os.clock() - os_clock_ret >= 0.006 then
        task.wait();
        os_clock_ret = os.clock();
    end;

    local u35 = require(Weapons2:WaitForChild("StorefrontClient")).new(Canvas, Weapons2, SkinCatalog2, PresentationCues, LocalPlayer, pace);

    if os.clock() - os_clock_ret >= 0.006 then
        task.wait();
        os_clock_ret = os.clock();
    end;

    local state = u1.state;
    local Default = SkinCatalog2.Default;
    local Vector2_zero = Vector2.zero;
    local Palette = Skin.Palette;
    local Unit = (Vector3.new(0.47942555, 0.12, 0.87758255)).Unit;
    local u36 = {};
    local u37 = false;
    local u38 = nil;
    local u39 = 3;
    local u40 = nil;
    local u41 = 0;

    local function thumbPose(p42, p43, p44) -- Line: 231
        -- upvalues: Unit (copy)
        local Attribute = p43:GetAttribute("ThumbAxis");
        local Attribute2 = p43:GetAttribute("ThumbNormal");

        if typeof(Attribute) ~= "Vector3" or (typeof(Attribute2) ~= "Vector3" or Attribute.Magnitude < 0.5) then
            local Size = p42.Size;
            local v45 = { Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1) };
            local v46 = { Size.X, Size.Y, Size.Z };
            local v47 = 1;
            local v48 = 1;
            local v49 = v46[2] > v46[v47] and 2 or v47;
            local v50 = v46[2] < v46[v48] and 2 or v48;
            local v51 = v46[3] > v46[v49] and 3 or v49;
            local v52 = v46[3] < v46[v50] and 3 or v50;

            if v51 == v52 then
                v52 = v51 % 3 + 1;
            end;

            Attribute = v45[v51];
            Attribute2 = v45[v52];
        end;

        local Unit2 = Attribute.Unit;
        local Unit3 = (Attribute2 - Unit2 * Attribute2:Dot(Unit2)).Unit;
        local CFrame_fromMatrix_ret = CFrame.fromMatrix(Vector3.new(0, 0, 0), Unit2, Unit3, Unit2:Cross(Unit3));
        local CFrame_lookAt_ret = CFrame.lookAt(p44 or Unit, Vector3.new(0, 0, 0));
        local Unit4 = (CFrame_lookAt_ret.RightVector * 0.882947592858927 + CFrame_lookAt_ret.UpVector * 0.4694715627858908).Unit;
        local v53 = -CFrame_lookAt_ret.LookVector;

        return CFrame.fromMatrix(Vector3.new(0, 0, 0), Unit4, v53, Unit4:Cross(v53)) * CFrame_fromMatrix_ret:Inverse();
    end;

    local u54 = "Shop";
    local u55 = {
        Mythical = 6,
        Legendary = 5,
        Epic = 3,
        Rare = 2,
        Common = 1
    };
    local u56 = false;
    local u57 = 0;
    local u58 = true;
    local u59 = false;

    for i, v in SkinCatalog2.Order do
        u36[v] = i;
    end;

    local function rarityOf(p60, p61) -- Line: 264
        -- upvalues: Skin (copy), u55 (copy), SkinCatalog2 (copy)
        if p61.Rarity then
            return string.upper(p61.Rarity), Skin.Rarity[p61.Rarity] or p61.Accent, u55[p61.Rarity] or 0;
        end;

        local v62 = p60 == SkinCatalog2.Default and "STANDARD" or "EXCLUSIVE";
        local Accent = p61.Accent;

        if p60 == SkinCatalog2.Default then
            return v62, Accent, 0;
        end;

        return v62, Accent, 4;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "KnifeCollection";
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = Canvas;

    local function headerLabel(p63, p64, p65, p66) -- Line: 275
        -- upvalues: Frame (copy), Skin (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p63;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Font = Enum.Font.GothamBold;
        TextLabel.Text = p64;
        TextLabel.TextSize = p65;
        TextLabel.TextColor3 = p66;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Parent = Frame;
        Skin.textStroke(TextLabel, 1.5);

        return TextLabel;
    end;

    local text = Palette.text;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Heading";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.Text = "KNIFE INDEX";
    TextLabel.TextSize = 20;
    TextLabel.TextColor3 = text;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    Skin.textStroke(TextLabel, 1.5);
    TextLabel.Size = UDim2.fromOffset(150, 28);
    local gold = Palette.gold;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Count";
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Font = Enum.Font.GothamBold;
    TextLabel2.Text = "";
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = gold;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Parent = Frame;
    Skin.textStroke(TextLabel2, 1.5);
    TextLabel2.Position = UDim2.fromOffset(152, 2);
    TextLabel2.Size = UDim2.fromOffset(120, 26);
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "Grid";
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Position = UDim2.fromOffset(0, 36);
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -36);
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.ScrollBarThickness = 6;
    ScrollingFrame.Parent = Frame;
    Skin.scroll(ScrollingFrame);
    local UIGridLayout = Instance.new("UIGridLayout");
    UIGridLayout.CellPadding = UDim2.fromOffset(10, 10);
    UIGridLayout.CellSize = UDim2.fromOffset(140, 166);
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIGridLayout.Parent = ScrollingFrame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 4);
    UIPadding.PaddingLeft = UDim.new(0, 3);
    UIPadding.PaddingBottom = UDim.new(0, 8);
    UIPadding.Parent = ScrollingFrame;

    local function thumbnail(p67, p68) -- Line: 316
        -- upvalues: Weapons2 (copy), thumbPose (copy), KnifeIconCopy (copy), Unit (copy)
        if p68 then
            p68 = Weapons2.Models:FindFirstChild(p68.Model);
        end;

        local v69;

        if p68 then
            v69 = p68:FindFirstChild("Blade") or p68:FindFirstChildWhichIsA("MeshPart", true);
        else
            v69 = p68;
        end;

        if not v69 then
            return;
        end;

        local v70 = v69:Clone();
        local v71 = {};

        for _, descendant in v70:GetDescendants() do
            if descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or (descendant:IsA("WeldConstraint") or (descendant:IsA("Sound") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Light"))))))) then
                descendant:Destroy();
            elseif descendant:IsA("BasePart") then
                if descendant.Transparency >= 1 then
                    descendant:Destroy();
                else
                    v71[descendant] = v70.CFrame:ToObjectSpace(descendant.CFrame);
                end;
            end;
        end;

        v70.Anchored = true;
        v70.Transparency = 0;
        v70.CFrame = thumbPose(v70, p68);

        for i, v in v71 do
            if i.Parent then
                i.Anchored = true;
                i.CFrame = v70.CFrame * v;
            end;
        end;

        local Model = Instance.new("Model");
        v70.Parent = Model;
        local BoundingBox, v72 = Model:GetBoundingBox();
        Model:PivotTo(Model:GetPivot() - BoundingBox.Position);

        if KnifeIconCopy.cross(Model, p68, thumbPose, CFrame.lookAt(Unit, Vector3.new(0, 0, 0)).UpVector) then
            local v73;
            v73, v72 = Model:GetBoundingBox();
            Model:PivotTo(Model:GetPivot() - v73.Position);
        end;

        Model.Parent = p67;
        local v74 = math.max(v72.X, v72.Y, v72.Z, 0.5) * 1.85;
        local Camera = Instance.new("Camera");
        Camera.FieldOfView = 32;
        Camera.CFrame = CFrame.lookAt(Unit * v74, Vector3.new(0, 0, 0));
        Camera.Parent = p67;
        p67.CurrentCamera = Camera;
    end;

    local u75 = {};
    local u76 = nil;

    local function cardLabel(p77, p78, p79, p80) -- Line: 372
        -- upvalues: Skin (copy)
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.Name = p78;
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.Font = Enum.Font.GothamBold;
        TextLabel3.TextScaled = true;
        TextLabel3.TextColor3 = p79;
        TextLabel3.ZIndex = 3;
        TextLabel3:SetAttribute("SelfManagedText", true);
        TextLabel3.Parent = p77;
        Skin.textStroke(TextLabel3, p80);

        return TextLabel3;
    end;

    local function makeCard(u81) -- Line: 385
        -- upvalues: SkinCatalog2 (copy), Skin (copy), u55 (copy), Palette (copy), ScrollingFrame (copy), thumbnail (copy), cardLabel (copy), u76 (ref), rarityOf (copy), u75 (copy)
        local v82 = SkinCatalog2.get(u81);
        local v83, v84;

        if v82.Rarity then
            v83 = string.upper(v82.Rarity);
            v84 = Skin.Rarity[v82.Rarity] or v82.Accent;
            local _ = u55[v82.Rarity] or 0;
        else
            v83 = u81 == SkinCatalog2.Default and "STANDARD" or "EXCLUSIVE";
            v84 = v82.Accent;
            local _ = u81 == SkinCatalog2.Default;
        end;

        local Frame2 = Instance.new("Frame");
        Frame2.Name = u81;
        Frame2.BackgroundColor3 = Palette.surface;
        Frame2.BorderSizePixel = 0;
        Frame2.Parent = ScrollingFrame;
        Skin.card(Frame2, v84, {
            radius = UDim.new(0, 10),
            glow = v82.Rarity == "Legendary" and true or v82.Rarity == "Mythical"
        });
        local ViewportFrame = Instance.new("ViewportFrame");
        ViewportFrame.Name = "Thumb";
        ViewportFrame.BackgroundTransparency = 1;
        ViewportFrame.AnchorPoint = Vector2.new(0.5, 0);
        ViewportFrame.Position = UDim2.new(0.5, 0, 0, 4);
        ViewportFrame.Size = UDim2.new(1, -8, 0.64, 0);
        ViewportFrame.Ambient = Color3.fromRGB(205, 205, 215);
        ViewportFrame.LightColor = Color3.new(1, 1, 1);
        ViewportFrame.LightDirection = Vector3.new(-1, -1, -1);
        ViewportFrame.ZIndex = 2;
        ViewportFrame.Parent = Frame2;
        thumbnail(ViewportFrame, v82);
        local v85 = cardLabel(Frame2, "KnifeName", Palette.text, 1.5);
        v85.Text = string.gsub(v82.Name, "\n", " ");
        v85.Position = UDim2.new(0, 8, 0.67, 0);
        v85.Size = UDim2.new(1, -16, 0.15, 0);
        local v86 = cardLabel(Frame2, "Rarity", v84:Lerp(Palette.text, 0.3), 1);
        v86.Text = v83;
        v86.Position = UDim2.new(0, 8, 0.83, 0);
        v86.Size = UDim2.new(1, -16, 0.1, 0);
        local v87 = cardLabel(Frame2, "Equipped", Color3.new(0, 0, 0), 0);
        v87.Text = "EQUIPPED";
        v87.BackgroundTransparency = 0;
        v87.BackgroundColor3 = Palette.green;
        v87.Position = UDim2.fromOffset(6, 6);
        v87.Size = UDim2.fromOffset(70, 18);
        v87.ZIndex = 4;
        v87.Visible = false;
        Skin.corner(v87, UDim.new(1, 0));
        Skin.outline(v87, 1.5);
        local v88 = cardLabel(Frame2, "Copies", Color3.new(0, 0, 0), 0);
        v88.BackgroundTransparency = 0;
        v88.BackgroundColor3 = Palette.gold;
        v88.AnchorPoint = Vector2.new(1, 0);
        v88.Position = UDim2.new(1, -6, 0, 6);
        v88.Size = UDim2.fromOffset(34, 18);
        v88.ZIndex = 4;
        v88.Visible = false;
        Skin.corner(v88, UDim.new(1, 0));
        Skin.outline(v88, 1.5);
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "Pick";
        TextButton.Text = "";
        TextButton.BackgroundTransparency = 1;
        TextButton.AutoButtonColor = false;
        TextButton.Size = UDim2.fromScale(1, 1);
        TextButton.ZIndex = 5;
        TextButton.Parent = Frame2;
        TextButton.Activated:Connect(function() -- Line: 444
            -- upvalues: u76 (ref), u81 (copy)
            if u76 then
                u76(u81);
            end;
        end);
        local v89 = {
            frame = Frame2,
            badge = v87,
            copies = v88,
            viewport = ViewportFrame,
            name = v85,
            tier = v86,
            rarity = v83,
            color = v84,
            legendary = v82.Rarity == "Legendary" and true or v82.Rarity == "Mythical",
            tierColor = v84:Lerp(Palette.text, 0.3),
            rank = select(3, rarityOf(u81, v82))
        };
        u75[u81] = v89;

        return v89;
    end;

    local u90 = nil;

    local function groupOf(p91) -- Line: 468
        -- upvalues: state (ref), u90 (ref)
        if state.owned[p91] == true then
            return 0;
        end;

        local v92 = u90(p91);

        return v92 and (v92.buy and ((v92.kind == "Crate" or v92.kind == "HalloweenCrate") and 2 or 1) or 3) or 4;
    end;

    local u93 = false;
    local u94 = nil;

    local function renderCollection(p95) -- Line: 485
        -- upvalues: u94 (ref), state (ref), u90 (ref), rarityOf (copy), SkinCatalog2 (copy), u36 (copy), u75 (copy), makeCard (copy), Palette (copy), Default (ref), Skin (copy), TextLabel2 (copy), u93 (ref), u37 (ref), u54 (ref), renderCollection (copy)
        u94 = p95;
        local table_clone_ret = table.clone(p95);
        local u96 = {};
        local u97 = {};

        for _, v in table_clone_ret do
            local v98;

            if state.owned[v] == true then
                v98 = 0;
            else
                local v99 = u90(v);
                v98 = v99 and (v99.buy and ((v99.kind == "Crate" or v99.kind == "HalloweenCrate") and 2 or 1) or 3) or 4;
            end;

            u96[v] = v98;
            u97[v] = select(3, rarityOf(v, SkinCatalog2.get(v)));
        end;

        table.sort(table_clone_ret, function(p100, p101) -- Line: 493
            -- upvalues: state (ref), u96 (copy), u97 (copy), u36 (ref)
            local v102 = state.equipped == p100;

            if v102 ~= (state.equipped == p101) then
                return v102;
            end;

            if u96[p100] ~= u96[p101] then
                return u96[p100] < u96[p101];
            end;

            if u97[p100] == u97[p101] then
                return (u36[p100] or 0) < (u36[p101] or 0);
            end;

            return u97[p100] > u97[p101];
        end);
        local os_clock_ret2 = os.clock();
        local v103 = {};
        local v104 = false;

        for i, v in table_clone_ret do
            v103[v] = true;
            local v105 = u75[v];

            if not (v105 or v104) then
                if os.clock() - os_clock_ret2 < 0.005 then
                    v105 = makeCard(v);
                else
                    v104 = true;
                end;
            end;

            if v105 then
                v105.frame.LayoutOrder = i;
                local v106 = state.owned[v] == true;

                if v105.owned ~= v106 then
                    v105.owned = v106;
                    v105.tier.Text = v106 and (v105.rarity or "NOT OWNED") or "NOT OWNED";
                    v105.tier.TextColor3 = v106 and v105.tierColor or Palette.danger;
                end;

                local v107 = state.equipped == v and "equipped" or (v == Default and "selected" or "idle");

                if v105.look ~= v107 then
                    v105.look = v107;
                    local v108;

                    if v107 == "equipped" then
                        v108 = Palette.green or nil;
                    else
                        v108 = nil;
                    end;

                    Skin.select(v105.frame, v107 ~= "idle", v108);
                    v105.badge.Visible = v107 == "equipped";
                end;

                local v109 = v106 and state.knifeStacks and state.knifeStacks[v];
                local copies = v105.copies;
                local v110;

                if type(v109) == "number" then
                    v110 = v109 > 1;
                else
                    v110 = false;
                end;

                copies.Visible = v110;

                if v105.copies.Visible then
                    v105.copies.Text = "x" .. v109;
                end;
            end;
        end;

        for i, v in u75 do
            if not v103[i] then
                v.frame:Destroy();
                u75[i] = nil;
            end;
        end;

        local v111 = 0;

        for _, v in table_clone_ret do
            if state.owned[v] == true then
                v111 = v111 + 1;
            end;
        end;

        TextLabel2.Text = v111 .. " / " .. #table_clone_ret .. " OWNED";

        if v104 and not u93 then
            u93 = true;
            task.spawn(function() -- Line: 556
                -- upvalues: u93 (ref), u37 (ref), u54 (ref), u94 (ref), renderCollection (ref)
                task.wait();
                u93 = false;

                if u37 and (u54 == "Inventory" and u94) then
                    renderCollection(u94);
                end;
            end);
        end;
    end;

    local function applyViewStyle() -- Line: 565
        -- upvalues: u54 (ref), Canvas (copy), Frame (copy), u35 (copy), u37 (ref), ArmoryStyle (copy)
        local v112 = u54 == "Inventory";

        for _, v in { "Hero", "Details", "Sounds", "Status" } do
            Canvas[v].Visible = v112;
        end;

        Canvas.Selection.Visible = false;
        Frame.Visible = v112;
        u35:setOpen(u37 and not v112, u54);
        ArmoryStyle.view(Canvas, v112, u54);
    end;

    local function permitted() -- Line: 575
        -- upvalues: LocalPlayer (ref)
        local v113;

        if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and (LocalPlayer:GetAttribute("TutorialRouting") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true)) then
            v113 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
        else
            v113 = false;
        end;

        return v113;
    end;

    local function _() -- Line: 583
        -- upvalues: PlayerGui (copy)
        local LikeReward = PlayerGui:FindFirstChild("LikeReward");
        local v114;

        if LikeReward then
            v114 = LikeReward:FindFirstChild("PanelShade");
        else
            v114 = LikeReward;
        end;

        local v115;

        if v114 == nil then
            v115 = false;
        else
            v115 = LikeReward.Enabled and v114.Visible == true;
        end;

        return v115;
    end;

    local function comma(p116) -- Line: 588
        local math_floor_ret = math.floor(p116);

        return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    end;

    local function layout() -- Line: 592
        -- upvalues: ValleyArmory (copy), Vector2_zero (ref), Dock (copy), Canvas (copy), GuiService (ref), u30 (copy), u31 (copy), u54 (ref), Frame (copy), UIGridLayout (copy), u35 (copy)
        local AbsoluteSize = ValleyArmory.AbsoluteSize;

        if AbsoluteSize.X == 0 or AbsoluteSize.Y == 0 then
            return;
        end;

        if AbsoluteSize == Vector2_zero then
            return;
        end;

        Vector2_zero = AbsoluteSize;
        Dock.Scale.Scale = math.min(AbsoluteSize.X / 1280, AbsoluteSize.Y / 720);
        local v117 = AbsoluteSize.X / AbsoluteSize.Y < 1.1;
        local v118 = not v117 and AbsoluteSize.Y < 600;
        local v119 = v117 and 930 or (v118 and 490 or 680);
        Canvas.Size = UDim2.fromOffset(v117 and 600 or 1080, v119);
        local v120 = GuiService:GetGuiInset().Y + 6;
        local math_max_ret = math.max(14, v120);
        local v121 = AbsoluteSize.Y - math_max_ret - math.max(14, AbsoluteSize.Y * 0.04);
        local math_max_ret2 = math.max(100, v121);
        Canvas.Position = UDim2.new(0.5, 0, 0, math_max_ret + math_max_ret2 * 0.5);
        Canvas.Scale.Scale = math.min(1.05, AbsoluteSize.X * 0.94 / (v117 and 600 or 1080), math_max_ret2 / v119);
        Canvas.TopRule.Size = UDim2.new(1, 0, 0, 3);
        Canvas.Close.Position = UDim2.new(1, -85, 0, 23);
        Canvas.Wallet.Position = UDim2.fromOffset(v117 and 320 or 800, 23);
        Canvas.Tabs.Position = UDim2.fromOffset(v117 and 28 or 296, v117 and 92 or 25);
        Canvas.Tabs.Size = UDim2.fromOffset(486, 48);
        local v122 = 0;

        for _, v in u30 do
            local v123 = Canvas.Tabs[v];
            v123.Position = UDim2.fromOffset(v122, 0);
            v123.Size = UDim2.fromOffset(u31[v], 42);
            v123.TextScaled = true;
            v123.TextWrapped = false;
            v123.TextTruncate = Enum.TextTruncate.None;
            v122 = v122 + (u31[v] + 14);
        end;

        Canvas.Tabs.ActiveLine.Position = UDim2.fromOffset(Canvas.Tabs[u54].Position.X.Offset, 44);
        Canvas.Tabs.ActiveLine.Size = UDim2.fromOffset(u31[u54], 3);
        Canvas.HeaderRule.Position = UDim2.fromOffset(28, v117 and 151 or 99);
        Canvas.HeaderRule.Size = UDim2.new(1, -56, 0, 1);
        local v124 = v117 and 544 or 404;
        local v125 = v117 and 28 or 648;
        local v126 = v117 and 163 or (v118 and 110 or 118);
        local v127 = v117 and 190 or (v118 and 130 or 232);
        Canvas.Hero.Position = UDim2.fromOffset(v125, v126);
        Canvas.Hero.Size = UDim2.fromOffset(v124, v127);
        Canvas.Hero.Field.Position = UDim2.fromOffset(0, 0);
        Canvas.Hero.Field.Size = UDim2.new(1, 0, 1, v118 and 0 or -22);
        Canvas.Hero.Field.CentreLine.Visible = false;
        Canvas.Hero.Field.CentreCircle.Visible = false;
        Canvas.Hero.PreviewHint.Visible = not v118;
        Canvas.Hero.PreviewHint.Position = UDim2.new(0, 0, 1, -20);
        Canvas.Hero.PreviewHint.Size = UDim2.new(1, 0, 0, 20);
        Canvas.Hero.PreviewHint.TextSize = 12;
        local v128 = v126 + v127 + (v118 and 8 or 10);
        local v129 = v118 and 36 or (v117 and 48 or 62);
        local Details = Canvas.Details;
        Details.Position = UDim2.fromOffset(v125, v128);
        Details.Size = UDim2.fromOffset(v124, v118 and 146 or 220);
        Details.Collection.Size = UDim2.fromOffset(v124, 20);
        Details.Collection.TextSize = v118 and 12 or 14;
        Details.Title.Position = UDim2.fromOffset(0, 20);
        Details.Title.Size = UDim2.fromOffset(v124, v129);
        Details.Title.TextSize = v118 and 22 or (v117 and 28 or 30);
        Details.Subtitle.Position = UDim2.fromOffset(0, 20 + v129);
        Details.Subtitle.Size = UDim2.fromOffset(v124, v118 and 20 or 26);
        Details.Subtitle.TextSize = v118 and 14 or 17;
        Details.Description.Position = UDim2.fromOffset(0, 20 + v129 + (v118 and 22 or 30));
        Details.Description.Size = UDim2.fromOffset(v124, v118 and 28 or 40);
        Details.Description.TextSize = v118 and 12 or 15;
        Details.Action.Position = UDim2.fromOffset(0, v118 and 110 or 20 + v129 + 76);
        Details.Action.Size = UDim2.fromOffset(v124, v118 and 36 or 44);
        Details.Action.TextSize = v118 and 16 or 18;
        local v130 = v128 + (v118 and 152 or 20 + v129 + 130);
        Canvas.Sounds.Position = UDim2.fromOffset(v125, v130);
        Canvas.Sounds.Size = UDim2.fromOffset(v124, v118 and 32 or 36);
        local math_floor_ret = math.floor((v124 - 70 - 16) / 3);
        Canvas.Sounds.Label.Size = UDim2.fromOffset(66, v118 and 32 or 36);
        Canvas.Sounds.Label.TextSize = 13;

        for i, v in { "Equip", "Swing", "Hit" } do
            local v131 = Canvas.Sounds[v];
            v131.Position = UDim2.fromOffset(70 + (i - 1) * (math_floor_ret + 8), 0);
            v131.Size = UDim2.fromOffset(math_floor_ret, v118 and 32 or 36);
            v131.TextSize = v118 and 14 or 16;
        end;

        if v117 then
            v126 = v130 + 46 or v126;
        end;

        local v132 = v117 and 544 or 600;
        Frame.Position = UDim2.fromOffset(28, v126);
        Frame.Size = UDim2.fromOffset(v132, v119 - v126 - (v117 and 40 or 38));
        local math_floor_ret2 = math.floor((v132 - 3 - 10 - 30) / 4);
        UIGridLayout.CellSize = UDim2.fromOffset(math_floor_ret2, (math.floor(math_floor_ret2 * (v118 and 1.08 or 1.18))));
        Canvas.Status.Position = UDim2.fromOffset(298, v126);
        Canvas.Status.Size = UDim2.fromOffset(v132 - 270, 28);
        Canvas.Status.TextSize = 13;
        Canvas.Status.TextXAlignment = Enum.TextXAlignment.Right;
        Canvas.Status.TextTruncate = Enum.TextTruncate.AtEnd;
        Canvas.Selection.Visible = false;
        local v133 = v117 and 169 or 118;
        Canvas.Storefront.Position = UDim2.fromOffset(28, v133);
        Canvas.Storefront.Size = UDim2.new(1, -56, 1, -v133 - 33);
        Canvas.Notice.Position = UDim2.new(0, 28, 1, -29);
        Canvas.Notice.Size = UDim2.new(1, -56, 0, 25);
        u35:layout((v117 and 600 or 1080) - 56, v117);
    end;

    local function preview(p134) -- Line: 702
        -- upvalues: Canvas (copy), u38 (ref), SkinCatalog2 (copy), Weapons2 (copy), thumbPose (copy), KnifeIconCopy (copy), u39 (ref), u40 (ref), u41 (ref)
        local Weapon = Canvas.Hero.Weapon;
        Weapon:ClearAllChildren();
        u38 = nil;
        local v135 = SkinCatalog2.get(p134);

        if v135 then
            v135 = Weapons2.Models:FindFirstChild(v135.Model);
        end;

        if not v135 then
            return;
        end;

        local v136 = v135:FindFirstChild("Blade") or v135:FindFirstChildWhichIsA("MeshPart", true);

        if not v136 then
            return;
        end;

        local WorldModel = Instance.new("WorldModel");
        WorldModel.Parent = Weapon;
        u38 = Instance.new("Model");
        u38.Name = "Preview";
        u38.Parent = WorldModel;
        local v137 = v136:Clone();
        local v138 = {};

        for _, descendant in v137:GetDescendants() do
            if descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) then
                descendant:Destroy();
            elseif descendant:IsA("BasePart") then
                if descendant.Transparency >= 1 then
                    descendant:Destroy();
                else
                    v138[descendant] = v137.CFrame:ToObjectSpace(descendant.CFrame);
                end;
            end;
        end;

        v137.Anchored = true;
        v137.CanCollide = false;
        v137.CanTouch = false;
        v137.CanQuery = false;
        v137.Transparency = 0;
        v137.CFrame = thumbPose(v137, v135, (Vector3.new(0, 0.05, 1)).Unit);

        for i, v in v138 do
            if i.Parent then
                i.Anchored = true;
                i.CFrame = v137.CFrame * v;
            end;
        end;

        v137.Parent = u38;
        u38.PrimaryPart = v137;
        local BoundingBox, v139 = u38:GetBoundingBox();
        u38:PivotTo(u38:GetPivot() - BoundingBox.Position);
        local Unit2 = (Vector3.new(0, 0.05, 1)).Unit;

        if KnifeIconCopy.cross(u38, v135, function(p140, p141) -- Line: 756
            -- upvalues: thumbPose (ref), Unit2 (copy)
            return thumbPose(p140, p141, Unit2);
        end, CFrame.lookAt(Unit2, Vector3.new(0, 0, 0)).UpVector, v137) then
            local v142;
            v142, v139 = u38:GetBoundingBox();
            u38:PivotTo(u38:GetPivot() - v142.Position);
        end;

        u39 = math.max(v139.X, v139.Y, v139.Z);
        u40 = Instance.new("Camera");
        u40.FieldOfView = 33;
        u40.Parent = Weapon;
        Weapon.CurrentCamera = u40;
        u41 = 0;
    end;

    local function releaseKnives() -- Line: 773
        -- upvalues: u75 (copy), Canvas (copy), u38 (ref), u40 (ref)
        for i, v in u75 do
            v.frame:Destroy();
            u75[i] = nil;
        end;

        local Weapon = Canvas.Hero.Weapon;
        Weapon:ClearAllChildren();
        Weapon.CurrentCamera = nil;
        u38 = nil;
        u40 = nil;
    end;

    local CrateCatalog = require(ChickenOrHero2:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
    local JourneyConfig = require(ChickenOrHero2:WaitForChild("Progression"):WaitForChild("JourneyConfig"));
    local ShopConfig = require(Weapons2:WaitForChild("ShopConfig"));
    local OfferRules = require(Weapons2:WaitForChild("OfferRules"));
    local Bundles = require(Weapons2:WaitForChild("Bundles"));
    local u143 = {};
    local u144 = {};
    local u145 = {};

    for _, v in ShopConfig.AdditionalKnives or {} do
        u143[v.SkinId] = true;
    end;

    for i, v in CrateCatalog.Crates do
        local v146 = i;

        for _, v2 in v.Entries do
            if v2.Skin then
                u144[v2.Skin] = v146;
            end;
        end;
    end;

    for _, v in JourneyConfig.Rewards do
        for _, v2 in v do
            if v2.SkinId then
                u145[v2.SkinId] = true;
            end;
        end;
    end;

    u90 = function(p147) -- Line: 809, Name: sourceOf
        -- upvalues: u144 (copy), CrateCatalog (copy), ChickenOrHero2 (copy), Bundles (copy), OfferRules (copy), Canvas (copy), ShopConfig (copy), u143 (copy), SkinCatalog2 (copy), u145 (copy), u35 (copy)
        local v148 = u144[p147];
        local v149;

        if v148 then
            v149 = CrateCatalog.get(v148);
        else
            v149 = v148;
        end;

        if v149 and v149.Halloween then
            local v150 = ChickenOrHero2:FindFirstChild("Game") and ChickenOrHero2.Game:FindFirstChild("HalloweenShopEvent");

            if v150 and v150:GetAttribute("Live") == true then
                return {
                    kind = "HalloweenCrate",
                    buy = true,
                    label = "BUY NOW",
                    crate = v148
                };
            end;
        elseif v148 then
            return {
                kind = "Crate",
                buy = true,
                label = "BUY NOW",
                crate = v148
            };
        end;

        for _, v in Bundles.shopList() do
            if p147 == v.SkinId and OfferRules.active(v, os.time()) then
                return {
                    kind = "Bundle",
                    buy = true,
                    label = "BUY NOW",
                    key = v.Key
                };
            end;
        end;

        local Storefront = Canvas.Storefront;
        local VIP = ShopConfig.Passes.VIP;
        local Earnable = ShopConfig.Earnable;
        local v151 = p147 == ShopConfig.Flagship.SkinId and Storefront:FindFirstChild("Featured") or (p147 == ShopConfig.GhostFlagship.SkinId and Storefront:FindFirstChild("GhostFeatured") or p147 == ShopConfig.FootballFlagship.SkinId and Storefront:FindFirstChild("FootballFeatured")) or (p147 == ShopConfig.FutbolFlagship.SkinId and Storefront:FindFirstChild("FutbolFeatured") or (p147 == "BalloonDagger" or p147 == "TopWinsDagger") and Storefront:FindFirstChild(p147) or (u143[p147] and Storefront:FindFirstChild(p147) or VIP and p147 == VIP.RewardSkinId and Storefront:FindFirstChild("Perks")));

        if not v151 then
            if Earnable and (p147 == Earnable.SkinId and SkinCatalog2.get(p147).Available) then
                v151 = Storefront:FindFirstChild("Earnable") or nil;
            else
                v151 = nil;
            end;
        end;

        if (p147 == ShopConfig.FootballFlagship.SkinId and true or p147 == ShopConfig.FutbolFlagship.SkinId) and not (v151 and v151.Visible) then
            v151 = Storefront:FindFirstChild("EventKnives") or v151;
        end;

        if v151 and v151.Visible then
            local v152 = v151.Name:find("Featured$") and v151.Name or (v151.Name == "EventKnives" and "EventKnives" or (v151.Name == "Perks" and "VIP" or (v151.Name == "Earnable" and "Earnable" or p147)));
            local v153 = p147 == "BalloonDagger" and true or p147 == "TopWinsDagger";

            return {
                kind = "Shop",
                section = v152,
                buy = not v153,
                label = v153 and "VIEW IN SHOP" or "BUY NOW"
            };
        end;

        if u145[p147] then
            return {
                kind = "Journey",
                label = "GET IT IN THE JOURNEY"
            };
        end;

        local v154 = u35.questState and u35.questState.event;

        if v154 and v154.phase == "Active" then
            for _, v in v154.weapons or {} do
                if v.id == p147 then
                    return {
                        kind = "Quests",
                        label = "VIEW QUESTS"
                    };
                end;
            end;
        end;

        return nil;
    end;

    local function escape(p155) -- Line: 868
        return p155:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
    end;

    local function subtitleText(p156) -- Line: 873
        -- upvalues: Skin (copy), Canvas (copy)
        local v157 = p156.Subtitle or "";
        local Rarity = p156.Rarity;

        if Rarity and string.sub(v157, 1, #Rarity) == Rarity then
            return ("<font color=\"#%s\" size=\"%d\"><b>%s</b></font>%s"):format((Skin.Rarity[Rarity] or p156.Accent):ToHex(), Canvas.Details.Subtitle.TextSize + 5, Rarity, (string.sub(v157, #Rarity + 1):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")));
        end;

        return v157:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
    end;

    if os.clock() - os_clock_ret >= 0.006 then
        task.wait();
        os_clock_ret = os.clock();
    end;

    local u158 = require(ChickenOrHero2:WaitForChild("Interface"):WaitForChild("PreviewButton")).row(Canvas.Sounds, PresentationCues);

    if os.clock() - os_clock_ret >= 0.006 then
        task.wait();
        os_clock_ret = os.clock();
    end;

    local function updateAction() -- Line: 891
        -- upvalues: SkinCatalog2 (copy), Default (ref), u158 (copy), Canvas (copy), subtitleText (copy), state (ref), u54 (ref), u90 (ref), ArmoryStyle (copy)
        local v159 = SkinCatalog2.get(Default);

        if not v159 then
            return;
        end;

        u158:set(Default);
        Canvas.Details.Collection.Text = v159.Collection;
        Canvas.Details.Collection.TextColor3 = v159.Accent;
        Canvas.Details.Title.Text = v159.Name;
        Canvas.Details.Subtitle.RichText = true;
        Canvas.Details.Subtitle.Text = subtitleText(v159);
        Canvas.Details.Description.Text = v159.Description;
        local Action = Canvas.Details.Action;
        local v160 = state.owned[Default] == true;

        if state.loaded then
            if state.equipped == Default then
                Action.Text = "EQUIPPED  ✓";
            elseif v160 then
                Action.Text = "EQUIP KNIFE";
            elseif u54 == "Inventory" then
                local v161 = u90(Default);
                Action.Text = v161 and v161.label or "NOT FOR SALE";
            elseif v159.Available and v159.Offer then
                local math_floor_ret = math.floor(v159.Offer.Price);
                Action.Text = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "  " .. string.upper(v159.Offer.Currency);
            else
                Action.Text = "COMING LATER";
            end;
        else
            Action.Text = "LOADING COLLECTION…";
        end;

        local loaded = state.loaded;

        if loaded then
            if (not v160 or state.equipped == Default) and (v160 or (u54 ~= "Inventory" or u90(Default) == nil)) then
                loaded = not v160;

                if loaded then
                    if u54 == "Inventory" then
                        loaded = false;
                    else
                        loaded = v159.Available and v159.Offer ~= nil;
                    end;
                end;
            else
                loaded = true;
            end;
        end;

        Action.Active = loaded;
        Action.AutoButtonColor = loaded;
        ArmoryStyle.action(Canvas, u54 == "Inventory", loaded, state.loaded and state.equipped == Default and "equipped" or nil);
    end;

    local function render() -- Line: 930
        -- upvalues: applyViewStyle (copy), SkinCatalog2 (copy), u54 (ref), state (ref), Default (ref), preview (copy), renderCollection (copy), Canvas (copy), u31 (copy), updateAction (copy)
        applyViewStyle();
        local v162 = {};

        for _, v in SkinCatalog2.Order do
            local v163 = SkinCatalog2.get(v);

            if (not v163 or v163.HideOwned ~= true) and (u54 == "Shop" and (v ~= "DevelopersPencil" and v ~= "SecretPencil") or u54 == "Inventory" and (v163.Hide ~= true or state.owned[v] == true)) then
                table.insert(v162, v);
            end;
        end;

        local v164 = #v162 == 0 and { SkinCatalog2.Default } or v162;

        if not table.find(v164, Default) then
            Default = v164[1];

            if u54 == "Inventory" then
                preview(Default);
            end;
        end;

        if u54 == "Inventory" then
            renderCollection(v164);
        end;

        Canvas.Tabs.ActiveLine.Position = UDim2.fromOffset(Canvas.Tabs[u54].Position.X.Offset, 44);
        Canvas.Tabs.ActiveLine.Size = UDim2.fromOffset(u31[u54], 3);
        updateAction();
    end;

    u76 = function(p165) -- Line: 963
        -- upvalues: Default (ref), preview (copy), render (copy)
        Default = p165;
        preview(p165);
        render();
    end;

    local function gamepadPreferred() -- Line: 970
        -- upvalues: UserInputService (ref)
        local success, result = pcall(function() -- Line: 971
            -- upvalues: UserInputService (ref)
            return UserInputService.PreferredInput == Enum.PreferredInput.Gamepad;
        end);

        if success then
            success = result == true;
        end;

        return success;
    end;

    local function gamepadCursor(p166) -- Line: 976
        -- upvalues: u59 (ref), UserInputService (ref), GamepadService (copy), Canvas (copy)
        if p166 then
            if not u59 then
                local success, result = pcall(function() -- Line: 971
                    -- upvalues: UserInputService (ref)
                    return UserInputService.PreferredInput == Enum.PreferredInput.Gamepad;
                end);

                if success then
                    success = result == true;
                end;

                if success and not GamepadService.GamepadCursorEnabled then
                    u59 = pcall(GamepadService.EnableGamepadCursor, GamepadService, Canvas);
                end;
            end;
        elseif u59 then
            u59 = false;

            if GamepadService.GamepadCursorEnabled then
                pcall(GamepadService.DisableGamepadCursor, GamepadService);
            end;
        end;
    end;

    local function setOpen(p167, p168) -- Line: 988
        -- upvalues: HudNavigation (ref), u54 (ref), permitted (copy), Vector2_zero (ref), Canvas (copy), u37 (ref), PresentationCues (copy), ArmoryEvent2 (copy), ValleyArmory (copy), ValleyArmoryShade (copy), u35 (copy), LocalPlayer (ref), releaseKnives (copy), Default (ref), state (ref), render (copy), preview (copy), layout (copy), u58 (ref), u59 (ref), UserInputService (ref), GamepadService (copy)
        if p167 then
            HudNavigation.opening((p168 or u54) == "Inventory" and "Inventory" or "Shop");
        end;

        if p167 and not permitted() then
            return;
        end;

        if p168 then
            u54 = p168;
            Vector2_zero = Vector2.zero;
            Canvas.Status.Text = u54 == "Inventory" and "Your collection. Your choice." or "Earn coins by playing. Find your next favourite.";
        end;

        local v169 = u37;

        if p167 and not u37 then
            PresentationCues:Fire("ArmoryOpen");
            ArmoryEvent2:FireServer("Get");
        elseif not p167 and u37 then
            PresentationCues:Fire("ArmoryClose");
        end;

        u37 = p167;
        ValleyArmory.Overlay.Visible = p167;
        ValleyArmoryShade.Enabled = p167;
        local v170;

        if p167 then
            v170 = u54 ~= "Inventory";
        else
            v170 = p167;
        end;

        u35:setOpen(v170, u54);
        LocalPlayer:SetAttribute("ArmoryOpen", p167);

        if not p167 or u54 ~= "Inventory" then
            releaseKnives();
        end;

        if p167 then
            Default = u54 == "Inventory" and state.equipped or Default;
            render();

            if u54 == "Inventory" then
                preview(Default);
            end;

            layout();
        end;

        if p167 and not v169 then
            task.defer(function() -- Line: 1027
                -- upvalues: u58 (ref), u37 (ref), u59 (ref), UserInputService (ref), GamepadService (ref), Canvas (ref)
                if u58 and (u37 and not u59) then
                    local success, result = pcall(function() -- Line: 971
                        -- upvalues: UserInputService (ref)
                        return UserInputService.PreferredInput == Enum.PreferredInput.Gamepad;
                    end);

                    if success then
                        success = result == true;
                    end;

                    if success and not GamepadService.GamepadCursorEnabled then
                        u59 = pcall(GamepadService.EnableGamepadCursor, GamepadService, Canvas);
                    end;
                end;
            end);

            return;
        end;

        if not p167 and (v169 and u59) then
            u59 = false;

            if GamepadService.GamepadCursorEnabled then
                pcall(GamepadService.DisableGamepadCursor, GamepadService);
            end;
        end;
    end;

    local function openEmotes() -- Line: 1037
        -- upvalues: EmoteCatalog (copy), EmoteStoreClient (copy), LocalPlayer (ref), ValleyToast2 (copy), setOpen (copy)
        if EmoteCatalog.ComingSoon then
            EmoteStoreClient.comingSoon();

            return;
        end;

        if LocalPlayer:GetAttribute("InMatch") == true then
            ValleyToast2.show("Open My Emotes in the lobby.");

            return;
        end;

        setOpen(true, "Emotes");
    end;

    Weapons2:WaitForChild("ArmoryNavigation").Event:Connect(function(u171) -- Line: 1048
        -- upvalues: EmoteCatalog (copy), EmoteStoreClient (copy), LocalPlayer (ref), ValleyToast2 (copy), setOpen (copy), u37 (ref), u54 (ref), u35 (copy)
        if u171 == "Emotes" then
            if EmoteCatalog.ComingSoon then
                EmoteStoreClient.comingSoon();

                return;
            end;

            if LocalPlayer:GetAttribute("InMatch") == true then
                ValleyToast2.show("Open My Emotes in the lobby.");

                return;
            end;

            setOpen(true, "Emotes");

            return;
        end;

        if u171 ~= "Featured" and (u171 ~= "Earnable" and u171 ~= "VIP") then
            return;
        end;

        setOpen(true, "Shop");

        if u37 then
            task.defer(function() -- Line: 1060
                -- upvalues: u37 (ref), u54 (ref), u35 (ref), u171 (copy)
                if u37 and u54 == "Shop" then
                    u35:focus(u171);
                end;
            end);
        end;
    end);

    local function availability() -- Line: 1068
        -- upvalues: permitted (copy), Dock (copy), HudNavigation (ref), LocalPlayer (ref), u37 (ref), PresentationCues (copy), ValleyArmory (copy), ValleyArmoryShade (copy), u35 (copy), u54 (ref), releaseKnives (copy), u59 (ref), GamepadService (copy)
        local v172 = permitted();
        Dock.Visible = false;
        HudNavigation.setAvailable("Shop", v172);
        HudNavigation.setAvailable("Inventory", v172);
        HudNavigation.setAvailable("Abilities", v172);
        HudNavigation.setAvailable("Items", v172);

        if not (v172 and (LocalPlayer:GetAttribute("ServerBrowserOpen") ~= true and LocalPlayer:GetAttribute("MatchSummaryVisible") ~= true)) then
            local v173 = u37;

            if u37 then
                PresentationCues:Fire("ArmoryClose");
            end;

            u37 = false;
            ValleyArmory.Overlay.Visible = false;
            ValleyArmoryShade.Enabled = false;
            u35:setOpen(false, u54);
            LocalPlayer:SetAttribute("ArmoryOpen", false);
            releaseKnives();

            if v173 and u59 then
                u59 = false;

                if GamepadService.GamepadCursorEnabled then
                    pcall(GamepadService.DisableGamepadCursor, GamepadService);
                end;
            end;
        end;
    end;

    HudNavigation.register("Shop", function() -- Line: 1083
        -- upvalues: setOpen (copy)
        setOpen(true, "Shop");
    end);
    HudNavigation.register("Inventory", function() -- Line: 1086
        -- upvalues: setOpen (copy)
        setOpen(true, "Inventory");
    end);
    HudNavigation.register("Abilities", function() -- Line: 1090
        -- upvalues: setOpen (copy)
        setOpen(true, "Abilities");
    end);
    HudNavigation.register("Items", function() -- Line: 1094
        -- upvalues: setOpen (copy)
        setOpen(true, "Items");
    end);
    HudNavigation.Opening.Event:Connect(function(p174) -- Line: 1097
        -- upvalues: u37 (ref), PresentationCues (copy), ValleyArmory (copy), ValleyArmoryShade (copy), u35 (copy), u54 (ref), LocalPlayer (ref), releaseKnives (copy), u59 (ref), GamepadService (copy)
        if p174 ~= "Shop" and p174 ~= "Inventory" then
            local v175 = u37;

            if u37 then
                PresentationCues:Fire("ArmoryClose");
            end;

            u37 = false;
            ValleyArmory.Overlay.Visible = false;
            ValleyArmoryShade.Enabled = false;
            u35:setOpen(false, u54);
            LocalPlayer:SetAttribute("ArmoryOpen", false);
            releaseKnives();

            if v175 and u59 then
                u59 = false;

                if GamepadService.GamepadCursorEnabled then
                    pcall(GamepadService.DisableGamepadCursor, GamepadService);
                end;
            end;
        end;
    end);
    Dock.Shop.Activated:Connect(function() -- Line: 1102
        -- upvalues: setOpen (copy)
        setOpen(true, "Shop");
    end);
    Dock.Inventory.Activated:Connect(function() -- Line: 1105
        -- upvalues: setOpen (copy)
        setOpen(true, "Inventory");
    end);
    v33.Activated:Connect(function() -- Line: 1108
        -- upvalues: setOpen (copy)
        setOpen(true, "Items");
    end);
    v34.Activated:Connect(openEmotes);
    v32.Activated:Connect(function() -- Line: 1112
        -- upvalues: setOpen (copy)
        setOpen(true, "Abilities");
    end);
    Canvas.Tabs.Shop.Activated:Connect(function() -- Line: 1115
        -- upvalues: setOpen (copy)
        setOpen(true, "Shop");
    end);
    Canvas.Tabs.Inventory.Activated:Connect(function() -- Line: 1118
        -- upvalues: setOpen (copy)
        setOpen(true, "Inventory");
    end);
    Canvas.Close.Activated:Connect(function() -- Line: 1121
        -- upvalues: u37 (ref), PresentationCues (copy), ValleyArmory (copy), ValleyArmoryShade (copy), u35 (copy), u54 (ref), LocalPlayer (ref), releaseKnives (copy), u59 (ref), GamepadService (copy)
        local v176 = u37;

        if u37 then
            PresentationCues:Fire("ArmoryClose");
        end;

        u37 = false;
        ValleyArmory.Overlay.Visible = false;
        ValleyArmoryShade.Enabled = false;
        u35:setOpen(false, u54);
        LocalPlayer:SetAttribute("ArmoryOpen", false);
        releaseKnives();

        if v176 and u59 then
            u59 = false;

            if GamepadService.GamepadCursorEnabled then
                pcall(GamepadService.DisableGamepadCursor, GamepadService);
            end;
        end;
    end);

    local function goTo(u177) -- Line: 1126
        -- upvalues: setOpen (copy), u37 (ref), u54 (ref), u35 (copy), PresentationCues (copy), ValleyArmory (copy), ValleyArmoryShade (copy), LocalPlayer (ref), releaseKnives (copy), u59 (ref), GamepadService (copy), Weapons2 (copy), HudNavigation (ref)
        if not u177 then
            return;
        end;

        if u177.kind == "Shop" then
            setOpen(true, "Shop");
            task.defer(function() -- Line: 1132
                -- upvalues: u37 (ref), u54 (ref), u35 (ref), u177 (copy)
                if u37 and u54 == "Shop" then
                    u35:focus(u177.section);
                end;
            end);

            return;
        end;

        if u177.kind == "Crate" then
            local v178 = u37;

            if u37 then
                PresentationCues:Fire("ArmoryClose");
            end;

            u37 = false;
            ValleyArmory.Overlay.Visible = false;
            ValleyArmoryShade.Enabled = false;
            u35:setOpen(false, u54);
            LocalPlayer:SetAttribute("ArmoryOpen", false);
            releaseKnives();

            if v178 and u59 then
                u59 = false;

                if GamepadService.GamepadCursorEnabled then
                    pcall(GamepadService.DisableGamepadCursor, GamepadService);
                end;
            end;

            Weapons2.ArmoryNavigation:Fire("Crate:" .. u177.crate);

            return;
        end;

        if u177.kind == "HalloweenCrate" then
            local v179 = u37;

            if u37 then
                PresentationCues:Fire("ArmoryClose");
            end;

            u37 = false;
            ValleyArmory.Overlay.Visible = false;
            ValleyArmoryShade.Enabled = false;
            u35:setOpen(false, u54);
            LocalPlayer:SetAttribute("ArmoryOpen", false);
            releaseKnives();

            if v179 and u59 then
                u59 = false;

                if GamepadService.GamepadCursorEnabled then
                    pcall(GamepadService.DisableGamepadCursor, GamepadService);
                end;
            end;

            Weapons2.ArmoryNavigation:Fire("HalloweenCrate:" .. u177.crate);

            return;
        end;

        if u177.kind == "Bundle" then
            require(Weapons2:WaitForChild("BundlePanel")).open(false, u177.key);

            return;
        end;

        if u177.kind ~= "Journey" then
            if u177.kind == "Quests" then
                local v180 = u37;

                if u37 then
                    PresentationCues:Fire("ArmoryClose");
                end;

                u37 = false;
                ValleyArmory.Overlay.Visible = false;
                ValleyArmoryShade.Enabled = false;
                u35:setOpen(false, u54);
                LocalPlayer:SetAttribute("ArmoryOpen", false);
                releaseKnives();

                if v180 and u59 then
                    u59 = false;

                    if GamepadService.GamepadCursorEnabled then
                        pcall(GamepadService.DisableGamepadCursor, GamepadService);
                    end;
                end;

                LocalPlayer:SetAttribute("QuestOpenRequestedAt", os.clock());
            end;

            return;
        end;

        local v181 = u37;

        if u37 then
            PresentationCues:Fire("ArmoryClose");
        end;

        u37 = false;
        ValleyArmory.Overlay.Visible = false;
        ValleyArmoryShade.Enabled = false;
        u35:setOpen(false, u54);
        LocalPlayer:SetAttribute("ArmoryOpen", false);
        releaseKnives();

        if v181 and u59 then
            u59 = false;

            if GamepadService.GamepadCursorEnabled then
                pcall(GamepadService.DisableGamepadCursor, GamepadService);
            end;
        end;

        HudNavigation.activate("Journey");
    end;

    Canvas.Details.Action.Activated:Connect(function() -- Line: 1153
        -- upvalues: state (ref), Default (ref), u54 (ref), goTo (copy), u90 (ref), SkinCatalog2 (copy), CurrencyTopUp (copy), ArmoryEvent2 (copy)
        if not state.loaded or state.equipped == Default then
            return;
        end;

        if u54 == "Inventory" and state.owned[Default] ~= true then
            goTo(u90(Default));

            return;
        end;

        local v182 = not state.owned[Default] and SkinCatalog2.get(Default);
        local v183 = v182 and v182.Available and v182.Offer;

        if v183 and (v183.Currency == "coins" or v183.Currency == "gems") then
            local v184 = state[v183.Currency] or 0;

            if v184 < v183.Price then
                CurrencyTopUp.prompt(v183.Currency, v183.Price, v184);

                return;
            end;
        end;

        ArmoryEvent2:FireServer(state.owned[Default] and "Equip" or "Buy", Default);
    end);

    for _, v in { "Equip", "Swing", "Hit" } do
        Canvas.Sounds[v].Activated:Connect(function() -- Line: 1174
            -- upvalues: PresentationCues (copy), Default (ref), v (copy)
            PresentationCues:Fire("KnifePreview", Default, v);
        end);
    end;

    ArmoryEvent2.OnClientEvent:Connect(function(p185, p186) -- Line: 1178
        -- upvalues: state (ref), u35 (copy), HudNavigation (ref), Dock (copy), Canvas (copy), TweenService (ref), Skin (copy), u37 (ref), PlayerGui (copy), ValleyToast2 (copy), u54 (ref), render (copy)
        if p185 ~= "State" or type(p186) ~= "table" then
            return;
        end;

        local coins = state.coins;
        local gems = state.gems;
        state = p186;
        u35:update(state);
        HudNavigation.setWallet(p186.loaded, p186.coins, p186.gems);
        local Coins = Dock.Coins;
        local v187;

        if p186.loaded then
            local math_floor_ret = math.floor(p186.coins);
            v187 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "—";
        else
            v187 = "—";
        end;

        Coins.Text = v187;
        local Gems = Dock.Gems;
        local v188;

        if p186.loaded then
            local math_floor_ret = math.floor(p186.gems);
            v188 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "—";
        else
            v188 = "—";
        end;

        Gems.Text = v188;
        Canvas.Wallet.Coins.Text = "●  " .. Dock.Coins.Text;
        Canvas.Wallet.Gems.Text = "◆  " .. Dock.Gems.Text;

        if p186.loaded and coins < p186.coins then
            Dock.Coins.TextColor3 = Color3.fromRGB(255, 240, 200);
            TweenService:Create(Dock.Coins, TweenInfo.new(0.8), {
                TextColor3 = Skin.Palette.gold
            }):Play();
        end;

        if p186.loaded and gems < p186.gems then
            Dock.Gems.TextColor3 = Color3.fromRGB(219, 255, 239);
            TweenService:Create(Dock.Gems, TweenInfo.new(0.65), {
                TextColor3 = Skin.Palette.gemText
            }):Play();
        end;

        if type(p186.message) == "string" and (p186.message ~= "" and not u37) then
            local LikeReward = PlayerGui:FindFirstChild("LikeReward");
            local v189;

            if LikeReward then
                v189 = LikeReward:FindFirstChild("PanelShade");
            else
                v189 = LikeReward;
            end;

            local v190;

            if v189 == nil then
                v190 = false;
            else
                v190 = LikeReward.Enabled and v189.Visible == true;
            end;

            if not v190 then
                ValleyToast2.show(p186.message);
            end;
        end;

        Canvas.Status.Text = p186.message or (u54 == "Inventory" and "Your collection. Your choice." or "Earn coins by playing. Find your next favourite.");

        if u37 then
            render();
        end;
    end);
    Canvas.Hero.Weapon.InputBegan:Connect(function(p191) -- Line: 1212
        -- upvalues: u56 (ref), u57 (ref)
        if p191.UserInputType == Enum.UserInputType.MouseButton1 or p191.UserInputType == Enum.UserInputType.Touch then
            u56 = true;
            u57 = p191.Position.X;
        end;
    end);
    UserInputService.InputChanged:Connect(function(p192) -- Line: 1218
        -- upvalues: u56 (ref), u41 (ref), u57 (ref)
        if u56 and (p192.UserInputType == Enum.UserInputType.MouseMovement or p192.UserInputType == Enum.UserInputType.Touch) then
            u41 = u41 + (p192.Position.X - u57) * 0.012;
            u57 = p192.Position.X;
        end;
    end);
    UserInputService.InputEnded:Connect(function(p193) -- Line: 1227
        -- upvalues: u56 (ref)
        if p193.UserInputType == Enum.UserInputType.MouseButton1 or p193.UserInputType == Enum.UserInputType.Touch then
            u56 = false;
        end;
    end);
    UserInputService.InputBegan:Connect(function(p194, p195) -- Line: 1232
        -- upvalues: UserInputService (ref), u37 (ref), PresentationCues (copy), ValleyArmory (copy), ValleyArmoryShade (copy), u35 (copy), u54 (ref), LocalPlayer (ref), releaseKnives (copy), u59 (ref), GamepadService (copy), setOpen (copy)
        if UserInputService:GetFocusedTextBox() then
            return;
        end;

        if u37 and (p194.KeyCode == Enum.KeyCode.ButtonB or p194.KeyCode == Enum.KeyCode.Escape) then
            local v196 = u37;

            if u37 then
                PresentationCues:Fire("ArmoryClose");
            end;

            u37 = false;
            ValleyArmory.Overlay.Visible = false;
            ValleyArmoryShade.Enabled = false;
            u35:setOpen(false, u54);
            LocalPlayer:SetAttribute("ArmoryOpen", false);
            releaseKnives();

            if v196 and u59 then
                u59 = false;

                if GamepadService.GamepadCursorEnabled then
                    pcall(GamepadService.DisableGamepadCursor, GamepadService);
                end;
            end;
        elseif not (p195 or p194.KeyCode ~= Enum.KeyCode.N and p194.KeyCode ~= Enum.KeyCode.ButtonY) then
            setOpen(not u37, "Inventory");
        end;
    end);

    for _, v in { "ClientReady", "InMatch", "TutorialRouting", "ScreenPresentationActive", "AdminRefreshActive", "ServerBrowserOpen", "MatchSummaryVisible" } do
        LocalPlayer:GetAttributeChangedSignal(v):Connect(availability);
    end;

    local u201 = RunService.RenderStepped:Connect(function(p197) -- Line: 1255
        -- upvalues: layout (copy), u35 (copy), u37 (ref), u54 (ref), u40 (ref), u38 (ref), u56 (ref), u41 (ref), u39 (ref)
        layout();
        u35:step(p197);

        if u37 and (u54 == "Inventory" and (u40 and u38)) then
            if not u56 then
                u41 = u41 + math.min(p197, 0.1) * 0.18;
            end;

            local v198 = u39 * 2;
            local CFrame_lookAt = CFrame.lookAt;
            local v199 = math.sin(u41) * v198;
            local v200 = math.cos(u41) * v198;
            u40.CFrame = CFrame_lookAt(Vector3.new(v199, u39 * 0.1, v200), Vector3.new(0, 0, 0));
        end;
    end);
    u1.live = true;

    if u1.state ~= state then
        state = u1.state;
        u35:update(state);
    end;

    LocalPlayer:SetAttribute("ArmoryOpen", false);
    availability();
    layout();
    task.spawn(function() -- Line: 1276
        -- upvalues: u58 (ref), state (ref), ArmoryEvent2 (copy)
        while u58 and not state.loaded do
            ArmoryEvent2:FireServer("Get");
            task.wait(3);
        end;
    end);
    script.Destroying:Connect(function() -- Line: 1282
        -- upvalues: u58 (ref), u59 (ref), GamepadService (copy), u201 (copy), u35 (copy), ValleyArmoryShade (copy), LocalPlayer (ref)
        u58 = false;

        if u59 then
            u59 = false;

            if GamepadService.GamepadCursorEnabled then
                pcall(GamepadService.DisableGamepadCursor, GamepadService);
            end;
        end;

        u201:Disconnect();
        u35:destroy();
        ValleyArmoryShade.Enabled = false;
        LocalPlayer:SetAttribute("ArmoryOpen", false);
    end);
end;