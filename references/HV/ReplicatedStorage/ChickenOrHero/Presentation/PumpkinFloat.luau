 

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local PumpkinHuntConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntConfig"));
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local KnifeIconCopy = require(Weapons:WaitForChild("KnifeIconCopy"));
local u1 = {};
u1.__index = u1;
local Vector2_new_ret = Vector2.new(0.5, 0.52);
local Color3_fromRGB_ret = Color3.fromRGB(255, 132, 28);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 184, 72);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 220, 110);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local u2 = {
    Whisper = { "rbxassetid://9126213995", 0.6, 0, 1.9 },
    Drone = { "rbxassetid://9125439885", 0.7, 0.3, 8 },
    Thud = { "rbxassetid://9126267420", 0.9, 0, 0.7 },
    Strain = { "rbxassetid://9125407239", 0.8, 0.3, 0.5 },
    Swell = { "rbxassetid://9125626800", 0.7, 2.57, 1.2 },
    Boom = { "rbxassetid://9125484743", 0.6, 0, 3.5 },
    Splinter = { "rbxassetid://9125993215", 0.6, 0, 0.45 },
    Toll = { "rbxassetid://9113804436", 0.6, 0.05, 1.15 }
};
local u3 = { { 0, 9 }, { 0.42, 13 }, { 0.84, 17 } };
local u4 = { 0.86, 0.73 };
local Color3_fromRGB_ret4 = Color3.fromRGB(10, 10, 12);
local CFrame_Angles_ret = CFrame.Angles(0, 3.141592653589793, 0);

local function backOut(p5) -- Line: 114
    return 1 + 2.70158 * (p5 - 1) ^ 3 + 1.70158 * (p5 - 1) ^ 2;
end;

local function smooth(p6) -- Line: 117
    return p6 * p6 * (3 - 2 * p6);
end;

local function hush(u7, p8) -- Line: 121
    -- upvalues: TweenService (copy)
    if u7 and u7.Parent then
        TweenService:Create(u7, TweenInfo.new(p8), {
            Volume = 0
        }):Play();
        task.delay(p8 + 0.02, function() -- Line: 124
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);
    end;
end;

local function sound(p9, u10, p11, p12) -- Line: 131
    -- upvalues: u2 (copy), PumpkinHuntConfig (copy), SoundService (copy), hush (copy)
    local u13 = u2[p9] or PumpkinHuntConfig.Sounds[p9];

    if not u13 then
        return nil;
    end;

    if p12 and not (p12.parent and p12.parent.Parent) then
        return nil;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = u13[1];
    Sound.Volume = (p11 or (u13[2] or 0.5)) * (p12 and (p12.volume or 1) or 1);
    Sound.PlaybackSpeed = u10 or 1;

    if p12 then
        Sound.RollOffMode = Enum.RollOffMode.Linear;
        Sound.RollOffMinDistance = p12.near or 8;
        Sound.RollOffMaxDistance = p12.far or 25;
    end;

    local v14;

    if p12 then
        v14 = p12.parent;
    else
        v14 = SoundService;
    end;

    Sound.Parent = v14;
    local os_clock_ret = os.clock();

    local function go() -- Line: 150
        -- upvalues: Sound (copy), u13 (copy), u10 (copy), hush (ref)
        if not Sound.Parent then
            return;
        end;

        Sound.TimePosition = u13[3] or 0;
        Sound:Play();
        task.delay((u13[4] or 3) / (u10 or 1), function() -- Line: 156
            -- upvalues: hush (ref), Sound (ref)
            hush(Sound, 0.08);
        end);
    end;

    if Sound.IsLoaded then
        go();

        return Sound;
    end;

    Sound.Loaded:Once(function() -- Line: 163
        -- upvalues: os_clock_ret (copy), go (copy), Sound (copy)
        if os.clock() - os_clock_ret < 1 then
            go();

            return;
        end;

        Sound:Destroy();
    end);
    task.delay(3, function() -- Line: 172
        -- upvalues: Sound (copy)
        if Sound.Parent and not Sound.IsPlaying then
            Sound:Destroy();
        end;
    end);

    return Sound;
end;

local function quiet(p15) -- Line: 180
    p15.Anchored = true;
    p15.CanCollide = false;
    p15.CanQuery = false;
    p15.CanTouch = false;
    p15.CastShadow = false;
end;

local function make(p16, p17, p18, p19) -- Line: 184
    local Instance_new_ret = Instance.new(p16);
    Instance_new_ret.Name = p18;

    for i, v in p19 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p17;

    return Instance_new_ret;
end;

local function invisible(p20, p21, p22) -- Line: 193
    local Part = Instance.new("Part");
    Part.Name = p21;

    for i, v in {
        Transparency = 1,
        Size = p22 or Vector3.new(1, 1, 1)
    } or {} do
        Part[i] = v;
    end;

    Part.Parent = p20;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;

    return Part;
end;

local function lookOf(p23) -- Line: 201
    -- upvalues: PumpkinHuntConfig (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local v24 = (p23 - PumpkinHuntConfig.KnifeChanceMin) / math.max(1, PumpkinHuntConfig.KnifeChanceMax - PumpkinHuntConfig.KnifeChanceMin);
    local math_clamp_ret = math.clamp(v24, 0, 1);
    local math_sqrt_ret = math.sqrt(math_clamp_ret);

    return math_sqrt_ret * 0.4 + 0.6, Color3_fromRGB_ret, Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret3, math_sqrt_ret), math_sqrt_ret;
end;

local function pumpkinSource() -- Line: 210
    -- upvalues: ReplicatedStorage (copy)
    local PumpkinHuntAssets = ReplicatedStorage:FindFirstChild("PumpkinHuntAssets");
    local v25;

    if PumpkinHuntAssets then
        v25 = PumpkinHuntAssets:FindFirstChild("OpeningPumpkin");
    else
        v25 = PumpkinHuntAssets;
    end;

    if v25 and v25:IsA("BasePart") then
        return v25;
    end;

    if PumpkinHuntAssets then
        PumpkinHuntAssets = PumpkinHuntAssets:FindFirstChild("Pumpkin");
    end;

    if PumpkinHuntAssets then
        PumpkinHuntAssets = PumpkinHuntAssets:FindFirstChild("Shell");
    end;

    if PumpkinHuntAssets and PumpkinHuntAssets:IsA("BasePart") then
        return PumpkinHuntAssets;
    end;

    return nil;
end;

