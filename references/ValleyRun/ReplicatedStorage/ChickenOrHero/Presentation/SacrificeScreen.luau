 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local PumpkinHuntConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntConfig"));
local success, result = pcall(function() -- Line: 33
    -- upvalues: ChickenOrHero (copy)
    return require(ChickenOrHero:WaitForChild("Game"):WaitForChild("RandomPrizePolicy", 10)).start();
end);

if not success or type(result) ~= "table" then
    warn("[SacrificeScreen] Game.RandomPrizePolicy didn\'t load (" .. tostring(result) .. "); nobody is treated as restricted");
    result = {
        restricted = function() -- Line: 40, Name: restricted
            return false;
        end,

        start = function() -- Line: 40, Name: start
        end,

        Changed = Instance.new("BindableEvent")
    };
end;

local u1 = "Feed " .. PumpkinHuntConfig.commas(PumpkinHuntConfig.Pot.Goal) .. " coins to start a Pumpkin Hunt next match!\nExtra coins = luckier pumpkins!";
local u2 = "Feed " .. PumpkinHuntConfig.commas(PumpkinHuntConfig.Pot.Goal) .. " coins to start a Pumpkin Hunt next match!\nEvery pumpkin you collect = " .. PumpkinHuntConfig.commas(PumpkinHuntConfig.RestrictedCoins) .. " coins!";
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local KnifeIconCopy = require(Weapons:WaitForChild("KnifeIconCopy"));
local ArmoryEvent = Weapons:WaitForChild("ArmoryEvent");
local LocalPlayer = Players.LocalPlayer;
local u3 = {};
u3.__index = u3;
u3.UNAVAILABLE = PumpkinHuntConfig.Unavailable;
u3.sacrificed = Instance.new("BindableEvent");
local u4 = {
    Pumpkin = "rbxassetid://122172980164834",
    Bat = "rbxassetid://70771941159898",
    Moon = "rbxassetid://108163343124811",
    Web = "rbxassetid://77897902869831",
    Tombstone = "rbxassetid://109374624586738",
    Cauldron = "rbxassetid://83317730984861",
    Coin = "rbxassetid://78008558948307",
    Gem = "rbxassetid://137046122108742",
    CandyCorn = "rbxassetid://119759573303359",
    GhostKey = "rbxassetid://99826093535691",
    Glow = "rbxassetid://129028976496842",
    GlowGold = "rbxassetid://101867007295297",
    Stripes = "rbxassetid://140022482252277"
};
local u5 = {
    night = Color3.fromRGB(34, 16, 48),
    deep = Color3.fromRGB(11, 6, 17),
    pumpkin = Color3.fromRGB(255, 132, 28),
    ember = Color3.fromRGB(255, 184, 72),
    witch = Color3.fromRGB(176, 98, 255),
    mist = Color3.fromRGB(196, 170, 255),
    fog = Color3.fromRGB(120, 78, 170),
    moon = Color3.fromRGB(255, 238, 196),
    gold = Color3.fromRGB(255, 202, 58),
    ink = Color3.fromRGB(23, 14, 32),
    edge = Color3.fromRGB(86, 60, 110),
    track = Color3.fromRGB(40, 28, 52),
    white = Color3.new(1, 1, 1),
    soft = Color3.fromRGB(222, 214, 236),
    bad = Color3.fromRGB(255, 96, 96),
    titleStroke = Color3.fromRGB(40, 8, 30)
};
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.Creepster);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);

local function rarityColor(p6) -- Line: 94
    if p6 <= 100 then
        return Color3.fromRGB(242, 191, 89);
    end;

    if p6 <= 500 then
        return Color3.fromRGB(183, 123, 244);
    end;

    if p6 <= 2000 then
        return Color3.fromRGB(92, 173, 238);
    end;

    if p6 <= 3000 then
        return Color3.fromRGB(104, 211, 122);
    end;

    return Color3.fromRGB(214, 220, 226);
end;

local u7 = {
    pumpkin = { Color3.fromRGB(255, 176, 70), Color3.fromRGB(226, 92, 8), Color3.fromRGB(255, 150, 50) },
    witch = { Color3.fromRGB(199, 140, 255), Color3.fromRGB(122, 52, 200), Color3.fromRGB(176, 98, 255) },
    gold = { Color3.fromRGB(255, 225, 120), Color3.fromRGB(230, 161, 0), Color3.fromRGB(255, 202, 58) },
    grey = { Color3.fromRGB(110, 100, 120), Color3.fromRGB(70, 62, 80), Color3.fromRGB(110, 100, 120) },
    close = { Color3.fromRGB(158, 158, 158), Color3.fromRGB(120, 120, 124), Color3.fromRGB(189, 189, 189) },
    dark = { u5.ink, u5.ink, u5.edge }
};
local u8 = {
    NotEnough = "You don\'t have enough coins for that.",
    Maxed = "The bowl is MAXED. This hunt\'s pumpkins are as lucky as they get!",
    Running = "A Pumpkin Hunt is on. The bowl opens again after it.",
    Summon = "The bowl is closed while the Fallen King rises. It opens again once his fight starts.",
    Cooldown = "The bowl is on cooldown. Come back when the timer runs out.",
    Sealed = "This server is closing, so the bowl is sealed.",
    TooFar = "Head back to the lobby to sacrifice.",
    InMatch = "Sacrifice in the lobby.",
    Loading = "Your coins are still loading.",
    Failed = "That didn\'t save, and no coins were used. Try again.",
    Unavailable = PumpkinHuntConfig.Unavailable
};

local function make(p9, p10, p11, p12) -- Line: 129
    local Instance_new_ret = Instance.new(p9);
    Instance_new_ret.Name = p11;

    for i, v in p12 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p10;

    return Instance_new_ret;
end;

local function corner(p13, p14) -- Line: 138
    local v15 = {
        CornerRadius = UDim.new(p14, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v15 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = p13;
end;

local function rings(p16, p17, p18, p19) -- Line: 142
    local v20 = {
        ZIndex = 1,
        Color = Color3.new(0, 0, 0),
        Thickness = p18,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Outline";

    for i, v in v20 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p16;
    local v21 = {
        ZIndex = 2,
        Color = p17,
        Thickness = p19,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "Ring";

    for i, v in v21 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = p16;

    return UIStroke2;
end;

local function label(p22, p23, p24, p25, p26, p27) -- Line: 158
    -- upvalues: Font_new_ret (copy), u5 (copy)
    local v28 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        FontFace = p27 or Font_new_ret,
        Text = p24,
        TextColor3 = u5.white
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p23;

    for i, v in v28 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p22;

    for i, v in p25 or {} do
        TextLabel[i] = v;
    end;

    local v29 = {
        Color = Color3.new(0, 0, 0),
        Thickness = p26 or 0.1,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v29 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function deco(p30, p31, p32, p33) -- Line: 179
    p33.BorderSizePixel = 0;
    p33.Active = false;
    p33.Interactable = false;

    if p30 ~= "Frame" then
        p33.BackgroundTransparency = 1;
    end;

    local Instance_new_ret = Instance.new(p30);
    Instance_new_ret.Name = p32;

    for i, v in p33 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p31;

    return Instance_new_ret;
end;

local function picture(p34, p35, p36, p37) -- Line: 188
    -- upvalues: u4 (copy)
    p37.Image = u4[p36] or p36;
    p37.ScaleType = p37.ScaleType or Enum.ScaleType.Fit;
    p37.AnchorPoint = p37.AnchorPoint or Vector2.new(0.5, 0.5);
    p37.BorderSizePixel = 0;
    p37.Active = false;
    p37.Interactable = false;
    p37.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = p35;

    for i, v in p37 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p34;

    return ImageLabel;
end;

local function setLook(p38, p39) -- Line: 196
    -- upvalues: u7 (copy), u5 (copy)
    local v40 = u7[p39] or u7.grey;
    p38:FindFirstChild("UIGradient").Color = ColorSequence.new(v40[1], v40[2]);
    p38:FindFirstChild("Ring").Color = v40[3];
    local Texture = p38:FindFirstChild("Texture");
    local v41;

    if p39 == "grey" or p39 == "dark" then
        v41 = false;
    else
        v41 = p39 ~= "close";
    end;

    Texture.Visible = v41;
    local TextLabel = p38:FindFirstChild("TextLabel");
    local v42;

    if p39 == "grey" then
        v42 = Color3.fromRGB(190, 182, 200);
    else
        v42 = u5.white;
    end;

    TextLabel.TextColor3 = v42;
    p38:SetAttribute("Look", p39);
end;

local function button(p43, p44, p45, p46, p47) -- Line: 204
    -- upvalues: u5 (copy), rings (copy), label (copy), setLook (copy)
    local v48 = {
        AutoButtonColor = true,
        BorderSizePixel = 0,
        BackgroundColor3 = u5.white
    };
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = p44;

    for i, v in v48 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = p43;

    for i, v in p47 do
        ImageButton[i] = v;
    end;

    local v49 = {
        CornerRadius = UDim.new(0.22, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v49 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = ImageButton;
    rings(ImageButton, u5.edge, 0.05, 0.033);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in {
        Rotation = 90
    } or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = ImageButton;
    local v50 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.93)
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Texture";

    for i, v in v50 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = ImageButton;
    local v51 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v51 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = CanvasGroup;
    local v52 = {
        Rotation = 45,
        BackgroundTransparency = 1,
        Image = "rbxassetid://140022482252277",
        ImageTransparency = 0.82,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.87, 8),
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromScale(0.35, 0.35)
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "ImageLabel";

    for i, v in v52 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = CanvasGroup;
    local v53 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0) })
    };
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "UIGradient";

    for i, v in v53 or {} do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = ImageLabel;
    label(ImageButton, "TextLabel", p45, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.86, 0.52),
        ZIndex = ImageButton.ZIndex + 1
    }, 0.1);
    setLook(ImageButton, p46);

    return ImageButton;
