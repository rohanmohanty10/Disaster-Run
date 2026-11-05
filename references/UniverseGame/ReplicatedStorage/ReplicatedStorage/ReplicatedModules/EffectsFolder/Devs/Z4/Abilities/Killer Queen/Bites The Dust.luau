  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local u1 = Random.new();
Color3.fromRGB(150, 70, 220);
local u2 = {
    Color3.fromRGB(150, 70, 220),
    Color3.fromRGB(225, 70, 200),
    Color3.fromRGB(255, 200, 120),
    Color3.fromRGB(80, 140, 255),
    Color3.fromRGB(70, 220, 230),
    Color3.fromRGB(225, 70, 200)
};
local u3 = {
    [4] = { "rbxassetid://94471502822254", "rbxassetid://123291283898816", "rbxassetid://111769270277108" }
};
local u4 = {
    Default = 0.6,
    { 0, 0.6 },
    { 30, 1.1 },
    { 150, 1.4 },
    { 160, 2.3 },
    { 200, 1.3 },
    { 400, 1.9 },
    { 470, 2.5 },
    { 520, 0.8 },
    { 560, 0.5 }
};
local u5 = {
    Default = 0,
    { 0, 0.65 },
    { 30, -0.05 },
    { 150, 0.05 },
    { 157, 0.75 },
    { 175, -0.05 },
    { 300, 0.05 },
    { 400, -0.05 },
    { 467, 0.75 },
    { 485, 0 },
    { 520, 0 }
};
local u6 = {
    Default = 0.15,
    { 0, 0.15 },
    { 30, 0.35 },
    { 160, 0.55 },
    { 200, 0.4 },
    { 400, 0.5 },
    { 470, 0.65 },
    { 520, 0.15 }
};
local u7 = {
    Default = 1,
    { 0, 2.6 },
    { 30, 1 },
    { 150, 1.5 },
    { 157, 3.2 },
    { 175, 1.2 },
    { 400, 1.7 },
    { 467, 3.2 },
    { 485, 1.2 },
    { 520, 1 }
};
local u8 = {
    Default = 1,
    { 0, 0.55 },
    { 30, 1.1 },
    { 157, 0.5 },
    { 175, 1 },
    { 467, 0.5 },
    { 485, 1 }
};
local u9 = {
    Default = 24,
    { 0, 42 },
    { 30, 24 },
    { 157, 50 },
    { 175, 24 },
    { 467, 50 },
    { 485, 24 }
};
local u10 = {
    Default = 0,
    { 0, 18 },
    { 26, 0 },
    { 150, 0 },
    { 156, 14 },
    { 172, 0 },
    { 400, 0 },
    { 465, 13 },
    { 483, 0 },
    { 518, 0 },
    { 540, 16 },
    { 560, 0 }
};
local u11 = {
    Default = 0.4,
    { 0, 0.4 },
    { 160, 12 },
    { 400, 18 },
    { 500, 0.5 }
};

local function SmoothStep(p12) -- Line: 135
    local v13 = math.clamp(p12, 0, 1);

    return v13 * v13 * (3 - 2 * v13);
end;

local function Snapshot(u14, p15) -- Line: 140
    if not u14 then
        return function() -- Line: 141
        end;
    end;

    local u16 = {};

    for _, v in p15 do
        u16[v] = u14[v];
    end;

    return function() -- Line: 144
        -- upvalues: u14 (copy), u16 (copy)
        if not u14.Parent then
            return;
        end;

        for i, v in u16 do
            u14[i] = v;
        end;
    end;
end;

local function FxPart(p17) -- Line: 150
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;

    for i, v in p17 do
        Part[i] = v;
    end;

    return Part;
end;

