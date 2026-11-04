 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local PumpkinHuntConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntConfig"));
local success, result = pcall(function() -- Line: 40
    -- upvalues: ChickenOrHero (copy)
    return require(ChickenOrHero:WaitForChild("Game"):WaitForChild("RandomPrizePolicy", 10)).start();
end);

if not success or type(result) ~= "table" then
    warn("[PumpkinScreen] Game.RandomPrizePolicy didn\'t load (" .. tostring(result) .. "); nobody is treated as restricted");
    result = {
        restricted = function() -- Line: 47, Name: restricted
            return false;
        end,

        start = function() -- Line: 47, Name: start
        end,

        Changed = Instance.new("BindableEvent")
    };
end;

local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local KnifeIconCopy = require(Weapons:WaitForChild("KnifeIconCopy"));
local PumpkinFloat = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("PumpkinFloat"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
u1.__index = u1;
u1.UNAVAILABLE = PumpkinHuntConfig.Unavailable;
u1.counted = Instance.new("BindableEvent");

local function counted(p2) -- Line: 60
    -- upvalues: result (copy), u1 (copy)
    local v3 = result.restricted() and 0 or p2;
    u1.count = v3;
    u1.counted:Fire(v3);
end;

local u4 = {
    Pumpkin = "rbxassetid://122172980164834",
    Bat = "rbxassetid://70771941159898",
    Moon = "rbxassetid://108163343124811",
    Web = "rbxassetid://77897902869831",
    Ghost = "rbxassetid://121891052662054",
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
    white = Color3.new(1, 1, 1),
    bad = Color3.fromRGB(255, 96, 96),
    titleStroke = Color3.fromRGB(40, 8, 30)
};
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.Creepster);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local u6 = {
    InMatch = "Open pumpkins in the lobby.",
    Loading = "Your pumpkins are still loading.",
    Busy = "Still opening the last one.",
    NoPumpkins = "You don\'t have any pumpkins. Win some in a Pumpkin Hunt!",
    Failed = "That didn\'t save, and no pumpkin was used. Try again.",
    Slow = "Still waiting on that pumpkin. Your prize shows as soon as it lands.",
    Unavailable = PumpkinHuntConfig.Unavailable
};

local function rarityColor(p7) -- Line: 115
    if p7 <= 100 then
        return Color3.fromRGB(242, 191, 89);
    end;

    if p7 <= 500 then
        return Color3.fromRGB(183, 123, 244);
    end;

    if p7 <= 2000 then
        return Color3.fromRGB(92, 173, 238);
    end;

    if p7 <= 3000 then
        return Color3.fromRGB(104, 211, 122);
    end;

    return Color3.fromRGB(214, 220, 226);
end;

local u8 = {
    { 100, "LEGENDARY", Color3.fromRGB(242, 191, 89) },
    { 500, "EPIC", Color3.fromRGB(183, 123, 244) },
    { 2000, "RARE", Color3.fromRGB(92, 173, 238) },
    { 3000, "UNCOMMON", Color3.fromRGB(104, 211, 122) },
    { (1 / 0), "COMMON", Color3.fromRGB(214, 220, 226) }
};

local function rarityOf(p9) -- Line: 135
    -- upvalues: u8 (copy)
    local v10 = p9.kind == "Knife" and 0 or (tonumber(p9.odds) or 10000);

    for i, v in u8 do
        if v10 <= v[1] then
            return v[2], v[3], #u8 - i;
        end;
    end;

    return "COMMON", u8[#u8][3], 0;
end;

local u11 = {
    pumpkin = { Color3.fromRGB(255, 176, 70), Color3.fromRGB(226, 92, 8), Color3.fromRGB(255, 150, 50) },
    grey = { Color3.fromRGB(110, 100, 120), Color3.fromRGB(70, 62, 80), Color3.fromRGB(110, 100, 120) },
    close = { Color3.fromRGB(158, 158, 158), Color3.fromRGB(120, 120, 124), Color3.fromRGB(189, 189, 189) }
};

local function make(p12, p13, p14, p15) -- Line: 150
    local Instance_new_ret = Instance.new(p12);
    Instance_new_ret.Name = p14;

    for i, v in p15 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p13;

    return Instance_new_ret;
end;

local function corner(p16, p17) -- Line: 159
    local v18 = {
        CornerRadius = UDim.new(p17, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v18 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = p16;
end;

local function rings(p19, p20, p21, p22) -- Line: 162
    local v23 = {
        ZIndex = 1,
        Color = Color3.new(0, 0, 0),
        Thickness = p21,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Outline";

    for i, v in v23 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p19;
    local v24 = {
        ZIndex = 2,
        Color = p20,
        Thickness = p22,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "Ring";

    for i, v in v24 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = p19;

    return UIStroke2;
end;

local function label(p25, p26, p27, p28, p29, p30) -- Line: 178
    -- upvalues: Font_new_ret (copy), u5 (copy)
    local v31 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        FontFace = p30 or Font_new_ret,
        Text = p27,
        TextColor3 = u5.white
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p26;

    for i, v in v31 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p25;

    for i, v in p28 or {} do
        TextLabel[i] = v;
    end;

    local v32 = {
        Color = Color3.new(0, 0, 0),
        Thickness = p29 or 0.1,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v32 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function deco(p33, p34, p35, p36) -- Line: 198
    p36.BorderSizePixel = 0;
    p36.Active = false;
    p36.Interactable = false;

    if p33 ~= "Frame" then
        p36.BackgroundTransparency = 1;
    end;

    local Instance_new_ret = Instance.new(p33);
    Instance_new_ret.Name = p35;

    for i, v in p36 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p34;

    return Instance_new_ret;
end;

local function picture(p37, p38, p39, p40) -- Line: 207
    -- upvalues: u4 (copy)
    p40.Image = u4[p39] or p39;
    p40.ScaleType = p40.ScaleType or Enum.ScaleType.Fit;
    p40.AnchorPoint = p40.AnchorPoint or Vector2.new(0.5, 0.5);
    p40.BorderSizePixel = 0;
    p40.Active = false;
    p40.Interactable = false;
    p40.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = p38;

    for i, v in p40 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p37;

    return ImageLabel;
end;

local function setLook(p41, p42) -- Line: 213
    -- upvalues: u11 (copy), u5 (copy)
    local v43 = u11[p42] or u11.grey;
    p41:FindFirstChild("UIGradient").Color = ColorSequence.new(v43[1], v43[2]);
    p41:FindFirstChild("Ring").Color = v43[3];
    local Texture = p41:FindFirstChild("Texture");
    local v44;

    if p42 == "grey" then
        v44 = false;
    else
        v44 = p42 ~= "close";
    end;

    Texture.Visible = v44;
    local TextLabel = p41:FindFirstChild("TextLabel");
    local v45;

    if p42 == "grey" then
        v45 = Color3.fromRGB(190, 182, 200);
    else
        v45 = u5.white;
    end;

    TextLabel.TextColor3 = v45;
end;

local function button(p46, p47, p48, p49, p50) -- Line: 220
    -- upvalues: u5 (copy), rings (copy), label (copy), setLook (copy)
    local v51 = {
        AutoButtonColor = true,
        BorderSizePixel = 0,
        BackgroundColor3 = u5.white
    };
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = p47;

    for i, v in v51 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = p46;

    for i, v in p50 do
        ImageButton[i] = v;
    end;

    local v52 = {
        CornerRadius = UDim.new(0.22, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v52 or {} do
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
    local v53 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.93)
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Texture";

    for i, v in v53 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = ImageButton;
    local v54 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v54 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = CanvasGroup;
    local v55 = {
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

    for i, v in v55 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = CanvasGroup;
    local v56 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0) })
    };
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "UIGradient";

    for i, v in v56 or {} do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = ImageLabel;
    label(ImageButton, "TextLabel", p48, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.86, 0.5),
        ZIndex = ImageButton.ZIndex + 1
    }, 0.1);
    setLook(ImageButton, p49);

    return ImageButton;
end;

local function setEnabled(p57, p58, p59) -- Line: 263
    -- upvalues: setLook (copy)
    p57.Interactable = p58;
    p57.AutoButtonColor = p58;
    setLook(p57, not p58 and "grey" or p59);
end;

local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(1, 1, 0.35));

local function knifeIcon(p60, p61) -- Line: 271
    -- upvalues: SkinCatalog (copy), Weapons (copy), KnifeIconCopy (copy), CFrame_lookAt_ret (copy)
    local v62 = SkinCatalog.get(p61);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        if v62 then
            v62 = Models:FindFirstChild(v62.Model);
        end;
    else
        v62 = Models;
    end;

    if v62 then
        v62 = v62:FindFirstChild("Blade") or v62:FindFirstChildWhichIsA("BasePart", true);
    end;

    local v63 = {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -0.8, -1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(200, 200, 210),
        LightColor = Color3.fromRGB(255, 250, 235),
        ZIndex = p60.ZIndex + 1
    };
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "Knife";

    for i, v in v63 or {} do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = p60;

    if not v62 then
        return ViewportFrame;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "World";

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = ViewportFrame;
    local v64, _, v65, v66 = KnifeIconCopy.new(v62);
    v64.Parent = WorldModel;
    local Size = v64.Size;
    local v67;

    if Size.Z >= Size.X and Size.Z >= Size.Y then
        v67 = CFrame_lookAt_ret;
    elseif Size.X >= Size.Y then
        v67 = CFrame_lookAt_ret * CFrame.Angles(0, 1.5707963267948966, 0);
    else
        v67 = CFrame_lookAt_ret * CFrame.Angles(-1.5707963267948966, 0, 0);
    end;

    v64.CFrame = CFrame.new(-v67:VectorToWorldSpace(v66)) * v67;
    local math_max_ret = math.max(v65.X, v65.Y, v65.Z);
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

local function spinToken(p68) -- Line: 305
    -- upvalues: u5 (copy), label (copy)
    local v69 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.95, 0.95),
        BackgroundColor3 = u5.white,
        ZIndex = p68.ZIndex + 1
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Spin";

    for i, v in v69 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p68;
    local v70 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v70 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v71 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3.fromRGB(255, 225, 120), Color3.fromRGB(230, 161, 0))
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v71 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v72 = {
        Thickness = 0.08,
        Color = u5.white,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Ring";

    for i, v in v72 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    label(Frame, "Text", "SPIN", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.45),
        ZIndex = Frame.ZIndex + 1
    }, 0.12);

    return Frame;
end;

local function prizeIcon(p73, p74) -- Line: 320
    -- upvalues: knifeIcon (copy), PumpkinHuntConfig (copy), spinToken (copy), u4 (copy), label (copy), u5 (copy)
    if p74 == "Knife" then
        return knifeIcon(p73, PumpkinHuntConfig.Knife);
    end;

    if p74 == "Spins" then
        return spinToken(p73);
    end;

    local v75 = (p74 == "Gems" or p74 == "GemBoostMinutes") and "rbxassetid://137046122108742" or (p74 == "CandyCorn" and "rbxassetid://119759573303359" or (p74 == "GhostKeys" and "rbxassetid://99826093535691" or "rbxassetid://78008558948307"));
    local v76 = {
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        ZIndex = p73.ZIndex + 1,
        Image = u4[v75] or v75
    };
    v76.ScaleType = v76.ScaleType or Enum.ScaleType.Fit;
    v76.AnchorPoint = v76.AnchorPoint or Vector2.new(0.5, 0.5);
    v76.BorderSizePixel = 0;
    v76.Active = false;
    v76.Interactable = false;
    v76.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Image";

    for i, v in v76 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p73;

    if p74 == "CoinBoostMinutes" or p74 == "GemBoostMinutes" then
        label(p73, "Boost", "2x", {
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.fromScale(1.15, 1.05),
            Size = UDim2.fromScale(0.7, 0.5),
            TextColor3 = u5.gold,
            ZIndex = p73.ZIndex + 2
        }, 0.12);
    end;

    return ImageLabel;