end;

local function setEnabled(p54, p55, p56) -- Line: 251
    -- upvalues: setLook (copy)
    p54.Interactable = p55;
    p54.AutoButtonColor = p55;
    setLook(p54, not p55 and "grey" or p56);
end;

local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(1, 1, 0.35));

local function knifeIcon(p57, p58) -- Line: 259
    -- upvalues: SkinCatalog (copy), Weapons (copy), KnifeIconCopy (copy), CFrame_lookAt_ret (copy)
    local v59 = SkinCatalog.get(p58);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        if v59 then
            v59 = Models:FindFirstChild(v59.Model);
        end;
    else
        v59 = Models;
    end;

    if v59 then
        v59 = v59:FindFirstChild("Blade") or v59:FindFirstChildWhichIsA("BasePart", true);
    end;

    local v60 = {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -0.8, -1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(200, 200, 210),
        LightColor = Color3.fromRGB(255, 250, 235),
        ZIndex = p57.ZIndex + 1
    };
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "Knife";

    for i, v in v60 or {} do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = p57;

    if not v59 then
        return ViewportFrame;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "World";

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = ViewportFrame;
    local v61, _, v62, v63 = KnifeIconCopy.new(v59);
    v61.Parent = WorldModel;
    local Size = v61.Size;
    local v64;

    if Size.Z >= Size.X and Size.Z >= Size.Y then
        v64 = CFrame_lookAt_ret;
    elseif Size.X >= Size.Y then
        v64 = CFrame_lookAt_ret * CFrame.Angles(0, 1.5707963267948966, 0);
    else
        v64 = CFrame_lookAt_ret * CFrame.Angles(-1.5707963267948966, 0, 0);
    end;

    v61.CFrame = CFrame.new(-v64:VectorToWorldSpace(v63)) * v64;
    local math_max_ret = math.max(v62.X, v62.Y, v62.Z);
    local Camera = Instance.new("Camera");
    Camera.Name = "Camera";

    for i, v in {
        FieldOfView = 35
    } or {} do
        Camera[i] = v;
    end;

    Camera.Parent = ViewportFrame;
    Camera.CFrame = CFrame.lookAt(Vector3.new(0, 0, math_max_ret * 1.3), Vector3.new(0, 0, 0));
    ViewportFrame.CurrentCamera = Camera;

    return ViewportFrame;
end;

local function spinToken(p65) -- Line: 293
    local Frame = Instance.new("Frame");
    Frame.Name = "Spin";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(0.95, 0.95);
    Frame.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame.ZIndex = p65.ZIndex + 1;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 225, 120), Color3.fromRGB(230, 161, 0));
    UIGradient.Rotation = 90;
    UIGradient.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.new(1, 1, 1);
    UIStroke.Thickness = 0.08;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel.Size = UDim2.fromScale(0.8, 0.45);
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
    TextLabel.Text = "SPIN";
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.ZIndex = Frame.ZIndex + 1;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Thickness = 0.12;
    UIStroke2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke2.Parent = TextLabel;
    TextLabel.Parent = Frame;
    Frame.Parent = p65;

    return Frame;
end;

local function lerp(p66, p67, p68) -- Line: 333
    return p66:Lerp(p67, (math.clamp(p68, 0, 1)));
end;

