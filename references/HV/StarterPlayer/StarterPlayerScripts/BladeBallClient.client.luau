 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local TouchActionButton = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("TouchActionButton"));
local Game = ChickenOrHero:WaitForChild("Game");
local BladeBallConfig = require(Game:WaitForChild("BladeBallConfig"));
local BladeBallPhysics = require(Game:WaitForChild("BladeBallPhysics"));
local Session = Game:WaitForChild("Session");
local BladeBallEvent = Game:WaitForChild("BladeBallEvent");
local BladeBallSnapshot = Game:WaitForChild("BladeBallSnapshot");
local Color3_fromRGB_ret = Color3.fromRGB(255, 52, 52);
local Color3_fromRGB_ret2 = Color3.fromRGB(120, 220, 255);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret3 = Color3.fromRGB(235, 235, 240);
local Color3_fromRGB_ret4 = Color3.fromRGB(25, 80, 255);
local Color3_fromRGB_ret5 = Color3.fromRGB(205, 238, 255);
local Color3_fromRGB_ret6 = Color3.fromRGB(60, 60, 66);
local TouchEnabled = UserInputService.TouchEnabled;
local u1 = TouchEnabled and 38 or 76;
local u2 = TouchEnabled and 43 or 86;
local u3 = false;
local u4 = nil;
local u5 = {
    st = "Serve",
    tg = 0,
    t = 0
};
local u6 = Vector3.new(0, 0, 0);
local CFrame_identity = CFrame.identity;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = 0;
local u11 = nil;
local u12 = (-1 / 0);
local u13 = 0;
local u14 = nil;
local u15 = nil;
local u16 = nil;

local function now() -- Line: 52
    return workspace:GetServerTimeNow();
end;

local function rootOf(p17) -- Line: 55
    if p17 then
        p17 = p17.Character;
    end;

    if p17 then
        p17 = p17:FindFirstChild("HumanoidRootPart");
    end;

    return p17;
end;

local function inGame(p18) -- Line: 59
    if p18 then
        p18 = p18:GetAttribute("BladeHearts");
    end;

    local v19;

    if type(p18) == "number" then
        v19 = p18 > 0;
    else
        v19 = false;
    end;

    return v19;
end;

local function sound(p20, p21, p22) -- Line: 67
    -- upvalues: BladeBallConfig (copy), u15 (ref), Debris (copy), SoundService (copy)
    local v23 = BladeBallConfig.Sounds[p20];

    if not v23 then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = v23[1];
    Sound.Volume = v23[2];
    Sound.PlaybackSpeed = p22 or 0.95 + math.random() * 0.1;

    if p21 and u15 then
        local Attachment = Instance.new("Attachment");
        Attachment.WorldPosition = p21;
        Attachment.Parent = workspace.Terrain;
        Sound.RollOffMinDistance = 12;
        Sound.RollOffMaxDistance = 220;
        Sound.Parent = Attachment;
        Debris:AddItem(Attachment, 4);
    else
        Sound.Parent = SoundService;
        Debris:AddItem(Sound, 4);
    end;

    Sound:Play();
end;

local function burst(p24, p25, p26) -- Line: 93
    -- upvalues: u15 (ref), TweenService (copy), Debris (copy)
    if not u15 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Shape = Enum.PartType.Ball;
    Part.Material = Enum.Material.Neon;
    Part.Color = p25;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = Vector3.new(1.5, 1.5, 1.5);
    Part.Transparency = 0.15;
    Part.CFrame = CFrame.new(p24);
    Part.Parent = u15.folder;
    TweenService:Create(Part, TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(1, 1, 1) * p26
    }):Play();
    Debris:AddItem(Part, 0.4);
end;

local u27 = 0;
local u28 = 0;

local function shake(p29, p30) -- Line: 115
    -- upvalues: u28 (ref), u27 (ref)
    u28 = math.max(u28, p29);
    local v31 = os.clock() + p30;
    u27 = math.max(u27, v31);
end;

RunService:BindToRenderStep("BladeBallShake", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 119
    -- upvalues: u27 (ref), u28 (ref)
    local v32 = u27 - os.clock();

    if v32 <= 0 then
        u28 = 0;

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v33 = u28 * math.min(1, v32 * 6);
    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.Angles((math.random() - 0.5) * v33, (math.random() - 0.5) * v33, 0);
end);

local function make(p34, p35, p36) -- Line: 133
    local Instance_new_ret = Instance.new(p34);

    for i, v in p36 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p35;

    return Instance_new_ret;
end;

local function bare(p37) -- Line: 141
    p37.Anchored = true;
    p37.CanCollide = false;
    p37.CanQuery = false;
    p37.CanTouch = false;
    p37.CastShadow = false;
    p37.Massless = true;
end;

