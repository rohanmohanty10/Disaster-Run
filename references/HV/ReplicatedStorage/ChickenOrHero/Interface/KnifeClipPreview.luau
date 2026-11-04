 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local KnifeClips = require(Parent.Weapons.KnifeClips);
local SkinCatalog = require(Parent.Weapons.SkinCatalog);
local DaggerConfig = require(Parent.Weapons.DaggerConfig);
local ClientBotKnife = require(Parent.Bots.ClientBotKnife);
local KnifeChains = require(Parent.Weapons.KnifeChains);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local EmotePieces = require(Parent.Emotes.EmotePieces);
local FootballShots = require(Parent.Presentation.FootballShots);
local KnifeVisibility = require(Parent.Weapons.KnifeVisibility);
local CharacterClone = require(script_Parent.CharacterClone);
local CharacterFrame = require(script_Parent.CharacterFrame);
local Cursor = require(script_Parent.Cursor);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {
    Equip = {
        action = "Equip",
        label = "Draw",
        cue = 0.08,
        window = DaggerConfig.DrawDuration
    },
    Swing = {
        action = "Stab",
        label = "Swing",
        cue = 0.04
    },
    Hit = {
        action = "Dive",
        label = "Hit",
        cue = 0.32,
        window = DaggerConfig.DiveDuration
    }
};
local u3 = { "Equip", "Swing", "Hit" };
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(76, 76, 81);
local Color3_fromRGB_ret3 = Color3.fromRGB(80, 255, 100);
local Color3_fromRGB_ret4 = Color3.fromRGB(17, 213, 40);
local Color3_fromRGB_ret5 = Color3.fromRGB(222, 222, 222);
local Color3_fromRGB_ret6 = Color3.fromRGB(253, 60, 85);
local Color3_fromRGB_ret7 = Color3.fromRGB(255, 202, 58);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Timing = FootballShots.Timing;
local MatchDay = FootballShots.MatchDay;
local u4 = {
    Catch = "CatchAnim",
    Touchdown = "TouchdownAnim",
    Intro = "IntroAnim",
    IntroLoop = "IntroLoopAnim",
    Celebrate = "CelebrateAnim",
    CelebrateLoop = "CelebrateLoopAnim",
    Run = "RunAnim"
};
local u5 = nil;

local function make(p6, p7, p8) -- Line: 62
    local Instance_new_ret = Instance.new(p6);

    for i, v in p8 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p7;

    return Instance_new_ret;
end;