local function buildPumpkin(p26) -- Line: 222
    -- upvalues: pumpkinSource (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local v27 = pumpkinSource();

    if not v27 then
        return nil;
    end;

    local v28 = v27:Clone();
    v28.Name = "Pumpkin";

    for _, child in v28:GetChildren() do
        if not (child:IsA("DataModelMesh") or (child:IsA("Decal") or child:IsA("SurfaceAppearance"))) then
            child:Destroy();
        end;
    end;

    v28.Anchored = true;
    v28.CanCollide = false;
    v28.CanQuery = false;
    v28.CanTouch = false;
    v28.CastShadow = false;
    v28.Transparency = 0;
    local v29 = v28:FindFirstChildOfClass("SpecialMesh");
    local v30 = {
        grow = 0,
        size = 1,
        squash = Vector3.new(1, 1, 1),
        roll = 0,
        blaze = 0,
        spin = 0,
        isPumpkin = true,
        part = v28,
        mesh = v29,
        baseSize = v28.Size,
        baseMesh = not v29 and Vector3.new(1, 1, 1) or v29.Scale,
        baseOffset = not v29 and Vector3.new(0, 0, 0) or v29.Offset,
        baseVertex = not v29 and Vector3.new(1, 1, 1) or v29.VertexColor,
        bornAt = os.clock()
    };

    if v29 then
        v29.Scale = Vector3.new(0.001, 0.001, 0.001);
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "Lamp";

    for i, v in {} do
        Attachment[i] = v;
    end;

    Attachment.Parent = v28;
    local PointLight = Instance.new("PointLight");
    PointLight.Name = "Glow";

    for i, v in {
        Shadows = false
    } or {} do
        PointLight[i] = v;
    end;

    PointLight.Parent = Attachment;
    local Part = Instance.new("Part");
    Part.Name = "PullShell";

    for i, v in {
        Size = Vector3.new(1, 1, 1),
        Transparency = 1
    } or {} do
        Part[i] = v;
    end;

    Part.Parent = v28;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    local v31 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        LightInfluence = 0,
        Enabled = false,
        Shape = Enum.ParticleEmitterShape.Sphere,
        ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        Color = ColorSequence.new(Color3_fromRGB_ret2, Color3_fromRGB_ret3),
        Lifetime = NumberRange.new(0.28, 0.32)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Pull";

    for i, v in v31 or {} do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = Part;
    v30.lamp = Attachment;
    v30.light = PointLight;
    v30.pull = ParticleEmitter;
    v30.shell = Part;
    v28.Parent = p26;

    return v30;
end;

local function dress(p32, p33) -- Line: 279
    local strength = p32.strength;
    local blaze = p32.blaze;

    if p32.fading then
        return;
    end;

    p32.light.Color = p32.high;
    p32.light.Brightness = 0.3 + 0.5 * strength + 1.5 * blaze;
    p32.light.Range = (6 + 4 * strength) * p33;
    local v34 = p32.fullF or p33;
    p32.pull.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2 * v34), NumberSequenceKeypoint.new(1, 0.07 * v34) });
    p32.pull.Speed = NumberRange.new(9 * p33);
end;

local function knifePrize(p35, p36) -- Line: 295
    -- upvalues: SkinCatalog (copy), Weapons (copy), KnifeIconCopy (copy)
    local v37 = SkinCatalog.get(p36);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        if v37 then
            v37 = Models:FindFirstChild(v37.Model);
        end;
    else
        v37 = Models;
    end;

    if v37 then
        v37 = v37:FindFirstChild("Blade") or v37:FindFirstChildWhichIsA("BasePart", true);
    end;

    if not (v37 and v37:IsA("BasePart")) then
        return nil;
    end;

    local v38, _, v39, v40 = KnifeIconCopy.new(v37);
    local v41 = { Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1) };
    local v42 = { v39.X, v39.Y, v39.Z };
    local v43 = 1;
    local v44 = 1;
    local v45 = v42[2] > v42[v43] and 2 or v43;
    local v46 = v42[2] < v42[v44] and 2 or v44;
    local v47 = v42[3] > v42[v45] and 3 or v45;
    local v48 = v42[3] < v42[v46] and 3 or v46;

    if v48 == v47 then
        v48 = v47 % 3 + 1;
    end;

    local v49 = v41[v47];
    local v50 = v41[v48];
    local GripPoint = v37:FindFirstChild("GripPoint");
    local v51;

    if GripPoint and GripPoint:IsA("Attachment") then
        v51 = GripPoint.Position;
    else
        v51 = v37.PivotOffset.Position;
    end;

    if v51:Dot(v49) > 0 then
        v49 = -v49;
    end;

    local v52 = CFrame.fromMatrix(Vector3.new(0, 0, 0), v49:Cross(v50), v49, v50):Inverse();
    local Model = Instance.new("Model");
    Model.Name = "Knife";
    v38.Parent = Model;
    Model.PrimaryPart = v38;

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.CastShadow = false;
        end;
    end;

    Model:ScaleTo(0.01);
    Model.Parent = p35;

    return {
        scaled = 0.01,
        spin = 0,
        turns = true,
        sway = 0.6981317007977318,
        part = v38,
        model = Model,
        size = v42[v47],
        middle = v40,
        stand = v52
    };
end;

local function picturePrize(p53, p54, p55) -- Line: 352
    -- upvalues: Font_new_ret (copy)
    local Part = Instance.new("Part");
    Part.Name = "Picture";

    for i, v in {
        Size = Vector3.new(1, 1, 0.02),
        Transparency = 1
    } or {} do
        Part[i] = v;
    end;

    Part.Parent = p53;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;

    for _, v in { Enum.NormalId.Front, Enum.NormalId.Back } do
        local v56 = "Face" .. v.Name;
        local v57 = {
            LightInfluence = 0,
            Brightness = 1.15,
            ClipsDescendants = false,
            Face = v,
            SizingMode = Enum.SurfaceGuiSizingMode.FixedSize,
            CanvasSize = Vector2.new(400, 400),
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        };
        local SurfaceGui = Instance.new("SurfaceGui");
        SurfaceGui.Name = v56;

        for i, v2 in v57 or {} do
            SurfaceGui[i] = v2;
        end;

        SurfaceGui.Parent = Part;
        local v58 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.92, 0.92),
            Image = p54,
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Icon";

        for i, v2 in v58 or {} do
            ImageLabel[i] = v2;
        end;

        ImageLabel.Parent = SurfaceGui;

        if p55 then
            local v59 = {
                BackgroundTransparency = 1,
                TextScaled = true,
                ZIndex = 2,
                AnchorPoint = Vector2.new(1, 1),
                Position = UDim2.fromScale(1.02, 1),
                Size = UDim2.fromScale(0.62, 0.42),
                FontFace = Font_new_ret,
                Text = p55,
                TextColor3 = Color3.fromRGB(255, 202, 58)
            };
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "Boost";

            for i, v2 in v59 or {} do
                TextLabel[i] = v2;
            end;

            TextLabel.Parent = SurfaceGui;
            local v60 = {
                Thickness = 0.12,
                Color = Color3.new(0, 0, 0),
                StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
                LineJoinMode = Enum.LineJoinMode.Round
            };
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Name = "UIStroke";

            for i, v2 in v60 or {} do
                UIStroke[i] = v2;
            end;

            UIStroke.Parent = TextLabel;
        end;
    end;

    return {
        size = 1,
        flat = Vector3.new(1, 1, 0.02),
        spin = 0,
        sway = 0.24434609527920614,
        part = Part
    };