local function play(p69) -- Line: 336
    -- upvalues: PumpkinHuntConfig (copy), SoundService (copy)
    local v70 = PumpkinHuntConfig.Sounds[p69];

    if not v70 then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = v70[1];
    Sound.Volume = v70[2] or 0.5;
    Sound.Parent = SoundService;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 346
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    task.delay(6, function() -- Line: 349
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

local function clock(p71) -- Line: 355
    local math_floor_ret = math.floor(p71);
    local math_max_ret = math.max(0, math_floor_ret);

    return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
end;

function u3.new(p72) -- Line: 363
    -- upvalues: u3 (copy), u5 (copy), u4 (copy), label (copy), PumpkinHuntConfig (copy), Font_fromEnum_ret (copy), u1 (copy), rings (copy), button (copy), knifeIcon (copy), spinToken (copy), SkinCatalog (copy)
    local v73;

    if p72 == nil then
        v73 = false;
    else
        v73 = p72.altar == true;
    end;

    local u74 = setmetatable({
        chip = 1,
        coins = nil,
        localPending = 0,
        lastClick = 0,
        altar = v73,
        cards = {},
        rows = {},
        embers = {},
        bats = {}
    }, u3);
    local v75 = {
        BackgroundTransparency = 1,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "PumpkinSacrifice";

    for i, v in v75 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = nil;
    Frame:SetAttribute("SelfManagedText", true);
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "FixedAspectRatio";

    for i, v in {
        AspectRatio = 2.115
    } or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Pop";

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    u74.pop = UIScale;
    u74.frame = Frame;
    Frame.Destroying:Connect(function() -- Line: 391
        -- upvalues: u74 (copy)
        u74.frame = nil;
        u74:closed();
    end);

    if not v73 then
        local v76 = {
            BackgroundTransparency = 0.04,
            ZIndex = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(3, 3),
            BackgroundColor3 = Color3.fromRGB(15, 8, 24),
            BorderSizePixel = 0,
            Active = false,
            Interactable = false
        };
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Dim";

        for i, v in v76 or {} do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;
        local v77 = {
            BackgroundTransparency = 1,
            ZIndex = 1,
            Size = UDim2.fromScale(1, 1),
            BorderSizePixel = 0,
            Active = false,
            Interactable = false
        };
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "HalloweenNight";

        for i, v in v77 or {} do
            Frame3[i] = v;
        end;

        Frame3.Parent = Frame;
        local v78 = {
            ImageTransparency = 0.75,
            ZIndex = 1,
            Position = UDim2.fromScale(0.665, 0.085),
            Size = UDim2.fromScale(0.11, 0.233),
            ImageColor3 = u5.moon,
            Image = u4.Glow or "Glow"
        };
        v78.ScaleType = v78.ScaleType or Enum.ScaleType.Fit;
        v78.AnchorPoint = v78.AnchorPoint or Vector2.new(0.5, 0.5);
        v78.BorderSizePixel = 0;
        v78.Active = false;
        v78.Interactable = false;
        v78.BackgroundTransparency = 1;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "MoonGlow";

        for i, v in v78 or {} do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = Frame3;
        local v79 = {
            ImageTransparency = 0.3,
            ZIndex = 1,
            Position = UDim2.fromScale(0.665, 0.085),
            Size = UDim2.fromScale(0.05, 0.106),
            ImageColor3 = u5.moon,
            Image = u4.Moon or "Moon"
        };
        v79.ScaleType = v79.ScaleType or Enum.ScaleType.Fit;
        v79.AnchorPoint = v79.AnchorPoint or Vector2.new(0.5, 0.5);
        v79.BorderSizePixel = 0;
        v79.Active = false;
        v79.Interactable = false;
        v79.BackgroundTransparency = 1;
        local ImageLabel2 = Instance.new("ImageLabel");
        ImageLabel2.Name = "Moon";

        for i, v in v79 or {} do
            ImageLabel2[i] = v;
        end;

        ImageLabel2.Parent = Frame3;
        local v80 = {
            ZIndex = 1,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0.62),
            Size = UDim2.fromScale(3, 1),
            BackgroundColor3 = u5.fog,
            BorderSizePixel = 0,
            Active = false,
            Interactable = false
        };
        local Frame4 = Instance.new("Frame");
        Frame4.Name = "Fog";

        for i, v in v80 or {} do
            Frame4[i] = v;
        end;

        Frame4.Parent = Frame3;
        local v81 = {
            Rotation = 90,
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.35, 0.82), NumberSequenceKeypoint.new(1, 0.72) })
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "UIGradient";

        for i, v in v81 or {} do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = Frame4;

        for i, v in { { 0.33, 0.16, 0.026, 1.6, 0 }, { 0.62, 0.28, 0.022, 2.1, 1.7 }, { 0.76, 0.09, 0.024, 1.8, 3.1 } } do
            local v82 = {
                ImageTransparency = 0.2,
                ZIndex = 1,
                Position = UDim2.fromScale(v[1], v[2]),
                Size = UDim2.fromScale(v[3], v[3] * 2.1),
                Image = u4.Bat or "Bat"
            };
            v82.ScaleType = v82.ScaleType or Enum.ScaleType.Fit;
            v82.AnchorPoint = v82.AnchorPoint or Vector2.new(0.5, 0.5);
            v82.BorderSizePixel = 0;
            v82.Active = false;
            v82.Interactable = false;
            v82.BackgroundTransparency = 1;
            local ImageLabel3 = Instance.new("ImageLabel");
            ImageLabel3.Name = "Bat" .. i;
            local v83 = v;

            for i2, v2 in v82 or {} do
                ImageLabel3[i2] = v2;
            end;

            ImageLabel3.Parent = Frame3;
            table.insert(u74.bats, {
                tall = 2.1,
                image = ImageLabel3,
                x = v83[1],
                y = v83[2],
                size = v83[3],
                speed = v83[4],
                phase = v83[5]
            });
        end;

        for i = 1, 14 do
            local v84 = {
                ZIndex = 1,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.fromScale(0.0035, 0.0074)
            };
            local v85;

            if i % 3 == 0 then
                v85 = u5.witch;
            else
                v85 = u5.ember;
            end;

            v84.BackgroundColor3 = v85;
            v84.BorderSizePixel = 0;
            v84.Active = false;
            v84.Interactable = false;
            local Frame5 = Instance.new("Frame");
            Frame5.Name = "Ember" .. i;
            local v86 = i;

            for i2, v in v84 or {} do
                Frame5[i2] = v;
            end;

            Frame5.Parent = Frame3;
            local v87 = {
                CornerRadius = UDim.new(1, 0)
            };
            local UICorner = Instance.new("UICorner");
            UICorner.Name = "UICorner";

            for i2, v in v87 or {} do
                UICorner[i2] = v;
            end;

            UICorner.Parent = Frame5;
            table.insert(u74.embers, {
                frame = Frame5,
                x = v86 * 0.137 % 1 * 0.4 + 0.3,
                speed = v86 % 4 * 0.02 + 0.05,
                phase = v86 * 0.61
            });
        end;
    end;

    label(Frame, "Title", string.upper(PumpkinHuntConfig.EventName), {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.06),
        Size = UDim2.fromScale(0.4, 0.1),
        TextColor3 = u5.pumpkin
    }, 0.06, Font_fromEnum_ret).UIStroke.Color = u5.titleStroke;
    u74.timer = label(Frame, "Timer", "", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.118),
        Size = UDim2.fromScale(0.4, 0.042),
        TextColor3 = u5.ember
    }, 0.1);
    u74.info = label(Frame, "Info", u1, {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.17),
        Size = UDim2.fromScale(0.36, 0.056),
        TextColor3 = Color3.fromRGB(226, 214, 255)
    }, 0.12);
    local v88 = {
        BackgroundTransparency = 1,
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.435),
        Size = UDim2.fromScale(0.3, 0.5)
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Pumpkin";

    for i, v in v88 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint2.Name = "Square";

    for i, v in {
        AspectRatio = 1
    } or {} do
        UIAspectRatioConstraint2[i] = v;
    end;

    UIAspectRatioConstraint2.Parent = Frame2;
    u74.stage = Frame2;
    Frame2.Visible = not v73;
    local v89 = {
        ImageTransparency = 0.9,
        ZIndex = 3,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.7, 1.7),
        ImageColor3 = u5.pumpkin,
        Image = u4.Glow or "Glow"
    };
    v89.ScaleType = v89.ScaleType or Enum.ScaleType.Fit;
    v89.AnchorPoint = v89.AnchorPoint or Vector2.new(0.5, 0.5);
    v89.BorderSizePixel = 0;
    v89.Active = false;
    v89.Interactable = false;
    v89.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Halo";

    for i, v in v89 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame2;
    u74.halo = ImageLabel;
    local v90 = {
        ImageTransparency = 1,
        ZIndex = 4,
        Position = UDim2.fromScale(0.5, 0.52),
        Size = UDim2.fromScale(1.05, 1.05),
        ImageColor3 = u5.ember,
        Image = u4.GlowGold or "GlowGold"
    };
    v90.ScaleType = v90.ScaleType or Enum.ScaleType.Fit;
    v90.AnchorPoint = v90.AnchorPoint or Vector2.new(0.5, 0.5);
    v90.BorderSizePixel = 0;
    v90.Active = false;
    v90.Interactable = false;
    v90.BackgroundTransparency = 1;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "EyeGlow";

    for i, v in v90 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame2;
    u74.eyes = ImageLabel2;
    local v91 = {
        ZIndex = 5,
        Position = UDim2.fromScale(0.5, 0.52),
        Size = UDim2.fromScale(1, 1),
        Image = u4.Pumpkin or "Pumpkin"
    };
    v91.ScaleType = v91.ScaleType or Enum.ScaleType.Fit;
    v91.AnchorPoint = v91.AnchorPoint or Vector2.new(0.5, 0.5);
    v91.BorderSizePixel = 0;
    v91.Active = false;
    v91.Interactable = false;
    v91.BackgroundTransparency = 1;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.Name = "Pumpkin";

    for i, v in v91 or {} do
        ImageLabel3[i] = v;
    end;

    ImageLabel3.Parent = Frame2;
    u74.pumpkin = ImageLabel3;
    local pumpkin = u74.pumpkin;
    local UIScale2 = Instance.new("UIScale");
    UIScale2.Name = "Pop";

    for i, v in {} do
        UIScale2[i] = v;
    end;

    UIScale2.Parent = pumpkin;
    u74.pumpkinPop = UIScale2;
    u74.chanceTitle = label(Frame, "ChanceTitle", "KNIFE CHANCE", {
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.688),
        Size = UDim2.fromScale(0.3, 0.034),
        TextColor3 = u5.mist
    }, 0.1);
    u74.chanceText = label(Frame, "Chance", "", {
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.745),
        Size = UDim2.fromScale(0.34, 0.07),
        TextColor3 = u5.pumpkin
    }, 0.08);
    local chanceTitle = u74.chanceTitle;
    local UIScale3 = Instance.new("UIScale");
    UIScale3.Name = "Pop";
    local v92 = {};

    for i, v in {} do
        UIScale3[i] = v;
    end;

    UIScale3.Parent = chanceTitle;
    local chanceText = u74.chanceText;
    local UIScale4 = Instance.new("UIScale");
    UIScale4.Name = "Pop";

    for i, v in {} do
        UIScale4[i] = v;
    end;

    UIScale4.Parent = chanceText;
    v92[1], v92[2] = UIScale3, UIScale4;
    u74.chancePops = v92;
    local v93 = {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.808),
        Size = UDim2.fromScale(0.36, 0.046),
        BackgroundColor3 = u5.track
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Bar";

    for i, v in v93 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local v94 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v94 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame3;
    rings(Frame3, u5.edge, 0.06, 0.04);
    local v95 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 3,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Clip";

    for i, v in v95 or {} do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    local v96 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v96 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame4;
    local v97 = {
        BorderSizePixel = 0,
        ZIndex = 4,
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = u5.white
    };
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "Fill";

    for i, v in v97 or {} do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame4;
    u74.fill = Frame5;
    local fill = u74.fill;
    local v98 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner3 = Instance.new("UICorner");
    UICorner3.Name = "UICorner";

    for i, v in v98 or {} do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = fill;
    local fill2 = u74.fill;
    local v99 = {
        Color = ColorSequence.new(u5.witch, u5.pumpkin)
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v99 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = fill2;
    u74.fillGradient = UIGradient;
    local v100 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = u5.white
    };
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "Flash";

    for i, v in v100 or {} do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame4;
    u74.flash = Frame6;
    u74.barText = label(Frame3, "Text", "", {
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.94, 0.68)
    }, 0.16);
    u74.stageText = label(Frame, "Stage", "", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.853),
        Size = UDim2.fromScale(0.3, 0.03),
        TextColor3 = u5.ember
    }, 0.1);
    u74.cta = button(Frame, "Sacrifice", "SACRIFICE", "pumpkin", {
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.945),
        Size = UDim2.fromScale(0.182, 0.086)
    });
    local cta = u74.cta;
    local UIScale5 = Instance.new("UIScale");
    UIScale5.Name = "Pop";

    for i, v in {} do
        UIScale5[i] = v;
    end;

    UIScale5.Parent = cta;
    u74.ctaPop = UIScale5;
    u74.closeButton = button(Frame, "CloseButton", "Close", "close", {
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.654, 0.945),
        Size = UDim2.fromScale(0.09, 0.061)
    });
    u74.status = label(Frame, "Status", "", {
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.885),
        Size = UDim2.fromScale(0.4, 0.028),
        TextColor3 = u5.bad
    }, 0.1);
    label(Frame, "AmountTitle", "SACRIFICE", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.822, 0.27),
        Size = UDim2.fromScale(0.17, 0.04),
        TextColor3 = u5.gold
    }, 0.1);
    u74.chips = {};

    for i, v in PumpkinHuntConfig.Pot.Amounts do
        local v101 = button(Frame, "Amount" .. i, PumpkinHuntConfig.short(v) .. " COINS", "dark", {
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.822, 0.33 + (i - 1) * 0.095),
            Size = UDim2.fromScale(0.17, 0.075)
        });
        v101.Activated:Connect(function() -- Line: 603
            -- upvalues: u74 (copy), i (copy)
            u74.chip = i;
            u74:refresh();
        end);
        u74.chips[i] = v101;
    end;

    local v102 = {
        BackgroundTransparency = 1,
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.822, #PumpkinHuntConfig.Pot.Amounts * 0.095 + 0.33),
        Size = UDim2.fromScale(0.15, 0.05)
    };
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "Coins";

    for i, v in v102 or {} do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame;
    local v103 = {
        ZIndex = 4,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(0.25, 1),
        Image = u4.Coin or "Coin"
    };
    v103.ScaleType = v103.ScaleType or Enum.ScaleType.Fit;
    v103.AnchorPoint = v103.AnchorPoint or Vector2.new(0.5, 0.5);
    v103.BorderSizePixel = 0;
    v103.Active = false;
    v103.Interactable = false;
    v103.BackgroundTransparency = 1;
    local ImageLabel4 = Instance.new("ImageLabel");
    ImageLabel4.Name = "Coin";

    for i, v in v103 or {} do
        ImageLabel4[i] = v;
    end;

    ImageLabel4.Parent = Frame7;
    local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint3.Name = "Square";

    for i, v in {
        AspectRatio = 1
    } or {} do
        UIAspectRatioConstraint3[i] = v;
    end;

    UIAspectRatioConstraint3.Parent = ImageLabel4;
    u74.coinText = label(Frame7, "Amount", "", {
        ZIndex = 4,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.27, 0.5),
        Size = UDim2.fromScale(0.73, 0.75),
        TextColor3 = u5.gold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, 0.1);
    local v104 = {
        BorderSizePixel = 0,
        AutoButtonColor = true,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.234, 0.062),
        Size = UDim2.fromScale(0.038, 0.08),
        BackgroundColor3 = u5.white
    };
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = "OddsButton";

    for i, v in v104 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = Frame;
    local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint4.Name = "Square";

    for i, v in {
        AspectRatio = 1
    } or {} do
        UIAspectRatioConstraint4[i] = v;
    end;

    UIAspectRatioConstraint4.Parent = ImageButton;
    local v105 = {
        CornerRadius = UDim.new(0.25, 0)
    };
    local UICorner4 = Instance.new("UICorner");
    UICorner4.Name = "UICorner";

    for i, v in v105 or {} do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = ImageButton;
    rings(ImageButton, u5.witch, 0.068, 0.045);
    local v106 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3.fromRGB(199, 140, 255), Color3.fromRGB(122, 52, 200))
    };
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "UIGradient";

    for i, v in v106 or {} do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = ImageButton;
    label(ImageButton, "Mark", "?", {
        ZIndex = 7,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.7, 0.7)
    }, 0.09);
    label(ImageButton, "Caption", "Odds", {
        ZIndex = 7,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 1.12),
        Size = UDim2.fromScale(1.6, 0.45)
    }, 0.1);
    u74.oddsButton = ImageButton;
    local v107 = {
        BackgroundTransparency = 0.1,
        Visible = false,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.175, 0.47),
        Size = UDim2.fromScale(0.21, 0.56),
        BackgroundColor3 = u5.ink
    };
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "Odds";

    for i, v in v107 or {} do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame;
    local v108 = {
        CornerRadius = UDim.new(0.05, 0)
    };
    local UICorner5 = Instance.new("UICorner");
    UICorner5.Name = "UICorner";

    for i, v in v108 or {} do
        UICorner5[i] = v;
    end;

    UICorner5.Parent = Frame8;
    rings(Frame8, u5.edge, 0.008, 0.005);
    u74.odds = Frame8;
    label(Frame8, "Heading", "IN EVERY PUMPKIN FROM THIS HUNT", {
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.025),
        Size = UDim2.fromScale(0.9, 0.06),
        TextColor3 = u5.gold
    }, 0.1);
    local v109 = {
        BackgroundTransparency = 1,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.11),
        Size = UDim2.fromScale(0.92, 0.86)
    };
    local Frame9 = Instance.new("Frame");
    Frame9.Name = "List";

    for i, v in v109 or {} do
        Frame9[i] = v;
    end;

    Frame9.Parent = Frame8;
    local v110 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0.012, 0)
    };
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "UIListLayout";

    for i, v in v110 or {} do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame9;
    local v111 = PumpkinHuntConfig.ranked(PumpkinHuntConfig.slots(PumpkinHuntConfig.KnifeChanceMin));
    local v112 = 1 / #v111 - 0.013;

    for i, v in v111 do
        local v113 = v.kind == "Knife";
        local v114 = "Row_" .. v.id;
        local v115 = {
            ZIndex = 6,
            Size = UDim2.fromScale(1, v112)
        };
        local v116;

        if v113 then
            v116 = u5.night;
        else
            v116 = Color3.new(0, 0, 0);
        end;

        v115.BackgroundColor3 = v116;
        v115.BackgroundTransparency = v113 and 0.05 or 0.55;
        v115.LayoutOrder = i;
        local Frame10 = Instance.new("Frame");
        Frame10.Name = v114;
        local v117 = v;

        for i2, v2 in v115 or {} do
            Frame10[i2] = v2;
        end;

        Frame10.Parent = Frame9;
        local v118 = {
            CornerRadius = UDim.new(0.25, 0)
        };
        local UICorner6 = Instance.new("UICorner");
        UICorner6.Name = "UICorner";

        for i2, v2 in v118 or {} do
            UICorner6[i2] = v2;
        end;

        UICorner6.Parent = Frame10;
        local v119;

        if v113 then
            v119 = u5.pumpkin;
        else
            v119 = u5.edge;
        end;

        local v120 = rings(Frame10, v119, 0.04, 0.025);
        local v121 = {
            BackgroundTransparency = 1,
            ZIndex = 7,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0.02, 0.5),
            Size = UDim2.fromScale(0.16, 0.85)
        };
        local Frame11 = Instance.new("Frame");
        Frame11.Name = "Icon";

        for i2, v2 in v121 or {} do
            Frame11[i2] = v2;
        end;

        Frame11.Parent = Frame10;
        local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint5.Name = "Square";

        for i2, v2 in {
            AspectRatio = 1
        } or {} do
            UIAspectRatioConstraint5[i2] = v2;
        end;

        UIAspectRatioConstraint5.Parent = Frame11;

        if v113 then
            knifeIcon(Frame11, PumpkinHuntConfig.Knife);
        elseif v117.kind == "Spins" then
            spinToken(Frame11);
        else
            local v122 = (v117.kind == "Gems" or v117.kind == "GemBoostMinutes") and "rbxassetid://137046122108742" or (v117.kind == "CandyCorn" and "rbxassetid://119759573303359" or (v117.kind == "GhostKeys" and "rbxassetid://99826093535691" or "rbxassetid://78008558948307"));
            local v123 = {
                ZIndex = 7,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(1, 1),
                Image = u4[v122] or v122
            };
            v123.ScaleType = v123.ScaleType or Enum.ScaleType.Fit;
            v123.AnchorPoint = v123.AnchorPoint or Vector2.new(0.5, 0.5);
            v123.BorderSizePixel = 0;
            v123.Active = false;
            v123.Interactable = false;
            v123.BackgroundTransparency = 1;
            local ImageLabel5 = Instance.new("ImageLabel");
            ImageLabel5.Name = "Image";

            for i2, v2 in v123 or {} do
                ImageLabel5[i2] = v2;
            end;

            ImageLabel5.Parent = Frame11;

            if v117.kind == "CoinBoostMinutes" or v117.kind == "GemBoostMinutes" then
                label(Frame11, "Boost", "2x", {
                    ZIndex = 8,
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.fromScale(1.15, 1.05),
                    Size = UDim2.fromScale(0.7, 0.5),
                    TextColor3 = u5.gold
                }, 0.12);
            end;
        end;

        local v124;

        if v113 then
            v124 = SkinCatalog.get(PumpkinHuntConfig.Knife);
        else
            v124 = v113;
        end;

        local v125;

        if v113 then
            v125 = string.upper(v124 and v124.Name or PumpkinHuntConfig.Knife);
        else
            v125 = string.upper(v117.name);
        end;

        local v126 = {
            ZIndex = 7,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0.22, 0.5),
            Size = UDim2.fromScale(0.52, 0.5)
        };
        local v127;

        if v113 then
            v127 = u5.ember;
        else
            v127 = u5.white;
        end;

        v126.TextColor3 = v127;
        v126.TextXAlignment = Enum.TextXAlignment.Left;
        label(Frame10, "Name", v125, v126, 0.1);
        local v128 = label(Frame10, "Percent", "", {
            ZIndex = 7,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.fromScale(0.97, 0.5),
            Size = UDim2.fromScale(0.24, 0.5),
            TextXAlignment = Enum.TextXAlignment.Right
        }, 0.1);
        u74.rows[v117.id] = {
            id = v117.id,
            row = Frame10,
            ring = v120,
            percent = v128,
            knife = v113
        };
    end;

    ImageButton.Activated:Connect(function() -- Line: 747
        -- upvalues: Frame8 (copy)
        Frame8.Visible = not Frame8.Visible;
    end);
    local v129 = {
        BackgroundTransparency = 1,
        ZIndex = 10,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame10 = Instance.new("Frame");
    Frame10.Name = "Effects";

    for i, v in v129 or {} do
        Frame10[i] = v;
    end;

    Frame10.Parent = Frame;
    u74.fx = Frame10;

    if v73 then
        u74:altarLook();
    end;

    return u74;
end;

function u3.altarLook(p130) -- Line: 761
    -- upvalues: u5 (copy), SkinCatalog (copy), PumpkinHuntConfig (copy), label (copy), Font_fromEnum_ret (copy)
    local frame = p130.frame;
    local Color3_fromRGB_ret = Color3.fromRGB(255, 238, 102);

    local function restyle(p131, p132, p133) -- Line: 765
        if not p131 then
            return;
        end;

        for i, v in p132 do
            p131[i] = v;
        end;

        local UIStroke = p131:FindFirstChild("UIStroke");

        if p133 and UIStroke then
            UIStroke.Thickness = p133;
            UIStroke.Color = Color3.new(0, 0, 0);
        end;
    end;

    local Title = frame:FindFirstChild("Title");
    local v134 = {};

    if Title then
        for i, v in v134 do
            Title[i] = v;
        end;

        local UIStroke = Title:FindFirstChild("UIStroke");

        if UIStroke then
            UIStroke.Thickness = 0.08;
            UIStroke.Color = Color3.new(0, 0, 0);
        end;
    end;

    local Timer = frame:FindFirstChild("Timer");
    local v135 = {};

    if Timer then
        for i, v in v135 do
            Timer[i] = v;
        end;

        local UIStroke = Timer:FindFirstChild("UIStroke");

        if UIStroke then
            UIStroke.Thickness = 0.14;
            UIStroke.Color = Color3.new(0, 0, 0);
        end;
    end;

    local info = p130.info;
    local v136 = {
        TextColor3 = Color3.fromRGB(198, 140, 255),
        Position = UDim2.fromScale(0.5, 0.1693),
        Size = UDim2.fromScale(0.466, 0.0735)
    };

    if info then
        for i, v in v136 do
            info[i] = v;
        end;

        local UIStroke = info:FindFirstChild("UIStroke");

        if UIStroke then
            UIStroke.Thickness = 0.18;
            UIStroke.Color = Color3.new(0, 0, 0);
        end;
    end;

    local AmountTitle = frame:FindFirstChild("AmountTitle");
    local v137 = {
        Position = UDim2.fromScale(0.822, 0.232),
        Size = UDim2.fromScale(0.2, 0.066),
        TextColor3 = Color3_fromRGB_ret
    };

    if AmountTitle then
        for i, v in v137 do
            AmountTitle[i] = v;
        end;

        local UIStroke = AmountTitle:FindFirstChild("UIStroke");

        if UIStroke then
            UIStroke.Thickness = 0.14;
            UIStroke.Color = Color3.new(0, 0, 0);
        end;
    end;

    local Coins = frame:FindFirstChild("Coins");

    if Coins then
        Coins.Position = UDim2.fromScale(0.822, 0.748);
        Coins.Size = UDim2.fromScale(0.19, 0.078);
        local Coin = Coins:FindFirstChild("Coin");
        local Amount = Coins:FindFirstChild("Amount");
        local v138 = {
            TextColor3 = Color3_fromRGB_ret
        };

        if Amount then
            for i, v in v138 do
                Amount[i] = v;
            end;

            local UIStroke = Amount:FindFirstChild("UIStroke");

            if UIStroke then
                UIStroke.Thickness = 0.14;
                UIStroke.Color = Color3.new(0, 0, 0);
            end;
        end;

        local function centre() -- Line: 793
            -- upvalues: Coins (copy), Coin (copy), Amount (copy)
            local X = Coins.AbsoluteSize.X;

            if not (Coin and (Amount and X > 0)) then
                return;
            end;

            local X2 = Coin.AbsoluteSize.X;
            local v139 = X * 0.03;
            local math_min_ret = math.min(Amount.TextBounds.X, Amount.AbsoluteSize.X);
            local math_max_ret = math.max(0, (X - (X2 + v139 + math_min_ret)) / 2);
            Coin.Position = UDim2.new(0, math_max_ret, 0.5, 0);
            Amount.Position = UDim2.new(0, math_max_ret + X2 + v139, 0.5, 0);
        end;

        if Coin and Amount then
            Coins:GetPropertyChangedSignal("AbsoluteSize"):Connect(centre);
            Amount:GetPropertyChangedSignal("TextBounds"):Connect(centre);
            centre();
        end;
    end;

    local chanceTitle = p130.chanceTitle;
    local v140 = {
        Position = UDim2.fromScale(0.5, 0.708),
        Size = UDim2.fromScale(0.32, 0.044),
        TextColor3 = Color3_fromRGB_ret
    };

    if chanceTitle then
        for i, v in v140 do
            chanceTitle[i] = v;
        end;

        local UIStroke = chanceTitle:FindFirstChild("UIStroke");

        if UIStroke then
            UIStroke.Thickness = 0.14;
            UIStroke.Color = Color3.new(0, 0, 0);
        end;
    end;

    local chanceText = p130.chanceText;
    local v141 = {
        Position = UDim2.fromScale(0.5, 0.766),
        Size = UDim2.fromScale(0.38, 0.076)
    };

    if chanceText then
        for i, v in v141 do
            chanceText[i] = v;
        end;

        local UIStroke = chanceText:FindFirstChild("UIStroke");

        if UIStroke then
            UIStroke.Thickness = 0.1;
            UIStroke.Color = Color3.new(0, 0, 0);
        end;
    end;

    local Bar = frame:FindFirstChild("Bar");

    if Bar then
        Bar.Position = UDim2.fromScale(0.5, 0.855);
        Bar.Size = UDim2.fromScale(0.42, 0.06);
        Bar.BackgroundColor3 = Color3.fromRGB(18, 10, 28);
        local Ring = Bar:FindFirstChild("Ring");

        if Ring then
            Ring.Color = u5.gold;
            Ring.Thickness = 0.07;
        end;

        local Outline = Bar:FindFirstChild("Outline");

        if Outline then
            Outline.Thickness = 0.12;
        end;

        local barText = p130.barText;
        local v142 = {};

        if barText then
            for i, v in v142 do
                barText[i] = v;
            end;

            local UIStroke = barText:FindFirstChild("UIStroke");

            if UIStroke then
                UIStroke.Thickness = 0.2;
                UIStroke.Color = Color3.new(0, 0, 0);
            end;
        end;
    end;

    p130.stageText.Visible = false;
    local status = p130.status;
    local v143 = {
        Position = UDim2.fromScale(0.5, 0.672)
    };

    if status then
        for i, v in v143 do
            status[i] = v;
        end;

        local UIStroke = status:FindFirstChild("UIStroke");

        if UIStroke then
            UIStroke.Thickness = 0.14;
            UIStroke.Color = Color3.new(0, 0, 0);
        end;
    end;

    p130.cta.Position = UDim2.fromScale(0.5, 0.96);
    p130.closeButton.Position = UDim2.fromScale(0.654, 0.96);

    if p130.oddsButton then
        p130.oddsButton.Position = UDim2.fromScale(0.178, 0.062);
    end;

    local v144 = SkinCatalog.get(PumpkinHuntConfig.Knife);
    p130.showcaseTitle = label(frame, "BestPrize", "BEST PRIZE", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.178, 0.232),
        Size = UDim2.fromScale(0.2, 0.058),
        TextColor3 = Color3_fromRGB_ret
    }, 0.14);
    p130.showcaseName = label(frame, "BestPrizeName", string.upper(v144 and v144.Name or PumpkinHuntConfig.Knife), {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.178, 0.725),
        Size = UDim2.fromScale(0.22, 0.072),
        TextColor3 = Color3.fromRGB(242, 191, 89)
    }, 0.1, Font_fromEnum_ret);
    p130.showcaseInfo = label(frame, "BestPrizeOdds", "", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.178, 0.776),
        Size = UDim2.fromScale(0.22, 0.036),
        TextColor3 = Color3.fromRGB(198, 140, 255)
    }, 0.16);
    p130.showcaseHint = label(frame, "BestPrizeHint", "DRAG TO SPIN", {
        TextTransparency = 0.15,
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.178, 0.812),
        Size = UDim2.fromScale(0.13, 0.026),
        TextColor3 = u5.white
    }, 0.18);