local function stroke(p9, p10, p11) -- Line: 70
    local v12 = {
        Color = p10,
        Thickness = p11,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v12 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p9;

    return UIStroke;
end;

local function label(p13, p14, p15, p16, p17) -- Line: 73
    -- upvalues: Font_new_ret (copy)
    local v18 = {
        BackgroundTransparency = 1,
        FontFace = Font_new_ret,
        Text = p14,
        TextSize = p15,
        TextColor3 = p16,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v18 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p13;

    for i, v in p17 do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function extras(p19, p20) -- Line: 89
    -- upvalues: EmoteCatalog (copy)
    local v21 = {};

    for _, v in EmoteCatalog.bundle(p19) do
        if EmoteCatalog.assetId(v.Id) then
            table.insert(v21, {
                key = "Emote:" .. v.Id,
                label = v.Name,
                emote = v
            });
        end;
    end;

    for _, v in EmoteCatalog.Entries do
        if table.find(v.PlaysWith or {}, p19) and (EmoteCatalog.assetId(v.Id) and not table.find(EmoteCatalog.bundle(p19), v)) then
            table.insert(v21, {
                key = "Emote:" .. v.Id,
                label = v.Name,
                emote = v
            });
        end;
    end;

    if p20.Show == "GameDay" then
        table.insert(v21, {
            key = "GameDay",
            label = "Game Day",
            show = true
        });

        return v21;
    end;

    if p20.Show == "MatchDay" then
        table.insert(v21, {
            key = "MatchDay",
            label = "Match Day",
            show = true
        });
    end;

    return v21;
end;

local function template(p22) -- Line: 111
    -- upvalues: SkinCatalog (copy), Parent (copy), extras (copy), KnifeClips (copy)
    local v23 = SkinCatalog.get(p22);
    local v24;

    if v23 then
        v24 = Parent.Weapons.Models:FindFirstChild(v23.Model);
    else
        v24 = v23;
    end;

    if not v24 then
        return nil;
    end;

    local v25 = extras(p22, v23);

    if #v25 > 0 then
        return v24, v23, v25;
    end;

    for i in KnifeClips.Actions do
        if KnifeClips.custom(v24, i) then
            return v24, v23, v25;
        end;
    end;

    return nil;
end;

function u1.has(p26) -- Line: 128
    -- upvalues: template (copy)
    return template(p26) ~= nil;
end;

function u1.first(p27) -- Line: 132
    -- upvalues: template (copy)
    local _, _, v28 = template(p27);

    return v28 and (v28[1] and v28[1].key) or "Equip";
end;

local function load(p29, p30, p31, p32, p33) -- Line: 137
    local v34 = p29.tracks[p30];

    if v34 then
        return v34;
    end;

    if not p31 then
        return nil;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = p31;
    table.insert(p29.assets, Animation);
    local success, result = pcall(p29.animator.LoadAnimation, p29.animator, Animation);

    if not success then
        return nil;
    end;

    result.Priority = p32;
    result.Looped = p33;
    p29.tracks[p30] = result;

    return result;
end;

local function track(p35, p36) -- Line: 157
    -- upvalues: KnifeClips (copy), load (copy)
    local v37 = KnifeClips.Actions[p36];

    return load(p35, p36, KnifeClips.id(p35.model, p36), v37.priority, v37.looped);
end;

local function showClip(p38, p39) -- Line: 162
    -- upvalues: load (copy), KnifeClips (copy), u4 (copy)
    return load(p38, p39, KnifeClips.normalize(p38.model:GetAttribute(u4[p39])), Enum.AnimationPriority.Action3, (p39 == "IntroLoop" or p39 == "CelebrateLoop") and true or p39 == "Run");
end;

local function isRest(p40) -- Line: 166
    local _, v41 = p40:ToAxisAngle();
    local v42;

    if p40.Position.Magnitude < 0.0001 then
        v42 = math.abs(v41) < 0.001;
    else
        v42 = false;
    end;

    return v42;
end;

local function rootPiece(p43, p44) -- Line: 173
    -- upvalues: RunService (copy), KnifeVisibility (copy)
    local Attribute = p43.model:GetAttribute("RootPart");
    local EquippedDagger = p44:FindFirstChild("EquippedDagger");

    if type(Attribute) == "string" then
        if EquippedDagger then
            EquippedDagger = EquippedDagger:FindFirstChild(Attribute);
        end;
    else
        EquippedDagger = false;
    end;

    local HumanoidRootPart = p44:FindFirstChild("HumanoidRootPart");

    if not (EquippedDagger and (EquippedDagger:IsA("BasePart") and HumanoidRootPart)) then
        return nil;
    end;

    local RootStow = EquippedDagger:FindFirstChild("RootStow");

    if RootStow then
        RootStow:Destroy();
    end;

    local v45 = {
        Name = Attribute,
        Part0 = HumanoidRootPart,
        Part1 = EquippedDagger,
        C0 = p43.model:GetAttribute("RootC0") or CFrame.identity,
        C1 = p43.model:GetAttribute("RootC1") or CFrame.identity
    };
    local Motor6D = Instance.new("Motor6D");

    for i, v in v45 do
        Motor6D[i] = v;
    end;

    Motor6D.Parent = HumanoidRootPart;
    local Attribute2 = p43.model:GetAttribute("RootRest");

    if typeof(Attribute2) ~= "CFrame" then
        Attribute2 = CFrame.identity;
    end;

    table.insert(p43.connections, RunService.PreSimulation:Connect(function() -- Line: 196
        -- upvalues: Motor6D (copy), Attribute2 (ref)
        if Motor6D.Parent then
            local Transform = Motor6D.Transform;
            local _, v46 = Transform:ToAxisAngle();
            local v47;

            if Transform.Position.Magnitude < 0.0001 then
                v47 = math.abs(v46) < 0.001;
            else
                v47 = false;
            end;

            if v47 then
                Motor6D.Transform = Attribute2;
            end;
        end;
    end));
    KnifeVisibility.set(EquippedDagger, false);

    return EquippedDagger;
end;

local function ready(u48, u49, u50, u51) -- Line: 206
    -- upvalues: u5 (ref)
    if u50.Length > 0 then
        u51();

        return;
    end;

    task.spawn(function() -- Line: 211
        -- upvalues: u5 (ref), u48 (copy), u49 (copy), u50 (copy), u51 (copy)
        local v52 = os.clock() + 3;

        while u5 == u48 and (u48.token == u49 and (u50.Length <= 0 and os.clock() < v52)) do
            task.wait(0.05);
        end;

        if u5 == u48 and u48.token == u49 then
            u51();
        end;
    end);
end;

local function highlight(p53, p54) -- Line: 221
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy)
    for i, v in p53.buttons do
        local v55 = i == p54;
        v.gradient.Enabled = v55;
        v.button.BackgroundColor3 = v55 and Color3_new_ret or Color3_fromRGB_ret;
        v.edge.Color = v55 and Color3_fromRGB_ret3 or Color3_fromRGB_ret2;
    end;
end;

local function part(p56, p57, p58, p59, p60) -- Line: 233
    local v61 = {
        Anchored = true,
        CanCollide = false,
        CanQuery = false,
        CanTouch = false,
        CastShadow = false,
        Size = p57,
        CFrame = p58,
        Color = p59,
        Material = p60 or Enum.Material.SmoothPlastic
    };
    local Part = Instance.new("Part");

    for i, v in v61 do
        Part[i] = v;
    end;

    Part.Parent = p56;

    return Part;
end;

local function fieldEnd() -- Line: 248
    -- upvalues: part (copy)
    local Model = Instance.new("Model");
    Model.Name = "GameDayStage";
    part(Model, Vector3.new(120, 1, 190), CFrame.new(0, -3.5, -70), Color3.fromRGB(62, 128, 56), Enum.Material.Grass);
    part(Model, Vector3.new(92, 0.06, 23.5), CFrame.new(0, -2.98, 0.25), Color3.fromRGB(196, 46, 52));
    local v62 = {};

    for i = 0, 12 do
        local v63 = part(Model, Vector3.new(92, 0.06, i == 0 and 0.9 or (i % 2 == 0 and 0.6 or 0.35)), CFrame.new(0, -2.96, -11.5 - i * 5 * 2.33), Color3.new(1, 1, 1));
        table.insert(v62, v63);
        local _ = i;
    end;

    for _, v in { -46, 46 } do
        local v64 = part(Model, Vector3.new(0.7, 0.06, 175), CFrame.new(v, -2.96, -75), Color3.new(1, 1, 1));
        table.insert(v62, v64);
    end;

    local v65 = part(Model, Vector3.new(92, 0.06, 0.6), CFrame.new(0, -2.96, 12), Color3.new(1, 1, 1));
    table.insert(v62, v65);
    local v66 = {
        Color3.fromRGB(44, 62, 112),
        Color3.fromRGB(150, 44, 52),
        Color3.fromRGB(58, 58, 66),
        Color3.fromRGB(214, 170, 60)
    };

    for i = 0, 5 do
        part(Model, Vector3.new(130, 2.2, 3.2), CFrame.new(0, i * 2.2 + -1.9, i * 3.2 + 16), v66[i % 4 + 1]);
        part(Model, Vector3.new(3.2, 2.2, 150), CFrame.new(-52 - i * 3.2, i * 2.2 + -1.9, -60), v66[(i + 1) % 4 + 1]);
        local _ = i;
    end;

    Model.WorldPivot = CFrame.new();

    return { Model, v62 };
end;

local function pitchEnd() -- Line: 277
    -- upvalues: part (copy), Parent (copy)
    local Model = Instance.new("Model");
    Model.Name = "MatchDayStage";
    local Color3_new_ret3 = Color3.new(1, 1, 1);
    part(Model, Vector3.new(120, 1, 190), CFrame.new(0, -3.5, -70), Color3.fromRGB(62, 128, 56), Enum.Material.Grass);
    local u67 = {};

    local function line(p68, p69, p70, p71, p72) -- Line: 285
        -- upvalues: u67 (copy), part (ref), Model (copy), Color3_new_ret3 (copy)
        local v73 = CFrame.new(p68, -2.96, p69) * CFrame.Angles(0, p72 or 0, 0);
        local v74 = part(Model, Vector3.new(p70, 0.06, p71), v73, Color3_new_ret3);
        table.insert(u67, v74);
    end;

    local v75 = part(Model, Vector3.new(100, 0.06, 0.6), CFrame.new(0, -2.96, 16) * CFrame.Angles(0, 0, 0), Color3_new_ret3);
    table.insert(u67, v75);
    local v76 = part(Model, Vector3.new(89.472, 0.06, 0.6), CFrame.new(0, -2.96, -20.614285714285714) * CFrame.Angles(0, 0, 0), Color3_new_ret3);
    table.insert(u67, v76);
    local v77 = part(Model, Vector3.new(40.652954, 0.06, 0.6), CFrame.new(0, -2.96, 3.795238095238094) * CFrame.Angles(0, 0, 0), Color3_new_ret3);
    table.insert(u67, v77);

    for _, v in { -1, 1 } do
        local v78 = part(Model, Vector3.new(0.6, 0.06, 36.614285), CFrame.new(v * 89.47200000000001 / 2, -2.96, -2.307142857142857) * CFrame.Angles(0, 0, 0), Color3_new_ret3);
        table.insert(u67, v78);
        local v79 = part(Model, Vector3.new(0.6, 0.06, 12.2047615), CFrame.new(v * 40.652952380952385 / 2, -2.96, 9.897619047619047) * CFrame.Angles(0, 0, 0), Color3_new_ret3);
        table.insert(u67, v79);
        local v80 = part(Model, Vector3.new(0.7, 0.06, 174), CFrame.new(v * 50, -2.96, -71) * CFrame.Angles(0, 0, 0), Color3_new_ret3);
        table.insert(u67, v80);
    end;

    local v81 = part(Model, Vector3.new(1, 0.06, 1), CFrame.new(0, -2.96, -8.409523809523812) * CFrame.Angles(0, 0, 0), Color3_new_ret3);
    table.insert(u67, v81);

    for i = 0, 9 do
        local v82 = 2.2156642568073255 + (i + 0.5) * 0.9259283967824677 / 5;
        local v83 = math.sin(v82) * 20.304285714285715;
        local v84 = math.cos(v82) * 20.304285714285715 + -8.409523809523812;
        local v85 = part(Model, Vector3.new(3.8746924, 0.06, 0.6), CFrame.new(v83, -2.96, v84) * CFrame.Angles(0, v82 or 0, 0), Color3_new_ret3);
        table.insert(u67, v85);
        local _ = i;
    end;

    local SoccerNet = Parent.Presentation:FindFirstChild("SoccerNet");
    local v86;

    if SoccerNet then
        local v87 = SoccerNet:Clone();
        v87.Anchored = true;
        v87.CanCollide = false;
        v87.CanQuery = false;
        v87.CanTouch = false;
        v87.CFrame = CFrame.new(0, -3 + v87.Size.Y / 2, 16 + v87.Size.Z / 2 - 0.25) * CFrame.Angles(0, 3.141592653589793, 0);
        v87.Parent = Model;
        v86 = 16 + v87.Size.Z;
    else
        v86 = 25;
    end;

    local v88 = {
        Color3.fromRGB(44, 62, 112),
        Color3.fromRGB(150, 44, 52),
        Color3.fromRGB(58, 58, 66),
        Color3.fromRGB(214, 170, 60)
    };

    for i = 0, 5 do
        part(Model, Vector3.new(130, 2.2, 3.2), CFrame.new(0, i * 2.2 + -1.9, v86 + 12 + i * 3.2), v88[i % 4 + 1]);
        part(Model, Vector3.new(3.2, 2.2, 150), CFrame.new(-56 - i * 3.2, i * 2.2 + -1.9, -60), v88[(i + 1) % 4 + 1]);
        local _ = i;
    end;

    Model.WorldPivot = CFrame.new();

    return { Model, u67, v86 };
end;

local function stage(p89, p90) -- Line: 330
    -- upvalues: pitchEnd (copy), fieldEnd (copy)
    local v91 = p90 and "MatchDay" or "GameDay";
    p89.stages = p89.stages or {};
    local v92 = p89.stages[v91];

    if not v92 then
        if p90 then
            v92 = pitchEnd();
        else
            v92 = fieldEnd();
        end;

        p89.stages[v91] = v92;
    end;

    local v93 = v92[2];
    local v94 = v92[3];
    p89.stage = v92[1];
    p89.lines = v93;
    p89.goalBack = v94;

    return v92[1];
end;

local function shotLabel(p95, p96, p97, p98, p99) -- Line: 341
    -- upvalues: label (copy)
    local v100 = label(p95, "", p98, p99, {
        TextTransparency = 1,
        ZIndex = 6,
        Name = p96,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, p97),
        Size = UDim2.new(1, -20, 0, p98 + 6),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local UIStroke = Instance.new("UIStroke");

    for i, v in {
        Thickness = 2,
        Transparency = 1
    } do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = v100;
    local UIScale = Instance.new("UIScale");

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = v100;

    return v100;
end;

local function pop(p101, p102) -- Line: 355
    -- upvalues: TweenService (copy)
    p101.Text = p102;
    p101.UIScale.Scale = 1.35;
    TweenService:Create(p101, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        TextTransparency = 0
    }):Play();
    TweenService:Create(p101.UIStroke, TweenInfo.new(0.2), {
        Transparency = 0.2
    }):Play();
    TweenService:Create(p101.UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
        Scale = 1
    }):Play();