end;

local function wheelPrize(p61) -- Line: 396
    -- upvalues: StarterGui (copy)
    local SpinWheel = StarterGui:FindFirstChild("SpinWheel");

    if SpinWheel then
        SpinWheel = SpinWheel:FindFirstChild("Main");
    end;

    if SpinWheel then
        SpinWheel = SpinWheel:FindFirstChild("Wheel");
    end;

    if not (SpinWheel and SpinWheel:IsA("GuiObject")) then
        return nil;
    end;

    local Part = Instance.new("Part");
    Part.Name = "Wheel";

    for i, v in {
        Size = Vector3.new(1, 1, 0.02),
        Transparency = 1
    } or {} do
        Part[i] = v;
    end;

    Part.Parent = p61;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    local v62 = {
        LightInfluence = 0,
        Brightness = 1.1,
        ClipsDescendants = false,
        Face = Enum.NormalId.Front,
        SizingMode = Enum.SurfaceGuiSizingMode.FixedSize,
        CanvasSize = Vector2.new(500, 500),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Name = "Face";

    for i, v in v62 or {} do
        SurfaceGui[i] = v;
    end;

    SurfaceGui.Parent = Part;
    local v63 = SpinWheel:Clone();

    for _, descendant in v63:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") then
            descendant:Destroy();
        end;
    end;

    v63.AnchorPoint = Vector2.new(0.5, 0.5);
    v63.Position = UDim2.fromScale(0.5, 0.5);
    v63.Size = UDim2.fromScale(0.98, 0.98);
    v63.Visible = true;
    v63.Parent = SurfaceGui;
    local v64 = {
        Size = Vector3.new(0.08, 0.93, 0.93),
        Shape = Enum.PartType.Cylinder,
        Color = Color3.fromRGB(34, 16, 48),
        Material = Enum.Material.SmoothPlastic
    };
    local Part2 = Instance.new("Part");
    Part2.Name = "Disc";

    for i, v in v64 or {} do
        Part2[i] = v;
    end;

    Part2.Parent = Part;
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;

    return {
        size = 1,
        flat = Vector3.new(1, 1, 0.02),
        spin = 0,
        sway = 0.2792526803190927,
        part = Part,
        extra = {
            {
                size = Vector3.new(0.08, 0.93, 0.93),
                part = Part2,
                offset = CFrame.new(0, 0, 0.045) * CFrame.Angles(0, 1.5707963267948966, 0)
            }
        },
        spinner = v63:FindFirstChild("Spinner")
    };
end;

local function prizeFor(p65, p66) -- Line: 443
    -- upvalues: knifePrize (copy), PumpkinHuntConfig (copy), wheelPrize (copy), picturePrize (copy)
    local kind = p66.kind;
    local v67 = nil;

    if kind == "Knife" then
        v67 = knifePrize(p65, p66.knife or PumpkinHuntConfig.Knife);
    elseif kind == "Spins" then
        v67 = wheelPrize(p65);
    end;

    if v67 then
        return v67;
    end;

    if kind == "Spins" then
        return picturePrize(p65, "rbxassetid://78008558948307", "SPIN");
    end;

    return picturePrize(p65, (kind == "Gems" or kind == "GemBoostMinutes") and "rbxassetid://137046122108742" or (kind == "CandyCorn" and "rbxassetid://119759573303359" or (kind == "GhostKeys" and "rbxassetid://99826093535691" or "rbxassetid://78008558948307")), (kind == "CoinBoostMinutes" or kind == "GemBoostMinutes") and "2x" or nil);
end;

function u1.new(p68) -- Line: 470
    -- upvalues: u1 (copy)
    return setmetatable({
        token = 0,
        hover = 0,
        stage = p68,
        lean = Vector2.zero
    }, u1);
end;

function u1.folder(p69) -- Line: 481
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not p69.holder then
        p69.holder = Instance.new("Folder");
        p69.holder.Name = "PumpkinOpening";
    end;

    if p69.hidden then
        if p69.holder.Parent ~= nil then
            p69.holder.Parent = nil;
        end;
    elseif workspace_CurrentCamera and p69.holder.Parent ~= workspace_CurrentCamera then
        p69.holder.Parent = workspace_CurrentCamera;
    end;

    return p69.holder;
end;

function u1.sound(p70, p71, p72, p73) -- Line: 498
    -- upvalues: sound (copy)
    return sound(p71, p72, p73, p70.voice);
end;

function u1.spot(p74, p75) -- Line: 503
    -- upvalues: Vector2_new_ret (copy)
    if p74.layout then
        return p74.layout(p75);
    end;

    local stage = p74.stage;

    if not (stage and (stage.Parent and stage.AbsoluteSize.Y > 1)) then
        return nil;
    end;

    local v76 = stage:FindFirstAncestorWhichIsA("ScreenGui");
    local v77 = stage.AbsolutePosition + stage.AbsoluteSize * Vector2_new_ret;
    local v78;

    if v76 and v76.IgnoreGuiInset then
        v78 = p75:ViewportPointToRay(v77.X, v77.Y);
    else
        v78 = p75:ScreenPointToRay(v77.X, v77.Y);
    end;

    local v79 = v78.Direction:Dot(p75.CFrame.LookVector);
    local v80 = v78.Origin + v78.Direction * (5.5 / math.max(v79, 0.3));
    local v81 = math.rad(p75.FieldOfView) / 2;

    return v80, math.tan(v81) * 11 / math.max(1, p75.ViewportSize.Y) * stage.AbsoluteSize.Y, stage.AbsoluteSize.Y;
end;

function u1.running(u82) -- Line: 520
    -- upvalues: RunService (copy)
    if u82.connection then
        return;
    end;

    u82.connection = RunService.RenderStepped:Connect(function(p83) -- Line: 524
        -- upvalues: u82 (copy)
        local success, result = pcall(u82.step, u82, p83);

        if not success then
            warn("[PumpkinFloat] " .. tostring(result));
            u82:dismiss(true);
        end;
    end);
end;

function u1.stopIfIdle(p84) -- Line: 533
    if p84.connection and not (p84.pumpkin or (p84.prize or (p84.leaving or p84.veiled))) then
        p84.connection:Disconnect();
        p84.connection = nil;
    end;
end;

function u1.step(p85, p86) -- Line: 541
    -- upvalues: UserInputService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    p85:folder();
    p85:poseVeil(workspace_CurrentCamera);
    local v87, v88, v89 = p85:spot(workspace_CurrentCamera);

    if not v87 then
        return;
    end;

    local v90 = CFrame.new(v87) * workspace_CurrentCamera.CFrame.Rotation;

    if p85.facing then
        local v91 = v87 - workspace_CurrentCamera.CFrame.Position;

        if v91.Magnitude > 0.01 and math.abs(v91.Unit.Y) < 0.98 then
            v90 = CFrame.lookAt(v87, v87 + v91);
        end;
    end;

    local v92 = 0;
    local Vector2_zero = Vector2.zero;
    local v93;

    if UserInputService.MouseEnabled and v89 then
        local v94 = workspace_CurrentCamera:WorldToViewportPoint(v87);
        v93 = (UserInputService:GetMouseLocation() - Vector2.new(v94.X, v94.Y)) / math.max(1, v89 * 0.42);

        if v93.Magnitude < 1 then
            v92 = 1;
        else
            v93 = Vector2_zero;
        end;
    else
        v93 = Vector2_zero;
    end;

    local math_min_ret = math.min(1, p86 * 8);
    p85.hover = p85.hover + (v92 - p85.hover) * math_min_ret;
    p85.lean = p85.lean:Lerp(v93, math_min_ret);
    local os_clock_ret = os.clock();

    if p85.pumpkin then
        p85:posePumpkin(p85.pumpkin, v90, v88, os_clock_ret);
    end;

    if p85.prize then
        p85:posePrize(p85.prize, workspace_CurrentCamera, v90, v88, os_clock_ret, p86);
    end;

    if p85.leaving then
        for i, v in p85.leaving do
            local math_clamp_ret = math.clamp((os_clock_ret - v.at) / 0.22, 0, 1);
            v.scale = 1 - math_clamp_ret * math_clamp_ret;

            if i.part then
                if i.isPumpkin then
                    p85:posePumpkin(i, v90, v88, os_clock_ret, v.scale);
                else
                    p85:posePrize(i, workspace_CurrentCamera, v90, v88, os_clock_ret, p86, v.scale);
                end;
            end;

            if math_clamp_ret >= 1 then
                p85.leaving[i] = nil;
                pcall(function() -- Line: 593
                    -- upvalues: i (copy)
                    (i.root or i.part):Destroy();
                end);
            end;
        end;

        if next(p85.leaving) == nil then
            p85.leaving = nil;
        end;
    end;

    p85:stopIfIdle();
end;

function u1.posePumpkin(p95, p96, p97, p98, p99, p100) -- Line: 605
    -- upvalues: u3 (copy), CFrame_Angles_ret (copy), dress (copy)
    local v101 = p98 * 0.74;
    local v102 = v101 / p96.baseSize.Y;
    local math_clamp_ret = math.clamp((p99 - p96.bornAt) / 0.55, 0, 1);
    p96.grow = 1 + 2.70158 * (math_clamp_ret - 1) ^ 3 + 1.70158 * (math_clamp_ret - 1) ^ 2;

    if p96.shakeAt and not p96.bursting then
        local v103 = p99 - p96.shakeAt;
        local v104 = 0;
        local v105 = 0;

        for i, v in u3 do
            local v106 = (v103 - v[1]) / 0.28;

            if v106 >= 0 and v106 <= 1 then
                if p96.knocked ~= i then
                    p96.knocked = i;
                    p95:sound("Thud", 0.8 + 0.05 * i);
                end;

                v104 = (i % 2 == 0 and -1 or 1) * math.rad(v[2]) * math.sin(v106 * 3.141592653589793 * 2) * (1 - 0.35 * v106);
                v105 = math.sin(v106 * 3.141592653589793) * 0.06;
            end;
        end;

        if v103 > 1.2400000000000002 then
            v104 = math.sin(p99 * 18) * 0.04363323129985824;
        end;

        p96.roll = v104;
        p96.squash = Vector3.new(v105 + 1, 1 - v105, v105 + 1);
    end;

    local v107 = p96.shakeAt and 0.25 or 1;
    local v108 = p96.grow * p96.size * (p100 or 1);
    local v109 = v101 * v108;
    local hover = p95.hover;
    local lean = p95.lean;
    local v110 = math.sin(p99 * 1.7) * 0.035 * v101 * v107;
    local v111 = math.sin(p99 * 0.9) * 0.15707963267948966 * v107;
    local v112 = math.sin(p99 * 1.25) * 0.05235987755982989 * v107;
    local v113 = math.sin(p99 * 1.4) * 0.04363323129985824 * v107;
    p96.part.CFrame = p97 * CFrame.new(lean.X * 0.03 * v101 * hover, -lean.Y * 0.03 * v101 * hover + v110, 0) * CFrame.Angles(lean.Y * 0.2 * hover, lean.X * 0.28 * hover, 0) * CFrame.new(0, -v109 / 2, 0) * CFrame.Angles(0, 0, p96.roll + v113) * CFrame.new(0, v109 / 2, 0) * CFrame.Angles(v112, v111 + (1 - math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret)) * -3.141592653589793 * 0.9, 0) * CFrame_Angles_ret;
    local v114 = v102 * math.max(v108, 0.001);
    local squash = p96.squash;
    p96.part.Size = p96.baseSize * math.max(v114, 0.01) * squash;

    if p96.mesh then
        p96.mesh.Scale = p96.baseMesh * v114 * squash;
        p96.mesh.Offset = p96.baseOffset * v114 * squash;
        p96.mesh.VertexColor = (p96.baseVertex * (0.8 + 0.2 * (p96.t or 0)) * (1 + 0.06 * hover)):Lerp(Vector3.new(1.75, 1.45, 1.1), p96.blaze * 0.8);
    end;

    p96.shell.Size = Vector3.new(1, 1, 1) * math.max(0.05, v109 * 1.8);
    p96.shell.CFrame = CFrame.new(p96.part.Position);
    p96.lamp.Position = Vector3.new(0, (p96.baseSize.Y / 2 + 2.5) * v114, 0);
    local v115 = math.floor(v109 / 3.676 * 50 + 0.5) / 50;

    if v115 ~= p96.dressedAt or (p96.blaze ~= p96.dressedBlaze or p96.restyle) then
        local blaze = p96.blaze;
        p96.dressedAt = v115;
        p96.dressedBlaze = blaze;
        p96.restyle = nil;
        dress(p96, (math.max(v115, 0.02)));
    end;
