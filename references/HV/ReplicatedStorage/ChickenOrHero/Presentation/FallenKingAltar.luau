 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local StarterGui = game:GetService("StarterGui");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local Game = ChickenOrHero:WaitForChild("Game");
local FallenKingBossConfig = require(Game:WaitForChild("FallenKingBossConfig"));
local success, result = pcall(function() -- Line: 34
    -- upvalues: Game (copy)
    return require(Game:WaitForChild("RandomPrizePolicy", 10)).start();
end);

if not success or type(result) ~= "table" then
    warn("[FallenKingAltar] Game.RandomPrizePolicy didn\'t load (" .. tostring(result) .. "); nobody is treated as restricted");
    result = {
        restricted = function() -- Line: 41, Name: restricted
            return false;
        end,

        start = function() -- Line: 41, Name: start
        end,

        Changed = Instance.new("BindableEvent")
    };
end;

local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local LocalHide = require(Presentation:WaitForChild("LocalHide"));
local LocalLooks = require(Presentation:WaitForChild("LocalLooks"));
local CreatorVisibility = require(Presentation:WaitForChild("CreatorVisibility"));
local ArmoryEvent = ChickenOrHero:WaitForChild("Weapons"):WaitForChild("ArmoryEvent");
local Session = Game:WaitForChild("Session");
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    Lying = {
        fov = 70,
        cframe = CFrame.new(-3.913, 8.62, -18.586) * CFrame.fromOrientation(-0.5795016715396772, -2.7314577326636456, 0)
    },
    Standing = {
        fov = 65.5,
        cframe = CFrame.new(0.056, 10.393, -6.733) * CFrame.fromOrientation(-0.047664941871965134, 3.1068082415975464, 0)
    }
};
local Vector2_new_ret = Vector2.new(0.455, 0.925);
local u2 = {
    ghost = Color3.fromRGB(120, 255, 170),
    mint = Color3.fromRGB(215, 255, 228),
    ink = Color3.fromRGB(12, 16, 18),
    edge = Color3.fromRGB(52, 78, 64),
    track = Color3.fromRGB(22, 32, 28),
    white = Color3.fromRGB(240, 255, 246),
    soft = Color3.fromRGB(206, 226, 216),
    gold = Color3.fromRGB(255, 220, 110),
    lemon = Color3.fromRGB(255, 238, 102),
    bad = Color3.fromRGB(255, 110, 110)
};
local u3 = {
    Common = Color3.fromRGB(175, 185, 192),
    Rare = Color3.fromRGB(92, 173, 238),
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local u4 = {
    ghost = { Color3.fromRGB(150, 255, 195), Color3.fromRGB(30, 150, 84), Color3.fromRGB(120, 255, 170) },
    grey = { Color3.fromRGB(100, 108, 104), Color3.fromRGB(62, 68, 66), Color3.fromRGB(100, 108, 104) },
    close = { Color3.fromRGB(158, 158, 158), Color3.fromRGB(120, 120, 124), Color3.fromRGB(189, 189, 189) },
    dark = { Color3.fromRGB(26, 36, 32), Color3.fromRGB(12, 16, 18), Color3.fromRGB(52, 78, 64) }
};
local u5 = {
    Offer = { "rbxassetid://1841354543", 0.45 },
    Open = { "rbxassetid://9126213995", 0.5 }
};
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.Creepster);
local Font_fromEnum_ret2 = Font.fromEnum(Enum.Font.GothamBlack);
local Font_fromEnum_ret3 = Font.fromEnum(Enum.Font.GothamBold);
local u6 = {
    NotEnough = "You don\'t have enough coins for that.",
    Full = "The meter is full!",
    Countdown = "The meter is full! The Fallen King rises soon.",
    Summoning = "The Fallen King is rising!",
    Busy = "Not while the Fallen King is being fought.",
    Resting = "The Fallen King is resting. Offer again soon.",
    Closed = "This feature is currently not available.",
    Unavailable = "This feature is currently not available.",
    Sealed = "This server is closing, so the meter is locked.",
    TooFar = "Head back to the stone King to offer coins.",
    InMatch = "Offer coins in the lobby.",
    Loading = "Your coins are still loading.",
    Failed = "That didn\'t save, and no coins were used. Try again.",
    NoSouls = "You have no souls to offer. Catch runners to collect them."
};
local u7 = {
    UNAVAILABLE = "This feature is currently not available."
};
local u8 = false;
local u9 = nil;
local u10 = {};
local u11 = false;
local u12 = nil;
local u13 = 1;
local u14 = nil;
local u15 = (-1 / 0);
local u16 = 0;
local u17 = false;
local u18 = 0;
local u19 = 0;
local u20 = 0;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = setmetatable({}, {
    __mode = "k"
});

local function flat(p29) -- Line: 161
    return Vector3.new(p29.X, 0, p29.Z);
end;

local function commas(p30) -- Line: 164
    local math_floor_ret = math.floor(p30);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function clock(p31) -- Line: 169
    local math_ceil_ret = math.ceil(p31);
    local math_max_ret = math.max(0, math_ceil_ret);

    return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
end;

local function multiplier(p32) -- Line: 173
    if p32 % 1 == 0 then
        return ("x%d"):format(p32);
    end;

    return ("x%s"):format((("%.2f"):format(p32):gsub("0+$", "")));
end;

local function percent(p33) -- Line: 176
    if p33 >= 10 then
        return ("%.1f%%"):format(p33);
    end;

    if p33 >= 0.1 then
        return ("%.2f%%"):format(p33);
    end;

    return ("%.4f%%"):format(p33):gsub("0+%%$", "%%");
end;

local function alive() -- Line: 184
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;
    local v34;

    if Character then
        v34 = Character:FindFirstChildOfClass("Humanoid");
    else
        v34 = Character;
    end;

    local v35;

    if Character then
        v35 = Character:FindFirstChild("HumanoidRootPart");
    else
        v35 = Character;
    end;

    local v36;

    if v34 == nil or v34.Health <= 0 then
        v36 = false;
    else
        v36 = v35 ~= nil;
    end;

    return Character, v34, v35, v36;
end;

function u7.stone() -- Line: 191
    local FallenKingStone = workspace:FindFirstChild("FallenKingStone");

    if FallenKingStone then
        FallenKingStone = FallenKingStone:FindFirstChildWhichIsA("Model");
    end;

    if FallenKingStone and FallenKingStone:FindFirstChildWhichIsA("BasePart", true) then
        return FallenKingStone;
    end;

    return nil;
end;

local function spotPart() -- Line: 196
    local Lobby = workspace:FindFirstChild("Lobby");

    if Lobby then
        Lobby = Lobby:FindFirstChild("Throne");
    end;

    if Lobby then
        Lobby = Lobby:FindFirstChild("StoneKingSpot");
    end;

    if Lobby and Lobby:IsA("BasePart") then
        return Lobby;
    end;

    return nil;
end;

local function shotOf(p37, p38) -- Line: 202
    -- upvalues: u1 (copy)
    local BoundingBox, v39 = p37:GetBoundingBox();
    local Position = BoundingBox.Position;
    local v40 = Position + Vector3.new(-0, -1, -0);
    local Lobby = workspace:FindFirstChild("Lobby");

    if Lobby then
        Lobby = Lobby:FindFirstChild("Throne");
    end;

    if Lobby then
        Lobby = Lobby:FindFirstChild("StoneKingSpot");
    end;

    if not (Lobby and Lobby:IsA("BasePart")) then
        Lobby = nil;
    end;

    local v41;

    if Lobby then
        v41 = Lobby:FindFirstChild("CameraSpot");
    else
        v41 = Lobby;
    end;

    if v41 and v41:IsA("Attachment") then
        return CFrame.lookAt(v41.WorldPosition, v40);
    end;

    if Lobby then
        local v42 = u1[p37:GetAttribute("StonePose")] or u1.Lying;

        return Lobby.CFrame * v42.cframe, v42.fov;
    end;

    local HumanoidRootPart = p37:FindFirstChild("HumanoidRootPart");
    local v43;

    if HumanoidRootPart then
        v43 = HumanoidRootPart.CFrame.LookVector;
    else
        v43 = not Lobby and Vector3.new(0, 0, 1) or Lobby.CFrame.LookVector;
    end;

    local Vector3_new_ret = Vector3.new(v43.X, 0, v43.Z);
    local v44 = Vector3_new_ret.Magnitude <= 0.01 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit;
    local v45 = v44:Cross(Vector3.new(0, 1, 0));
    local v46 = 0;

    for _, v in { -0.5, 0.5 } do
        local v47 = v;

        for _, v2 in { -0.5, 0.5 } do
            local v48 = v2;

            for _, v3 in { -0.5, 0.5 } do
                local v49 = (BoundingBox:PointToWorldSpace(v39 * Vector3.new(v47, v48, v3)) - Position):Dot(v45);
                local math_abs_ret = math.abs(v49);
                v46 = math.max(v46, math_abs_ret);
            end;
        end;
    end;

    local ViewportSize = p38.ViewportSize;
    local v50 = ViewportSize.Y <= 0 and 1.7777777777777777 or math.max(1, ViewportSize.X / ViewportSize.Y);
    local math_clamp_ret = math.clamp(v46 / (v50 * 0.7002075382097097 * 0.42), 16, 48);

    return CFrame.lookAt(Position + v44 * 0.9396926207859084 * math_clamp_ret + Vector3.new(0, 0.34202015, 0) * math_clamp_ret, v40);