end;

function u3.attr(p145, p146) -- Line: 878
    local v147 = p145.remote and p145.remote:GetAttribute(p146);

    return v147;
end;

function u3.available(p148) -- Line: 881
    local v149;

    if p148.remote == nil then
        v149 = false;
    else
        v149 = p148:attr("Live") == true;
    end;

    return v149;
end;

function u3.snapshot(p150) -- Line: 886
    -- upvalues: PumpkinHuntConfig (copy), ChickenOrHero (copy)
    local v151 = PumpkinHuntConfig.whole(p150:attr("Goal")) and p150:attr("Goal") or PumpkinHuntConfig.Pot.Goal;
    local v152 = PumpkinHuntConfig.whole(p150:attr("Max")) and p150:attr("Max") or PumpkinHuntConfig.Pot.Max;
    local v153 = PumpkinHuntConfig.whole(p150:attr("Pot")) and (p150:attr("Pot") or 0) or 0;
    local v154 = p150:attr("Chance");
    local v155 = {
        goal = v151,
        max = v152,
        pot = v153
    };

    if not PumpkinHuntConfig.whole(v154) then
        v154 = nil;
    end;

    v155.chance = v154;
    v155.phase = p150:attr("Phase") or "Filling";
    v155.sealed = p150:attr("Sealed") == true;
    local v156 = ChickenOrHero:FindFirstChild("Game") and ChickenOrHero.Game:FindFirstChild("FallenKingEvent");
    local v157;

    if v156 == nil then
        v157 = false;
    else
        v157 = v156:GetAttribute("SummonComing") == true;
    end;

    v155.king = v157;
    v155.cooldownEndsAt = p150:attr("CooldownEndsAt") or 0;

    return v155;