end;

function u1.posePrize(p116, p117, p118, p119, p120, p121, p122, p123) -- Line: 675
    -- upvalues: CFrame_Angles_ret (copy)
    local v124 = p120 * 0.78;
    local math_clamp_ret = math.clamp((p121 - p117.bornAt) / 0.5, 0, 1);
    local v125 = (1 + 2.70158 * (math_clamp_ret - 1) ^ 3 + 1.70158 * (math_clamp_ret - 1) ^ 2) * (p123 or 1);
    local hover = p116.hover;
    local lean = p116.lean;
    local v126 = (1 - math.cos(p121 * 2)) * 0.03 * v124;
    local v127 = math.sin((p121 - p117.bornAt) * (p117.turns and 1.4 or 1.1)) * p117.sway;
    local v128 = (1 - math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret)) * 3.141592653589793 * 2 * (p117.turns and 1 or 0.25);
    p117.yaw = (p117.yaw or 0) + p117.spin * 3.141592653589793 * 2 * (p122 or 0);
    local v129 = v124 / p117.size * math.max(v125, 0.001) * (1 + 0.05 * hover);
    local v130 = p119 * CFrame.new(lean.X * 0.04 * v124 * hover, -lean.Y * 0.04 * v124 * hover + v126, 0) * CFrame.Angles(lean.Y * 0.3 * hover, lean.X * 0.38 * hover, 0) * CFrame.Angles(0, v127 + p117.yaw + v128, math.sin(p121 * 1.3) * 0.06981317007977318);

    if p117.model then
        local math_max_ret = math.max(v129, 0.01);

        if math.abs((p117.scaled or 0) - math_max_ret) > 0.002 then
            p117.model:ScaleTo(math_max_ret);
            p117.scaled = math_max_ret;
        end;

        p117.part.CFrame = v130 * p117.stand * CFrame.new(-p117.middle * math_max_ret);
    else
        p117.part.Size = p117.flat * v129;
        p117.part.CFrame = v130 * CFrame_Angles_ret;

        for _, v in p117.extra or {} do
            v.part.Size = v.size * v129;
            v.part.CFrame = p117.part.CFrame * CFrame.new(v.offset.Position * v129) * v.offset.Rotation;
        end;
    end;

    if p117.spinner then
        p117.spinner.Rotation = (p117.spinner.Rotation + (p122 or 0) * 70) % 360;
    end;

    p117.rays.CFrame = CFrame.new(p119.Position + (p119.Position - p118.CFrame.Position).Unit * 1.2);
    local v131 = (1.1 + 0.02 * p117.level) * p120 * 1.2181818181818183 * math.max(v125, 0);
    p117.board.Size = UDim2.fromScale(math.max(v131, 0.01), (math.max(v131, 0.01)));
    p117.ring1.Rotation = (p117.ring1.Rotation + (p122 or 0) * 40) % 360;
    p117.ring2.Rotation = (p117.ring2.Rotation - (p122 or 0) * 25) % 360;
    p117.glow.CFrame = CFrame.new(p119.Position);
    local glow = p117.glow;
    local v132 = v124 * 0.75 * math.max(v125, 0);
    glow.Size = Vector3.new(1, 1, 1) * math.max(0.05, v132);
    p117.light.Range = v124 * 1.6;
    p117.front.CFrame = CFrame.lookAt(p119.Position - (p119.Position - p118.CFrame.Position).Unit * v124 * 0.9 + p118.CFrame.UpVector * v124 * 0.3, p119.Position);
    p117.key.Range = v124 * 1.4;