return function(p18) -- Line: 162
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), Trove (copy), EffectsHandler (copy), AnimationHandler (copy), u3 (copy), LocalPlayer (copy), Lighting (copy), Snapshot (copy), u2 (copy), TweenService (copy), u4 (copy), u5 (copy), u6 (copy), u7 (copy), u8 (copy), u9 (copy), u10 (copy), u11 (copy), RunService (copy), u1 (copy), CurrentCamera (copy)
    local v19 = p18 or {};
    local u20 = v19.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = v19.Player or v19.AttackerPlayer,
        Character = v19.Character or v19.Attacker
    });
    local Character = v19.Character;
    local v21 = v19.CutsceneLength or 9.333333333333334;
    local _ = v19.SkinName;
    local u22 = AssetHandler.GetAbilityData(v19.Player);
    local u23 = Trove.new();
    u23:AttachToInstance(Character);
    task.delay(v21, u23.Destroy, u23);
    EffectsHandler.CallEffect("Q_PLAY_SOUND", Character:FindFirstChild("Bites The Dust Voiceline", true));
    EffectsHandler.CallEffect("Q_PLAY_SOUND", Character:FindFirstChild("Bites The Dust", true));

    local function CloneChar(p24) -- Line: 181
        -- upvalues: u23 (copy)
        p24.Archivable = true;
        local v25 = u23:Clone(p24);
        local v26 = {
            Fire = true,
            Sparkles = true,
            Smoke = true,
            ParticleEmitter = true,
            Sound = true,
            Trail = true,
            Beam = true,
            BillboardGui = true,
            LocalScript = true,
            Script = true
        };

        for _, descendant in v25:GetDescendants() do
            if v26[descendant.ClassName] then
                descendant:Destroy();
            end;
        end;

        local v27 = v25:FindFirstChildOfClass("Humanoid");

        if v27 then
            v27.BreakJointsOnDeath = false;
            v27.RequiresNeck = true;
            v27.AutomaticScalingEnabled = false;
            v27.EvaluateStateMachine = false;
            v27.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            v27.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
        end;

        for _, descendant in v25:GetDescendants() do
            if descendant:IsA("Motor6D") then
                descendant.Enabled = true;
            end;
        end;

        local HumanoidRootPart = v25:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            HumanoidRootPart.Anchored = true;
            v25.PrimaryPart = HumanoidRootPart;
        end;

        for _, descendant in v25:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CollisionGroup = "FX";
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.Massless = true;
            end;
        end;

        return v25;
    end;

    for _, child in game.Lighting:GetChildren() do
        if child:IsA("Atmosphere") then
            local Glare = child.Glare;
            local Haze = child.Haze;
            child.Glare = 0;
            child.Haze = 0;
            u23:Add(function() -- Line: 241
                -- upvalues: child (copy), Glare (copy), Haze (copy)
                child.Glare = Glare;
                child.Haze = Haze;
            end);
        end;

        if child:IsA("Sky") then
            child.Parent = nil;
            u23:Add(function() -- Line: 250
                -- upvalues: child (copy)
                task.defer(function() -- Line: 251
                    -- upvalues: child (ref)
                    child.Parent = game.Lighting;
                end);
            end);
        end;
    end;

    u23:Clone(AssetHandler.GetAsset("Particles/BTD/Sky", u22)).Parent = game.Lighting;
    local u28 = CloneChar(Character);
    u28.Parent = workspace.Effects;
    u28:PivotTo(CFrame.new(Character.HumanoidRootPart.Position + Vector3.new(5000, 1500, 5000)));
    (u28:FindFirstChild("Humanoid") or u28:FindFirstChildOfClass("AnimationController")).Animator:LoadAnimation((u23:Add(AnimationHandler.CreateAnimationByName(u22.AbilityName, u22.SkinName, "Bites The Dust Player")))):Play();
    local u29 = os.clock();
    local Position = u28.PrimaryPart.Position;
    local v30 = "BTDImpact_" .. tostring(os.clock());
    local v31 = {
        {
            300,
            {
                Time = 0.13333333333333333,
                Decals = u3[4]
            }
        }
    };
    local u32 = false;

    for _, v in { true, false } do
        EffectsHandler.CallEffect("Sequential Impact Frames", {
            BypassSettings = true,
            Preload = v,
            Identifier = v30,
            Character = Character,
            Players = { LocalPlayer },
            Speed = not v and 1 or nil,
            Frames = v31
        });
    end;

    local function IsAlive() -- Line: 290
        -- upvalues: Character (copy), u28 (copy)
        return Character.Parent and u28.Parent;
    end;

    local function Tinted(p33) -- Line: 294
        -- upvalues: ParticleHandler (ref), u20 (copy)
        return ParticleHandler.TryHSVShift(p33, u20);
    end;

    local DefaultBloom = Lighting:FindFirstChild("DefaultBloom");
    local DefaultBlur = Lighting:FindFirstChild("DefaultBlur");
    local u34 = DefaultBloom and (Snapshot(DefaultBloom, { "Threshold", "Intensity", "Size" }) or function() -- Line: 302
    end) or function() -- Line: 302
    end;
    local u35 = DefaultBlur and (Snapshot(DefaultBlur, { "Size" }) or function() -- Line: 303
    end) or function() -- Line: 303
    end;
    u23:Add(function() -- Line: 305
        -- upvalues: u34 (copy), u35 (copy)
        u34();
        u35();
    end);
    local u36 = u23:Add(Instance.new("ColorCorrectionEffect"));
    u36.Name = "BTD_CC";
    u36.Enabled = true;
    u36.Parent = Lighting;
    local u37 = u23:Add(Instance.new("DepthOfFieldEffect"));
    u37.Name = "BTD_CinematicDOF";
    u37.FarIntensity = 0.4;
    u37.FocusDistance = 1;
    u37.InFocusRadius = 60;
    u37.NearIntensity = 0;
    u37.Parent = Lighting;
    local v38 = {
        Default = Color3.new(1, 1, 1),
        { 0, Color3.new(1, 1, 1) },
        { 30, Tinted(u2[1]) },
        { 150, Tinted(u2[1]) },
        { 157, Tinted(u2[3]) },
        { 180, Tinted(u2[3]) },
        { 200, Tinted(u2[1]) },
        { 260, Tinted(u2[1]) },
        { 280, Tinted(u2[2]) },
        { 330, Tinted(u2[2]) },
        { 345, Tinted(u2[4]) },
        { 390, Tinted(u2[4]) },
        { 405, Tinted(u2[5]) },
        { 450, Tinted(u2[5]) },
        { 465, Tinted(u2[2]) },
        { 500, Tinted(u2[2]) },
        { 520, Color3.new(1, 1, 1) }
    };
    local u39 = {};
    local u40 = 0;

    local function PrepareKeyframes(p41) -- Line: 343
        local v42 = {};
        local v43 = nil;

        for i, v in pairs(p41) do
            if type(i) == "number" then
                v42[#v42 + 1] = v;
            elseif i == "Default" then
                v43 = v;
            end;
        end;

        table.sort(v42, function(p44, p45) -- Line: 349
            return p44[1] < p45[1];
        end);

        return v42, v43;
    end;

    local function SampleKeyframes(p46, p47) -- Line: 353
        -- upvalues: TweenService (ref)
        local Sorted = p46.Sorted;
        local v48 = #p46.Sorted;

        if v48 == 0 then
            return p46.Default;
        end;

        local LastIdx = p46.LastIdx;

        while LastIdx < v48 and Sorted[LastIdx + 1][1] <= p47 do
            LastIdx = LastIdx + 1;
        end;

        p46.LastIdx = LastIdx;

        if LastIdx == 0 then
            return Sorted[1][2];
        end;

        if v48 <= LastIdx then
            return Sorted[v48][2];
        end;

        local v49 = Sorted[LastIdx];
        local v50 = Sorted[LastIdx + 1];
        local v51 = v49[2];
        local v52 = v50[2];
        local v53 = v50[3];
        local v54 = v50[4];

        if v53 == "Constant" or v50[1] == v49[1] then
            return v51;
        end;

        local v55 = TweenService:GetValue(math.clamp((p47 - v49[1]) / (v50[1] - v49[1]), 0, 1), v53 and Enum.EasingStyle[v53] or Enum.EasingStyle.Sine, v54 and Enum.EasingDirection[v54] or Enum.EasingDirection.Out);

        if typeof(v51) == "Color3" then
            return v51:Lerp(v52, v55);
        end;

        return v51 + (v52 - v51) * v55;
    end;

    local function RegisterKeyframeUpdate(p56, p57, p58) -- Line: 380
        -- upvalues: PrepareKeyframes (copy), SampleKeyframes (copy), u40 (ref), u39 (copy)
        if not (p56 and p56.Parent) then
            return;
        end;

        local v59, v60 = PrepareKeyframes(p58);
        local v61 = {
            LastIdx = 0,
            LastValue = nil,
            Instance = p56,
            Property = p57,
            Sorted = v59,
            Default = v60
        };
        local v62 = SampleKeyframes(v61, 0);

        if v62 ~= nil then
            p56[p57] = v62;
            v61.LastValue = v62;
        end;

        u40 = u40 + 1;
        u39[u40] = v61;
    end;

    RegisterKeyframeUpdate(u36, "Saturation", u4);
    RegisterKeyframeUpdate(u36, "Brightness", u5);
    RegisterKeyframeUpdate(u36, "Contrast", u6);
    RegisterKeyframeUpdate(u36, "TintColor", v38);

    if DefaultBloom then
        RegisterKeyframeUpdate(DefaultBloom, "Intensity", u7);
        RegisterKeyframeUpdate(DefaultBloom, "Threshold", u8);
        RegisterKeyframeUpdate(DefaultBloom, "Size", u9);
    end;

    if DefaultBlur then
        RegisterKeyframeUpdate(DefaultBlur, "Size", u10);
    end;

    RegisterKeyframeUpdate(u37, "FarIntensity", u11);
    u23:Connect(RunService.RenderStepped, function() -- Line: 413
        -- upvalues: u32 (ref), u29 (copy), u40 (ref), u39 (copy), SampleKeyframes (copy)
        if u32 then
            return;
        end;

        local v63 = (os.clock() - u29) * 60;

        for i = 1, u40 do
            local v64 = u39[i];
            local Instance2 = v64.Instance;

            if Instance2 and Instance2.Parent then
                local v65 = SampleKeyframes(v64, v63);

                if v65 ~= nil and v65 ~= v64.LastValue then
                    Instance2[v64.Property] = v65;
                    v64.LastValue = v65;
                end;
            end;
        end;
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u66;

    if PlayerGui then
        local v67 = u23:Add(Instance.new("ScreenGui"));
        v67.Name = "BTD_Flash";
        v67.IgnoreGuiInset = true;
        v67.ResetOnSpawn = false;
        v67.DisplayOrder = 1000;
        v67.Parent = PlayerGui;
        u66 = Instance.new("Frame");
        u66.Size = UDim2.fromScale(1, 1);
        u66.BackgroundColor3 = Color3.new(1, 1, 1);
        u66.BackgroundTransparency = 0;
        u66.BorderSizePixel = 0;
        u66.Parent = v67;
    else
        u66 = nil;
    end;

    local function Flash(p68) -- Line: 449
        -- upvalues: u66 (ref), TweenService (ref)
        if not (u66 and u66.Parent) then
            return;
        end;

        u66.BackgroundTransparency = 0;
        TweenService:Create(u66, TweenInfo.new(p68 or 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;

    if PlayerGui then
        local u69 = u23:Add(Instance.new("ScreenGui"));
        u69.Name = "BTD_Letterbox";
        u69.IgnoreGuiInset = true;
        u69.ResetOnSpawn = false;
        u69.DisplayOrder = 998;
        u69.Parent = PlayerGui;

        local function MakeBar(p70) -- Line: 464
            -- upvalues: u69 (copy)
            local Frame = Instance.new("Frame");
            Frame.AnchorPoint = Vector2.new(0.5, p70);
            Frame.Position = UDim2.fromScale(0.5, p70);
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.BackgroundColor3 = Color3.new(0, 0, 0);
            Frame.BorderSizePixel = 0;
            Frame.Parent = u69;

            return Frame;
        end;

        local u71 = MakeBar(0);
        local u72 = MakeBar(1);
        local v73 = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        TweenService:Create(u71, v73, {
            Size = UDim2.fromScale(1, 0.11)
        }):Play();
        TweenService:Create(u72, v73, {
            Size = UDim2.fromScale(1, 0.11)
        }):Play();
        u23:Add(function() -- Line: 482
            -- upvalues: u69 (copy), TweenService (ref), u71 (copy), u72 (copy)
            if not (u69 and u69.Parent) then
                return;
            end;

            local v74 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            TweenService:Create(u71, v74, {
                Size = UDim2.fromScale(1, 0)
            }):Play();
            TweenService:Create(u72, v74, {
                Size = UDim2.fromScale(1, 0)
            }):Play();
        end);
    end;

    local v75 = Color3.fromRGB(185, 125, 255);
    local u76 = ParticleHandler.TryHSVShift(v75, u20);
    local u77 = u23:Add(Instance.new("Folder"));
    u77.Name = "BTD_Trails";
    u77.Parent = workspace.Effects;
    local u78 = {};

    for _, v in { "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Head" } do
        local v79 = u28:FindFirstChild(v);

        if v79 then
            u78[#u78 + 1] = {
                Part = v79,
                Last = v79.Position
            };
        end;
    end;

    local v80 = u23:Add(Instance.new("Folder"));
    v80.Name = "BTD_Stars";
    v80.Parent = workspace.Effects;
    local u81 = table.create(70);

    for i = 1, 70 do
        local v82 = Color3.fromHSV(u1:NextNumber(0.55, 0.85), u1:NextNumber(0.1, 0.4), 1);
        local v83 = {
            Transparency = 1,
            Shape = Enum.PartType.Ball,
            Size = Vector3.new(1, 1, 1) * u1:NextNumber(0.6, 2.4),
            Material = Enum.Material.Neon,
            Color = v82
        };
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;

        for i2, v in v83 do
            Part[i2] = v;
        end;

        local v84 = u1:NextNumber(0, 6.283185307179586);
        local v85 = u1:NextNumber(-0.8, 0.8);
        local v86 = math.cos(v84) * math.cos(v85);
        local v87 = math.sin(v85);
        local v88 = math.sin(v84) * math.cos(v85);
        Part.Position = Position + Vector3.new(v86, v87, v88) * u1:NextNumber(180, 520);
        Part.Parent = v80;
        local BillboardGui = Instance.new("BillboardGui");
        BillboardGui.Adornee = Part;
        BillboardGui.Size = UDim2.fromScale(u1:NextNumber(7, 16), u1:NextNumber(7, 16));
        BillboardGui.LightInfluence = 0;
        BillboardGui.Parent = Part;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Size = UDim2.fromScale(1, 1);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxasset://textures/particles/sparkles_main.dds";
        ImageLabel.ImageColor3 = v82;
        ImageLabel.ImageTransparency = 1;
        ImageLabel.Parent = BillboardGui;
        u81[i] = {
            Part = Part,
            Halo = ImageLabel,
            BaseColor = v82,
            Phase = u1:NextNumber(0, 6.283185307179586),
            Speed = u1:NextNumber(2, 5)
        };
    end;

    local v89 = u23:Add(Instance.new("Folder"));
    v89.Name = "BTD_Streaks";
    v89.Parent = workspace.Effects;
    local u90 = table.create(36);

    for i = 1, 36 do
        local v91 = u1:NextNumber(10, 30);
        local v92 = {
            Transparency = 1,
            Size = Vector3.new(0.3, 0.3, v91),
            Material = Enum.Material.Neon,
            Color = Color3.fromHSV(u1:NextNumber(0.55, 0.8), u1:NextNumber(0.2, 0.5), 1)
        };
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;

        for i2, v in v92 do
            Part[i2] = v;
        end;

        Part.Parent = v89;
        u90[i] = {
            Part = Part,
            Lateral = Vector2.new(u1:NextNumber(-32, 32), u1:NextNumber(-22, 22)),
            Forward = u1:NextNumber(20, 220),
            BaseT = u1:NextNumber(0.15, 0.5),
            Length = v91
        };
    end;

    local u93 = os.clock();
    u23:Connect(RunService.RenderStepped, function(p94) -- Line: 574
        -- upvalues: Character (copy), u28 (copy), u29 (copy), u81 (copy), u32 (ref), CurrentCamera (ref), u90 (copy), u1 (ref), u78 (copy), u76 (copy), u77 (copy), TweenService (ref), u93 (ref), EffectsHandler (ref)
        if not (Character.Parent and u28.Parent) then
            return;
        end;

        local v95 = os.clock();
        local v96 = v95 - u29;
        local v97 = v96 * 60;
        local v98 = math.clamp((v97 - 20) / 60, 0, 1) * (1 - math.clamp((v97 - 510) / 50, 0, 1));

        for _, v in u81 do
            if v.Part and v.Part.Parent then
                local v99 = (math.sin(v96 * v.Speed + v.Phase) + 1) * 0.5;
                v.Part.Transparency = 1 - v98 * (v99 * 0.55 + 0.45);

                if v.Halo and v.Halo.Parent then
                    v.Halo.ImageTransparency = 1 - v98 * math.lerp(0.35, 0.85, v99);
                end;
            end;
        end;

        local v100 = u32 and 0 or (math.clamp((v97 - 150) / 50, 0, 1) * (1 - math.clamp((v97 - 500) / 60, 0, 1)) or 0);
        local v101 = (math.clamp((v97 - 150) / 250, 0, 1) * 520 + 60) * p94;
        local CFrame2 = CurrentCamera.CFrame;
        local Position2 = CFrame2.Position;
        local LookVector = CFrame2.LookVector;
        local RightVector = CFrame2.RightVector;
        local UpVector = CFrame2.UpVector;

        for _, v in u90 do
            if v.Part and v.Part.Parent then
                if u32 then
                    v.Part.Transparency = 1;
                else
                    v.Forward = v.Forward - v101;

                    if v.Forward < 5 then
                        v.Forward = u1:NextNumber(140, 240);
                        v.Lateral = Vector2.new(u1:NextNumber(-32, 32), u1:NextNumber(-22, 22));
                    end;

                    local v102 = Position2 + LookVector * v.Forward + RightVector * v.Lateral.X + UpVector * v.Lateral.Y;
                    v.Part.CFrame = CFrame.lookAt(v102, v102 + LookVector);
                    v.Part.Transparency = 1 - v100 * (1 - v.BaseT);
                end;
            end;
        end;

        local v103 = math.clamp((v97 - 10) / 40, 0, 1) * (1 - math.clamp((v97 - 510) / 45, 0, 1));

        if v103 > 0 then
            for _, v in u78 do
                if v.Part and v.Part.Parent then
                    local Position3 = v.Part.Position;
                    local Magnitude = (Position3 - v.Last).Magnitude;

                    if Magnitude >= 0.8 then
                        local v104 = u1:NextNumber(0.45, 0.85);
                        local v105 = {
                            Size = Vector3.new(v104, v104, Magnitude),
                            Material = Enum.Material.Neon,
                            Color = u76,
                            CFrame = CFrame.lookAt((Position3 + v.Last) * 0.5, Position3),
                            Transparency = math.clamp(1 - v103 * 0.85, 0.15, 1)
                        };
                        local Part = Instance.new("Part");
                        Part.Anchored = true;
                        Part.CanCollide = false;
                        Part.CanQuery = false;
                        Part.CanTouch = false;
                        Part.CastShadow = false;

                        for i, v2 in v105 do
                            Part[i] = v2;
                        end;

                        Part.Parent = u77;
                        TweenService:Create(Part, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Transparency = 1,
                            Size = Vector3.new(0, 0, Magnitude)
                        }):Play();
                        task.delay(0.45, Part.Destroy, Part);
                        v.Last = Position3;
                    end;
                end;
            end;
        end;

        if not u32 and (v97 <= 200 and v95 - u93 >= 0.037) then
            u93 = v95;
            local v106 = u28:FindFirstChild("Torso") or u28:FindFirstChild("UpperTorso");

            if v106 then
                local v107 = Vector3.new(1, 1, 1) * u1:NextNumber(3, 8);
                local CallEffect = EffectsHandler.CallEffect;
                local v108 = {};
                local new = CFrame.new;
                local Position3 = v106.Position;
                local v109 = u1:NextNumber(-7, 7);
                local v110 = u1:NextNumber(-5, 5);
                v108.Origin = new(Position3 + Vector3.new(v109, v110, u1:NextNumber(-7, 7)));
                v108.StartSize = v107;
                v108.EndSize = v107 * u1:NextNumber(2, 3.5);
                v108.Transparency = u1:NextNumber(3, 7);
                v108.Time = u1:NextNumber(0.16, 0.3);
                CallEffect("Bubble Distortion", v108);
            end;
        end;
    end);

    local function RunAcidTrip(p111, p112) -- Line: 659
        -- upvalues: u32 (ref), u23 (copy), u29 (copy), u39 (copy), u37 (copy), DefaultBloom (copy), Snapshot (ref), u36 (copy), Lighting (ref), Position (copy), u2 (ref), ParticleHandler (ref), u20 (copy), Tinted (copy), AssetHandler (ref), u22 (copy), u1 (ref), Flash (copy), RunService (ref), Character (copy), u28 (copy), EffectsHandler (ref), CurrentCamera (ref)
        if u32 then
            return;
        end;

        u32 = true;
        local u113 = u23:Extend();
        local u114 = (p112 - p111) / 60;
        local u115 = u29 + p111 / 60;
        local u116 = false;

        for _, v in u39 do
            v.LastValue = nil;
        end;

        if u37 and u37.Parent then
            u37.Enabled = false;
        end;

        local u117 = DefaultBloom and Snapshot(DefaultBloom, { "Threshold", "Intensity", "Size" }) or function() -- Line: 671
        end;
        local u118 = Snapshot(u36, { "Brightness", "Contrast", "Saturation", "TintColor" });
        local Atmosphere = Lighting:FindFirstChild("Atmosphere");

        if Atmosphere then
            local v119 = Snapshot(Atmosphere, { "Glare", "Haze" });
            Atmosphere.Glare = 0;
            Atmosphere.Haze = 0;
            u113:Add(v119);
        end;

        local v120 = u113:Add(Instance.new("Folder"));
        v120.Name = "BTD_Acid";
        v120.Parent = workspace.Effects;
        CFrame.new(Position + Vector3.new(0, 4000, 0));

        local function CalcFOV(p121) -- Line: 690
            local v122 = math.clamp(p121, 0, 1);

            if v122 < 0.12 then
                local v123 = math.clamp(v122 / 0.12, 0, 1);

                return math.lerp(70, 120, v123 * v123 * (3 - 2 * v123));
            end;

            if v122 < 0.45 then
                local v124 = math.clamp((v122 - 0.12) / 0.33, 0, 1);

                return math.lerp(120, 15, v124 * v124 * (3 - 2 * v124));
            end;

            local v125 = math.clamp((v122 - 0.45) / 0.55, 0, 1);

            return math.lerp(15, 70, v125 * v125 * (3 - 2 * v125));
        end;

        local function CalcLightPulse(p126) -- Line: 701
            local v127 = math.clamp(p126, 0, 1);

            if v127 < 0.12 then
                local v128 = math.clamp(v127 / 0.12, 0, 1);

                return v128 * v128 * (3 - 2 * v128);
            end;

            if v127 < 0.45 then
                local v129 = math.clamp((v127 - 0.12) / 0.33, 0, 1);

                return 1 - v129 * v129 * (3 - 2 * v129) * 0.65;
            end;

            local v130 = math.clamp((v127 - 0.45) / 0.55, 0, 1);

            return (1 - v130 * v130 * (3 - 2 * v130)) * 0.35;
        end;

        local v131 = { ParticleHandler.TryHSVShift(u2[1], u20), ParticleHandler.TryHSVShift(u2[2], u20), Tinted(u2[4]) };
        local u132 = table.create(3);

        for i = 1, 3 do
            local v133 = AssetHandler.GetAsset("Particles/BTD/EnterStage" .. i, u22);

            if v133 then
                local Start = v133:FindFirstChild("Start");
                local End = v133:FindFirstChild("End");

                if Start and End then
                    local v134 = Start.CFrame:ToObjectSpace(End.CFrame);
                    local v135 = v131[i] or ParticleHandler.TryHSVShift(u2[1], u20);
                    local v136 = table.create(10);

                    for i2 = 1, 10 do
                        local v137 = u113:Clone(v133);
                        ParticleHandler.Unusualify(v137, {
                            HSVData = u20
                        });
                        ParticleHandler.EnableAllParticles(v137, false);
                        v137.Parent = v120;
                        local v138 = {};

                        for _, descendant in v137:GetDescendants() do
                            if descendant:IsA("BasePart") then
                                descendant.Anchored = true;
                                descendant.CanCollide = false;
                                descendant.CanQuery = false;
                                descendant.CanTouch = false;
                                descendant.CastShadow = false;
                                descendant.Transparency = 1;
                            elseif descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) then
                                v138[#v138 + 1] = descendant;
                                descendant.Color = ColorSequence.new(v135);

                                if descendant:IsA("ParticleEmitter") then
                                    descendant.Rate = descendant.Rate * 0.4;
                                elseif descendant:IsA("Beam") then
                                    descendant.LightInfluence = 1;

                                    if descendant.Brightness > 1 then
                                        descendant.Brightness = 1;
                                    end;
                                end;
                            end;
                        end;

                        local Start2 = v137:FindFirstChild("Start");
                        local End2 = v137:FindFirstChild("End");

                        if Start2 and End2 then
                            v136[i2] = {
                                Start = Start2,
                                End = End2,
                                Model = v137,
                                Colorables = v138,
                                Z = i2 * 45,
                                Spin = (i2 - 1) * 0.6283185307179586
                            };
                        end;
                    end;

                    u132[i] = {
                        Active = false,
                        Dissipated = false,
                        LastHueBucket = -2,
                        RelCF = v134,
                        Tint = v135,
                        Segments = v136
                    };
                end;
            end;
        end;

        local u139 = table.create(20);

        for i = 1, 20 do
            local v140 = u1:NextInteger(18, 45);
            local v141 = {
                Size = Vector3.new(0.4, 0.4, v140),
                Material = Enum.Material.Neon,
                Color = ParticleHandler.TryHSVShift(u2[1], u20),
                Transparency = u1:NextNumber(0.15, 0.4)
            };
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;

            for i2, v in v141 do
                Part[i2] = v;
            end;

            Part.Parent = v120;
            u139[i] = {
                Part = Part,
                Angle = u1:NextNumber(0, 6.283185307179586),
                Radius = u1:NextNumber(12, 60),
                Z = u1:NextNumber(0, 700),
                SpeedMul = u1:NextNumber(0.8, 1.3),
                BaseT = Part.Transparency,
                Length = v140
            };
        end;

        local function SpinSpeed() -- Line: 785
            -- upvalues: u1 (ref)
            return 3.839724354387525 * u1:NextNumber(0.4, 1.4) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
        end;

        local u142 = table.create(18);

        for i = 1, 18 do
            local v143 = u1:NextNumber(1, 2.5);
            local v144 = u1:NextInteger(1, 3);
            local v145 = {
                Material = Enum.Material.Neon,
                Color = ParticleHandler.TryHSVShift(u2[2], u20),
                Transparency = u1:NextNumber(0.15, 0.4)
            };
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;

            for i2, v in v145 do
                Part[i2] = v;
            end;

            if v144 == 1 then
                Part.Shape = Enum.PartType.Ball;
                Part.Size = Vector3.new(v143, v143, v143);
            elseif v144 == 2 then
                Part.Size = Vector3.new(v143, v143, v143);
            else
                Part.Size = Vector3.new(v143 * 0.5, v143 * 0.5, v143 * 1.8);
            end;

            Part.Parent = v120;
            local v146 = {
                Part = Part,
                Angle = u1:NextNumber(0, 6.283185307179586),
                Radius = u1:NextNumber(8, 60),
                Z = u1:NextNumber(20, 320),
                SpeedMul = u1:NextNumber(0.7, 1.3),
                BaseT = Part.Transparency,
                Phase = u1:NextNumber(0, 6.283185307179586)
            };
            local v147 = u1:NextNumber(0, 6.283185307179586);
            local v148 = u1:NextNumber(0, 6.283185307179586);
            v146.Spin = Vector3.new(v147, v148, u1:NextNumber(0, 6.283185307179586));
            local v149 = 3.839724354387525 * u1:NextNumber(0.4, 1.4) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
            local v150 = 3.839724354387525 * u1:NextNumber(0.4, 1.4) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
            local v151 = 3.839724354387525 * u1:NextNumber(0.4, 1.4);
            local v152 = u1:NextInteger(0, 1) == 0 and -1 or 1;
            v146.SpinSpeed = Vector3.new(v149, v150, v151 * v152);
            u142[i] = v146;
        end;

        local function SetStageActive(p153, p154) -- Line: 812
            -- upvalues: ParticleHandler (ref)
            if not p153 or p153.Active == p154 then
                return;
            end;

            p153.Active = p154;

            for _, v in p153.Segments do
                if v and (v.Model and v.Model.Parent) then
                    ParticleHandler.EnableAllParticles(v.Model, p154);
                end;
            end;
        end;

        local function Release() -- Line: 820
            -- upvalues: u32 (ref), u39 (ref), u37 (ref), u117 (copy), u118 (copy)
            u32 = false;

            for _, v in u39 do
                v.LastValue = nil;
            end;

            if u37 and u37.Parent then
                u37.Enabled = true;
            end;

            u117();
            u118();
        end;

        local function Finish() -- Line: 828
            -- upvalues: u116 (ref), Flash (ref), u32 (ref), u39 (ref), u37 (ref), u117 (copy), u118 (copy), u113 (copy)
            if u116 then
                return;
            end;

            u116 = true;
            Flash(0.45);
            u32 = false;

            for _, v in u39 do
                v.LastValue = nil;
            end;

            if u37 and u37.Parent then
                u37.Enabled = true;
            end;

            u117();
            u118();
            u113:Destroy();
        end;

        u113:Add(function() -- Line: 836
            -- upvalues: u32 (ref), u37 (ref)
            u32 = false;

            if u37 and u37.Parent then
                u37.Enabled = true;
            end;
        end);
        local u155 = 0;
        u113:Connect(RunService.RenderStepped, function(p156) -- Line: 843
            -- upvalues: Character (ref), u28 (ref), u116 (ref), Flash (ref), u32 (ref), u39 (ref), u37 (ref), u117 (copy), u118 (copy), u113 (copy), u115 (copy), u114 (copy), u155 (ref), SetStageActive (copy), u132 (copy), EffectsHandler (ref), CurrentCamera (ref), u139 (copy), u1 (ref), u142 (copy), DefaultBloom (ref), u36 (ref)
            if not (Character.Parent and u28.Parent) then
                if u116 then
                    return;
                end;

                u116 = true;
                Flash(0.45);
                u32 = false;

                for _, v in u39 do
                    v.LastValue = nil;
                end;

                if u37 and u37.Parent then
                    u37.Enabled = true;
                end;

                u117();
                u118();
                u113:Destroy();

                return;
            end;

            local v157 = os.clock() - u115;
            local v158 = math.clamp(v157 / u114, 0, 1);
            u155 = u155 + p156 * 0.25;

            if u114 <= v157 then
                if u116 then
                    return;
                end;

                u116 = true;
                Flash(0.45);
                u32 = false;

                for _, v in u39 do
                    v.LastValue = nil;
                end;

                if u37 and u37.Parent then
                    u37.Enabled = true;
                end;

                u117();
                u118();
                u113:Destroy();

                return;
            end;

            local v159 = math.floor(v158 * 3) + 1;
            local v160 = math.min(v159, 3);
            local v161 = v158 * 3 - (v160 - 1);
            local v162 = v158 >= 0.5 and ((v157 - 0.5 * u114) % 1 or 0) or 0;
            local v163;

            if v160 == 3 and v161 >= 0.72 then
                local v164 = math.clamp((v161 - 0.72) / 0.28, 0, 1);
                v163 = v164 * v164 * (3 - 2 * v164) or 0;
            else
                v163 = 0;
            end;

            SetStageActive(u132[1], v160 == 1);
            SetStageActive(u132[2], v160 == 2);
            SetStageActive(u132[3], v160 == 3);
            local v165 = u132[v160];

            if not v165 then
                return;
            end;

            local Tint = v165.Tint;

            if v162 > 0 then
                local v166, v167, v168 = v165.Tint:ToHSV();
                Tint = Color3.fromHSV((v166 + v162) % 1, v167, v168);
            end;

            if v162 > 0 and v163 <= 0 then
                local v169 = math.floor(v162 * 90);

                if v169 ~= v165.LastHueBucket then
                    v165.LastHueBucket = v169;
                    local v170 = ColorSequence.new(Tint);

                    for _, v in v165.Segments do
                        for _, v2 in v.Colorables do
                            if v2 and v2.Parent then
                                v2.Color = v170;
                            end;
                        end;
                    end;
                end;
            end;

            if v163 > 0 and not v165.Dissipated then
                v165.Dissipated = true;

                for _, v in v165.Segments do
                    if v and (v.Model and v.Model.Parent) then
                        EffectsHandler.CallEffect("FadeBeams", v.Model, {
                            Time = 0.35
                        });
                    end;
                end;
            end;

            local v171 = 1 + v163 * 1.8;
            local CFrame2 = CurrentCamera.CFrame;
            local Position2 = CFrame2.Position;
            local LookVector = CFrame2.LookVector;
            local RightVector = CFrame2.RightVector;
            local UpVector = CFrame2.UpVector;
            local v172 = 140 * v171 * p156;

            for _, v in v165.Segments do
                if v and (v.Start and (v.Start.Parent and (v.End and v.End.Parent))) then
                    local v173 = v.Z - v172;

                    if v173 < -30 and v163 <= 0 then
                        v173 = v173 + 450;
                    end;

                    v.Z = v173;
                    local v174 = Position2 + LookVector * v173;
                    local v175 = CFrame.lookAt(v174, v174 + LookVector) * CFrame.Angles(0, 0, v.Spin);
                    v.Start.CFrame = v175;
                    v.End.CFrame = v175 * v165.RelCF;
                end;
            end;

            for _, v in u139 do
                if v.Part and v.Part.Parent then
                    v.Z = v.Z - 224 * v.SpeedMul * v171 * p156;

                    if v.Z < -v.Length and v163 <= 0 then
                        v.Z = 700 + u1:NextNumber(0, 100);
                        v.Angle = u1:NextNumber(0, 6.283185307179586);
                        v.Radius = u1:NextNumber(12, 60);
                    end;

                    local v176 = Vector2.new(math.cos(v.Angle), (math.sin(v.Angle))) * v.Radius;
                    local v177 = Position2 + LookVector * v.Z + RightVector * v176.X + UpVector * v176.Y;
                    v.Part.CFrame = CFrame.lookAt(v177, v177 + LookVector);
                    v.Part.Color = Tint;
                    v.Part.Transparency = math.clamp(v.BaseT + v163, 0, 1);
                end;
            end;

            for _, v in u142 do
                if v.Part and v.Part.Parent then
                    v.Z = v.Z - 280 * v.SpeedMul * v171 * p156;

                    if v.Z < -10 and v163 <= 0 then
                        v.Z = 320 + u1:NextNumber(0, 80);
                        v.Angle = u1:NextNumber(0, 6.283185307179586);
                        v.Radius = u1:NextNumber(8, 60);
                        v.Phase = u1:NextNumber(0, 6.283185307179586);
                    end;

                    v.Spin = v.Spin + v.SpinSpeed * p156;
                    local v178 = math.cos(v.Angle) * v.Radius + math.sin(v157 * 8 + v.Z * 0.04 + v.Phase) * 5;
                    local v179 = math.sin(v.Angle) * v.Radius + math.cos(v157 * 7 + v.Z * 0.03 + v.Phase) * 5;
                    v.Part.CFrame = CFrame.lookAt(Position2 + LookVector * v.Z + RightVector * v178 + UpVector * v179, Position2) * CFrame.Angles(v.Spin.X, v.Spin.Y, v.Spin.Z);
                    v.Part.Color = Tint;
                    local v180 = v.Z < 35 and (math.max(0, (1 - v.Z / 35) * 0.55) or 0) or 0;
                    v.Part.Transparency = math.clamp(v.BaseT + v180 + v163, 0, 1);
                end;
            end;

            local v181 = math.clamp(v158, 0, 1);
            local v182;

            if v181 < 0.12 then
                local v183 = math.clamp(v181 / 0.12, 0, 1);
                v182 = v183 * v183 * (3 - 2 * v183);
            elseif v181 < 0.45 then
                local v184 = math.clamp((v181 - 0.12) / 0.33, 0, 1);
                v182 = 1 - v184 * v184 * (3 - 2 * v184) * 0.65;
            else
                local v185 = math.clamp((v181 - 0.45) / 0.55, 0, 1);
                v182 = (1 - v185 * v185 * (3 - 2 * v185)) * 0.35;
            end;

            local v186 = math.max(0.1, v182);
            local v187 = math.clamp(v158 / 0.18, 0, 1);
            local v188 = math.clamp(v187, 0, 1);
            local v189 = 1 - v188 * v188 * (3 - 2 * v188);

            if DefaultBloom and DefaultBloom.Parent then
                DefaultBloom.Size = math.lerp(30, 46, v186);
                DefaultBloom.Threshold = math.lerp(0.95, 0.55, v186);
                DefaultBloom.Intensity = math.lerp(0.85, 2.4, v186) + v189 * 0.65;
            end;

            if u36 and u36.Parent then
                u36.Saturation = math.lerp(0.6, 1.6, v186);
                u36.Brightness = math.lerp(0.02, 0.14, v186) + v189 * 0.08;
                u36.TintColor = v162 > 0 and Color3.fromHSV(v162, 0.16, 1) or Color3.new(1, 1, 1);
            end;
        end);
    end;

    local u192 = {
        { 0, function() -- Line: 963
                -- upvalues: Flash (copy)
                Flash(0.5);
            end },
        { 150, function() -- Line: 967
                -- upvalues: Flash (copy), u28 (copy), EffectsHandler (ref), u2 (ref), ParticleHandler (ref), u20 (copy)
                Flash(0.4);
                local v190 = u28:FindFirstChild("Torso") or u28:FindFirstChild("UpperTorso");

                if v190 then
                    EffectsHandler.CallEffect("Bubble Distortion", {
                        StartSize = Vector3.new(6, 6, 6),
                        EndSize = Vector3.new(55, 55, 55),
                        Transparency = 11,
                        Time = 0.35,
                        Origin = CFrame.new(v190.Position)
                    });
                end;

                EffectsHandler.CallEffect("Vignette Gui", {
                    TweenTime = 0.25,
                    Blur = 8,
                    StartingColor = ParticleHandler.TryHSVShift(u2[3], u20),
                    EndingColor = ParticleHandler.TryHSVShift(u2[1], u20)
                });

                for i = 1, 3 do
                    task.delay(i * 0.04, function() -- Line: 988
                        -- upvalues: u28 (ref), EffectsHandler (ref), u2 (ref), ParticleHandler (ref), u20 (ref)
                        if u28.Parent then
                            EffectsHandler.CallEffect("Byee_Afterimage", {
                                Lifetime = 0.5,
                                IsHighlight = true,
                                FillTransparency = 0.2,
                                OutlineTransparency = 0.1,
                                Character = u28,
                                FillColor = ParticleHandler.TryHSVShift(u2[1], u20),
                                OutlineColor = ParticleHandler.TryHSVShift(u2[1], u20),
                                DepthMode = Enum.HighlightDepthMode.Occluded
                            });
                        end;
                    end);
                end;
            end },
        { 300, function() -- Line: 1001
                -- upvalues: Flash (copy), RunAcidTrip (copy)
                Flash(0.4);
                RunAcidTrip(300, 455);
            end },
        { 467, function() -- Line: 1006
                -- upvalues: Flash (copy), u28 (copy), EffectsHandler (ref), u2 (ref), ParticleHandler (ref), u20 (copy)
                Flash(0.5);
                local v191 = u28:FindFirstChild("Torso") or u28:FindFirstChild("UpperTorso");

                if v191 then
                    EffectsHandler.CallEffect("Bubble Distortion", {
                        StartSize = Vector3.new(8, 8, 8),
                        EndSize = Vector3.new(70, 70, 70),
                        Transparency = 10,
                        Time = 0.38,
                        Origin = CFrame.new(v191.Position)
                    });
                end;

                EffectsHandler.CallEffect("Vignette Gui", {
                    TweenTime = 0.2,
                    Blur = 10,
                    StartingColor = ParticleHandler.TryHSVShift(u2[2], u20),
                    EndingColor = ParticleHandler.TryHSVShift(u2[4], u20)
                });

                for i = 1, 4 do
                    task.delay(i * 0.035, function() -- Line: 1027
                        -- upvalues: u28 (ref), EffectsHandler (ref), u2 (ref), ParticleHandler (ref), u20 (ref)
                        if u28.Parent then
                            EffectsHandler.CallEffect("Byee_Afterimage", {
                                Lifetime = 0.5,
                                IsHighlight = true,
                                FillTransparency = 0.2,
                                OutlineTransparency = 0.1,
                                Character = u28,
                                FillColor = ParticleHandler.TryHSVShift(u2[2], u20),
                                OutlineColor = ParticleHandler.TryHSVShift(u2[2], u20),
                                DepthMode = Enum.HighlightDepthMode.Occluded
                            });
                        end;
                    end);
                end;
            end }
    };
    table.sort(u192, function(p193, p194) -- Line: 1041
        return p193[1] < p194[1];
    end);
    local u195 = 1;
    u23:Connect(RunService.Heartbeat, function() -- Line: 1044
        -- upvalues: Character (copy), u28 (copy), u29 (copy), u195 (ref), u192 (copy)
        if not (Character.Parent and u28.Parent) then
            return;
        end;

        local v196 = (os.clock() - u29) * 60;

        while u195 <= #u192 and u192[u195][1] <= v196 do
            local v197 = u192[u195][2];
            u195 = u195 + 1;
            task.spawn(v197);
        end;
    end);
    EffectsHandler.CallEffect("Camera Animation", {
        Bypass = true,
        CameraPart = "Bone",
        AbilityName = "Killer Queen",
        AnimationName = "Bites The Dust Camera",
        Speed = 1,
        CameraRig = AssetHandler.GetAsset("Models/CameraRig", u22),
        Character = u28,
        Offset = CFrame.new(0, 1.847, 0),
        FOVData = {
            TimeIn = 0.25,
            TimeOut = 0.25,
            FOV = 50
        }
    });
end;