  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
game:GetService("ContentProvider");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local _ = ReplicatedStorage["Client Assets"];
local u2 = {
    { "rbxassetid://131812451878534", "rbxassetid://74055744715475", "rbxassetid://127252691002947", "rbxassetid://101143853574066", "rbxassetid://133249287975360", "rbxassetid://105166877172461", "rbxassetid://117297038323047", "rbxassetid://112748447086663", "rbxassetid://128463175051076" },
    { "rbxassetid://102823963072899", "rbxassetid://130420459967316", "rbxassetid://113425045289150" },
    { "rbxassetid://107206509438318", "rbxassetid://92304852900610", "rbxassetid://85131797874907", "rbxassetid://133939148392704" },
    { "rbxassetid://94471502822254", "rbxassetid://123291283898816", "rbxassetid://111769270277108" },
    { "rbxassetid://132336899061190", "rbxassetid://82805399533185", "rbxassetid://80252123323131" },
    { "rbxassetid://138481620910632", "rbxassetid://105160313892642", "rbxassetid://74197876120342", "rbxassetid://138780766804703", "rbxassetid://137163002139117", "rbxassetid://127910079896843", "rbxassetid://136177490052065", "rbxassetid://86348643731975", "rbxassetid://106900340878129", "rbxassetid://126607141846919", "rbxassetid://93152248832837", "rbxassetid://80048531980932" },
    { "rbxassetid://108967133533394", "rbxassetid://131090381882497", "rbxassetid://116789497716740", "rbxassetid://111999166754372", "rbxassetid://74403667284224", "rbxassetid://82781835836470", "rbxassetid://72063979563264", "rbxassetid://114701311261212", "rbxassetid://71900380227638", "rbxassetid://133068246417448", "rbxassetid://116263245360869", "rbxassetid://133610788882265", "rbxassetid://78703812980477", "rbxassetid://112167490830680", "rbxassetid://124510757153350", "rbxassetid://140429987615301", "rbxassetid://117388084937512", "rbxassetid://105033054943530", "rbxassetid://110530416633954", "rbxassetid://102420727713074", "rbxassetid://123200942146533", "rbxassetid://89205962874449", "rbxassetid://100192256034912", "rbxassetid://97344318671307", "rbxassetid://94934291025212", "rbxassetid://104596904327394", "rbxassetid://76771002147821" }
};
local u3 = {
    Default = 70,
    Keyframes = { { 0, 60 }, { 5, 55, "Sine", "Out" }, { 39, 25, "Constant" }, { 81, 25, "Sine", "InOut" }, { 134, 30, "Quad", "In" }, { 144, 33 }, { 150, 22 }, { 161, 55 }, { 179, 65, "Sine", "In" }, { 194, 45 }, { 200, 40.7142829895 }, { 201, 20 }, { 214, 20, "Sine", "InOut" }, { 239, 30 }, { 270, 45 }, { 298, 30 }, { 347, 32 }, { 389, 30, "Quad", "In" }, { 433, 100 }, { 438, 120 }, { 467, 120 }, { 477, 7, "Sine", "Out" }, { 545, 12 }, { 567, 12, "Constant" }, { 691, 12, "Constant" }, { 707, 90, "Sine", "InOut" }, { 733, 69 }, { 743, 30, "Constant" }, { 859, 30, "Sine", "InOut" }, { 881, 5 }, { 882, 120, "Sine", "Out" }, { 920, 80 }, { 1185, 80, "Constant" }, { 1395, 80, "Constant" }, { 1396, 20, "Constant" }, { 1424, 50, "Sine", "Out" }, { 1552, 50 }, { 1562, 60, "Constant" }, { 1673, 20, "Constant" }, { 1702, 50, "Sine", "Out" }, { 1830, 50 }, { 1840, 60, "Constant" }, { 1950, 60, "Constant" }, { 1951, 50, "Sine", "InOut" }, { 1989, 30, "Sine", "In" }, { 2021, 35 }, { 2030, 50 } }
};
local u4 = {
    Threshold = { { 475, 2.65, "Constant" }, { 496, 2.3 } },
    Intensity = {
        Default = 1.5
    },
    Size = {
        Default = 24
    }
};
local u5 = {
    FarIntensity = {
        Default = 0.5,
        { 0, 0.5 },
        { 236, 0.5 },
        { 264, 35 },
        { 361, 35 },
        { 393, 150 },
        { 472, 1 },
        { 473, 0.5 },
        { 567, 0.5, "Constant" },
        { 691, 0.5, "Constant" },
        { 694, 0.5 },
        { 707, 0.5, "Constant" },
        { 742, 5 },
        { 801, 1 },
        { 802, 5 },
        { 1007, 5 },
        { 1080, 0.2 }
    },
    InFocusRadius = {
        Default = 150,
        { 0, 150 },
        { 8, 1 },
        { 36, 150 },
        { 70, 150 },
        { 78, 1 },
        { 110, 150 },
        { 146, 150 },
        { 154, 1 },
        { 186, 150 },
        { 227, 150 },
        { 235, 1 },
        { 264, 100 },
        { 317, 150 },
        { 361, 150 },
        { 393, 1 },
        { 472, 1 },
        { 473, 150 },
        { 567, 150, "Constant" },
        { 691, 150, "Constant" },
        { 694, 150 },
        { 707, 150, "Constant" },
        { 742, 10 },
        { 800, 10 },
        { 1005, 10 },
        { 1080, 400 }
    }
};
local u6 = {
    Size = {
        Default = 0,
        { 0, 0 },
        { 567, 0, "Constant" },
        { 691, 0, "Constant" },
        { 707, 0, "Constant" }
    }
};
local u7 = {
    Saturation = {
        Default = 0.3,
        { 0, 0.3 },
        { 380, 0.3 },
        { 480, 0.3 },
        { 730, 0.3 },
        { 745, -1 },
        { 855, -1 },
        { 872, 0.3 }
    },
    Brightness = {
        Default = 0.05,
        { 0, 0.05 },
        { 405, 0.05 },
        { 435, 0.1 },
        { 480, 0.01 },
        { 730, 0.01 },
        { 743, 0.5 },
        { 745, -0.1 },
        { 855, -0.1 },
        { 872, 0.01 },
        { 1950, 0.01, "Constant" },
        { 1951, 1 },
        { 1961, 0 }
    },
    TintColor = {
        Default = Color3.new(1, 1, 1),
        { 380, Color3.new(1, 1, 1) },
        { 435, Color3.fromRGB(122, 189, 255) },
        { 480, Color3.new(1, 1, 1) }
    }
};

local function SmoothStep(p8) -- Line: 271
    local v9 = math.clamp(p8, 0, 1);

    return v9 * v9 * (3 - 2 * v9);
end;

local function Snapshot(u10, p11) -- Line: 276
    if not u10 then
        return function() -- Line: 277
        end;
    end;

    local u12 = {};

    for _, v in p11 do
        u12[v] = u10[v];
    end;

    return function() -- Line: 280
        -- upvalues: u10 (copy), u12 (copy)
        if not u10.Parent then
            return;
        end;

        for i, v in u12 do
            u10[i] = v;
        end;
    end;
end;

local function FxPart(p13) -- Line: 286
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;

    for i, v in p13 do
        Part[i] = v;
    end;

    return Part;
end;

local u14 = {
    Default = Color3.fromRGB(71, 145, 255),
    ["Reverse Flash"] = Color3.fromRGB(172, 12, 12),
    ["CW Flash"] = Color3.fromRGB(221, 147, 81),
    ["Injustice Flash"] = Color3.fromRGB(234, 201, 15)
};

local function Highlight(p15, p16, p17, p18) -- Line: 304
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy), u14 (copy)
    if not (p15 and p15.Parent) then
        return;
    end;

    local v19 = p17 or ParticleHandler.GetUnusualHSVData({
        Character = p15
    });
    EffectsHandler.CallEffect("HighlightObject", p15, {
        FillTransparency = -0.5,
        OutlineTransparency = 1,
        Tween = true,
        Style = "Sine",
        Direction = "In",
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = ParticleHandler.TryHSVShift(u14[p18 or "Default"] or u14.Default, v19),
        Lifetime = p16
    });
end;

local function SafeSet(p20, p21, p22) -- Line: 319
    if p20 and p20.Parent then
        p20[p21] = p22;
    end;
end;

