 

 

local TweenService = game:GetService("TweenService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Crates = ChickenOrHero:WaitForChild("Crates");
local Interface = ChickenOrHero:WaitForChild("Interface");
local CrateRollConfig = require(Crates:WaitForChild("CrateRollConfig"));
local PumpkinHuntConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntConfig"));
local CrateCatalog = require(Crates:WaitForChild("CrateCatalog"));
local SkinCatalog = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("SkinCatalog"));
local EmoteCatalog = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local EmotePlayback = require(ChickenOrHero.Emotes:WaitForChild("EmotePlayback"));
local CharacterClone = require(Interface:WaitForChild("CharacterClone"));
local CharacterFrame = require(Interface:WaitForChild("CharacterFrame"));
local KnifeIconCopy = require(ChickenOrHero.Weapons:WaitForChild("KnifeIconCopy"));
local v1 = {};
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret2 = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret3 = Color3.fromRGB(222, 222, 222);
local Color3_fromRGB_ret4 = Color3.fromRGB(8, 18, 20);
local u2 = {
    Common = Color3.fromRGB(175, 185, 192),
    Rare = Color3.fromRGB(92, 173, 238),
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local u3 = {
    CrateTick = { 10128760939, 0.16, 1.3 },
    CrateOpen = { 10128766965, 0.3, 0.8 },
    CrateReward = { 82803453482376, 0.42, 1 },
    Jackpot = { 9117278724, 0.35, 1 },
    WheelTick = { 10066931761, 0.18, 1 }
};

local function make(p4, p5, p6) -- Line: 57
    local Instance_new_ret = Instance.new(p4);

    for i, v in p6 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p5;

    return Instance_new_ret;
end;

local function placer(u7, u8) -- Line: 67
    return function(p9, p10, p11, p12, p13) -- Line: 68
        -- upvalues: u7 (copy), u8 (copy)
        p9.Position = UDim2.fromScale(p10 / u7, p11 / u8);
        p9.Size = UDim2.fromScale(p12 / u7, p13 / u8);

        return p9;
    end;
end;

local function corner(p14, p15) -- Line: 75
    local v16 = {
        CornerRadius = UDim.new(p15, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v16 do
        UICorner[i] = v;
    end;

    UICorner.Parent = p14;

    return UICorner;
end;

local function stroke(p17, p18, p19, p20) -- Line: 79
    local v21 = {
        Color = p18,
        Thickness = p19,
        Transparency = p20 or 0,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v21 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p17;

    return UIStroke;
end;

local function label(p22, p23, p24, p25, p26) -- Line: 89
    -- upvalues: Color3_fromRGB_ret4 (copy)
    local v27 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        TextStrokeTransparency = 0.6,
        Text = p23,
        TextColor3 = p24,
        Font = p25,
        TextStrokeColor3 = Color3_fromRGB_ret4,
        ZIndex = p26
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v27 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p22;

    return TextLabel;
end;

local function tween(p28, p29, p30, p31, p32) -- Line: 103
    -- upvalues: TweenService (copy)
    local v33 = TweenService:Create(p28, TweenInfo.new(p29, p31 or Enum.EasingStyle.Quad, p32 or Enum.EasingDirection.Out), p30);
    v33:Play();

    return v33;
end;

local function fadeOut(p34, p35) -- Line: 114
    -- upvalues: TweenService (copy)
    for _, descendant in p34:GetDescendants() do
        local v36 = descendant:IsA("TextLabel") and {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            BackgroundTransparency = 1
        } or (descendant:IsA("ImageLabel") and {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        } or (descendant:IsA("ViewportFrame") and {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        } or (descendant:IsA("GuiObject") and {
            BackgroundTransparency = 1
        } or (descendant:IsA("UIStroke") and {
            Transparency = 1
        } or nil))));

        if v36 then
            TweenService:Create(descendant, TweenInfo.new(p35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v36):Play();
        end;
    end;
end;

local function knifeView(p37, p38, p39) -- Line: 137
    -- upvalues: SkinCatalog (copy), ChickenOrHero (copy), Color3_new_ret (copy), KnifeIconCopy (copy)
    local v40 = SkinCatalog.get(p38);
    local Models = ChickenOrHero.Weapons:FindFirstChild("Models");

    if Models then
        Models = v40 and Models:FindFirstChild(v40.Model) or Models:FindFirstChild(p38);
    end;

    local v41;

    if Models then
        v41 = Models:FindFirstChild("Blade");
    else
        v41 = Models;
    end;

    if not (v41 and v41:IsA("BasePart")) then
        return nil;
    end;

    local v42 = {
        Name = "Preview",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -1),
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(200, 210, 225),
        LightColor = Color3_new_ret,
        ZIndex = p39
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v42 do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = p37;
    local WorldModel = Instance.new("WorldModel");

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = ViewportFrame;
    local v43, _, v44, v45 = KnifeIconCopy.new(v41);
    local Attribute = Models:GetAttribute("PreviewRotation");
    local v46;

    if typeof(Attribute) == "CFrame" then
        v46 = Attribute.Rotation;
    else
        v46 = CFrame.Angles(-0.3, 0, -0.5);
    end;

    v43.CFrame = CFrame.new(-v46:VectorToWorldSpace(v45)) * v46;
    v43.Parent = WorldModel;
    local Camera = Instance.new("Camera");

    for i, v in {
        FieldOfView = 35
    } do
        Camera[i] = v;
    end;

    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;

    return {
        reach = 1.6,
        viewport = ViewportFrame,
        camera = Camera,
        extent = math.max(v44.X, v44.Y, v44.Z, 0.5)
    };
end;

local function orbit(p47, p48) -- Line: 172
    local v49 = p48 * 0.3;
    local extent = p47.extent;
    local v50 = p47.reach or 1.9;
    local camera = p47.camera;
    local CFrame_lookAt = CFrame.lookAt;
    local v51 = math.sin(v49) * extent * v50;
    local v52 = math.cos(v49) * extent * v50;
    camera.CFrame = CFrame_lookAt(Vector3.new(v51, extent * 0.4, v52), Vector3.new(0, 0, 0));
end;

local function emoteView(p53, p54, p55, p56) -- Line: 181
    -- upvalues: CharacterClone (copy), Color3_new_ret (copy), CharacterFrame (copy), EmotePlayback (copy)
    local v57, v58 = CharacterClone.copy(p54);

    if not v57 then
        return nil;
    end;

    local v59 = {
        Name = "Preview",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -1),
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(200, 210, 225),
        LightColor = Color3_new_ret,
        ZIndex = p56
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v59 do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = p53;
    local WorldModel = Instance.new("WorldModel");

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = ViewportFrame;
    local Camera = Instance.new("Camera");

    for i, v in {
        FieldOfView = 40
    } do
        Camera[i] = v;
    end;

    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;
    v57:PivotTo(CFrame.new());
    v57.Name = "PreviewCharacter";
    v57.Parent = WorldModel;
    CharacterFrame.fit(Camera, v57, ViewportFrame, 1.12);
    v57:PivotTo(CFrame.Angles(0, -0.3490658503988659, 0));
    local v60 = v58:FindFirstChildOfClass("Animator");

    if v60 then
        v60 = EmotePlayback.load(v60, p55);
    end;

    if v60 then
        v60:Play(0.15);
    end;

    return {
        viewport = ViewportFrame,
        track = v60
    };
end;

local function prizeOf(p61, p62) -- Line: 212
    -- upvalues: CrateCatalog (copy), EmoteCatalog (copy), SkinCatalog (copy)
    local v63 = CrateCatalog.get(p61);

    if not v63 or type(p62) ~= "string" then
        return nil;
    end;

    for _, v in v63.Entries do
        if (v.Emote or v.Skin) == p62 then
            if v.Emote then
                local v64 = EmoteCatalog.get(p62);
                local v65 = {
                    kind = "Emote",
                    id = p62
                };

                if v64 then
                    p62 = v64.Name or p62;
                end;

                v65.name = p62;
                v65.rarity = v.Rarity or "Common";

                return v65;
            end;

            local v66 = SkinCatalog.get(p62);
            local v67 = {
                kind = "Skin",
                id = p62
            };

            if v66 then
                p62 = v66.Name or p62;
            end;

            v67.name = p62;
            v67.rarity = v.Rarity or "Common";

            return v67;
        end;
    end;

    return nil;
end;

local function billboard(p68, p69, p70, p71, p72) -- Line: 230
    -- upvalues: CrateRollConfig (copy)
    local v73 = {
        StudsOffset = Vector3.new(0, 0, 0),
        AlwaysOnTop = false,
        LightInfluence = 0,
        ResetOnSpawn = false,
        ClipsDescendants = false,
        Active = false,
        Name = p72,
        Adornee = p68,
        Size = UDim2.fromScale(p70, p71),
        SizeOffset = Vector2.new(0, 0.5),
        StudsOffsetWorldSpace = Vector3.new(0, CrateRollConfig.HeadOffset, 0),
        MaxDistance = CrateRollConfig.MaxDistance,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local BillboardGui = Instance.new("BillboardGui");

    for i, v in v73 do
        BillboardGui[i] = v;
    end;

    BillboardGui.Parent = p69;

    return BillboardGui;
end;

local function plateParts(p74, p75, p76) -- Line: 254
    -- upvalues: CrateRollConfig (copy)
    local v77 = p74:FindFirstChild("PlayerOverhead_" .. tostring(p75));

    if v77 and (v77:IsA("BillboardGui") and (v77.Enabled and v77.Adornee == p76)) then
        return v77.StudsOffsetWorldSpace.Y, (v77.SizeOffset.Y + 0.5) * v77.Size.Y.Scale + CrateRollConfig.NameplateGap;
    end;

    return CrateRollConfig.HeadOffset, 0;
end;

local function plateTop(p78, p79, p80) -- Line: 261
    -- upvalues: plateParts (copy)
    local v81, v82 = plateParts(p78, p79, p80);

    return v81 + v82;
end;

local function lift(p83, p84, p85, p86) -- Line: 266
    -- upvalues: plateParts (copy)
    local v87, v88 = plateParts(p84, p85, p86);
    local v89 = v87 + v88;

    if p83.StudsOffsetWorldSpace.Y ~= v89 then
        p83.StudsOffsetWorldSpace = Vector3.new(0, v89, 0);
    end;
end;

local function soundBank(u90) -- Line: 274
    -- upvalues: u3 (copy), CrateRollConfig (copy)
    local u91 = {};
    local u92 = {};

    function u91.mute(p93) -- Line: 278
        -- upvalues: u91 (copy), u92 (copy)
        u91.muted = p93;

        if p93 then
            for _, v in u92 do
                v:Stop();
            end;
        end;
    end;

    function u91.play(p94, p95, p96) -- Line: 286
        -- upvalues: u91 (copy), u3 (ref), u92 (copy), u90 (copy), CrateRollConfig (ref)
        if u91.muted then
            return;
        end;

        local v97 = u3[p94];
        local v98 = u92[p94];

        if not v98 then
            if not u91.holder then
                local Attachment = Instance.new("Attachment");

                for i, v in {
                    Name = "CrateRollSounds"
                } do
                    Attachment[i] = v;
                end;

                Attachment.Parent = u90;
                u91.holder = Attachment;
            end;

            local holder = u91.holder;
            local v99 = {
                Name = p94,
                SoundId = "rbxassetid://" .. v97[1],
                Volume = v97[2],
                RollOffMode = Enum.RollOffMode.Linear,
                RollOffMinDistance = CrateRollConfig.SoundMinDistance,
                RollOffMaxDistance = CrateRollConfig.SoundMaxDistance
            };
            v98 = Instance.new("Sound");

            for i, v in v99 do
                v98[i] = v;
            end;

            v98.Parent = holder;
            u92[p94] = v98;
        end;

        v98.Volume = v97[2] * (p96 or 1);
        v98.PlaybackSpeed = p95 or v97[3];
        v98.TimePosition = 0;
        v98:Play();
    end;

    function u91.destroy() -- Line: 311
        -- upvalues: u91 (copy)
        if u91.holder then
            u91.holder:Destroy();
            u91.holder = nil;
        end;
    end;

    return u91;
end;

local function countBadge(p100, p101, p102, p103, p104, p105, p106, p107) -- Line: 321
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy)
    if type(p101) ~= "number" or p101 <= 1 then
        return nil;
    end;

    local v108 = {
        Name = "Count",
        BorderSizePixel = 0,
        BackgroundColor3 = Color3_fromRGB_ret,
        ZIndex = p107
    };
    local Frame = Instance.new("Frame");

    for i, v in v108 do
        Frame[i] = v;
    end;

    Frame.Parent = p100;
    local v109 = p102(Frame, p103, p104, p105, p106);
    local v110 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v110 do
        UICorner[i] = v;
    end;

    UICorner.Parent = v109;
    local v111 = {
        Thickness = 0.06,
        Transparency = 0.4,
        Color = Color3_fromRGB_ret4,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v111 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = v109;
    local v112 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        TextStrokeTransparency = 0.6,
        Text = "x" .. math.floor(p101),
        TextColor3 = Color3_fromRGB_ret4,
        Font = Enum.Font.GothamBlack,
        TextStrokeColor3 = Color3_fromRGB_ret4,
        ZIndex = p107 + 1
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v112 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = v109;
    TextLabel.TextStrokeTransparency = 1;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel.Size = UDim2.fromScale(0.86, 0.78);

    return v109;
end;

local function burst(p113, p114, u115, u116, p117, p118, p119, p120, p121, p122) -- Line: 342
    -- upvalues: TweenService (copy), Color3_new_ret (copy)
    local v123 = {
        Name = "RarityBurst",
        BackgroundTransparency = 1,
        Rotation = -25,
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = p122
    };
    local Frame = Instance.new("Frame");
    local v124 = p114;

    for i, v in v123 do
        Frame[i] = v;
    end;

    Frame.Parent = p113;
    local v125 = p114(Frame, p117, p118, 460, 460);
    local v126 = p120 and 24 or 16;

    for i = 1, v126 do
        local v127 = i * 3.141592653589793 * 2 / v126;
        local v128 = i % 2 == 0;
        local v129 = {
            BackgroundTransparency = 0.45,
            BorderSizePixel = 0,
            Name = "Ray" .. i,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.fromScale(math.sin(v127) * 28 / 460 + 0.5, 0.5 - math.cos(v127) * 28 / 460),
            Size = UDim2.fromScale((v128 and 18 or 7) / 460, 0.043478260869565216),
            Rotation = math.deg(v127),
            BackgroundColor3 = p119,
            ZIndex = p122
        };
        local Frame2 = Instance.new("Frame");
        local _ = i;

        for i2, v in v129 do
            Frame2[i2] = v;
        end;

        Frame2.Parent = v125;
        local v130 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner = Instance.new("UICorner");

        for i2, v in v130 do
            UICorner[i2] = v;
        end;

        UICorner.Parent = Frame2;
        local v131 = {
            Rotation = 90,
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.3), NumberSequenceKeypoint.new(1, 0.95) })
        };
        local UIGradient = Instance.new("UIGradient");

        for i2, v in v131 do
            UIGradient[i2] = v;
        end;

        UIGradient.Parent = Frame2;
        local v132 = {
            BackgroundTransparency = 0.75,
            Size = UDim2.fromScale((v128 and 18 or 7) / 460, (v128 and 120 or 145) * (p120 and 1.45 or 1) / 460)
        };
        TweenService:Create(Frame2, TweenInfo.new(p120 and 1.05 or 0.75, Enum.EasingStyle.Quart or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v132):Play();
    end;

    TweenService:Create(v125, TweenInfo.new(2.4, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Rotation = 35
    }):Play();

    for i = 1, p120 and 3 or 2 do
        local v133 = {
            BackgroundTransparency = 1,
            Name = "ShockRing" .. i,
            AnchorPoint = Vector2.new(0.5, 0.5),
            ZIndex = p122
        };
        local Frame2 = Instance.new("Frame");
        local u134 = i;

        for i2, v in v133 do
            Frame2[i2] = v;
        end;

        Frame2.Parent = p113;
        local u135 = v124(Frame2, p117, p118, 30, 30);
        local v136 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner = Instance.new("UICorner");

        for i2, v in v136 do
            UICorner[i2] = v;
        end;

        UICorner.Parent = u135;
        local v137 = {
            Transparency = 0.15,
            Color = p119,
            Thickness = u134 == 1 and 0.03 or 0.012,
            StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i2, v in v137 do
            UIStroke[i2] = v;
        end;

        UIStroke.Parent = u135;
        local u138 = u134 * 40 * (p120 and 1.3 or 1) + 210;
        task.delay((u134 - 1) * (p120 and 0.12 or 0), function() -- Line: 393
            -- upvalues: u135 (copy), u134 (copy), u138 (copy), u115 (copy), u116 (copy), TweenService (ref), UIStroke (copy)
            if u135.Parent then
                local v139 = {
                    Size = UDim2.fromScale(u138 / u115, u138 / u116)
                };
                TweenService:Create(u135, TweenInfo.new(u134 * 0.2 + 0.6, Enum.EasingStyle.Quart or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v139):Play();
                TweenService:Create(UIStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end);
        v124 = v124;
    end;

    local v140 = {
        Name = "Glints",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = p122 + 1
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v140 do
        Frame2[i] = v;
    end;

    Frame2.Parent = p113;
    local v141 = v124(Frame2, p117, p118, 460, 460);
    local v142 = p120 and 40 or 24;

    for i = 1, v142 do
        local v143 = i * 3.141592653589793 * 2 / v142 + p121:NextNumber(-0.1, 0.1);
        local v144 = p121:NextNumber(80, 150) * (p120 and 1.3 or 1);
        local v145 = {
            BorderSizePixel = 0,
            Name = "Glint" .. i,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.006521739130434782, p121:NextInteger(5, 11) / 460),
            Rotation = math.deg(v143)
        };
        local v146;

        if p120 and i % 3 == 0 then
            v146 = Color3_new_ret;
        else
            v146 = p119:Lerp(Color3_new_ret, 0.3);
        end;

        v145.BackgroundColor3 = v146;
        v145.ZIndex = p122 + 1;
        local Frame3 = Instance.new("Frame");
        local _ = i;

        for i2, v in v145 do
            Frame3[i2] = v;
        end;

        Frame3.Parent = v141;
        local v147 = p121:NextNumber(0.65, 1.1);
        local v148 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0.5 + math.cos(v143) * v144 / 460, 0.5 + math.sin(v143) * v144 / 460),
            Size = UDim2.fromScale(0.002173913043478261, 0.002173913043478261),
            Rotation = math.deg(v143) + 120
        };
        TweenService:Create(Frame3, TweenInfo.new(v147, Enum.EasingStyle.Quart or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v148):Play();
    end;
end;

local function rareGlow(p149, p150, p151, p152, p153, p154, p155, u156) -- Line: 435
    -- upvalues: TweenService (copy)
    local v157 = {
        Name = "RareGlow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://120639974824188",
        ImageTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = p154,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = p155
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v157 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p149;
    local u158 = p150(ImageLabel, p151, p152, p153, p153);
    TweenService:Create(u158, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0.25
    }):Play();
    task.delay(0.5, function() -- Line: 447
        -- upvalues: u158 (copy), u156 (copy), TweenService (ref)
        if u158.Parent and not u156.closed then
            local v159 = TweenService:Create(u158, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                ImageTransparency = 0.55
            });
            table.insert(u156, v159);
            v159:Play();
        end;
    end);

    return u158;
end;

local function crateShow(u160, u161, u162, u163, p164) -- Line: 468
    -- upvalues: prizeOf (copy), CrateCatalog (copy), u2 (copy), Color3_fromRGB_ret (copy), CrateRollConfig (copy), billboard (copy), plateParts (copy), soundBank (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), countBadge (copy), Color3_new_ret (copy), Color3_fromRGB_ret2 (copy), knifeView (copy), TweenService (copy), burst (copy), rareGlow (copy), emoteView (copy), fadeOut (copy), EmotePlayback (copy)
    local u165 = prizeOf(u160.crate, u160.prize);
    local v166 = CrateCatalog.get(u160.crate);

    if not (u165 and v166) then
        return nil;
    end;

    local u167 = u165.rarity == "Legendary" and true or u165.rarity == "Mythical";
    local u168 = u2[u165.rarity] or Color3_fromRGB_ret;
    local v169;

    if u167 then
        v169 = CrateRollConfig.RareHoldSeconds;
    else
        v169 = CrateRollConfig.HoldSeconds;
    end;

    local u170;

    if type(u160.seed) == "number" then
        u170 = Random.new(u160.seed);
    else
        u170 = Random.new();
    end;

    local u171 = 810;
    local u172 = 300;

    local function v178(p173, p174, p175, p176, p177) -- Line: 68
        -- upvalues: u171 (copy), u172 (copy)
        p173.Position = UDim2.fromScale(p174 / u171, p175 / u172);
        p173.Size = UDim2.fromScale(p176 / u171, p177 / u172);

        return p173;
    end;

    local ReelWidth = CrateRollConfig.ReelWidth;
    local u179 = billboard(u161, u163, ReelWidth, ReelWidth * 300 / 810, "CrateRoll_" .. tostring(u160.user));
    p164.gui = u179;
    local v180, v181 = plateParts(u163, u160.user, u161);
    local v182 = v180 + v181;

    if u179.StudsOffsetWorldSpace.Y ~= v182 then
        u179.StudsOffsetWorldSpace = Vector3.new(0, v182, 0);
    end;

    local v183 = {
        Name = "Canvas",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v183 do
        Frame[i] = v;
    end;

    Frame.Parent = u179;
    local u184 = soundBank(u161);
    local u185 = {};
    p164.sounds = u184;
    p164.loops = u185;
    local u186 = setmetatable({}, {
        __mode = "k"
    });

    local function textSize(p187) -- Line: 493
        -- upvalues: Frame (copy)
        local math_floor_ret = math.floor(Frame.AbsoluteSize.Y * p187 / 300);

        return math.clamp(math_floor_ret, 1, 100);
    end;

    local function fit(p188, p189) -- Line: 496
        -- upvalues: u186 (copy), Frame (copy)
        p188.TextScaled = false;
        u186[p188] = p189;
        local math_floor_ret = math.floor(Frame.AbsoluteSize.Y * p189 / 300);
        p188.TextSize = math.clamp(math_floor_ret, 1, 100);
    end;

    Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 501
        -- upvalues: u186 (copy), Frame (copy)
        for i, v in u186 do
            local math_floor_ret = math.floor(Frame.AbsoluteSize.Y * v / 300);
            i.TextSize = math.clamp(math_floor_ret, 1, 100);
        end;
    end);
    local table_create_ret = table.create(42);
    local u190 = true;
    local v191 = {
        opener = u162,
        head = u161
    };

    for i = 1, 42 do
        local v192;

        if i == 36 then
            table_create_ret[i] = u165;
            v192 = i;
        else
            local v193 = CrateCatalog.pick(u160.crate, u170:NextInteger(1, 10000));
            table_create_ret[i] = prizeOf(u160.crate, v193.Emote or v193.Skin) or u165;
            v192 = i;
        end;
    end;

    local v194 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        TextStrokeTransparency = 0.6,
        ZIndex = 6,
        Text = v166.Name,
        TextColor3 = Color3_fromRGB_ret3,
        Font = Enum.Font.GothamBold,
        TextStrokeColor3 = Color3_fromRGB_ret4
    };
    local TextLabel = Instance.new("TextLabel");
    local v195 = v178;

    for i, v in v194 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame;
    local u196 = v178(TextLabel, 150, 0, 510, 33);
    u196.TextStrokeTransparency = 0.45;
    countBadge(Frame, u160.count, v195, 18, 6, 92, 34, 7);
    local v197 = {
        Name = "Pointer",
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ZIndex = 20,
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame2 = Instance.new("Frame");
    local v198 = v195;

    for i, v in v197 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local u199 = v195(Frame2, 405, 46, 4, 252);
    local v200 = {
        Name = "Diamond",
        BorderSizePixel = 0,
        Rotation = 45,
        ZIndex = 21,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame3 = Instance.new("Frame");
    local u201 = v198;

    for i, v in v200 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local u202 = v198(Frame3, 405, 48, 22, 22);
    local u203 = {};
    local u204 = true;

    local function buildCard(p205) -- Line: 543
        -- upvalues: table_create_ret (copy), u2 (ref), Color3_fromRGB_ret3 (ref), Frame (copy), Color3_new_ret (ref), Color3_fromRGB_ret2 (ref), u204 (ref), knifeView (ref), Color3_fromRGB_ret4 (ref), u186 (copy)
        local v206 = table_create_ret[p205];
        local v207 = u2[v206.rarity] or Color3_fromRGB_ret3;
        local v208 = {
            BorderSizePixel = 0,
            ZIndex = 2,
            Name = "Card" .. p205,
            BackgroundColor3 = Color3_new_ret,
            Size = UDim2.fromScale(0.18518518518518517, 0.7533333333333333)
        };
        local Frame4 = Instance.new("Frame");

        for i, v in v208 do
            Frame4[i] = v;
        end;

        Frame4.Parent = Frame;
        local v209 = {
            CornerRadius = UDim.new(0.067, 0)
        };
        local UICorner = Instance.new("UICorner");

        for i, v in v209 do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame4;
        local v210 = {
            Thickness = 0.022,
            Transparency = 0.1,
            Color = v207,
            StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in v210 do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = Frame4;
        local v211 = {
            Rotation = 90,
            Color = ColorSequence.new(Color3_fromRGB_ret2, v207),
            Transparency = NumberSequence.new(0.2, 0.6)
        };
        local UIGradient = Instance.new("UIGradient");

        for i, v in v211 do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = Frame4;
        local v212 = {
            Name = "RarityLine",
            BorderSizePixel = 0,
            ZIndex = 3,
            BackgroundColor3 = v207,
            Position = UDim2.fromScale(0, 0.9778761061946902),
            Size = UDim2.fromScale(1, 0.022123893805309734)
        };
        local Frame5 = Instance.new("Frame");

        for i, v in v212 do
            Frame5[i] = v;
        end;

        Frame5.Parent = Frame4;
        local v213 = {
            Name = "Art",
            BackgroundTransparency = 1,
            ZIndex = 3,
            Position = UDim2.fromScale(0.02666666666666667, 0.06637168141592921),
            Size = UDim2.fromScale(0.9466666666666667, 0.6194690265486725)
        };
        local Frame6 = Instance.new("Frame");

        for i, v in v213 do
            Frame6[i] = v;
        end;

        Frame6.Parent = Frame4;
        local v214 = {
            { Frame4, "BackgroundTransparency", 0 },
            { UIStroke, "Transparency", 0.1 },
            { Frame5, "BackgroundTransparency", 0 }
        };
        local v215 = nil;

        if v206.kind == "Emote" then
            local v216 = {
                BackgroundTransparency = 1,
                Image = "rbxassetid://117630660259402",
                ZIndex = 3,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(0.647887323943662, 0.6571428571428571),
                ImageColor3 = v207:Lerp(Color3_new_ret, 0.35),
                ScaleType = Enum.ScaleType.Fit
            };
            local ImageLabel = Instance.new("ImageLabel");

            for i, v in v216 do
                ImageLabel[i] = v;
            end;

            ImageLabel.Parent = Frame6;
            table.insert(v214, { ImageLabel, "ImageTransparency", 0 });
        elseif u204 then
            v215 = knifeView(Frame6, v206.id, 3);

            if v215 then
                table.insert(v214, { v215.viewport, "ImageTransparency", 0 });
            end;
        end;

        local v217 = {
            BackgroundTransparency = 1,
            TextScaled = true,
            TextWrapped = true,
            TextStrokeTransparency = 0.6,
            ZIndex = 4,
            Text = v206.name,
            TextColor3 = Color3_new_ret,
            Font = Enum.Font.GothamBold,
            TextStrokeColor3 = Color3_fromRGB_ret4
        };
        local TextLabel2 = Instance.new("TextLabel");

        for i, v in v217 do
            TextLabel2[i] = v;
        end;

        TextLabel2.Parent = Frame4;
        TextLabel2.Position = UDim2.fromScale(0.05333333333333334, 0.6946902654867256);
        TextLabel2.Size = UDim2.fromScale(0.8933333333333333, 0.168141592920354);
        TextLabel2.TextScaled = false;
        u186[TextLabel2] = 16;
        local math_floor_ret = math.floor(Frame.AbsoluteSize.Y * 16 / 300);
        TextLabel2.TextSize = math.clamp(math_floor_ret, 1, 100);
        local v218 = {
            BackgroundTransparency = 1,
            TextScaled = true,
            TextWrapped = true,
            TextStrokeTransparency = 0.6,
            ZIndex = 4,
            Text = string.upper(v206.rarity),
            TextColor3 = v207,
            Font = Enum.Font.GothamBold,
            TextStrokeColor3 = Color3_fromRGB_ret4
        };
        local TextLabel3 = Instance.new("TextLabel");

        for i, v in v218 do
            TextLabel3[i] = v;
        end;

        TextLabel3.Parent = Frame4;
        TextLabel3.Position = UDim2.fromScale(0.03333333333333333, 0.8716814159292036);
        TextLabel3.Size = UDim2.fromScale(0.9333333333333333, 0.08849557522123894);
        TextLabel3.TextStrokeTransparency = 0.35;
        TextLabel3.TextScaled = false;
        u186[TextLabel3] = 13;
        local math_floor_ret2 = math.floor(Frame.AbsoluteSize.Y * 13 / 300);
        TextLabel3.TextSize = math.clamp(math_floor_ret2, 1, 100);
        table.insert(v214, { TextLabel2, "TextTransparency", 0 });
        table.insert(v214, { TextLabel2, "TextStrokeTransparency", 0.6 });
        table.insert(v214, { TextLabel3, "TextTransparency", 0 });
        table.insert(v214, { TextLabel3, "TextStrokeTransparency", 0.6 });

        return {
            frame = Frame4,
            fades = v214,
            view = v215
        };
    end;

    local function setAlpha(p219, p220) -- Line: 610
        for _, v in p219.fades do
            v[1][v[2]] = 1 - (1 - v[3]) * p220;
        end;
    end;

    local u221 = nil;
    local u222 = "spin";
    local u223 = 5.949999999999999 + v169;
    local u224 = nil;

    local function lay(p225, p226) -- Line: 624
        -- upvalues: u203 (copy), buildCard (copy)
        for i = 1, 42 do
            local v227 = (i - 1) * 162 + 405 + 75 - p225;
            local math_abs_ret = math.abs(v227 - 405);
            local v228 = u203[i];
            local v229;

            if math_abs_ret < 400 then
                if not v228 then
                    v228 = buildCard(i);
                    u203[i] = v228;
                end;

                v228.frame.Position = UDim2.fromScale((v227 - 75) / 810, 0.2);
                local math_clamp_ret = math.clamp((400 - math_abs_ret) / 150, 0, 1);
                v229 = i;

                for _, v in v228.fades do
                    v[1][v[2]] = 1 - (1 - v[3]) * math_clamp_ret;
                end;

                if v228.view and math_abs_ret < 243 then
                    local view = v228.view;
                    local v230 = p226 * 0.3;
                    local extent = view.extent;
                    local v231 = view.reach or 1.9;
                    local camera = view.camera;
                    local CFrame_lookAt = CFrame.lookAt;
                    local v232 = math.sin(v230) * extent * v231;
                    local v233 = math.cos(v230) * extent * v231;
                    camera.CFrame = CFrame_lookAt(Vector3.new(v232, extent * 0.4, v233), Vector3.new(0, 0, 0));
                end;
            elseif v228 then
                v228.frame:Destroy();
                u203[i] = nil;
                v229 = i;
            else
                v229 = i;
            end;
        end;
    end;

    local function land() -- Line: 647
        -- upvalues: u222 (ref), lay (copy), u184 (copy), u203 (copy), u168 (copy), TweenService (ref), Color3_fromRGB_ret2 (ref)
        u222 = "land";
        lay(5745, os.clock());
        u184.play("CrateTick", 0.65);
        local v234 = u203[36];

        if v234 then
            local frame = v234.frame;
            local v235 = {
                Name = "WinFlash",
                BackgroundTransparency = 0.25,
                BorderSizePixel = 0,
                ZIndex = 8,
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = u168
            };
            local Frame4 = Instance.new("Frame");

            for i, v in v235 do
                Frame4[i] = v;
            end;

            Frame4.Parent = frame;
            local v236 = {
                CornerRadius = UDim.new(0.067, 0)
            };
            local UICorner = Instance.new("UICorner");

            for i, v in v236 do
                UICorner[i] = v;
            end;

            UICorner.Parent = Frame4;
            TweenService:Create(Frame4, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            local frame2 = v234.frame;
            local v237 = {
                BackgroundColor3 = u168:Lerp(Color3_fromRGB_ret2, 0.65)
            };
            TweenService:Create(frame2, TweenInfo.new(0.24, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v237):Play();
        end;

        for i, v in u203 do
            if i ~= 36 then
                for _, v2 in v.fades do
                    local v238 = {
                        [v2[2]] = 1
                    };
                    TweenService:Create(v2[1], TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v238):Play();
                end;
            end;
        end;
    end;

    local function reveal(p239) -- Line: 675
        -- upvalues: u222 (ref), u203 (copy), u199 (copy), u202 (copy), u196 (copy), u165 (copy), u168 (copy), TweenService (ref), burst (ref), Frame (copy), u201 (copy), u167 (copy), u170 (copy), rareGlow (ref), u185 (copy), u224 (ref), u162 (copy), emoteView (ref), Color3_new_ret (ref), knifeView (ref), u184 (copy), u190 (ref)
        u222 = "reveal";

        for i, v in u203 do
            v.frame:Destroy();
            u203[i] = nil;
        end;

        u199:Destroy();
        u202:Destroy();
        u196.Text = string.upper(u165.rarity) .. " · " .. string.upper(u165.name);
        u196.TextColor3 = u168;
        u196.Font = Enum.Font.GothamBlack;
        u196.TextStrokeTransparency = 0.35;

        if not p239 then
            u196.TextTransparency = 1;
            TweenService:Create(u196, TweenInfo.new(0.3, Enum.EasingStyle.Quart or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play();
            burst(Frame, u201, 810, 300, 405, 173, u168, u167, u170, 3);
        end;

        if u167 then
            rareGlow(Frame, u201, 405, 173, 330, u168, 1, u185);
        end;

        local v240 = u165.kind == "Emote";
        local v241 = {
            BackgroundTransparency = 1,
            ZIndex = 5,
            Name = v240 and "WinningEmote" or "WinningKnife",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Rotation = (p239 or v240) and 0 or -70
        };
        local Frame4 = Instance.new("Frame");

        for i, v in v241 do
            Frame4[i] = v;
        end;

        Frame4.Parent = Frame;
        local u242 = u201(Frame4, 405, 173, 230, 230);
        local UIScale = Instance.new("UIScale");

        for i, v in {
            Scale = p239 and 1 or 0.15
        } do
            UIScale[i] = v;
        end;

        UIScale.Parent = u242;
        local v243 = {
            Name = "Sunray",
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ImageTransparency = 0.55,
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1.5, 1.5),
            ImageColor3 = u168,
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v in v243 do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = u242;
        local v244 = {
            Name = "Halo",
            Rotation = 45,
            BackgroundTransparency = 0.9,
            ZIndex = 5,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.782608695652174, 0.782608695652174),
            BackgroundColor3 = u168
        };
        local Frame5 = Instance.new("Frame");

        for i, v in v244 do
            Frame5[i] = v;
        end;

        Frame5.Parent = u242;
        local v245 = {
            CornerRadius = UDim.new(0.13, 0)
        };
        local UICorner = Instance.new("UICorner");

        for i, v in v245 do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame5;
        local v246 = {
            Thickness = 0.02,
            Transparency = 0.45,
            Color = u168,
            StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in v246 do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = Frame5;
        TweenService:Create(Frame5, TweenInfo.new(1.4, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Rotation = 135
        }):Play();
        local v247 = {
            Name = "Content",
            BackgroundTransparency = 1,
            ZIndex = 6,
            Size = UDim2.fromScale(1, 1)
        };
        local Frame6 = Instance.new("Frame");

        for i, v in v247 do
            Frame6[i] = v;
        end;

        Frame6.Parent = u242;

        if v240 then
            local v248 = u162.Character and emoteView(Frame6, u162.Character, u165.id, 6);
            u224 = v248;

            if not u224 then
                local v249 = {
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://117630660259402",
                    ZIndex = 6,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromScale(0.5217391304347826, 0.5217391304347826),
                    ImageColor3 = u168:Lerp(Color3_new_ret, 0.35),
                    ScaleType = Enum.ScaleType.Fit
                };
                local ImageLabel2 = Instance.new("ImageLabel");

                for i, v in v249 do
                    ImageLabel2[i] = v;
                end;

                ImageLabel2.Parent = Frame6;
            end;
        else
            u224 = knifeView(Frame6, u165.id, 6);
        end;

        if p239 then
            return;
        end;

        u184.play("CrateOpen", 1.35);
        TweenService:Create(UIScale, TweenInfo.new(0.65, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.12
        }):Play();
        TweenService:Create(u242, TweenInfo.new(0.65, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Rotation = v240 and 0 or 4
        }):Play();
        task.delay(0.55, function() -- Line: 760
            -- upvalues: u190 (ref), u184 (ref), u167 (ref), UIScale (copy), TweenService (ref), u242 (copy)
            if not u190 then
                return;
            end;

            u184.play("CrateReward", u167 and 0.9 or 1, u167 and 1.7 or 1);

            if u167 then
                u184.play("Jackpot", 1, 1.6);
            end;

            TweenService:Create(UIScale, TweenInfo.new(0.55, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            TweenService:Create(u242, TweenInfo.new(0.55, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Rotation = 0
            }):Play();
        end);
    end;

    local u250 = false;
    local u251 = true;

    function v191.step(p252, p253, p254) -- Line: 778
        -- upvalues: u160 (copy), u223 (copy), CrateRollConfig (ref), u204 (ref), u251 (ref), u179 (copy), u184 (copy), u163 (copy), u161 (copy), plateParts (ref), u222 (ref), reveal (copy), land (copy), u221 (ref), lay (copy), u199 (copy), u224 (ref), u250 (ref), fadeOut (ref)
        local v255 = p253 - u160.at;

        if u223 + 0.4 <= v255 then
            return false;
        end;

        local v256 = p254 <= CrateRollConfig.MaxDistance;
        u204 = p254 <= CrateRollConfig.DetailDistance;
        local v257 = CrateRollConfig.MinCameraDistance <= p254;

        if v257 ~= u251 then
            u251 = v257;
            u179.Enabled = v257;
            u184.mute(not v257);
        end;

        local v258 = u179;
        local v259, v260 = plateParts(u163, u160.user, u161);
        local v261 = v259 + v260;

        if v258.StudsOffsetWorldSpace.Y ~= v261 then
            v258.StudsOffsetWorldSpace = Vector3.new(0, v261, 0);
        end;

        local os_clock_ret = os.clock();

        if u222 == "spin" then
            if v255 >= 5.949999999999999 then
                reveal(true);
            elseif v255 >= 5.6 then
                land();
            elseif v256 then
                local math_clamp_ret = math.clamp(v255 / 5.6, 0, 1);
                local v262 = (1 - (1 - math_clamp_ret) ^ 4) * 5346 + 399;
                lay(v262, os_clock_ret);
                local v263 = math.floor((v262 + 6) / 162) + 1;

                if u221 and v263 ~= u221 then
                    u184.play("CrateTick", (1 - math_clamp_ret) * 0.6 + 0.85);
                    u199.BackgroundTransparency = 0;
                else
                    u199.BackgroundTransparency = math.min(0.35, u199.BackgroundTransparency + 0.05);
                end;

                u221 = v263;
            else
                u221 = nil;
            end;
        elseif u222 == "land" and v255 >= 5.949999999999999 then
            reveal(false);
        end;

        if v256 and (u224 and u224.camera) then
            local v264 = u224;
            local v265 = os_clock_ret * 0.3;
            local extent = v264.extent;
            local v266 = v264.reach or 1.9;
            local camera = v264.camera;
            local CFrame_lookAt = CFrame.lookAt;
            local v267 = math.sin(v265) * extent * v266;
            local v268 = math.cos(v265) * extent * v266;
            camera.CFrame = CFrame_lookAt(Vector3.new(v267, extent * 0.4, v268), Vector3.new(0, 0, 0));
        end;

        if not u250 and u223 <= v255 then
            u250 = true;
            fadeOut(u179, 0.4);
        end;

        return true;
    end;

    function v191.destroy(p269) -- Line: 829
        -- upvalues: u190 (ref), u185 (copy), u179 (copy), u184 (copy), u224 (ref), EmotePlayback (ref)
        u190 = false;
        u185.closed = true;
        u179:Destroy();
        u184.destroy();

        for _, v in ipairs(u185) do
            v:Cancel();
        end;

        if u224 and u224.track then
            EmotePlayback.dispose(u224.track);
        end;
    end;

    local v270 = workspace:GetServerTimeNow() - u160.at;

    if v270 >= 5.949999999999999 then
        reveal(true);
    elseif v270 < 1 then
        u184.play("CrateOpen");
    end;

    return v191;
end;

local u271 = {
    { 100, "Legendary", Color3.fromRGB(242, 191, 89) },
    { 500, "Epic", Color3.fromRGB(183, 123, 244) },
    { 2000, "Rare", Color3.fromRGB(92, 173, 238) },
    { 3000, "Uncommon", Color3.fromRGB(104, 211, 122) },
    { (1 / 0), "Common", Color3.fromRGB(214, 220, 226) }
};

local function pumpkinPrizeOf(p272) -- Line: 884
    -- upvalues: PumpkinHuntConfig (copy), SkinCatalog (copy), u271 (copy)
    local chance = p272.chance;

    if type(p272.prize) ~= "string" or not (PumpkinHuntConfig.whole(chance) and (chance >= PumpkinHuntConfig.KnifeChanceMin and PumpkinHuntConfig.KnifeChanceMax >= chance)) then
        return nil;
    end;

    local v273 = PumpkinHuntConfig.slots(chance);

    for i, v in v273 do
        if v.id == p272.prize then
            local kind = v.kind;
            local name = v.name;

            if kind == "Knife" then
                local v274 = SkinCatalog.get(PumpkinHuntConfig.Knife);
                name = v274 and v274.Name or PumpkinHuntConfig.Knife;
            elseif kind == "CandyCorn" and (p272.paid == "Coins" and (type(p272.name) == "string" and #p272.name <= 40)) then
                name = p272.name;
                kind = "Coins";
            end;

            local v275 = v.kind == "Knife" and 0 or PumpkinHuntConfig.percents(v273)[i];

            for i2, v2 in u271 do
                if v275 <= v2[1] then
                    return {
                        kind = kind,
                        name = name,
                        rarity = v2[2],
                        color = v2[3],
                        level = #u271 - i2
                    };
                end;
            end;
        end;
    end;

    return nil;
end;

local function pumpkinShow(u276, u277, p278, u279, p280) -- Line: 915
    -- upvalues: pumpkinPrizeOf (copy), ChickenOrHero (copy), PumpkinHuntConfig (copy), CrateRollConfig (copy), billboard (copy), plateParts (copy), Color3_fromRGB_ret4 (copy), TweenService (copy), fadeOut (copy)
    local u281 = pumpkinPrizeOf(u276);

    if not u281 then
        return nil;
    end;

    local PumpkinFloat = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("PumpkinFloat"));
    local v282 = PumpkinHuntConfig.tier(u276.chance);
    local u283;

    if u281.rarity == "Legendary" or u281.rarity == "Mythical" then
        u283 = CrateRollConfig.RareHoldSeconds;
    else
        u283 = CrateRollConfig.HoldSeconds;
    end;

    local PumpkinSize = CrateRollConfig.PumpkinSize;
    local u284 = billboard(u277, u279, 5.5, 0.5, "PumpkinRoll_" .. tostring(u276.user));
    p280.gui = u284;

    local function stack() -- Line: 929
        -- upvalues: plateParts (ref), u279 (copy), u276 (copy), u277 (copy), PumpkinSize (copy), u284 (copy)
        local v285, v286 = plateParts(u279, u276.user, u277);
        local v287 = v286 + PumpkinSize * 0.81 + 0.15;

        if u284.StudsOffsetWorldSpace.Y ~= v285 then
            u284.StudsOffsetWorldSpace = Vector3.new(0, v285, 0);
        end;

        if u284.StudsOffset.Y ~= v287 then
            u284.StudsOffset = Vector3.new(0, v287, 0);
        end;
    end;

    local v288, v289 = plateParts(u279, u276.user, u277);
    local v290 = v289 + PumpkinSize * 0.81 + 0.15;

    if u284.StudsOffsetWorldSpace.Y ~= v288 then
        u284.StudsOffsetWorldSpace = Vector3.new(0, v288, 0);
    end;

    if u284.StudsOffset.Y ~= v290 then
        u284.StudsOffset = Vector3.new(0, v290, 0);
    end;

    local v291 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        TextStrokeTransparency = 0.6,
        ZIndex = 2,
        Text = string.upper(v282.Name) .. " PUMPKIN",
        TextColor3 = v282.Color,
        Font = Enum.Font.GothamBlack,
        TextStrokeColor3 = Color3_fromRGB_ret4
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v291 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = u284;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.TextStrokeTransparency = 1;
    local v292 = {
        Thickness = 0.07,
        Transparency = 0.1,
        Color = Color3_fromRGB_ret4,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v292 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 1
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = TextLabel;
    local Attachment = Instance.new("Attachment");

    for i, v in {
        Name = "PumpkinRollSounds"
    } do
        Attachment[i] = v;
    end;

    Attachment.Parent = u277;
    p280.voice = Attachment;
    local u293 = PumpkinFloat.new(nil);
    p280.float = u293;
    u293.voice = {
        volume = 0.4,
        parent = Attachment,
        near = CrateRollConfig.SoundMinDistance,
        far = CrateRollConfig.SoundMaxDistance
    };
    u293.lights = false;
    u293.facing = true;

    function u293.layout(p294) -- Line: 960
        -- upvalues: u277 (copy), plateParts (ref), u279 (copy), u276 (copy), PumpkinSize (copy)
        if not u277.Parent then
            return nil;
        end;

        local v295, v296 = plateParts(u279, u276.user, u277);

        return u277.Position + Vector3.new(0, v295, 0) + p294.CFrame.UpVector * (v296 + PumpkinSize * 0.42), PumpkinSize;
    end;

    u293:folder().Name = "PumpkinRoll_" .. tostring(u276.user);
    local v297 = {
        opener = p278,
        head = u277
    };
    local u298 = true;
    local u299 = nil;
    local u300 = {
        kind = u281.kind,
        knife = PumpkinHuntConfig.Knife
    };

    local function u302(p301) -- Line: 974
        -- upvalues: u299 (ref), TextLabel (copy), u281 (copy), u293 (copy), u300 (copy), u298 (ref), UIScale (copy), TweenService (ref)
        u299 = os.clock();
        TextLabel.Text = string.upper(u281.rarity) .. " · " .. string.upper(u281.name);
        TextLabel.TextColor3 = u281.color;
        u293:reward(u300, u281.color, u281.level);

        if p301 then
            return;
        end;

        u293:landed();
        task.delay(0.18, function() -- Line: 983
            -- upvalues: u298 (ref), UIScale (ref), TweenService (ref), u293 (ref)
            if u298 then
                UIScale.Scale = 1.8;
                TweenService:Create(UIScale, TweenInfo.new(0.32, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();
                u293:slam();
            end;
        end);
    end;

    local u303 = workspace:GetServerTimeNow() - u276.at;

    if u303 >= 2.9 then
        u299 = os.clock();
        TextLabel.Text = string.upper(u281.rarity) .. " · " .. string.upper(u281.name);
        TextLabel.TextColor3 = u281.color;
        u293:reward(u300, u281.color, u281.level);
    else
        u293:present(u276.chance);
        task.spawn(function() -- Line: 996
            -- upvalues: u303 (copy), u298 (ref), u293 (copy), u281 (copy), u302 (copy)
            task.wait((math.max(0, 0.35 - u303)));

            if not u298 then
                return;
            end;

            u293:anticipate();

            if not (u293:burst(u281.color, u281.level) and u298) then
                return;
            end;

            task.wait(0.1);

            if u298 then
                u302(false);
            end;
        end);
    end;

    local u304 = nil;
    local u305 = true;

    function v297.step(p306, p307, p308) -- Line: 1016
        -- upvalues: u276 (copy), CrateRollConfig (ref), u305 (ref), u284 (copy), u293 (copy), plateParts (ref), u279 (copy), u277 (copy), PumpkinSize (copy), u299 (ref), u304 (ref), u283 (copy), fadeOut (ref)
        if p307 - u276.at > 2.9 + CrateRollConfig.RareHoldSeconds + 6 then
            return false;
        end;

        local v309 = p308 <= CrateRollConfig.MaxDistance;
        local v310 = CrateRollConfig.MinCameraDistance <= p308;

        if v310 ~= u305 then
            u305 = v310;
            u284.Enabled = v310;
        end;

        u293.hidden = not (v309 and v310);
        local v311, v312 = plateParts(u279, u276.user, u277);
        local v313 = v312 + PumpkinSize * 0.81 + 0.15;

        if u284.StudsOffsetWorldSpace.Y ~= v311 then
            u284.StudsOffsetWorldSpace = Vector3.new(0, v311, 0);
        end;

        if u284.StudsOffset.Y ~= v313 then
            u284.StudsOffset = Vector3.new(0, v313, 0);
        end;

        if u299 and (not u304 and u283 <= os.clock() - u299) then
            u304 = os.clock();
            fadeOut(u284, 0.4);
            u293:clearReward();
        end;

        local v314 = u304 and os.clock() - u304 >= 0.4;

        return not v314;
    end;

    function v297.destroy(p315) -- Line: 1036
        -- upvalues: u298 (ref), u284 (copy), u293 (copy), Attachment (copy)
        u298 = false;
        u284:Destroy();
        u293:dismiss(true);

        if u293.holder then
            u293.holder:Destroy();
        end;

        Attachment:Destroy();
    end;

    return v297;
end;

local function wheelArt(p316) -- Line: 1073
    local v317 = game:GetService("StarterGui"):FindFirstChild("SpinWheel") or p316:FindFirstChild("SpinWheel");

    if v317 then
        v317 = v317:FindFirstChild("Main");
    end;

    if v317 then
        v317 = v317:FindFirstChild("Wheel");
    end;

    if not (v317 and v317:FindFirstChild("Spinner")) then
        return nil;
    end;

    local v318 = v317:Clone();

    for _, v in { "MultiScale", "MultiRing", "MultiChip" } do
        local v319 = v318:FindFirstChild(v);

        if v319 then
            v319:Destroy();
        end;
    end;

    for _, descendant in v318:GetDescendants() do
        if descendant:IsA("GuiObject") then
            local Position = descendant.Position;
            local Size = descendant.Size;
            descendant.Position = UDim2.fromScale(Position.X.Scale, Position.Y.Scale);
            descendant.Size = UDim2.fromScale(Size.X.Scale, Size.Y.Scale);
        elseif descendant:IsA("UIStroke") and descendant.StrokeSizingMode ~= Enum.StrokeSizingMode.ScaledSize then
            descendant.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
            descendant.Thickness = 0.04;
        elseif descendant:IsA("LuaSourceContainer") then
            descendant:Destroy();
        end;
    end;

    v318.Visible = true;
    v318.Spinner.Rotation = -30;
    v318.Spinner.Size = UDim2.fromScale(0.95, 0.95);

    return v318;
end;

local function wheelShow(u320, u321, p322, u323, p324) -- Line: 1106
    -- upvalues: SkinCatalog (copy), wheelArt (copy), CrateRollConfig (copy), billboard (copy), plateParts (copy), soundBank (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), TweenService (copy), Color3_new_ret (copy), burst (copy), rareGlow (copy), knifeView (copy), fadeOut (copy)
    local v325;

    if type(u320.knife) == "string" then
        v325 = SkinCatalog.get(u320.knife);
    else
        v325 = false;
    end;

    local angle = u320.angle;

    if not (v325 and (type(u320.prize) == "string" and (type(angle) == "number" and math.abs(angle) <= 360))) then
        return nil;
    end;

    local v326 = wheelArt(u323);
    local u327;

    if v326 then
        u327 = v326.Spinner:FindFirstChild(u320.prize);
    else
        u327 = v326;
    end;

    if not u327 then
        if v326 then
            v326:Destroy();
        end;

        return nil;
    end;

    local v328 = u320.count == 5 and true or u320.count == 10;
    local u329 = v328 and 0.45 or 0;
    local u330 = u329 + (v328 and 5.6 or 5.1);
    local u331 = u330 + 0.35;
    local u332 = u331 + CrateRollConfig.RareHoldSeconds;
    local u333 = angle + math.ceil((2130 - angle) / 360) * 360;
    local u334;

    if type(u320.seed) == "number" then
        u334 = Random.new(u320.seed);
    else
        u334 = Random.new();
    end;

    local u335 = 560;
    local u336 = 720;

    local function v342(p337, p338, p339, p340, p341) -- Line: 68
        -- upvalues: u335 (copy), u336 (copy)
        p337.Position = UDim2.fromScale(p338 / u335, p339 / u336);
        p337.Size = UDim2.fromScale(p340 / u335, p341 / u336);

        return p337;
    end;

    local v343 = CrateRollConfig.WheelWidth * 560 / 300;
    local u344 = billboard(u321, u323, v343, v343 * 720 / 560, "WheelRoll_" .. tostring(u320.user));
    p324.gui = u344;
    local v345, v346 = plateParts(u323, u320.user, u321);
    local v347 = v345 + v346;

    if u344.StudsOffsetWorldSpace.Y ~= v347 then
        u344.StudsOffsetWorldSpace = Vector3.new(0, v347, 0);
    end;

    local v348 = {
        Name = "Canvas",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v348 do
        Frame[i] = v;
    end;

    Frame.Parent = u344;
    local u349 = soundBank(u321);
    local u350 = {};
    p324.sounds = u349;
    p324.loops = u350;
    v326.AnchorPoint = Vector2.new(0.5, 0.5);
    v326.ZIndex = 2;
    v342(v326, 280, 570, 300, 300);
    v326.Parent = Frame;
    local Spinner = v326.Spinner;
    local UIScale = Instance.new("UIScale");
    local u351 = true;
    local v352 = {
        opener = p322,
        head = u321
    };

    for i, v in {
        Scale = 1
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = v326;
    local v353 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        TextStrokeTransparency = 0.6,
        ZIndex = 8,
        Text = string.upper(v325.Name or u320.knife) .. "!",
        TextColor3 = Color3_fromRGB_ret,
        Font = Enum.Font.GothamBlack,
        TextStrokeColor3 = Color3_fromRGB_ret4
    };
    local TextLabel = Instance.new("TextLabel");
    local u354 = v342;

    for i, v in v353 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame;
    local u355 = v342(TextLabel, 20, 4, 520, 62);
    u355.TextStrokeTransparency = 1;
    u355.Visible = false;
    local v356 = {
        Thickness = 0.07,
        Transparency = 0.1,
        Color = Color3_fromRGB_ret4,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v356 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = u355;
    local UIScale2 = Instance.new("UIScale");

    for i, v in {
        Scale = 1
    } do
        UIScale2[i] = v;
    end;

    UIScale2.Parent = u355;
    local u357 = "spin";
    local u358 = nil;
    local u359 = nil;
    local u360 = 0;

    local function turn(p361) -- Line: 1165
        -- upvalues: u329 (copy), u330 (copy), Spinner (copy), u333 (copy)
        local math_clamp_ret = math.clamp((p361 - u329) / (u330 - u329), 0, 1);
        Spinner.Rotation = -30 + (u333 - -30) * (1 - (1 - math_clamp_ret) ^ 5);
    end;

    local function u362() -- Line: 1171
        -- upvalues: u357 (ref), Spinner (copy), angle (copy), u349 (copy), UIScale (copy), TweenService (ref), u327 (copy), Color3_new_ret (ref)
        u357 = "land";
        Spinner.Rotation = angle;
        u349.play("WheelTick", 0.7);
        UIScale.Scale = 1.06;
        TweenService:Create(UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();

        if u327:IsA("ImageLabel") then
            local ImageColor3 = u327.ImageColor3;
            u327.ImageColor3 = Color3_new_ret;
            TweenService:Create(u327, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageColor3 = ImageColor3
            }):Play();
        end;
    end;

    local function u370(p363) -- Line: 1185
        -- upvalues: u357 (ref), Spinner (copy), angle (copy), u355 (copy), TweenService (ref), UIScale2 (copy), burst (ref), Frame (copy), u354 (copy), Color3_fromRGB_ret (ref), u334 (copy), rareGlow (ref), u350 (copy), Color3_fromRGB_ret4 (ref), u358 (ref), knifeView (ref), u320 (copy), u349 (copy), u351 (ref)
        u357 = "reveal";
        Spinner.Rotation = angle;
        u355.Visible = true;

        if not p363 then
            u355.TextTransparency = 1;
            TweenService:Create(u355, TweenInfo.new(0.3, Enum.EasingStyle.Quart or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play();
            UIScale2.Scale = 1.8;
            TweenService:Create(UIScale2, TweenInfo.new(0.32, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            burst(Frame, u354, 560, 720, 280, 250, Color3_fromRGB_ret, true, u334, 3);
        end;

        rareGlow(Frame, u354, 280, 250, 360, Color3_fromRGB_ret, 1, u350);
        local v364 = {
            Name = "WinningKnife",
            BackgroundTransparency = 1,
            ZIndex = 5,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Rotation = p363 and 0 or -70
        };
        local Frame2 = Instance.new("Frame");

        for i, v in v364 do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;
        local u365 = u354(Frame2, 280, p363 and 250 or 570, 360, 360);
        local UIScale3 = Instance.new("UIScale");

        for i, v in {
            Scale = p363 and 1 or 0.15
        } do
            UIScale3[i] = v;
        end;

        UIScale3.Parent = u365;
        local v366 = {
            Name = "Backing",
            BackgroundTransparency = 1,
            Image = "rbxassetid://120639974824188",
            ImageTransparency = 0.55,
            ZIndex = 3,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.95, 0.95),
            ImageColor3 = Color3_fromRGB_ret4,
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v in v366 do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = u365;
        local v367 = {
            Name = "Sunray",
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ImageTransparency = 0.55,
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1.25, 1.25),
            ImageColor3 = Color3_fromRGB_ret,
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel2 = Instance.new("ImageLabel");

        for i, v in v367 do
            ImageLabel2[i] = v;
        end;

        ImageLabel2.Parent = u365;
        local v368 = {
            Name = "Content",
            BackgroundTransparency = 1,
            ZIndex = 6,
            Size = UDim2.fromScale(1, 1)
        };
        local Frame3 = Instance.new("Frame");

        for i, v in v368 do
            Frame3[i] = v;
        end;

        Frame3.Parent = u365;
        u358 = knifeView(Frame3, u320.knife, 6);

        if u358 then
            u358.viewport.Ambient = Color3.fromRGB(255, 238, 200);
            u358.viewport.LightColor = Color3.fromRGB(255, 246, 220);
        end;

        if p363 then
            return;
        end;

        u349.play("CrateOpen", 1.35);
        local v369 = {
            Rotation = 4,
            Position = UDim2.fromScale(0.5, 0.3472222222222222)
        };
        TweenService:Create(u365, TweenInfo.new(0.65, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v369):Play();
        TweenService:Create(UIScale3, TweenInfo.new(0.65, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.12
        }):Play();
        task.delay(0.55, function() -- Line: 1252
            -- upvalues: u351 (ref), u349 (ref), UIScale3 (copy), TweenService (ref), u365 (copy)
            if not u351 then
                return;
            end;

            u349.play("CrateReward", 0.9, 1.7);
            u349.play("Jackpot", 1, 1.6);
            TweenService:Create(UIScale3, TweenInfo.new(0.55, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            TweenService:Create(u365, TweenInfo.new(0.55, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Rotation = 0
            }):Play();
        end);
    end;

    local u371 = false;
    local u372 = true;

    function v352.step(p373, p374, p375) -- Line: 1267
        -- upvalues: u320 (copy), u332 (copy), CrateRollConfig (ref), u372 (ref), u344 (copy), u349 (copy), u323 (copy), u321 (copy), plateParts (ref), u357 (ref), u331 (copy), u370 (copy), u330 (copy), u362 (copy), u359 (ref), u329 (copy), Spinner (copy), u333 (copy), u360 (ref), u358 (ref), u371 (ref), fadeOut (ref)
        local v376 = p374 - u320.at;

        if u332 + 0.4 <= v376 then
            return false;
        end;

        local v377 = p375 <= CrateRollConfig.MaxDistance;
        local v378 = CrateRollConfig.MinCameraDistance <= p375;

        if v378 ~= u372 then
            u372 = v378;
            u344.Enabled = v378;
            u349.mute(not v378);
        end;

        local v379 = u344;
        local v380, v381 = plateParts(u323, u320.user, u321);
        local v382 = v380 + v381;

        if v379.StudsOffsetWorldSpace.Y ~= v382 then
            v379.StudsOffsetWorldSpace = Vector3.new(0, v382, 0);
        end;

        if u357 == "spin" then
            if u331 <= v376 then
                u370(true);
            elseif u330 <= v376 then
                u362();
            elseif v377 then
                local math_clamp_ret = math.clamp((v376 - u329) / (u330 - u329), 0, 1);
                Spinner.Rotation = -30 + (u333 - -30) * (1 - (1 - math_clamp_ret) ^ 5);
                local math_floor_ret = math.floor((Spinner.Rotation + 30) / 60);

                if u359 and (math_floor_ret ~= u359 and os.clock() - u360 >= 0.05) then
                    u360 = os.clock();
                    u349.play("WheelTick");
                end;

                u359 = math_floor_ret;
            else
                u359 = nil;
            end;
        elseif u357 == "land" and u331 <= v376 then
            u370(false);
        end;

        if v377 and (u358 and u358.camera) then
            local v383 = u358;
            local v384 = os.clock() * 0.3;
            local extent = v383.extent;
            local v385 = v383.reach or 1.9;
            local camera = v383.camera;
            local CFrame_lookAt = CFrame.lookAt;
            local v386 = math.sin(v384) * extent * v385;
            local v387 = math.cos(v384) * extent * v385;
            camera.CFrame = CFrame_lookAt(Vector3.new(v386, extent * 0.4, v387), Vector3.new(0, 0, 0));
        end;

        if not u371 and u332 <= v376 then
            u371 = true;
            fadeOut(u344, 0.4);
        end;

        return true;
    end;

    function v352.destroy(p388) -- Line: 1311
        -- upvalues: u351 (ref), u350 (copy), u344 (copy), u349 (copy)
        u351 = false;
        u350.closed = true;
        u344:Destroy();
        u349.destroy();

        for _, v in ipairs(u350) do
            v:Cancel();
        end;
    end;

    local v389 = workspace:GetServerTimeNow() - u320.at;

    if u331 <= v389 then
        u370(true);
    else
        local math_clamp_ret = math.clamp((v389 - u329) / (u330 - u329), 0, 1);
        Spinner.Rotation = -30 + (u333 - -30) * (1 - (1 - math_clamp_ret) ^ 5);
    end;

    return v352;
end;

function v1.new(p390, p391, p392, p393) -- Line: 1334
    -- upvalues: crateShow (copy), pumpkinShow (copy), wheelShow (copy)
    if type(p390) ~= "table" or (type(p390.at) ~= "number" or not (p391 and p392)) then
        return nil;
    end;

    local v394;

    if p390.kind == "Crate" then
        v394 = crateShow;
    elseif p390.kind == "Pumpkin" then
        v394 = pumpkinShow;
    elseif p390.kind == "Wheel" then
        v394 = wheelShow;
    else
        v394 = nil;
    end;

    if not v394 then
        return nil;
    end;

    local u395 = {};
    local success, result = pcall(v394, p390, p391, p392, p393, u395);

    if success and result then
        return result;
    end;

    if u395.loops then
        u395.loops.closed = true;

        for _, v in ipairs(u395.loops) do
            v:Cancel();
        end;
    end;

    if u395.gui then
        u395.gui:Destroy();
    end;

    if u395.sounds then
        u395.sounds.destroy();
    end;

    if u395.float then
        pcall(function() -- Line: 1366
            -- upvalues: u395 (copy)
            u395.float:dismiss(true);

            if u395.float.holder then
                u395.float.holder:Destroy();
            end;
        end);
    end;

    if u395.voice then
        u395.voice:Destroy();
    end;

    if not success then
        warn("[CrateRolls]", result);
    end;

    return nil;
end;

return v1;