end;

local function prizeText(p77) -- Line: 344
    -- upvalues: SkinCatalog (copy), PumpkinHuntConfig (copy)
    if p77.kind ~= "Knife" then
        return tostring(p77.name or "a prize");
    end;

    local v78 = SkinCatalog.get(p77.knife or PumpkinHuntConfig.Knife);
    local v79 = v78 and v78.Name or PumpkinHuntConfig.Knife;

    if p77.duplicateGems then
        return v79 .. " (already yours, so +" .. p77.duplicateGems .. " gems)";
    end;

    return v79;
end;

local function play(p80, p81, p82) -- Line: 352
    -- upvalues: PumpkinHuntConfig (copy), SoundService (copy)
    local v83 = PumpkinHuntConfig.Sounds[p80];

    if not v83 then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = v83[1];
    Sound.Volume = p81 or (v83[2] or 0.5);
    Sound.PlaybackSpeed = p82 or 1;
    Sound.Parent = SoundService;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 363
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    task.delay(6, function() -- Line: 366
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

local function luckOf(p84) -- Line: 372
    -- upvalues: PumpkinHuntConfig (copy)
    return (p84 - PumpkinHuntConfig.KnifeChanceMin) / math.max(1, PumpkinHuntConfig.KnifeChanceMax - PumpkinHuntConfig.KnifeChanceMin);
end;

function u1.new() -- Line: 379
    -- upvalues: u1 (copy), u5 (copy), u4 (copy), label (copy), Font_fromEnum_ret (copy), button (copy), rings (copy), PumpkinHuntConfig (copy), prizeIcon (copy), SkinCatalog (copy), PumpkinFloat (copy)
    local u85 = setmetatable({
        total = 0,
        rows = {},
        cards = {},
        stacks = {},
        embers = {},
        bats = {}
    }, u1);
    local v86 = {
        BackgroundTransparency = 1,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Pumpkins";

    for i, v in v86 or {} do
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
    u85.pop = UIScale;
    u85.frame = Frame;
    Frame.Destroying:Connect(function() -- Line: 395
        -- upvalues: u85 (copy)
        u85.frame = nil;

        if u85.animation then
            u85.animation:Disconnect();
            u85.animation = nil;
        end;
    end);
    local v87 = {
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

    for i, v in v87 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    Frame2.Visible = false;
    local v88 = {
        BackgroundTransparency = 1,
        ZIndex = 1,
        Visible = false,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "HalloweenNight";

    for i, v in v88 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local v89 = {
        ImageTransparency = 0.75,
        ZIndex = 1,
        Position = UDim2.fromScale(0.665, 0.085),
        Size = UDim2.fromScale(0.11, 0.233),
        ImageColor3 = u5.moon,
        Image = u4.Glow or "Glow"
    };
    v89.ScaleType = v89.ScaleType or Enum.ScaleType.Fit;
    v89.AnchorPoint = v89.AnchorPoint or Vector2.new(0.5, 0.5);
    v89.BorderSizePixel = 0;
    v89.Active = false;
    v89.Interactable = false;
    v89.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "MoonGlow";

    for i, v in v89 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame3;
    u85.moonGlow = ImageLabel;
    local v90 = {
        ImageTransparency = 0.3,
        ZIndex = 1,
        Position = UDim2.fromScale(0.665, 0.085),
        Size = UDim2.fromScale(0.05, 0.106),
        ImageColor3 = u5.moon,
        Image = u4.Moon or "Moon"
    };
    v90.ScaleType = v90.ScaleType or Enum.ScaleType.Fit;
    v90.AnchorPoint = v90.AnchorPoint or Vector2.new(0.5, 0.5);
    v90.BorderSizePixel = 0;
    v90.Active = false;
    v90.Interactable = false;
    v90.BackgroundTransparency = 1;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Moon";

    for i, v in v90 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame3;
    local v91 = {
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

    for i, v in v91 or {} do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    local v92 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.35, 0.82), NumberSequenceKeypoint.new(1, 0.72) })
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v92 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame4;

    for i, v in { { 0.33, 0.16, 0.026, 1.6, 0 }, { 0.62, 0.28, 0.022, 2.1, 1.7 }, { 0.76, 0.09, 0.024, 1.8, 3.1 } } do
        local v93 = {
            ImageTransparency = 0.2,
            ZIndex = 1,
            Position = UDim2.fromScale(v[1], v[2]),
            Size = UDim2.fromScale(v[3], v[3] * 2.1),
            Image = u4.Bat or "Bat"
        };
        v93.ScaleType = v93.ScaleType or Enum.ScaleType.Fit;
        v93.AnchorPoint = v93.AnchorPoint or Vector2.new(0.5, 0.5);
        v93.BorderSizePixel = 0;
        v93.Active = false;
        v93.Interactable = false;
        v93.BackgroundTransparency = 1;
        local ImageLabel3 = Instance.new("ImageLabel");
        ImageLabel3.Name = "Bat" .. i;
        local v94 = v;

        for i2, v2 in v93 or {} do
            ImageLabel3[i2] = v2;
        end;

        ImageLabel3.Parent = Frame3;
        table.insert(u85.bats, {
            image = ImageLabel3,
            x = v94[1],
            y = v94[2],
            size = v94[3],
            speed = v94[4],
            phase = v94[5]
        });
    end;

    for i = 1, 14 do
        local v95 = {
            ZIndex = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromScale(0.0035, 0.0074)
        };
        local v96;

        if i % 3 == 0 then
            v96 = u5.witch;
        else
            v96 = u5.ember;
        end;

        v95.BackgroundColor3 = v96;
        v95.BorderSizePixel = 0;
        v95.Active = false;
        v95.Interactable = false;
        local Frame5 = Instance.new("Frame");
        Frame5.Name = "Ember" .. i;
        local v97 = i;

        for i2, v in v95 or {} do
            Frame5[i2] = v;
        end;

        Frame5.Parent = Frame3;
        local v98 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v in v98 or {} do
            UICorner[i2] = v;
        end;

        UICorner.Parent = Frame5;
        table.insert(u85.embers, {
            frame = Frame5,
            x = v97 * 0.173 % 1 * 0.4 + 0.3,
            speed = v97 % 4 * 0.02 + 0.05,
            phase = v97 * 0.57
        });
    end;

    label(Frame, "Title", "YOUR PUMPKINS", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.06),
        Size = UDim2.fromScale(0.4, 0.1),
        TextColor3 = u5.pumpkin
    }, 0.06, Font_fromEnum_ret).UIStroke.Color = u5.titleStroke;
    u85.leftText = label(Frame, "Count", "", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.128),
        Size = UDim2.fromScale(0.4, 0.042),
        TextColor3 = u5.ember
    }, 0.1);
    local v99 = {
        BackgroundTransparency = 1,
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.435),
        Size = UDim2.fromScale(0.3, 0.5)
    };
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "Next";

    for i, v in v99 or {} do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame;
    local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint2.Name = "Square";

    for i, v in {
        AspectRatio = 1
    } or {} do
        UIAspectRatioConstraint2[i] = v;
    end;

    UIAspectRatioConstraint2.Parent = Frame5;
    u85.stage = Frame5;
    local v100 = {
        ImageTransparency = 0.8,
        ZIndex = 3,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.7, 1.7),
        ImageColor3 = u5.pumpkin,
        Image = u4.Glow or "Glow"
    };
    v100.ScaleType = v100.ScaleType or Enum.ScaleType.Fit;
    v100.AnchorPoint = v100.AnchorPoint or Vector2.new(0.5, 0.5);
    v100.BorderSizePixel = 0;
    v100.Active = false;
    v100.Interactable = false;
    v100.BackgroundTransparency = 1;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.Name = "Halo";

    for i, v in v100 or {} do
        ImageLabel3[i] = v;
    end;

    ImageLabel3.Parent = Frame5;
    u85.halo = ImageLabel3;
    local v101 = {
        ImageTransparency = 1,
        ZIndex = 4,
        Position = UDim2.fromScale(0.5, 0.52),
        Size = UDim2.fromScale(1.05, 1.05),
        ImageColor3 = u5.ember,
        Image = u4.GlowGold or "GlowGold"
    };
    v101.ScaleType = v101.ScaleType or Enum.ScaleType.Fit;
    v101.AnchorPoint = v101.AnchorPoint or Vector2.new(0.5, 0.5);
    v101.BorderSizePixel = 0;
    v101.Active = false;
    v101.Interactable = false;
    v101.BackgroundTransparency = 1;
    local ImageLabel4 = Instance.new("ImageLabel");
    ImageLabel4.Name = "EyeGlow";

    for i, v in v101 or {} do
        ImageLabel4[i] = v;
    end;

    ImageLabel4.Parent = Frame5;
    u85.eyes = ImageLabel4;
    local v102 = {
        ZIndex = 5,
        Position = UDim2.fromScale(0.5, 0.52),
        Size = UDim2.fromScale(1, 1),
        Image = u4.Pumpkin or "Pumpkin"
    };
    v102.ScaleType = v102.ScaleType or Enum.ScaleType.Fit;
    v102.AnchorPoint = v102.AnchorPoint or Vector2.new(0.5, 0.5);
    v102.BorderSizePixel = 0;
    v102.Active = false;
    v102.Interactable = false;
    v102.BackgroundTransparency = 1;
    local ImageLabel5 = Instance.new("ImageLabel");
    ImageLabel5.Name = "Pumpkin";

    for i, v in v102 or {} do
        ImageLabel5[i] = v;
    end;

    ImageLabel5.Parent = Frame5;
    u85.pumpkin = ImageLabel5;
    local pumpkin = u85.pumpkin;
    local UIScale2 = Instance.new("UIScale");
    UIScale2.Name = "Pop";

    for i, v in {} do
        UIScale2[i] = v;
    end;

    UIScale2.Parent = pumpkin;
    u85.pumpkinScale = UIScale2;
    u85.pumpkin.Visible = false;
    u85.eyes.Visible = false;
    u85.nextTag = label(Frame5, "NextTag", "NEXT", {
        Visible = false,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromScale(0.34, 0.09),
        TextColor3 = u5.gold
    }, 0.1);
    local v103 = {
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 7,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "Reveal";

    for i, v in v103 or {} do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame5;
    local v104 = {
        ImageTransparency = 0.3,
        ZIndex = 7,
        Position = UDim2.fromScale(0.5, 0.52),
        Size = UDim2.fromScale(1.4, 1.4),
        ImageColor3 = u5.gold,
        Image = u4.Glow or "Glow"
    };
    v104.ScaleType = v104.ScaleType or Enum.ScaleType.Fit;
    v104.AnchorPoint = v104.AnchorPoint or Vector2.new(0.5, 0.5);
    v104.BorderSizePixel = 0;
    v104.Active = false;
    v104.Interactable = false;
    v104.BackgroundTransparency = 1;
    local ImageLabel6 = Instance.new("ImageLabel");
    ImageLabel6.Name = "Rays";

    for i, v in v104 or {} do
        ImageLabel6[i] = v;
    end;

    ImageLabel6.Parent = Frame6;
    u85.revealRays = ImageLabel6;
    local v105 = {
        BackgroundTransparency = 1,
        ZIndex = 8,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.52),
        Size = UDim2.fromScale(0.55, 0.55)
    };
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "Icon";

    for i, v in v105 or {} do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame6;
    u85.revealIcon = Frame7;
    local revealIcon = u85.revealIcon;
    local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint3.Name = "Square";

    for i, v in {
        AspectRatio = 1
    } or {} do
        UIAspectRatioConstraint3[i] = v;
    end;

    UIAspectRatioConstraint3.Parent = revealIcon;
    local revealIcon2 = u85.revealIcon;
    local UIScale3 = Instance.new("UIScale");
    UIScale3.Name = "Pop";

    for i, v in {} do
        UIScale3[i] = v;
    end;

    UIScale3.Parent = revealIcon2;
    u85.revealScale = UIScale3;
    u85.revealName = label(Frame6, "Name", "", {
        ZIndex = 9,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.86),
        Size = UDim2.fromScale(1.3, 0.14),
        TextColor3 = u5.gold
    }, 0.08, Font_fromEnum_ret);
    u85.reveal = Frame6;
    local v106 = {
        BackgroundTransparency = 1,
        ZIndex = 10,
        BackgroundColor3 = u5.white,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "Flash";

    for i, v in v106 or {} do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame5;
    u85.flash = Frame8;
    local flash = u85.flash;
    local v107 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v107 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = flash;
    local UIScale4 = Instance.new("UIScale");
    UIScale4.Name = "Zoom";

    for i, v in {} do
        UIScale4[i] = v;
    end;

    UIScale4.Parent = Frame5;
    u85.stageScale = UIScale4;
    local v108 = {
        BackgroundTransparency = 1,
        ZIndex = 6,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame9 = Instance.new("Frame");
    Frame9.Name = "OpenFX";

    for i, v in v108 or {} do
        Frame9[i] = v;
    end;

    Frame9.Parent = Frame5;
    u85.fxLayer = Frame9;
    local v109 = {
        BackgroundTransparency = 1,
        ZIndex = 4,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame10 = Instance.new("Frame");
    Frame10.Name = "OpenFXBack";

    for i, v in v109 or {} do
        Frame10[i] = v;
    end;

    Frame10.Parent = Frame5;
    u85.backFx = Frame10;
    local v110 = {
        ImageTransparency = 0.55,
        ZIndex = 7,
        Position = UDim2.fromScale(0.5, 0.52),
        Size = UDim2.fromScale(1.9, 1.9),
        Image = u4.Glow or "Glow"
    };
    v110.ScaleType = v110.ScaleType or Enum.ScaleType.Fit;
    v110.AnchorPoint = v110.AnchorPoint or Vector2.new(0.5, 0.5);
    v110.BorderSizePixel = 0;
    v110.Active = false;
    v110.Interactable = false;
    v110.BackgroundTransparency = 1;
    local ImageLabel7 = Instance.new("ImageLabel");
    ImageLabel7.Name = "Rays2";

    for i, v in v110 or {} do
        ImageLabel7[i] = v;
    end;

    ImageLabel7.Parent = Frame6;
    u85.revealRays2 = ImageLabel7;
    u85.revealBanner = label(Frame6, "Rarity", "", {
        ZIndex = 9,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.13),
        Size = UDim2.fromScale(1.5, 0.15)
    }, 0.09);
    local revealBanner = u85.revealBanner;
    local UIScale5 = Instance.new("UIScale");
    UIScale5.Name = "Slam";

    for i, v in {} do
        UIScale5[i] = v;
    end;

    UIScale5.Parent = revealBanner;
    u85.bannerScale = UIScale5;
    local v111 = {
        BackgroundTransparency = 1,
        ZIndex = 40,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(3, 3),
        BackgroundColor3 = u5.white,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame11 = Instance.new("Frame");
    Frame11.Name = "BigFlash";

    for i, v in v111 or {} do
        Frame11[i] = v;
    end;

    Frame11.Parent = Frame;
    u85.bigFlash = Frame11;
    u85.tierText = label(Frame, "Tier", "", {
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.715),
        Size = UDim2.fromScale(0.3, 0.04)
    }, 0.1);
    u85.chanceText = label(Frame, "Chance", "", {
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.775),
        Size = UDim2.fromScale(0.36, 0.075)
    }, 0.08);
    u85.openButton = button(Frame, "Open", "OPEN", "pumpkin", {
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.945),
        Size = UDim2.fromScale(0.182, 0.086)
    });
    u85.closeButton = button(Frame, "CloseButton", "Close", "close", {
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.654, 0.945),
        Size = UDim2.fromScale(0.09, 0.061)
    });
    u85.status = label(Frame, "Status", "", {
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.875),
        Size = UDim2.fromScale(0.4, 0.03),
        TextColor3 = u5.bad
    }, 0.1);
    u85.stacksTitle = label(Frame, "StacksTitle", "BY LUCK", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.822, 0.27),
        Size = UDim2.fromScale(0.17, 0.04),
        TextColor3 = u5.gold
    }, 0.1);
    local v112 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.822, 0.3),
        Size = UDim2.fromScale(0.18, 0.5),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.fromScale(0, 0),
        ScrollBarImageColor3 = u5.pumpkin
    };
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "Stacks";

    for i, v in v112 or {} do
        ScrollingFrame[i] = v;
    end;

    ScrollingFrame.Parent = Frame;
    u85.stackList = ScrollingFrame;
    local stackList = u85.stackList;
    local v113 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    };
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "UIListLayout";

    for i, v in v113 or {} do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = stackList;
    local stackList2 = u85.stackList;
    local v114 = {
        PaddingLeft = UDim.new(0, 4),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 4)
    };
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "UIPadding";

    for i, v in v114 or {} do
        UIPadding[i] = v;
    end;

    UIPadding.Parent = stackList2;
    u85.stackList:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 587
        -- upvalues: u85 (copy)
        for _, v in u85.cards do
            v.frame.Size = UDim2.new(1, 0, 0, u85:rowHeight());
        end;
    end);
    local v115 = {
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

    for i, v in v115 or {} do
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
    local v116 = {
        CornerRadius = UDim.new(0.25, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v116 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = ImageButton;
    rings(ImageButton, u5.witch, 0.068, 0.045);
    local v117 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3.fromRGB(199, 140, 255), Color3.fromRGB(122, 52, 200))
    };
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "UIGradient";

    for i, v in v117 or {} do
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
    u85.oddsButton = ImageButton;
    local v118 = {
        BackgroundTransparency = 0.1,
        Visible = false,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.175, 0.47),
        Size = UDim2.fromScale(0.21, 0.56),
        BackgroundColor3 = u5.ink
    };
    local Frame12 = Instance.new("Frame");
    Frame12.Name = "Odds";

    for i, v in v118 or {} do
        Frame12[i] = v;
    end;

    Frame12.Parent = Frame;
    local v119 = {
        CornerRadius = UDim.new(0.05, 0)
    };
    local UICorner3 = Instance.new("UICorner");
    UICorner3.Name = "UICorner";

    for i, v in v119 or {} do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame12;
    rings(Frame12, u5.edge, 0.008, 0.005);
    u85.odds = Frame12;
    u85.oddsTitle = label(Frame12, "Heading", "INSIDE YOUR NEXT PUMPKIN", {
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.025),
        Size = UDim2.fromScale(0.9, 0.06),
        TextColor3 = u5.gold
    }, 0.1);
    local v120 = {
        BackgroundTransparency = 1,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.11),
        Size = UDim2.fromScale(0.92, 0.86)
    };
    local Frame13 = Instance.new("Frame");
    Frame13.Name = "List";

    for i, v in v120 or {} do
        Frame13[i] = v;
    end;

    Frame13.Parent = Frame12;
    local v121 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0.012, 0)
    };
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Name = "UIListLayout";

    for i, v in v121 or {} do
        UIListLayout2[i] = v;
    end;

    UIListLayout2.Parent = Frame13;
    local v122 = PumpkinHuntConfig.ranked(PumpkinHuntConfig.slots(PumpkinHuntConfig.KnifeChanceMin));
    local v123 = 1 / #v122 - 0.013;

    for i, v in v122 do
        local v124 = v.kind == "Knife";
        local v125 = "Row_" .. v.id;
        local v126 = {
            ZIndex = 6,
            Size = UDim2.fromScale(1, v123)
        };
        local v127;

        if v124 then
            v127 = u5.night;
        else
            v127 = Color3.new(0, 0, 0);
        end;

        v126.BackgroundColor3 = v127;
        v126.BackgroundTransparency = v124 and 0.05 or 0.55;
        v126.LayoutOrder = i;
        local Frame14 = Instance.new("Frame");
        Frame14.Name = v125;
        local v128 = v;

        for i2, v2 in v126 or {} do
            Frame14[i2] = v2;
        end;

        Frame14.Parent = Frame13;
        local v129 = {
            CornerRadius = UDim.new(0.25, 0)
        };
        local UICorner4 = Instance.new("UICorner");
        UICorner4.Name = "UICorner";

        for i2, v2 in v129 or {} do
            UICorner4[i2] = v2;
        end;

        UICorner4.Parent = Frame14;
        local v130;

        if v124 then
            v130 = u5.pumpkin;
        else
            v130 = u5.edge;
        end;

        local v131 = rings(Frame14, v130, 0.04, 0.025);
        local v132 = {
            BackgroundTransparency = 1,
            ZIndex = 7,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0.02, 0.5),
            Size = UDim2.fromScale(0.16, 0.85)
        };
        local Frame15 = Instance.new("Frame");
        Frame15.Name = "Icon";

        for i2, v2 in v132 or {} do
            Frame15[i2] = v2;
        end;

        Frame15.Parent = Frame14;
        local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint5.Name = "Square";

        for i2, v2 in {
            AspectRatio = 1
        } or {} do
            UIAspectRatioConstraint5[i2] = v2;
        end;

        UIAspectRatioConstraint5.Parent = Frame15;
        prizeIcon(Frame15, v128.kind);
        local v133;

        if v124 then
            v133 = SkinCatalog.get(PumpkinHuntConfig.Knife);
        else
            v133 = v124;
        end;

        local v134;

        if v124 then
            v134 = string.upper(v133 and v133.Name or PumpkinHuntConfig.Knife);
        else
            v134 = string.upper(v128.name);
        end;

        local v135 = {
            ZIndex = 7,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0.22, 0.5),
            Size = UDim2.fromScale(0.52, 0.5)
        };
        local v136;

        if v124 then
            v136 = u5.ember;
        else
            v136 = u5.white;
        end;

        v135.TextColor3 = v136;
        v135.TextXAlignment = Enum.TextXAlignment.Left;
        label(Frame14, "Name", v134, v135, 0.1);
        local v137 = label(Frame14, "Percent", "", {
            ZIndex = 7,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.fromScale(0.97, 0.5),
            Size = UDim2.fromScale(0.24, 0.5),
            TextXAlignment = Enum.TextXAlignment.Right
        }, 0.1);
        u85.rows[v128.id] = {
            row = Frame14,
            ring = v131,
            percent = v137,
            knife = v124
        };
    end;

    ImageButton.Activated:Connect(function() -- Line: 659
        -- upvalues: Frame12 (copy)
        Frame12.Visible = not Frame12.Visible;
    end);
    u85.float = PumpkinFloat.new(Frame5);
    u85:floatLook();

    return u85;