end;

function u1.veil(u133, p134) -- Line: 732
    -- upvalues: Color3_fromRGB_ret4 (copy), TweenService (copy)
    if p134 then
        if u133.veiled and u133.veiled.part.Parent then
            return;
        end;

        local v135 = u133:folder();
        local Part = Instance.new("Part");
        Part.Name = "Veil";

        for i, v in {
            Size = Vector3.new(1, 1, 0.05),
            Transparency = 1
        } or {} do
            Part[i] = v;
        end;

        Part.Parent = v135;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        local v136 = {
            LightInfluence = 0,
            AlwaysOnTop = false,
            Face = Enum.NormalId.Front,
            SizingMode = Enum.SurfaceGuiSizingMode.FixedSize,
            CanvasSize = Vector2.new(64, 64)
        };
        local SurfaceGui = Instance.new("SurfaceGui");
        SurfaceGui.Name = "Shade";

        for i, v in v136 or {} do
            SurfaceGui[i] = v;
        end;

        SurfaceGui.Parent = Part;
        local v137 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3_fromRGB_ret4
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Shade";

        for i, v in v137 or {} do
            Frame[i] = v;
        end;

        Frame.Parent = SurfaceGui;
        TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.35
        }):Play();
        u133.veiled = {
            part = Part,
            shade = Frame
        };
        u133:running();
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            u133:poseVeil(workspace_CurrentCamera);
        end;
    elseif u133.veiled then
        local veiled = u133.veiled;
        u133.veiled = nil;
        TweenService:Create(veiled.shade, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        task.delay(0.26, function() -- Line: 762
            -- upvalues: veiled (copy)
            veiled.part:Destroy();
        end);
        u133.fadingVeil = veiled;
        task.delay(0.26, function() -- Line: 767
            -- upvalues: u133 (copy), veiled (copy)
            if u133.fadingVeil == veiled then
                u133.fadingVeil = nil;
            end;
        end);
    end;
end;

function u1.poseVeil(p138, p139) -- Line: 776
    -- upvalues: CFrame_Angles_ret (copy)
    for _, v in { p138.veiled, p138.fadingVeil } do
        if v and v.part.Parent then
            local v140 = math.rad(p139.FieldOfView) / 2;
            local v141 = math.tan(v140) * 15.2 * 1.25;
            local ViewportSize = p139.ViewportSize;
            local v142 = ViewportSize.X / math.max(1, ViewportSize.Y);
            local v143 = v141 * math.max(1, v142);
            v.part.Size = Vector3.new(v143, v141, 0.05);
            v.part.CFrame = p139.CFrame * CFrame.new(0, 0, -7.6) * CFrame_Angles_ret;
        end;
    end;
end;

function u1.ready(p144) -- Line: 788
    return p144.pumpkin ~= nil;
end;

function u1.present(p145, p146) -- Line: 793
    -- upvalues: buildPumpkin (copy), PumpkinHuntConfig (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    if p146 == nil then
        if p145.pumpkin and not p145.pumpkin.shakeAt then
            p145:dismiss(false);
        end;

        return;
    end;

    local pumpkin = p145.pumpkin;

    if pumpkin and (pumpkin.shakeAt or pumpkin.fading) then
        return;
    end;

    if pumpkin and pumpkin.chance == p146 then
        return;
    end;

    if not pumpkin then
        local v147;
        v147, pumpkin = pcall(buildPumpkin, p145:folder());

        if not (v147 and pumpkin) then
            if not v147 then
                warn("[PumpkinFloat] couldn\'t build the pumpkin: " .. tostring(pumpkin));
            end;

            return;
        end;

        p145.pumpkin = pumpkin;

        if p145.lights == false then
            pumpkin.light.Enabled = false;
        end;

        p145:sound("Tell", 1.25, 0.3);
    end;

    pumpkin.chance = p146;
    local v148 = (p146 - PumpkinHuntConfig.KnifeChanceMin) / math.max(1, PumpkinHuntConfig.KnifeChanceMax - PumpkinHuntConfig.KnifeChanceMin);
    local math_clamp_ret = math.clamp(v148, 0, 1);
    local math_sqrt_ret = math.sqrt(math_clamp_ret);
    local v149 = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret3, math_sqrt_ret);
    pumpkin.strength = math_sqrt_ret * 0.4 + 0.6;
    pumpkin.low = Color3_fromRGB_ret;
    pumpkin.high = v149;
    pumpkin.t = math_sqrt_ret;
    pumpkin.restyle = true;
    p145:running();
    pcall(p145.step, p145, 0);
end;

local function gone(p150, u151, p152) -- Line: 830
    if not u151 then
        return;
    end;

    if p152 or not p150.connection then
        pcall(function() -- Line: 835
            -- upvalues: u151 (copy)
            (u151.root or u151.part):Destroy();
        end);

        return;
    end;

    p150.leaving = p150.leaving or {};
    p150.leaving[u151] = {
        at = os.clock()
    };
end;

function u1.dismiss(p153, p154) -- Line: 844
    -- upvalues: gone (copy)
    p153.token = p153.token + 1;
    p153:quiet(p154 and 0.1 or 0.3);
    local pumpkin = p153.pumpkin;
    local prize = p153.prize;
    p153.pumpkin = nil;
    p153.prize = nil;
    gone(p153, pumpkin, p154);
    gone(p153, prize, p154);

    if p154 then
        if p153.leaving then
            for i in p153.leaving do
                pcall(function() -- Line: 854
                    -- upvalues: i (copy)
                    (i.root or i.part):Destroy();
                end);
            end;

            p153.leaving = nil;
        end;

        if p153.holder then
            p153.holder:ClearAllChildren();
        end;

        p153.veiled = nil;
        p153.fadingVeil = nil;
    end;

    p153:stopIfIdle();
end;

function u1.anticipate(p155) -- Line: 868
    -- upvalues: u2 (copy), TweenService (copy)
    local pumpkin = p155.pumpkin;

    if pumpkin and not (pumpkin.fading or pumpkin.shakeAt) then
        pumpkin.shakeAt = os.clock();
        pumpkin.knocked = nil;
        p155:sound("Whisper");
        p155:quiet(0.2);
        local v156 = p155:sound("Drone", 1, 0);

        if v156 then
            p155.drone = v156;
            local v157 = u2.Drone[2] * (p155.voice and (p155.voice.volume or 1) or 1);
            TweenService:Create(v156, TweenInfo.new(0.8), {
                Volume = v157
            }):Play();
        end;
    end;
end;

function u1.quiet(p158, p159) -- Line: 886
    -- upvalues: hush (copy)
    hush(p158.drone, p159);
    hush(p158.swell, p159);
    hush(p158.creak, p159);
    p158.drone = nil;
    p158.swell = nil;
    p158.creak = nil;
end;

function u1.settle(p160) -- Line: 893
    local pumpkin = p160.pumpkin;

    if pumpkin and not pumpkin.bursting then
        pumpkin.shakeAt = nil;
        pumpkin.roll = 0;
        pumpkin.squash = Vector3.new(1, 1, 1);
    end;

    p160:quiet(0.4);
end;

function u1.landed(p161) -- Line: 904
    p161:sound("Toll");
end;

function u1.slam(p162) -- Line: 908
    p162:sound("Thud", 0.7, 0.7);
end;

function u1.burst(u163, p164, p165) -- Line: 914
    -- upvalues: RunService (copy), u4 (copy)
    local pumpkin = u163.pumpkin;

    if not pumpkin or pumpkin.fading then
        return false;
    end;

    local token = u163.token;

    if not pumpkin.shakeAt then
        u163:anticipate();
    end;

    local function wait() -- Line: 923
        -- upvalues: RunService (ref), u163 (copy), token (copy), pumpkin (copy)
        RunService.RenderStepped:Wait();
        local v166;

        if u163.token == token then
            v166 = u163.pumpkin == pumpkin;
        else
            v166 = false;
        end;

        return v166;
    end;

    while os.clock() - pumpkin.shakeAt < 1.2400000000000002 do
        RunService.RenderStepped:Wait();
        local v167;

        if u163.token == token then
            v167 = u163.pumpkin == pumpkin;
        else
            v167 = false;
        end;

        if not v167 then
            return false;
        end;
    end;

    pumpkin.bursting = true;
    pumpkin.roll = 0;
    local u168 = false;
    local u169 = os.clock() + #u4 * 0.38;

    local function shrinkSounds() -- Line: 937
        -- upvalues: u168 (ref), u169 (ref), u163 (copy)
        if not u168 and os.clock() >= u169 - 0.2 then
            u168 = true;
            u163.creak = u163:sound("Strain", 0.6, 0.9);
            u163.swell = u163:sound("Swell");
        end;
    end;

    for i, v in u4 do
        u163:sound("Thud", 0.95 + 0.05 * i);
        local size = pumpkin.size;
        local os_clock_ret = os.clock();
        local v170 = i;
        local v171 = v;

        while true do
            local v172 = (os.clock() - os_clock_ret) / 0.3;
            local math_clamp_ret = math.clamp(v172, 0, 1);
            local v173 = math.sin(math_clamp_ret * 3.141592653589793 * 2.5) * (1 - math_clamp_ret);
            pumpkin.size = size + (v171 - size) * (math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret));
            pumpkin.squash = Vector3.new(v173 * 0.2 + 1, 1 - v173 * 0.22, v173 * 0.2 + 1);
            pumpkin.roll = math.sin(math_clamp_ret * 3.141592653589793 * 2) * 0.08726646259971647 * (v170 % 2 == 0 and 1 or -1);

            if not u168 and os.clock() >= u169 - 0.2 then
                u168 = true;
                u163.creak = u163:sound("Strain", 0.6, 0.9);
                u163.swell = u163:sound("Swell");
            end;

            if math_clamp_ret >= 1 then
                break;
            end;

            RunService.RenderStepped:Wait();
            local v174;

            if u163.token == token then
                v174 = u163.pumpkin == pumpkin;
            else
                v174 = false;
            end;

            if not v174 then
                return false;
            end;
        end;

        pumpkin.squash = Vector3.new(1, 1, 1);
        pumpkin.roll = 0;
        local os_clock_ret2 = os.clock();

        while os.clock() - os_clock_ret2 < 0.08 do
            if not u168 and os.clock() >= u169 - 0.2 then
                u168 = true;
                u163.creak = u163:sound("Strain", 0.6, 0.9);
                u163.swell = u163:sound("Swell");
            end;

            RunService.RenderStepped:Wait();
            local v175;

            if u163.token == token then
                v175 = u163.pumpkin == pumpkin;
            else
                v175 = false;
            end;

            if not v175 then
                return false;
            end;
        end;
    end;

    u169 = os.clock();

    if not u168 and os.clock() >= u169 - 0.2 then
        u168 = true;
        u163.creak = u163:sound("Strain", 0.6, 0.9);
        u163.swell = u163:sound("Swell");
    end;

    pumpkin.fullF = pumpkin.dressedAt;
    pumpkin.pull.Enabled = true;
    pumpkin.pull.Rate = 110;
    local size = pumpkin.size;
    local os_clock_ret = os.clock();

    while true do
        local v176 = (os.clock() - os_clock_ret) / 0.55;
        local math_clamp_ret = math.clamp(v176, 0, 1);
        local os_clock_ret2 = os.clock();
        pumpkin.size = size + (0.3 - size) * math_clamp_ret * math_clamp_ret;
        pumpkin.blaze = math_clamp_ret;
        pumpkin.roll = math.sin(os_clock_ret2 * 60) * math.rad(math_clamp_ret * 6 + 3);
        local v177 = math.sin(os_clock_ret2 * 45) * 0.07;
        pumpkin.squash = Vector3.new(v177 + 1, 1 - v177, v177 + 1);

        if math_clamp_ret >= 1 then
            break;
        end;

        RunService.RenderStepped:Wait();
        local v178;

        if u163.token == token then
            v178 = u163.pumpkin == pumpkin;
        else
            v178 = false;
        end;

        if not v178 then
            return false;
        end;
    end;

    local CFrame2 = pumpkin.part.CFrame;
    u163.pumpkin = nil;
    pcall(function() -- Line: 1002
        -- upvalues: pumpkin (copy)
        pumpkin.part:Destroy();
    end);
    u163:pop(CFrame2, p164, p165);

    return true;