end;

local function play(p51) -- Line: 236
    -- upvalues: u5 (copy), u7 (copy)
    local v52 = u5[p51];
    local v53 = u7.stone();

    if v53 then
        v53 = v53:FindFirstChild("HumanoidRootPart") or v53:FindFirstChildWhichIsA("BasePart", true);
    end;

    if not (v52 and v53) then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = v52[1];
    Sound.Volume = v52[2];
    Sound.RollOffMaxDistance = 120;
    Sound.Parent = v53;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 249
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    task.delay(8, function() -- Line: 252
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

function u7.notice(u54) -- Line: 261
    -- upvalues: ChickenOrHero (copy), Presentation (copy)
    task.spawn(function() -- Line: 262
        -- upvalues: ChickenOrHero (ref), Presentation (ref), u54 (copy)
        local success2, result2 = pcall(function() -- Line: 263
            -- upvalues: ChickenOrHero (ref), Presentation (ref), u54 (ref)
            local v55;

            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                v55 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v55 = Presentation:WaitForChild("ValleyToast", 5);
            end;

            require(v55).show(u54);
        end);

        if not success2 then
            warn("[FallenKingAltar] notice: " .. tostring(result2));
        end;
    end);
end;

local function attr(p56, p57) -- Line: 279
    -- upvalues: u9 (ref)
    local v58 = u9 and u9:GetAttribute(p56);

    if v58 == nil then
        return p57;
    end;

    return v58;
end;

function u7.state() -- Line: 286
    -- upvalues: u9 (ref)
    local v59 = u9 and u9:GetAttribute("SummonState");

    return v59 == nil and "Closed" or v59;
end;

local function snapshot() -- Line: 289
    -- upvalues: u7 (copy), u9 (ref), LocalPlayer (copy)
    local v60 = {
        state = u7.state()
    };
    local v61 = u9 and u9:GetAttribute("SummonPot");
    v60.pot = tonumber(v61 == nil and 0 or v61) or 0;
    local v62 = u9 and u9:GetAttribute("SummonTarget");
    v60.target = tonumber(v62 == nil and 0 or v62) or 0;
    local v63 = u9 and u9:GetAttribute("SummonEndsAt");
    v60.endsAt = tonumber(v63 == nil and 0 or v63) or 0;
    local v64 = u9 and u9:GetAttribute("SummonTop");
    v60.top = tostring(v64 == nil and "" or v64);
    local v65 = u9 and u9:GetAttribute("SummonTopId");
    v60.topId = tonumber(v65 == nil and 0 or v65) or 0;
    local v66 = u9 and u9:GetAttribute("SummonTopCoins");
    v60.topCoins = tonumber(v66 == nil and 0 or v66) or 0;
    v60.mine = tonumber(LocalPlayer:GetAttribute("FallenKingDeposited")) or 0;

    return v60;
end;

local function readOdds() -- Line: 301
    -- upvalues: u9 (ref), u27 (ref), u25 (ref), HttpService (copy)
    local v67 = u9 and u9:GetAttribute("SummonOdds");

    if v67 == nil then
        v67 = nil;
    end;

    if v67 == u27 then
        return u25;
    end;

    u27 = v67;
    u25 = nil;

    if type(v67) == "string" then
        local success2, result2 = pcall(HttpService.JSONDecode, HttpService, v67);

        if success2 and (type(result2) == "table" and (type(result2.rows) == "table" and type(result2.tiers) == "table")) then
            u25 = result2;
        end;
    end;

    return u25;
end;

local function tierFor(p68) -- Line: 317
    -- upvalues: readOdds (copy)
    local v69 = readOdds();

    if not v69 then
        return nil, nil;
    end;

    local v70 = nil;
    local v71 = nil;

    for _, v in v69.tiers do
        local v72 = tonumber(v.at) or 0;

        if v72 <= p68 and (not v70 or v70.at < v72) then
            v70 = v;
        elseif p68 < v72 and (not v71 or v72 < v71.at) then
            v71 = v;
        end;
    end;

    return v70, v71;
end;

local function make(p73, p74, p75, p76) -- Line: 337
    local Instance_new_ret = Instance.new(p73);
    Instance_new_ret.Name = p75;

    for i, v in p76 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p74;

    return Instance_new_ret;
end;

local function stroke(p77, p78) -- Line: 346
    local v79 = {
        Color = Color3.new(0, 0, 0),
        Thickness = p78 or 0.12,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v79 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p77;

    return UIStroke;
end;

local function label(p80, p81, p82, p83, p84) -- Line: 354
    -- upvalues: Font_fromEnum_ret2 (copy), u2 (copy), stroke (copy)
    local v85 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        Active = false,
        Interactable = false,
        FontFace = p84 or Font_fromEnum_ret2,
        Text = p82,
        TextColor3 = u2.white,
        AnchorPoint = Vector2.new(0.5, 0.5)
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p81;

    for i, v in v85 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p80;

    for i, v in p83 or {} do
        TextLabel[i] = v;
    end;

    stroke(TextLabel);

    return TextLabel;
end;

local function setLook(p86, p87) -- Line: 372
    -- upvalues: u4 (copy), u2 (copy)
    local v88 = u4[p87] or u4.grey;
    p86.UIGradient.Color = ColorSequence.new(v88[1], v88[2]);
    p86.Ring.Color = v88[3];
    p86.Texture.Visible = p87 == "ghost";
    local TextLabel = p86.TextLabel;
    local v89;

    if p87 == "grey" then
        v89 = Color3.fromRGB(176, 186, 180);
    else
        v89 = u2.white;
    end;

    TextLabel.TextColor3 = v89;
end;

local function button(p90, p91, p92, p93, p94) -- Line: 379
    -- upvalues: u2 (copy), label (copy), setLook (copy)
    local v95 = {
        AutoButtonColor = true,
        BorderSizePixel = 0,
        BackgroundColor3 = u2.white,
        AnchorPoint = Vector2.new(0.5, 0.5)
    };
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = p91;

    for i, v in v95 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = p90;

    for i, v in p94 do
        ImageButton[i] = v;
    end;

    local v96 = {
        CornerRadius = UDim.new(0.22, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v96 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = ImageButton;
    local v97 = {
        Thickness = 0.05,
        ZIndex = 1,
        Color = Color3.new(0, 0, 0),
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Outline";

    for i, v in v97 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = ImageButton;
    local v98 = {
        Thickness = 0.033,
        ZIndex = 2,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "Ring";

    for i, v in v98 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = ImageButton;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in {
        Rotation = 90
    } or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = ImageButton;
    local v99 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.93)
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Texture";

    for i, v in v99 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = ImageButton;
    local v100 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v100 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = CanvasGroup;
    local v101 = {
        Rotation = 45,
        BackgroundTransparency = 1,
        Image = "rbxassetid://140022482252277",
        ImageTransparency = 0.84,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.87, 8),
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromScale(0.35, 0.35)
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Stripes";

    for i, v in v101 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = CanvasGroup;
    label(ImageButton, "TextLabel", p92, {
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.84, 0.5),
        ZIndex = ImageButton.ZIndex + 1
    });
    setLook(ImageButton, p93);

    return ImageButton;
end;

local function setEnabled(p102, p103, p104) -- Line: 430
    -- upvalues: setLook (copy)
    p102.Interactable = p103;
    p102.AutoButtonColor = p103;
    setLook(p102, not p103 and "grey" or p104);
end;

local function panel(p105, p106, p107) -- Line: 437
    -- upvalues: u2 (copy)
    local v108 = {
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(14, 20, 18)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = p106;

    for i, v in v108 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p105;

    for i, v in p107 do
        Frame[i] = v;
    end;

    local v109 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v109 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v110 = {
        Thickness = 1.5,
        Transparency = 0.5,
        Color = u2.ghost
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Edge";

    for i, v in v110 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;

    return Frame;
end;

local function divider(p111, p112) -- Line: 451
    -- upvalues: u2 (copy)
    local v113 = {
        BackgroundTransparency = 0.55,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, p112),
        Size = UDim2.new(0.84, 0, 0, 1),
        BackgroundColor3 = u2.ghost
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Divider";

    for i, v in v113 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p111;
end;

local function page(p114, p115) -- Line: 462
    local v116 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = p115;

    for i, v in v116 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p114;

    return Frame;
end;

local function build() -- Line: 466
    -- upvalues: u10 (copy), panel (copy), label (copy), u2 (copy), Font_fromEnum_ret (copy), Font_fromEnum_ret3 (copy), divider (copy), button (copy), u17 (ref), u7 (copy), FallenKingBossConfig (copy), u13 (ref), Vector2_new_ret (copy), LocalPlayer (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "FallenKingAltar";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 66;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.Enabled = false;
    ScreenGui:SetAttribute("CreatorCaptureExempt", true);
    ScreenGui:SetAttribute("SelfManagedText", true);
    u10.gui = ScreenGui;

    for _, v in { { 0, 0 }, { 1, 180 } } do
        local v117 = {
            BorderSizePixel = 0,
            Active = false,
            Interactable = false,
            AnchorPoint = Vector2.new(v[1], 0),
            Position = UDim2.fromScale(v[1], 0),
            Size = UDim2.fromScale(0.38, 1),
            BackgroundColor3 = Color3.new(0, 0, 0)
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Edge";

        for i, v2 in v117 or {} do
            Frame[i] = v2;
        end;

        Frame.Parent = ScreenGui;
        local v118 = {
            Rotation = v[2],
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1) })
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "UIGradient";

        for i, v2 in v118 or {} do
            UIGradient[i] = v2;
        end;

        UIGradient.Parent = Frame;
    end;

    local v119 = {
        BorderSizePixel = 0,
        Active = false,
        Interactable = false,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.fromScale(1, 0.4),
        BackgroundColor3 = Color3.new(0, 0, 0)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Bottom";

    for i, v in v119 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v120 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.3) })
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v120 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v121 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1)
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Controls";

    for i, v in v121 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = ScreenGui;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "UIAspectRatioConstraint";

    for i, v in {
        AspectRatio = 2.115
    } or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame2;
    u10.frame = Frame2;
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Pop";

    for i, v in {
        Scale = 1
    } or {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame2;
    u10.pop = UIScale;
    local v122 = panel(Frame2, "Info", {
        Position = UDim2.fromScale(0.165, 0.47),
        Size = UDim2.fromScale(0.29, 0.76)
    });
    u10.title = label(v122, "Title", "THE FALLEN KING", {
        Position = UDim2.fromScale(0.5, 0.085),
        Size = UDim2.fromScale(0.88, 0.1),
        TextColor3 = u2.ghost
    }, Font_fromEnum_ret);
    u10.subtitle = label(v122, "Subtitle", "Offer coins to summon him again", {
        Position = UDim2.fromScale(0.5, 0.165),
        Size = UDim2.fromScale(0.86, 0.045),
        TextColor3 = u2.soft
    }, Font_fromEnum_ret3);
    divider(v122, 0.215);
    local v123 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "InfoPage";

    for i, v in v123 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = v122;
    u10.infoPage = Frame3;
    label(Frame3, "YoursTitle", "YOUR OFFERING", {
        Position = UDim2.fromScale(0.5, 0.275),
        Size = UDim2.fromScale(0.8, 0.045),
        TextColor3 = u2.lemon
    });
    u10.yours = label(Frame3, "Yours", "0 COINS", {
        Position = UDim2.fromScale(0.5, 0.345),
        Size = UDim2.fromScale(0.8, 0.07)
    });
    u10.luckTitle = label(Frame3, "LuckTitle", "YOUR LUCK", {
        Position = UDim2.fromScale(0.5, 0.445),
        Size = UDim2.fromScale(0.8, 0.045),
        TextColor3 = u2.lemon
    });
    u10.luck = label(Frame3, "Luck", "", {
        Position = UDim2.fromScale(0.5, 0.54),
        Size = UDim2.fromScale(0.86, 0.12),
        TextColor3 = u2.ghost
    }, Font_fromEnum_ret3);
    u10.nextTier = label(Frame3, "NextTier", "", {
        Position = UDim2.fromScale(0.5, 0.655),
        Size = UDim2.fromScale(0.86, 0.05),
        TextColor3 = u2.mint
    }, Font_fromEnum_ret3);
    local v124 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "OddsPage";

    for i, v in v124 or {} do
        Frame4[i] = v;
    end;

    Frame4.Parent = v122;
    Frame4.Visible = false;
    u10.oddsPage = Frame4;
    u10.oddsTitle = label(Frame4, "OddsTitle", "KING\'S SPOILS ODDS", {
        Position = UDim2.fromScale(0.5, 0.265),
        Size = UDim2.fromScale(0.84, 0.045),
        TextColor3 = u2.lemon
    });
    u10.oddsRows = {};

    for i = 1, 8 do
        local v125 = {
            BackgroundTransparency = 1,
            Visible = false,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, (i - 1) * 0.058 + 0.33),
            Size = UDim2.fromScale(0.84, 0.048)
        };
        local Frame5 = Instance.new("Frame");
        Frame5.Name = "Odds" .. i;

        for i2, v in v125 or {} do
            Frame5[i2] = v;
        end;

        Frame5.Parent = Frame4;
        local v126 = label(Frame5, "Name", "", {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0, 0.5),
            Size = UDim2.fromScale(0.7, 1),
            TextXAlignment = Enum.TextXAlignment.Left
        }, Font_fromEnum_ret3);
        local v127 = label(Frame5, "Value", "", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.fromScale(1, 0.5),
            Size = UDim2.fromScale(0.28, 1),
            TextXAlignment = Enum.TextXAlignment.Right
        });
        u10.oddsRows[i] = {
            frame = Frame5,
            name = v126,
            value = v127
        };
    end;

    u10.oddsButton = button(v122, "OddsButton", "SEE ODDS", "dark", {
        Position = UDim2.fromScale(0.5, 0.905),
        Size = UDim2.fromScale(0.62, 0.085)
    });
    u10.oddsButton.Activated:Connect(function() -- Line: 571
        -- upvalues: u17 (ref), u7 (ref)
        u17 = not u17;
        u7.refresh();
    end);
    local v128 = panel(Frame2, "Offer", {
        Position = UDim2.fromScale(0.835, 0.47),
        Size = UDim2.fromScale(0.29, 0.76)
    });
    label(v128, "AmountTitle", "OFFER COINS", {
        Position = UDim2.fromScale(0.5, 0.075),
        Size = UDim2.fromScale(0.8, 0.055),
        TextColor3 = u2.lemon
    });
    u10.chips = {};

    for i, v in FallenKingBossConfig.Summon.Deposits do
        local v129 = button(v128, "Amount" .. i, "", "dark", {
            Position = UDim2.fromScale(0.5, 0.19 + (i - 1) * 0.125),
            Size = UDim2.fromScale(0.84, 0.1)
        });
        local TextLabel = v129.TextLabel;
        local math_floor_ret = math.floor(v);
        TextLabel.Text = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        v129.TextLabel.Position = UDim2.fromScale(0.58, 0.5);
        v129.TextLabel.Size = UDim2.fromScale(0.62, 0.5);
        local v130 = {
            BackgroundTransparency = 1,
            Image = "rbxassetid://78008558948307",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.17, 0.5),
            Size = UDim2.fromScale(0.5, 0.5),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = v129.ZIndex + 1
        };
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Coin";
        local u131 = i;

        for i2, v2 in v130 or {} do
            ImageLabel[i2] = v2;
        end;

        ImageLabel.Parent = v129;
        v129.Activated:Connect(function() -- Line: 598
            -- upvalues: u13 (ref), u131 (copy), u7 (ref)
            u13 = u131;
            u7.refresh();
        end);
        u10.chips[u131] = v129;
    end;

    u10.wallet = label(v128, "Wallet", "", {
        Position = UDim2.fromScale(0.5, 0.55),
        Size = UDim2.fromScale(0.8, 0.045),
        TextColor3 = u2.soft
    }, Font_fromEnum_ret3);
    divider(v128, 0.615);
    u10.topTitle = label(v128, "TopTitle", "TOP OFFERING", {
        Position = UDim2.fromScale(0.5, 0.68),
        Size = UDim2.fromScale(0.8, 0.045),
        TextColor3 = u2.lemon
    });
    u10.top = label(v128, "Top", "", {
        Position = UDim2.fromScale(0.5, 0.755),
        Size = UDim2.fromScale(0.86, 0.06)
    });
    u10.topNote = label(v128, "TopNote", "gets the Top 10\'s odds", {
        Position = UDim2.fromScale(0.5, 0.825),
        Size = UDim2.fromScale(0.8, 0.04),
        TextColor3 = u2.soft
    }, Font_fromEnum_ret3);
    u10.souls = button(v128, "Souls", "OFFER SOULS", "dark", {
        Position = UDim2.fromScale(0.5, 0.92),
        Size = UDim2.fromScale(0.84, 0.09)
    });
    u10.status = label(Frame2, "Status", "", {
        Position = UDim2.fromScale(0.5, 0.7),
        Size = UDim2.fromScale(0.36, 0.034),
        TextColor3 = u2.bad
    }, Font_fromEnum_ret3);
    u10.stage = label(Frame2, "Stage", "", {
        Position = UDim2.fromScale(0.5, 0.752),
        Size = UDim2.fromScale(0.36, 0.04),
        TextColor3 = u2.ghost
    });
    local v132 = {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.815),
        Size = UDim2.fromScale(0.36, 0.055),
        BackgroundColor3 = u2.track
    };
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "Meter";

    for i, v in v132 or {} do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame2;
    local v133 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v133 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame5;
    local v134 = {
        Thickness = 2.5,
        Color = u2.gold
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Ring";

    for i, v in v134 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame5;
    local v135 = {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = u2.ghost
    };
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "Fill";

    for i, v in v135 or {} do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame5;
    local v136 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v136 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame6;
    local v137 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(150, 150, 150))
    };
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "UIGradient";

    for i, v in v137 or {} do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame6;
    u10.meter = Frame5;
    u10.fill = Frame6;
    u10.meterText = label(Frame5, "Text", "", {
        ZIndex = 3,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.9, 0.62)
    });
    u10.offer = button(Frame2, "Offer", "OFFER", "ghost", {
        Position = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y),
        Size = UDim2.fromScale(0.17, 0.08)
    });
    u10.close = button(Frame2, "Close", "CLOSE", "close", {
        Position = UDim2.fromScale(0.597, Vector2_new_ret.Y),
        Size = UDim2.fromScale(0.09, 0.066)
    });
    local v138 = {
        BackgroundTransparency = 1,
        Active = false,
        Interactable = false,
        ZIndex = 9,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "Fx";

    for i, v in v138 or {} do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame2;
    u10.fx = Frame7;
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
end;

local function say(p139) -- Line: 649
    -- upvalues: u10 (copy), u24 (ref)
    u10.status.Text = p139 or "";
    local v140;

    if p139 and p139 ~= "" then
        v140 = os.clock();
    else
        v140 = nil;
    end;

    u24 = v140;
end;

function u7.refresh() -- Line: 655
    -- upvalues: u10 (copy), snapshot (copy), result (copy), u21 (ref), u23 (ref), TweenService (copy), u2 (copy), tierFor (copy), readOdds (copy), u17 (ref), LocalPlayer (copy), FallenKingBossConfig (copy), u3 (copy), u14 (ref), u22 (ref), setLook (copy), u13 (ref), u26 (ref), u24 (ref)
    if not u10.frame then
        return;
    end;

    local v141 = snapshot();
    local v142 = result.restricted();
    local math_max_ret = math.max(v141.pot, u21 or 0);

    if v141.target > 0 then
        math_max_ret = math.min(math_max_ret, v141.target);
    end;

    local math_max_ret2 = math.max(v141.mine, u23 or 0);
    local v143 = v141.state == "Countdown";
    local v144 = v141.target <= 0 and 0 or math.clamp(math_max_ret / v141.target, 0, 1);
    TweenService:Create(u10.fill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(v143 and 1 or v144, 1)
    }):Play();
    local v145;

    if v143 then
        v145 = u2.gold;
    else
        v145 = u2.ghost;
    end;

    u10.fill.BackgroundColor3 = v145;
    local meterText = u10.meterText;
    local v146;

    if v143 then
        v146 = "FULL";
    else
        local math_floor_ret = math.floor(math_max_ret);
        local v147 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        local math_floor_ret2 = math.floor(v141.target);
        v146 = ("%s / %s COINS"):format(v147, (tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
    end;

    meterText.Text = v146;

    if v143 then
        local stage = u10.stage;
        local v148 = v141.endsAt - workspace:GetServerTimeNow();
        local math_ceil_ret = math.ceil(v148);
        local math_max_ret3 = math.max(0, math_ceil_ret);
        stage.Text = "THE KING RISES IN " .. string.format("%d:%02d", math_max_ret3 // 60, math_max_ret3 % 60);
        u10.stage.TextColor3 = u2.gold;
    else
        u10.stage.Text = "FILL THE METER TO SUMMON HIM";
        u10.stage.TextColor3 = u2.ghost;
    end;

    local yours = u10.yours;
    local math_floor_ret = math.floor(math_max_ret2);
    yours.Text = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " COINS";
    local v149, v150 = tierFor(math_max_ret2);
    local v151 = readOdds();
    local v152 = not v142;

    if v152 then
        if v151 == nil then
            v152 = false;
        else
            v152 = v149 ~= nil;
        end;
    end;

    u10.luckTitle.Visible = v152;
    u10.luck.Visible = v152;
    u10.oddsTitle.Visible = v152;
    u10.nextTier.Visible = v152;
    u10.oddsButton.Visible = v152;
    local v153;

    if v152 then
        v153 = u17;
    else
        v153 = v152;
    end;

    u10.infoPage.Visible = not v153;
    local v154;

    if v152 then
        v154 = u17;
    else
        v154 = v152;
    end;

    u10.oddsPage.Visible = v154;
    u10.oddsButton.TextLabel.Text = u17 and "BACK" or "SEE ODDS";
    local v155;

    if v141.topId == 0 then
        v155 = false;
    else
        v155 = v141.topId == LocalPlayer.UserId;
    end;

    if v152 then
        local v156 = FallenKingBossConfig.luck(math_max_ret2);
        local v157 = {};

        for _, v in { "Blades", "Axes" } do
            local v158 = v156[v] or 1;
            local v159 = v;
            local v160 = {};

            for _, v2 in v151.rows do
                if v2.luck == v159 then
                    table.insert(v160, v2.name);
                end;
            end;

            if #v160 > 0 then
                local v161;

                if v158 % 1 == 0 then
                    v161 = ("x%d"):format(v158);
                else
                    v161 = ("x%s"):format((("%.2f"):format(v158):gsub("0+$", "")));
                end;

                local v162 = v161 .. " " .. table.concat(v160, " & ");
                table.insert(v157, v162);
            end;
        end;

        u10.luck.Text = table.concat(v157, "\n");
        u10.oddsTitle.Text = v155 and "KING\'S SPOILS ODDS · TOP" or "KING\'S SPOILS ODDS";
        local v163;

        if v155 then
            v163 = v149.top;
        else
            v163 = v149.normal;
        end;

        for i, v in u10.oddsRows do
            local v164 = v151.rows[i];
            local v165;

            if v164 then
                if v163 then
                    v165 = tonumber(v163[i]);
                else
                    v165 = v163;
                end;
            else
                v165 = v164;
            end;

            local v166;

            if v164 == nil then
                v166 = false;
            else
                v166 = v165 ~= nil;
            end;

            v.frame.Visible = v166;

            if v164 and v165 then
                v.name.Text = v164.name;
                v.name.TextColor3 = u3[v164.rarity] or u2.white;
                local value = v.value;
                local v167;

                if v165 >= 10 then
                    v167 = ("%.1f%%"):format(v165);
                elseif v165 >= 0.1 then
                    v167 = ("%.2f%%"):format(v165);
                else
                    v167 = ("%.4f%%"):format(v165):gsub("0+%%$", "%%");
                end;

                value.Text = v167;
                local v168;

                if v164.luck and (v156[v164.luck] or 1) > 1 then
                    v168 = u2.ghost;
                else
                    v168 = u2.white;
                end;

                v.value.TextColor3 = v168;
            end;
        end;

        local v169 = v141.state ~= "Filling" and 0 or math.max(0, v141.target - math_max_ret);

        if v150 then
            if v169 <= 0 then
                u10.nextTier.Text = "Your luck is set for this summon";
            elseif v169 < v150.at - math_max_ret2 then
                local nextTier = u10.nextTier;
                local math_floor_ret2 = math.floor(v169);
                nextTier.Text = ("Only %s more fits in the meter"):format((tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
            else
                local v170 = FallenKingBossConfig.luck(v150.at);
                local nextTier = u10.nextTier;
                local math_floor_ret2 = math.floor(v150.at - math_max_ret2);
                local v171 = tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                local v172 = v170.Blades or 1;
                local v173;

                if v172 % 1 == 0 then
                    v173 = ("x%d"):format(v172);
                else
                    v173 = ("x%s"):format((("%.2f"):format(v172):gsub("0+$", "")));
                end;

                local v174 = v170.Axes or 1;
                local v175;

                if v174 % 1 == 0 then
                    v175 = ("x%d"):format(v174);
                else
                    v175 = ("x%s"):format((("%.2f"):format(v174):gsub("0+$", "")));
                end;

                nextTier.Text = ("Offer %s more: %s / %s luck"):format(v171, v173, v175);
            end;
        else
            u10.nextTier.Text = "Your luck is MAXED";
        end;
    else
        for _, v in u10.oddsRows do
            v.frame.Visible = false;
        end;
    end;

    local top = u10.top;
    local v176;

    if v141.top == "" then
        v176 = "Nobody yet";
    else
        local top2 = v141.top;
        local math_floor_ret2 = math.floor(v141.topCoins);
        v176 = ("%s · %s"):format(top2, (tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
    end;

    top.Text = v176;
    u10.topNote.Visible = not v142;
    local v177;

    if u14 then
        v177 = math.min(u14, u22 or (1 / 0));
    else
        v177 = nil;
    end;

    local wallet = u10.wallet;
    local v178;

    if v177 then
        local math_floor_ret2 = math.floor(v177);
        v178 = "You have " .. tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    else
        v178 = "";
    end;

    wallet.Text = v178;
    local math_max_ret3 = math.max(0, v141.target - math_max_ret);
    local v179;

    if v141.state == "Filling" then
        v179 = v141.target - math_max_ret > 0;
    else
        v179 = false;
    end;

    for i, v in u10.chips do
        setLook(v, v179 and (i == u13 and "ghost" or "dark") or "grey");
        v.Interactable = v179;
        local v180 = FallenKingBossConfig.Summon.Deposits[i];
        local TextLabel = v.TextLabel;
        local v181;

        if v179 and math_max_ret3 < v180 then
            local math_floor_ret2 = math.floor(math_max_ret3);
            v181 = tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " · MAX";
        else
            local math_floor_ret2 = math.floor(v180);
            v181 = tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        end;

        TextLabel.Text = v181;
    end;

    local math_min_ret = math.min(FallenKingBossConfig.Summon.Deposits[u13], math_max_ret3);
    local v182;

    if v141.state == "Filling" then
        v182 = math_min_ret > 0;
    else
        v182 = false;
    end;

    local TextLabel = u10.offer.TextLabel;
    local v183;

    if v182 then
        local math_floor_ret2 = math.floor(math_min_ret);
        v183 = "OFFER " .. tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    else
        v183 = v143 and "FULL" or "OFFER";
    end;

    TextLabel.Text = v183;
    local offer = u10.offer;
    offer.Interactable = v182;
    offer.AutoButtonColor = v182;
    setLook(offer, v182 and "ghost" or "grey");
    local v184 = tonumber(LocalPlayer:GetAttribute("FallenKingCarried")) or 0;
    local TextLabel2 = u10.souls.TextLabel;
    local v185;

    if v184 > 0 then
        local math_floor_ret2 = math.floor(v184);
        v185 = ("OFFER %s SOUL%s"):format(tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), v184 == 1 and "" or "S");
    else
        v185 = "NO SOULS";
    end;

    TextLabel2.Text = v185;
    local souls = u10.souls;
    local v186;

    if v141.state == "Filling" and (math_max_ret3 > 0 and v184 > 0) then
        v186 = not u26;
    else
        v186 = false;
    end;

    souls.Interactable = v186;
    souls.AutoButtonColor = v186;
    setLook(souls, v186 and "ghost" or "grey");

    if u24 and os.clock() - u24 > 4 then
        u10.status.Text = "";
        u24 = nil;
    end;
end;

local function stoneOnScreen() -- Line: 781
    -- upvalues: u7 (copy), u10 (copy)
    local v187 = u7.stone();
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local frame = u10.frame;

    if not (v187 and (workspace_CurrentCamera and (frame and frame.AbsoluteSize.X > 0))) then
        return Vector2.new(0.5, 0.45);
    end;

    local v188 = workspace_CurrentCamera:WorldToViewportPoint(v187:GetBoundingBox().Position);

    return (Vector2.new(v188.X, v188.Y) - frame.AbsolutePosition) / frame.AbsoluteSize;
end;

local function burst(p189, p190) -- Line: 792
    -- upvalues: u10 (copy), u2 (copy), TweenService (copy), Vector2_new_ret (copy), stoneOnScreen (copy), label (copy)
    if not (u10.frame and u10.gui.Enabled) then
        return;
    end;

    u10.meter.Ring.Color = u2.white;
    TweenService:Create(u10.meter.Ring, TweenInfo.new(0.5), {
        Color = u2.gold
    }):Play();

    if not p190 then
        return;
    end;

    local v191 = Vector2_new_ret;
    local v192 = stoneOnScreen();

    for i = 1, 8 do
        local fx = u10.fx;
        local v193 = {
            BorderSizePixel = 0,
            ZIndex = 10,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(v191.X + (math.random() - 0.5) * 0.1, v191.Y + (math.random() - 0.5) * 0.05),
            Size = UDim2.fromScale(0.012, 0.019)
        };
        local v194;

        if i % 2 == 0 then
            v194 = u2.ghost;
        else
            v194 = u2.mint;
        end;

        v193.BackgroundColor3 = v194;
        local Frame = Instance.new("Frame");
        Frame.Name = "Spark";
        local _ = i;

        for i2, v in v193 or {} do
            Frame[i2] = v;
        end;

        Frame.Parent = fx;
        local v195 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v in v195 or {} do
            UICorner[i2] = v;
        end;

        UICorner.Parent = Frame;
        local v196 = 0.45 + math.random() * 0.25;
        TweenService:Create(Frame, TweenInfo.new(v196, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundTransparency = 0.4,
            Position = UDim2.fromScale(v192.X + (math.random() - 0.5) * 0.08, v192.Y + (math.random() - 0.5) * 0.08),
            Size = UDim2.fromScale(0.006, 0.0096)
        }):Play();
        task.delay(v196, function() -- Line: 819
            -- upvalues: Frame (copy)
            Frame:Destroy();
        end);
    end;

    local fx = u10.fx;
    local math_floor_ret = math.floor(p189);
    local u197 = label(fx, "Plus", "+" .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), {
        ZIndex = 11,
        Position = UDim2.fromScale(v191.X, v191.Y - 0.07),
        Size = UDim2.fromScale(0.12, 0.05),
        TextColor3 = u2.gold
    });
    TweenService:Create(u197, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1,
        Position = UDim2.fromScale(v191.X, v191.Y - 0.17)
    }):Play();
    TweenService:Create(u197.UIStroke, TweenInfo.new(0.8), {
        Transparency = 1
    }):Play();
    task.delay(0.85, function() -- Line: 834
        -- upvalues: u197 (copy)
        u197:Destroy();
    end);
end;

local function remember(p198) -- Line: 842
    -- upvalues: u28 (copy)
    for i, v in p198.saved do
        if u28[i] == nil then
            u28[i] = v;
        end;
    end;
end;

local function sweepLeftovers(p199) -- Line: 849
    -- upvalues: u12 (ref), u28 (copy), LocalLooks (copy)
    if u12 then
        return;
    end;

    local v200 = 0;

    for i, v in u28 do
        local success2, result2 = pcall(function() -- Line: 855
            -- upvalues: i (copy)
            return i.LocalTransparencyModifier;
        end);

        if success2 and (i.Parent and (result2 >= 1 and (v < 1 and not LocalLooks.has(i, "LocalTransparencyModifier")))) then
            pcall(function() -- Line: 859
                -- upvalues: i (copy), v (copy)
                i.LocalTransparencyModifier = v;
            end);
            v200 = v200 + 1;
        end;
    end;

    table.clear(u28);

    if v200 > 0 then
        warn(("[FallenKingAltar] %d hidden parts were still hidden (%s): shown again"):format(v200, p199));
    end;
end;

local function watchPlate(p201, u202) -- Line: 870
    if p201.plates[u202] or (not u202:IsA("BillboardGui") or string.sub(u202.Name, 1, 15) ~= "PlayerOverhead_") then
        return;
    end;

    local u203 = {
        own = 0,
        wanted = u202.Enabled
    };
    p201.plates[u202] = u203;

    local function suppress() -- Line: 876
        -- upvalues: u202 (copy), u203 (copy)
        if u202.Enabled then
            local v204 = u203;
            v204.own = v204.own + 1;
            u202.Enabled = false;
        end;
    end;

    u203.connection = u202:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 882
        -- upvalues: u202 (copy), u203 (copy)
        if u202.Enabled or u203.own <= 0 then
            u203.wanted = u202.Enabled;

            if u202.Enabled then
                local v205 = u203;
                v205.own = v205.own + 1;
                u202.Enabled = false;
            end;

            return;
        end;

        local v206 = u203;
        v206.own = v206.own - 1;
    end);

    if u202.Enabled then
        u203.own = u203.own + 1;
        u202.Enabled = false;
    end;
end;

local function showPlates(p207) -- Line: 892
    for i, v in p207.plates do
        v.connection:Disconnect();

        if i.Parent then
            pcall(function() -- Line: 896
                -- upvalues: i (copy), v (copy)
                i.Enabled = v.wanted;
            end);
        end;
    end;

    table.clear(p207.plates);
end;

local function hideAll(u208) -- Line: 903
    -- upvalues: u28 (copy)
    pcall(function() -- Line: 904
        -- upvalues: u208 (copy)
        u208.hide:sweep();

        if u208.character.Parent then
            u208.hide:model(u208.character);
        end;
    end);

    for i, v in u208.hide.saved do
        if u28[i] == nil then
            u28[i] = v;
        end;
    end;
end;

local function fly(u209, u210, u211, u212) -- Line: 916
    -- upvalues: RunService (copy), u7 (copy)
    local camera = u209.camera;
    local CFrame2 = camera.CFrame;
    local FieldOfView = camera.FieldOfView;
    local u213;

    if u210 == u209.shot then
        u213 = u209.shotFov or 70;
    else
        u213 = u209.saved.fov;
    end;

    local v214 = Vector3.new(0, 1, 0) * math.clamp((u210.Position - CFrame2.Position).Magnitude * 0.35, 2, 10);
    local u215 = (CFrame2.Position + u210.Position) / 2 + v214;
    local os_clock_ret = os.clock();

    if u209.flight then
        u209.flight:Disconnect();
    end;

    u209.flight = RunService.RenderStepped:Connect(function() -- Line: 926
        -- upvalues: os_clock_ret (copy), u211 (copy), CFrame2 (copy), u215 (copy), u210 (copy), camera (copy), FieldOfView (copy), u213 (copy), u209 (copy), u212 (copy), u7 (ref)
        local success2, result2 = pcall(function() -- Line: 927
            -- upvalues: os_clock_ret (ref), u211 (ref), CFrame2 (ref), u215 (ref), u210 (ref), camera (ref), FieldOfView (ref), u213 (ref), u209 (ref), u212 (ref)
            local v216 = (os.clock() - os_clock_ret) / u211;
            local math_clamp_ret = math.clamp(v216, 0, 1);
            local v217 = math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
            local v218 = CFrame2.Position:Lerp(u215, v217);
            local v219 = u215:Lerp(u210.Position, v217);
            camera.CFrame = CFrame.new(v218:Lerp(v219, v217)) * (CFrame2 - CFrame2.Position):Lerp(u210 - u210.Position, v217);
            camera.FieldOfView = FieldOfView + (u213 - FieldOfView) * v217;

            if math_clamp_ret >= 1 then
                u209.flight:Disconnect();
                u209.flight = nil;

                if u212 then
                    u212();
                end;
            end;
        end);

        if not success2 then
            warn("[FallenKingAltar] camera flight failed: " .. tostring(result2));

            if u209.flight then
                u209.flight:Disconnect();
                u209.flight = nil;
            end;

            u7.close("instant");
        end;
    end);
end;

local function restoreCamera(p220) -- Line: 952
    -- upvalues: LocalPlayer (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera ~= p220.camera then
        return;
    end;

    local type2 = p220.saved.type;

    if type2 == Enum.CameraType.Scriptable then
        type2 = Enum.CameraType.Custom;
    end;

    workspace_CurrentCamera.CameraType = type2;
    local Character = LocalPlayer.Character;
    local v221;

    if Character then
        v221 = Character:FindFirstChildOfClass("Humanoid");
    else
        v221 = Character;
    end;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if v221 ~= nil and v221.Health > 0 then
        local _ = Character == nil;
    end;

    local subject = p220.saved.subject;

    if subject and subject.Parent then
        if subject:IsA("Humanoid") then
            if subject.Health <= 0 then
                subject = v221;
            end;
        end;
    else
        subject = v221;
    end;

    workspace_CurrentCamera.CameraSubject = subject or v221;
    workspace_CurrentCamera.FieldOfView = p220.saved.fov;
end;

local function hideScreens() -- Line: 976
    -- upvalues: LocalPlayer (copy), CreatorVisibility (copy), StarterGui (copy)
    if LocalPlayer:GetAttribute("CreatorUIHidden") == true then
        return nil;
    end;

    local v222 = CreatorVisibility.new(LocalPlayer);
    v222:setHidden(true);

    if v222.topbar ~= nil then
        pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", v222.topbar);
        v222.topbar = nil;
    end;

    return v222;
end;

local function finish(u223) -- Line: 989
    -- upvalues: u12 (ref), LocalPlayer (copy), Session (copy), fly (copy), RunService (copy), restoreCamera (copy), showPlates (copy), sweepLeftovers (copy)
    local u224 = u12;

    if not u224 then
        return;
    end;

    if u224.finishing then
        if u223 ~= "fly" then
            u224.abort = u223;
        end;

        return;
    end;

    u224.finishing = true;

    for _, v in u224.connections do
        v:Disconnect();
    end;

    table.clear(u224.connections);

    if u224.flight then
        u224.flight:Disconnect();
        u224.flight = nil;
    end;

    local v225 = {};
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(v225, AttributeChangedSignal:Connect(function() -- Line: 1010
        -- upvalues: LocalPlayer (ref), u224 (copy)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u224.abort = "instant";
        end;
    end));
    local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("MapChanging");
    table.insert(v225, AttributeChangedSignal2:Connect(function() -- Line: 1015
        -- upvalues: Session (ref), u224 (copy)
        if Session:GetAttribute("MapChanging") == true then
            u224.abort = "instant";
        end;
    end));
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("CutsceneActive");
    table.insert(v225, AttributeChangedSignal3:Connect(function() -- Line: 1020
        -- upvalues: LocalPlayer (ref), u224 (copy)
        if LocalPlayer:GetAttribute("CutsceneActive") == true then
            u224.abort = "instant";
        end;
    end));
    local success2, result2 = pcall(function() -- Line: 1025
        -- upvalues: u223 (ref), u224 (copy), LocalPlayer (ref), fly (ref), RunService (ref)
        if u223 == "fly" and (workspace.CurrentCamera == u224.camera and u224.camera.CameraType == Enum.CameraType.Scriptable) then
            local Character = LocalPlayer.Character;
            Character = Character;
            local v226;

            if Character then
                v226 = Character:FindFirstChildOfClass("Humanoid");
            else
                v226 = Character;
            end;

            local v227 = Character and Character:FindFirstChild("HumanoidRootPart");
            local v228;

            if v226 == nil or v226.Health <= 0 then
                v228 = false;
            else
                v228 = v227 ~= nil;
            end;

            if v228 and v227 then
                local u229 = false;
                fly(u224, v227.CFrame * u224.offset, 0.75, function() -- Line: 1030
                    -- upvalues: u229 (ref)
                    u229 = true;
                end);
                local os_clock_ret = os.clock();

                while not (u229 or (u224.abort or os.clock() - os_clock_ret >= 1.75)) do
                    RunService.RenderStepped:Wait();
                end;

                if u224.flight then
                    u224.flight:Disconnect();
                    u224.flight = nil;
                end;

                if u224.abort == "external" then
                    u223 = "external";
                end;
            end;
        end;
    end);

    if not success2 then
        warn("[FallenKingAltar] flying back failed: " .. tostring(result2));
    end;

    for _, v in v225 do
        v:Disconnect();
    end;

    if u223 ~= "external" then
        pcall(restoreCamera, u224);
    end;

    pcall(function() -- Line: 1058
        -- upvalues: u224 (copy)
        u224.hide:restore();
    end);
    pcall(showPlates, u224);

    if u224.screens then
        pcall(u224.screens.destroy, u224.screens);
        u224.screens = nil;
    end;

    u12 = nil;
    pcall(sweepLeftovers, "after the altar");
    LocalPlayer:SetAttribute("FallenKingAltarOpen", nil);
end;

local function enter() -- Line: 1071
    -- upvalues: LocalPlayer (copy), u7 (copy), LocalHide (copy), shotOf (copy), u12 (ref), u28 (copy), hideScreens (copy), watchPlate (copy), fly (copy), Session (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local v230;

    if Character then
        v230 = Character:FindFirstChildOfClass("Humanoid");
    else
        v230 = Character;
    end;

    local v231;

    if Character then
        v231 = Character:FindFirstChild("HumanoidRootPart");
    else
        v231 = Character;
    end;

    local v232;

    if v230 == nil or v230.Health <= 0 then
        v232 = false;
    else
        v232 = v231 ~= nil;
    end;

    local u233 = u7.stone();
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (v232 and (u233 and workspace_CurrentCamera)) then
        return false;
    end;

    local u234 = {
        shot = nil,
        camera = workspace_CurrentCamera,
        character = Character,
        saved = {
            type = workspace_CurrentCamera.CameraType,
            subject = workspace_CurrentCamera.CameraSubject,
            fov = workspace_CurrentCamera.FieldOfView
        },
        offset = v231.CFrame:ToObjectSpace(workspace_CurrentCamera.CFrame),
        hide = LocalHide.new(),
        plates = {},
        connections = {}
    };
    local v235, v236 = shotOf(u233, workspace_CurrentCamera);
    u234.shot = v235;
    u234.shotFov = v236;
    u12 = u234;
    LocalPlayer:SetAttribute("FallenKingAltarOpen", true);
    pcall(function() -- Line: 904
        -- upvalues: u234 (copy)
        u234.hide:sweep();

        if u234.character.Parent then
            u234.hide:model(u234.character);
        end;
    end);

    for i, v in u234.hide.saved do
        if u28[i] == nil then
            u28[i] = v;
        end;
    end;

    local success2, result2 = pcall(hideScreens);

    if not success2 then
        result2 = nil;
    end;

    u234.screens = result2;
    local v237 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v237 then
        for _, child in v237:GetChildren() do
            watchPlate(u234, child);
        end;

        table.insert(u234.connections, v237.ChildAdded:Connect(function(p238) -- Line: 1099
            -- upvalues: watchPlate (ref), u234 (copy)
            watchPlate(u234, p238);
        end));
    end;

    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    fly(u234, u234.shot, 0.9, nil);
    local connections = u234.connections;
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(connections, AttributeChangedSignal:Connect(function() -- Line: 1106
        -- upvalues: LocalPlayer (ref), u7 (ref)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u7.close("instant");
        end;
    end));
    local connections2 = u234.connections;
    local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("MapChanging");
    table.insert(connections2, AttributeChangedSignal2:Connect(function() -- Line: 1111
        -- upvalues: Session (ref), u7 (ref)
        if Session:GetAttribute("MapChanging") == true then
            u7.close("instant");
        end;
    end));
    local connections3 = u234.connections;
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("CutsceneActive");
    table.insert(connections3, AttributeChangedSignal3:Connect(function() -- Line: 1118
        -- upvalues: LocalPlayer (ref), u7 (ref)
        if LocalPlayer:GetAttribute("CutsceneActive") == true then
            u7.close("instant");
        end;
    end));
    table.insert(u234.connections, Character.AncestryChanged:Connect(function() -- Line: 1123
        -- upvalues: Character (copy), u7 (ref)
        if not Character:IsDescendantOf(workspace) then
            u7.close("instant");
        end;
    end));
    local v239 = Character:FindFirstChildOfClass("Humanoid");

    if v239 then
        table.insert(u234.connections, v239.Died:Connect(function() -- Line: 1130
            -- upvalues: u7 (ref)
            u7.close("instant");
        end));
    end;

    local connections4 = u234.connections;
    local PropertyChangedSignal = workspace_CurrentCamera:GetPropertyChangedSignal("CameraType");
    table.insert(connections4, PropertyChangedSignal:Connect(function() -- Line: 1134
        -- upvalues: workspace_CurrentCamera (copy), u7 (ref)
        if workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
            u7.close("external");
        end;
    end));
    local connections5 = u234.connections;
    local PropertyChangedSignal2 = workspace:GetPropertyChangedSignal("CurrentCamera");
    table.insert(connections5, PropertyChangedSignal2:Connect(function() -- Line: 1139
        -- upvalues: u7 (ref)
        u7.close("external");
    end));
    table.insert(u234.connections, u233.AncestryChanged:Connect(function() -- Line: 1142
        -- upvalues: u233 (copy), u7 (ref)
        if not u233:IsDescendantOf(workspace) then
            u7.close("instant");
        end;
    end));
    local u240 = 0;
    table.insert(u234.connections, RunService.Heartbeat:Connect(function() -- Line: 1149
        -- upvalues: u240 (ref), u234 (copy), u28 (ref)
        local os_clock_ret = os.clock();

        if os_clock_ret < u240 then
            return;
        end;

        u240 = os_clock_ret + 0.3;
        local u241 = u234;
        pcall(function() -- Line: 904
            -- upvalues: u241 (copy)
            u241.hide:sweep();

            if u241.character.Parent then
                u241.hide:model(u241.character);
            end;
        end);

        for i, v in u241.hide.saved do
            if u28[i] == nil then
                u28[i] = v;
            end;
        end;
    end));

    return true;
end;

local function popIn() -- Line: 1163
    -- upvalues: u10 (copy), TweenService (copy)
    u10.gui.Enabled = true;
    u10.pop.Scale = 0.55;
    TweenService:Create(u10.pop, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
end;

local function popOut(p242) -- Line: 1168
    -- upvalues: u10 (copy), TweenService (copy), u11 (ref)
    if p242 then
        u10.gui.Enabled = false;

        return;
    end;

    local u243 = {};
    u10.outToken = u243;
    TweenService:Create(u10.pop, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Scale = 0.6
    }):Play();
    task.delay(0.18, function() -- Line: 1176
        -- upvalues: u10 (ref), u243 (copy), u11 (ref)
        if u10.outToken == u243 and not u11 then
            u10.gui.Enabled = false;
            u10.pop.Scale = 1;
        end;
    end);
end;

function u7.close(p244) -- Line: 1185
    -- upvalues: u11 (ref), GuiService (copy), u10 (copy), popOut (copy), u12 (ref), finish (copy)
    if u11 then
        u11 = false;
        local SelectedObject = GuiService.SelectedObject;

        if SelectedObject and (u10.gui and SelectedObject:IsDescendantOf(u10.gui)) then
            GuiService.SelectedObject = nil;
        end;

        if u10.animation then
            u10.animation:Disconnect();
            u10.animation = nil;
        end;

        popOut(p244 ~= "fly");
    end;

    if u12 then
        task.spawn(finish, p244 or "fly");
    end;
end;

function u7.canOpen() -- Line: 1205
    -- upvalues: u7 (copy), u6 (copy), LocalPlayer (copy)
    local v245 = u7.state();

    if v245 == "Unavailable" or v245 == "Closed" then
        return false, "This feature is currently not available.";
    end;

    if v245 ~= "Filling" then
        return false, u6[v245];
    end;

    if LocalPlayer:GetAttribute("InMatch") == true or (LocalPlayer:GetAttribute("CutsceneActive") == true or not u7.stone()) then
        return false, nil;
    end;

    local Character = LocalPlayer.Character;
    local v246;

    if Character then
        v246 = Character:FindFirstChildOfClass("Humanoid");
    else
        v246 = Character;
    end;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v247;

    if v246 == nil or v246.Health <= 0 then
        v247 = false;
    else
        v247 = Character ~= nil;
    end;

    return v247, nil;
end;

local function stateChanged() -- Line: 1221
    -- upvalues: u7 (copy), u11 (ref), u9 (ref)
    local v248 = u7.state();

    if not u11 then
        return;
    end;

    if v248 == "Filling" then
        return;
    end;

    if v248 == "Countdown" then
        local v249 = u9 and u9:GetAttribute("SummonEndsAt");

        if (tonumber(v249 == nil and 0 or v249) or 0) - workspace:GetServerTimeNow() > 3 then
            return;
        end;
    end;

    u7.close("fly");

    if v248 == "Unavailable" or v248 == "Closed" then
        u7.notice("This feature is currently not available.");
    end;
end;

function u7.open() -- Line: 1242
    -- upvalues: u11 (ref), u12 (ref), u8 (ref), u7 (copy), HudNavigation (copy), enter (copy), finish (copy), u17 (ref), u21 (ref), u22 (ref), u23 (ref), u18 (ref), u10 (copy), u24 (ref), u15 (ref), ArmoryEvent (copy), play (copy), popIn (copy), UserInputService (copy), GuiService (copy), RunService (copy), stateChanged (copy)
    if u11 or (u12 or not u8) then
        return;
    end;

    local v250, v251 = u7.canOpen();

    if not v250 then
        if v251 then
            u7.notice(v251);
        end;

        return;
    end;

    HudNavigation.opening("FallenKingAltar");
    local success2, result2 = pcall(enter);

    if not success2 then
        warn("[FallenKingAltar] couldn\'t start: " .. tostring(result2));
        finish("instant");

        return;
    end;

    if not result2 then
        return;
    end;

    u11 = true;
    u17 = false;
    u21 = nil;
    u22 = nil;
    u23 = nil;
    u18 = 0;
    u10.status.Text = "";
    u24 = nil;

    if os.clock() - u15 >= 0.75 then
        u15 = os.clock();
        ArmoryEvent:FireServer("Get");
    end;

    u7.refresh();
    play("Open");
    local u252 = u12;
    task.delay(0.63, function() -- Line: 1274
        -- upvalues: u11 (ref), u12 (ref), u252 (copy), popIn (ref), UserInputService (ref), GuiService (ref), u10 (ref)
        if u11 and u12 == u252 then
            popIn();

            if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
                GuiService.SelectedObject = u10.offer;
            end;
        end;
    end);
    local u253 = 0;
    u10.animation = RunService.Heartbeat:Connect(function() -- Line: 1286
        -- upvalues: u253 (ref), stateChanged (ref), u11 (ref), u7 (ref)
        local os_clock_ret = os.clock();

        if os_clock_ret < u253 then
            return;
        end;

        u253 = os_clock_ret + 0.25;
        stateChanged();

        if u11 then
            u7.refresh();
        end;
    end);
end;

function u7.isOpen() -- Line: 1299
    -- upvalues: u11 (ref)
    return u11;
end;

local function offer() -- Line: 1303
    -- upvalues: u11 (ref), snapshot (copy), u6 (copy), u10 (copy), u24 (ref), u16 (ref), u21 (ref), FallenKingBossConfig (copy), u13 (ref), u14 (ref), u22 (ref), u18 (ref), u19 (ref), u23 (ref), u9 (ref), burst (copy), play (copy), u7 (copy)
    if not u11 then
        return;
    end;

    local v254 = snapshot();

    if v254.state ~= "Filling" then
        local v255 = u6[v254.state] or "That didn\'t save, and no coins were used. Try again.";
        u10.status.Text = v255 or "";
        local v256;

        if v255 and v255 ~= "" then
            v256 = os.clock();
        else
            v256 = nil;
        end;

        u24 = v256;

        return;
    end;

    if os.clock() - u16 < 0.25 then
        return;
    end;

    u16 = os.clock();
    local math_max_ret = math.max(v254.pot, u21 or 0);
    local v257 = v254.target - math_max_ret;

    if v257 <= 0 then
        u10.status.Text = "The meter is full!";
        u24 = os.clock();

        return;
    end;

    local math_min_ret = math.min(FallenKingBossConfig.Summon.Deposits[u13], v257);
    local v258;

    if u14 then
        v258 = math.min(u14, u22 or (1 / 0));
    else
        v258 = nil;
    end;

    if v258 and v258 < math_min_ret then
        u10.status.Text = "You don\'t have enough coins for that.";
        u24 = os.clock();

        return;
    end;

    u18 = u18 + math_min_ret;
    u19 = os.clock();
    u21 = math_max_ret + math_min_ret;
    u23 = math.max(v254.mine, u23 or 0) + math_min_ret;
    local v259;

    if v258 then
        v259 = v258 - math_min_ret;
    else
        v259 = nil;
    end;

    u22 = v259;
    u9:FireServer("Deposit", u13);
    burst(math_min_ret, true);
    play("Offer");
    u7.refresh();
end;

local function offerSouls() -- Line: 1340
    -- upvalues: u11 (ref), u26 (ref), snapshot (copy), u6 (copy), u10 (copy), u24 (ref), LocalPlayer (copy), u21 (ref), u9 (ref), burst (copy), FallenKingBossConfig (copy), play (copy), u7 (copy)
    if not u11 or u26 then
        return;
    end;

    local v260 = snapshot();

    if v260.state ~= "Filling" then
        local v261 = u6[v260.state] or "That didn\'t save, and no coins were used. Try again.";
        u10.status.Text = v261 or "";
        local v262;

        if v261 and v261 ~= "" then
            v262 = os.clock();
        else
            v262 = nil;
        end;

        u24 = v262;

        return;
    end;

    local v263 = tonumber(LocalPlayer:GetAttribute("FallenKingCarried")) or 0;

    if v263 <= 0 then
        u10.status.Text = "You have no souls to offer. Catch runners to collect them.";
        u24 = os.clock();

        return;
    end;

    local v264 = v260.target - math.max(v260.pot, u21 or 0);
    local math_max_ret = math.max(0, v264);

    if math_max_ret <= 0 then
        u10.status.Text = "The meter is full!";
        u24 = os.clock();

        return;
    end;

    u26 = os.clock();
    u9:FireServer("Souls");
    burst(math.min(v263 * FallenKingBossConfig.Summon.SoulCoins, math_max_ret), true);
    play("Offer");
    u7.refresh();
end;

function u7.start(p265) -- Line: 1367
    -- upvalues: u8 (ref), u9 (ref), build (copy), u10 (copy), offer (copy), offerSouls (copy), u7 (copy), HudNavigation (copy), u11 (ref), UserInputService (copy), ArmoryEvent (copy), u14 (ref), stateChanged (copy), LocalPlayer (copy), u26 (ref), u18 (ref), u20 (ref), u21 (ref), u22 (ref), u23 (ref), u6 (copy), u24 (ref), u2 (copy), TweenService (copy), u19 (ref), sweepLeftovers (copy), u12 (ref), result (copy)
    if u8 then
        return;
    end;

    u8 = true;
    u9 = p265;
    build();
    u10.offer.Activated:Connect(offer);
    u10.souls.Activated:Connect(offerSouls);
    u10.close.Activated:Connect(function() -- Line: 1376
        -- upvalues: u7 (ref)
        u7.close("fly");
    end);
    HudNavigation.register("FallenKingAltar", function() -- Line: 1379
        -- upvalues: u11 (ref), u7 (ref)
        if u11 then
            u7.close("fly");

            return;
        end;

        u7.open();
    end);
    HudNavigation.setAvailable("FallenKingAltar", true);
    HudNavigation.Opening.Event:Connect(function(p266) -- Line: 1387
        -- upvalues: u11 (ref), u7 (ref)
        if p266 ~= "FallenKingAltar" and u11 then
            u7.close("fly");
        end;
    end);
    UserInputService.InputBegan:Connect(function(p267) -- Line: 1392
        -- upvalues: u11 (ref), u7 (ref)
        if u11 and (p267.KeyCode == Enum.KeyCode.Escape or p267.KeyCode == Enum.KeyCode.ButtonB) then
            u7.close("fly");
        end;
    end);
    ArmoryEvent.OnClientEvent:Connect(function(p268, p269) -- Line: 1398
        -- upvalues: u14 (ref), u11 (ref), u7 (ref)
        if p268 == "State" and (type(p269) == "table" and (p269.loaded == true and type(p269.coins) == "number")) then
            u14 = p269.coins;

            if u11 then
                u7.refresh();
            end;
        end;
    end);
    u9.AttributeChanged:Connect(function(p270) -- Line: 1406
        -- upvalues: stateChanged (ref), u11 (ref), u7 (ref)
        if p270 == "SummonState" or p270 == "SummonEndsAt" then
            stateChanged();
        end;

        if u11 then
            u7.refresh();
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("FallenKingDeposited"):Connect(function() -- Line: 1414
        -- upvalues: u11 (ref), u7 (ref)
        if u11 then
            u7.refresh();
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("FallenKingCarried"):Connect(function() -- Line: 1419
        -- upvalues: u11 (ref), u7 (ref)
        if u11 then
            u7.refresh();
        end;
    end);
    u9.OnClientEvent:Connect(function(p271, p272) -- Line: 1424
        -- upvalues: u26 (ref), u11 (ref), u7 (ref), u18 (ref), u20 (ref), u21 (ref), u22 (ref), u23 (ref), u6 (ref), u10 (ref), u24 (ref), LocalPlayer (ref), u2 (ref), TweenService (ref)
        if p271 ~= "Summon" or type(p272) ~= "table" then
            return;
        end;

        if p272.kind == "Souls" then
            u26 = nil;

            if u11 then
                u7.refresh();
            end;
        elseif p272.kind == "Result" then
            if p272.ok ~= true then
                u26 = nil;
            end;

            if p272.ok == true then
                local v273 = u18 - (tonumber(p272.amount) or 0);
                u18 = math.max(0, v273);

                if u18 == 0 then
                    u20 = os.clock();
                end;
            else
                u18 = 0;
                u21 = nil;
                u22 = nil;
                u23 = nil;
                local v274 = u6[p272.reason] or "That didn\'t save, and no coins were used. Try again.";
                u10.status.Text = v274 or "";
                local v275;

                if v274 and v274 ~= "" then
                    v275 = os.clock();
                else
                    v275 = nil;
                end;

                u24 = v275;
            end;

            if u11 then
                u7.refresh();
            end;
        elseif p272.kind == "Burst" and (u11 and p272.userId ~= LocalPlayer.UserId) then
            local _ = tonumber(p272.amount) or 0;

            if u10.frame then
                if not u10.gui.Enabled then
                    return;
                end;

                u10.meter.Ring.Color = u2.white;
                TweenService:Create(u10.meter.Ring, TweenInfo.new(0.5), {
                    Color = u2.gold
                }):Play();
            end;
        end;
    end);
    task.spawn(function() -- Line: 1455
        -- upvalues: u10 (ref), u26 (ref), u18 (ref), u19 (ref), u21 (ref), u22 (ref), u23 (ref), u20 (ref), u11 (ref), u7 (ref)
        while u10.gui and u10.gui.Parent do
            task.wait(1);

            if u26 and os.clock() - u26 > 6 then
                u26 = nil;
            end;

            if u18 > 0 and os.clock() - u19 > 6 then
                u18 = 0;
                u21 = nil;
                u22 = nil;
                u23 = nil;
            end;

            if u18 == 0 and (u21 or (u22 or u23)) and os.clock() - u20 > 2 then
                u21 = nil;
                u22 = nil;
                u23 = nil;

                if u11 then
                    u7.refresh();
                end;
            end;
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 1475
        -- upvalues: sweepLeftovers (ref)
        task.defer(sweepLeftovers, "match");
    end);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 1478
        -- upvalues: sweepLeftovers (ref), u12 (ref), LocalPlayer (ref)
        task.defer(function() -- Line: 1479
            -- upvalues: sweepLeftovers (ref), u12 (ref), LocalPlayer (ref)
            sweepLeftovers("respawn");

            if not u12 and LocalPlayer:GetAttribute("FallenKingAltarOpen") ~= nil then
                LocalPlayer:SetAttribute("FallenKingAltarOpen", nil);
            end;
        end);
    end);
    result.Changed.Event:Connect(function(p276) -- Line: 1487
        -- upvalues: LocalPlayer (ref), u11 (ref), u7 (ref)
        if p276 == LocalPlayer and u11 then
            u7.refresh();
        end;
    end);
end;

function u7.debugState() -- Line: 1495
    -- upvalues: u11 (ref), u12 (ref), u13 (ref)
    local v277 = {
        open = u11,
        visit = u12 ~= nil
    };
    local v278;

    if u12 == nil then
        v278 = false;
    else
        v278 = u12.finishing == true;
    end;

    v277.finishing = v278;
    v277.chip = u13;

    return v277;
end;

return u7;