end;

local function fade(p103) -- Line: 362
    -- upvalues: TweenService (copy)
    TweenService:Create(p103, TweenInfo.new(0.3), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(p103.UIStroke, TweenInfo.new(0.3), {
        Transparency = 1
    }):Play();
end;

local function bar(p104, p105) -- Line: 367
    -- upvalues: Color3_new_ret2 (copy)
    local v106 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 5,
        Name = p105 and "TopBar" or "BottomBar",
        AnchorPoint = Vector2.new(0, p105 and 0 or 1),
        Position = UDim2.fromScale(0, p105 and 0 or 1),
        Size = UDim2.fromScale(1, 0)
    };
    local Frame = Instance.new("Frame");

    for i, v in v106 do
        Frame[i] = v;
    end;

    Frame.Parent = p104;
    local v107 = {
        ZIndex = 5,
        AnchorPoint = Vector2.new(0, p105 and 0 or 1),
        Position = UDim2.fromScale(0, p105 and 0 or 1),
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v107 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v108 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v108 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame2;
    local v109 = {
        BorderSizePixel = 0,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0, p105 and 1 or 0),
        Position = UDim2.fromScale(0, p105 and 1 or 0),
        Size = UDim2.new(1, 0, 1, -12),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v109 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;

    return Frame;
end;

local function cue(p110, p111, p112) -- Line: 395
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");
    local v113 = GameAudio and GameAudio:FindFirstChild("10_Football") and GameAudio["10_Football"]:FindFirstChild(p111);

    if not v113 then
        return nil;
    end;

    local v114 = v113:Clone();
    v114.Volume = p112 or v113.Volume;
    v114.Parent = p110.gui;
    v114:Play();
    table.insert(p110.game.sounds, v114);

    return v114;
end;

local u115 = { 82217872102044, 72037374064818, 107586207514159 };

local function sequence(p116, p117, p118, p119, p120, p121) -- Line: 412
    -- upvalues: SoundService (copy)
    local FootballSequenceAudio = SoundService:FindFirstChild("FootballSequenceAudio");

    if FootballSequenceAudio then
        FootballSequenceAudio = FootballSequenceAudio:FindFirstChild(p117);
    end;

    local v122;

    if FootballSequenceAudio then
        v122 = FootballSequenceAudio:Clone();
    else
        v122 = Instance.new("Sound");
    end;

    v122.SoundId = "rbxassetid://" .. p118;
    v122.Volume = p119;
    v122.Looped = p120 == true;
    v122.Parent = p116.gui;
    v122.TimePosition = p121 or 0;
    v122:Play();
    table.insert(p116.game.sounds, v122);

    return v122;
end;

local function confetti(p123, p124) -- Line: 426
    -- upvalues: Color3_fromRGB_ret7 (copy), Color3_new_ret (copy), part (copy)
    local v125 = {
        Color3_fromRGB_ret7,
        Color3.fromRGB(196, 46, 52),
        Color3.fromRGB(44, 92, 196),
        Color3_new_ret
    };
    local bits = p123.game.bits;

    for i = 1, 36 do
        local v126 = part(p123.world, Vector3.new(0.35, 0.05, 0.25), CFrame.new(p124), v125[i % 4 + 1]);
        local v127 = math.random() * 3.141592653589793 * 2;
        local v128 = math.random() * 0.9599310885968813;
        local v129 = 14 + math.random() * 12;
        local v130 = math.cos(v127) * math.sin(v128);
        local math_cos_ret = math.cos(v128);
        local v131 = math.sin(v127) * math.sin(v128);
        local v132 = {
            part = v126,
            velocity = Vector3.new(v130, math_cos_ret, v131) * v129
        };
        local math_random_ret = math.random();
        local math_random_ret2 = math.random();
        v132.spin = Vector3.new(math_random_ret, math_random_ret2, math.random()) * 12;
        table.insert(bits, v132);
        local _ = i;
    end;
end;

local function endGameDay(p133) -- Line: 438
    -- upvalues: TweenService (copy), u4 (copy), KnifeVisibility (copy)
    local game2 = p133.game;

    if not game2 then
        return;
    end;

    p133.game = nil;
    game2.connection:Disconnect();

    for _, v in game2.sounds do
        if v.Parent then
            TweenService:Create(v, TweenInfo.new(0.4), {
                Volume = 0
            }):Play();
            task.delay(0.45, function() -- Line: 448
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;
    end;

    for _, v in game2.bits do
        v.part:Destroy();
    end;

    for _, v in game2.labels do
        v:Destroy();
    end;

    game2.top:Destroy();
    game2.bottom:Destroy();
    game2.flash:Destroy();

    for i in u4 do
        local v134 = p133.tracks[i];

        if v134 and v134.IsPlaying then
            v134:Stop(0.1);
        end;
    end;

    if p133.ball then
        KnifeVisibility.set(p133.ball, false);
    end;

    if p133.stage then
        p133.stage.Parent = nil;
    end;

    p133.tip.Visible = true;
    p133.camera.FieldOfView = 40;
    p133.clone:PivotTo(CFrame.new());
    p133.fit();
    p133.clone:PivotTo(CFrame.Angles(0, p133.yaw, 0));
    p133.knife:show(true);
    local Hold = p133.tracks.Hold;

    if Hold and not Hold.IsPlaying then
        Hold:Play(0.2);
    end;
end;

local function settle(p135, p136, p137) -- Line: 486
    -- upvalues: endGameDay (copy), KnifeVisibility (copy), EmotePieces (copy)
    endGameDay(p135);

    if p135.ball then
        KnifeVisibility.set(p135.ball, false);
    end;

    if p135.pieces then
        EmotePieces.clear(p135.pieces);
        p135.pieces = nil;
    end;

    if p135.loop then
        p135.loop:Destroy();
        p135.loop = nil;
    end;

    for i, v in p135.tracks do
        if i ~= p136 and (i ~= "Hold" or not p137) and v.IsPlaying then
            v:Stop(0.1);
        end;
    end;

    if p137 then
        local Hold = p135.tracks.Hold;

        if Hold and not Hold.IsPlaying then
            Hold:Play(0.1);
        end;
    end;
end;

local function gameDay(u138, p139) -- Line: 514
    -- upvalues: highlight (copy), settle (copy), load (copy), KnifeClips (copy), u4 (copy), MatchDay (copy), stage (copy), TweenService (copy), Timing (copy), bar (copy), Color3_new_ret (copy), shotLabel (copy), Color3_fromRGB_ret7 (copy), LocalPlayer (copy), FootballShots (copy), RunService (copy), u5 (ref), sequence (copy), cue (copy), pop (copy), KnifeVisibility (copy), fade (copy), u115 (copy), confetti (copy), endGameDay (copy)
    local u140 = p139.key == "MatchDay";
    u138.token = u138.token + 1;
    highlight(u138, p139.key);
    u138.info.Text = p139.label .. "  ·  Hero and last-runner show";
    settle(u138, nil, false);
    local token = u138.token;
    local v141 = u140 and "Intro" or "Catch";
    local u142 = load(u138, v141, KnifeClips.normalize(u138.model:GetAttribute(u4[v141])), Enum.AnimationPriority.Action3, (v141 == "IntroLoop" or v141 == "CelebrateLoop") and true or v141 == "Run");
    local v143 = u140 and "Celebrate" or "Touchdown";
    local u144 = load(u138, v143, KnifeClips.normalize(u138.model:GetAttribute(u4[v143])), Enum.AnimationPriority.Action3, (v143 == "IntroLoop" or v143 == "CelebrateLoop") and true or v143 == "Run");
    local u145;

    if u140 then
        u145 = load(u138, "IntroLoop", KnifeClips.normalize(u138.model:GetAttribute(u4.IntroLoop)), Enum.AnimationPriority.Action3, true);
    else
        u145 = u140;
    end;

    local u146;

    if u140 then
        u146 = load(u138, "CelebrateLoop", KnifeClips.normalize(u138.model:GetAttribute(u4.CelebrateLoop)), Enum.AnimationPriority.Action3, true);
    else
        u146 = u140;
    end;

    local u147;

    if u140 then
        u147 = load(u138, "Run", KnifeClips.normalize(u138.model:GetAttribute(u4.Run)), Enum.AnimationPriority.Action3, true);
    else
        u147 = u140;
    end;

    local RunUp = MatchDay.RunUp;
    local Slide = MatchDay.Slide;
    local RunUpDistance = MatchDay.RunUpDistance;
    local u148 = RunUpDistance * Slide / (2 * RunUp);
    u138.tip.Visible = false;
    u138.clone:PivotTo(CFrame.new());
    u138.knife:hide();
    local HumanoidRootPart = u138.clone:FindFirstChild("HumanoidRootPart");
    local u149 = HumanoidRootPart and (HumanoidRootPart.Position or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0);
    local v150 = stage(u138, u140);
    v150:PivotTo(CFrame.new(u149));
    v150.Parent = u138.world;

    for i, v in u138.lines do
        v.Transparency = 1;
        TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1 + i * 0.03), {
            Transparency = 0
        }):Play();
    end;

    local v151 = (Vector3.new(0, 0, -1)):Cross(Vector3.new(0, 1, 0));
    local u152 = u149 + Vector3.new(0, 1.5, 0);
    local CFrame_lookAt_ret = CFrame.lookAt(u152 - (Vector3.new(0, -0.2419219, -0.9702957)).Unit * 12.5, u152);
    local Kickoff = Timing.Kickoff;
    local Touchdown = Timing.Touchdown;
    local CatchDelay = Timing.CatchDelay;
    local v153 = CatchDelay + Timing.CatchAt / Timing.CatchSpeed;
    local SpikeAt = Timing.SpikeAt;
    local u154, u155, u156, u157;

    if u140 then
        Kickoff = MatchDay.Kickoff;
        Touchdown = MatchDay.Celebrate;
        CatchDelay = MatchDay.JuggleDelay;
        SpikeAt = MatchDay.RunUp + MatchDay.CheerAt;
        local Attribute = u138.model:GetAttribute("IntroAnimLength");
        local Attribute2 = u138.model:GetAttribute("CelebrateAnimLength");
        u154 = (type(Attribute) ~= "number" and 1.5 or Attribute) - MatchDay.Blend;
        u155 = (type(Attribute2) ~= "number" and 0.75 or Attribute2) - MatchDay.Blend;
        v153 = CatchDelay + u154 + MatchDay.Blend;
        u156 = "MATCH DAY";
        u157 = "GOAL!";
    else
        u156 = "GAME DAY";
        u155 = 0;
        u154 = 0;
        u157 = "TOUCHDOWN!";
    end;

    local u158 = {
        forward = Vector3.new(0, 0, -1),
        right = v151,
        throw = CatchDelay,
        catch = v153,
        back = Kickoff - 1.4
    };
    local u159 = {
        forward = Vector3.new(0, 0, -1),
        right = v151,
        back = Touchdown - 1.25,
        spike = SpikeAt
    };
    local u160;

    if u140 then
        u159.forward = Vector3.new(-0, -0, 1);
        u159.right = -v151;
        u160 = (u138.goalBack or 25) - MatchDay.NetGap - (RunUpDistance + u148);
    else
        u160 = 0;
    end;

    local u161 = u149 - Vector3.new(0, 0, -1) * u160 + Vector3.new(0, 1.5, 0);
    local CFrame_lookAt_ret2 = CFrame.lookAt(u161 - (Vector3.new(-0, -0.2419219, 0.9702957)).Unit * 12.5, u161);
    local u162 = {
        shakeUntil = 0,
        token = token,
        sounds = {},
        bits = {},
        fired = {},
        top = bar(u138.card, true),
        bottom = bar(u138.card, false)
    };
    local card = u138.card;
    local v163 = {
        Name = "Flash",
        BackgroundTransparency = 1,
        ZIndex = 7,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v163 do
        Frame[i] = v;
    end;

    Frame.Parent = card;
    u162.flash = Frame;
    local flash = u162.flash;
    local v164 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v164 do
        UICorner[i] = v;
    end;

    UICorner.Parent = flash;
    local u165 = shotLabel(u138.card, "Eyebrow", 0.71, 15, Color3_fromRGB_ret7);
    local u166 = shotLabel(u138.card, "Title", 0.785, 26, Color3_new_ret);
    local u167 = shotLabel(u138.card, "Subtitle", 0.855, 13, Color3_new_ret);
    u162.labels = { u165, u166, u167 };
    u138.game = u162;
    local string_upper_ret = string.upper(LocalPlayer.DisplayName);
    local os_clock_ret = os.clock();
    local u168 = os_clock_ret;

    local function once(p169, p170, p171, p172) -- Line: 600
        -- upvalues: u162 (copy)
        if not u162.fired[p169] and p171 <= p170 then
            u162.fired[p169] = true;
            p172();
        end;
    end;

    local function bars(p173, p174) -- Line: 606
        -- upvalues: FootballShots (ref), u162 (copy)
        local v175 = FootballShots.smoother(p173 / 0.75) * (1 - FootballShots.smoother((p173 - p174 + 0.75) / 0.7));
        u162.top.Size = UDim2.fromScale(1, 0.11 * v175);
        u162.bottom.Size = UDim2.fromScale(1, 0.11 * v175);
    end;

    local function frame(p176, p177, p178, p179, p180, p181, p182, p183) -- Line: 613
        -- upvalues: CFrame_lookAt_ret (copy), u152 (copy), FootballShots (ref)
        local v184 = p182 or CFrame_lookAt_ret;
        local v185 = p183 or u152;

        if p178 < p179 then
            local v186 = FootballShots.smoother(p178 / p179);
            p176 = FootballShots.orbit(v184, p176, v186, v185);
            p177 = 70 + (p177 - 70) * v186;
        elseif p180 < p178 then
            local v187 = FootballShots.smoother((p178 - p180) / (p181 - 0.2 - p180));
            p176 = FootballShots.orbit(p176, v184, v187, v185);
            p177 = p177 + (70 - p177) * v187;
        end;

        return p176, p177;
    end;

    u162.connection = RunService.RenderStepped:Connect(function() -- Line: 627
        -- upvalues: u5 (ref), u138 (copy), u162 (copy), u168 (ref), os_clock_ret (copy), Kickoff (ref), sequence (ref), u140 (copy), TweenService (ref), cue (ref), pop (ref), u165 (copy), u156 (ref), CatchDelay (ref), u142 (copy), KnifeVisibility (ref), u154 (ref), u145 (copy), MatchDay (ref), Timing (ref), u158 (copy), u166 (copy), string_upper_ret (copy), u167 (copy), fade (ref), FootballShots (ref), u149 (ref), frame (copy), bars (copy), CFrame_lookAt_ret (copy), Touchdown (ref), u147 (copy), RunUpDistance (copy), RunUp (copy), u144 (copy), u148 (copy), Slide (copy), u160 (ref), HumanoidRootPart (copy), u155 (ref), u146 (copy), u159 (copy), u115 (ref), u157 (ref), Color3_fromRGB_ret7 (ref), confetti (ref), CFrame_lookAt_ret2 (copy), u161 (copy), endGameDay (ref)
        if u5 ~= u138 or u138.game ~= u162 then
            return;
        end;

        local os_clock_ret2 = os.clock();
        local math_min_ret = math.min(os_clock_ret2 - u168, 0.1);
        u168 = os_clock_ret2;
        local v188 = os_clock_ret2 - os_clock_ret;
        local v189, v190;

        if v188 < Kickoff then
            local function v192() -- Line: 637
                -- upvalues: sequence (ref), u138 (ref), u140 (ref), TweenService (ref), cue (ref)
                sequence(u138, "Sting", 128362753120295, 0.8, false, u140 and 1.3 or 0.8);
                TweenService:Create(sequence(u138, "Song", 105536563312044, 0, true), TweenInfo.new(0.8), {
                    Volume = 0.45
                }):Play();
                cue(u138, "Whistle");
                local v191 = cue(u138, "CrowdBed", 0);

                if v191 then
                    TweenService:Create(v191, TweenInfo.new(1.2), {
                        Volume = v191.Volume + 0.45
                    }):Play();
                end;
            end;

            if not u162.fired.whistle and v188 >= 0.05 then
                u162.fired.whistle = true;
                v192();
            end;

            local function _() -- Line: 647
                -- upvalues: pop (ref), u165 (ref), u156 (ref)
                pop(u165, u156);
            end;

            if not u162.fired.eyebrow and v188 >= 0.3 then
                u162.fired.eyebrow = true;
                pop(u165, u156);
            end;

            if u140 then
                local function _() -- Line: 652
                    -- upvalues: u142 (ref), u138 (ref), KnifeVisibility (ref)
                    if u142 then
                        u142.Looped = false;
                        u142:Play(0.12);
                    end;

                    if u138.ball then
                        KnifeVisibility.set(u138.ball, true);
                    end;
                end;

                if not u162.fired.throw and CatchDelay <= v188 then
                    u162.fired.throw = true;

                    if u142 then
                        u142.Looped = false;
                        u142:Play(0.12);
                    end;

                    if u138.ball then
                        KnifeVisibility.set(u138.ball, true);
                    end;
                end;

                local function _() -- Line: 661
                    -- upvalues: u145 (ref), MatchDay (ref), u142 (ref)
                    if u145 then
                        u145:Play(MatchDay.Blend);
                    end;

                    if u142 then
                        u142:Stop(MatchDay.Blend);
                    end;
                end;

                if not u162.fired.loop and CatchDelay + u154 <= v188 then
                    u162.fired.loop = true;

                    if u145 then
                        u145:Play(MatchDay.Blend);
                    end;

                    if u142 then
                        u142:Stop(MatchDay.Blend);
                    end;
                end;
            else
                local function _() -- Line: 670
                    -- upvalues: u142 (ref), Timing (ref)
                    if u142 then
                        u142:Play(0.12, 1, Timing.CatchSpeed);
                    end;
                end;

                if not u162.fired.throw and CatchDelay <= v188 then
                    u162.fired.throw = true;

                    if u142 then
                        u142:Play(0.12, 1, Timing.CatchSpeed);
                    end;
                end;

                local function _() -- Line: 675
                    -- upvalues: u138 (ref)
                    u138.knife:show(true);
                end;

                if not u162.fired.ball and CatchDelay + Timing.ThrowAt / Timing.CatchSpeed <= v188 then
                    u162.fired.ball = true;
                    u138.knife:show(true);
                end;
            end;

            local function v193() -- Line: 679
                -- upvalues: cue (ref), u138 (ref), u162 (ref), TweenService (ref), pop (ref), u166 (ref), string_upper_ret (ref), os_clock_ret2 (copy)
                cue(u138, "CrowdSurge");
                u162.flash.BackgroundTransparency = 0.65;
                TweenService:Create(u162.flash, TweenInfo.new(0.25), {
                    BackgroundTransparency = 1
                }):Play();
                pop(u166, string_upper_ret .. " HAS THE BALL");
                u162.shakeUntil = os_clock_ret2 + 0.3;
            end;

            if not u162.fired.catch and u158.catch - 0.02 <= v188 then
                u162.fired.catch = true;
                v193();
            end;

            local function _() -- Line: 686
                -- upvalues: pop (ref), u167 (ref)
                pop(u167, "HERO RUN  ·  CROSS ALONE");
            end;

            if not u162.fired.subtitle and u158.catch + 0.55 <= v188 then
                u162.fired.subtitle = true;
                pop(u167, "HERO RUN  ·  CROSS ALONE");
            end;

            local function _() -- Line: 689
                -- upvalues: fade (ref), u165 (ref), u166 (ref), u167 (ref)
                fade(u165);
                fade(u166);
                fade(u167);
            end;

            if not u162.fired.titles and u158.back <= v188 then
                u162.fired.titles = true;
                fade(u165);
                fade(u166);
                fade(u167);
            end;

            local v194;

            if u140 then
                v194 = FootballShots.juggle;
            else
                v194 = FootballShots.catch;
            end;

            local v195, v196 = v194(u158, v188, u149);
            v189, v190 = frame(v195, v196, v188, CatchDelay, u158.back, Kickoff);
            bars(v188, Kickoff);
        elseif v188 < Kickoff + 0.5 then
            v189 = CFrame_lookAt_ret;
            bars(0, Kickoff);
            v190 = 70;
        else
            if v188 >= Kickoff + 0.5 + Touchdown then
                endGameDay(u138);

                return;
            end;

            local v197 = v188 - Kickoff - 0.5;

            local function v198() -- Line: 702
                -- upvalues: u142 (ref), u145 (ref), u140 (ref), u147 (ref), RunUpDistance (ref), RunUp (ref), u138 (ref), KnifeVisibility (ref), u144 (ref), cue (ref), pop (ref), u165 (ref), u156 (ref), sequence (ref)
                for _, v in { u142, u145 } do
                    if v and v.IsPlaying then
                        v:Stop(0.1);
                    end;
                end;

                if u140 then
                    if u147 then
                        u147:Play(0.1, 1, (math.clamp(RunUpDistance / RunUp / 28, 0.5, 1.5)));
                    end;

                    if u138.ball then
                        KnifeVisibility.set(u138.ball, false);
                    end;
                elseif u144 then
                    u144.Looped = false;
                    u144:Play(0.1);
                    cue(u138, "TouchdownCelebration");
                end;

                pop(u165, u156);
                sequence(u138, "Sting", 128362753120295, 0.8);
            end;

            if not u162.fired.touchdown and Kickoff + 0.5 <= v188 then
                u162.fired.touchdown = true;
                v198();
            end;

            if u140 then
                local v199;

                if v197 < RunUp then
                    v199 = RunUpDistance * v197 / RunUp;
                else
                    v199 = RunUpDistance + u148 * (1 - (1 - math.min(1, (v197 - RunUp) / Slide)) ^ 2);
                end;

                u138.clone:PivotTo(CFrame.new(Vector3.new(-0, -0, 1) * (u160 + v199)) * CFrame.Angles(0, 3.141592653589793, 0));

                if HumanoidRootPart then
                    u149 = HumanoidRootPart.Position;
                end;

                local function _() -- Line: 733
                    -- upvalues: u147 (ref), u144 (ref)
                    if u147 then
                        u147:Stop(0.1);
                    end;

                    if u144 then
                        u144.Looped = false;
                        u144:Play(0.1);
                    end;
                end;

                if not u162.fired.slide and RunUp <= v197 then
                    u162.fired.slide = true;

                    if u147 then
                        u147:Stop(0.1);
                    end;

                    if u144 then
                        u144.Looped = false;
                        u144:Play(0.1);
                    end;
                end;

                local function _() -- Line: 742
                    -- upvalues: u146 (ref), MatchDay (ref), u144 (ref)
                    if u146 then
                        u146:Play(MatchDay.Blend);
                    end;

                    if u144 then
                        u144:Stop(MatchDay.Blend);
                    end;
                end;

                if not u162.fired.celebrate and RunUp + u155 <= v197 then
                    u162.fired.celebrate = true;

                    if u146 then
                        u146:Play(MatchDay.Blend);
                    end;

                    if u144 then
                        u144:Stop(MatchDay.Blend);
                    end;
                end;
            end;

            local function _() -- Line: 751
                -- upvalues: u115 (ref), sequence (ref), u138 (ref), pop (ref), u166 (ref), u157 (ref), Color3_fromRGB_ret7 (ref), confetti (ref), u149 (ref), u162 (ref), os_clock_ret2 (copy)
                local math_random_ret = math.random(1, #u115);
                sequence(u138, "Cheer" .. math_random_ret, u115[math_random_ret], 0.8);
                pop(u166, u157);
                u166.TextColor3 = Color3_fromRGB_ret7;
                confetti(u138, u149 + Vector3.new(0, 2, 0));
                u162.shakeUntil = os_clock_ret2 + 0.35;
            end;

            if not u162.fired.spike and u159.spike - 0.05 <= v197 then
                u162.fired.spike = true;
                local math_random_ret = math.random(1, #u115);
                sequence(u138, "Cheer" .. math_random_ret, u115[math_random_ret], 0.8);
                pop(u166, u157);
                u166.TextColor3 = Color3_fromRGB_ret7;
                confetti(u138, u149 + Vector3.new(0, 2, 0));
                u162.shakeUntil = os_clock_ret2 + 0.35;
            end;

            local function _() -- Line: 759
                -- upvalues: pop (ref), u167 (ref), string_upper_ret (ref)
                pop(u167, string_upper_ret .. " SCORES");
            end;

            if not u162.fired.scores and u159.spike + 0.45 <= v197 then
                u162.fired.scores = true;
                pop(u167, string_upper_ret .. " SCORES");
            end;

            local function _() -- Line: 762
                -- upvalues: fade (ref), u165 (ref), u166 (ref), u167 (ref)
                fade(u165);
                fade(u166);
                fade(u167);
            end;

            if not u162.fired.titles2 and u159.back <= v197 then
                u162.fired.titles2 = true;
                fade(u165);
                fade(u166);
                fade(u167);
            end;

            local v200;

            if u140 then
                v200 = FootballShots.goal;
            else
                v200 = FootballShots.touchdown;
            end;

            local v201, v202 = v200(u159, v197, u149);

            if u140 then
                v189, v190 = frame(v201, v202, v197, 0.7, u159.back, Touchdown, CFrame_lookAt_ret2, u161);
            else
                v189, v190 = frame(v201, v202, v197, 0.7, u159.back, Touchdown);
            end;

            bars(v197, Touchdown);
        end;

        if os_clock_ret2 < u162.shakeUntil then
            local v203 = (u162.shakeUntil - os_clock_ret2) * 2.2;
            local CFrame_Angles = CFrame.Angles;
            local v204 = (math.random() - 0.5) * v203;
            local math_rad_ret = math.rad(v204);
            local v205 = (math.random() - 0.5) * v203;
            v189 = v189 * CFrame_Angles(math_rad_ret, math.rad(v205), 0);
        end;

        u138.camera.CFrame = v189;
        u138.camera.FieldOfView = v190;

        for i = #u162.bits, 1, -1 do
            local v206 = u162.bits[i];
            v206.velocity = v206.velocity + Vector3.new(0, -26, 0) * math_min_ret;
            v206.velocity = v206.velocity * (1 - math.min(1, math_min_ret * 1.5));
            v206.part.CFrame = (v206.part.CFrame + v206.velocity * math_min_ret) * CFrame.Angles(v206.spin.X * math_min_ret, v206.spin.Y * math_min_ret, v206.spin.Z * math_min_ret);
            local v207;

            if v206.part.Position.Y < u149.Y - 3 then
                v206.part:Destroy();
                table.remove(u162.bits, i);
                v207 = i;
            else
                v207 = i;
            end;
        end;
    end);
end;

local function emote(u208, p209) -- Line: 799
    -- upvalues: highlight (copy), settle (copy), load (copy), EmoteCatalog (copy), EmotePieces (copy), KnifeVisibility (copy), KnifeClips (copy), u5 (ref)
    local emote = p209.emote;
    u208.token = u208.token + 1;
    highlight(u208, p209.key);
    u208.info.Text = emote.Name .. "  ·  Emote  ·  " .. (emote.Source or "Comes with this knife");
    settle(u208, p209.key, false);
    local u210 = load(u208, p209.key, EmoteCatalog.assetId(emote.Id), Enum.AnimationPriority.Action4, true);

    if not u210 then
        return;
    end;

    local u211 = emote.Intro and load(u208, p209.key .. ":Intro", EmoteCatalog.introId(emote.Id), Enum.AnimationPriority.Action4, false);

    if u211 and u210.IsPlaying then
        u210:Stop(0.1);
    end;

    if emote.Pieces then
        u208.pieces = EmotePieces.build(u208.clone, emote, u208.model, u208.clone);
    end;

    if emote.Prop == nil or not u208.ball then
        if emote.HideProp then
            u208.knife:hide();
        else
            local v212;

            if emote.Prop == nil then
                v212 = false;
            else
                v212 = EmoteCatalog.holdsIdle(emote.Id, u208.model.Name);
            end;

            u208.knife:show(emote.Prop ~= nil, not v212 and "Right Arm" or nil);
            local v213;

            if v212 then
                local Hold = KnifeClips.Actions.Hold;
                v213 = load(u208, "Hold", KnifeClips.id(u208.model, "Hold"), Hold.priority, Hold.looped);
            else
                v213 = u208.knife.chain and load(u208, "Stow", KnifeClips.stow(u208.model), KnifeClips.Stow.priority, KnifeClips.Stow.looped);
            end;

            if v213 then
                v213:Play(0.15);
            end;
        end;
    else
        u208.knife:hide();
        KnifeVisibility.set(u208.ball, true);
    end;

    local token = u208.token;
    local u214 = u211 or u210;

    local function u228() -- Line: 839
        -- upvalues: u211 (copy), emote (copy), u5 (ref), u208 (copy), token (copy), u210 (copy), EmoteCatalog (ref)
        if u211 then
            u211.Looped = false;
            u211:Play(0.15);
            u211.TimePosition = 0;
            task.delay(math.max(0.1, (emote.IntroLength or u211.Length) - 0.1), function() -- Line: 844
                -- upvalues: u5 (ref), u208 (ref), token (ref), u210 (ref), u211 (ref)
                if u5 == u208 and u208.token == token then
                    u210.Looped = true;
                    u210:Play(0.1);
                    u210.TimePosition = 0;
                    u211:Stop(0.1);
                end;
            end);
        else
            u210.Looped = true;
            u210:Play(0.15);
            u210.TimePosition = 0;
        end;

        local v215 = EmoteCatalog.soundId(emote.Id);

        if v215 then
            local gui = u208.gui;
            local v216 = {
                SoundId = v215,
                Looped = emote.SoundEachLoop ~= true,
                Volume = emote.Volume or 0.25
            };
            local Sound = Instance.new("Sound");

            for i, v in v216 do
                Sound[i] = v;
            end;

            Sound.Parent = gui;
            u208.loop = Sound;
            local v217, v218, v219 = EmoteCatalog.soundIds(emote.Id);
            local u220 = {};

            for i, v in v217 do
                if i > 1 then
                    local v221 = {
                        SoundId = v
                    };
                    v221.Looped = Sound.Looped and not v219[i];
                    v221.Volume = v218[i];
                    local Sound2 = Instance.new("Sound");
                    local v222 = i;

                    for i2, v2 in v221 do
                        Sound2[i2] = v2;
                    end;

                    Sound2.Parent = Sound;

                    if v219[v222] then
                        u220[Sound2] = v219[v222];
                    end;
                end;
            end;

            local u223 = tonumber(emote.SoundDelay) or 0;

            local function start() -- Line: 875
                -- upvalues: u5 (ref), u208 (ref), token (ref), Sound (copy), u220 (copy)
                if u5 == u208 and (u208.token == token and u208.loop == Sound) then
                    Sound.TimePosition = 0;
                    Sound:Play();

                    for _, child in Sound:GetChildren() do
                        if child:IsA("Sound") and not u220[child] then
                            child.TimePosition = 0;
                            child:Play();
                        end;
                    end;
                end;
            end;

            local u224;

            if emote.SoundEachLoop == true then
                local v225 = tonumber(emote.SoundPerLoop) or 1;
                local math_floor_ret = math.floor(v225);
                u224 = math.clamp(math_floor_ret, 1, 8);
            else
                u224 = 1;
            end;

            local function loopStarted() -- Line: 892
                -- upvalues: u223 (copy), start (copy), u210 (ref), emote (ref), u224 (copy)
                if u223 > 0 then
                    task.delay(u223, start);
                else
                    start();
                end;

                local v226 = u210.Length > 0 and u210.Length or (tonumber(emote.Length) or 0);

                for i = 1, u224 - 1 do
                    task.delay(u223 + i * v226 / u224, start);
                    local _ = i;
                end;
            end;

            local function delayedStarts() -- Line: 904
                -- upvalues: u220 (copy), u5 (ref), u208 (ref), token (ref), Sound (copy)
                for i, v in u220 do
                    task.delay(v, function() -- Line: 906
                        -- upvalues: u5 (ref), u208 (ref), token (ref), Sound (ref), i (copy)
                        if u5 == u208 and (u208.token == token and (u208.loop == Sound and i.Parent)) then
                            i.TimePosition = 0;
                            i:Play();
                        end;
                    end);
                end;
            end;

            loopStarted();
            delayedStarts();

            if emote.SoundEachLoop == true or next(u220) ~= nil then
                local u227 = nil;
                u227 = u210.DidLoop:Connect(function() -- Line: 918
                    -- upvalues: u5 (ref), u208 (ref), token (ref), Sound (copy), u227 (ref), emote (ref), loopStarted (copy), delayedStarts (copy)
                    if u5 ~= u208 or (u208.token ~= token or u208.loop ~= Sound) then
                        u227:Disconnect();

                        return;
                    end;

                    if emote.SoundEachLoop == true then
                        loopStarted();
                    end;

                    delayedStarts();
                end);
                table.insert(u208.connections, u227);
            end;
        end;
    end;

    if u214.Length > 0 then
        u228();

        return;
    end;

    task.spawn(function() -- Line: 211
        -- upvalues: u5 (ref), u208 (copy), token (copy), u214 (copy), u228 (copy)
        local v229 = os.clock() + 3;

        while u5 == u208 and (u208.token == token and (u214.Length <= 0 and os.clock() < v229)) do
            task.wait(0.05);
        end;

        if u5 == u208 and u208.token == token then
            u228();
        end;
    end);
end;

local function close() -- Line: 935
    -- upvalues: u5 (ref), endGameDay (copy), Cursor (copy)
    local v230 = u5;

    if not v230 then
        return;
    end;

    u5 = nil;
    endGameDay(v230);

    for _, v in v230.connections do
        v:Disconnect();
    end;

    for _, v in v230.tracks do
        v:Stop(0);
        v:Destroy();
    end;

    for _, v in v230.assets do
        v:Destroy();
    end;

    if v230.knife then
        v230.knife:remove();
    end;

    for _, v in v230.stages or {} do
        v[1]:Destroy();
    end;

    Cursor.release(v230.gui);
    v230.gui:Destroy();
end;

u1.close = close;

local function show(u231, u232) -- Line: 964
    -- upvalues: u2 (copy), highlight (copy), KnifeClips (copy), settle (copy), load (copy), DaggerConfig (copy), u5 (ref)
    local u233 = u2[u232];
    local v234 = u231.token + 1;
    u231.event = u232;
    u231.token = v234;
    highlight(u231, u232);
    u231.info.Text = u233.label .. (KnifeClips.custom(u231.model, u233.action) and "  ·  Custom animation" or "  ·  Standard animation");
    settle(u231, u233.action, true);
    local action = u233.action;
    local v235 = KnifeClips.Actions[action];
    local u236 = load(u231, action, KnifeClips.id(u231.model, action), v235.priority, v235.looped);

    if not u236 then
        return;
    end;

    local token = u231.token;

    local function u237() -- Line: 976
        -- upvalues: u233 (copy), u236 (copy), KnifeClips (ref), u231 (copy), DaggerConfig (ref), u5 (ref), token (copy), u232 (copy)
        u236:Play(0.08, 1, u233.window and (u236.Length > 0 and KnifeClips.fit(u236.Length, u233.window)) or 1);
        u236.TimePosition = 0;
        u231.knife:show(u233.action ~= "Equip" and true or u231.knife.chain ~= nil);

        if u233.action == "Equip" then
            task.delay(DaggerConfig.DrawTransfer, function() -- Line: 983
                -- upvalues: u5 (ref), u231 (ref), token (ref)
                if u5 == u231 and u231.token == token then
                    u231.knife:show(true);
                end;
            end);
        end;

        task.delay(u233.cue, function() -- Line: 989
            -- upvalues: u5 (ref), u231 (ref), token (ref), u232 (ref)
            if u5 == u231 and u231.token == token then
                u231.sound(u232);
            end;
        end);
    end;

    if u236.Length > 0 then
        u237();

        return;
    end;

    task.spawn(function() -- Line: 211
        -- upvalues: u5 (ref), u231 (copy), token (copy), u236 (copy), u237 (copy)
        local v238 = os.clock() + 3;

        while u5 == u231 and (u231.token == token and (u236.Length <= 0 and os.clock() < v238)) do
            task.wait(0.05);
        end;

        if u5 == u231 and u231.token == token then
            u237();
        end;
    end);
end;

local function pick(p239, p240) -- Line: 996
    -- upvalues: u2 (copy), show (copy), gameDay (copy), emote (copy)
    p239.picked = p240;

    if u2[p240] then
        show(p239, p240);

        return;
    end;

    for _, v in p239.extras do
        if v.key == p240 then
            if v.show then
                gameDay(p239, v);

                return;
            end;

            emote(p239, v);

            return;
        end;
    end;
end;

local function button(u241, p242, u243, p244, p245, p246) -- Line: 1015
    -- upvalues: Color3_fromRGB_ret (copy), label (copy), Color3_new_ret (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), pick (copy)
    local v247 = {
        BackgroundTransparency = 0.2,
        AutoButtonColor = true,
        Text = "",
        Name = u243,
        LayoutOrder = p245,
        Size = UDim2.new(p246, 0, 1, 0),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v247 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p242;
    label(TextButton, p244, 18, Color3_new_ret, {
        Name = "TextLabel",
        ZIndex = 2,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v248 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v248 do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton;
    local v249 = {
        Thickness = 3,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v249 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton;
    local v250 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v250 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton;
    local v251 = {
        Rotation = 90,
        Enabled = false,
        Color = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret4)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v251 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton;
    u241.buttons[u243] = {
        button = TextButton,
        gradient = UIGradient,
        edge = UIStroke2
    };
    table.insert(u241.connections, TextButton.Activated:Connect(function() -- Line: 1043
        -- upvalues: pick (ref), u241 (copy), u243 (copy)
        pick(u241, u243);
    end));
end;

local function buttonRow(p252, p253, p254) -- Line: 1048
    local v255 = {
        BackgroundTransparency = 1,
        Name = p253,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -p254),
        Size = UDim2.new(1, -20, 0, 48)
    };
    local Frame = Instance.new("Frame");

    for i, v in v255 do
        Frame[i] = v;
    end;

    Frame.Parent = p252;
    local v256 = {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0.035, 0),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local UIListLayout = Instance.new("UIListLayout");

    for i, v in v256 do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame;

    return Frame;
end;

function u1.open(u257, u258, p259) -- Line: 1067
    -- upvalues: template (copy), u2 (copy), u5 (ref), pick (copy), close (copy), CharacterClone (copy), LocalPlayer (copy), Cursor (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), label (copy), Color3_new_ret (copy), Color3_fromRGB_ret5 (copy), Font_new_ret (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret3 (copy), buttonRow (copy), u3 (copy), button (copy), ClientBotKnife (copy), KnifeChains (copy), RunService (copy), rootPiece (copy), KnifeClips (copy), load (copy), u4 (copy), CharacterFrame (copy), UserInputService (copy), u1 (copy)
    local v260, v261, v262 = template(u257);

    if not v260 then
        return false;
    end;

    local v263 = u2[u258] ~= nil;

    for _, v in v262 do
        v263 = v263 or v.key == u258;
    end;

    if not v263 then
        return false;
    end;

    if u5 and u5.skin == u257 then
        u5.sound = p259;
        pick(u5, u258);

        return true;
    end;

    close();
    local u264, v265 = CharacterClone.copy(LocalPlayer.Character);

    if not u264 then
        return false;
    end;

    local u266 = #v262 > 0 and 58 or 0;
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local v267 = {
        Name = "KnifeClipPreview",
        DisplayOrder = 1000,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in v267 do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = PlayerGui;
    local u268 = {
        token = 0,
        yaw = -0.4363323129985824,
        skin = u257,
        model = v260,
        extras = v262,
        gui = ScreenGui,
        sound = p259,
        tracks = {},
        assets = {},
        buttons = {},
        connections = {}
    };
    u5 = u268;
    Cursor.request(ScreenGui);
    local v269 = {
        Name = "Shade",
        BackgroundTransparency = 0.35,
        AutoButtonColor = false,
        Text = "",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.5, 1.5),
        BackgroundColor3 = Color3_new_ret2
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v269 do
        TextButton[i] = v;
    end;

    TextButton.Parent = ScreenGui;
    table.insert(u268.connections, TextButton.Activated:Connect(close));
    local v270 = {
        Name = "Panel",
        BackgroundTransparency = 0.2,
        Active = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(440, 560 + u266),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v270 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v271 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v271 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v272 = {
        Thickness = 3,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v272 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v273 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v273 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    local connections = u268.connections;
    local PropertyChangedSignal = ScreenGui:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 1137, Name: fitScreen
        -- upvalues: ScreenGui (copy), UIScale (copy), u266 (copy)
        local AbsoluteSize = ScreenGui.AbsoluteSize;

        if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
            UIScale.Scale = math.min(AbsoluteSize.X * 0.92 / 440, AbsoluteSize.Y * 0.86 / (560 + u266), 1.25);
        end;
    end));
    local AbsoluteSize = ScreenGui.AbsoluteSize;

    if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
        UIScale.Scale = math.min(AbsoluteSize.X * 0.92 / 440, AbsoluteSize.Y * 0.86 / (560 + u266), 1.25);
    end;

    local v274 = {
        Name = "Header",
        BackgroundTransparency = 0.5,
        Position = UDim2.fromOffset(10, 10),
        Size = UDim2.new(1, -20, 0, 62),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v274 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v275 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v275 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v276 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v276 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = Frame2;
    label(Frame2, v261.Name, 24, Color3_new_ret, {
        Name = "Title",
        TextScaled = true,
        Position = UDim2.fromOffset(16, 8),
        Size = UDim2.new(1, -70, 0, 28)
    });
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "InfoBox";
    Frame3.BackgroundTransparency = 1;
    Frame3.Position = UDim2.fromOffset(16, 36);
    Frame3.Size = UDim2.new(1, -70, 0, 18);
    Frame3:SetAttribute("SelfManagedText", true);
    Frame3.Parent = Frame2;
    u268.info = label(Frame3, "", 16, Color3_fromRGB_ret5, {
        Name = "Info",
        TextScaled = true,
        Size = UDim2.fromScale(1, 1)
    });
    local info = u268.info;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 16,
        MinTextSize = 8
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = info;
    local v277 = {
        Name = "CloseButton",
        BackgroundTransparency = 1,
        Text = "x",
        TextSize = 30,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(40, 40),
        FontFace = Font_new_ret,
        TextColor3 = Color3_fromRGB_ret6
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v277 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame2;
    table.insert(u268.connections, TextButton2.Activated:Connect(close));
    local v278 = {
        Name = "Item",
        Position = UDim2.fromOffset(10, 84),
        Size = UDim2.new(1, -20, 1, -160 - u266),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v278 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame;
    u268.card = Frame4;
    local v279 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret3),
        Transparency = NumberSequence.new(0.2, 0.6)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v279 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame4;
    local v280 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v280 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame4;
    local v281 = {
        Thickness = 3,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v281 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = Frame4;
    local v282 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret3,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke5 = Instance.new("UIStroke");

    for i, v in v282 do
        UIStroke5[i] = v;
    end;

    UIStroke5.Parent = Frame4;
    u268.tip = label(Frame4, "Drag to Rotate", 14, Color3_new_ret, {
        Name = "Tip",
        ZIndex = 2,
        Position = UDim2.fromOffset(14, 10),
        Size = UDim2.fromOffset(200, 18)
    });
    local v283 = {
        Name = "ViewportFrame",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -1, -0.6),
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(170, 170, 170),
        LightColor = Color3_new_ret
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v283 do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = Frame4;
    local Camera = Instance.new("Camera");

    for i, v in {
        FieldOfView = 40
    } do
        Camera[i] = v;
    end;

    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;
    u268.camera = Camera;
    local WorldModel = Instance.new("WorldModel");

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = ViewportFrame;
    u268.world = WorldModel;
    local v284 = buttonRow(Frame, "Sound", 14);

    for i, v in u3 do
        button(u268, v284, v, u2[v].label, i, 0.31);
    end;

    if #v262 > 0 then
        local v285 = buttonRow(Frame, "Included", 72);
        local math_min_ret = math.min(0.31, (1 - (#v262 - 1) * 0.035) / #v262);

        for i, v in v262 do
            button(u268, v285, v.key, v.label, i, math_min_ret);
        end;
    end;

    local EquippedDagger = u264:FindFirstChild("EquippedDagger");

    if EquippedDagger then
        EquippedDagger:Destroy();
    end;

    u264.Name = "PreviewCharacter";
    u264.Parent = WorldModel;
    u268.clone = u264;
    u268.knife = ClientBotKnife.new(u264);
    u268.knife:create(v261.Model);

    if u268.knife.chain then
        u268.knife:show(true);
        local EquippedDagger2 = u264:FindFirstChild("EquippedDagger");

        if EquippedDagger2 then
            EquippedDagger2 = KnifeChains.followers(EquippedDagger2, u264);
        end;

        if EquippedDagger2 then
            table.insert(u268.connections, RunService.PreSimulation:Connect(function() -- Line: 1246
                -- upvalues: KnifeChains (ref), EquippedDagger2 (copy)
                KnifeChains.place(EquippedDagger2);
            end));
        end;
    end;

    u268.ball = rootPiece(u268, u264);
    u268.animator = v265:FindFirstChildOfClass("Animator");
    local Hold = KnifeClips.Actions.Hold;
    local v286 = load(u268, "Hold", KnifeClips.id(u268.model, "Hold"), Hold.priority, Hold.looped);

    if v286 then
        v286:Play(0);
    end;

    if v261.Show == "GameDay" then
        load(u268, "Catch", KnifeClips.normalize(u268.model:GetAttribute(u4.Catch)), Enum.AnimationPriority.Action3, false);
        load(u268, "Touchdown", KnifeClips.normalize(u268.model:GetAttribute(u4.Touchdown)), Enum.AnimationPriority.Action3, false);
    elseif v261.Show == "MatchDay" then
        for _, v in { "Intro", "IntroLoop", "Celebrate", "CelebrateLoop", "Run" } do
            load(u268, v, KnifeClips.normalize(u268.model:GetAttribute(u4[v])), Enum.AnimationPriority.Action3, (v == "IntroLoop" or v == "CelebrateLoop") and true or v == "Run");
        end;
    end;

    local function fitCamera() -- Line: 1266
        -- upvalues: u268 (copy), CharacterFrame (ref), Camera (copy), u264 (copy), ViewportFrame (copy)
        if not u268.game then
            CharacterFrame.fit(Camera, u264, ViewportFrame, 1.3);
        end;
    end;

    u268.fit = fitCamera;
    local connections2 = u268.connections;
    local PropertyChangedSignal2 = ViewportFrame:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(connections2, PropertyChangedSignal2:Connect(fitCamera));
    u264:PivotTo(CFrame.new());

    if not u268.game then
        CharacterFrame.fit(Camera, u264, ViewportFrame, 1.3);
    end;

    u264:PivotTo(CFrame.Angles(0, u268.yaw, 0));
    local u287 = false;
    local u288 = 0;
    table.insert(u268.connections, ViewportFrame.InputBegan:Connect(function(p289) -- Line: 1280
        -- upvalues: u268 (copy), u287 (ref), u288 (ref)
        if not (u268.game or p289.UserInputType ~= Enum.UserInputType.MouseButton1 and p289.UserInputType ~= Enum.UserInputType.Touch) then
            u287 = true;
            u288 = p289.Position.X;
        end;
    end));
    table.insert(u268.connections, UserInputService.InputChanged:Connect(function(p290) -- Line: 1291
        -- upvalues: u287 (ref), u268 (copy), u288 (ref), u264 (copy)
        if u287 and not (u268.game or p290.UserInputType ~= Enum.UserInputType.MouseMovement and p290.UserInputType ~= Enum.UserInputType.Touch) then
            local v291 = u268;
            v291.yaw = v291.yaw + (p290.Position.X - u288) * 0.012;
            u288 = p290.Position.X;
            u264:PivotTo(CFrame.Angles(0, u268.yaw, 0));
        end;
    end));
    table.insert(u268.connections, UserInputService.InputEnded:Connect(function(p292) -- Line: 1308
        -- upvalues: u287 (ref)
        if p292.UserInputType == Enum.UserInputType.MouseButton1 or p292.UserInputType == Enum.UserInputType.Touch then
            u287 = false;
        end;
    end));
    table.insert(u268.connections, UserInputService.InputBegan:Connect(function(p293) -- Line: 1319
        -- upvalues: close (ref)
        if p293.KeyCode == Enum.KeyCode.Escape or p293.KeyCode == Enum.KeyCode.ButtonB then
            close();
        end;
    end));

    local function shopGone() -- Line: 1326
        -- upvalues: LocalPlayer (ref), close (ref)
        if LocalPlayer:GetAttribute("ArmoryOpen") ~= true and (LocalPlayer:GetAttribute("BalloonOfferOpen") ~= true and LocalPlayer:GetAttribute("BundleOfferOpen") ~= true) then
            close();
        end;
    end;

    for _, v in { "ArmoryOpen", "BalloonOfferOpen", "BundleOfferOpen" } do
        local connections3 = u268.connections;
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
        table.insert(connections3, AttributeChangedSignal:Connect(shopGone));
    end;

    local connections3 = u268.connections;
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(connections3, AttributeChangedSignal:Connect(close));
    pick(u268, u258);

    if not CharacterClone.dressed(u264) then
        task.spawn(function() -- Line: 1343
            -- upvalues: CharacterClone (ref), u5 (ref), u268 (copy), LocalPlayer (ref), u258 (copy), close (ref), u1 (ref), u257 (copy)
            for i = 1, CharacterClone.RETRIES do
                task.wait(CharacterClone.RETRY_SECONDS);

                if u5 ~= u268 then
                    return;
                end;

                local v294 = CharacterClone.copy(LocalPlayer.Character);
                local v295;

                if v294 == nil then
                    v295 = false;
                else
                    v295 = CharacterClone.dressed(v294);
                end;

                if v294 then
                    v294:Destroy();
                end;

                if v295 then
                    local v296 = u268.picked or u258;
                    local sound = u268.sound;
                    close();
                    u1.open(u257, v296, sound);

                    return;
                end;

                local _ = i;
            end;
        end);
    end;

    return true;
end;

return u1;