end;

function u1.pop(p179, p180, p181, p182) -- Line: 1010
    -- upvalues: TweenService (copy), RunService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v183 = p179:folder();
    local _, v184 = p179:spot(workspace_CurrentCamera);
    local u185 = (v184 or 3) * 0.74;
    p179:quiet(0.5);
    p179:sound("Boom");
    p179:sound("Splinter", 0.9);
    p179:sound("AnkleBreak", 0.8, 0.35);
    local v186 = {
        Transparency = 1,
        Size = Vector3.new(1, 1, 1) * u185 * 0.3 or Vector3.new(1, 1, 1)
    };
    local Part = Instance.new("Part");
    Part.Name = "Burst";

    for i, v in v186 or {} do
        Part[i] = v;
    end;

    Part.Parent = v183;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.CFrame = p180;
    local v187 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        LightInfluence = 0,
        Drag = 3,
        Enabled = false,
        Color = ColorSequence.new(p181, Color3.new(1, 1, 1)),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2 * u185), NumberSequenceKeypoint.new(1, 0) }),
        Lifetime = NumberRange.new(0.45, 0.9),
        Speed = NumberRange.new(2.2 * u185, 4.5 * u185),
        SpreadAngle = Vector2.new(180, 180)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Sparks";

    for i, v in v187 or {} do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(40 + 10 * p182);

    if p179.lights ~= false then
        local v188 = {
            Brightness = 8,
            Shadows = false,
            Color = p181:Lerp(Color3.new(1, 1, 1), 0.4),
            Range = u185 * 4
        };
        local PointLight = Instance.new("PointLight");
        PointLight.Name = "Flash";

        for i, v in v188 or {} do
            PointLight[i] = v;
        end;

        PointLight.Parent = Part;
        TweenService:Create(PointLight, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Brightness = 0
        }):Play();
    end;

    task.delay(1.2, function() -- Line: 1039
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
    local RightVector = workspace_CurrentCamera.CFrame.RightVector;
    local UpVector = workspace_CurrentCamera.CFrame.UpVector;
    local v189 = -workspace_CurrentCamera.CFrame.LookVector;
    local v190 = { Color3.fromRGB(255, 140, 30), Color3.fromRGB(226, 104, 14), Color3.fromRGB(255, 172, 64) };
    local u191 = {};

    for i = 1, 12 do
        local v192 = i / 12 * 3.141592653589793 * 2 + math.random() * 0.4;
        local v193 = u185 * (0.1 + math.random() * 0.08);
        local v194 = {
            Size = Vector3.new(v193, v193 * 0.7, v193 * 0.45),
            Color = v190[i % 3 + 1],
            Material = Enum.Material.SmoothPlastic
        };
        local Part2 = Instance.new("Part");
        Part2.Name = "Chunk";
        local _ = i;

        for i2, v in v194 or {} do
            Part2[i2] = v;
        end;

        Part2.Parent = v183;
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CanTouch = false;
        Part2.CastShadow = false;
        local v195 = RightVector * math.cos(v192) + UpVector * math.sin(v192) + v189 * 0.25;
        local v196 = {
            part = Part2,
            position = p180.Position + v195 * u185 * 0.15,
            velocity = v195 * u185 * (2.6 + math.random() * 1.6) + UpVector * u185 * 1.2,
            spin = CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)
        };
        local v197 = math.random() - 0.5;
        local v198 = math.random() - 0.5;
        local v199 = math.random() - 0.5;
        v196.turn = Vector3.new(v197, v198, v199) * 14;
        table.insert(u191, v196);
    end;

    local os_clock_ret = os.clock();
    local u200 = nil;
    u200 = RunService.RenderStepped:Connect(function(p201) -- Line: 1066
        -- upvalues: os_clock_ret (copy), u191 (copy), UpVector (copy), u185 (copy), u200 (ref)
        local v202 = os.clock() - os_clock_ret;

        for _, v in u191 do
            if v.part.Parent then
                v.velocity = v.velocity - UpVector * u185 * 9 * p201;
                v.position = v.position + v.velocity * p201;
                v.spin = v.spin * CFrame.Angles(v.turn.X * p201, v.turn.Y * p201, v.turn.Z * p201);
                v.part.CFrame = CFrame.new(v.position) * v.spin;
                v.part.LocalTransparencyModifier = math.clamp((v202 - 0.25) / 0.25, 0, 1);
            end;
        end;

        if v202 > 0.5 then
            u200:Disconnect();

            for _, v in u191 do
                v.part:Destroy();
            end;
        end;
    end);