end;

function u1.floatLook(p138) -- Line: 671
    local function outline(p139, p140) -- Line: 672
        if p139 then
            p139 = p139:FindFirstChild("UIStroke");
        end;

        if p139 then
            p139.Thickness = p140;
            p139.Color = Color3.new(0, 0, 0);
        end;
    end;

    local Title = p138.frame:FindFirstChild("Title");

    if Title then
        Title = Title:FindFirstChild("UIStroke");
    end;

    if Title then
        Title.Thickness = 0.08;
        Title.Color = Color3.new(0, 0, 0);
    end;

    local leftText = p138.leftText;

    if leftText then
        leftText = leftText:FindFirstChild("UIStroke");
    end;

    if leftText then
        leftText.Thickness = 0.16;
        leftText.Color = Color3.new(0, 0, 0);
    end;

    local tierText = p138.tierText;

    if tierText then
        tierText = tierText:FindFirstChild("UIStroke");
    end;

    if tierText then
        tierText.Thickness = 0.16;
        tierText.Color = Color3.new(0, 0, 0);
    end;

    local chanceText = p138.chanceText;

    if chanceText then
        chanceText = chanceText:FindFirstChild("UIStroke");
    end;

    if chanceText then
        chanceText.Thickness = 0.1;
        chanceText.Color = Color3.new(0, 0, 0);
    end;

    local stacksTitle = p138.stacksTitle;

    if stacksTitle then
        stacksTitle = stacksTitle:FindFirstChild("UIStroke");
    end;

    if stacksTitle then
        stacksTitle.Thickness = 0.16;
        stacksTitle.Color = Color3.new(0, 0, 0);
    end;

    local status = p138.status;

    if status then
        status = status:FindFirstChild("UIStroke");
    end;

    if status then
        status.Thickness = 0.16;
        status.Color = Color3.new(0, 0, 0);
    end;

    local revealName = p138.revealName;

    if revealName then
        revealName = revealName:FindFirstChild("UIStroke");
    end;

    if revealName then
        revealName.Thickness = 0.1;
        revealName.Color = Color3.new(0, 0, 0);
    end;

    local revealBanner = p138.revealBanner;

    if revealBanner then
        revealBanner = revealBanner:FindFirstChild("UIStroke");
    end;

    if revealBanner then
        revealBanner.Thickness = 0.11;
        revealBanner.Color = Color3.new(0, 0, 0);
    end;

    local Caption = p138.oddsButton:FindFirstChild("Caption");

    if Caption then
        Caption = Caption:FindFirstChild("UIStroke");
    end;

    if Caption then
        Caption.Thickness = 0.16;
        Caption.Color = Color3.new(0, 0, 0);
    end;

    p138.revealBanner.Position = UDim2.fromScale(0.5, 0.03);
    p138.revealName.Position = UDim2.fromScale(0.5, 0.93);