end;

function u3.refresh(p158) -- Line: 907
    -- upvalues: PumpkinHuntConfig (copy), rarityColor (copy), u5 (copy), result (copy), u2 (copy), u1 (copy), TweenService (copy), lerp (copy), setLook (copy)
    if not (p158.frame and p158.frame.Parent) then
        return;
    end;

    local v159 = p158:snapshot();
    local v160 = PumpkinHuntConfig.Pot.Amounts[p158.chip];

    if p158.optimistic and (v159.pot >= p158.optimistic or v159.pot < (p158.serverPot or 0)) then
        p158.optimistic = nil;
    end;

    p158.serverPot = v159.pot;

    if p158.spendable and (p158.coins and p158.coins <= p158.spendable) then
        p158.spendable = nil;
    end;

    local max = v159.max;
    local math_max_ret = math.max(v159.pot, p158.optimistic or 0);
    local math_min_ret = math.min(max, math_max_ret);
    local math_max_ret2 = math.max(0, v159.max - math_min_ret);
    local v161;

    if p158.coins then
        v161 = math.min(p158.coins, p158.spendable or (1 / 0));
    else
        v161 = nil;
    end;

    local v162 = v159.pot >= v159.max;
    local v163;

    if v159.goal <= math_min_ret then
        v163 = PumpkinHuntConfig.chance(math_min_ret) or v159.chance;
    else
        v163 = nil;
    end;

    local v164 = v163 or PumpkinHuntConfig.KnifeChanceMin;
    local v165 = PumpkinHuntConfig.slots(v164);
    local v166 = PumpkinHuntConfig.percents(v165);
    local v167 = PumpkinHuntConfig.tier(v164);

    for i, v in v165 do
        local v168 = p158.rows[v.id];

        if v168 then
            local percent = v168.percent;
            local v169;

            if v168.knife then
                v169 = PumpkinHuntConfig.chanceText(v166[i]);
            else
                v169 = PumpkinHuntConfig.percentText(v166[i]);
            end;

            percent.Text = v169;
            local percent2 = v168.percent;
            local v170;

            if v168.knife then
                v170 = v167.Color;
            else
                v170 = rarityColor(v166[i]);
            end;

            percent2.TextColor3 = v170;

            if v168.knife then
                v168.ring.Color = v167.Color;
            end;
        end;
    end;

    local v171 = not v163 and 0 or (v163 - PumpkinHuntConfig.KnifeChanceMin) / math.max(1, PumpkinHuntConfig.KnifeChanceMax - PumpkinHuntConfig.KnifeChanceMin);
    local v172 = v163 and 1 or math_min_ret / math.max(1, v159.goal);
    local v173;

    if v163 then
        v173 = 0.35 + 0.65 * v171;
    else
        v173 = v172 * 0.25;
    end;

    p158.glow = v173;
    local v174;

    if v163 then
        v174 = v167.Color;
    else
        v174 = u5.witch;
    end;

    p158.glowColor = v174;
    p158.halo.ImageColor3 = p158.glowColor;
    p158.eyes.ImageColor3 = u5.ember:Lerp(u5.gold, (math.clamp(v171, 0, 1)));

    if v163 then
        p158.chanceTitle.Text = string.upper(v167.Name) .. " · KNIFE CHANCE";
        p158.chanceText.Text = PumpkinHuntConfig.chanceText(v163);
        p158.chanceText.TextColor3 = v167.Color;
    else
        p158.chanceTitle.Text = "KNIFE CHANCE";
        p158.chanceText.Text = PumpkinHuntConfig.chanceText(PumpkinHuntConfig.KnifeChanceMin) .. " to " .. PumpkinHuntConfig.chanceText(PumpkinHuntConfig.KnifeChanceMax);
        local v175;

        if p158.altar then
            v175 = u5.white;
        else
            v175 = u5.mist;
        end;

        p158.chanceText.TextColor3 = v175;
    end;

    local v176 = result.restricted();

    if v176 then
        p158.chanceTitle.Text = "EVERY PUMPKIN YOU COLLECT";
        p158.chanceText.Text = PumpkinHuntConfig.commas(PumpkinHuntConfig.RestrictedCoins) .. " COINS";
        p158.chanceText.TextColor3 = u5.gold;
    end;

    local v177;

    if v176 then
        v177 = u2;
    else
        v177 = u1;
    end;

    p158.info.Text = v177;

    for _, v in {
        p158.oddsButton,
        p158.showcaseTitle,
        p158.showcaseName,
        p158.showcaseInfo,
        p158.showcaseHint
    } do
        if v then
            v.Visible = not v176;
        end;
    end;

    if v176 and p158.odds then
        p158.odds.Visible = false;
    end;

    local v178 = v163 ~= nil and true or v176;

    if p158.chanceShown ~= v178 then
        local v179 = p158.chanceShown == nil;
        p158.chanceShown = v178;
        p158.chanceTitle.Visible = v178;
        p158.chanceText.Visible = v178;

        if v178 and not v179 then
            for _, v in p158.chancePops do
                v.Scale = 0.4;
                TweenService:Create(v, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();
            end;
        end;
    end;

    if p158.showcaseInfo then
        local showcaseInfo = p158.showcaseInfo;
        local v180;

        if v163 then
            v180 = PumpkinHuntConfig.chanceText(v163) .. " in every pumpkin";
        else
            v180 = PumpkinHuntConfig.chanceText(PumpkinHuntConfig.KnifeChanceMin) .. "–" .. PumpkinHuntConfig.chanceText(PumpkinHuntConfig.KnifeChanceMax) .. " in every pumpkin";
        end;

        showcaseInfo.Text = v180;
    end;

    local v181, v182, v183;

    if math_min_ret < v159.goal then
        v181 = math_min_ret / v159.goal;
        v182 = PumpkinHuntConfig.commas(math_min_ret) .. " / " .. PumpkinHuntConfig.commas(v159.goal) .. " coins to unlock the hunt";
        p158.fillGradient.Color = ColorSequence.new(u5.witch, lerp(u5.witch, u5.pumpkin, v181));
        v183 = "STAGE 1 · UNLOCK THE HUNT";
    else
        local math_max_ret3 = math.max(1, v159.max - v159.goal);
        local v184 = v159.max <= math_min_ret;
        v181 = (math_min_ret - v159.goal) / math_max_ret3;
        v183 = v184 and "MAXED · AS LUCKY AS IT GETS" or "STAGE 2 · RAISE THE LUCK";

        if v184 then
            v182 = "MAXED! " .. PumpkinHuntConfig.chanceText(PumpkinHuntConfig.KnifeChanceMax) .. " knife chance";
        else
            v182 = PumpkinHuntConfig.commas(math_min_ret) .. " / " .. PumpkinHuntConfig.commas(v159.max) .. " coins · max " .. PumpkinHuntConfig.chanceText(PumpkinHuntConfig.KnifeChanceMax);
        end;

        p158.fillGradient.Color = ColorSequence.new(u5.pumpkin, lerp(u5.pumpkin, u5.gold, v181));

        if v176 then
            v183 = v184 and "MAXED" or "THE HUNT IS UNLOCKED";

            if v184 then
                v182 = "MAXED!";
            else
                v182 = PumpkinHuntConfig.commas(math_min_ret) .. " / " .. PumpkinHuntConfig.commas(v159.max) .. " coins";
            end;
        end;
    end;

    if v159.phase == "Running" then
        v183 = "THE HUNT IS ON";
    elseif v159.king and (v159.phase == "Filling" or v159.phase == "Ready") then
        v183 = "THE KING RISES";
    elseif v159.phase == "Cooldown" then
        local v185 = v159.cooldownEndsAt - workspace:GetServerTimeNow();
        local math_floor_ret = math.floor(v185);
        local math_max_ret3 = math.max(0, math_floor_ret);
        v182 = "Back in " .. string.format("%d:%02d", math_max_ret3 // 60, math_max_ret3 % 60);
        v183 = "COOLDOWN";
        v181 = 0;
    end;

    p158.stageText.Text = v183;
    p158.barText.Text = v182;

    if p158.shownFraction ~= v181 then
        p158.shownFraction = v181;
        TweenService:Create(p158.fill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(math.clamp(v181, 0, 1), 1)
        }):Play();
    end;

    p158.coinText.Text = not p158.coins and "..." or PumpkinHuntConfig.commas(p158.coins);
    local v186 = not v159.sealed;

    if v186 then
        if v159.phase == "Filling" or v159.phase == "Ready" then
            v186 = not v162 and not v159.king;
        else
            v186 = false;
        end;
    end;

    for i, v in p158.chips do
        v.Interactable = v186;
        v.AutoButtonColor = v186;
        setLook(v, v186 and (i == p158.chip and "witch" or "dark") or "grey");
    end;

    local v187 = "SACRIFICE";
    local v188 = "pumpkin";
    local v189 = true;

    if v159.sealed then
        v187 = "BOWL SEALED";
        v189 = false;
    elseif v159.phase == "Running" then
        v187 = "HUNT IN PROGRESS";
        v189 = false;
    elseif v159.phase == "Cooldown" then
        v187 = "COOLDOWN";
        v189 = false;
    elseif v159.king then
        v187 = "CLOSED · KING RISING";
        v189 = false;
    elseif v162 or math_max_ret2 <= 0 then
        v187 = "MAXED";
        v189 = false;
        v188 = "gold";
    elseif p158.coins == nil then
        v187 = "LOADING";
        v189 = false;
    elseif v161 < math.min(v160, math_max_ret2) then
        v187 = "NOT ENOUGH COINS";
        v189 = false;
    end;

    p158.cta:FindFirstChild("TextLabel").Text = v187;
    local cta = p158.cta;
    cta.Interactable = v189;
    cta.AutoButtonColor = v189;
    setLook(cta, not v189 and "grey" or v188);

    if v162 and not v189 then
        setLook(p158.cta, "gold");
    end;

    local timer = p158.timer;
    local v190;

    if v159.phase == "Cooldown" then
        local v191 = v159.cooldownEndsAt - workspace:GetServerTimeNow();
        local math_floor_ret = math.floor(v191);
        local math_max_ret3 = math.max(0, math_floor_ret);
        v190 = "Back in " .. string.format("%d:%02d", math_max_ret3 // 60, math_max_ret3 % 60);
    else
        v190 = "";
    end;

    timer.Text = v190;
    p158.info.Visible = v159.phase ~= "Cooldown";
end;

function u3.say(p192, p193) -- Line: 1076
    p192.status.Text = p193 or "";
    p192.statusAt = os.clock();
end;

function u3.burst(p194, p195, p196) -- Line: 1085
    -- upvalues: TweenService (copy), u5 (copy), label (copy), PumpkinHuntConfig (copy)
    if not (p194.frame and p194.frame.Parent) then
        return;
    end;

    p194.pumpkinPop.Scale = p196 and 1.14 or 1.06;
    TweenService:Create(p194.pumpkinPop, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    p194.flare = 1;
    p194.flash.BackgroundTransparency = 0.55;
    TweenService:Create(p194.flash, TweenInfo.new(0.4), {
        BackgroundTransparency = 1
    }):Play();

    if not p196 then
        return;
    end;

    p194.ctaPop.Scale = 0.92;
    TweenService:Create(p194.ctaPop, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    local Vector2_new_ret = Vector2.new(0.5, 0.94);
    local v197 = p194:target();

    for i = 1, 7 do
        local fx = p194.fx;
        local v198 = {
            ZIndex = 10,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(Vector2_new_ret.X + (math.random() - 0.5) * 0.1, Vector2_new_ret.Y + (math.random() - 0.5) * 0.05),
            Size = UDim2.fromScale(0.012, 0.019)
        };
        local v199;

        if i % 2 == 0 then
            v199 = u5.pumpkin;
        else
            v199 = u5.ember;
        end;

        v198.BackgroundColor3 = v199;
        v198.BorderSizePixel = 0;
        v198.Active = false;
        v198.Interactable = false;
        local Frame = Instance.new("Frame");
        Frame.Name = "Spark";
        local _ = i;

        for i2, v in v198 or {} do
            Frame[i2] = v;
        end;

        Frame.Parent = fx;
        local v200 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v in v200 or {} do
            UICorner[i2] = v;
        end;

        UICorner.Parent = Frame;
        local v201 = 0.45 + math.random() * 0.25;
        TweenService:Create(Frame, TweenInfo.new(v201, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundTransparency = 0.4,
            Position = UDim2.fromScale(v197.X + (math.random() - 0.5) * 0.08, v197.Y + (math.random() - 0.5) * 0.08),
            Size = UDim2.fromScale(0.006, 0.0096)
        }):Play();
        task.delay(v201, function() -- Line: 1116
            -- upvalues: Frame (copy)
            Frame:Destroy();
        end);
    end;

    local u202 = label(p194.fx, "Plus", "+" .. PumpkinHuntConfig.short(p195), {
        ZIndex = 11,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y - 0.07),
        Size = UDim2.fromScale(0.12, 0.06),
        TextColor3 = u5.gold
    }, 0.1);
    TweenService:Create(u202, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1,
        Position = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y - 0.17)
    }):Play();
    TweenService:Create(u202.UIStroke, TweenInfo.new(0.8), {
        Transparency = 1
    }):Play();
    task.delay(0.85, function() -- Line: 1132
        -- upvalues: u202 (copy)
        u202:Destroy();
    end);
end;

function u3.target(p203) -- Line: 1138
    if p203.sparkTarget then
        local success2, result2 = pcall(p203.sparkTarget);

        if success2 and typeof(result2) == "Vector2" then
            return result2;
        end;
    end;

    return Vector2.new(0.5, 0.45);
end;

function u3.altarIn(p204) -- Line: 1150
    -- upvalues: TweenService (copy), u5 (copy), play (copy)
    local frame = p204.frame;

    if not frame then
        return;
    end;

    p204.outToken = nil;
    frame.Visible = true;
    p204.pop.Scale = 0.55;
    TweenService:Create(p204.pop, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    local v205 = p204:target();

    for i = 1, 18 do
        local v206 = i / 18 * 3.141592653589793 * 2 + math.random() * 0.3;
        local fx = p204.fx;
        local v207 = {
            ZIndex = 10,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(v205.X, v205.Y),
            Size = UDim2.fromScale(0.008, 0.0135)
        };
        local v208;

        if i % 3 == 0 then
            v208 = u5.witch;
        elseif i % 3 == 1 then
            v208 = u5.pumpkin;
        else
            v208 = u5.ember;
        end;

        v207.BackgroundColor3 = v208;
        v207.BorderSizePixel = 0;
        v207.Active = false;
        v207.Interactable = false;
        local Frame = Instance.new("Frame");
        Frame.Name = "Spark";
        local _ = i;

        for i2, v in v207 or {} do
            Frame[i2] = v;
        end;

        Frame.Parent = fx;
        local v209 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v in v209 or {} do
            UICorner[i2] = v;
        end;

        UICorner.Parent = Frame;
        local v210 = 0.16 + math.random() * 0.14;
        local v211 = 0.5 + math.random() * 0.3;
        TweenService:Create(Frame, TweenInfo.new(v211, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(v205.X + math.cos(v206) * v210 / 2.115, v205.Y + math.sin(v206) * v210),
            Size = UDim2.fromScale(0.003, 0.005)
        }):Play();
        task.delay(v211, function() -- Line: 1178
            -- upvalues: Frame (copy)
            Frame:Destroy();
        end);
    end;

    for _, v in p204.cards do
        local Ring = v:FindFirstChild("Ring");

        if Ring then
            Ring.Color = u5.gold;
            TweenService:Create(Ring, TweenInfo.new(0.7), {
                Color = u5.pumpkin
            }):Play();
        end;
    end;

    play("Collect");
end;

function u3.altarOut(u212) -- Line: 1191
    -- upvalues: TweenService (copy)
    if not u212.frame then
        return;
    end;

    local u213 = {};
    u212.outToken = u213;
    TweenService:Create(u212.pop, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Scale = 0.6
    }):Play();
    task.delay(0.18, function() -- Line: 1199
        -- upvalues: u212 (copy), u213 (copy)
        if u212.outToken == u213 and u212.frame then
            u212.frame.Visible = false;
            u212.pop.Scale = 1;
        end;
    end);
end;

function u3.animate(p214, p215) -- Line: 1208
    local os_clock_ret = os.clock();

    for _, v in p214.bats do
        local math_sin_ret = math.sin(os_clock_ret * v.speed * 3.141592653589793 + v.phase);
        local v216 = math.abs(math_sin_ret) * 0.35 + 0.65;
        v.image.Size = UDim2.fromScale(v.size, v.size * (v.tall or 1.6) * v216);
        v.image.Position = UDim2.fromScale(v.x + math.sin(os_clock_ret * 0.4 + v.phase) * 0.02, v.y + math.sin(os_clock_ret * 0.9 + v.phase) * 0.01);
    end;

    for _, v in p214.embers do
        local v217 = 1 - (os_clock_ret * v.speed + v.phase) % 1;
        v.frame.Position = UDim2.fromScale(v.x + math.sin(os_clock_ret + v.phase) * 0.01, v217);
        v.frame.BackgroundTransparency = 0.2 + 0.7 * (1 - v217);
    end;

    p214.flare = math.max(0, (p214.flare or 0) - p215 * 2);
    local math_clamp_ret = math.clamp((p214.glow or 0) + 0.35 * p214.flare, 0, 1);
    local v218 = math.sin(os_clock_ret * 13) * 0.06 + math.sin(os_clock_ret * 7.3) * 0.04;
    p214.eyes.ImageTransparency = 1 - math.clamp(math_clamp_ret * (v218 + 0.85), 0, 1);
    p214.halo.ImageTransparency = 1 - math.clamp(math_clamp_ret * 0.5 + 0.3, 0, 1);
    p214.halo.Rotation = (p214.halo.Rotation + p215 * (math_clamp_ret * 30 + 8)) % 360;

    if p214.statusAt and os.clock() - p214.statusAt > 4 then
        p214.statusAt = nil;
        p214.status.Text = "";
    end;
end;

function u3.sacrifice(p219) -- Line: 1235
    -- upvalues: u3 (copy), PumpkinHuntConfig (copy), u8 (copy), play (copy)
    if not p219:available() then
        u3.notice(u3.UNAVAILABLE);
        p219.host.close();

        return;
    end;

    if os.clock() - p219.lastClick < 0.12 then
        return;
    end;

    p219.lastClick = os.clock();
    local v220 = p219:snapshot();
    local v221 = PumpkinHuntConfig.Pot.Amounts[p219.chip];
    local max = v220.max;
    local math_max_ret = math.max(v220.pot, p219.optimistic or 0);
    local math_min_ret = math.min(max, math_max_ret);
    local v222 = v220.max - math_min_ret;

    if v222 <= 0 or (v220.phase == "Running" or (v220.phase == "Cooldown" or (v220.sealed or v220.king))) then
        return;
    end;

    local math_min_ret2 = math.min(v221, v222);
    local v223;

    if p219.coins then
        v223 = math.min(p219.coins, p219.spendable or (1 / 0));
    else
        v223 = nil;
    end;

    if v223 and v223 < math_min_ret2 then
        p219:say(u8.NotEnough);
        p219:refresh();

        return;
    end;

    p219.localPending = p219.localPending + math_min_ret2;
    p219.optimistic = math_min_ret + math_min_ret2;
    local v224;

    if v223 then
        v224 = v223 - math_min_ret2;
    else
        v224 = nil;
    end;

    p219.spendable = v224;
    p219.pendingAt = os.clock();
    p219.remote:FireServer("Sacrifice", p219.chip);
    p219:burst(math_min_ret2, true);
    u3.sacrificed:Fire(math_min_ret2);
    play("Sacrifice");
    p219:refresh();
end;

function u3.fetch(p225) -- Line: 1270
    -- upvalues: ArmoryEvent (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret - (p225.fetchedAt or (-1 / 0)) >= 0.75 then
        p225.fetchedAt = os_clock_ret;
        ArmoryEvent:FireServer("Get");
    end;
end;

function u3.opened(u226) -- Line: 1278
    -- upvalues: u3 (copy), RunService (copy)
    if not u226:available() then
        task.defer(u226.host.close);
        u3.notice(u3.UNAVAILABLE);

        return;
    end;

    u226:fetch();
    u226:say("");
    u226:refresh();

    if not u226.animation then
        u226.animation = RunService.RenderStepped:Connect(function(p227) -- Line: 1289
            -- upvalues: u226 (copy)
            u226:animate(p227);
        end);
    end;
end;

function u3.closed(p228) -- Line: 1294
    if p228.animation then
        p228.animation:Disconnect();
        p228.animation = nil;
    end;
end;

function u3.start(u229, u230) -- Line: 1301
    -- upvalues: ArmoryEvent (copy), LocalPlayer (copy), u3 (copy), ChickenOrHero (copy), result (copy), u8 (copy)
    u229.host = u230;
    u229.cta.Activated:Connect(function() -- Line: 1303
        -- upvalues: u229 (copy)
        u229:sacrifice();
    end);
    ArmoryEvent.OnClientEvent:Connect(function(p231, p232) -- Line: 1306
        -- upvalues: u229 (copy), u230 (copy)
        if p231 == "State" and (type(p232) == "table" and (p232.loaded == true and type(p232.coins) == "number")) then
            u229.coins = p232.coins;

            if u230.isOpen() then
                u229:refresh();
            end;
        end;
    end);

    local function lobby() -- Line: 1315
        -- upvalues: LocalPlayer (ref), u229 (copy), u230 (copy), u3 (ref)
        local v233 = LocalPlayer:GetAttribute("InMatch") ~= true;
        local v234 = u229:available();
        u230.setAvailable(v233 and v234);

        if u230.isOpen() and not (v233 and v234) then
            u230.close();

            if not v234 then
                u3.notice(u3.UNAVAILABLE);
            end;
        end;
    end;

    LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(lobby);
    lobby();
    task.spawn(function() -- Line: 1328
        -- upvalues: u229 (copy), u230 (copy)
        while u229.frame do
            if u229.localPending > 0 and os.clock() - (u229.pendingAt or 0) > 6 then
                u229.localPending = 0;
                u229.optimistic = nil;
                u229.spendable = nil;
            end;

            if u229.localPending == 0 and (u229.optimistic or u229.spendable) and os.clock() - (u229.settledAt or 0) > 2 then
                u229.optimistic = nil;
                u229.spendable = nil;
            end;

            if u230.isOpen() then
                u229:refresh();
            end;

            task.wait(1);
        end;
    end);
    local PumpkinHuntEvent = ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntEvent", 60);

    if not PumpkinHuntEvent then
        warn("SacrificeScreen: Game.PumpkinHuntEvent never arrived after 60 s; waiting for it");
        PumpkinHuntEvent = ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntEvent");
    end;

    u229.remote = PumpkinHuntEvent;
    PumpkinHuntEvent.AttributeChanged:Connect(function(p235) -- Line: 1350
        -- upvalues: lobby (copy), u230 (copy), u229 (copy)
        if p235 == "Live" then
            lobby();
        end;

        if u230.isOpen() then
            u229:refresh();
        end;
    end);
    lobby();
    PumpkinHuntEvent.OnClientEvent:Connect(function(p236, p237, p238) -- Line: 1359
        -- upvalues: u229 (copy), result (ref), u8 (ref), u230 (copy), LocalPlayer (ref)
        if p236 == "Result" and type(p237) == "table" then
            if p237.ok == true then
                local v239 = u229.localPending - (tonumber(p237.amount) or 0);
                u229.localPending = math.max(0, v239);

                if u229.localPending == 0 then
                    u229.settledAt = os.clock();
                end;
            else
                u229.localPending = 0;
                u229.optimistic = nil;
                u229.spendable = nil;
                u229:say(p237.reason == "Maxed" and result.restricted() and "The bowl is MAXED!" or (u8[p237.reason] or u8.Failed));
            end;

            if u230.isOpen() then
                u229:refresh();
            end;
        elseif p236 == "Burst" and (u230.isOpen() and p237 ~= LocalPlayer.UserId) then
            u229:burst(tonumber(p238) or 0, false);
        end;
    end);
    u229:refresh();
end;

function u3.notice(u240) -- Line: 1384
    -- upvalues: ChickenOrHero (copy)
    task.spawn(function() -- Line: 1385
        -- upvalues: ChickenOrHero (ref), u240 (copy)
        local success2, result2 = pcall(function() -- Line: 1386
            -- upvalues: ChickenOrHero (ref), u240 (ref)
            local v241;

            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                v241 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v241 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
            end;

            require(v241).show(u240);
        end);

        if not success2 then
            warn("Pumpkin Hunt notice: " .. tostring(result2));
        end;
    end);
end;

return u3;