end;

function u1.reward(p203, p204, p205, p206) -- Line: 1087
    -- upvalues: prizeFor (copy)
    local v207 = p203:folder();

    if p203.prize then
        local prize = p203.prize;

        if prize then
            pcall(function() -- Line: 835
                -- upvalues: prize (copy)
                (prize.root or prize.part):Destroy();
            end);
        end;

        p203.prize = nil;
    end;

    local Model = Instance.new("Model");
    Model.Name = "Prize";
    Model.Parent = v207;
    local success, result = pcall(prizeFor, Model, p204);

    if not (success and result) then
        warn("[PumpkinFloat] couldn\'t build the prize: " .. tostring(result));
        Model:Destroy();

        return;
    end;

    result.root = Model;
    result.level = p206 or 0;
    result.bornAt = os.clock();
    local Part = Instance.new("Part");
    Part.Name = "Rays";

    for i, v in {
        Size = Vector3.new(0.2, 0.2, 0.2),
        Transparency = 1
    } or {} do
        Part[i] = v;
    end;

    Part.Parent = Model;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    local v208 = {
        LightInfluence = 0,
        Brightness = 1.5,
        AlwaysOnTop = false,
        Adornee = Part,
        Size = UDim2.fromScale(1, 1),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "Rays";

    for i, v in v208 or {} do
        BillboardGui[i] = v;
    end;

    BillboardGui.Parent = Part;
    local v209 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ImageTransparency = 0.18,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.87, 0.87),
        ImageColor3 = p205
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Rays";

    for i, v in v209 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = BillboardGui;
    local v210 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ImageTransparency = 0.42,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        ImageColor3 = p205:Lerp(Color3.new(1, 1, 1), 0.4)
    };
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Rays2";

    for i, v in v210 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = BillboardGui;
    local Part2 = Instance.new("Part");
    Part2.Name = "Glow";

    for i, v in {
        Size = Vector3.new(1, 1, 1),
        Transparency = 1
    } or {} do
        Part2[i] = v;
    end;

    Part2.Parent = Model;
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;
    local v211 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 0.7,
        LightInfluence = 0,
        LockedToPart = true,
        Color = ColorSequence.new(p205, Color3.new(1, 1, 1)),
        Shape = Enum.ParticleEmitterShape.Sphere,
        ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.1), NumberSequenceKeypoint.new(1, 0) }),
        Lifetime = NumberRange.new(0.6, 1.1),
        Speed = NumberRange.new(0.2, 0.6),
        Rate = 8 + 5 * result.level
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Sparkles";

    for i, v in v211 or {} do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = Part2;
    local v212 = {
        Shadows = false,
        Color = p205,
        Brightness = 0.8 + 0.3 * result.level
    };
    local PointLight = Instance.new("PointLight");
    PointLight.Name = "Light";

    for i, v in v212 or {} do
        PointLight[i] = v;
    end;

    PointLight.Parent = Part2;
    local Part3 = Instance.new("Part");
    Part3.Name = "Front";

    for i, v in {
        Size = Vector3.new(0.2, 0.2, 0.2),
        Transparency = 1
    } or {} do
        Part3[i] = v;
    end;

    Part3.Parent = Model;
    Part3.Anchored = true;
    Part3.CanCollide = false;
    Part3.CanQuery = false;
    Part3.CanTouch = false;
    Part3.CastShadow = false;
    local v213 = {
        Brightness = 1.6,
        Angle = 40,
        Shadows = false,
        Color = Color3.fromRGB(255, 246, 232),
        Face = Enum.NormalId.Front
    };
    local SpotLight = Instance.new("SpotLight");
    SpotLight.Name = "Key";

    for i, v in v213 or {} do
        SpotLight[i] = v;
    end;

    SpotLight.Parent = Part3;

    if p203.lights == false then
        PointLight.Enabled = false;
        SpotLight.Enabled = false;
    end;

    result.rays = Part;
    result.board = BillboardGui;
    result.ring1 = ImageLabel;
    result.ring2 = ImageLabel2;
    result.glow = Part2;
    result.light = PointLight;
    result.front = Part3;
    result.key = SpotLight;
    p203.prize = result;
    p203:running();
    pcall(p203.step, p203, 0);