end;

function u1.next(p141) -- Line: 697
    return p141.stacks[1];
end;

function u1.available(p142) -- Line: 701
    -- upvalues: result (copy)
    local v143;

    if p142.remote == nil or p142.remote:GetAttribute("Live") ~= true then
        v143 = false;
    else
        v143 = not result.restricted();
    end;

    return v143;
end;

function u1.rowHeight(p144) -- Line: 707
    local math_floor_ret = math.floor((p144.stackList.AbsoluteSize.X - 12) / 3.1);

    return math.max(24, math_floor_ret);
end;

function u1.card(p145, p146, p147) -- Line: 712
    -- upvalues: PumpkinHuntConfig (copy), u5 (copy), rings (copy), u4 (copy), label (copy)
    local v148 = PumpkinHuntConfig.tier(p147.chance);
    local v149 = p145.cards[p146];

    if not v149 then
        local stackList = p145.stackList;
        local v150 = {
            BackgroundTransparency = 0.1,
            ZIndex = 4,
            Size = UDim2.new(1, 0, 0, p145:rowHeight()),
            BackgroundColor3 = u5.ink,
            LayoutOrder = p146
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Stack" .. p146;

        for i, v in v150 or {} do
            Frame[i] = v;
        end;

        Frame.Parent = stackList;
        local v151 = {
            CornerRadius = UDim.new(0.22, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i, v in v151 or {} do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame;
        local v152 = rings(Frame, v148.Color, 0.035, 0.025);
        local v153 = {
            ZIndex = 4,
            Position = UDim2.fromScale(0.15, 0.5),
            Size = UDim2.fromScale(0.36, 1.1),
            Image = u4.Glow or "Glow"
        };
        v153.ScaleType = v153.ScaleType or Enum.ScaleType.Fit;
        v153.AnchorPoint = v153.AnchorPoint or Vector2.new(0.5, 0.5);
        v153.BorderSizePixel = 0;
        v153.Active = false;
        v153.Interactable = false;
        v153.BackgroundTransparency = 1;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Glow";

        for i, v in v153 or {} do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = Frame;
        local v154 = {
            ZIndex = 5,
            Position = UDim2.fromScale(0.15, 0.5),
            Size = UDim2.fromScale(0.24, 0.78),
            Image = u4.Pumpkin or "Pumpkin"
        };
        v154.ScaleType = v154.ScaleType or Enum.ScaleType.Fit;
        v154.AnchorPoint = v154.AnchorPoint or Vector2.new(0.5, 0.5);
        v154.BorderSizePixel = 0;
        v154.Active = false;
        v154.Interactable = false;
        v154.BackgroundTransparency = 1;
        local ImageLabel2 = Instance.new("ImageLabel");
        ImageLabel2.Name = "Pumpkin";

        for i, v in v154 or {} do
            ImageLabel2[i] = v;
        end;

        ImageLabel2.Parent = Frame;
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint.Name = "Square";

        for i, v in {
            AspectRatio = 1
        } or {} do
            UIAspectRatioConstraint[i] = v;
        end;

        UIAspectRatioConstraint.Parent = ImageLabel2;
        v149 = {
            frame = Frame,
            ring = v152,
            glow = ImageLabel,
            icon = ImageLabel2,
            count = label(Frame, "Count", "", {
                ZIndex = 6,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.fromScale(0.95, 0.5),
                Size = UDim2.fromScale(0.17, 0.42),
                TextXAlignment = Enum.TextXAlignment.Right
            }, 0.1),
            name = label(Frame, "Tier", "", {
                ZIndex = 6,
                AnchorPoint = Vector2.new(0, 0),
                Position = UDim2.fromScale(0.31, 0.14),
                Size = UDim2.fromScale(0.44, 0.36),
                TextXAlignment = Enum.TextXAlignment.Left
            }, 0.1),
            chance = label(Frame, "Chance", "", {
                ZIndex = 6,
                AnchorPoint = Vector2.new(0, 0),
                Position = UDim2.fromScale(0.31, 0.53),
                Size = UDim2.fromScale(0.44, 0.3),
                TextColor3 = Color3.fromRGB(226, 214, 255),
                TextXAlignment = Enum.TextXAlignment.Left
            }, 0.1)
        };
        p145.cards[p146] = v149;
    end;

    v149.frame.Visible = true;
    v149.ring.Color = v148.Color;
    v149.glow.ImageColor3 = v148.Color;
    v149.glow.ImageTransparency = 0.8 - 0.55 * ((p147.chance - PumpkinHuntConfig.KnifeChanceMin) / math.max(1, PumpkinHuntConfig.KnifeChanceMax - PumpkinHuntConfig.KnifeChanceMin));
    v149.count.Text = "x" .. p147.count;
    v149.name.Text = string.upper(v148.Name);
    v149.name.TextColor3 = v148.Color;
    v149.chance.Text = (p146 == 1 and "NEXT · " or "") .. PumpkinHuntConfig.chanceText(p147.chance) .. " knife";
    v149.ring.Thickness = p146 == 1 and 0.045 or 0.025;
end;

function u1.refresh(p155) -- Line: 747
    -- upvalues: PumpkinHuntConfig (copy), rarityColor (copy), u5 (copy), setLook (copy)
    if not (p155.frame and p155.frame.Parent) then
        return;
    end;

    local v156 = p155:next();

    if p155.float and (p155.shown and not (v156 or (not p155.hadPumpkins or p155.opening))) then
        p155:outOfPumpkins();

        return;
    end;

    for i, v in p155.stacks do
        p155:card(i, v);
    end;

    for i = #p155.stacks + 1, #p155.cards do
        p155.cards[i].frame.Visible = false;
        local _ = i;
    end;

    local v157 = v156 and v156.chance or PumpkinHuntConfig.KnifeChanceMin;
    local v158 = PumpkinHuntConfig.tier(v157);
    local v159 = PumpkinHuntConfig.slots(v157);
    local v160 = PumpkinHuntConfig.percents(v159);

    for i, v in v159 do
        local v161 = p155.rows[v.id];

        if v161 then
            local percent = v161.percent;
            local v162;

            if v161.knife then
                v162 = PumpkinHuntConfig.chanceText(v160[i]);
            else
                v162 = PumpkinHuntConfig.percentText(v160[i]);
            end;

            percent.Text = v162;
            local percent2 = v161.percent;
            local v163;

            if v161.knife then
                v163 = v158.Color;
            else
                v163 = rarityColor(v160[i]);
            end;

            percent2.TextColor3 = v163;

            if v161.knife then
                v161.ring.Color = v158.Color;
            end;
        end;
    end;

    p155.glow = not v156 and 0 or 0.3 + 0.7 * ((v157 - PumpkinHuntConfig.KnifeChanceMin) / math.max(1, PumpkinHuntConfig.KnifeChanceMax - PumpkinHuntConfig.KnifeChanceMin));
    p155.halo.ImageColor3 = v158.Color;
    p155.eyes.ImageColor3 = v158.Color:Lerp(u5.gold, 0.5);
    p155.pumpkin.ImageTransparency = v156 and 0 or 0.6;
    p155.nextTag.Visible = false;

    if v156 then
        p155.tierText.Text = "NEXT · " .. string.upper(v158.Name) .. " PUMPKIN";
        p155.tierText.TextColor3 = v158.Color;
        p155.chanceText.Text = PumpkinHuntConfig.chanceText(v157) .. " KNIFE CHANCE";
        p155.chanceText.TextColor3 = v158.Color;
    else
        p155.tierText.Text = "NO PUMPKINS YET";
        p155.tierText.TextColor3 = u5.mist;
        p155.chanceText.Text = "Earn them in a Pumpkin Hunt!";
        p155.chanceText.TextColor3 = u5.mist;
    end;

    p155.leftText.Text = p155.total == 1 and "1 pumpkin" or p155.total .. " pumpkins";
    p155.oddsTitle.Text = v156 and "INSIDE YOUR NEXT PUMPKIN" or "INSIDE A PUMPKIN";
    local v164 = p155.opening ~= nil;
    local v165;

    if v156 == nil then
        v165 = not v164;
    else
        v165 = false;
    end;

    p155.halo.Visible = false;
    p155.moonGlow.Visible = false;
    p155.stacksTitle.Visible = not v165;
    p155.oddsButton.Visible = not v165;

    if v165 then
        p155.odds.Visible = false;
    end;

    p155.openButton.Visible = not v165;
    local closeButton = p155.closeButton;
    local v166;

    if v165 then
        v166 = UDim2.fromScale(0.5, 0.945);
    else
        v166 = UDim2.fromScale(0.654, 0.945);
    end;

    closeButton.Position = v166;
    local closeButton2 = p155.closeButton;
    local v167;

    if v165 then
        v167 = UDim2.fromScale(0.182, 0.086);
    else
        v167 = UDim2.fromScale(0.09, 0.061);
    end;

    closeButton2.Size = v167;
    p155.closeButton:FindFirstChild("TextLabel").Text = v165 and "CLOSE" or "Close";
    p155.openButton:FindFirstChild("TextLabel").Text = v164 and "OPENING..." or "OPEN";
    local openButton = p155.openButton;
    local v168;

    if v156 == nil then
        v168 = false;
    else
        v168 = not v164;
    end;

    openButton.Interactable = v168;
    openButton.AutoButtonColor = v168;
    setLook(openButton, v168 and "pumpkin" or "grey");

    if p155.float and (p155.shown and not v164) then
        if v156 then
            p155.hadPumpkins = true;
        end;

        if v156 then
            v156 = v156.chance;
        end;

        p155.float:present(v156);
    end;
end;

function u1.lastOne(p169) -- Line: 826
    local pending = p169.pending;

    if pending and type(pending.total) == "number" then
        return pending.total <= 0;
    end;

    return p169.total <= 1;
end;

function u1.fadeAway(p170) -- Line: 835
    -- upvalues: PumpkinFloat (copy)
    if p170.fadeRestore then
        return;
    end;

    p170.fadeRestore = PumpkinFloat.fade(p170.frame, 0.8);

    if p170.float then
        p170.float:fadeAway(0.8);
    end;

    task.wait(0.8);
end;

function u1.outOfPumpkins(u171) -- Line: 847
    if u171.leavingEmpty then
        return;
    end;

    u171.leavingEmpty = true;
    task.spawn(function() -- Line: 852
        -- upvalues: u171 (copy)
        u171:fadeAway();
        u171.leavingEmpty = nil;

        if u171.shown and u171.host then
            u171.host.close();
        end;
    end);
end;

function u1.say(p172, p173) -- Line: 861
    p172.status.Text = p173 or "";
    p172.statusAt = os.clock();
end;

function u1.openNext(u174) -- Line: 869
    -- upvalues: u1 (copy), LocalPlayer (copy), u6 (copy)
    if u174.opening then
        return;
    end;

    if not u174:available() then
        u1.notice(u1.UNAVAILABLE);
        u174.host.close();

        return;
    end;

    if LocalPlayer:GetAttribute("InMatch") == true then
        u174:say(u6.InMatch);

        return;
    end;

    if not u174:next() then
        u174:say(u6.NoPumpkins);

        return;
    end;

    u174.opening = {
        at = os.clock()
    };
    u174:say("");
    u174:refresh();
    u174.remote:FireServer("Open");

    if u174.float then
        u174.float:anticipate();
    end;

    local opening = u174.opening;
    task.delay(10, function() -- Line: 896
        -- upvalues: u174 (copy), opening (copy), u6 (ref)
        if u174.opening == opening and not opening.result then
            u174.opening = nil;

            if u174.float then
                u174.float:settle();
            end;

            u174:say(u6.Slow);
            u174:refresh();
            u174:lobbyCheck();
        end;
    end);
end;

local Vector2_new_ret = Vector2.new(0.5, 0.52);

function u1.spark(p175, p176, p177, p178, p179, p180, p181) -- Line: 913
    -- upvalues: TweenService (copy)
    local fxLayer = p175.fxLayer;
    local v182 = {
        Rotation = 45,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(p176.X, p176.Y),
        Size = UDim2.fromScale(p180, p180),
        BackgroundColor3 = p178,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Spark";

    for i, v in v182 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = fxLayer;
    local v183 = {
        CornerRadius = UDim.new(0.3, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v183 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    TweenService:Create(Frame, TweenInfo.new(p179, p181 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.9,
        Position = UDim2.fromScale(p177.X, p177.Y),
        Size = UDim2.fromScale(p180 * 0.35, p180 * 0.35),
        Rotation = 45 + math.random(-200, 200)
    }):Play();
    task.delay(p179, function() -- Line: 929
        -- upvalues: Frame (copy)
        Frame:Destroy();
    end);
end;

function u1.beam(p184, p185, p186) -- Line: 934
    -- upvalues: Vector2_new_ret (copy), TweenService (copy)
    local backFx = p184.backFx;
    local v187 = {
        BackgroundTransparency = 1,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y),
        Size = UDim2.fromScale(1.35, 1.35),
        Rotation = p185,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Beam";

    for i, v in v187 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = backFx;
    local v188 = {
        ZIndex = 4,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0, 0.025),
        BackgroundColor3 = p186,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Ray";

    for i, v in v188 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v189 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v189 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame2;
    local v190 = {
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "Fade";

    for i, v in v190 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame2;
    TweenService:Create(Frame2, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.5, 0.045)
    }):Play();

    return Frame;
end;

function u1.shockwave(p191, p192, p193) -- Line: 958
    -- upvalues: Vector2_new_ret (copy), TweenService (copy)
    local fxLayer = p191.fxLayer;
    local v194 = {
        BackgroundTransparency = 1,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y),
        Size = UDim2.fromScale(0.3, 0.3),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Shockwave";

    for i, v in v194 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = fxLayer;
    local v195 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v195 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Ring";

    for i, v in {
        Thickness = 10,
        Transparency = 0,
        Color = p192
    } or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    TweenService:Create(Frame, TweenInfo.new(p193, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(1.9, 1.9)
    }):Play();
    TweenService:Create(UIStroke, TweenInfo.new(p193, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Transparency = 1,
        Thickness = 2
    }):Play();
    task.delay(p193, function() -- Line: 970
        -- upvalues: Frame (copy)
        Frame:Destroy();
    end);
end;

function u1.shake(u196, u197, u198) -- Line: 975
    -- upvalues: RunService (copy)
    local stage = u196.stage;
    local u199 = u196.stageHome or stage.Position;
    u196.stageHome = u199;
    local os_clock_ret = os.clock();
    local u200 = nil;
    u200 = RunService.RenderStepped:Connect(function() -- Line: 981
        -- upvalues: os_clock_ret (copy), u197 (copy), u196 (copy), u200 (ref), stage (copy), u199 (copy), u198 (copy)
        local v201 = (os.clock() - os_clock_ret) / u197;

        if v201 >= 1 or not u196.frame then
            u200:Disconnect();
            stage.Position = u199;

            return;
        end;

        local v202 = u198 * (1 - v201);
        stage.Position = u199 + UDim2.fromScale((math.random() - 0.5) * v202, (math.random() - 0.5) * v202 * 1.6);
    end);
end;

function u1.reveal2D(u203, p204) -- Line: 994
    -- upvalues: rarityOf (copy), play (copy), u5 (copy), RunService (copy), Vector2_new_ret (copy), TweenService (copy)
    local _, v205, v206 = rarityOf(p204);
    local stage = u203.stage;
    u203.stageHome = u203.stageHome or stage.Position;
    local stageHome = u203.stageHome;
    local glow = u203.glow;
    u203.shaking = false;
    u203.eyes.Visible = false;
    local os_clock_ret = os.clock();
    local u207 = {};
    local u208 = 0.2;
    local u209 = 0;
    local u210 = 0;
    local u211 = 0.42;
    play("Tell", 0.55);
    local u212 = { u5.pumpkin, u5.ember, u5.gold };
    local u213 = nil;
    u213 = RunService.RenderStepped:Connect(function() -- Line: 1013
        -- upvalues: u203 (copy), u213 (ref), os_clock_ret (copy), stage (copy), stageHome (copy), u208 (ref), u207 (copy), u212 (copy), u209 (ref), Vector2_new_ret (ref), u210 (ref), u211 (ref), play (ref)
        if not u203.frame then
            u213:Disconnect();

            return;
        end;

        local v214 = os.clock() - os_clock_ret;
        local math_clamp_ret = math.clamp(v214 / 1.8, 0, 1);
        local os_clock_ret2 = os.clock();
        u203.pumpkin.Rotation = math.sin(os_clock_ret2 * (math_clamp_ret * 40 + 28)) * (math_clamp_ret * 14 * math_clamp_ret + 2);
        u203.pumpkinScale.Scale = math_clamp_ret * 0.08 + 1 + math_clamp_ret * 0.04 * math.sin(os_clock_ret2 * 30);
        u203.stageScale.Scale = math_clamp_ret * 0.14 + 1;
        stage.Position = stageHome + UDim2.fromScale((math.random() - 0.5) * 0.004 * math_clamp_ret, (math.random() - 0.5) * 0.007 * math_clamp_ret);
        u203.glow = math_clamp_ret * 0.55 + 0.45;

        if u208 <= v214 and #u207 < 9 then
            u208 = u208 + 0.17;
            local math_random_ret = math.random(0, 359);
            local v215 = u212[math.random(1, #u212)];
            table.insert(u207, u203:beam(math_random_ret, v215));
        end;

        if u209 <= v214 then
            u209 = u209 + 0.06;
            local v216 = math.random() * 3.141592653589793 * 2;
            u203:spark(Vector2_new_ret + Vector2.new(math.cos(v216), (math.sin(v216))) * (0.75 + math.random() * 0.25), Vector2_new_ret, u212[math.random(1, #u212)], 0.45, 0.035, Enum.EasingStyle.Quad);
        end;

        if u210 <= v214 then
            u210 = u210 + u211;
            u211 = math.max(0.12, u211 * 0.8);
            play("HeadPop", math_clamp_ret * 0.3 + 0.25, math_clamp_ret * 0.8 + 0.7);
        end;
    end);
    task.wait(1.8);
    u213:Disconnect();

    if not u203.frame then
        return;
    end;

    stage.Position = stageHome;
    u203.pumpkin.Rotation = 0;

    for _, v in u207 do
        v:Destroy();
    end;

    play("HeadPop", 1, 0.75);
    play("Sacrifice", 0.7);
    play("AnkleBreak", 0.5, 1.3);
    u203.pumpkinScale.Scale = 0;
    u203.bigFlash.BackgroundColor3 = v205:Lerp(u5.white, 0.55);
    u203.bigFlash.BackgroundTransparency = 0.05;
    TweenService:Create(u203.bigFlash, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    u203:shockwave(v205, 0.7);

    if v206 >= 2 then
        task.delay(0.12, function() -- Line: 1066
            -- upvalues: u203 (copy), u5 (ref)
            u203:shockwave(u5.white, 0.6);
        end);
    end;

    for i = 1, 14 do
        local v217 = i / 14 * 3.141592653589793 * 2 + math.random() * 0.4;
        local v218 = 0.55 + math.random() * 0.5;
        local v219;

        if i % 3 == 0 then
            v219 = u5.ember;
        elseif i % 3 == 1 then
            v219 = u5.pumpkin;
        else
            v219 = Color3.fromRGB(200, 90, 20);
        end;

        u203:spark(Vector2_new_ret, Vector2_new_ret + Vector2.new(math.cos(v217), (math.sin(v217))) * v218, v219, 0.35 + math.random() * 0.15, 0.07 + math.random() * 0.05);
        local _ = i;
    end;

    for i = 1, 22 do
        local v220 = math.random() * 3.141592653589793 * 2;
        u203:spark(Vector2_new_ret, Vector2_new_ret + Vector2.new(math.cos(v220), (math.sin(v220))) * (0.8 + math.random() * 0.6), v205, 0.7, 0.03);
        local _ = i;
    end;

    u203:shake(0.45, 0.02 + 0.006 * v206);
    TweenService:Create(u203.stageScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    u203.glow = glow;
    task.wait(0.1);
    u203:showPrize(p204);
    task.wait(v206 >= 3 and 3.2 or (v206 >= 2 and 2.8 or 2.4));
    u203:hidePrize();
end;

function u1.showPrize(u221, p222, p223) -- Line: 1092
    -- upvalues: rarityOf (copy), prizeIcon (copy), SkinCatalog (copy), PumpkinHuntConfig (copy), u5 (copy), TweenService (copy), play (copy), RunService (copy)
    for _, child in u221.revealIcon:GetChildren() do
        if not (child:IsA("UIScale") or child:IsA("UIAspectRatioConstraint")) then
            child:Destroy();
        end;
    end;

    local v224, u225, u226 = rarityOf(p222);
    local u227;

    if u221.float == nil then
        u227 = false;
    else
        u227 = not p223;
    end;

    u221.revealIcon.Visible = not u227;
    u221.revealRays.Visible = not u227;
    u221.revealRays2.Visible = not u227;

    if u227 then
        u221.float:reward(p222, u225, u226);
    else
        prizeIcon(u221.revealIcon, p222.kind);
    end;

    local v228;

    if p222.kind == "Knife" then
        local v229 = SkinCatalog.get(p222.knife or PumpkinHuntConfig.Knife);
        v228 = string.upper(v229 and v229.Name or PumpkinHuntConfig.Knife);

        if p222.duplicateGems then
            v228 = v228 .. "  (+" .. p222.duplicateGems .. " GEMS)";
        end;
    else
        v228 = string.upper(p222.name or "");
    end;

    local revealName = u221.revealName;
    local v230;

    if p222.kind == "Knife" then
        v230 = PumpkinHuntConfig.tier(p222.chance or PumpkinHuntConfig.KnifeChanceMin).Color;
    else
        v230 = u225;
    end;

    revealName.TextColor3 = v230;
    u221.reveal.Visible = true;
    u221.showing = (u221.showing or 0) + 1;
    local showing = u221.showing;
    u221.revealRays.ImageColor3 = u225;
    u221.revealRays2.ImageColor3 = u225:Lerp(u5.white, 0.4);
    u221.revealRays.Size = UDim2.fromScale(0, 0);
    u221.revealRays2.Size = UDim2.fromScale(0, 0);
    TweenService:Create(u221.revealRays, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.95 + 0.03 * u226, 0.95 + 0.03 * u226)
    }):Play();
    TweenService:Create(u221.revealRays2, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(1.1 + 0.02 * u226, 1.1 + 0.02 * u226)
    }):Play();
    u221.tierText.Visible = false;
    u221.chanceText.Visible = false;
    u221.leftText.Visible = false;
    u221.revealScale.Scale = 0;
    u221.revealIcon.Position = UDim2.fromScale(0.5, 0.52);
    TweenService:Create(u221.revealScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();

    if u221.bob then
        u221.bob:Cancel();
    end;

    u221.bob = TweenService:Create(u221.revealIcon, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Position = UDim2.fromScale(0.5, 0.48)
    });
    task.delay(0.5, function() -- Line: 1145
        -- upvalues: u221 (copy), showing (copy)
        if u221.showing == showing and u221.bob then
            u221.bob:Play();
        end;
    end);

    if u227 then
        u221.float:landed(u226);
    else
        play("Collect", 0.9);

        if u226 >= 3 then
            task.delay(0.28, function() -- Line: 1156
                -- upvalues: play (ref)
                play("Collect", 0.7, 1.3);
            end);
        end;
    end;

    u221.revealBanner.Text = v224 .. "!";
    u221.revealBanner.TextColor3 = u225;
    u221.revealBanner.Visible = false;
    task.delay(0.18, function() -- Line: 1165
        -- upvalues: u221 (copy), showing (copy), TweenService (ref), u227 (copy), play (ref)
        if u221.showing ~= showing then
            return;
        end;

        u221.revealBanner.Visible = true;
        u221.bannerScale.Scale = 2.8;
        u221.revealBanner.Rotation = -10;
        TweenService:Create(u221.bannerScale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
        TweenService:Create(u221.revealBanner, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Rotation = 0
        }):Play();

        if u227 and u221.float then
            u221.float:slam();

            return;
        end;

        play("HeadPop", 0.6, 0.6);
    end);
    local u231 = tonumber(p222.amount);
    local u232 = p222.kind == "Gems" and " GEMS!" or (p222.kind == "CandyCorn" and " CANDY CORN!" or (p222.kind == "GhostKeys" and (u231 == 1 and " GHOST KEY!" or " GHOST KEYS!") or nil));

    if u232 and (u231 and u231 > 0) then
        task.spawn(function() -- Line: 1187
            -- upvalues: u221 (copy), showing (copy), u231 (copy), u232 (copy), RunService (ref)
            local os_clock_ret = os.clock();

            while u221.showing == showing do
                local v233 = (os.clock() - os_clock_ret) / 0.7;
                local math_clamp_ret = math.clamp(v233, 0, 1);
                u221.revealName.Text = "+" .. math.floor(u231 * (1 - (1 - math_clamp_ret) ^ 3) + 0.5) .. u232;

                if math_clamp_ret >= 1 then
                    break;
                end;

                RunService.RenderStepped:Wait();
            end;
        end);
    else
        u221.revealName.Text = v228 .. "!";
    end;

    task.spawn(function() -- Line: 1203
        -- upvalues: u221 (copy), showing (copy), u227 (copy), u5 (ref), u225 (copy), TweenService (ref), u226 (copy)
        while u221.showing == showing and (u221.frame and not u227) do
            local v234 = math.random() * 3.141592653589793 * 2;
            local v235 = Vector2.new(0.5, 0.52) + Vector2.new(math.cos(v234), (math.sin(v234))) * (0.3 + math.random() * 0.2);
            local reveal = u221.reveal;
            local v236 = {
                Rotation = 45,
                ZIndex = 9,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(v235.X, v235.Y),
                Size = UDim2.fromScale(0, 0)
            };
            local v237;

            if math.random() < 0.5 then
                v237 = u5.white;
            else
                v237 = u225;
            end;

            v236.BackgroundColor3 = v237;
            v236.BorderSizePixel = 0;
            v236.Active = false;
            v236.Interactable = false;
            local Frame = Instance.new("Frame");
            Frame.Name = "Twinkle";

            for i, v in v236 or {} do
                Frame[i] = v;
            end;

            Frame.Parent = reveal;
            local v238 = {
                CornerRadius = UDim.new(0.25, 0)
            };
            local UICorner = Instance.new("UICorner");
            UICorner.Name = "UICorner";

            for i, v in v238 or {} do
                UICorner[i] = v;
            end;

            UICorner.Parent = Frame;
            local v239 = 0.025 + math.random() * 0.025;
            TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(v239, v239)
            }):Play();
            task.delay(0.3, function() -- Line: 1218
                -- upvalues: TweenService (ref), Frame (copy)
                TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Size = UDim2.fromScale(0, 0)
                }):Play();
                task.delay(0.36, function() -- Line: 1220
                    -- upvalues: Frame (ref)
                    Frame:Destroy();
                end);
            end);
            task.wait(0.14 - 0.02 * u226);
        end;
    end);
end;

function u1.hidePrize(p240) -- Line: 1229
    -- upvalues: TweenService (copy)
    p240.showing = (p240.showing or 0) + 1;

    if p240.bob then
        p240.bob:Cancel();
        p240.bob = nil;
    end;

    p240.revealBanner.Visible = false;
    p240.reveal.Visible = false;
    p240.eyes.Visible = false;

    if p240.float then
        p240.float:clearReward();
    end;

    p240.tierText.Visible = true;
    p240.chanceText.Visible = true;
    p240.leftText.Visible = true;
    p240.revealIcon.Position = UDim2.fromScale(0.5, 0.52);
    p240.pumpkinScale.Scale = 0;
    TweenService:Create(p240.pumpkinScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
end;

function u1.revealFloat(u241, p242) -- Line: 1252
    -- upvalues: rarityOf (copy), u5 (copy), TweenService (copy)
    local float = u241.float;
    local _, v243, v244 = rarityOf(p242);

    if not float:ready() then
        u241:showPrize(p242, true);
        task.wait(2.4);
        u241:hidePrize();

        return true;
    end;

    if not float:burst(v243, v244) then
        return false;
    end;

    local token = float.token;

    if not u241.frame then
        return false;
    end;

    u241.bigFlash.BackgroundColor3 = v243:Lerp(u5.white, 0.55);
    u241.bigFlash.BackgroundTransparency = 0.2;
    TweenService:Create(u241.bigFlash, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    u241:shockwave(v243, 0.7);

    if v244 >= 2 then
        task.delay(0.12, function() -- Line: 1275
            -- upvalues: u241 (copy), u5 (ref)
            u241:shockwave(u5.white, 0.6);
        end);
    end;

    task.wait(0.1);

    if float.token ~= token or not u241.frame then
        return false;
    end;

    u241:showPrize(p242);
    local os_clock_ret = os.clock();

    while os.clock() - os_clock_ret < (v244 >= 3 and 3.6 or (v244 >= 2 and 3.1 or 2.7)) do
        task.wait(0.05);

        if float.token ~= token or not u241.frame then
            u241:hidePrize();

            return false;
        end;
    end;

    if u241.opening then
        u241.opening.seen = true;
    end;

    if u241:lastOne() then
        u241:fadeAway();

        if u241.shown and u241.host then
            u241.host.close();
        end;

        return true;
    end;

    u241:hidePrize();
    task.wait(0.22);

    return true;
end;

function u1.reveal3D(p245, p246) -- Line: 1312
    -- upvalues: TweenService (copy), ReplicatedStorage (copy), PumpkinHuntConfig (copy), LocalPlayer (copy), label (copy), u5 (copy), Font_fromEnum_ret (copy), rings (copy), u4 (copy), play (copy), UserInputService (copy), RunService (copy), SkinCatalog (copy), Weapons (copy)
    local host = p245.host;
    p245.hidden = true;
    TweenService:Create(p245.pop, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Scale = 0
    }):Play();

    if host.setHidden then
        host.setHidden(true, 0.3);
    end;

    task.wait(0.3);
    local PumpkinHuntAssets = ReplicatedStorage:FindFirstChild("PumpkinHuntAssets");

    if PumpkinHuntAssets then
        PumpkinHuntAssets = PumpkinHuntAssets:FindFirstChild("Pumpkin");
    end;

    local v247 = PumpkinHuntConfig.tier(p246.chance or PumpkinHuntConfig.KnifeChanceMin);
    local Folder = Instance.new("Folder");
    Folder.Name = "PumpkinOpening";
    Folder.Parent = workspace.CurrentCamera;
    local u248;

    if PumpkinHuntAssets then
        u248 = PumpkinHuntAssets:Clone();
    else
        u248 = Instance.new("Model");
    end;

    for _, descendant in u248:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
        end;
    end;

    u248.Parent = Folder;
    local v249 = u248.PrimaryPart or u248:FindFirstChildWhichIsA("BasePart");
    local u250 = {};

    for _, descendant in u248:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Material == Enum.Material.Neon then
            table.insert(u250, descendant);
        end;
    end;

    local v251 = not v249 and Vector3.new(2.7, 2.3, 2.7) or v249.Size;
    local u252;

    if v249 then
        u252 = v249:FindFirstChildOfClass("SpecialMesh");
    else
        u252 = v249;
    end;

    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 230, 140), v247.Color);
    ParticleEmitter.LightEmission = 0.9;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.2) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 0.8);
    ParticleEmitter.Speed = NumberRange.new(3, 6);
    ParticleEmitter.SpreadAngle = Vector2.new(25, 25);
    ParticleEmitter.Rate = 15;
    local v253;

    if v249 then
        v253 = v249:FindFirstChild("Flame");
    else
        v253 = v249;
    end;

    if not v253 and v249 then
        v253 = Instance.new("Attachment");
        v253.Position = Vector3.new(0, v251.Y / 2, 0);
        v253.Parent = v249;
    end;

    ParticleEmitter.Parent = v253;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = v247.Color;
    PointLight.Brightness = 1;
    PointLight.Range = 12;
    PointLight.Parent = v249;
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "PumpkinTap";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 120;
    ScreenGui:SetAttribute("SelfManagedText", true);
    ScreenGui:SetAttribute("CreatorCaptureExempt", true);
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
    local v254 = label(ScreenGui, "Tap", "TAP! TAP! TAP!", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.78),
        Size = UDim2.fromScale(0.4, 0.07),
        TextColor3 = u5.gold
    }, 0.08, Font_fromEnum_ret);
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Pop";

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = v254;
    local v255 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.86),
        Size = UDim2.fromScale(0.34, 0.035),
        BackgroundColor3 = Color3.fromRGB(40, 28, 52)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Bar";

    for i, v in v255 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v256 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v256 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    rings(Frame, v247.Color, 0.1, 0.06);
    local v257 = {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = u5.white
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Fill";

    for i, v in v257 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v258 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v258 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v259 = {
        Color = ColorSequence.new(v247.Color, Color3.fromRGB(255, 240, 160))
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v259 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame2;
    local v260 = {
        ImageTransparency = 0.5,
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(0.25, 3),
        ImageColor3 = u5.ember,
        Image = u4.Glow or "Glow"
    };
    v260.ScaleType = v260.ScaleType or Enum.ScaleType.Fit;
    v260.AnchorPoint = v260.AnchorPoint or Vector2.new(0.5, 0.5);
    v260.BorderSizePixel = 0;
    v260.Active = false;
    v260.Interactable = false;
    v260.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Glow";

    for i, v in v260 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame;
    local u261 = 0;
    local u262 = 0;
    local os_clock_ret = os.clock();
    local u263 = false;
    local u264 = 0;

    local function addTap() -- Line: 1387
        -- upvalues: u263 (ref), u262 (ref), u261 (ref), u264 (ref), UIScale (copy), TweenService (ref), Frame2 (copy), play (ref)
        if u263 or os.clock() - u262 < 0.06 then
            return;
        end;

        u262 = os.clock();
        u261 = u261 + 1;
        u264 = 1;
        UIScale.Scale = 1.25;
        TweenService:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
        TweenService:Create(Frame2, TweenInfo.new(0.15), {
            Size = UDim2.fromScale(math.min(1, u261 / 8), 1)
        }):Play();
        play("Tell", u261 * 0.05 + 0.25);
    end;

    local v266 = UserInputService.InputBegan:Connect(function(p265) -- Line: 1399
        -- upvalues: addTap (copy)
        local UserInputType = p265.UserInputType;

        if UserInputType == Enum.UserInputType.MouseButton1 or (UserInputType == Enum.UserInputType.Touch or (p265.KeyCode == Enum.KeyCode.ButtonA or p265.KeyCode == Enum.KeyCode.ButtonR2)) then
            addTap();
        end;
    end);
    local v274 = RunService.RenderStepped:Connect(function(p267) -- Line: 1405
        -- upvalues: u261 (ref), u264 (ref), u248 (copy), u250 (copy), u252 (copy), ParticleEmitter (copy), PointLight (copy), ImageLabel (copy), u263 (ref), os_clock_ret (copy), u262 (ref), LocalPlayer (ref), TweenService (ref), Frame2 (copy)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local math_min_ret = math.min(1, u261 / 8);
        u264 = math.max(0, u264 - p267 * 6);
        local os_clock_ret2 = os.clock();
        local math_sin_ret = math.sin(os_clock_ret2 * 41);
        local math_sin_ret2 = math.sin(os_clock_ret2 * 37);
        local v268 = (math_min_ret * 0.12 + 0.03) * Vector3.new(math_sin_ret, math_sin_ret2, 0);
        local v269 = math.random() - 0.5;
        local v270 = math.random() - 0.5;
        local v271 = v268 + u264 * 0.15 * Vector3.new(v269, v270, 0);
        local v272 = math.sin(os_clock_ret2 * 2) * 0.15;
        u248:PivotTo(workspace_CurrentCamera.CFrame * CFrame.new(v271.X, v272 + -0.4 + v271.Y, -7) * CFrame.Angles(0, 3.141592653589793 + math.sin(os_clock_ret2 * 1.2) * 0.25, 0));
        u248:ScaleTo(u264 * 0.12 + 1 + math_min_ret * 0.1);
        local v273 = Color3.fromRGB(255, 196, 64):Lerp(Color3.fromRGB(255, 250, 225), math_min_ret);

        for _, v in u250 do
            v.Color = v273;
        end;

        if u252 then
            u252.VertexColor = (Vector3.new(1.2, 1.2, 1.2)):Lerp(Vector3.new(2.8, 2.1, 1.3), math_min_ret) + Vector3.new(0.6, 0.6, 0.6) * u264;
        end;

        ParticleEmitter.Rate = math_min_ret * 110 + 15;
        ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, math_min_ret * 2.2 + 1), NumberSequenceKeypoint.new(1, 0.2) });
        PointLight.Brightness = math_min_ret * 7 + 1 + u264 * 2;
        PointLight.Range = math_min_ret * 10 + 12;
        ImageLabel.Position = UDim2.fromScale(math.min(1, math_min_ret), 0.5);
        ImageLabel.ImageTransparency = 0.6 - math_min_ret * 0.5;

        if not (u263 or (u261 >= 8 or os.clock() - math.max(os_clock_ret, u262) <= 10 and LocalPlayer:GetAttribute("InMatch") ~= true)) then
            u261 = 8;
            TweenService:Create(Frame2, TweenInfo.new(0.3), {
                Size = UDim2.fromScale(1, 1)
            }):Play();
        end;

        if u261 >= 8 then
            u263 = true;
        end;
    end);

    while not u263 do
        task.wait();
    end;

    v266:Disconnect();
    v254.Text = "";
    task.wait(0.15);
    v274:Disconnect();
    local Pivot = u248:GetPivot();
    local os_clock_ret2 = os.clock();

    while os.clock() - os_clock_ret2 < 0.25 do
        local v275 = (os.clock() - os_clock_ret2) / 0.25;
        u248:ScaleTo(1.2 - 0.9 * v275 * v275);
        u248:PivotTo(Pivot);
        RunService.RenderStepped:Wait();
    end;

    u248:Destroy();
    play("HeadPop");
    play("Collect");
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = Pivot;
    Part.Parent = Folder;
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter2.Color = ColorSequence.new(v247.Color, u5.gold);
    ParticleEmitter2.LightEmission = 1;
    ParticleEmitter2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter2.Lifetime = NumberRange.new(0.5, 1);
    ParticleEmitter2.Speed = NumberRange.new(10, 22);
    ParticleEmitter2.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter2.Enabled = false;
    ParticleEmitter2.Parent = Part;
    ParticleEmitter2:Emit(60);
    local PointLight2 = Instance.new("PointLight");
    PointLight2.Color = u5.gold;
    PointLight2.Brightness = 10;
    PointLight2.Range = 24;
    PointLight2.Parent = Part;
    TweenService:Create(PointLight2, TweenInfo.new(0.6), {
        Brightness = 0
    }):Play();
    local v276 = SkinCatalog.get(p246.knife or PumpkinHuntConfig.Knife);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        if v276 then
            Models = Models:FindFirstChild(v276.Model);
        else
            Models = v276;
        end;
    end;

    if Models then
        Models = Models:Clone();
    end;

    local Part2 = Instance.new("Part");
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.Transparency = 1;
    Part2.Size = Vector3.new(1, 1, 1);
    Part2.Parent = Folder;

    if Models then
        for _, descendant in Models:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
            elseif descendant:IsA("LuaSourceContainer") then
                descendant:Destroy();
            end;
        end;

        if Models:IsA("BasePart") then
            Models.Anchored = true;
            Models.CanCollide = false;
        end;

        Models.Parent = Folder;
    end;

    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Size = UDim2.fromScale(7, 2.2);
    BillboardGui.StudsOffset = Vector3.new(0, 2.6, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.Adornee = Part2;
    BillboardGui.Parent = Part2;
    label(BillboardGui, "Name", string.upper(v276 and v276.Name or PumpkinHuntConfig.Knife), {
        Size = UDim2.fromScale(1, 0.6),
        TextColor3 = v247.Color
    }, 0.08, Font_fromEnum_ret);
    local v277;

    if p246.duplicateGems then
        v277 = "Already yours: +" .. p246.duplicateGems .. " gems";
    else
        v277 = PumpkinHuntConfig.chanceText(p246.chance or PumpkinHuntConfig.KnifeChanceMin) .. " chance";
    end;

    label(BillboardGui, "Odds", v277, {
        Position = UDim2.fromScale(0, 0.6),
        Size = UDim2.fromScale(1, 0.4),
        TextColor3 = u5.white
    }, 0.1);
    local u278 = 0;
    local v282 = RunService.RenderStepped:Connect(function(p279) -- Line: 1523
        -- upvalues: u278 (ref), Part2 (copy), Models (copy)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        u278 = math.min(1, u278 + p279 * 3);
        local os_clock_ret3 = os.clock();
        local v280 = workspace_CurrentCamera.CFrame * CFrame.new(0, math.sin(os_clock_ret3 * 2) * 0.12 + -0.2, -6);
        Part2.CFrame = v280;

        if Models then
            local v281 = v280 * CFrame.Angles(0, os_clock_ret3 * 1.4, 0.3490658503988659);

            if Models:IsA("Model") then
                Models:PivotTo(v281);
                Models:ScaleTo((math.max(0.05, u278 * 1.4)));

                return;
            end;

            Models.CFrame = v281;
        end;
    end);
    task.wait(3.6);
    v282:Disconnect();
    ScreenGui:Destroy();
    Folder:Destroy();
    p245.hidden = false;

    if host.setHidden then
        host.setHidden(false, 0.35);
    end;

    TweenService:Create(p245.pop, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    p245.pumpkinScale.Scale = 0;
    p245:showPrize(p246);
    task.wait(2.2);
    p245:hidePrize();
end;

function u1.played(u283, p284) -- Line: 1559
    -- upvalues: LocalPlayer (copy), u1 (copy), SkinCatalog (copy), PumpkinHuntConfig (copy)
    local function settle() -- Line: 1560
        -- upvalues: u283 (copy)
        u283.opening = nil;

        if u283.pending then
            u283:apply(u283.pending);
            u283.pending = nil;
        end;

        u283:refresh();
        u283:lobbyCheck();
    end;

    local v285 = u283.host and u283.host.isOpen();

    if not v285 or LocalPlayer:GetAttribute("InMatch") == true then
        local notice = u1.notice;
        local v286;

        if p284.kind == "Knife" then
            local v287 = SkinCatalog.get(p284.knife or PumpkinHuntConfig.Knife);
            v286 = v287 and v287.Name or PumpkinHuntConfig.Knife;

            if p284.duplicateGems then
                v286 = v286 .. " (already yours, so +" .. p284.duplicateGems .. " gems)";
            end;
        else
            v286 = tostring(p284.name or "a prize");
        end;

        notice("Your pumpkin gave you " .. v286 .. "!");
        u283.opening = nil;

        if u283.pending then
            u283:apply(u283.pending);
            u283.pending = nil;
        end;

        u283:refresh();
        u283:lobbyCheck();

        return;
    end;

    local opening = u283.opening;

    if not opening then
        opening = {
            at = os.clock()
        };
        u283.opening = opening;
        u283:say("");
    end;

    opening.result = p284;
    local v288 = true;

    if u283.float then
        v288 = u283:revealFloat(p284);
    else
        local _ = p284.kind == "Knife";
        u283:reveal2D(p284);
    end;

    if not (v288 and (u283.host.isOpen() or opening.seen)) then
        local notice = u1.notice;
        local v289;

        if p284.kind == "Knife" then
            local v290 = SkinCatalog.get(p284.knife or PumpkinHuntConfig.Knife);
            v289 = v290 and v290.Name or PumpkinHuntConfig.Knife;

            if p284.duplicateGems then
                v289 = v289 .. " (already yours, so +" .. p284.duplicateGems .. " gems)";
            end;
        else
            v289 = tostring(p284.name or "a prize");
        end;

        notice("Your pumpkin gave you " .. v289 .. "!");
    end;

    u283.opening = nil;

    if u283.pending then
        u283:apply(u283.pending);
        u283.pending = nil;
    end;

    u283:refresh();
    u283:lobbyCheck();
end;

function u1.lobbyCheck(p291) -- Line: 1599
    if p291.checkLobby then
        p291.checkLobby();
    end;
end;

function u1.apply(p292, p293) -- Line: 1605
    -- upvalues: result (copy), u1 (copy)
    p292.stacks = type(p293.stacks) ~= "table" and {} or p293.stacks;
    p292.total = type(p293.total) ~= "number" and 0 or p293.total;

    if p292.host and p292.host.setCount then
        p292.host.setCount(result.restricted() and 0 or p292.total);
    end;

    local total = p292.total;
    local v294 = result.restricted() and 0 or total;
    u1.count = v294;
    u1.counted:Fire(v294);
end;

function u1.animate(p295, p296) -- Line: 1614
    local os_clock_ret = os.clock();

    for _, v in {} do
        local math_sin_ret = math.sin(os_clock_ret * v.speed * 3.141592653589793 + v.phase);
        local v297 = math.abs(math_sin_ret) * 0.35 + 0.65;
        v.image.Size = UDim2.fromScale(v.size, v.size * 2.1 * v297);
        v.image.Position = UDim2.fromScale(v.x + math.sin(os_clock_ret * 0.4 + v.phase) * 0.02, v.y + math.sin(os_clock_ret * 0.9 + v.phase) * 0.01);
    end;

    for _, v in {} do
        local v298 = 1 - (os_clock_ret * v.speed + v.phase) % 1;
        v.frame.Position = UDim2.fromScale(v.x + math.sin(os_clock_ret + v.phase) * 0.01, v298);
        v.frame.BackgroundTransparency = 0.2 + 0.7 * (1 - v298);
    end;

    local v299 = p295.glow or 0;

    if p295.shaking then
        p295.pumpkin.Rotation = math.sin(os_clock_ret * 40) * 10;
        v299 = math.min(1, v299 + 0.4);
    end;

    local v300 = math.sin(os_clock_ret * 13) * 0.06 + math.sin(os_clock_ret * 7.3) * 0.04;
    p295.eyes.ImageTransparency = 1 - math.clamp(v299 * (v300 + 0.85), 0, 1);
    p295.halo.ImageTransparency = 1 - math.clamp(0.3 + v299 * 0.5, 0, 1);
    p295.halo.Rotation = (p295.halo.Rotation + p296 * (8 + 30 * v299)) % 360;
    p295.revealRays.Rotation = (p295.revealRays.Rotation + p296 * 40) % 360;
    p295.revealRays2.Rotation = (p295.revealRays2.Rotation - p296 * 25) % 360;

    if p295.statusAt and os.clock() - p295.statusAt > 4 then
        p295.statusAt = nil;
        p295.status.Text = "";
    end;
end;

function u1.opened(u301) -- Line: 1643
    -- upvalues: u1 (copy), RunService (copy)
    if not u301:available() then
        task.defer(u301.host.close);
        u1.notice(u1.UNAVAILABLE);

        return;
    end;

    if u301.remote then
        u301.remote:FireServer("Get");
    end;

    u301.shown = true;

    if u301.float then
        u301.float:veil(true);
    end;

    u301:say("");
    u301:refresh();

    if not u301.animation then
        u301.animation = RunService.RenderStepped:Connect(function(p302) -- Line: 1660
            -- upvalues: u301 (copy)
            u301:animate(p302);
        end);
    end;
end;

function u1.closed(p303) -- Line: 1665
    p303.shown = false;
    p303.hadPumpkins = nil;

    if p303.float then
        p303.float:dismiss(p303.fadeRestore ~= nil);
        p303.float:veil(false);
    end;

    if p303.fadeRestore then
        local fadeRestore = p303.fadeRestore;
        p303.fadeRestore = nil;
        p303:hidePrize();
        fadeRestore();
    end;

    if p303.animation and not p303.opening then
        p303.animation:Disconnect();
        p303.animation = nil;
    end;
end;

function u1.start(u304, u305) -- Line: 1686
    -- upvalues: LocalPlayer (copy), result (copy), u1 (copy), ChickenOrHero (copy), PumpkinHuntConfig (copy), u6 (copy)
    u304.host = u305;
    u304.openButton.Activated:Connect(function() -- Line: 1688
        -- upvalues: u304 (copy)
        u304:openNext();
    end);

    local function lobby() -- Line: 1692
        -- upvalues: LocalPlayer (ref), u305 (copy), result (ref), u304 (copy)
        local v306 = LocalPlayer:GetAttribute("InMatch") ~= true;
        local setAvailable = u305.setAvailable;
        local v307;

        if v306 then
            v307 = not result.restricted();
        else
            v307 = v306;
        end;

        setAvailable(v307);

        if not v306 and (u304.opening and u304.float) then
            u304.float:dismiss(true);
        end;

        if u305.isOpen() and not (v306 or u304.opening) then
            u305.close();
        end;
    end;

    u304.checkLobby = lobby;
    LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(lobby);
    lobby();
    result.Changed.Event:Connect(function(p308, p309) -- Line: 1707
        -- upvalues: LocalPlayer (ref), lobby (copy), u305 (copy), u304 (copy), result (ref), u1 (ref)
        if p308 ~= LocalPlayer then
            return;
        end;

        lobby();

        if u305.setCount then
            u305.setCount(p309 and 0 or (u304.total or 0));
        end;

        local v310 = u304.total or 0;
        local v311 = result.restricted() and 0 or v310;
        u1.count = v311;
        u1.counted:Fire(v311);

        if p309 and (u305.isOpen() and not u304.opening) then
            u305.close();
        end;
    end);
    local PumpkinEvent = ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinEvent", 60);

    if not PumpkinEvent then
        warn("PumpkinScreen: Game.PumpkinEvent never arrived after 60 s; waiting for it");
        PumpkinEvent = ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinEvent");
    end;

    u304.remote = PumpkinEvent;
    PumpkinEvent.OnClientEvent:Connect(function(p312, p313) -- Line: 1726
        -- upvalues: u304 (copy), u305 (copy), result (ref), u1 (ref), PumpkinHuntConfig (ref), u6 (ref)
        if type(p313) ~= "table" then
            return;
        end;

        if p312 == "State" then
            if u304.opening then
                u304.pending = p313;

                if u305.setCount and type(p313.total) == "number" then
                    u305.setCount(p313.total);
                end;

                if type(p313.total) == "number" then
                    local total = p313.total;
                    local v314 = result.restricted() and 0 or total;
                    u1.count = v314;
                    u1.counted:Fire(v314);
                end;
            else
                u304:apply(p313);
                u304:refresh();
            end;

            if type(p313.convertedCoins) == "number" and p313.convertedCoins > 0 then
                local v315 = type(p313.converted) ~= "number" and 0 or p313.converted;
                u1.notice(("Opening pumpkins isn\'t available for your account, so your %s %s became %s coins!"):format(PumpkinHuntConfig.commas(v315), v315 == 1 and "pumpkin" or "pumpkins", PumpkinHuntConfig.commas(p313.convertedCoins)));
            end;

            if type(p313.grantedCoins) == "number" and p313.grantedCoins > 0 then
                u1.notice(("Opening pumpkins isn\'t available for your account, so the Pumpkin Hunt paid you %s coins!"):format(PumpkinHuntConfig.commas(p313.grantedCoins)));
            end;

            if type(p313.granted) == "number" and p313.granted > 0 then
                u1.notice(("You got %d %s from the Pumpkin Hunt! Open them with the pumpkin button."):format(p313.granted, p313.granted == 1 and "pumpkin" or "pumpkins"));
            end;
        elseif p312 == "Opened" then
            if p313.ok == true then
                task.spawn(u304.played, u304, p313);

                return;
            end;

            u304.opening = nil;

            if u304.float then
                u304.float:settle();
            end;

            u304:say(u6[p313.reason] or u6.Failed);
            u304:refresh();
            u304:lobbyCheck();
        end;
    end);
    PumpkinEvent:FireServer("Get");
    u304:refresh();
end;

function u1.notice(u316) -- Line: 1780
    -- upvalues: ChickenOrHero (copy)
    task.spawn(function() -- Line: 1781
        -- upvalues: ChickenOrHero (ref), u316 (copy)
        local success2, result2 = pcall(function() -- Line: 1782
            -- upvalues: ChickenOrHero (ref), u316 (ref)
            local v317;

            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                v317 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v317 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
            end;

            require(v317).show(u316);
        end);

        if not success2 then
            warn("Pumpkin notice: " .. tostring(result2));
        end;
    end);
end;

return u1;