return function(p23) -- Line: 324
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), Snapshot (copy), RunService (copy), u4 (copy), u5 (copy), u7 (copy), u6 (copy), u2 (copy), EffectsHandler (copy), AnimationHandler (copy), UserInputService (copy), u1 (copy), Highlight (copy), CurrentCamera (copy), u3 (copy), u14 (copy)
    local u24 = p23 or {};
    local u25 = u24.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = u24.Player or u24.AttackerPlayer,
        Character = u24.Character or u24.Attacker
    });
    local Attacker = u24.Attacker;
    local Target = u24.Target;
    local AttackerPlayer = u24.AttackerPlayer;
    local HumanoidRootPart = Attacker.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    local Animations = u24.Animations;
    local Trove = u24.Trove;
    local CloneChar = u24.CloneChar;
    local AttackerClone = u24.AttackerClone;
    local TargetClone = u24.TargetClone;
    local u26 = AssetHandler.GetAbilityData(Attacker);
    local u27 = Trove:Clone(AssetHandler.GetAsset("Models/CameraRig", u26));
    local camera = u27:FindFirstChild("camera");

    if not camera then
        return;
    end;

    u27.PrimaryPart.CFrame = CFrame2;
    u27.Parent = workspace.Effects;
    u27.PrimaryPart.Anchored = true;
    local SpeedBeams = u27:FindFirstChild("SpeedBeams");
    task.spawn(function() -- Line: 349
        -- upvalues: u27 (copy), LocalPlayer (ref), TweenService (ref), Trove (copy)
        local letterboxbot = u27:FindFirstChild("letterboxbot");
        local letterboxtop = u27:FindFirstChild("letterboxtop");

        if letterboxbot then
            letterboxbot.Transparency = 1;
        end;

        if letterboxtop then
            letterboxtop.Transparency = 1;
        end;

        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

        if not PlayerGui then
            return;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "CinematicLetterbox";
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.DisplayOrder = 999;
        ScreenGui.Parent = PlayerGui;

        local function MakeBar(p28, p29) -- Line: 365
            -- upvalues: ScreenGui (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = p28;
            Frame.AnchorPoint = Vector2.new(0.5, p29);
            Frame.Position = UDim2.fromScale(0.5, p29);
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.BackgroundColor3 = Color3.new(0, 0, 0);
            Frame.BorderSizePixel = 0;
            Frame.Parent = ScreenGui;

            return Frame;
        end;

        local u30 = MakeBar("TopBar", 0);
        local u31 = MakeBar("BottomBar", 1);
        local v32 = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        TweenService:Create(u30, v32, {
            Size = UDim2.fromScale(1, 0.105)
        }):Play();
        TweenService:Create(u31, v32, {
            Size = UDim2.fromScale(1, 0.105)
        }):Play();
        Trove:Add(function() -- Line: 384
            -- upvalues: ScreenGui (copy), u30 (copy), TweenService (ref), u31 (copy)
            if not (ScreenGui and ScreenGui.Parent) then
                return;
            end;

            local v33 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

            if u30 and u30.Parent then
                TweenService:Create(u30, v33, {
                    Size = UDim2.fromScale(1, 0)
                }):Play();
            end;

            if u31 and u31.Parent then
                TweenService:Create(u31, v33, {
                    Size = UDim2.fromScale(1, 0)
                }):Play();
            end;

            task.delay(0.3, function() -- Line: 393
                -- upvalues: ScreenGui (ref)
                if ScreenGui and ScreenGui.Parent then
                    ScreenGui:Destroy();
                end;
            end);
        end);
    end);
    local DefaultBloom = Lighting:FindFirstChild("DefaultBloom");
    local DefaultBlur = Lighting:FindFirstChild("DefaultBlur");
    local DefaultColorCorrection = Lighting:FindFirstChild("DefaultColorCorrection");
    local u34 = DefaultBloom and (Snapshot(DefaultBloom, { "Threshold", "Intensity", "Size" }) or function() -- Line: 403
    end) or function() -- Line: 403
    end;
    local u35 = DefaultBlur and (Snapshot(DefaultBlur, { "Size" }) or function() -- Line: 404
    end) or function() -- Line: 404
    end;
    local u36 = DefaultColorCorrection and (Snapshot(DefaultColorCorrection, { "Brightness", "Contrast", "Saturation", "TintColor" }) or function() -- Line: 405
    end) or function() -- Line: 405
    end;
    Trove:Add(function() -- Line: 407
        -- upvalues: u34 (copy), u35 (copy), u36 (copy)
        u34();
        u35();
        u36();
    end);

    if DefaultBloom then
        DefaultBloom.Size = 24;
        DefaultBloom.Threshold = 2.65;
        DefaultBloom.Intensity = 1.5;
    end;

    if DefaultColorCorrection then
        DefaultColorCorrection.Brightness = 0.05;
        DefaultColorCorrection.Contrast = 0.1;
        DefaultColorCorrection.Saturation = 0.3;
        DefaultColorCorrection.TintColor = Color3.new(1, 1, 1);
    end;

    local u37 = Trove:Add(Instance.new("DepthOfFieldEffect"));
    u37.Name = "UGrain_CinematicDOF";
    u37.FarIntensity = 0.5;
    u37.FocusDistance = 1;
    u37.InFocusRadius = 150;
    u37.NearIntensity = 1;
    u37.Enabled = true;
    u37.Parent = Lighting;
    local u38 = os.clock();
    local u39 = {};

    local function IsBeatdownAlive() -- Line: 434
        -- upvalues: Attacker (copy), Target (copy)
        return Attacker.Parent and Target.Parent;
    end;

    local function SetTimelineSuppressed(p40, p41, p42) -- Line: 436
        -- upvalues: u39 (copy)
        if not p40 then
            return;
        end;

        u39[p40] = u39[p40] or {};
        u39[p40][p41] = p42 or nil;
    end;

    local function PrepareKeyframes(p43) -- Line: 442
        local v44 = {};
        local v45 = nil;

        for i, v in pairs(p43) do
            if type(i) == "number" then
                v44[#v44 + 1] = v;
            elseif i == "Default" then
                v45 = v;
            end;
        end;

        table.sort(v44, function(p46, p47) -- Line: 448
            return p46[1] < p47[1];
        end);

        return v44, v45;
    end;

    local function SampleKeyframes(p48, p49) -- Line: 452
        -- upvalues: TweenService (ref)
        local Sorted = p48.Sorted;
        local v50 = #p48.Sorted;

        if v50 == 0 then
            return p48.Default;
        end;

        local LastIdx = p48.LastIdx;

        while LastIdx < v50 and Sorted[LastIdx + 1][1] <= p49 do
            LastIdx = LastIdx + 1;
        end;

        p48.LastIdx = LastIdx;

        if LastIdx == 0 then
            return Sorted[1][2];
        end;

        if v50 <= LastIdx then
            return Sorted[v50][2];
        end;

        local v51 = Sorted[LastIdx];
        local v52 = Sorted[LastIdx + 1];
        local v53 = v51[2];
        local v54 = v52[2];
        local v55 = v52[3];
        local v56 = v52[4];

        if v55 == "Constant" or v52[1] == v51[1] then
            return v53;
        end;

        local v57 = TweenService:GetValue(math.clamp((p49 - v51[1]) / (v52[1] - v51[1]), 0, 1), v55 and Enum.EasingStyle[v55] or Enum.EasingStyle.Linear, v56 and Enum.EasingDirection[v56] or Enum.EasingDirection.Out);

        if typeof(v53) == "Color3" then
            return v53:Lerp(v54, v57);
        end;

        return v53 + (v54 - v53) * v57;
    end;

    local u58 = {};
    local u59 = 0;

    local function RegisterKeyframeUpdate(p60, p61, p62, p63, p64) -- Line: 482
        -- upvalues: u38 (copy), Trove (copy), PrepareKeyframes (copy), SampleKeyframes (copy), u59 (ref), u58 (ref)
        if not (p60 and p60.Parent) then
            return;
        end;

        local v65 = p63 or u38;
        local v66, v67 = PrepareKeyframes(p62);
        local u68 = {
            LastIdx = 0,
            LastValue = nil,
            Alive = true,
            Instance = p60,
            Property = p61,
            Sorted = v66,
            Default = v67,
            ClockStart = v65
        };
        local v69 = SampleKeyframes(u68, (os.clock() - v65) * 60);

        if v69 ~= nil then
            p60[p61] = v69;
            u68.LastValue = v69;
        end;

        u59 = u59 + 1;
        u58[u59] = u68;
        (p64 or Trove):Add(function() -- Line: 503
            -- upvalues: u68 (copy)
            u68.Alive = false;
        end);
    end;

    local u70 = false;
    Trove:Connect(RunService.RenderStepped, function() -- Line: 507
        -- upvalues: u59 (ref), u58 (ref), u70 (ref), u39 (copy), SampleKeyframes (copy)
        local v71 = os.clock();
        local v72 = 0;

        for i = 1, u59 do
            local v73 = u58[i];

            if v73.Alive then
                local Instance2 = v73.Instance;

                if Instance2 and Instance2.Parent then
                    v72 = v72 + 1;
                    local v74 = u39[Instance2];

                    if not (v74 and v74[v73.Property]) then
                        local v75 = SampleKeyframes(v73, (v71 - v73.ClockStart) * 60);

                        if v75 ~= nil and v75 ~= v73.LastValue then
                            Instance2[v73.Property] = v75;
                            v73.LastValue = v75;
                        end;
                    end;
                else
                    v73.Alive = false;
                    u70 = true;
                end;
            else
                u70 = true;
            end;
        end;

        if u70 and u59 - v72 >= 8 then
            local v76 = 0;
            local v77 = {};

            for i = 1, u59 do
                local v78 = u58[i];

                if v78.Alive then
                    v76 = v76 + 1;
                    v77[v76] = v78;
                end;
            end;

            u58 = v77;
            u59 = v76;
            u70 = false;
        end;
    end);

    local function ScheduleFrameEvents(p79, p80, p81) -- Line: 540
        -- upvalues: u38 (copy), Trove (copy), Attacker (copy), Target (copy), RunService (ref)
        local u82 = p80 or u38;
        local u83 = {};

        for i, v in pairs(p79) do
            if type(i) == "number" then
                u83[#u83 + 1] = v;
            end;
        end;

        table.sort(u83, function(p84, p85) -- Line: 548
            return p84[1] < p85[1];
        end);
        local u86 = 1;
        local u87 = #u83;
        local u88 = nil;

        local function Process() -- Line: 553
            -- upvalues: Attacker (ref), Target (ref), u88 (ref), u82 (ref), u86 (ref), u87 (copy), u83 (copy)
            if not (Attacker.Parent and Target.Parent) then
                if u88 then
                    u88:Disconnect();
                    u88 = nil;
                end;

                return;
            end;

            local v89 = os.clock() - u82;

            while u86 <= u87 do
                local v90 = u83[u86];

                if v89 < v90[1] / 60 then
                    break;
                end;

                u86 = u86 + 1;
                local u91 = v90[2];
                local u92 = math.max(0, v89 - v90[1] / 60);
                task.spawn(function() -- Line: 565
                    -- upvalues: Attacker (ref), Target (ref), u91 (copy), u92 (copy)
                    if Attacker.Parent and Target.Parent then
                        u91(u92);
                    end;
                end);
            end;

            if u87 < u86 and u88 then
                u88:Disconnect();
                u88 = nil;
            end;
        end;

        u88 = RunService.Heartbeat:Connect(Process);
        (p81 or Trove):Add(function() -- Line: 573
            -- upvalues: u88 (ref)
            if u88 then
                u88:Disconnect();
                u88 = nil;
            end;
        end);
        Process();
    end;

    local function WaitUntilTime(p93) -- Line: 579
        -- upvalues: Attacker (copy), Target (copy), RunService (ref)
        while true do
            if not (Attacker.Parent and Target.Parent) or os.clock() >= p93 then
                return;
            end;

            RunService.Heartbeat:Wait();
        end;
    end;

    local function WaitUntilFrame(p94, p95) -- Line: 585
        -- upvalues: WaitUntilTime (copy), u38 (copy)
        WaitUntilTime((p95 or u38) + p94 / 60);
    end;

    RegisterKeyframeUpdate(DefaultBloom, "Threshold", u4.Threshold);
    RegisterKeyframeUpdate(u37, "FarIntensity", u5.FarIntensity);
    RegisterKeyframeUpdate(u37, "InFocusRadius", u5.InFocusRadius);
    RegisterKeyframeUpdate(DefaultColorCorrection, "Saturation", u7.Saturation);
    RegisterKeyframeUpdate(DefaultColorCorrection, "Brightness", u7.Brightness);
    RegisterKeyframeUpdate(DefaultColorCorrection, "TintColor", u7.TintColor);
    RegisterKeyframeUpdate(DefaultBlur, "Size", u6.Size);
    local v96 = "UGrainImpact_" .. tostring(os.clock());
    local v97 = {
        {
            426,
            {
                Time = 0.18333333333333332,
                Decals = u2[1]
            }
        },
        {
            744,
            {
                Time = 0.1,
                Decals = u2[2]
            }
        },
        {
            1056,
            {
                Time = 0.13333333333333333,
                Decals = u2[3]
            }
        },
        {
            1538,
            {
                Time = 0.13333333333333333,
                Decals = u2[4]
            }
        },
        {
            1816,
            {
                Time = 0.13333333333333333,
                Decals = u2[5]
            }
        },
        {
            1290,
            {
                Time = 0.5,
                Decals = u2[6]
            }
        },
        {
            1959,
            {
                Time = 0.9666666666666667,
                Decals = u2[7]
            }
        }
    };

    for _, v in { true, false } do
        EffectsHandler.CallEffect("Sequential Impact Frames", {
            BypassSettings = true,
            Preload = v,
            Identifier = v96,
            Character = Attacker,
            Players = { LocalPlayer },
            Speed = not v and 1 or nil,
            Frames = v97
        });
    end;

    local u98 = {};

    local function Load(p99, p100) -- Line: 624
        -- upvalues: Animations (copy), u98 (copy), AnimationHandler (ref)
        if not (p99 and p99.Parent) then
            return;
        end;

        for _, v in p100 do
            local v101 = Animations[v];

            if v101 then
                if typeof(v101) == "string" then
                    v101 = string.match(v101, "%d+") or v101;
                end;

                u98[v] = AnimationHandler.PlayAnimId(p99, v101, true);
            end;
        end;
    end;

    local u102 = {};
    local u103 = 0;

    local function PlaySyncedTrack(p104, p105, p106, p107) -- Line: 638
        -- upvalues: u38 (copy), u102 (copy), u103 (ref)
        if not p104 then
            return;
        end;

        local v108 = p105 or u38;
        local v109 = p106 or 0;
        p104:Play(p107 or 0);
        local v110 = os.clock() - v108 - v109 / 60;
        p104.TimePosition = math.max(0, v110);
        u102[p104] = {
            ClockStart = v108,
            StartFrame = v109
        };
        u103 = u103 + 1;
    end;

    local function PlaySyncedTracks(p111, p112) -- Line: 647
        -- upvalues: PlaySyncedTrack (copy), u98 (copy)
        for _, v in p111 do
            PlaySyncedTrack(u98[v], p112, 0, 0);
        end;
    end;

    local u113 = 0;
    Trove:Connect(RunService.Heartbeat, function(p114) -- Line: 652
        -- upvalues: u103 (ref), u113 (ref), u102 (copy)
        if u103 == 0 then
            return;
        end;

        u113 = u113 + p114;

        if u113 < 0.066 then
            return;
        end;

        u113 = 0;
        local v115 = os.clock();

        for i, v in u102 do
            if i.IsPlaying then
                local v116 = v115 - v.ClockStart - v.StartFrame / 60;

                if v116 >= 0 and math.abs(i.TimePosition - v116) > 0.08 then
                    i.TimePosition = v116;
                end;
            else
                u102[i] = nil;
                u103 = u103 - 1;
            end;
        end;
    end);

    if not UserInputService.TouchEnabled then
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

        if PlayerGui then
            PlayerGui = PlayerGui:FindFirstChild("UI");
        end;

        if PlayerGui then
            PlayerGui.Enabled = false;
            Trove:Add(function() -- Line: 677
                -- upvalues: PlayerGui (copy)
                if PlayerGui and PlayerGui.Parent then
                    PlayerGui.Enabled = true;
                end;
            end);
        end;
    end;

    local function Wormhole(p117, p118) -- Line: 683
        -- upvalues: Trove (copy), EffectsHandler (ref), AssetHandler (ref), u26 (copy), ParticleHandler (ref), u25 (copy), u27 (copy), CloneChar (copy), AttackerClone (copy), TargetClone (copy), SpeedBeams (copy), Load (copy), PlaySyncedTrack (copy), u98 (copy), AttackerPlayer (copy), RunService (ref), WaitUntilTime (copy), TweenService (ref), u1 (ref), ScheduleFrameEvents (copy), u38 (copy)
        local u119 = p117 or 1;
        local u120 = os.clock() - (p118 or 0);
        local u121 = Trove:Extend();
        EffectsHandler.CallEffect("ColorCorrectionFrame", {
            CanTween = true,
            Brightness = 5,
            Contrast = 0.7,
            Saturation = -0.7,
            Duration = 0.47,
            Easing = {
                Enum.EasingStyle.Cubic,
                Enum.EasingDirection.Out,
                0,
                false,
                0.1
            }
        });
        local v122 = u121:Add(AssetHandler.CloneAsset("Particles/Beatdown/Wormhole/Pivot", u26));
        ParticleHandler.Unusualify(v122, {
            HSVData = u25
        });
        v122.PrimaryPart.CFrame = CFrame.new(250 * u119, 250, 250 * u119);
        v122.Parent = workspace.Effects;
        local u123 = u121:Clone(AssetHandler.GetAsset("Models/Map" .. u119, u26));
        u123.Parent = workspace.Effects;
        u123:PivotTo(v122.PrimaryPart.CFrame);
        local u124 = {};

        for _, descendant in u123:GetDescendants() do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                u124[descendant] = descendant.Transparency;
                descendant.Transparency = 1;

                if descendant:IsA("BasePart") then
                    descendant.Anchored = true;
                    descendant.CanCollide = false;
                    descendant.CanQuery = false;
                    descendant.CanTouch = false;
                end;
            elseif descendant:IsA("Shirt") or (descendant:IsA("Pants") or descendant:IsA("ShirtGraphic")) then
                u124[descendant] = descendant.Parent;
                descendant.Parent = nil;
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("SurfaceGui"))) then
                descendant.Enabled = false;
            end;
        end;

        local Start = v122:FindFirstChild("Start");
        local Wall = v122:FindFirstChild("Wall");

        if not (Start and Wall) then
            u121:Destroy();

            return;
        end;

        local CFrame3 = Start.CFrame;
        local CFrame4 = Wall.CFrame;
        u27.PrimaryPart.CFrame = CFrame3;
        local u125 = u121:Add(CloneChar(AttackerClone));
        u125.Parent = workspace.Effects;
        u125:PivotTo(CFrame3);
        local u126 = u121:Add(CloneChar(TargetClone));
        u126.Parent = workspace.Effects;
        u126:PivotTo(CFrame3);
        local v165 = {
            { 0, function() -- Line: 739
                    -- upvalues: SpeedBeams (ref), ParticleHandler (ref), Load (ref), u125 (copy), u126 (copy), u119 (ref), u120 (copy), PlaySyncedTrack (ref), u98 (ref), AssetHandler (ref), u26 (ref), u25 (ref), u121 (copy), EffectsHandler (ref), CFrame3 (copy), AttackerPlayer (ref), RunService (ref), WaitUntilTime (ref), TweenService (ref), u1 (ref)
                    if SpeedBeams then
                        ParticleHandler.EnableAllParticles(SpeedBeams, true);
                    end;

                    Load(u125, { "UGrain_Beatdown Attacker Wormhole 1", "UGrain_Beatdown Attacker Wormhole 2" });
                    Load(u126, { "UGrain_Beatdown Target Wormhole 1", "UGrain_Beatdown Target Wormhole 2" });
                    local v127 = u120;

                    for _, v in { "UGrain_Beatdown Camera Wormhole " .. u119, "UGrain_Beatdown Attacker Wormhole " .. u119, "UGrain_Beatdown Target Wormhole " .. u119 } do
                        PlaySyncedTrack(u98[v], v127, 0, 0);
                    end;

                    local Torso = u125:FindFirstChild("Torso");

                    if Torso then
                        local u128 = AssetHandler.CloneAsset("Particles/Beatdown/BodyTrail", u26);
                        ParticleHandler.Unusualify(u128, {
                            HSVData = u25
                        });
                        u128.Parent = u125;
                        ParticleHandler.AttachTo(u128, {
                            Part = Torso
                        });
                        u121:Add(function() -- Line: 757
                            -- upvalues: u128 (copy), ParticleHandler (ref)
                            if u128 and u128.Parent then
                                ParticleHandler.EnableAllParticles(u128, false);
                                ParticleHandler.DestroyEmit(u128);
                            end;
                        end);
                    end;

                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/Wormhole/Running",
                        Origin = CFrame3,
                        Player = AttackerPlayer
                    });
                    local u129 = u121:Add(AssetHandler.CloneAsset("Particles/Beatdown/Wormhole/Mesh", u26));
                    u129.CFrame = CFrame3 * CFrame.Angles(0, 1.5707963267948966, 0);
                    u129.Parent = workspace.Effects;
                    u121:Connect(RunService.RenderStepped, function(p130) -- Line: 776
                        -- upvalues: u129 (copy)
                        if not (u129 and u129.Parent) then
                            return;
                        end;

                        local v131 = u129;
                        v131.CFrame = v131.CFrame * (CFrame.new(-132 * p130, 0, 0) * CFrame.fromEulerAnglesXYZ(math.rad(450 * p130), 0, 0));
                    end);
                    task.spawn(function() -- Line: 781
                        -- upvalues: WaitUntilTime (ref), u120 (ref), u129 (copy), TweenService (ref)
                        WaitUntilTime(u120 + 1.75);

                        if u129 and u129.Parent then
                            TweenService:Create(u129, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                Transparency = 1
                            }):Play();
                        end;
                    end);
                    local HumanoidRootPart2 = u125:FindFirstChild("HumanoidRootPart");

                    if not HumanoidRootPart2 then
                        return;
                    end;

                    local u132 = table.create(80);

                    for i = 1, 80 do
                        local v133 = u121:Add(AssetHandler.CloneAsset("Particles/Beatdown/Wormhole/Streak", u26));
                        ParticleHandler.Unusualify(v133, {
                            HSVData = u25
                        });
                        ParticleHandler.EnableAllParticles(v133, false);
                        v133.Parent = workspace.Effects;
                        local v134 = u1:NextNumber(0.05, 0.125);
                        local Attachment0 = v133:FindFirstChild("Attachment0");
                        local Attachment1 = v133:FindFirstChild("Attachment1");

                        if Attachment0 then
                            Attachment0.Position = Vector3.new(0, v134, 0);
                        end;

                        if Attachment1 then
                            Attachment1.Position = Vector3.new(0, -v134, 0);
                        end;

                        u132[i] = {
                            Active = false,
                            Part = v133,
                            OffsetX = u1:NextNumber(-30, 30),
                            OffsetY = u1:NextNumber(-30, 30),
                            OffsetZ = u1:NextNumber(75, 200)
                        };
                    end;

                    task.spawn(function() -- Line: 815
                        -- upvalues: WaitUntilTime (ref), u120 (ref), u132 (copy), ParticleHandler (ref)
                        WaitUntilTime(u120 + 2);

                        for _, v in u132 do
                            if v.Part.Parent then
                                ParticleHandler.EnableAllParticles(v.Part, false);
                            end;
                        end;
                    end);
                    local v135 = AssetHandler.GetAsset("Particles/Beatdown/Wormhole/Chain", u26);
                    local v136;

                    if v135 then
                        v136 = v135:FindFirstChild("Start");
                    else
                        v136 = v135;
                    end;

                    local v137;

                    if v135 then
                        v137 = v135:FindFirstChild("End");
                    else
                        v137 = v135;
                    end;

                    if not (v136 and v137) then
                        return;
                    end;

                    local u138 = v136.CFrame:ToObjectSpace(v137.CFrame);
                    local v139 = u121:Clone(v135);
                    ParticleHandler.Unusualify(v139, {
                        HSVData = u25
                    });
                    v139.Parent = workspace.Effects;

                    for _, descendant in v139:GetDescendants() do
                        if descendant:IsA("BasePart") then
                            descendant.Anchored = true;
                            descendant.CanCollide = false;
                            descendant.CanQuery = false;
                            descendant.CanTouch = false;
                        end;
                    end;

                    local Start2 = v139:FindFirstChild("Start");
                    local End = v139:FindFirstChild("End");

                    if not (Start2 and End) then
                        return;
                    end;

                    local u140 = {
                        Distance = 115,
                        Spin = 0,
                        Start = Start2,
                        End = End
                    };
                    local u141 = os.clock();
                    u121:Connect(RunService.RenderStepped, function(p142) -- Line: 851
                        -- upvalues: HumanoidRootPart2 (copy), u132 (copy), ParticleHandler (ref), u1 (ref), u141 (copy), u140 (copy), u138 (copy)
                        if not (HumanoidRootPart2 and HumanoidRootPart2.Parent) then
                            return;
                        end;

                        local CFrame5 = HumanoidRootPart2.CFrame;
                        local Position = CFrame5.Position;
                        local LookVector = CFrame5.LookVector;
                        local RightVector = CFrame5.RightVector;
                        local UpVector = CFrame5.UpVector;
                        local v143 = 800 * p142;

                        for _, v in u132 do
                            if v.Part and v.Part.Parent then
                                local v144 = v.OffsetZ - v143;

                                if not v.Active then
                                    v.Active = true;
                                    ParticleHandler.EnableAllParticles(v.Part, true);
                                end;

                                if v144 < -15 then
                                    v.OffsetX = u1:NextNumber(-30, 30);
                                    v.OffsetY = u1:NextNumber(-30, 30);
                                    v144 = u1:NextNumber(75, 200);
                                    v.Active = false;
                                    ParticleHandler.EnableAllParticles(v.Part, false);
                                end;

                                v.OffsetZ = v144;
                                v.Part.Position = Position + LookVector * v144 + RightVector * v.OffsetX + UpVector * v.OffsetY;
                            end;
                        end;

                        if os.clock() - u141 < 1.5 and (u140.Start.Parent and u140.End.Parent) then
                            local v145 = u140;
                            v145.Distance = v145.Distance - 360 * p142;
                            local v146 = u140;
                            v146.Spin = v146.Spin + 1.3089969389957472 * p142;

                            if u140.Distance < -20 then
                                local v147 = u140;
                                v147.Distance = v147.Distance + 270;
                            end;

                            local v148 = Position + LookVector * u140.Distance;
                            local v149 = CFrame.lookAt(v148, v148 + LookVector) * CFrame.Angles(0, 0, u140.Spin);
                            u140.Start.CFrame = v149;
                            u140.End.CFrame = v149 * u138;
                        end;
                    end);
                end },
            { 105, function() -- Line: 894
                    -- upvalues: u124 (copy), TweenService (ref), u123 (copy)
                    for i, v in u124 do
                        if typeof(v) == "number" and i.Parent then
                            TweenService:Create(i, TweenInfo.new(0.3), {
                                Transparency = v
                            }):Play();
                        elseif typeof(v) == "Instance" and v.Parent then
                            i.Parent = v;
                        end;
                    end;

                    for _, descendant in u123:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("SurfaceGui"))) then
                            descendant.Enabled = true;
                        end;
                    end;
                end },
            { 130, function() -- Line: 910
                    -- upvalues: SpeedBeams (ref), ParticleHandler (ref)
                    if SpeedBeams then
                        ParticleHandler.EnableAllParticles(SpeedBeams, false);
                    end;
                end },
            { 145, function() -- Line: 914
                end },
            { 149, function() -- Line: 918
                    -- upvalues: EffectsHandler (ref), CFrame3 (copy), AttackerPlayer (ref), u119 (ref), u1 (ref), CFrame4 (copy), TweenService (ref)
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/Wormhole/Slam",
                        Origin = CFrame3,
                        Player = AttackerPlayer
                    });
                    local v150 = ({ Color3.fromRGB(108, 88, 75), Color3.fromRGB(211, 190, 150) })[u119];
                    local v151 = Enum.Material[({ "Slate", "SmoothPlastic" })[u119]];

                    for _ = 1, 8 do
                        local v152 = u1:NextNumber(0.85, 2);
                        local Part = Instance.new("Part");
                        local v153 = CFrame4 * CFrame.new(0, 0, -3);
                        local Angles = CFrame.Angles;
                        local v154 = u1:NextNumber(-360, 360);
                        local v155 = math.rad(v154);
                        local v156 = u1:NextNumber(-360, 360);
                        local v157 = math.rad(v156);
                        local v158 = u1:NextNumber(-360, 360);
                        Part.CFrame = v153 * Angles(v155, v157, (math.rad(v158)));
                        Part.Size = Vector3.new(v152, v152, v152);
                        Part.CollisionGroup = "Ghosted";
                        Part.BottomSurface = Enum.SurfaceType.Smooth;
                        Part.TopSurface = Enum.SurfaceType.Smooth;
                        Part.Color = v150;
                        Part.Material = v151;
                        local v159 = u1:NextNumber(-180, 180);
                        local v160 = u1:NextNumber(-180, 180);
                        Part.Orientation = Vector3.new(v159, v160, u1:NextNumber(-180, 180));
                        Part.Parent = workspace.Effects;
                        local Attachment = Instance.new("Attachment");
                        Attachment.Parent = Part;
                        local LinearVelocity = Instance.new("LinearVelocity");
                        LinearVelocity.MaxForce = (1 / 0);
                        local v161 = CFrame4.LookVector * u1:NextNumber(5, 10);
                        local v162 = u1:NextNumber(-9, 9);
                        local v163 = u1:NextNumber(5, 9);
                        LinearVelocity.VectorVelocity = v161 + Vector3.new(v162, v163, u1:NextNumber(-9, 9));
                        LinearVelocity.Attachment0 = Attachment;
                        LinearVelocity.Parent = Attachment;
                        task.delay(u1:NextNumber(0.8, 1.4), function() -- Line: 956
                            -- upvalues: Part (copy), TweenService (ref), u1 (ref)
                            if not (Part and Part.Parent) then
                                return;
                            end;

                            local v164 = TweenService:Create(Part, TweenInfo.new(u1:NextNumber(1, 2)), {
                                Size = Vector3.new(0, 0, 0)
                            });
                            v164:Play();
                            v164.Completed:Connect(function() -- Line: 960
                                -- upvalues: Part (ref)
                                if Part then
                                    Part:Destroy();
                                end;
                            end);
                        end);
                        task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
                    end;
                end },
            { 213, function() -- Line: 966
                    -- upvalues: EffectsHandler (ref), CFrame3 (copy), AttackerPlayer (ref)
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/Wormhole/DashBack",
                        Origin = CFrame3,
                        Player = AttackerPlayer
                    });
                end },
            { 278, function() -- Line: 975
                end }
        };
        ScheduleFrameEvents(v165, u120, u121);
        WaitUntilTime((u120 or u38) + v165[#v165][1] / 60);
        u121:Destroy();
    end;

    local function End(p166) -- Line: 983
        -- upvalues: Trove (copy), u27 (copy), CFrame2 (copy), CloneChar (copy), AttackerClone (copy), TargetClone (copy), SpeedBeams (copy), ParticleHandler (ref), Load (copy), PlaySyncedTrack (copy), u98 (copy), EffectsHandler (ref), AttackerPlayer (copy), Highlight (ref), u25 (copy), u24 (ref), ScheduleFrameEvents (copy), WaitUntilTime (copy), u38 (copy)
        local u167 = os.clock() - (p166 or 0);
        local v168 = Trove:Extend();
        u27.PrimaryPart.CFrame = CFrame2;
        local u169 = v168:Add(CloneChar(AttackerClone));
        u169.Parent = workspace.Effects;
        u169:PivotTo(CFrame2);
        local u170 = v168:Add(CloneChar(TargetClone));
        u170.Parent = workspace.Effects;
        u170:PivotTo(CFrame2);
        local v173 = {
            { 0, function() -- Line: 999
                    -- upvalues: SpeedBeams (ref), ParticleHandler (ref), Load (ref), u169 (copy), u170 (copy), u167 (copy), PlaySyncedTrack (ref), u98 (ref)
                    if SpeedBeams then
                        ParticleHandler.EnableAllParticles(SpeedBeams, true);
                    end;

                    Load(u169, { "Outside UGrain_Beatdown Attacker End" });
                    Load(u170, { "Outside UGrain_Beatdown Target End" });
                    local v171 = u167;

                    for _, v in { "Outside UGrain_Beatdown Attacker End", "Outside UGrain_Beatdown Target End", "UGrain_Beatdown Attacker End", "UGrain_Beatdown Target End", "UGrain_Beatdown Camera End" } do
                        PlaySyncedTrack(u98[v], v171, 0, 0);
                    end;
                end },
            { 3, function() -- Line: 1014
                    -- upvalues: EffectsHandler (ref), AttackerPlayer (ref), CFrame2 (ref), Highlight (ref), AttackerClone (ref), u25 (ref), u24 (ref), TargetClone (ref)
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/End/Portal",
                        Player = AttackerPlayer,
                        Origin = CFrame2
                    });
                    Highlight(AttackerClone, 0.72, u25, u24.SkinName);
                    Highlight(TargetClone, 0.72, u25, u24.SkinName);
                end },
            { 71, function() -- Line: 1023
                    -- upvalues: EffectsHandler (ref), CFrame2 (ref), AttackerPlayer (ref), u170 (copy)
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/End/Impact",
                        Origin = CFrame2,
                        Player = AttackerPlayer
                    });
                    local v172 = u170 and u170:FindFirstChild("Torso");

                    if v172 then
                        EffectsHandler.CallEffect("Bubble Distortion", {
                            StartSize = Vector3.new(2.6666667, 2.6666667, 2.6666667),
                            EndSize = Vector3.new(11, 11, 11),
                            Transparency = 7,
                            Time = 0.6,
                            Origin = CFrame.new(v172.Position)
                        });
                    end;
                end },
            { 133, function() -- Line: 1039
                    -- upvalues: u169 (copy), u170 (copy), EffectsHandler (ref)
                    for _, v in { u169, u170 } do
                        if v and v.Parent then
                            EffectsHandler.CallEffect("SK_VANISH", {
                                Transparency = 1,
                                AffectStands = true,
                                Character = v
                            });
                        end;
                    end;
                end },
            { 147, function() -- Line: 1049
                    -- upvalues: EffectsHandler (ref), CFrame2 (ref), AttackerPlayer (ref)
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/End/GroundSlam",
                        Origin = CFrame2,
                        Player = AttackerPlayer
                    });
                end }
        };
        ScheduleFrameEvents(v173, u167, v168);
        WaitUntilTime((u167 or u38) + v173[#v173][1] / 60);
        v168:Destroy();
    end;

    local FieldOfView = CurrentCamera.FieldOfView;
    Trove:Add(function() -- Line: 1063
        -- upvalues: CurrentCamera (ref), FieldOfView (copy)
        CurrentCamera.FieldOfView = FieldOfView;
    end);
    RegisterKeyframeUpdate(CurrentCamera, "FieldOfView", u3.Keyframes);
    local u174 = CFrame.new();

    local function CameraUpdate() -- Line: 1067
        -- upvalues: CurrentCamera (ref), u27 (copy), camera (copy), u174 (ref)
        if CurrentCamera.CameraType == Enum.CameraType.Scriptable and (u27 and (u27.Parent and (camera and camera.Parent))) then
            CurrentCamera.CFrame = camera.CFrame * u174;
        end;
    end;

    local u175 = {
        CFrame.new(1.046, -0.154, -17.719) * CFrame.Angles(0, -1.5707963267948966, 0),
        CFrame.new(2.542, -0.154, -32.563) * CFrame.Angles(0, 1.5707963267948966, 0),
        CFrame.new(1.046, -0.154, -34.175) * CFrame.Angles(0, -1.5707963267948966, 0),
        CFrame.new(-0.457, 0.247, 44.869) * CFrame.Angles(0, -1.5707963267948966, 0)
    };

    local function DashEffect(p176) -- Line: 1080
        -- upvalues: EffectsHandler (ref), CFrame2 (copy), u175 (copy), AttackerPlayer (copy), TargetClone (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            VFXForgeEmit = true,
            Path = "Particles/Beatdown/Dash",
            Origin = CFrame2 * u175[p176],
            Player = AttackerPlayer
        });
        local v177 = TargetClone and TargetClone:FindFirstChild("HumanoidRootPart");

        if v177 then
            EffectsHandler.CallEffect("Emit Particle V3", {
                VFXForgeEmit = true,
                Path = "Particles/Beatdown/Hit",
                Player = AttackerPlayer,
                Origin = v177
            });
        end;
    end;

    local u178 = nil;
    local u179 = nil;
    local v451 = {
        { 0, function() -- Line: 1109
                -- upvalues: u178 (ref), Trove (copy), AssetHandler (ref), u26 (copy), ParticleHandler (ref), u25 (copy), AttackerClone (copy), Load (copy), TargetClone (copy), u27 (copy), u38 (copy), PlaySyncedTrack (copy), u98 (copy), RunService (ref), CameraUpdate (copy), CurrentCamera (ref), u179 (ref)
                u178 = Trove:Add(AssetHandler.CloneAsset("Models/Atoms", u26));

                for _, v in { "atacker", "e" } do
                    local v180 = u178:FindFirstChild(v);

                    if v180 then
                        ParticleHandler.Unusualify(v180, {
                            IncludeParts = true,
                            IncludeTextures = true,
                            IncludeSurfaces = true,
                            HSVData = u25
                        });
                    end;
                end;

                u178.PrimaryPart.CFrame = AttackerClone.PrimaryPart.CFrame * CFrame.new(0, 500, 0);
                u178.Parent = workspace.Effects;
                Load(u178, { "UGrain_Beatdown Atoms Start" });
                Load(AttackerClone, { "UGrain_Beatdown Attacker Start", "UGrain_Beatdown Attacker End" });
                Load(TargetClone, { "UGrain_Beatdown Target Start", "UGrain_Beatdown Target End" });
                Load(u27, { "UGrain_Beatdown Camera Start", "UGrain_Beatdown Camera End", "UGrain_Beatdown Camera Wormhole 1", "UGrain_Beatdown Camera Wormhole 2" });
                local v181 = u38;

                for _, v in { "UGrain_Beatdown Camera Start", "UGrain_Beatdown Attacker Start", "UGrain_Beatdown Target Start", "UGrain_Beatdown Atoms Start" } do
                    PlaySyncedTrack(u98[v], v181, 0, 0);
                end;

                RunService:BindToRenderStep("UGrain Camera", Enum.RenderPriority.Camera.Value, CameraUpdate);
                CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                Trove:Add(function() -- Line: 1146
                    -- upvalues: RunService (ref), CurrentCamera (ref)
                    RunService:UnbindFromRenderStep("UGrain Camera");
                    CurrentCamera.CameraType = Enum.CameraType.Custom;
                end);
                local v182 = AttackerClone and AttackerClone:FindFirstChild("Torso");

                if v182 then
                    u179 = AssetHandler.CloneAsset("Particles/Beatdown/BodyTrail", u26);
                    ParticleHandler.Unusualify(u179, {
                        HSVData = u25
                    });
                    u179.Parent = AttackerClone;
                    ParticleHandler.AttachTo(u179, {
                        Part = v182
                    });
                end;
            end },
        { 4, function() -- Line: 1160
                -- upvalues: DashEffect (copy)
                DashEffect(1);
            end },
        { 79, function() -- Line: 1161
                -- upvalues: DashEffect (copy)
                DashEffect(2);
            end },
        { 145, function() -- Line: 1162
                -- upvalues: DashEffect (copy)
                DashEffect(3);
            end },
        { 237, function(p183) -- Line: 1164
                -- upvalues: AttackerClone (copy), EffectsHandler (ref), AttackerPlayer (copy)
                local v184 = AttackerClone and AttackerClone:FindFirstChild("HumanoidRootPart");

                if not v184 then
                    return;
                end;

                EffectsHandler.CallEffect("Emit Particle V3", {
                    VFXForgeEmit = true,
                    Path = "Particles/Beatdown/WhirlStart",
                    Player = AttackerPlayer,
                    Origin = v184
                });
                EffectsHandler.CallEffect("UGrain Tornado", {
                    Scalar = 0.4,
                    Origin = CFrame.new(v184.Position),
                    Player = AttackerPlayer,
                    Duration = math.max(0, 1.05 - p183)
                });
            end },
        { 434, function() -- Line: 1183
                -- upvalues: DashEffect (copy)
                DashEffect(4);
            end },
        { 345, function() -- Line: 1185
                -- upvalues: AttackerClone (copy), Trove (copy), AssetHandler (ref), u26 (copy), ParticleHandler (ref), u25 (copy), CFrame2 (copy), u14 (ref), u24 (ref), TweenService (ref)
                local v185 = AttackerClone and AttackerClone:FindFirstChild("Right Leg");

                if not v185 then
                    return;
                end;

                local u186 = Trove:Add(AssetHandler.CloneAsset("Particles/Beatdown/LegCharge", u26));
                ParticleHandler.Unusualify(u186, {
                    HSVData = u25
                });
                u186.Parent = AttackerClone;
                ParticleHandler.AttachTo(u186, {
                    Part = v185
                });
                local u187 = Trove:Add(AssetHandler.CloneAsset("Particles/Beatdown/Charge", u26));
                ParticleHandler.Unusualify(u187, {
                    HSVData = u25
                });
                u187.CFrame = CFrame2;
                u187.Parent = AttackerClone;
                local u188 = Trove:Construct(Instance, "Highlight");
                u188.DepthMode = Enum.HighlightDepthMode.Occluded;
                u188.FillColor = ParticleHandler.TryHSVShift(u14[u24.SkinName or "Default"] or u14.Default, u25);
                u188.OutlineTransparency = 1;
                u188.FillTransparency = 1;
                u188.Parent = v185;
                TweenService:Create(u188, TweenInfo.new(1.5166666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    FillTransparency = -0.5
                }):Play();
                task.delay(1.5166666666666666, function() -- Line: 1212
                    -- upvalues: u186 (copy), ParticleHandler (ref), u187 (copy), u188 (copy)
                    if u186 and u186.Parent then
                        ParticleHandler.EnableAllParticles(u186, false);
                    end;

                    if u187 and u187.Parent then
                        ParticleHandler.EnableAllParticles(u187, false);
                    end;

                    if u188 and u188.Parent then
                        u188:Destroy();
                    end;
                end);
            end },
        { 389, function(p189) -- Line: 1219
                -- upvalues: u38 (copy), EffectsHandler (ref), Trove (copy), u174 (ref), TweenService (ref), LocalPlayer (ref), WaitUntilTime (copy), ParticleHandler (ref), u25 (copy)
                local v190 = math.max(0.001, 0.6833333333333333 - p189);
                local v191 = os.clock() - u38;
                local v192 = 7.416666666666667 - math.max(v191, 7.3);
                local u193 = math.max(0.001, v192);
                EffectsHandler.CallEffect("HyperFOV", {
                    EndFOV = 178,
                    WaitTime = 0.13333333333333333,
                    TimeIn = v190,
                    TimeOut = u193
                });
                local CFrameValue = Instance.new("CFrameValue");
                CFrameValue.Value = CFrame.identity;
                Trove:Add(CFrameValue.Changed:Connect(function(p194) -- Line: 1229
                    -- upvalues: u174 (ref)
                    u174 = p194;
                end));
                local v195 = TweenService:Create(CFrameValue, TweenInfo.new(v190, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Value = CFrame.new(0, 0.34, -0.785)
                });
                v195:Play();
                v195.Completed:Connect(function() -- Line: 1235
                    -- upvalues: CFrameValue (copy), TweenService (ref), u193 (copy), u174 (ref)
                    task.delay(0.13333333333333333, function() -- Line: 1236
                        -- upvalues: CFrameValue (ref), TweenService (ref), u193 (ref), u174 (ref)
                        if not (CFrameValue and CFrameValue.Parent) then
                            return;
                        end;

                        local v196 = TweenService:Create(CFrameValue, TweenInfo.new(u193, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                            Value = CFrame.identity
                        });
                        v196:Play();
                        v196.Completed:Connect(function() -- Line: 1242
                            -- upvalues: u174 (ref), CFrameValue (ref)
                            u174 = CFrame.identity;

                            if CFrameValue and CFrameValue.Parent then
                                CFrameValue:Destroy();
                            end;
                        end);
                    end);
                end);
                local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

                if PlayerGui then
                    PlayerGui = PlayerGui:FindFirstChild("CinematicLetterbox");
                end;

                if not PlayerGui then
                    return;
                end;

                local TopBar = PlayerGui:FindFirstChild("TopBar");
                local BottomBar = PlayerGui:FindFirstChild("BottomBar");

                if not (TopBar and BottomBar) then
                    return;
                end;

                local v197 = TweenInfo.new(v190, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                TweenService:Create(TopBar, v197, {
                    Size = UDim2.fromScale(1, 0.18)
                }):Play();
                TweenService:Create(BottomBar, v197, {
                    Size = UDim2.fromScale(1, 0.18)
                }):Play();
                task.spawn(function() -- Line: 1260
                    -- upvalues: u38 (ref), WaitUntilTime (ref), TopBar (copy), BottomBar (copy), u193 (copy), TweenService (ref), EffectsHandler (ref), ParticleHandler (ref), u25 (ref)
                    WaitUntilTime((u38 or u38) + 7.3);

                    if not (TopBar.Parent and BottomBar.Parent) then
                        return;
                    end;

                    local v198 = TweenInfo.new(u193 * 0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
                    TweenService:Create(TopBar, v198, {
                        Size = UDim2.fromScale(1, 0.105)
                    }):Play();
                    TweenService:Create(BottomBar, v198, {
                        Size = UDim2.fromScale(1, 0.105)
                    }):Play();
                    EffectsHandler.CallEffect("Vignette Gui", {
                        TweenTime = 0.2,
                        Blur = 8,
                        StartingColor = ParticleHandler.TryHSVShift(Color3.new(0.137255, 0.415686, 0.862745), u25),
                        EndingColor = ParticleHandler.TryHSVShift(Color3.new(0.0784314, 0.419608, 0.862745), u25)
                    });
                end);
            end },
        { 427, function() -- Line: 1275
            end },
        { 472, function() -- Line: 1280
                -- upvalues: u174 (ref), Trove (copy), ParticleHandler (ref), u14 (ref), u24 (ref), u25 (copy), AttackerClone (copy), CFrame2 (copy), WaitUntilTime (copy), u38 (copy), AssetHandler (ref), u26 (copy), HumanoidRootPart (copy), TargetClone (copy), EffectsHandler (ref), u1 (ref), RunService (ref)
                u174 = CFrame.new(0, 0, 3.5);
                task.delay(1.6666666666666667, function() -- Line: 1284
                    -- upvalues: u174 (ref)
                    u174 = CFrame.identity;
                end);
                local u199 = Trove:Construct(Instance, "Highlight");
                u199.DepthMode = Enum.HighlightDepthMode.Occluded;
                u199.FillColor = ParticleHandler.TryHSVShift(u14[u24.SkinName or "Default"] or u14.SkinName, u25);
                u199.OutlineTransparency = 1;
                u199.FillTransparency = -0.7;
                u199.Parent = AttackerClone;
                task.delay(1.6666666666666667, function() -- Line: 1292
                    -- upvalues: u199 (copy)
                    if u199 and u199.Parent then
                        u199:Destroy();
                    end;
                end);
                local u200 = {};
                local Map = workspace:FindFirstChild("Map");

                if Map then
                    local v201 = OverlapParams.new();
                    v201.FilterType = Enum.RaycastFilterType.Include;
                    v201.FilterDescendantsInstances = { Map };
                    v201.MaxParts = 0;

                    for _, v in workspace:GetPartBoundsInRadius(CFrame2.Position, 50, v201) do
                        if v:IsA("BasePart") then
                            u200[v] = v.LocalTransparencyModifier;
                            v.LocalTransparencyModifier = 1;
                        end;
                    end;
                end;

                local u202 = Trove:Extend();
                task.spawn(function() -- Line: 1313
                    -- upvalues: WaitUntilTime (ref), u38 (ref), u202 (copy)
                    WaitUntilTime(u38 + 1.6666666666666667);
                    u202:Destroy();
                end);
                u202:Add(function() -- Line: 1317
                    -- upvalues: u200 (copy)
                    for i, v in u200 do
                        if i.Parent then
                            i.LocalTransparencyModifier = v;
                        end;
                    end;
                end);
                local v203 = u202:Add(AssetHandler.CloneAsset("Particles/Beatdown/Backdrop", u26));
                ParticleHandler.Unusualify(v203, {
                    HSVData = u25
                });
                v203.CFrame = HumanoidRootPart.CFrame;
                v203.Parent = workspace.Effects;

                if TargetClone and TargetClone.Parent then
                    EffectsHandler.CallEffect("SK_VANISH", {
                        Transparency = 1,
                        AffectStands = true,
                        Character = TargetClone,
                        TweenInfo = { 0 }
                    });
                end;

                local function NewOff() -- Line: 1334
                    -- upvalues: u1 (ref)
                    local v204 = u1:NextNumber(-15, 15);
                    local v205 = u1:NextNumber(-15, 15);

                    return Vector3.new(v204, v205, u1:NextNumber(25, 50));
                end;

                local u206 = table.create(10);

                for i = 1, 10 do
                    local v207 = u202:Add(AssetHandler.CloneAsset("Particles/Beatdown/Wormhole/Streak", u26));
                    ParticleHandler.Unusualify(v207, {
                        HSVData = u25
                    });
                    ParticleHandler.EnableAllParticles(v207, false);
                    v207.Parent = workspace.Effects;
                    local v208 = u1:NextNumber(0.05, 0.125);
                    local Attachment0 = v207:FindFirstChild("Attachment0");
                    local Attachment1 = v207:FindFirstChild("Attachment1");

                    if Attachment0 then
                        Attachment0.Position = Vector3.new(0, v208, 0);
                    end;

                    if Attachment1 then
                        Attachment1.Position = Vector3.new(0, -v208, 0);
                    end;

                    local v209 = {
                        Active = false,
                        Part = v207
                    };
                    local v210 = u1:NextNumber(-15, 15);
                    local v211 = u1:NextNumber(-15, 15);
                    v209.Off = Vector3.new(v210, v211, u1:NextNumber(25, 50));
                    u206[i] = v209;
                end;

                local u212 = os.clock();
                u202:Connect(RunService.RenderStepped, function(p213) -- Line: 1358
                    -- upvalues: u212 (copy), u202 (copy), HumanoidRootPart (ref), u206 (copy), ParticleHandler (ref), u1 (ref)
                    if os.clock() - u212 >= 1.6666666666666667 then
                        u202:Destroy();

                        return;
                    end;

                    local v214 = HumanoidRootPart.CFrame * CFrame.new(15, 0, 0);
                    local Position = v214.Position;
                    local LookVector = v214.LookVector;
                    local RightVector = v214.RightVector;
                    local UpVector = v214.UpVector;
                    local v215 = 800 * p213;

                    for _, v in u206 do
                        if v.Part.Parent then
                            local v216 = v.Off.Z - v215;

                            if not v.Active then
                                v.Active = true;
                                ParticleHandler.EnableAllParticles(v.Part, true);
                            end;

                            if v216 < -15 then
                                local v217 = u1:NextNumber(-15, 15);
                                local v218 = u1:NextNumber(-15, 15);
                                v.Off = Vector3.new(v217, v218, u1:NextNumber(25, 50));
                                v216 = v.Off.Z;
                                v.Active = false;
                                ParticleHandler.EnableAllParticles(v.Part, false);
                            end;

                            v.Off = Vector3.new(v.Off.X, v.Off.Y, v216);
                            v.Part.Position = Position + LookVector * v216 + RightVector * v.Off.X + UpVector * v.Off.Y;
                        end;
                    end;
                end);
            end },
        { 567, function() -- Line: 1392
                -- upvalues: RunService (ref), u37 (copy), SpeedBeams (copy), ParticleHandler (ref), TargetClone (copy), EffectsHandler (ref), Trove (copy), Snapshot (ref), Lighting (ref), TweenService (ref), AssetHandler (ref), u26 (copy), u25 (copy), u1 (ref), CurrentCamera (ref)
                RunService:UnbindFromRenderStep("UGrain Camera");

                if u37 and u37.Parent then
                    u37.Enabled = false;
                end;

                if SpeedBeams then
                    ParticleHandler.EnableAllParticles(SpeedBeams, true);
                end;

                if TargetClone and TargetClone.Parent then
                    EffectsHandler.CallEffect("SK_VANISH", {
                        Transparency = 0,
                        AffectStands = true,
                        Character = TargetClone
                    });
                end;

                local v219 = Trove:Extend();
                task.delay(2.1166666666666667, v219.Destroy, v219);
                local u220 = Snapshot(Lighting, { "Ambient", "OutdoorAmbient", "Brightness" });
                v219:Add(function() -- Line: 1410
                    -- upvalues: u220 (copy), u37 (ref)
                    u220();

                    if u37 and u37.Parent then
                        u37.Enabled = true;
                    end;
                end);
                Lighting.Ambient = Color3.fromRGB(255, 255, 255);
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255);
                Lighting.Brightness = 0;
                local u221 = v219:Add(Instance.new("BloomEffect"));
                u221.Size = 48;
                u221.Threshold = 0.9;
                u221.Intensity = 0.4;
                u221.Parent = Lighting;
                local u222 = v219:Add(Instance.new("ColorCorrectionEffect"));
                u222.TintColor = Color3.new(0, 0, 0);
                u222.Brightness = -1;
                u222.Saturation = 0.3;
                u222.Parent = Lighting;
                local u223 = v219:Add(Instance.new("BlurEffect"));
                u223.Size = 0;
                u223.Parent = Lighting;
                TweenService:Create(u222, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Brightness = 0,
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
                local Atmosphere = Lighting:FindFirstChild("Atmosphere");

                if Atmosphere then
                    local v224 = Snapshot(Atmosphere, { "Glare", "Haze" });
                    Atmosphere.Glare = 0;
                    Atmosphere.Haze = 0;
                    v219:Add(v224);
                end;

                local v225 = v219:Add(AssetHandler.CloneAsset("Particles/Beatdown/Global/Sky", u26));
                ParticleHandler.Unusualify(v225, {
                    HSVData = u25
                });
                v225.Parent = Lighting;
                local u226 = v219:Add(AssetHandler.CloneAsset("Particles/Beatdown/Global/Earth", u26));
                ParticleHandler.EnableAllParticles(u226, false);
                u226.CFrame = CFrame.new(1000, 5000, 1000) * CFrame.Angles(0, 1.0471975511965976, 0);
                u226.Parent = workspace.Effects;
                local Position = u226.Position;
                local u227 = u226.Size.X / 2 + 2;
                local u228 = u227 + 4;
                local v229 = v219:Add(Instance.new("Folder"));
                v229.Name = "GlobeStars";
                v229.Parent = workspace.Effects;
                local u230 = table.create(80);

                for i = 1, 80 do
                    local v231 = Color3.fromHSV(u1:NextNumber(0.55, 0.72), u1:NextNumber(0, 0.25), 1);
                    local v232 = {
                        Shape = Enum.PartType.Ball,
                        Size = Vector3.new(1, 1, 1) * u1:NextNumber(0.5, 2),
                        Material = Enum.Material.Neon,
                        Color = v231,
                        Transparency = u1:NextNumber(0.15, 0.55)
                    };
                    local Part = Instance.new("Part");
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanQuery = false;
                    Part.CanTouch = false;
                    Part.CastShadow = false;

                    for i2, v in v232 do
                        Part[i2] = v;
                    end;

                    local v233 = u1:NextNumber(0, 6.283185307179586);
                    local v234 = u1:NextNumber(-0.7, 0.7);
                    local v235 = math.cos(v233) * math.cos(v234);
                    local v236 = math.sin(v234);
                    local v237 = math.sin(v233) * math.cos(v234);
                    Part.Position = Position + Vector3.new(v235, v236, v237) * u1:NextNumber(220, 480);
                    Part.Parent = v229;
                    local BillboardGui = Instance.new("BillboardGui");
                    BillboardGui.Adornee = Part;
                    BillboardGui.Size = UDim2.fromScale(u1:NextNumber(8, 18), u1:NextNumber(8, 18));
                    BillboardGui.AlwaysOnTop = false;
                    BillboardGui.LightInfluence = 0;
                    BillboardGui.Parent = Part;
                    local ImageLabel = Instance.new("ImageLabel");
                    ImageLabel.Size = UDim2.fromScale(1, 1);
                    ImageLabel.BackgroundTransparency = 1;
                    ImageLabel.Image = "rbxasset://textures/particles/sparkles_main.dds";
                    ImageLabel.ImageColor3 = v231;
                    ImageLabel.ImageTransparency = 0.3;
                    ImageLabel.Parent = BillboardGui;
                    u230[i] = {
                        Part = Part,
                        Halo = ImageLabel,
                        BaseT = Part.Transparency,
                        Phase = u1:NextNumber(0, 6.283185307179586),
                        Speed = u1:NextNumber(2, 5)
                    };
                end;

                local v238 = v219:Add(Instance.new("Folder"));
                v238.Name = "SolarSystem";
                v238.Parent = workspace.Effects;
                local v239 = {
                    Size = Vector3.new(120, 120, 120),
                    Shape = Enum.PartType.Ball,
                    Material = Enum.Material.Neon,
                    Color = Color3.fromRGB(255, 230, 160),
                    Position = Position + Vector3.new(-1200, 180, 600)
                };
                local Part = Instance.new("Part");
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanQuery = false;
                Part.CanTouch = false;
                Part.CastShadow = false;

                for i, v in v239 do
                    Part[i] = v;
                end;

                Part.Parent = v238;
                local v240 = {
                    Size = Vector3.new(180, 180, 180),
                    Transparency = 0.75,
                    Shape = Enum.PartType.Ball,
                    Material = Enum.Material.Neon,
                    Color = Color3.fromRGB(255, 200, 120),
                    Position = Part.Position
                };
                local Part2 = Instance.new("Part");
                Part2.Anchored = true;
                Part2.CanCollide = false;
                Part2.CanQuery = false;
                Part2.CanTouch = false;
                Part2.CastShadow = false;

                for i, v in v240 do
                    Part2[i] = v;
                end;

                Part2.Parent = v238;
                local v241 = {
                    {
                        Size = 18,
                        Radius = 380,
                        Speed = 0.35,
                        Angle = 0,
                        Tilt = 0.15,
                        Color = Color3.fromRGB(180, 130, 90)
                    },
                    {
                        Size = 32,
                        Radius = 540,
                        Speed = 0.26,
                        Angle = 1.2566370614359172,
                        Tilt = -0.08,
                        Color = Color3.fromRGB(220, 180, 120)
                    },
                    {
                        Size = 28,
                        Radius = 700,
                        Speed = 0.19,
                        Angle = 3.455751918948773,
                        Tilt = 0.22,
                        Color = Color3.fromRGB(190, 100, 70)
                    },
                    {
                        Size = 75,
                        Radius = 920,
                        Speed = 0.12,
                        Angle = 5.340707511102648,
                        Tilt = -0.1,
                        HasRing = true,
                        Color = Color3.fromRGB(210, 180, 140)
                    },
                    {
                        Size = 42,
                        Radius = 1100,
                        Speed = 0.08,
                        Angle = 2.199114857512855,
                        Tilt = 0.3,
                        Color = Color3.fromRGB(120, 180, 220)
                    }
                };
                local u242 = table.create(#v241);

                for i, v in v241 do
                    local v243 = {
                        Shape = Enum.PartType.Ball,
                        Size = Vector3.new(1, 1, 1) * v.Size,
                        Material = Enum.Material.SmoothPlastic,
                        Color = v.Color
                    };
                    local Part3 = Instance.new("Part");
                    Part3.Anchored = true;
                    Part3.CanCollide = false;
                    Part3.CanQuery = false;
                    Part3.CanTouch = false;
                    Part3.CastShadow = false;

                    for i2, v2 in v243 do
                        Part3[i2] = v2;
                    end;

                    Part3.Parent = v238;
                    local v244;

                    if v.HasRing then
                        local v245 = {
                            Transparency = 0.35,
                            Shape = Enum.PartType.Cylinder,
                            Size = Vector3.new(2, v.Size * 2.4, v.Size * 2.4),
                            Material = Enum.Material.SmoothPlastic,
                            Color = Color3.fromRGB(200, 170, 130)
                        };
                        v244 = Instance.new("Part");
                        v244.Anchored = true;
                        v244.CanCollide = false;
                        v244.CanQuery = false;
                        v244.CanTouch = false;
                        v244.CastShadow = false;

                        for i2, v2 in v245 do
                            v244[i2] = v2;
                        end;

                        v244.Parent = v238;
                    else
                        v244 = nil;
                    end;

                    u242[i] = {
                        Part = Part3,
                        Ring = v244,
                        Radius = v.Radius,
                        Speed = v.Speed,
                        StartAngle = v.Angle,
                        Tilt = v.Tilt,
                        SelfSpin = u1:NextNumber(0.3, 0.8) * (u1:NextInteger(0, 1) == 0 and -1 or 1),
                        SelfSpinAngle = u1:NextNumber(0, 6.283185307179586)
                    };
                end;

                local v246 = v219:Add(Instance.new("Folder"));
                v246.Name = "SpeedStreaks";
                v246.Parent = workspace.Effects;
                local u247 = table.create(35);
                local u248 = 0;

                for i = 1, 35 do
                    local v249 = u1:NextNumber(8, 25);
                    local v250 = {
                        Transparency = 1,
                        Size = Vector3.new(0.25, 0.25, v249),
                        Material = Enum.Material.Neon,
                        Color = Color3.fromHSV(u1:NextNumber(0.55, 0.65), u1:NextNumber(0.1, 0.3), 1)
                    };
                    local Part3 = Instance.new("Part");
                    Part3.Anchored = true;
                    Part3.CanCollide = false;
                    Part3.CanQuery = false;
                    Part3.CanTouch = false;
                    Part3.CastShadow = false;

                    for i2, v in v250 do
                        Part3[i2] = v;
                    end;

                    Part3.Parent = v246;
                    u247[i] = {
                        Part = Part3,
                        Lateral = Vector2.new(u1:NextNumber(-30, 30), u1:NextNumber(-20, 20)),
                        Forward = u1:NextNumber(20, 200),
                        BaseT = u1:NextNumber(0.2, 0.55),
                        Length = v249
                    };
                end;

                local u251 = v219:Add(AssetHandler.CloneAsset("Particles/Beatdown/Global/Trail", u26));
                ParticleHandler.Unusualify(u251, {
                    HSVData = u25
                });
                ParticleHandler.EnableAllParticles(u251, false);
                u251.CFrame = CFrame.new(Position) * CFrame.new(0, 0, -u227) * CFrame.Angles(0, 1.5707963267948966, 0);
                u251.Parent = workspace.Effects;
                TweenService:Create(u226, TweenInfo.new(2.1166666666666667, Enum.EasingStyle.Linear), {
                    CFrame = u226.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)
                }):Play();
                ParticleHandler.EnableAllParticles(u226, true);
                ParticleHandler.EnableAllParticles(u251, true);
                EffectsHandler.Wait(0.15);
                local u252 = os.clock();
                v219:Connect(RunService.RenderStepped, function(p253) -- Line: 1611
                    -- upvalues: u252 (copy), u230 (copy), u248 (ref), Part2 (copy), u242 (copy), Position (copy), u251 (copy), u227 (copy), u228 (copy), CurrentCamera (ref), u247 (copy), u1 (ref)
                    local v254 = os.clock() - u252;
                    local v255 = math.clamp(v254 / 1.9666666666666668, 0, 1);

                    for _, v in u230 do
                        if v.Part and v.Part.Parent then
                            local v256 = (math.sin(v254 * v.Speed + v.Phase) + 1) * 0.5;
                            v.Part.Transparency = v.BaseT * (v256 * 0.6 + 0.4);

                            if v.Halo and v.Halo.Parent then
                                v.Halo.ImageTransparency = math.lerp(0.6, 0.15, v256);
                            end;
                        end;
                    end;

                    u248 = u248 + p253;

                    if Part2 and Part2.Parent then
                        Part2.Size = Vector3.new(1, 1, 1) * ((math.sin(u248 * 2.5) * 0.04 + 1) * 180);
                        Part2.Transparency = math.sin(u248 * 3) * 0.08 + 0.75;
                    end;

                    for _, v in u242 do
                        if v.Part and v.Part.Parent then
                            local v257 = v.StartAngle + v254 * v.Speed;
                            local Position2 = (CFrame.new(Position) * CFrame.Angles(v.Tilt, v257, 0) * CFrame.new(0, 0, -v.Radius)).Position;
                            v.SelfSpinAngle = v.SelfSpinAngle + v.SelfSpin * p253;
                            local v258 = CFrame.new(Position2) * CFrame.Angles(0, v.SelfSpinAngle, 0);
                            v.Part.CFrame = v258;

                            if v.Ring and v.Ring.Parent then
                                v.Ring.CFrame = v258 * CFrame.Angles(0, 0, 1.5707963267948966);
                            end;
                        end;
                    end;

                    local v259 = (v255 * v255 * v255 * 0.9 + v255 * 0.1) * 5 * 3.141592653589793 * 2;

                    if u251 and u251.Parent then
                        u251.CFrame = CFrame.new(Position) * CFrame.Angles(0, v259, 0) * CFrame.new(0, 0, -u227) * CFrame.Angles(0, 1.5707963267948966, 0);
                    end;

                    local v260 = v255 ^ 6;
                    local v261 = v259 + math.lerp(0, -0.20943951023931956, v260);
                    local v262 = math.lerp(150, u228, v260);
                    local v263 = math.lerp(22, 0, v260);
                    local Position2 = (CFrame.new(Position) * CFrame.Angles(0, v261, 0) * CFrame.new(0, v263, -v262)).Position;
                    local v264 = Position:Lerp((CFrame.new(Position) * CFrame.Angles(0, v261 + 0.17453292519943295, 0) * CFrame.new(0, v263, -v262)).Position, v260);
                    local v265 = Position2 + (Position2 - Position).Unit * (v262 * (v255 > 0.9 and ((v255 - 0.9) / 0.1 * 0.15 or 0) or 0));
                    local v266;

                    if v255 < 0.55 then
                        local v267 = math.clamp(v255 / 0.55, 0, 1);
                        v266 = math.lerp(70, 60, v267 * v267 * (3 - 2 * v267));
                    elseif v255 < 0.75 then
                        local v268 = (v255 - 0.55) / 0.2;
                        v266 = math.lerp(60, 120, v268 * v268);
                    elseif v255 < 0.88 then
                        v266 = math.lerp(120, 85, (v255 - 0.75) / 0.13);
                    else
                        local v269 = (v255 - 0.88) / 0.12;
                        v266 = math.lerp(85, 5, v269 * v269 * v269);
                    end;

                    CurrentCamera.FieldOfView = v266;
                    CurrentCamera.CFrame = CFrame.lookAt(v265, v264, Vector3.new(0, 1, 0)) * CFrame.Angles(0, 0, v255 ^ 3 * 0.15707963267948966);
                    local CFrame3 = CurrentCamera.CFrame;
                    local Position3 = CFrame3.Position;
                    local LookVector = CFrame3.LookVector;
                    local RightVector = CFrame3.RightVector;
                    local UpVector = CFrame3.UpVector;
                    local v270 = math.max(0, (v260 - 0.15) / 0.85);
                    local v271 = (v260 * 600 + 60) * p253;

                    for _, v in u247 do
                        if v.Part and v.Part.Parent then
                            v.Forward = v.Forward - v271;

                            if v.Forward < 5 then
                                v.Forward = u1:NextNumber(120, 220);
                                v.Lateral = Vector2.new(u1:NextNumber(-30, 30), u1:NextNumber(-20, 20));
                            end;

                            local v272 = Position3 + LookVector * v.Forward + RightVector * v.Lateral.X + UpVector * v.Lateral.Y;
                            v.Part.CFrame = CFrame.lookAt(v272, v272 + LookVector);
                            v.Part.Transparency = math.lerp(1, v.BaseT, v270);
                        end;
                    end;
                end);
                task.delay(1.6716666666666666, function() -- Line: 1696
                    -- upvalues: u226 (copy), u221 (copy), TweenService (ref), u222 (copy)
                    if not (u226 and u226.Parent) then
                        return;
                    end;

                    if u221 and u221.Parent then
                        TweenService:Create(u221, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Intensity = 2.4,
                            Threshold = 0.5
                        }):Play();
                    end;

                    if u222 and u222.Parent then
                        TweenService:Create(u222, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Saturation = 0.65,
                            Brightness = 0.15
                        }):Play();
                    end;
                end);
                task.delay(1.7866666666666668, function() -- Line: 1711
                    -- upvalues: u226 (copy), u223 (copy), TweenService (ref)
                    if not (u226 and (u226.Parent and (u223 and u223.Parent))) then
                        return;
                    end;

                    local v273 = TweenService:Create(u223, TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Size = 36
                    });
                    v273:Play();
                    v273.Completed:Connect(function() -- Line: 1717
                        -- upvalues: u223 (ref), TweenService (ref)
                        if u223 and u223.Parent then
                            TweenService:Create(u223, TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Size = 0
                            }):Play();
                        end;
                    end);
                end);

                repeat
                    task.wait();
                until os.clock() - u252 >= 1.9666666666666668;
            end },
        { 691, function() -- Line: 1729
                -- upvalues: RunService (ref), CameraUpdate (copy), AttackerClone (copy), Attacker (copy), Target (copy), u14 (ref), u24 (ref), EffectsHandler (ref), ParticleHandler (ref), u25 (copy)
                RunService:BindToRenderStep("UGrain Camera", Enum.RenderPriority.Camera.Value, CameraUpdate);
                task.spawn(function() -- Line: 1733
                    -- upvalues: AttackerClone (ref), Attacker (ref), Target (ref), u14 (ref), u24 (ref), EffectsHandler (ref), ParticleHandler (ref), u25 (ref), RunService (ref)
                    local v274 = AttackerClone and AttackerClone:FindFirstChild("Torso");

                    if not v274 then
                        return;
                    end;

                    local v275 = os.clock();
                    local Position = v274.Position;
                    local v276 = 0;

                    while true do
                        if not (Attacker.Parent and Target.Parent) or (not AttackerClone.Parent or (not v274.Parent or os.clock() - v275 >= 0.7333333333333333)) then
                            return;
                        end;

                        local v277 = os.clock();
                        local Position2 = v274.Position;

                        if (Position2 - Position).Magnitude >= 2 and v277 - v276 >= 0.035 then
                            local v278 = u14[u24.SkinName or "Default"] or u14.Default;
                            EffectsHandler.CallEffect("Byee_Afterimage", {
                                Lifetime = 0.5,
                                IsHighlight = true,
                                FillTransparency = 0.2,
                                OutlineTransparency = 0.1,
                                Character = AttackerClone,
                                FillColor = ParticleHandler.TryHSVShift(v278, u25),
                                OutlineColor = ParticleHandler.TryHSVShift(v278, u25),
                                DepthMode = Enum.HighlightDepthMode.Occluded
                            });
                        else
                            v277 = v276;
                            Position2 = Position;
                        end;

                        RunService.Heartbeat:Wait();
                        v276 = v277;
                        Position = Position2;
                    end;
                end);
            end },
        { 745, function() -- Line: 1763
                -- upvalues: SpeedBeams (copy), ParticleHandler (ref), u179 (ref), u38 (copy), WaitUntilTime (copy)
                if SpeedBeams then
                    ParticleHandler.EnableAllParticles(SpeedBeams, false);
                end;

                local u279 = {};

                if u179 and u179.Parent then
                    for _, descendant in u179:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            u279[descendant] = descendant.TimeScale;
                            descendant.TimeScale = 0.05;
                        end;
                    end;
                end;

                task.spawn(function() -- Line: 1774
                    -- upvalues: u38 (ref), WaitUntilTime (ref), u279 (copy)
                    WaitUntilTime((u38 or u38) + 14.25);

                    for i, v in u279 do
                        if i.Parent then
                            i.TimeScale = v;
                        end;
                    end;
                end);
            end },
        { 747, function() -- Line: 1782
            end },
        { 855, function() -- Line: 1786
                -- upvalues: SpeedBeams (copy), ParticleHandler (ref)
                if SpeedBeams then
                    ParticleHandler.EnableAllParticles(SpeedBeams, true);
                end;
            end },
        { 885, function() -- Line: 1790
                -- upvalues: u178 (ref), Trove (copy), ParticleHandler (ref), u25 (copy), u1 (ref), RunService (ref), Attacker (copy), Target (copy)
                if not (u178 and u178.Parent) then
                    return;
                end;

                local atacker = u178:FindFirstChild("atacker");

                if not atacker then
                    return;
                end;

                local u280 = Trove:Extend();
                local u281 = ParticleHandler.TryHSVShift(Color3.fromRGB(81, 119, 173), u25);
                local u282 = {};

                for _, child in atacker:GetChildren() do
                    if child:IsA("BasePart") then
                        table.insert(u282, child);
                    end;
                end;

                local u283 = #u282;
                local u284 = {};

                for i, v in u282 do
                    local v285 = {};

                    for i2, v2 in u282 do
                        if i ~= i2 then
                            table.insert(v285, {
                                Atom = v2,
                                Dist = (v.Position - v2.Position).Magnitude
                            });
                        end;
                    end;

                    table.sort(v285, function(p286, p287) -- Line: 1815
                        return p286.Dist < p287.Dist;
                    end);
                    local v288 = table.create((math.min(5, #v285)));

                    for i2 = 1, math.min(5, #v285) do
                        v288[i2] = v285[i2].Atom;
                    end;

                    u284[v] = v288;
                end;

                local u289 = u280:Add(Instance.new("Folder"));
                u289.Name = "AtomLightning";
                u289.Parent = workspace.Effects;

                local function CreateSegment() -- Line: 1831
                    -- upvalues: u281 (copy), u289 (copy)
                    local v290 = {
                        Transparency = 1,
                        Size = Vector3.new(0.1, 0.1, 1),
                        Material = Enum.Material.Neon,
                        Color = u281
                    };
                    local Part = Instance.new("Part");
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanQuery = false;
                    Part.CanTouch = false;
                    Part.CastShadow = false;

                    for i, v in v290 do
                        Part[i] = v;
                    end;

                    Part.Parent = u289;

                    return Part;
                end;

                local u291 = 0;
                local u292 = {};

                for _ = 1, 80 do
                    u291 = u291 + 1;
                    local v293 = {
                        Transparency = 1,
                        Size = Vector3.new(0.1, 0.1, 1),
                        Material = Enum.Material.Neon,
                        Color = u281
                    };
                    local Part = Instance.new("Part");
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanQuery = false;
                    Part.CanTouch = false;
                    Part.CastShadow = false;

                    for i, v in v293 do
                        Part[i] = v;
                    end;

                    Part.Parent = u289;
                    u292[u291] = Part;
                end;

                local function GetSegment() -- Line: 1847
                    -- upvalues: u291 (ref), u292 (copy), u281 (copy), u289 (copy)
                    if u291 > 0 then
                        local v294 = u292[u291];
                        u292[u291] = nil;
                        u291 = u291 - 1;

                        return v294;
                    end;

                    local v295 = {
                        Transparency = 1,
                        Size = Vector3.new(0.1, 0.1, 1),
                        Material = Enum.Material.Neon,
                        Color = u281
                    };
                    local Part = Instance.new("Part");
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanQuery = false;
                    Part.CanTouch = false;
                    Part.CastShadow = false;

                    for i, v in v295 do
                        Part[i] = v;
                    end;

                    Part.Parent = u289;

                    return Part;
                end;

                local function ReturnSegment(p296) -- Line: 1857
                    -- upvalues: u291 (ref), u292 (copy)
                    if not (p296 and p296.Parent) then
                        return;
                    end;

                    p296.Transparency = 1;
                    u291 = u291 + 1;
                    u292[u291] = p296;
                end;

                local u297 = {};
                local u298 = 0;

                local function FireBolt(p299, p300) -- Line: 1867
                    -- upvalues: u298 (ref), u1 (ref), u291 (ref), u292 (copy), u281 (copy), u289 (copy), u297 (copy)
                    if u298 >= 60 then
                        return;
                    end;

                    local v301 = u1:NextInteger(1, 4);
                    local v302 = u1:NextNumber(0.06, 0.2);
                    local v303 = table.create(v301 - 1);

                    for i = 1, v301 - 1 do
                        v303[i] = {
                            T = i / v301,
                            Side1 = u1:NextNumber(-v302, v302),
                            Side2 = u1:NextNumber(-v302, v302)
                        };
                    end;

                    local v304 = table.create(v301);

                    for i = 1, v301 do
                        local v305;

                        if u291 > 0 then
                            v305 = u292[u291];
                            u292[u291] = nil;
                            u291 = u291 - 1;
                        else
                            local v306 = {
                                Transparency = 1,
                                Size = Vector3.new(0.1, 0.1, 1),
                                Material = Enum.Material.Neon,
                                Color = u281
                            };
                            v305 = Instance.new("Part");
                            v305.Anchored = true;
                            v305.CanCollide = false;
                            v305.CanQuery = false;
                            v305.CanTouch = false;
                            v305.CastShadow = false;

                            for i2, v in v306 do
                                v305[i2] = v;
                            end;

                            v305.Parent = u289;
                        end;

                        v304[i] = v305;
                    end;

                    u298 = u298 + 1;
                    u297[u298] = {
                        SourceAtom = p299,
                        TargetAtom = p300,
                        Offsets = v303,
                        Segments = v304,
                        Thickness = u1:NextNumber(0.08, 0.2),
                        Lifetime = u1:NextNumber(0.07, 0.15),
                        StartTime = os.clock(),
                        BaseTransparency = u1:NextNumber(0.05, 0.15)
                    };
                end;

                local function ReleaseBolt(p307) -- Line: 1896
                    -- upvalues: u291 (ref), u292 (copy)
                    for _, v in p307.Segments do
                        if v then
                            if v.Parent then
                                v.Transparency = 1;
                                u291 = u291 + 1;
                                u292[u291] = v;
                            end;
                        end;
                    end;
                end;

                local function UpdateBolt(p308, p309) -- Line: 1900
                    -- upvalues: u291 (ref), u292 (copy)
                    local v310 = (p309 - p308.StartTime) / p308.Lifetime;

                    if v310 >= 1 then
                        for _, v in p308.Segments do
                            if v then
                                if v.Parent then
                                    v.Transparency = 1;
                                    u291 = u291 + 1;
                                    u292[u291] = v;
                                end;
                            end;
                        end;

                        return false;
                    end;

                    local SourceAtom = p308.SourceAtom;
                    local TargetAtom = p308.TargetAtom;

                    if not (SourceAtom.Parent and TargetAtom.Parent) then
                        for _, v in p308.Segments do
                            if v then
                                if v.Parent then
                                    v.Transparency = 1;
                                    u291 = u291 + 1;
                                    u292[u291] = v;
                                end;
                            end;
                        end;

                        return false;
                    end;

                    local Position = SourceAtom.Position;
                    local v311 = TargetAtom.Position - Position;
                    local Magnitude = v311.Magnitude;

                    if Magnitude < 0.01 then
                        for _, v in p308.Segments do
                            if v and v.Parent then
                                v.Transparency = 1;
                            end;
                        end;

                        return true;
                    end;

                    local v312 = v311 / Magnitude;
                    local v313 = Vector3.new(v312.Z, 0, -v312.X);

                    if v313.Magnitude < 0.001 then
                        v313 = Vector3.new(0, v312.Z, -v312.Y);
                    end;

                    local Unit = v313.Unit;
                    local v314 = v312:Cross(Unit);
                    local v315 = v310 < 0.35 and p308.BaseTransparency or p308.BaseTransparency + (1 - p308.BaseTransparency) * ((v310 - 0.35) / 0.65);
                    local v316 = #p308.Segments;
                    local v317 = Position;

                    for i = 1, v316 do
                        local v318;

                        if i == v316 then
                            v318 = TargetAtom.Position;
                        else
                            local v319 = p308.Offsets[i];
                            local v320 = math.sin(v319.T * 3.141592653589793);
                            v318 = v317 + v311 * v319.T + Unit * (v319.Side1 * Magnitude * v320) + v314 * (v319.Side2 * Magnitude * v320);
                        end;

                        local v321 = math.max((v318 - Position).Magnitude, 0.01);
                        local v322 = p308.Segments[i];

                        if v322 and v322.Parent then
                            v322.Size = Vector3.new(p308.Thickness, p308.Thickness, v321);
                            v322.CFrame = CFrame.lookAt((Position + v318) * 0.5, v318);
                            v322.Transparency = v315;
                        end;

                        Position = v318;
                    end;

                    return true;
                end;

                u280:Connect(RunService.RenderStepped, function() -- Line: 1952
                    -- upvalues: u298 (ref), UpdateBolt (copy), u297 (copy)
                    if u298 == 0 then
                        return;
                    end;

                    local v323 = os.clock();

                    for i = u298, 1, -1 do
                        if not UpdateBolt(u297[i], v323) then
                            u297[i] = u297[u298];
                            u297[u298] = nil;
                            u298 = u298 - 1;
                        end;
                    end;
                end);
                u280:Add(function() -- Line: 1964
                    -- upvalues: u298 (ref), u297 (copy)
                    for i = 1, u298 do
                        for _, v in u297[i].Segments do
                            if v and v.Parent then
                                v.Transparency = 1;
                            end;
                        end;
                    end;

                    table.clear(u297);
                    u298 = 0;
                end);
                task.spawn(function() -- Line: 1974
                    -- upvalues: Attacker (ref), Target (ref), atacker (copy), u1 (ref), u283 (copy), u282 (copy), u284 (copy), FireBolt (copy), u298 (ref), RunService (ref), u280 (copy)
                    local v324 = os.clock();

                    while os.clock() - v324 < 3 and (Attacker.Parent and (Target.Parent and atacker.Parent)) do
                        task.wait(u1:NextNumber(0.025, 0.05));

                        if os.clock() - v324 >= 3 or not (Attacker.Parent and (Target.Parent and atacker.Parent)) then
                            break;
                        end;

                        if u283 ~= 0 then
                            for _ = 1, u1:NextInteger(1, 5) do
                                local v325 = u282[u1:NextInteger(1, u283)];
                                local v326 = u284[v325];

                                if v326 and #v326 > 0 then
                                    local v327 = v326[u1:NextInteger(1, #v326)];
                                    FireBolt(v325, v327);

                                    if u1:NextNumber() < 0.18 and #v326 > 1 then
                                        local v328;

                                        repeat
                                            v328 = v326[u1:NextInteger(1, #v326)];
                                        until v328 ~= v327;

                                        FireBolt(v325, v328);
                                    end;
                                end;
                            end;
                        end;
                    end;

                    while u298 > 0 and (Attacker.Parent and Target.Parent) do
                        RunService.RenderStepped:Wait();
                    end;

                    u280:Destroy();
                end);
            end },
        { 942, function() -- Line: 2006
                -- upvalues: SpeedBeams (copy), ParticleHandler (ref)
                if SpeedBeams then
                    ParticleHandler.EnableAllParticles(SpeedBeams, false);
                end;
            end },
        { 1058, function() -- Line: 2010
            end },
        { 1113, function() -- Line: 2014
                -- upvalues: AttackerClone (copy), EffectsHandler (ref), AttackerPlayer (copy), CFrame2 (copy)
                local v329 = AttackerClone and AttackerClone:FindFirstChild("HumanoidRootPart");

                if v329 then
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/PortalSpawn",
                        Player = AttackerPlayer,
                        Origin = v329
                    });
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/Portal",
                        Player = AttackerPlayer,
                        Origin = v329
                    });
                end;

                EffectsHandler.CallEffect("Emit Particle V3", {
                    VFXForgeEmit = true,
                    Path = "Particles/Beatdown/BigPunch",
                    Origin = CFrame2,
                    Player = AttackerPlayer
                });
            end },
        { 1185, function() -- Line: 2048
                -- upvalues: RunService (ref), CurrentCamera (ref), DefaultBloom (copy), DefaultColorCorrection (copy), u37 (copy), u39 (copy), Trove (copy), Snapshot (ref), Lighting (ref), AssetHandler (ref), u26 (copy), ParticleHandler (ref), u25 (copy), TweenService (ref), CameraUpdate (copy), LocalPlayer (ref), u1 (ref), u38 (copy), EffectsHandler (ref)
                RunService:UnbindFromRenderStep("UGrain Camera");
                local u330 = {};

                if CurrentCamera then
                    table.insert(u330, { CurrentCamera, "FieldOfView" });
                end;

                if DefaultBloom then
                    table.insert(u330, { DefaultBloom, "Threshold" });
                    table.insert(u330, { DefaultBloom, "Intensity" });
                    table.insert(u330, { DefaultBloom, "Size" });
                end;

                if DefaultColorCorrection then
                    table.insert(u330, { DefaultColorCorrection, "Brightness" });
                    table.insert(u330, { DefaultColorCorrection, "Saturation" });
                    table.insert(u330, { DefaultColorCorrection, "TintColor" });
                end;

                if u37 then
                    table.insert(u330, { u37, "FarIntensity" });
                    table.insert(u330, { u37, "InFocusRadius" });
                end;

                local function SetSuppressed(p331) -- Line: 2068
                    -- upvalues: u330 (copy), u39 (ref)
                    for _, v in u330 do
                        local v332 = v[1];
                        local v333 = v[2];

                        if v332 then
                            u39[v332] = u39[v332] or {};
                            u39[v332][v333] = p331 or nil;
                        end;
                    end;
                end;

                for _, v in u330 do
                    local v334 = v[1];
                    local v335 = v[2];

                    if v334 then
                        u39[v334] = u39[v334] or {};
                        u39[v334][v335] = true;
                    end;
                end;

                if u37 and u37.Parent then
                    u37.Enabled = false;
                end;

                local u336 = Trove:Extend();
                local u337 = false;
                local u338 = DefaultBloom and Snapshot(DefaultBloom, { "Threshold", "Intensity", "Size" }) or function() -- Line: 2077
                end;
                local u339 = DefaultColorCorrection and Snapshot(DefaultColorCorrection, { "Brightness", "Saturation", "TintColor" }) or function() -- Line: 2078
                end;
                local Atmosphere = Lighting:FindFirstChild("Atmosphere");

                if Atmosphere then
                    local v340 = Snapshot(Atmosphere, { "Glare", "Haze" });
                    Atmosphere.Glare = 0;
                    Atmosphere.Haze = 0;
                    u336:Add(v340);
                end;

                CurrentCamera.CFrame = CFrame.new(0, 1000, 0) * CFrame.Angles(1.5707963267948966, 0, 0);
                local v341 = u336:Add(AssetHandler.CloneAsset("Particles/Beatdown/Wormhole/Sky", u26));
                ParticleHandler.Unusualify(v341, {
                    HSVData = u25
                });
                v341.Parent = Lighting;
                local u342 = {};

                local function PlayAcidTween(p343, p344, p345) -- Line: 2094
                    -- upvalues: TweenService (ref), u342 (copy), Trove (ref)
                    if p343 and p343.Parent then
                        local v346 = TweenService:Create(p343, p344, p345);
                        table.insert(u342, v346);
                        Trove:Add(v346, "Cancel");
                        v346:Play();

                        return v346;
                    end;
                end;

                local function ReleaseLighting() -- Line: 2103
                    -- upvalues: u330 (copy), u39 (ref), u37 (ref), u338 (copy), u339 (copy)
                    for _, v in u330 do
                        local v347 = v[1];
                        local v348 = v[2];

                        if v347 then
                            u39[v347] = u39[v347] or {};
                            u39[v347][v348] = nil;
                        end;
                    end;

                    if u37 and u37.Parent then
                        u37.Enabled = true;
                    end;

                    u338();
                    u339();
                end;

                u336:Add(function() -- Line: 2110
                    -- upvalues: u342 (copy), u330 (copy), u39 (ref), u37 (ref), u338 (copy), u339 (copy), RunService (ref), CameraUpdate (ref)
                    for _, v in u342 do
                        pcall(v.Cancel, v);
                    end;

                    for _, v in u330 do
                        local v349 = v[1];
                        local v350 = v[2];

                        if v349 then
                            u39[v349] = u39[v349] or {};
                            u39[v349][v350] = nil;
                        end;
                    end;

                    if u37 and u37.Parent then
                        u37.Enabled = true;
                    end;

                    u338();
                    u339();
                    RunService:BindToRenderStep("UGrain Camera", Enum.RenderPriority.Camera.Value, CameraUpdate);
                end);

                if DefaultColorCorrection and DefaultColorCorrection.Parent then
                    DefaultColorCorrection.TintColor = Color3.new(0, 0, 0);
                    DefaultColorCorrection.Brightness = -0.25;
                    DefaultColorCorrection.Saturation = 0.15;
                end;

                if DefaultBloom and DefaultBloom.Parent then
                    DefaultBloom.Size = 28;
                    DefaultBloom.Threshold = 0.85;
                    DefaultBloom.Intensity = 1.1;
                end;

                local v351 = TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                local v352 = DefaultColorCorrection;
                local v353 = {
                    Brightness = 0.08,
                    Saturation = 0.45,
                    TintColor = Color3.new(1, 1, 1)
                };

                if v352 and v352.Parent then
                    local v354 = TweenService:Create(v352, v351, v353);
                    table.insert(u342, v354);
                    Trove:Add(v354, "Cancel");
                    v354:Play();
                end;

                local v355 = DefaultBloom;
                local v356 = {
                    Size = 34,
                    Threshold = 0.7,
                    Intensity = 1.5
                };

                if v355 and v355.Parent then
                    local v357 = TweenService:Create(v355, v351, v356);
                    table.insert(u342, v357);
                    Trove:Add(v357, "Cancel");
                    v357:Play();
                end;

                local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

                if not PlayerGui then
                    return;
                end;

                local v358 = u336:Add(Instance.new("ScreenGui"));
                v358.IgnoreGuiInset = true;
                v358.DisplayOrder = 1000;
                v358.Parent = PlayerGui;
                local Frame = Instance.new("Frame");
                Frame.Size = UDim2.fromScale(1, 1);
                Frame.BackgroundColor3 = Color3.new(1, 1, 1);
                Frame.BackgroundTransparency = 1;
                Frame.BorderSizePixel = 0;
                Frame.Parent = v358;
                local u359 = u336:Add(Instance.new("Folder"));
                u359.Name = "Entering Wormhole";
                u359.Parent = workspace.Effects;
                CurrentCamera:SetAttribute("CamDisabled", true);
                u336:Add(function() -- Line: 2158
                    -- upvalues: CurrentCamera (ref)
                    CurrentCamera:SetAttribute("CamDisabled", nil);
                end);
                local u360 = nil;
                RunService:BindToRenderStep("AcidTripFOVPre", Enum.RenderPriority.Camera.Value - 1, function() -- Line: 2161
                    -- upvalues: u360 (ref), CurrentCamera (ref)
                    if u360 then
                        CurrentCamera.CFrame = u360;
                        u360 = nil;
                    end;
                end);
                u336:Add(function() -- Line: 2164
                    -- upvalues: RunService (ref)
                    RunService:UnbindFromRenderStep("AcidTripFOVPre");
                    RunService:UnbindFromRenderStep("AcidTripFOVApply");
                end);

                local function CalcFOV(p361) -- Line: 2169
                    local v362 = math.clamp(p361, 0, 1);

                    if v362 < 0.12 then
                        local v363 = math.clamp(v362 / 0.12, 0, 1);

                        return math.lerp(70, 170, v363 * v363 * (3 - 2 * v363));
                    end;

                    if v362 < 0.45 then
                        local v364 = math.clamp((v362 - 0.12) / 0.33, 0, 1);

                        return math.lerp(170, 7, v364 * v364 * (3 - 2 * v364));
                    end;

                    local v365 = math.clamp((v362 - 0.45) / 0.55, 0, 1);

                    return math.lerp(7, 70, v365 * v365 * (3 - 2 * v365));
                end;

                local function CalcLightPulse(p366) -- Line: 2180
                    local v367 = math.clamp(p366, 0, 1);

                    if v367 < 0.12 then
                        local v368 = math.clamp(v367 / 0.12, 0, 1);

                        return v368 * v368 * (3 - 2 * v368);
                    end;

                    if v367 < 0.45 then
                        local v369 = math.clamp((v367 - 0.12) / 0.33, 0, 1);

                        return 1 - v369 * v369 * (3 - 2 * v369) * 0.65;
                    end;

                    local v370 = math.clamp((v367 - 0.45) / 0.55, 0, 1);

                    return (1 - v370 * v370 * (3 - 2 * v370)) * 0.35;
                end;

                local u371 = table.create(3);

                for i = 1, 3 do
                    local v372 = AssetHandler.GetAsset("Particles/Beatdown/Wormhole/EnterStage" .. i, u26);

                    if v372 then
                        local Start = v372:FindFirstChild("Start");
                        local End2 = v372:FindFirstChild("End");

                        if Start and End2 then
                            local v373 = Start.CFrame:ToObjectSpace(End2.CFrame);
                            local v374 = Color3.new(1, 1, 1);

                            for _, descendant in v372:GetDescendants() do
                                if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                                    local Keypoints = descendant.Color.Keypoints;
                                    v374 = Keypoints[math.ceil(#Keypoints / 2)].Value;
                                    break;
                                end;
                            end;

                            local v375 = table.create(10);

                            for i2 = 1, 10 do
                                local v376 = u336:Clone(v372);
                                ParticleHandler.Unusualify(v376, {
                                    HSVData = u25
                                });
                                ParticleHandler.EnableAllParticles(v376, false);
                                v376.Parent = u359;
                                local v377 = {};

                                for _, descendant in v376:GetDescendants() do
                                    if descendant:IsA("BasePart") then
                                        descendant.Anchored = true;
                                        descendant.CanCollide = false;
                                        descendant.CanQuery = false;
                                        descendant.CanTouch = false;
                                        descendant.CastShadow = false;
                                        descendant.Transparency = 1;
                                    elseif descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) then
                                        table.insert(v377, descendant);

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

                                local Start2 = v376:FindFirstChild("Start");
                                local End3 = v376:FindFirstChild("End");

                                if Start2 and End3 then
                                    v375[i2] = {
                                        Start = Start2,
                                        End = End3,
                                        Model = v376,
                                        Colorables = v377,
                                        Z = i2 * 45,
                                        Spin = (i2 - 1) * 0.6283185307179586
                                    };
                                end;
                            end;

                            u371[i] = {
                                Active = false,
                                Dissipated = false,
                                LastHueBucket = -2,
                                RelCF = v373,
                                Tint = v374,
                                Segments = v375
                            };
                        end;
                    end;
                end;

                local u378 = table.create(20);

                for i = 1, 20 do
                    local v379 = u1:NextInteger(18, 45);
                    local v380 = {
                        Size = Vector3.new(0.4, 0.4, v379),
                        Material = Enum.Material.Neon,
                        Transparency = u1:NextNumber(0.15, 0.4)
                    };
                    local Part = Instance.new("Part");
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanQuery = false;
                    Part.CanTouch = false;
                    Part.CastShadow = false;

                    for i2, v in v380 do
                        Part[i2] = v;
                    end;

                    Part.Parent = u359;
                    u378[i] = {
                        Part = Part,
                        Angle = u1:NextNumber(0, 6.283185307179586),
                        Radius = u1:NextNumber(12, 60),
                        Z = u1:NextNumber(0, 700),
                        SpeedMul = u1:NextNumber(0.8, 1.3),
                        BaseT = Part.Transparency,
                        Length = v379
                    };
                end;

                local function SpinSpeed() -- Line: 2279
                    -- upvalues: u1 (ref)
                    return 3.839724354387525 * u1:NextNumber(0.4, 1.4) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
                end;

                local u381 = table.create(18);

                for i = 1, 18 do
                    local v382 = u1:NextNumber(1, 2.5);
                    local v383 = u1:NextInteger(1, 3);
                    local v384 = {
                        Material = Enum.Material.Neon,
                        Transparency = u1:NextNumber(0.15, 0.4)
                    };
                    local Part = Instance.new("Part");
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanQuery = false;
                    Part.CanTouch = false;
                    Part.CastShadow = false;

                    for i2, v in v384 do
                        Part[i2] = v;
                    end;

                    if v383 == 1 then
                        Part.Shape = Enum.PartType.Ball;
                        Part.Size = Vector3.new(v382, v382, v382);
                    elseif v383 == 2 then
                        Part.Size = Vector3.new(v382, v382, v382);
                    else
                        Part.Size = Vector3.new(v382 * 0.5, v382 * 0.5, v382 * 1.8);
                    end;

                    Part.Parent = u359;
                    local v385 = {
                        Part = Part,
                        Angle = u1:NextNumber(0, 6.283185307179586),
                        Radius = u1:NextNumber(8, 60),
                        Z = u1:NextNumber(20, 320),
                        SpeedMul = u1:NextNumber(0.7, 1.3),
                        BaseT = Part.Transparency,
                        Phase = u1:NextNumber(0, 6.283185307179586)
                    };
                    local v386 = u1:NextNumber(0, 6.283185307179586);
                    local v387 = u1:NextNumber(0, 6.283185307179586);
                    v385.Spin = Vector3.new(v386, v387, u1:NextNumber(0, 6.283185307179586));
                    local v388 = 3.839724354387525 * u1:NextNumber(0.4, 1.4) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
                    local v389 = 3.839724354387525 * u1:NextNumber(0.4, 1.4) * (u1:NextInteger(0, 1) == 0 and -1 or 1);
                    local v390 = 3.839724354387525 * u1:NextNumber(0.4, 1.4);
                    local v391 = u1:NextInteger(0, 1) == 0 and -1 or 1;
                    v385.SpinSpeed = Vector3.new(v388, v389, v390 * v391);
                    u381[i] = v385;
                end;

                local function SetStageActive(p392, p393) -- Line: 2318
                    -- upvalues: ParticleHandler (ref)
                    if not p392 or p392.Active == p393 then
                        return;
                    end;

                    p392.Active = p393;

                    for _, v in p392.Segments do
                        if v and (v.Model and v.Model.Parent) then
                            ParticleHandler.EnableAllParticles(v.Model, p393);
                        end;
                    end;
                end;

                local u394 = u38 + 19.75;

                local function FinishAcid() -- Line: 2330
                    -- upvalues: u337 (ref), Frame (copy), RunService (ref), CurrentCamera (ref), CameraUpdate (ref), u330 (copy), u39 (ref), u37 (ref), u338 (copy), u339 (copy), u359 (copy)
                    if u337 then
                        return;
                    end;

                    u337 = true;

                    if Frame and Frame.Parent then
                        Frame.BackgroundTransparency = 0;
                    end;

                    RunService:UnbindFromRenderStep("AcidTripFOVPre");
                    RunService:UnbindFromRenderStep("AcidTripFOVApply");
                    CurrentCamera:SetAttribute("CamDisabled", nil);
                    RunService:BindToRenderStep("UGrain Camera", Enum.RenderPriority.Camera.Value, CameraUpdate);

                    for _, v in u330 do
                        local v395 = v[1];
                        local v396 = v[2];

                        if v395 then
                            u39[v395] = u39[v395] or {};
                            u39[v395][v396] = nil;
                        end;
                    end;

                    if u37 and u37.Parent then
                        u37.Enabled = true;
                    end;

                    u338();
                    u339();

                    if u359 and u359.Parent then
                        u359:Destroy();
                    end;
                end;

                RunService:BindToRenderStep("AcidTripFOVApply", Enum.RenderPriority.Camera.Value + 6, function() -- Line: 2345
                    -- upvalues: u337 (ref), u394 (copy), CurrentCamera (ref), u360 (ref)
                    if u337 then
                        return;
                    end;

                    local v397 = (os.clock() - u394) / 3.5;
                    local v398 = math.clamp(v397, 0, 1);
                    local v399 = math.clamp(v398, 0, 1);
                    local v400;

                    if v399 < 0.12 then
                        local v401 = math.clamp(v399 / 0.12, 0, 1);
                        v400 = math.lerp(70, 170, v401 * v401 * (3 - 2 * v401));
                    elseif v399 < 0.45 then
                        local v402 = math.clamp((v399 - 0.12) / 0.33, 0, 1);
                        v400 = math.lerp(170, 7, v402 * v402 * (3 - 2 * v402));
                    else
                        local v403 = math.clamp((v399 - 0.45) / 0.55, 0, 1);
                        v400 = math.lerp(7, 70, v403 * v403 * (3 - 2 * v403));
                    end;

                    if v400 <= 120 then
                        CurrentCamera.FieldOfView = math.max(1, v400);

                        return;
                    end;

                    CurrentCamera.FieldOfView = 120;
                    local v404 = math.clamp(v400, 120, 175) / 2;
                    local v405 = math.rad(v404);
                    local v406 = math.tan(v405);
                    local v407 = 1.7320508075688767 / (v406 <= 0 and 11.430052302761348 or v406);
                    u360 = CurrentCamera.CFrame;
                    CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 0, v407, 0, 0, 0, v407, 0, 0, 0, 1);
                end);
                local u408 = nil;
                u336:Connect(RunService.RenderStepped, function(p409) -- Line: 2366
                    -- upvalues: u394 (copy), u337 (ref), Frame (copy), u336 (copy), FinishAcid (copy), SetStageActive (copy), u371 (copy), EffectsHandler (ref), CurrentCamera (ref), u408 (ref), u378 (copy), u1 (ref), u381 (copy), DefaultBloom (ref), DefaultColorCorrection (ref)
                    local v410 = os.clock() - u394;

                    if u337 then
                        local v411 = v410 - 3.5;

                        if not (Frame and Frame.Parent) then
                            u336:Destroy();

                            return;
                        end;

                        if v411 < 0.38 then
                            Frame.BackgroundTransparency = 0;

                            return;
                        end;

                        if v411 >= 0.66 then
                            u336:Destroy();

                            return;
                        end;

                        local v412 = math.clamp((v411 - 0.38) / 0.28, 0, 1);
                        Frame.BackgroundTransparency = v412 * v412 * (3 - 2 * v412);

                        return;
                    end;

                    if v410 >= 3.5 then
                        FinishAcid();

                        return;
                    end;

                    if Frame and Frame.Parent then
                        local v413;

                        if v410 >= 3.05 then
                            local v414 = math.clamp((v410 - 3.05) / 0.45, 0, 1);
                            v413 = 1 - v414 * v414 * (3 - 2 * v414) or 1;
                        else
                            v413 = 1;
                        end;

                        Frame.BackgroundTransparency = v413;
                    end;

                    local v415 = math.clamp(v410 / 3.5, 0, 1);
                    local v416 = math.floor(v415 * 3) + 1;
                    local v417 = math.min(v416, 3);
                    local v418 = v415 * 3 - (v417 - 1);
                    local v419 = v415 >= 0.5 and ((v410 - 1.75) % 1 or 0) or 0;
                    local v420;

                    if v417 == 3 and v418 >= 0.72 then
                        local v421 = math.clamp((v418 - 0.72) / 0.28, 0, 1);
                        v420 = v421 * v421 * (3 - 2 * v421) or 0;
                    else
                        v420 = 0;
                    end;

                    SetStageActive(u371[1], v417 == 1);
                    SetStageActive(u371[2], v417 == 2);
                    SetStageActive(u371[3], v417 == 3);
                    local v422 = u371[v417];

                    if not v422 then
                        return;
                    end;

                    local Tint = v422.Tint;

                    if v419 > 0 then
                        local v423, v424, v425 = v422.Tint:ToHSV();
                        Tint = Color3.fromHSV((v423 + v419) % 1, v424, v425);
                    end;

                    if v419 > 0 and v420 <= 0 then
                        local v426 = math.floor(v419 * 90);

                        if v426 ~= v422.LastHueBucket then
                            v422.LastHueBucket = v426;
                            local v427 = ColorSequence.new(Tint);

                            for _, v in v422.Segments do
                                for _, v2 in v.Colorables do
                                    if v2 and v2.Parent then
                                        v2.Color = v427;
                                    end;
                                end;
                            end;
                        end;
                    end;

                    if v420 > 0 and not v422.Dissipated then
                        v422.Dissipated = true;

                        for _, v in v422.Segments do
                            if v and (v.Model and v.Model.Parent) then
                                EffectsHandler.CallEffect("FadeBeams", v.Model, {
                                    Time = 0.35
                                });
                            end;
                        end;
                    end;

                    local v428 = 1 + v420 * 1.8;
                    local CFrame3 = CurrentCamera.CFrame;
                    local Position = CFrame3.Position;
                    local LookVector = CFrame3.LookVector;
                    local RightVector = CFrame3.RightVector;
                    local UpVector = CFrame3.UpVector;
                    local v429 = 140 * v428 * p409;

                    for _, v in v422.Segments do
                        if v and (v.Start and (v.Start.Parent and (v.End and v.End.Parent))) then
                            local v430 = v.Z - v429;

                            if v430 < -30 and v420 <= 0 then
                                v430 = v430 + 450;
                            end;

                            v.Z = v430;
                            local v431 = Position + LookVector * v430;
                            local v432 = CFrame.lookAt(v431, v431 + LookVector) * CFrame.Angles(0, 0, v.Spin);
                            v.Start.CFrame = v432;
                            v.End.CFrame = v432 * v422.RelCF;
                        end;
                    end;

                    local v433 = Tint ~= u408;

                    if v433 then
                        u408 = Tint;
                    end;

                    for _, v in u378 do
                        if v.Part and v.Part.Parent then
                            v.Z = v.Z - 224 * v.SpeedMul * v428 * p409;

                            if v.Z < -v.Length and v420 <= 0 then
                                v.Z = 700 + u1:NextNumber(0, 100);
                                v.Angle = u1:NextNumber(0, 6.283185307179586);
                                v.Radius = u1:NextNumber(12, 60);
                            end;

                            local v434 = Vector2.new(math.cos(v.Angle), (math.sin(v.Angle))) * v.Radius;
                            local v435 = Position + LookVector * v.Z + RightVector * v434.X + UpVector * v434.Y;
                            v.Part.CFrame = CFrame.lookAt(v435, v435 + LookVector);

                            if v433 then
                                v.Part.Color = Tint;
                            end;

                            v.Part.Transparency = math.clamp(v.BaseT + v420, 0, 1);
                        end;
                    end;

                    for _, v in u381 do
                        if v.Part and v.Part.Parent then
                            v.Z = v.Z - 280 * v.SpeedMul * v428 * p409;

                            if v.Z < -10 and v420 <= 0 then
                                v.Z = 320 + u1:NextNumber(0, 80);
                                v.Angle = u1:NextNumber(0, 6.283185307179586);
                                v.Radius = u1:NextNumber(8, 60);
                                v.Phase = u1:NextNumber(0, 6.283185307179586);
                            end;

                            v.Spin = v.Spin + v.SpinSpeed * p409;
                            local v436 = math.cos(v.Angle) * v.Radius + math.sin(v410 * 8 + v.Z * 0.04 + v.Phase) * 5;
                            local v437 = math.sin(v.Angle) * v.Radius + math.cos(v410 * 7 + v.Z * 0.03 + v.Phase) * 5;
                            v.Part.CFrame = CFrame.lookAt(Position + LookVector * v.Z + RightVector * v436 + UpVector * v437, Position) * CFrame.Angles(v.Spin.X, v.Spin.Y, v.Spin.Z);

                            if v433 then
                                v.Part.Color = Tint;
                            end;

                            local v438 = v.Z < 35 and (math.max(0, (1 - v.Z / 35) * 0.55) or 0) or 0;
                            v.Part.Transparency = math.clamp(v.BaseT + v438 + v420, 0, 1);
                        end;
                    end;

                    local v439 = math.clamp(v415, 0, 1);
                    local v440;

                    if v439 < 0.12 then
                        local v441 = math.clamp(v439 / 0.12, 0, 1);
                        v440 = v441 * v441 * (3 - 2 * v441);
                    elseif v439 < 0.45 then
                        local v442 = math.clamp((v439 - 0.12) / 0.33, 0, 1);
                        v440 = 1 - v442 * v442 * (3 - 2 * v442) * 0.65;
                    else
                        local v443 = math.clamp((v439 - 0.45) / 0.55, 0, 1);
                        v440 = (1 - v443 * v443 * (3 - 2 * v443)) * 0.35;
                    end;

                    local v444 = math.max(0.1, v440);
                    local v445 = math.clamp(v415 / 0.18, 0, 1);
                    local v446 = math.clamp(v445, 0, 1);
                    local v447 = 1 - v446 * v446 * (3 - 2 * v446);

                    if DefaultBloom and DefaultBloom.Parent then
                        DefaultBloom.Size = math.lerp(30, 46, v444);
                        DefaultBloom.Threshold = math.lerp(0.95, 0.55, v444);
                        DefaultBloom.Intensity = math.lerp(0.85, 2.4, v444) + v447 * 0.65;
                    end;

                    if DefaultColorCorrection and DefaultColorCorrection.Parent then
                        DefaultColorCorrection.Saturation = math.lerp(0.28, 0.75, v444);
                        DefaultColorCorrection.Brightness = math.lerp(0.02, 0.14, v444) + v447 * 0.08;
                        DefaultColorCorrection.TintColor = v419 > 0 and Color3.fromHSV(v419, 0.16, 1) or Color3.new(1, 1, 1);
                    end;
                end);
            end },
        { 1395, function(p448) -- Line: 2507
                -- upvalues: Wormhole (copy)
                Wormhole(1, p448);
            end },
        { 1673, function(p449) -- Line: 2511
                -- upvalues: Wormhole (copy)
                Wormhole(2, p449);
            end },
        { 1951, function(p450) -- Line: 2515
                -- upvalues: End (copy)
                End(p450);
            end },
        { 2022, function() -- Line: 2519
            end },
        { 2098, function() -- Line: 2520
            end }
    };
    ScheduleFrameEvents(v451, u38, Trove);
    WaitUntilTime(u38 + v451[#v451][1] / 60);
end;