end;

function u1.fade(p214, p215) -- Line: 1176
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p215, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local u216 = {};
    local u217 = {};

    local function out(p218, p219) -- Line: 1179
        -- upvalues: u216 (copy), TweenService (ref), TweenInfo_new_ret (copy), u217 (copy)
        local v220 = {};

        for _, v in p219 do
            table.insert(u216, { p218, v, p218[v] });
            v220[v] = v == "Brightness" and 0 or 1;
        end;

        local v221 = TweenService:Create(p218, TweenInfo_new_ret, v220);
        table.insert(u217, v221);
        v221:Play();
    end;

    local function one(p222) -- Line: 1189
        -- upvalues: out (copy), u216 (copy)
        if p222:IsA("TextLabel") or (p222:IsA("TextButton") or p222:IsA("TextBox")) then
            out(p222, { "TextTransparency", "TextStrokeTransparency", "BackgroundTransparency" });

            return;
        end;

        if p222:IsA("ImageLabel") or (p222:IsA("ImageButton") or p222:IsA("ViewportFrame")) then
            out(p222, { "ImageTransparency", "BackgroundTransparency" });

            return;
        end;

        if p222:IsA("ScrollingFrame") then
            out(p222, { "ScrollBarImageTransparency", "BackgroundTransparency" });

            return;
        end;

        if p222:IsA("GuiObject") then
            out(p222, { "BackgroundTransparency" });

            return;
        end;

        if p222:IsA("UIStroke") then
            out(p222, { "Transparency" });

            return;
        end;

        if p222:IsA("BasePart") then
            out(p222, { "LocalTransparencyModifier" });

            return;
        end;

        if p222:IsA("Light") then
            out(p222, { "Brightness" });

            return;
        end;

        if p222:IsA("ParticleEmitter") then
            table.insert(u216, { p222, "Enabled", p222.Enabled });
            p222.Enabled = false;
        end;
    end;

    one(p214);

    for _, descendant in p214:GetDescendants() do
        one(descendant);
    end;

    return function() -- Line: 1213
        -- upvalues: u217 (copy), u216 (copy)
        for _, v in u217 do
            v:Cancel();
        end;

        for _, v in u216 do
            pcall(function() -- Line: 1218
                -- upvalues: v (copy)
                v[1][v[2]] = v[3];
            end);
        end;
    end;
end;

function u1.fadeAway(u223, p224) -- Line: 1226
    -- upvalues: u1 (copy)
    if u223.pumpkin then
        u223.pumpkin.fading = true;
    end;

    local token = u223.token;

    if u223.holder then
        u1.fade(u223.holder, p224);
    end;

    task.delay(p224, function() -- Line: 1234
        -- upvalues: u223 (copy), token (copy)
        if u223.token == token then
            u223:dismiss(true);
        end;
    end);
end;

function u1.clearReward(p225) -- Line: 1241
    -- upvalues: gone (copy)
    local prize = p225.prize;
    p225.prize = nil;
    gone(p225, prize, false);
    p225:stopIfIdle();
end;

return u1;