local function buildView() -- Line: 146
    -- upvalues: BladeBallConfig (copy), Color3_fromRGB_ret2 (copy), Color3_new_ret (copy), Color3_fromRGB_ret (copy), LocalPlayer (copy), u1 (copy), u2 (copy), TouchEnabled (copy), u15 (ref)
    local Folder = Instance.new("Folder");
    Folder.Name = "BladeBallView";
    local v38 = BladeBallConfig.Radius * 2;
    local v39 = {
        Name = "Ball",
        Shape = Enum.PartType.Ball,
        Size = Vector3.new(1, 1, 1) * v38,
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB(235, 235, 240)
    };
    local Part = Instance.new("Part");

    for i, v in v39 do
        Part[i] = v;
    end;

    Part.Parent = Folder;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Massless = true;
    local v40 = {};

    for i, v in { CFrame.Angles(0, 0, 1.5707963267948966), CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.Angles(0, 0, 1.5707963267948966) } do
        local v41 = {
            Name = "Band" .. i,
            Shape = Enum.PartType.Cylinder,
            Size = Vector3.new(0.28, v38 * 1.04, v38 * 1.04),
            Material = Enum.Material.Neon,
            Color = Color3_fromRGB_ret2
        };
        local Part2 = Instance.new("Part");

        for i2, v2 in v41 do
            Part2[i2] = v2;
        end;

        Part2.Parent = Folder;
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CanTouch = false;
        Part2.CastShadow = false;
        Part2.Massless = true;
        Part2.Anchored = false;
        Part2.CFrame = Part.CFrame * v;
        local WeldConstraint = Instance.new("WeldConstraint");

        for i2, v2 in {
            Part0 = Part,
            Part1 = Part2
        } do
            WeldConstraint[i2] = v2;
        end;

        WeldConstraint.Parent = Part2;
        table.insert(v40, Part2);
    end;

    local Part2 = Instance.new("Part");

    for i, v in {
        Name = "Carrier",
        Size = Vector3.new(0.2, 0.2, 0.2),
        Transparency = 1
    } do
        Part2[i] = v;
    end;

    Part2.Parent = Folder;
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;
    Part2.Massless = true;
    local v42 = {
        Position = Vector3.new(0, 1, 0) * BladeBallConfig.Radius * 0.7
    };
    local Attachment = Instance.new("Attachment");

    for i, v in v42 do
        Attachment[i] = v;
    end;

    Attachment.Parent = Part2;
    local v43 = {
        Position = Vector3.new(-0, -1, -0) * BladeBallConfig.Radius * 0.7
    };
    local Attachment2 = Instance.new("Attachment");

    for i, v in v43 do
        Attachment2[i] = v;
    end;

    Attachment2.Parent = Part2;
    local v44 = {
        Lifetime = 0.22,
        LightEmission = 1,
        FaceCamera = true,
        Attachment0 = Attachment,
        Attachment1 = Attachment2,
        Color = ColorSequence.new(Color3_fromRGB_ret2),
        Transparency = NumberSequence.new(0.2, 1),
        WidthScale = NumberSequence.new(1, 0)
    };
    local Trail = Instance.new("Trail");

    for i, v in v44 do
        Trail[i] = v;
    end;

    Trail.Parent = Part2;
    local v45 = {
        Range = 14,
        Brightness = 2.5,
        Shadows = false,
        Color = Color3_fromRGB_ret2
    };
    local PointLight = Instance.new("PointLight");

    for i, v in v45 do
        PointLight[i] = v;
    end;

    PointLight.Parent = Part2;
    local v46 = {
        Rate = 0,
        LightEmission = 1,
        Lifetime = NumberRange.new(0.15, 0.3),
        Speed = NumberRange.new(4, 10),
        SpreadAngle = Vector2.new(180, 180),
        Size = NumberSequence.new(0.35, 0),
        Color = ColorSequence.new(Color3_fromRGB_ret2)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");

    for i, v in v46 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = Part2;
    Folder.Parent = workspace;
    local v47 = {
        Name = "Aim",
        AlwaysOnTop = true,
        LightInfluence = 0,
        Enabled = false,
        Size = UDim2.fromOffset(64, 64)
    };
    local BillboardGui = Instance.new("BillboardGui");

    for i, v in v47 do
        BillboardGui[i] = v;
    end;

    BillboardGui.Parent = Folder;
    local v48 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v48 do
        Frame[i] = v;
    end;

    Frame.Parent = BillboardGui;
    local v49 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v49 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v50 = {
        Thickness = 3,
        Transparency = 0.1,
        Color = Color3_new_ret
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v50 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v51 = {
        BackgroundTransparency = 1,
        Text = "▼",
        TextScaled = true,
        Size = UDim2.fromScale(1, 0.4),
        Position = UDim2.fromScale(0, -0.45),
        TextColor3 = Color3_new_ret,
        Font = Enum.Font.GothamBlack
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v51 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = BillboardGui;
    local v52 = {
        FillTransparency = 0.7,
        OutlineTransparency = 0,
        Enabled = false,
        FillColor = Color3_fromRGB_ret,
        OutlineColor = Color3_fromRGB_ret,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    };
    local Highlight = Instance.new("Highlight");

    for i, v in v52 do
        Highlight[i] = v;
    end;

    Highlight.Parent = Folder;
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in {
        Name = "BladeBallHud",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 40
    } do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = PlayerGui;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v53 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 92),
        Size = UDim2.fromOffset(300, u1 + 30)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v53 do
        Frame2[i] = v;
    end;

    Frame2.Parent = ScreenGui;
    local v54 = {};

    for i = 1, BladeBallConfig.Hearts do
        local v55 = {
            BackgroundTransparency = 1,
            Text = "♥",
            TextScaled = true,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromOffset(u1, u1),
            Position = UDim2.fromOffset(150 + (i - (BladeBallConfig.Hearts + 1) / 2) * u2, u1 / 2),
            Font = Enum.Font.GothamBlack,
            TextColor3 = Color3_fromRGB_ret
        };
        local TextLabel2 = Instance.new("TextLabel");
        local v56 = i;

        for i2, v in v55 do
            TextLabel2[i2] = v;
        end;

        TextLabel2.Parent = Frame2;
        v54[v56] = TextLabel2;
        local v57 = v54[v56];
        local v58 = {
            Thickness = 3.5,
            Color = Color3.new(0, 0, 0)
        };
        local UIStroke2 = Instance.new("UIStroke");

        for i2, v in v58 do
            UIStroke2[i2] = v;
        end;

        UIStroke2.Parent = v57;
    end;

    local v59 = {
        BackgroundTransparency = 1,
        Text = "",
        TextScaled = true,
        Position = UDim2.fromOffset(0, u1 + 4),
        Size = UDim2.new(1, 0, 0, TouchEnabled and 18 or 24),
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3_new_ret
    };
    local TextLabel2 = Instance.new("TextLabel");

    for i, v in v59 do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = Frame2;
    local v60 = {
        Thickness = 2,
        Color = Color3.new(0, 0, 0)
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v60 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextLabel2;
    local v61 = {};

    for _, v in {
        { UDim2.new(1, 0, 0.16, 0), UDim2.fromScale(0, 0), 90 },
        { UDim2.new(1, 0, 0.16, 0), UDim2.fromScale(0, 0.84), -90 },
        { UDim2.new(0.12, 0, 1, 0), UDim2.fromScale(0, 0), 0 },
        { UDim2.new(0.12, 0, 1, 0), UDim2.fromScale(0.88, 0), 180 }
    } do
        local v62 = {
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Size = v[1],
            Position = v[2],
            BackgroundColor3 = Color3_fromRGB_ret
        };
        local Frame3 = Instance.new("Frame");

        for i, v2 in v62 do
            Frame3[i] = v2;
        end;

        Frame3.Parent = ScreenGui;
        local v63 = {
            Rotation = v[3],
            Transparency = NumberSequence.new(0.35, 1)
        };
        local UIGradient = Instance.new("UIGradient");

        for i, v2 in v63 do
            UIGradient[i] = v2;
        end;

        UIGradient.Parent = Frame3;
        table.insert(v61, Frame3);
    end;

    local v64 = {
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -128),
        Size = UDim2.fromOffset(160, 8),
        BackgroundColor3 = Color3.fromRGB(20, 20, 26),
        Visible = not TouchEnabled
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v64 do
        Frame3[i] = v;
    end;

    Frame3.Parent = ScreenGui;
    local v65 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v65 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame3;
    local v66 = {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v66 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    local v67 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v67 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame4;
    local v68 = {
        BackgroundTransparency = 1,
        Text = "F / CLICK BLOCK  ·  SPACE JUMP  ·  SHIFT DASH  ·  CAMERA AIMS",
        TextScaled = true,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 0, -4),
        Size = UDim2.fromOffset(260, 20),
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3_new_ret
    };
    local TextLabel3 = Instance.new("TextLabel");

    for i, v in v68 do
        TextLabel3[i] = v;
    end;

    TextLabel3.Parent = Frame3;
    local v69 = {
        Thickness = 1.5,
        Color = Color3.new(0, 0, 0)
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v69 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = TextLabel3;
    u15 = {
        folder = Folder,
        gui = ScreenGui,
        core = Part,
        bands = v40,
        carrier = Part2,
        trail = Trail,
        light = PointLight,
        sparks = ParticleEmitter,
        aimGui = BillboardGui,
        ring = Frame,
        mark = Highlight,
        hearts = v54,
        info = TextLabel2,
        edges = v61,
        fill = Frame4,
        tags = {},
        connections = {}
    };

    return u15;
end;

local function heartTag(p70) -- Line: 259
    -- upvalues: u15 (ref), BladeBallConfig (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret6 (copy)
    local v71 = p70.Character and (p70.Character:FindFirstChild("Head") or p70.Character:FindFirstChild("HumanoidRootPart"));
    local v72 = u15.tags[p70];

    if not v71 then
        if v72 then
            v72.gui:Destroy();
            u15.tags[p70] = nil;
        end;

        return;
    end;

    if not v72 then
        local folder = u15.folder;
        local v73 = {
            Name = "Hearts",
            StudsOffset = Vector3.new(0, 4.6, 0),
            LightInfluence = 0,
            MaxDistance = 150,
            Size = UDim2.fromOffset(BladeBallConfig.Hearts * 13, 13)
        };
        local BillboardGui = Instance.new("BillboardGui");

        for i, v in v73 do
            BillboardGui[i] = v;
        end;

        BillboardGui.Parent = folder;
        local v74 = {};

        for i = 1, BladeBallConfig.Hearts do
            local v75 = {
                BackgroundTransparency = 1,
                Text = "♥",
                TextScaled = true,
                Size = UDim2.fromOffset(12, 12),
                Position = UDim2.fromOffset((i - 1) * 13, 0),
                Font = Enum.Font.GothamBlack,
                TextColor3 = Color3_fromRGB_ret
            };
            local TextLabel = Instance.new("TextLabel");
            local v76 = i;

            for i2, v in v75 do
                TextLabel[i2] = v;
            end;

            TextLabel.Parent = BillboardGui;
            v74[v76] = TextLabel;
            local v77 = v74[v76];
            local v78 = {
                Thickness = 1,
                Color = Color3.new(0, 0, 0)
            };
            local UIStroke = Instance.new("UIStroke");

            for i2, v in v78 do
                UIStroke[i2] = v;
            end;

            UIStroke.Parent = v77;
        end;

        v72 = {
            shown = -1,
            gui = BillboardGui,
            labels = v74
        };
        u15.tags[p70] = v72;
    end;

    v72.gui.Adornee = v71;
    local v79 = p70:GetAttribute("BladeHearts") or 0;

    if v72.shown ~= v79 then
        v72.shown = v79;

        for i, v in v72.labels do
            local v80;

            if i <= v79 then
                v80 = Color3_fromRGB_ret;
            else
                v80 = Color3_fromRGB_ret6;
            end;

            v.TextColor3 = v80;
        end;
    end;
end;

local function readArena() -- Line: 306
    -- upvalues: u8 (ref), u9 (ref), u7 (ref), BladeBallConfig (copy)
    local BladeBallArena = workspace:FindFirstChild("BladeBallArena");

    if not BladeBallArena then
        return false;
    end;

    local Attribute = BladeBallArena:GetAttribute("Center");
    local Attribute2 = BladeBallArena:GetAttribute("Floor");
    local Attribute3 = BladeBallArena:GetAttribute("Box");

    if typeof(Attribute) ~= "Vector3" or (type(Attribute2) ~= "number" or typeof(Attribute3) ~= "CFrame") then
        return false;
    end;

    u8 = Attribute2;
    u9 = {
        cf = Attribute3,
        hx = BladeBallArena:GetAttribute("HX") or 80,
        hz = BladeBallArena:GetAttribute("HZ") or 110
    };
    u7 = Attribute + Vector3.new(0, 1, 0) * BladeBallConfig.ServeHeight;

    return true;
end;

local function aimFor() -- Line: 322
    -- upvalues: u5 (copy), u7 (ref), Players (copy), BladeBallConfig (copy)
    if u5.st == "Return" then
        return u7;
    end;

    if u5.st ~= "Live" then
        return nil;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(u5.tg);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
    end;

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Position + Vector3.new(0, 1, 0) * BladeBallConfig.AimHeight;
    end;

    return PlayerByUserId;
end;

local function shownPos() -- Line: 333
    -- upvalues: u4 (ref), u6 (ref)
    if u4 then
        return u4.pos + u6;
    end;

    return nil;
end;

local function apply(p81) -- Line: 338
    -- upvalues: u7 (ref), readArena (copy), u4 (ref), u6 (ref), BladeBallPhysics (copy), u8 (ref), u9 (ref), u5 (copy), Players (copy), BladeBallConfig (copy)
    if type(p81) ~= "table" or (typeof(p81.p) ~= "Vector3" or (typeof(p81.v) ~= "Vector3" or type(p81.t) ~= "number")) then
        return;
    end;

    if not (u7 or readArena()) then
        return;
    end;

    local v82;

    if u4 then
        v82 = u4.pos + u6;
    else
        v82 = nil;
    end;

    if not u4 then
        u4 = BladeBallPhysics.new(p81.p, u8, u9);
    end;

    local v = p81.v;
    u4.pos = p81.p;
    u4.vel = v;
    local v83 = p81.s or 0;
    local v84 = p81.f or 0;
    u4.cur = p81.c or 0;
    u4.speed = v83;
    u4.free = v84;
    local v85 = p81.tg or 0;
    local t = p81.t;
    u5.st = p81.st or "Serve";
    u5.tg = v85;
    u5.t = t;

    if u5.st == "Live" or u5.st == "Return" then
        local v86 = workspace:GetServerTimeNow() - p81.t;
        local math_clamp_ret = math.clamp(v86, 0, 0.5);
        local step = BladeBallPhysics.step;
        local v87;

        if u5.st == "Return" then
            v87 = u7;
        elseif u5.st == "Live" then
            v87 = Players:GetPlayerByUserId(u5.tg);

            if v87 then
                v87 = v87.Character;
            end;

            if v87 then
                v87 = v87:FindFirstChild("HumanoidRootPart");
            end;

            if v87 then
                v87 = v87.Position + Vector3.new(0, 1, 0) * BladeBallConfig.AimHeight;
            end;
        else
            v87 = nil;
        end;

        step(u4, math_clamp_ret, v87, BladeBallConfig, p81.t);
    end;

    if not v82 then
        u6 = Vector3.new(0, 0, 0);

        return;
    end;

    local v88 = v82 - u4.pos;
    u6 = v88.Magnitude >= 14 and Vector3.new(0, 0, 0) or v88;
end;

local function pickAim() -- Line: 368
    -- upvalues: Players (copy), LocalPlayer (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Position = workspace_CurrentCamera.CFrame.Position;
    local LookVector = workspace_CurrentCamera.CFrame.LookVector;
    local v89 = -2;
    local v90 = nil;

    for _, v in Players:GetPlayers() do
        local v91;

        if v == LocalPlayer then
            v91 = false;
        else
            local v92;

            if v then
                v92 = v:GetAttribute("BladeHearts");
            else
                v92 = v;
            end;

            if type(v92) == "number" then
                v91 = v92 > 0;
            else
                v91 = false;
            end;

            if v91 then
                if v then
                    v91 = v.Character;
                else
                    v91 = v;
                end;

                if v91 then
                    v91 = v91:FindFirstChild("HumanoidRootPart");
                end;
            end;
        end;

        if v91 then
            local v93 = v91.Position - Position;
            local v94 = v93.Magnitude <= 0.001 and -1 or v93.Unit:Dot(LookVector);

            if v89 < v94 then
                v90 = v;
                v89 = v94;
            end;
        end;
    end;

    return v90;
end;

local function showBlock(p95, p96) -- Line: 386
    -- upvalues: u14 (ref), LocalPlayer (copy), u4 (ref), BladeBallConfig (copy), u6 (ref), BladeBallPhysics (copy), u5 (copy), u12 (ref), u13 (ref), u11 (ref), u10 (ref), burst (copy), Color3_new_ret (copy), SoundService (copy), Debris (copy), u28 (ref), u27 (ref)
    local v97 = u14;
    local v98 = LocalPlayer;

    if v98 then
        v98 = v98.Character;
    end;

    if v98 then
        v98 = v98:FindFirstChild("HumanoidRootPart");
    end;

    u4.speed = math.min(BladeBallConfig.MaxSpeed, u4.speed + BladeBallConfig.SpeedPerBlock);
    u4.cur = u4.speed;
    local v99;

    if u4 then
        v99 = u4.pos + u6;
    else
        v99 = nil;
    end;

    u4.pos = v99;
    u6 = Vector3.new(0, 0, 0);

    if v97 then
        local v100;

        if v97 then
            v100 = v97.Character;
        else
            v100 = v97;
        end;

        if v100 then
            v100 = v100:FindFirstChild("HumanoidRootPart");
        end;

        if v100 then
            local launch = BladeBallPhysics.launch;
            local v101;

            if v97 then
                v101 = v97.Character;
            else
                v101 = v97;
            end;

            if v101 then
                v101 = v101:FindFirstChild("HumanoidRootPart");
            end;

            u4.vel = launch(v99, v101.Position + Vector3.new(0, 1, 0) * BladeBallConfig.AimHeight, p95, u4.cur, BladeBallConfig);
            u4.free = p96 + BladeBallConfig.CurveSeconds;
            u5.tg = v97.UserId;
        else
            u4.vel = BladeBallPhysics.launch(v99, v99 + p95 * 60, p95, u4.cur, BladeBallConfig);
            u4.free = p96 + 0.9;
        end;
    else
        u4.vel = BladeBallPhysics.launch(v99, v99 + p95 * 60, p95, u4.cur, BladeBallConfig);
        u4.free = p96 + 0.9;
    end;

    u12 = p96;
    u13 = p96 + 0.6;
    u11 = nil;
    u10 = p96 + BladeBallConfig.BlockCooldown;

    if v98 then
        v99 = v98.Position;
    end;

    burst(v99, Color3_new_ret, 16);
    local v102 = math.min(0.4, u4.cur / 700) + 1;
    local Block = BladeBallConfig.Sounds.Block;

    if Block then
        local Sound = Instance.new("Sound");
        Sound.SoundId = Block[1];
        Sound.Volume = Block[2];
        Sound.PlaybackSpeed = v102 or 0.95 + math.random() * 0.1;
        Sound.Parent = SoundService;
        Debris:AddItem(Sound, 4);
        Sound:Play();
    end;

    u28 = math.max(u28, 0.012);
    local v103 = os.clock() + 0.12;
    u27 = math.max(u27, v103);
end;

local function flatLook() -- Line: 412
    return workspace.CurrentCamera.CFrame.LookVector;
end;

local function press() -- Line: 416
    -- upvalues: u3 (ref), LocalPlayer (copy), u10 (ref), BladeBallEvent (copy), u14 (ref), BladeBallConfig (copy), SoundService (copy), Debris (copy), u4 (ref), u5 (copy), u6 (ref), BladeBallPhysics (copy), showBlock (copy), u11 (ref)
    if u3 then
        local v104 = LocalPlayer;

        if v104 then
            v104 = v104:GetAttribute("BladeHearts");
        end;

        local v105;

        if type(v104) == "number" then
            v105 = v104 > 0;
        else
            v105 = false;
        end;

        if v105 then
            local ServerTimeNow = workspace:GetServerTimeNow();

            if ServerTimeNow < u10 then
                return;
            end;

            local LookVector = workspace.CurrentCamera.CFrame.LookVector;
            BladeBallEvent:FireServer("Block", {
                t = ServerTimeNow,
                a = u14 and u14.UserId or nil,
                l = LookVector
            });
            local Slash = BladeBallConfig.Sounds.Slash;

            if Slash then
                local Sound = Instance.new("Sound");
                Sound.SoundId = Slash[1];
                Sound.Volume = Slash[2];
                Sound.PlaybackSpeed = 1.1;
                Sound.Parent = SoundService;
                Debris:AddItem(Sound, 4);
                Sound:Play();
            end;

            local v106 = LocalPlayer;

            if v106 then
                v106 = v106.Character;
            end;

            if v106 then
                v106 = v106:FindFirstChild("HumanoidRootPart");
            end;

            if not (u4 and (v106 and (u5.st == "Live" and u5.tg == LocalPlayer.UserId))) then
                u10 = ServerTimeNow + BladeBallConfig.Window;

                return;
            end;

            local v107;

            if u4 then
                v107 = u4.pos + u6;
            else
                v107 = nil;
            end;

            if (v107 - v106.Position).Magnitude <= BladeBallPhysics.blockRange(u4.cur, BladeBallConfig) then
                showBlock(LookVector, ServerTimeNow);

                return;
            end;

            u11 = {
                untilT = ServerTimeNow + BladeBallConfig.Window,
                look = LookVector
            };
            u10 = ServerTimeNow + BladeBallConfig.Window + BladeBallConfig.MissCooldown;
        end;
    end;
end;

local u108 = false;

local function setJump(p109) -- Line: 447
    -- upvalues: LocalPlayer (copy), BladeBallConfig (copy), u108 (ref)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if not Character then
        return;
    end;

    if not p109 then
        if u108 then
            u108 = false;
            Character.JumpPower = 0;
            Character:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
        end;

        return;
    end;

    Character.UseJumpPower = true;

    if Character.JumpPower ~= BladeBallConfig.JumpPower then
        Character.JumpPower = BladeBallConfig.JumpPower;
    end;

    if not Character:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
        Character:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
    end;

    u108 = true;
end;

local function frame(p110) -- Line: 469
    -- upvalues: u15 (ref), u4 (ref), setJump (copy), LocalPlayer (copy), u5 (copy), u7 (ref), BladeBallPhysics (copy), Players (copy), BladeBallConfig (copy), u6 (ref), u11 (ref), showBlock (copy), CFrame_identity (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret2 (copy), Color3_new_ret (copy), Color3_fromRGB_ret3 (copy), u14 (ref), pickAim (copy), Color3_fromRGB_ret6 (copy), heartTag (copy), u10 (ref)
    if not (u15 and u4) then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v111 = LocalPlayer;

    if v111 then
        v111 = v111:GetAttribute("BladeHearts");
    end;

    local v112;

    if type(v111) == "number" then
        v112 = v111 > 0;
    else
        v112 = false;
    end;

    setJump(v112);

    if u5.st == "Serve" then
        u4.pos = u7 + Vector3.new(0, 1, 0) * (math.sin(ServerTimeNow * 3) * 0.5);
        u4.vel = Vector3.new(0, 0, 0);
    else
        local step = BladeBallPhysics.step;
        local v113;

        if u5.st == "Return" then
            v113 = u7;
        elseif u5.st == "Live" then
            v113 = Players:GetPlayerByUserId(u5.tg);

            if v113 then
                v113 = v113.Character;
            end;

            if v113 then
                v113 = v113:FindFirstChild("HumanoidRootPart");
            end;

            if v113 then
                v113 = v113.Position + Vector3.new(0, 1, 0) * BladeBallConfig.AimHeight;
            end;
        else
            v113 = nil;
        end;

        step(u4, p110, v113, BladeBallConfig, ServerTimeNow - p110);
    end;

    u6 = u6 * math.exp(-p110 * 12);
    local v114;

    if u4 then
        v114 = u4.pos + u6;
    else
        v114 = nil;
    end;

    local v115;

    if u5.st == "Live" then
        v115 = u5.tg == LocalPlayer.UserId;
    else
        v115 = false;
    end;

    local v116 = LocalPlayer;

    if v116 then
        v116 = v116.Character;
    end;

    if v116 then
        v116 = v116:FindFirstChild("HumanoidRootPart");
    end;

    if u11 and (v115 and v116) then
        if ServerTimeNow <= u11.untilT and (v114 - v116.Position).Magnitude <= BladeBallPhysics.blockRange(u4.cur, BladeBallConfig) then
            showBlock(u11.look, ServerTimeNow);
            v115 = false;
        elseif u11.untilT < ServerTimeNow then
            u11 = nil;
        end;
    end;

    local vel = u4.vel;
    local Vector3_new_ret = Vector3.new(vel.X, 0, vel.Z);

    if Vector3_new_ret.Magnitude > 0.5 then
        local Unit = (Vector3.new(0, 1, 0)):Cross(Vector3_new_ret).Unit;
        CFrame_identity = CFrame.fromAxisAngle(Unit, Vector3_new_ret.Magnitude / BladeBallConfig.Radius * p110) * CFrame_identity;
    elseif u5.st == "Serve" then
        CFrame_identity = CFrame.Angles(0, p110 * 2.5, 0) * CFrame_identity;
    end;

    u15.core.CFrame = CFrame.new(v114) * CFrame_identity;
    u15.carrier.CFrame = CFrame.new(v114);
    local math_clamp_ret = math.clamp((u4.cur - BladeBallConfig.StartSpeed) / (BladeBallConfig.BlueSpeed - BladeBallConfig.StartSpeed), 0, 1);
    local v117;

    if v115 then
        v117 = Color3_fromRGB_ret;
    else
        v117 = Color3_fromRGB_ret5:Lerp(Color3_fromRGB_ret4, math_clamp_ret);
    end;

    if u5.st == "Serve" then
        v117 = Color3_fromRGB_ret2:Lerp(Color3_new_ret, (math.sin(ServerTimeNow * 8) + 1) / 2);
    end;

    for _, v in u15.bands do
        v.Color = v117;
    end;

    local core = u15.core;
    local v118;

    if v115 then
        v118 = Color3_fromRGB_ret;
    else
        v118 = Color3_fromRGB_ret3:Lerp(Color3_fromRGB_ret4, math_clamp_ret);
    end;

    core.Color = v118;
    local v119;

    if v115 then
        v119 = Enum.Material.Neon;
    else
        v119 = Enum.Material.SmoothPlastic;
    end;

    u15.core.Material = v119;
    u15.light.Color = v117;
    u15.trail.Color = ColorSequence.new(v117);
    u15.sparks.Color = ColorSequence.new(v117);
    u15.sparks.Rate = u4.cur <= 120 and 0 or (u4.cur - 120) * 0.5;
    u15.light.Brightness = math.min(4, u4.cur / 60) + 2;
    local v120;

    if u5.st == "Live" then
        v120 = Players:GetPlayerByUserId(u5.tg) or nil;
    else
        v120 = nil;
    end;

    local v121;

    if v120 then
        v121 = v120.Character or nil;
    else
        v121 = nil;
    end;

    u15.mark.Adornee = v121;
    local v122;

    if v120 == nil then
        v122 = false;
    else
        v122 = v120 ~= LocalPlayer;
    end;

    u15.mark.Enabled = v122;
    local v123 = not (v115 and v116) and 0 or 1 - math.clamp(((v114 - v116.Position).Magnitude - 10) / 80, 0, 1);

    for _, v in u15.edges do
        v.BackgroundTransparency = 1 - v123 * 0.85;
    end;

    local v124 = LocalPlayer;

    if v124 then
        v124 = v124:GetAttribute("BladeHearts");
    end;

    local v125;

    if type(v124) == "number" then
        v125 = v124 > 0;
    else
        v125 = false;
    end;

    local v126;

    if v125 then
        v126 = pickAim();
    else
        v126 = nil;
    end;

    u14 = v126;
    local v127 = u14;

    if v127 then
        v127 = v127.Character;
    end;

    if v127 then
        v127 = v127:FindFirstChild("HumanoidRootPart");
    end;

    u15.aimGui.Adornee = v127;
    u15.aimGui.Enabled = v127 ~= nil;
    local v128 = LocalPlayer:GetAttribute("BladeHearts") or 0;

    for i, v in u15.hearts do
        local v129;

        if i <= v128 then
            v129 = Color3_fromRGB_ret;
        else
            v129 = Color3_fromRGB_ret6;
        end;

        v.TextColor3 = v129;
    end;

    local v130 = 0;

    for _, v in Players:GetPlayers() do
        local v131;

        if v then
            v131 = v:GetAttribute("BladeHearts");
        else
            v131 = v;
        end;

        local v132;

        if type(v131) == "number" then
            v132 = v131 > 0;
        else
            v132 = false;
        end;

        if v132 then
            v130 = v130 + 1;

            if v ~= LocalPlayer then
                heartTag(v);
            end;
        end;
    end;

    for i, v in u15.tags do
        if i.Parent == Players then
            local v133;

            if i then
                v133 = i:GetAttribute("BladeHearts");
            else
                v133 = i;
            end;

            local v134;

            if type(v133) == "number" then
                v134 = v133 > 0;
            else
                v134 = false;
            end;

            if not v134 then
                v.gui:Destroy();
                u15.tags[i] = nil;
            end;
        else
            v.gui:Destroy();
            u15.tags[i] = nil;
        end;
    end;

    u15.info.Text = string.format("%d LEFT  ·  SPEED %d", v130, (math.floor(u4.cur + 0.5)));
    local math_clamp_ret2 = math.clamp(1 - (u10 - ServerTimeNow) / (BladeBallConfig.Window + BladeBallConfig.MissCooldown), 0, 1);
    local v135 = u10 <= ServerTimeNow and 1 or math_clamp_ret2;
    u15.fill.Size = UDim2.fromScale(v135, 1);
    local fill = u15.fill;
    local v136;

    if v135 >= 1 then
        v136 = Color3_fromRGB_ret2;
    else
        v136 = Color3.fromRGB(130, 130, 140);
    end;

    fill.BackgroundColor3 = v136;
end;

local function stop() -- Line: 573
    -- upvalues: u3 (ref), LocalPlayer (copy), u108 (ref), u16 (ref), u15 (ref), u4 (ref), u11 (ref), u14 (ref), u7 (ref), u8 (ref), u9 (ref), u6 (ref), u5 (copy), u10 (ref), u12 (ref), u13 (ref)
    u3 = false;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if Character and u108 then
        u108 = false;
        Character.JumpPower = 0;
        Character:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
    end;

    if u16 then
        u16:Disconnect();
        u16 = nil;
    end;

    if u15 then
        for _, v in u15.connections do
            v:Disconnect();
        end;

        u15.folder:Destroy();
        u15.gui:Destroy();
        u15 = nil;
    end;

    u4 = nil;
    u11 = nil;
    u14 = nil;
    u7 = nil;
    u8 = nil;
    u9 = nil;
    u6 = Vector3.new(0, 0, 0);
    u5.st = "Serve";
    u5.tg = 0;
    u5.t = 0;
    u10 = 0;
    u12 = (-1 / 0);
    u13 = 0;
end;

local function start() -- Line: 595
    -- upvalues: u3 (ref), buildView (copy), LocalPlayer (copy), u15 (ref), TouchActionButton (copy), press (copy), u16 (ref), RunService (copy), frame (copy)
    if u3 then
        return;
    end;

    u3 = true;
    local u137 = buildView();
    task.spawn(function() -- Line: 602
        -- upvalues: LocalPlayer (ref), u15 (ref), u137 (copy), TouchActionButton (ref), press (ref)
        local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD", 10);

        if HUD then
            HUD = HUD:WaitForChild("MeleeButton", 10);
        end;

        if HUD and u15 == u137 then
            table.insert(u137.connections, TouchActionButton.bind(HUD, press));
        end;
    end);
    u16 = RunService.RenderStepped:Connect(frame);
end;

local function refresh() -- Line: 612
    -- upvalues: Session (copy), u3 (ref), buildView (copy), LocalPlayer (copy), u15 (ref), TouchActionButton (copy), press (copy), u16 (ref), RunService (copy), frame (copy), stop (copy)
    if Session:GetAttribute("AdminMatchMode") ~= "BladeBall" then
        stop();

        return;
    end;

    if u3 then
        return;
    end;

    u3 = true;
    local u138 = buildView();
    task.spawn(function() -- Line: 602
        -- upvalues: LocalPlayer (ref), u15 (ref), u138 (copy), TouchActionButton (ref), press (ref)
        local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD", 10);

        if HUD then
            HUD = HUD:WaitForChild("MeleeButton", 10);
        end;

        if HUD and u15 == u138 then
            table.insert(u138.connections, TouchActionButton.bind(HUD, press));
        end;
    end);
    u16 = RunService.RenderStepped:Connect(frame);
end;

Session:GetAttributeChangedSignal("AdminMatchMode"):Connect(refresh);

if Session:GetAttribute("AdminMatchMode") == "BladeBall" then
    if not u3 then
        u3 = true;
        local u139 = buildView();
        task.spawn(function() -- Line: 602
            -- upvalues: LocalPlayer (copy), u15 (ref), u139 (copy), TouchActionButton (copy), press (copy)
            local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD", 10);

            if HUD then
                HUD = HUD:WaitForChild("MeleeButton", 10);
            end;

            if HUD and u15 == u139 then
                table.insert(u139.connections, TouchActionButton.bind(HUD, press));
            end;
        end);
        u16 = RunService.RenderStepped:Connect(frame);
    end;
else
    stop();
end;

UserInputService.InputBegan:Connect(function(p140, p141) -- Line: 622
    -- upvalues: u3 (ref), UserInputService (copy), press (copy)
    if not u3 or UserInputService:GetFocusedTextBox() then
        return;
    end;

    local KeyCode = p140.KeyCode;

    if KeyCode == Enum.KeyCode.F or (KeyCode == Enum.KeyCode.ButtonR1 or KeyCode == Enum.KeyCode.ButtonL2) then
        press();

        return;
    end;

    if p140.UserInputType == Enum.UserInputType.MouseButton1 and not p141 then
        press();
    end;
end);
UserInputService.TouchTapInWorld:Connect(function(p142, p143) -- Line: 634
    -- upvalues: u3 (ref), press (copy)
    if u3 and not p143 then
        press();
    end;
end);
BladeBallSnapshot.OnClientEvent:Connect(function(p144) -- Line: 640
    -- upvalues: u3 (ref), u5 (copy), u13 (ref), apply (copy)
    if not (u3 and (type(p144) == "table" and type(p144.t) == "number")) then
        return;
    end;

    if p144.t < u5.t or workspace:GetServerTimeNow() < u13 then
        return;
    end;

    apply(p144);
end);
BladeBallEvent.OnClientEvent:Connect(function(p145, p146) -- Line: 652
    -- upvalues: u3 (ref), buildView (copy), LocalPlayer (copy), u15 (ref), TouchActionButton (copy), press (copy), u16 (ref), RunService (copy), frame (copy), stop (copy), apply (copy), sound (copy), u7 (ref), burst (copy), Color3_fromRGB_ret2 (copy), Players (copy), u12 (ref), u4 (ref), u6 (ref), Color3_new_ret (copy), BladeBallConfig (copy), SoundService (copy), Debris (copy), u13 (ref), Color3_fromRGB_ret (copy), u28 (ref), u27 (ref), u1 (copy), TweenService (copy)
    if p145 ~= "Start" then
        if p145 == "End" then
            stop();

            return;
        end;

        if not u3 or type(p146) ~= "table" then
            return;
        end;

        if p146.ball then
            apply(p146.ball);
        end;

        if p145 == "Ball" and p146.serve then
            sound("Serve", u7);

            if u7 then
                burst(u7, Color3_fromRGB_ret2, 14);

                return;
            end;
        elseif p145 == "Block" then
            local PlayerByUserId = Players:GetPlayerByUserId(p146.u);

            if PlayerByUserId == LocalPlayer then
                if workspace:GetServerTimeNow() - u12 > 1 then
                    local v147;

                    if u4 then
                        v147 = u4.pos + u6;
                    else
                        v147 = nil;
                    end;

                    burst(v147 or u7, Color3_new_ret, 16);
                    local Block = BladeBallConfig.Sounds.Block;

                    if Block then
                        local Sound = Instance.new("Sound");
                        Sound.SoundId = Block[1];
                        Sound.Volume = Block[2];
                        Sound.PlaybackSpeed = 0.95 + math.random() * 0.1;
                        Sound.Parent = SoundService;
                        Debris:AddItem(Sound, 4);
                        Sound:Play();
                    end;
                end;

                u12 = (-1 / 0);
                u13 = 0;

                return;
            end;

            if PlayerByUserId then
                PlayerByUserId = PlayerByUserId.Character;
            end;

            if PlayerByUserId then
                PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
            end;

            local v148;

            if PlayerByUserId then
                v148 = PlayerByUserId.Position;
            elseif u4 then
                v148 = u4.pos + u6;
            else
                v148 = nil;
            end;

            if v148 then
                burst(v148, Color3_new_ret, 12);
                sound("Block", v148);

                return;
            end;
        elseif p145 == "Hit" then
            local PlayerByUserId = Players:GetPlayerByUserId(p146.u);
            local v149;

            if PlayerByUserId then
                v149 = PlayerByUserId.Character;
            else
                v149 = PlayerByUserId;
            end;

            if v149 then
                v149 = v149:FindFirstChild("HumanoidRootPart");
            end;

            local v150;

            if v149 then
                v150 = v149.Position;
            elseif u4 then
                v150 = u4.pos + u6;
            else
                v150 = nil;
            end;

            if v150 then
                burst(v150, Color3_fromRGB_ret, 18);
            end;

            u12 = (-1 / 0);
            u13 = 0;

            if PlayerByUserId == LocalPlayer then
                local Hit = BladeBallConfig.Sounds.Hit;

                if Hit then
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = Hit[1];
                    Sound.Volume = Hit[2];
                    Sound.PlaybackSpeed = 0.95 + math.random() * 0.1;
                    Sound.Parent = SoundService;
                    Debris:AddItem(Sound, 4);
                    Sound:Play();
                end;

                u28 = math.max(u28, 0.05);
                local v151 = os.clock() + 0.3;
                u27 = math.max(u27, v151);
                local v152 = u15 and u15.hearts[(p146.h or 0) + 1];

                if v152 then
                    v152.Size = UDim2.fromOffset(u1 * 1.5, u1 * 1.5);
                    TweenService:Create(v152, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
                        Size = UDim2.fromOffset(u1, u1)
                    }):Play();

                    return;
                end;
            elseif v150 then
                sound("Hit", v150);

                return;
            end;
        elseif p145 == "Out" and Players:GetPlayerByUserId(p146.u) == LocalPlayer then
            local Out = BladeBallConfig.Sounds.Out;

            if not Out then
                return;
            end;

            local Sound = Instance.new("Sound");
            Sound.SoundId = Out[1];
            Sound.Volume = Out[2];
            Sound.PlaybackSpeed = 0.95 + math.random() * 0.1;
            Sound.Parent = SoundService;
            Debris:AddItem(Sound, 4);
            Sound:Play();
        end;

        return;
    end;

    if u3 then
        return;
    end;

    u3 = true;
    local u153 = buildView();
    task.spawn(function() -- Line: 602
        -- upvalues: LocalPlayer (ref), u15 (ref), u153 (copy), TouchActionButton (ref), press (ref)
        local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD", 10);

        if HUD then
            HUD = HUD:WaitForChild("MeleeButton", 10);
        end;

        if HUD and u15 == u153 then
            table.insert(u153.connections, TouchActionButton.bind(HUD, press));
        end;
    end);
    u16 = RunService.RenderStepped:Connect(frame);
end);