 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("ContentProvider");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).EventIntro ~= true then
    return;
end;

local EventIntroRemote = ChickenOrHero:WaitForChild("Game"):WaitForChild("EventIntroRemote");
local TeamEventConfig = require(ChickenOrHero:WaitForChild("Progression"):WaitForChild("TeamEventConfig"));
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local CreatorVisibility = require(Presentation:WaitForChild("CreatorVisibility"));
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local KnifeDisplayRig = require(Weapons:WaitForChild("KnifeDisplayRig"));
local KnifeVisibility = require(Weapons:WaitForChild("KnifeVisibility"));
local AnimationConfig = require(ChickenOrHero:WaitForChild("Animation"):WaitForChild("AnimationConfig"));
local CFrame_new_ret = CFrame.new(0, 3000, 0);
local Color = TeamEventConfig.Team.Football.Color;
local Color2 = TeamEventConfig.Team.Futbol.Color;
local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 36, 56);
local Color3_fromRGB_ret3 = Color3.fromRGB(24, 118, 255);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local u1 = {
    Music = { "rbxassetid://1837460585", 0.6 },
    Boom = { "rbxassetid://9125484526", 0.9 },
    Whoosh = { "rbxassetid://9120718689", 0.8 },
    Riser = { "rbxassetid://9043343295", 0.55 },
    Pyro = { "rbxassetid://9120975204", 0.75 },
    Clack = { "rbxassetid://9119073088", 0.6 },
    Crowd = { "rbxassetid://9112779173", 1, true },
    Kick = { "rbxassetid://9119326824", 1, true },
    Kick2 = { "rbxassetid://9119327493", 1, true }
};
local u2 = {
    reveal = 6.8,
    football = 8.7,
    footballTitle = 9,
    futbol = 10.8,
    futbolTitle = 11.1,
    charge = 12.9,
    slow = 14.5,
    vs = 15.3,
    spike = 16.7,
    goal = 17.6,
    finale = 18.5,
    card = 18.6,
    fade = 23.2
};
local u3 = {
    en = { "huh..?", "what is that sound?" },
    zh = { "嗯..？", "那是什么声音？" },
    ["zh-tw"] = { "嗯..？", "那是什麼聲音？" },
    hi = { "हैं..?", "यह कैसी आवाज़ है?" },
    es = { "¿eh..?", "¿qué es ese sonido?" },
    fr = { "hein..?", "c\'est quoi ce bruit ?" },
    ar = { "هاه..؟", "ما هذا الصوت؟" },
    bn = { "কী..?", "এটা কিসের শব্দ?" },
    pt = { "hã..?", "que som é esse?" },
    ru = { "а..?", "что это за звук?" },
    ur = { "ہیں..؟", "یہ کیسی آواز ہے؟" },
    id = { "hah..?", "suara apa itu?" },
    de = { "hä..?", "was ist das für ein Geräusch?" },
    ja = { "ん..？", "何の音？" },
    tr = { "ha..?", "bu ses de ne?" },
    ko = { "어..?", "이게 무슨 소리지?" },
    it = { "eh..?", "cos\'è questo rumore?" },
    nl = { "hè..?", "wat is dat voor geluid?" },
    pl = { "co..?", "co to za dźwięk?" },
    hr = { "ha..?", "kakav je to zvuk?" },
    el = { "ε..;", "τι ήχος είναι αυτός;" },
    vi = { "hả..?", "tiếng gì vậy?" },
    th = { "หืม..?", "เสียงอะไรน่ะ?" },
    tl = { "ha..?", "anong tunog \'yon?" },
    ms = { "hah..?", "bunyi apa tu?" },
    sw = { "eh..?", "sauti gani hiyo?" }
};
u3.fil = u3.tl;

local function lines() -- Line: 109
    -- upvalues: u3 (copy)
    local LocalizationService = game:GetService("LocalizationService");

    for _, v in { "RobloxLocaleId", "SystemLocaleId" } do
        local success, result = pcall(function() -- Line: 112
            -- upvalues: LocalizationService (copy), v (copy)
            return string.lower(LocalizationService[v]);
        end);

        if success and (type(result) == "string" and result ~= "") then
            if result == "zh-tw" or (result == "zh-hk" or (result == "zh-hant" or result == "zh-mo")) then
                return u3["zh-tw"];
            end;

            local v4 = u3[string.match(result, "^%a+") or ""];

            if v4 then
                return v4;
            end;
        end;
    end;

    return u3.en;
end;

local u5 = { { 0.15, 8, 2.15 }, { 2.35, 13, 6.68 } };
local u6 = { 0.7, 1.3, 2.5, 3.1, 4.2, 4.6, 5.6, 6.1 };

local function smooth(p7) -- Line: 141
    local math_clamp_ret = math.clamp(p7, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

local function ease(p8) -- Line: 145
    return 1 - (1 - math.clamp(p8, 0, 1)) ^ 3;
end;

local function at(p9, p10, p11) -- Line: 149
    -- upvalues: CFrame_new_ret (copy)
    return CFrame_new_ret.Position + Vector3.new(p9, p10, p11);
end;

local function block(p12, p13, p14, p15, p16, p17) -- Line: 154
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = p13;
    Part.CFrame = p14;
    Part.Color = p15;
    Part.Material = p16 or Enum.Material.SmoothPlastic;
    Part.TopSurface = Enum.SurfaceType.Smooth;
    Part.BottomSurface = Enum.SurfaceType.Smooth;

    if p17 then
        for i, v in p17 do
            Part[i] = v;
        end;
    end;

    Part.Parent = p12;

    return Part;
end;

local function flat(p18, p19, p20, p21, p22, p23, p24, p25) -- Line: 175
    -- upvalues: CFrame_new_ret (copy)
    local Vector3_new_ret = Vector3.new(p21, 0.05, p22);
    local v26 = CFrame_new_ret * CFrame.new(p19, p24 or 0.03, p20);
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = Vector3_new_ret;
    Part.CFrame = v26;
    Part.Color = p23;
    Part.Material = p25 or Enum.Material.SmoothPlastic;
    Part.TopSurface = Enum.SurfaceType.Smooth;
    Part.BottomSurface = Enum.SurfaceType.Smooth;
    Part.Parent = p18;

    return Part;
end;

local function surface(p27, p28, p29) -- Line: 179
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Face = p28;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = p29 or 20;
    SurfaceGui.LightInfluence = 0.3;
    SurfaceGui:SetAttribute("CreatorCaptureExempt", true);
    SurfaceGui.Parent = p27;

    return SurfaceGui;
end;

local function paintText(p30, p31, p32, p33, p34) -- Line: 189
    -- upvalues: Font_new_ret (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.Text = p31;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = p32;
    TextLabel.FontFace = p33 or Font_new_ret;
    TextLabel.Rotation = p34 or 0;
    TextLabel.Parent = p30;

    return TextLabel;
end;

local function emitter(p35, p36) -- Line: 201
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Rate = 0;
    ParticleEmitter.LightEmission = 1;

    for i, v in p36 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = p35;

    return ParticleEmitter;
end;

local function buildStage(p37) -- Line: 215
    -- upvalues: block (copy), CFrame_new_ret (copy), Color3_new_ret (copy), Presentation (copy), Color (copy), Font_new_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), Color3_new_ret2 (copy), Color2 (copy)
    local v38 = block(p37, Vector3.new(1, 1, 1), CFrame_new_ret, Color3_new_ret, nil, {
        Transparency = 1,
        Name = "Anchors"
    });
    local Color3_fromRGB_ret4 = Color3.fromRGB(36, 116, 54);
    local v39 = CFrame_new_ret * CFrame.new(0, -1.05, 0);
    local Color3_fromRGB_ret5 = Color3.fromRGB(16, 40, 24);
    local Grass = Enum.Material.Grass;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = Vector3.new(420, 2, 300);
    Part.CFrame = v39;
    Part.Color = Color3_fromRGB_ret5;
    Part.Material = Grass or Enum.Material.SmoothPlastic;
    Part.TopSurface = Enum.SurfaceType.Smooth;
    Part.BottomSurface = Enum.SurfaceType.Smooth;
    Part.Parent = p37;
    local v40 = CFrame_new_ret * CFrame.new(0, -0.5, 0);
    local Grass2 = Enum.Material.Grass;
    local Part2 = Instance.new("Part");
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;
    Part2.Size = Vector3.new(190, 1, 100);
    Part2.CFrame = v40;
    Part2.Color = Color3_fromRGB_ret4;
    Part2.Material = Grass2 or Enum.Material.SmoothPlastic;
    Part2.TopSurface = Enum.SurfaceType.Smooth;
    Part2.BottomSurface = Enum.SurfaceType.Smooth;
    Part2.Parent = p37;
    local v41 = {
        folder = p37,
        sweeps = {},
        pyro = {},
        fireworks = {},
        flashes = {}
    };

    for i = 0, 8, 2 do
        local v42 = Color3_fromRGB_ret4:Lerp(Color3_new_ret, 0.08);
        local Grass3 = Enum.Material.Grass;
        local v43 = CFrame_new_ret * CFrame.new(i * 10 + 5, 0.01, 0);
        local Part3 = Instance.new("Part");
        Part3.Anchored = true;
        Part3.CanCollide = false;
        Part3.CanQuery = false;
        Part3.CanTouch = false;
        Part3.CastShadow = false;
        Part3.Size = Vector3.new(10, 0.05, 100);
        Part3.CFrame = v43;
        Part3.Color = v42;
        Part3.Material = Grass3 or Enum.Material.SmoothPlastic;
        Part3.TopSurface = Enum.SurfaceType.Smooth;
        Part3.BottomSurface = Enum.SurfaceType.Smooth;
        Part3.Parent = p37;
        local _ = i;
    end;

    local v44 = CFrame_new_ret * CFrame.new(80, 0.03, 0);
    local Part3 = Instance.new("Part");
    Part3.Anchored = true;
    Part3.CanCollide = false;
    Part3.CanQuery = false;
    Part3.CanTouch = false;
    Part3.CastShadow = false;
    Part3.Size = Vector3.new(0.5, 0.05, 44);
    Part3.CFrame = v44;
    Part3.Color = Color3_new_ret;
    Part3.Material = Enum.Material.SmoothPlastic;
    Part3.TopSurface = Enum.SurfaceType.Smooth;
    Part3.BottomSurface = Enum.SurfaceType.Smooth;
    Part3.Parent = p37;
    local v45 = CFrame_new_ret * CFrame.new(87.5, 0.03, 22);
    local Part4 = Instance.new("Part");
    Part4.Anchored = true;
    Part4.CanCollide = false;
    Part4.CanQuery = false;
    Part4.CanTouch = false;
    Part4.CastShadow = false;
    Part4.Size = Vector3.new(15, 0.05, 0.5);
    Part4.CFrame = v45;
    Part4.Color = Color3_new_ret;
    Part4.Material = Enum.Material.SmoothPlastic;
    Part4.TopSurface = Enum.SurfaceType.Smooth;
    Part4.BottomSurface = Enum.SurfaceType.Smooth;
    Part4.Parent = p37;
    local v46 = CFrame_new_ret * CFrame.new(87.5, 0.03, -22);
    local Part5 = Instance.new("Part");
    Part5.Anchored = true;
    Part5.CanCollide = false;
    Part5.CanQuery = false;
    Part5.CanTouch = false;
    Part5.CastShadow = false;
    Part5.Size = Vector3.new(15, 0.05, 0.5);
    Part5.CFrame = v46;
    Part5.Color = Color3_new_ret;
    Part5.Material = Enum.Material.SmoothPlastic;
    Part5.TopSurface = Enum.SurfaceType.Smooth;
    Part5.BottomSurface = Enum.SurfaceType.Smooth;
    Part5.Parent = p37;
    local SoccerNet = Presentation:FindFirstChild("SoccerNet");

    if SoccerNet and SoccerNet:IsA("BasePart") then
        local v47 = SoccerNet:Clone();
        v47.Anchored = true;
        v47.CanCollide = false;
        v47.CanQuery = false;
        v47.CanTouch = false;
        v47.CFrame = CFrame_new_ret * CFrame.new(95 + v47.Size.Z / 2, v47.Size.Y / 2, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
        v47.Parent = p37;
    end;

    for i = 0, 7 do
        local Vector3_new_ret = Vector3.new(i % 2 == 0 and 0.6 or 0.35, 0.05, 96);
        local v48 = CFrame_new_ret * CFrame.new(-10 - i * 9.5, 0.03, 0);
        local Part6 = Instance.new("Part");
        Part6.Anchored = true;
        Part6.CanCollide = false;
        Part6.CanQuery = false;
        Part6.CanTouch = false;
        Part6.CastShadow = false;
        Part6.Size = Vector3_new_ret;
        Part6.CFrame = v48;
        Part6.Color = Color3_new_ret;
        Part6.Material = Enum.Material.SmoothPlastic;
        Part6.TopSurface = Enum.SurfaceType.Smooth;
        Part6.BottomSurface = Enum.SurfaceType.Smooth;
        Part6.Parent = p37;
        local _ = i;
    end;

    local v49 = CFrame_new_ret * CFrame.new(-88, 0.02, 0);
    local Part6 = Instance.new("Part");
    Part6.Anchored = true;
    Part6.CanCollide = false;
    Part6.CanQuery = false;
    Part6.CanTouch = false;
    Part6.CastShadow = false;
    Part6.Size = Vector3.new(14, 0.05, 100);
    Part6.CFrame = v49;
    Part6.Color = Color;
    Part6.Material = Enum.Material.SmoothPlastic;
    Part6.TopSurface = Enum.SurfaceType.Smooth;
    Part6.BottomSurface = Enum.SurfaceType.Smooth;
    Part6.Parent = p37;
    local Top = Enum.NormalId.Top;
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Face = Top;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = 8;
    SurfaceGui.LightInfluence = 0.3;
    SurfaceGui:SetAttribute("CreatorCaptureExempt", true);
    SurfaceGui.Parent = Part6;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.Text = "FOOTBALL";
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3_new_ret;
    TextLabel.FontFace = Font_new_ret or Font_new_ret;
    TextLabel.Rotation = -90;
    TextLabel.Parent = SurfaceGui;
    local Color3_fromRGB_ret6 = Color3.fromRGB(255, 214, 40);
    local v50 = CFrame_new_ret * CFrame.new(-97, 5.5, 0);
    local Metal = Enum.Material.Metal;
    local Part7 = Instance.new("Part");
    Part7.Anchored = true;
    Part7.CanCollide = false;
    Part7.CanQuery = false;
    Part7.CanTouch = false;
    Part7.CastShadow = false;
    Part7.Size = Vector3.new(0.9, 11, 0.9);
    Part7.CFrame = v50;
    Part7.Color = Color3_fromRGB_ret6;
    Part7.Material = Metal or Enum.Material.SmoothPlastic;
    Part7.TopSurface = Enum.SurfaceType.Smooth;
    Part7.BottomSurface = Enum.SurfaceType.Smooth;
    Part7.Parent = p37;
    local v51 = CFrame_new_ret * CFrame.new(-97, 11, 0);
    local Metal2 = Enum.Material.Metal;
    local Part8 = Instance.new("Part");
    Part8.Anchored = true;
    Part8.CanCollide = false;
    Part8.CanQuery = false;
    Part8.CanTouch = false;
    Part8.CastShadow = false;
    Part8.Size = Vector3.new(0.7, 0.7, 19);
    Part8.CFrame = v51;
    Part8.Color = Color3_fromRGB_ret6;
    Part8.Material = Metal2 or Enum.Material.SmoothPlastic;
    Part8.TopSurface = Enum.SurfaceType.Smooth;
    Part8.BottomSurface = Enum.SurfaceType.Smooth;
    Part8.Parent = p37;

    for _, v in { -1, 1 } do
        local v52 = CFrame_new_ret * CFrame.new(-97, 22, v * 9.2);
        local Metal3 = Enum.Material.Metal;
        local Part9 = Instance.new("Part");
        Part9.Anchored = true;
        Part9.CanCollide = false;
        Part9.CanQuery = false;
        Part9.CanTouch = false;
        Part9.CastShadow = false;
        Part9.Size = Vector3.new(0.6, 22, 0.6);
        Part9.CFrame = v52;
        Part9.Color = Color3_fromRGB_ret6;
        Part9.Material = Metal3 or Enum.Material.SmoothPlastic;
        Part9.TopSurface = Enum.SurfaceType.Smooth;
        Part9.BottomSurface = Enum.SurfaceType.Smooth;
        Part9.Parent = p37;
    end;

    local v53 = CFrame_new_ret * CFrame.new(0, 0.03, 0);
    local Part9 = Instance.new("Part");
    Part9.Anchored = true;
    Part9.CanCollide = false;
    Part9.CanQuery = false;
    Part9.CanTouch = false;
    Part9.CastShadow = false;
    Part9.Size = Vector3.new(0.6, 0.05, 100);
    Part9.CFrame = v53;
    Part9.Color = Color3_new_ret;
    Part9.Material = Enum.Material.SmoothPlastic;
    Part9.TopSurface = Enum.SurfaceType.Smooth;
    Part9.BottomSurface = Enum.SurfaceType.Smooth;
    Part9.Parent = p37;

    for i = 0, 39 do
        local v54 = (i + 0.5) / 40 * 3.141592653589793 * 2;
        local v55 = CFrame_new_ret * CFrame.new(math.sin(v54) * 14, 0.03, math.cos(v54) * 14) * CFrame.Angles(0, v54, 0);
        local Part10 = Instance.new("Part");
        Part10.Anchored = true;
        Part10.CanCollide = false;
        Part10.CanQuery = false;
        Part10.CanTouch = false;
        Part10.CastShadow = false;
        Part10.Size = Vector3.new(2.2, 0.05, 0.5);
        Part10.CFrame = v55;
        Part10.Color = Color3_new_ret;
        Part10.Material = Enum.Material.SmoothPlastic;
        Part10.TopSurface = Enum.SurfaceType.Smooth;
        Part10.BottomSurface = Enum.SurfaceType.Smooth;
        Part10.Parent = p37;
        local _ = i;
    end;

    local v56 = CFrame_new_ret * CFrame.new(0, 0.04, 0);
    local Part10 = Instance.new("Part");
    Part10.Anchored = true;
    Part10.CanCollide = false;
    Part10.CanQuery = false;
    Part10.CanTouch = false;
    Part10.CastShadow = false;
    Part10.Size = Vector3.new(9, 0.05, 9);
    Part10.CFrame = v56;
    Part10.Color = Color3_new_ret;
    Part10.Material = Enum.Material.SmoothPlastic;
    Part10.TopSurface = Enum.SurfaceType.Smooth;
    Part10.BottomSurface = Enum.SurfaceType.Smooth;
    Part10.Parent = p37;
    Part10.Transparency = 1;
    local Top2 = Enum.NormalId.Top;
    local SurfaceGui2 = Instance.new("SurfaceGui");
    SurfaceGui2.Face = Top2;
    SurfaceGui2.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui2.PixelsPerStud = 24;
    SurfaceGui2.LightInfluence = 0.3;
    SurfaceGui2:SetAttribute("CreatorCaptureExempt", true);
    SurfaceGui2.Parent = Part10;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3_new_ret;
    Frame.Parent = SurfaceGui2;
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(1, 0);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 90;
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3_fromRGB_ret2),
        ColorSequenceKeypoint.new(0.495, Color3_fromRGB_ret2),
        ColorSequenceKeypoint.new(0.505, Color3_fromRGB_ret3),
        ColorSequenceKeypoint.new(1, Color3_fromRGB_ret3)
    });
    UIGradient.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret;
    UIStroke.Thickness = 10;
    UIStroke.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.Text = "VS";
    TextLabel2.TextScaled = true;
    TextLabel2.TextColor3 = Color3_new_ret;
    TextLabel2.FontFace = Font_new_ret or Font_new_ret;
    TextLabel2.Rotation = 90;
    TextLabel2.Parent = Frame;
    local Color3_fromRGB_ret7 = Color3.fromRGB(26, 28, 38);
    local v57 = {
        Color,
        Color:Lerp(Color3_new_ret, 0.4),
        Color:Lerp(Color3_new_ret2, 0.4),
        Color3_new_ret,
        Color3.fromRGB(60, 60, 70),
        Color2,
        Color2:Lerp(Color3_new_ret, 0.4),
        Color2:Lerp(Color3_new_ret2, 0.4),
        Color3_fromRGB_ret
    };
    local Random_new_ret = Random.new(1017);

    for _, v in { -1, 1 } do
        local v58 = v;

        for i = 0, 6 do
            local v59 = v58 * (i * 4 + 56);
            local v60 = i * 2.6 + 1.2;
            local Vector3_new_ret = Vector3.new(210, v60 * 2, 4);
            local v61 = CFrame_new_ret * CFrame.new(0, 0, v59);
            local Concrete = Enum.Material.Concrete;
            local Part11 = Instance.new("Part");
            Part11.Anchored = true;
            Part11.CanCollide = false;
            Part11.CanQuery = false;
            Part11.CanTouch = false;
            Part11.CastShadow = false;
            Part11.Size = Vector3_new_ret;
            Part11.CFrame = v61;
            Part11.Color = Color3_fromRGB_ret7;
            Part11.Material = Concrete or Enum.Material.SmoothPlastic;
            Part11.TopSurface = Enum.SurfaceType.Smooth;
            Part11.BottomSurface = Enum.SurfaceType.Smooth;
            Part11.Parent = p37;
            local _ = i;

            for i2 = 0, 13 do
                local v62 = i2 * 15 + -97.5;
                local v63 = v57[Random_new_ret:NextInteger(1, 5) + (v62 > 0 and 4 or 0)];
                local v64 = CFrame_new_ret * CFrame.new(v62, v60 + 0.7, v59 + v58 * 0.6);
                local Fabric = Enum.Material.Fabric;
                local Part12 = Instance.new("Part");
                Part12.Anchored = true;
                Part12.CanCollide = false;
                Part12.CanQuery = false;
                Part12.CanTouch = false;
                Part12.CastShadow = false;
                Part12.Size = Vector3.new(14.6, 1.4, 1.6);
                Part12.CFrame = v64;
                Part12.Color = v63;
                Part12.Material = Fabric or Enum.Material.SmoothPlastic;
                Part12.TopSurface = Enum.SurfaceType.Smooth;
                Part12.BottomSurface = Enum.SurfaceType.Smooth;
                Part12.Parent = p37;
                local _ = i2;
            end;
        end;

        local v65 = block(p37, Vector3.new(200, 14, 26), CFrame_new_ret * CFrame.new(0, 10, v58 * 68), Color3_new_ret, nil, {
            Transparency = 1,
            Name = "Flashes"
        });
        local flashes = v41.flashes;
        local v66 = {
            Texture = "rbxasset://textures/particles/sparkles_main.dds",
            Rate = 45,
            Shape = Enum.ParticleEmitterShape.Box,
            ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume,
            Size = NumberSequence.new(0.9, 0),
            Lifetime = NumberRange.new(0.06, 0.14),
            Speed = NumberRange.new(0),
            Color = ColorSequence.new(Color3_new_ret)
        };
        local ParticleEmitter = Instance.new("ParticleEmitter");
        ParticleEmitter.Rate = 0;
        ParticleEmitter.LightEmission = 1;

        for i, v2 in v66 do
            ParticleEmitter[i] = v2;
        end;

        ParticleEmitter.Parent = v65;
        table.insert(flashes, ParticleEmitter);

        for _, v2 in { -1, 1 } do
            local v67 = CFrame_new_ret * CFrame.new(v2 * 52, 2.2, v58 * 53.8);
            local v68 = (v2 < 0 and Color or Color2):Lerp(Color3_new_ret2, 0.3);
            local Neon = Enum.Material.Neon;
            local Part11 = Instance.new("Part");
            Part11.Anchored = true;
            Part11.CanCollide = false;
            Part11.CanQuery = false;
            Part11.CanTouch = false;
            Part11.CastShadow = false;
            Part11.Size = Vector3.new(104, 1.6, 0.4);
            Part11.CFrame = v67;
            Part11.Color = v68;
            Part11.Material = Neon or Enum.Material.SmoothPlastic;
            Part11.TopSurface = Enum.SurfaceType.Smooth;
            Part11.BottomSurface = Enum.SurfaceType.Smooth;
            Part11.Parent = p37;
        end;
    end;

    for _, v in { -1, 1 } do
        local v69 = v;

        for i = 0, 5 do
            local v70 = v69 * (i * 4 + 108);
            local v71 = i * 2.6 + 1.2;
            local Vector3_new_ret = Vector3.new(4, v71 * 2, 108);
            local v72 = CFrame_new_ret * CFrame.new(v70, 0, 0);
            local Concrete = Enum.Material.Concrete;
            local Part11 = Instance.new("Part");
            Part11.Anchored = true;
            Part11.CanCollide = false;
            Part11.CanQuery = false;
            Part11.CanTouch = false;
            Part11.CastShadow = false;
            Part11.Size = Vector3_new_ret;
            Part11.CFrame = v72;
            Part11.Color = Color3_fromRGB_ret7;
            Part11.Material = Concrete or Enum.Material.SmoothPlastic;
            Part11.TopSurface = Enum.SurfaceType.Smooth;
            Part11.BottomSurface = Enum.SurfaceType.Smooth;
            Part11.Parent = p37;
            local _ = i;

            for i2 = 0, 6 do
                local v73 = v57[Random_new_ret:NextInteger(1, 5) + (v69 > 0 and 4 or 0)];
                local v74 = CFrame_new_ret * CFrame.new(v70 - v69 * 0.6, v71 + 0.7, i2 * 15 + -45);
                local Fabric = Enum.Material.Fabric;
                local Part12 = Instance.new("Part");
                Part12.Anchored = true;
                Part12.CanCollide = false;
                Part12.CanQuery = false;
                Part12.CanTouch = false;
                Part12.CastShadow = false;
                Part12.Size = Vector3.new(1.6, 1.4, 15);
                Part12.CFrame = v74;
                Part12.Color = v73;
                Part12.Material = Fabric or Enum.Material.SmoothPlastic;
                Part12.TopSurface = Enum.SurfaceType.Smooth;
                Part12.BottomSurface = Enum.SurfaceType.Smooth;
                Part12.Parent = p37;
                local _ = i2;
            end;
        end;

        local v75 = CFrame_new_ret * CFrame.new(v69 * 105.8, 2.2, 0);
        local v76 = (v69 < 0 and Color or Color2):Lerp(Color3_new_ret2, 0.3);
        local Neon = Enum.Material.Neon;
        local Part11 = Instance.new("Part");
        Part11.Anchored = true;
        Part11.CanCollide = false;
        Part11.CanQuery = false;
        Part11.CanTouch = false;
        Part11.CastShadow = false;
        Part11.Size = Vector3.new(0.4, 1.6, 104);
        Part11.CFrame = v75;
        Part11.Color = v76;
        Part11.Material = Neon or Enum.Material.SmoothPlastic;
        Part11.TopSurface = Enum.SurfaceType.Smooth;
        Part11.BottomSurface = Enum.SurfaceType.Smooth;
        Part11.Parent = p37;
    end;

    local Color3_fromRGB_ret8 = Color3.fromRGB(255, 244, 225);

    for _, v in {
        Vector2.new(-1, -1),
        Vector2.new(1, -1),
        Vector2.new(-1, 1),
        Vector2.new(1, 1)
    } do
        local v77 = CFrame_new_ret.Position + Vector3.new(v.X * 96, 0, v.Y * 84);
        local CFrame_new_ret2 = CFrame.new(v77 + Vector3.new(0, 37, 0));
        local Color3_fromRGB_ret9 = Color3.fromRGB(70, 72, 80);
        local Metal3 = Enum.Material.Metal;
        local Part11 = Instance.new("Part");
        Part11.Anchored = true;
        Part11.CanCollide = false;
        Part11.CanQuery = false;
        Part11.CanTouch = false;
        Part11.CastShadow = false;
        Part11.Size = Vector3.new(2.4, 74, 2.4);
        Part11.CFrame = CFrame_new_ret2;
        Part11.Color = Color3_fromRGB_ret9;
        Part11.Material = Metal3 or Enum.Material.SmoothPlastic;
        Part11.TopSurface = Enum.SurfaceType.Smooth;
        Part11.BottomSurface = Enum.SurfaceType.Smooth;
        Part11.Parent = p37;
        local CFrame_lookAt_ret = CFrame.lookAt(v77 + Vector3.new(0, 76, 0), CFrame_new_ret.Position + Vector3.new(0, 0, 0));
        local Neon = Enum.Material.Neon;
        local Part12 = Instance.new("Part");
        Part12.Anchored = true;
        Part12.CanCollide = false;
        Part12.CanQuery = false;
        Part12.CanTouch = false;
        Part12.CastShadow = false;
        Part12.Size = Vector3.new(16, 7, 1.2);
        Part12.CFrame = CFrame_lookAt_ret;
        Part12.Color = Color3_fromRGB_ret8;
        Part12.Material = Neon or Enum.Material.SmoothPlastic;
        Part12.TopSurface = Enum.SurfaceType.Smooth;
        Part12.BottomSurface = Enum.SurfaceType.Smooth;
        Part12.Parent = p37;
        local SpotLight = Instance.new("SpotLight");
        SpotLight.Face = Enum.NormalId.Front;
        SpotLight.Angle = 75;
        SpotLight.Range = 140;
        SpotLight.Brightness = 3;
        SpotLight.Color = Color3_fromRGB_ret8;
        SpotLight.Shadows = false;
        SpotLight.Parent = Part12;
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = Part12;
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Parent = v38;
        Attachment2.WorldPosition = CFrame_new_ret.Position + Vector3.new(v.X * 20, 0, v.Y * 12);
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = Attachment;
        Beam.Attachment1 = Attachment2;
        Beam.Width0 = 10;
        Beam.Width1 = 60;
        Beam.FaceCamera = true;
        Beam.LightEmission = 1;
        Beam.LightInfluence = 0;
        Beam.Segments = 1;
        Beam.Color = ColorSequence.new(Color3_fromRGB_ret8);
        Beam.Transparency = NumberSequence.new(0.86, 1);
        Beam.Parent = Part12;
    end;

    for i, v in { Vector3.new(-60, 0, -94), Vector3.new(-25, 0, 94), Vector3.new(25, 0, -94), Vector3.new(60, 0, 94) } do
        local v78 = v.X < 0 and Color or Color2;
        local v79 = block(p37, Vector3.new(3, 3, 3), CFrame.new(CFrame_new_ret.Position + Vector3.new(v.X, 20, v.Z)), v78, Enum.Material.Neon, {
            Name = "Searchlight"
        });
        v79:SetAttribute("Tip", "Tip" .. i);
        v79:SetAttribute("Phase", i * 1.7);
        v79:SetAttribute("Lean", v.Z > 0 and 1 or -1);
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = v79;
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Name = "Tip" .. i;
        Attachment2.Parent = v38;
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = Attachment;
        Beam.Attachment1 = Attachment2;
        Beam.Width0 = 3;
        Beam.Width1 = 38;
        Beam.FaceCamera = true;
        Beam.LightEmission = 1;
        Beam.LightInfluence = 0;
        Beam.Segments = 1;
        Beam.Color = ColorSequence.new(v78:Lerp(Color3_new_ret, 0.25));
        Beam.Transparency = NumberSequence.new(0.55, 1);
        Beam.Parent = v79;
        table.insert(v41.sweeps, {
            tip = Attachment2,
            from = v79.Position,
            phase = i * 1.7,
            lean = v.Z > 0 and 1 or -1
        });
    end;

    for _, v in { -1, 1 } do
        local v80 = v < 0 and Color or Color2;
        local v81 = v;

        for _, v2 in { -34, 34 } do
            local v82 = block(p37, Vector3.new(2, 1, 2), CFrame_new_ret * CFrame.new(v81 * 99, 0.5, v2), Color3.fromRGB(40, 40, 46), Enum.Material.Metal, {
                Name = "Pyro"
            });
            local pyro = v41.pyro;
            local v83 = {
                Texture = "rbxasset://textures/particles/fire_main.dds",
                Acceleration = Vector3.new(0, -10, 0),
                EmissionDirection = Enum.NormalId.Top,
                Color = ColorSequence.new(v80:Lerp(Color3_new_ret, 0.5), Color3.fromRGB(255, 150, 40)),
                Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 3), NumberSequenceKeypoint.new(1, 7) }),
                Transparency = NumberSequence.new(0.1, 1),
                Lifetime = NumberRange.new(0.55, 0.85),
                Speed = NumberRange.new(45, 60),
                SpreadAngle = Vector2.new(6, 6)
            };
            local ParticleEmitter = Instance.new("ParticleEmitter");
            ParticleEmitter.Rate = 0;
            ParticleEmitter.LightEmission = 1;

            for i, v3 in v83 do
                ParticleEmitter[i] = v3;
            end;

            ParticleEmitter.Parent = v82;
            table.insert(pyro, ParticleEmitter);
            local pyro2 = v41.pyro;
            local v84 = {
                Texture = "rbxasset://textures/particles/sparkles_main.dds",
                Acceleration = Vector3.new(0, -45, 0),
                Drag = 0.6,
                EmissionDirection = Enum.NormalId.Top,
                Color = ColorSequence.new(Color3_fromRGB_ret, v80),
                Size = NumberSequence.new(0.7, 0.1),
                Lifetime = NumberRange.new(1, 1.6),
                Speed = NumberRange.new(40, 70),
                SpreadAngle = Vector2.new(25, 25)
            };
            local ParticleEmitter2 = Instance.new("ParticleEmitter");
            ParticleEmitter2.Rate = 0;
            ParticleEmitter2.LightEmission = 1;

            for i, v3 in v84 do
                ParticleEmitter2[i] = v3;
            end;

            ParticleEmitter2.Parent = v82;
            table.insert(pyro2, ParticleEmitter2);
            local PointLight = Instance.new("PointLight");
            PointLight.Color = v80:Lerp(Color3.fromRGB(255, 160, 60), 0.5);
            PointLight.Range = 40;
            PointLight.Brightness = 0;
            PointLight.Parent = v82;
            table.insert(v41.pyro, PointLight);
        end;
    end;

    for i, v in { Vector3.new(-40, 22, -52), Vector3.new(38, 26, -50), Vector3.new(-10, 30, -64), Vector3.new(14, 19, -56), Vector3.new(-66, 18, -44), Vector3.new(66, 20, -46) } do
        local v85 = block(p37, Vector3.new(1, 1, 1), CFrame.new(CFrame_new_ret.Position + Vector3.new(v.X, v.Y, v.Z)), Color3_new_ret, nil, {
            Transparency = 1,
            Name = "Firework"
        });
        local v86;

        if i % 3 == 0 then
            v86 = Color3_fromRGB_ret;
        elseif i % 2 == 0 then
            v86 = Color2:Lerp(Color3_new_ret, 0.3);
        else
            v86 = Color:Lerp(Color3_new_ret, 0.3);
        end;

        local fireworks = v41.fireworks;
        local v87 = {
            Texture = "rbxasset://textures/particles/sparkles_main.dds",
            Acceleration = Vector3.new(0, -14, 0),
            Drag = 1.6,
            Color = ColorSequence.new(Color3_new_ret, v86),
            Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 0.2) }),
            Lifetime = NumberRange.new(1.1, 1.7),
            Speed = NumberRange.new(30, 42),
            SpreadAngle = Vector2.new(180, 180)
        };
        local ParticleEmitter = Instance.new("ParticleEmitter");
        ParticleEmitter.Rate = 0;
        ParticleEmitter.LightEmission = 1;

        for i2, v2 in v87 do
            ParticleEmitter[i2] = v2;
        end;

        ParticleEmitter.Parent = v85;
        table.insert(fireworks, ParticleEmitter);
    end;

    local v88 = block(p37, Vector3.new(1, 1, 1), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 3.5, 0)), Color3_new_ret, nil, {
        Transparency = 1,
        Name = "Clash"
    });
    local v89 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        Drag = 4,
        Color = ColorSequence.new(Color3_new_ret, Color3_fromRGB_ret),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0) }),
        Lifetime = NumberRange.new(0.35, 0.7),
        Speed = NumberRange.new(30, 55),
        SpreadAngle = Vector2.new(180, 180)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Rate = 0;
    ParticleEmitter.LightEmission = 1;
    local v90 = {};

    for i, v in v89 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = v88;
    v90[1] = ParticleEmitter;
    v41.clash = v90;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3.fromRGB(255, 236, 190);
    PointLight.Range = 30;
    PointLight.Brightness = 0;
    PointLight.Parent = v88;
    table.insert(v41.clash, PointLight);
    local v91 = block(p37, Vector3.new(30, 1, 16), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 30, 0)), Color3_new_ret, nil, {
        Transparency = 1,
        Name = "Firework"
    });

    for _, v in {
        Color,
        Color2,
        Color3_fromRGB_ret,
        Color3_new_ret
    } do
        local fireworks = v41.fireworks;
        local v92 = {
            Texture = "rbxasset://textures/particles/sparkles_main.dds",
            LightEmission = 0.3,
            Acceleration = Vector3.new(0, -9, 0),
            Shape = Enum.ParticleEmitterShape.Box,
            Color = ColorSequence.new(v),
            Size = NumberSequence.new(0.5, 0.3),
            Lifetime = NumberRange.new(2.5, 3.5),
            Speed = NumberRange.new(2, 6),
            SpreadAngle = Vector2.new(60, 60),
            Rotation = NumberRange.new(0, 360),
            RotSpeed = NumberRange.new(-200, 200)
        };
        local ParticleEmitter2 = Instance.new("ParticleEmitter");
        ParticleEmitter2.Rate = 0;
        ParticleEmitter2.LightEmission = 1;

        for i, v2 in v92 do
            ParticleEmitter2[i] = v2;
        end;

        ParticleEmitter2.Parent = v91;
        table.insert(fireworks, ParticleEmitter2);
    end;

    return v41;
end;

local function collect(p93) -- Line: 472
    local v94 = {
        folder = p93,
        sweeps = {},
        pyro = {},
        fireworks = {},
        flashes = {},
        clash = {}
    };
    local Anchors = p93:FindFirstChild("Anchors");
    local v95 = {
        Pyro = v94.pyro,
        Firework = v94.fireworks,
        Clash = v94.clash,
        Flashes = v94.flashes
    };

    for _, child in p93:GetChildren() do
        local v96 = v95[child.Name];

        if v96 then
            for _, child2 in child:GetChildren() do
                if child2:IsA("ParticleEmitter") or child2:IsA("PointLight") then
                    table.insert(v96, child2);
                end;
            end;
        elseif child.Name == "Searchlight" and Anchors then
            local v97 = Anchors:FindFirstChild(child:GetAttribute("Tip") or "");

            if v97 then
                local sweeps = v94.sweeps;
                local v98 = {
                    tip = v97,
                    from = child.Position,
                    phase = child:GetAttribute("Phase") or 0,
                    lean = child:GetAttribute("Lean") or 1
                };
                table.insert(sweeps, v98);
            end;
        end;
    end;

    return v94;
end;

local function burst(p99, p100) -- Line: 493
    -- upvalues: TweenService (copy)
    for _, v in p99 do
        if v:IsA("ParticleEmitter") then
            v:Emit(p100);
        elseif v:IsA("PointLight") then
            v.Brightness = 6;
            TweenService:Create(v, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end;
    end;
end;

local function nightfall() -- Line: 506
    -- upvalues: Lighting (copy)
    local u101 = {};

    local function set(p102, p103, p104) -- Line: 508
        -- upvalues: u101 (copy)
        table.insert(u101, { p102, p103, p102[p103] });
        p102[p103] = p104;
    end;

    local v105 = Lighting;
    table.insert(u101, { v105, "ClockTime", v105.ClockTime });
    v105.ClockTime = 0.4;
    local v106 = Lighting;
    local Color3_fromRGB_ret4 = Color3.fromRGB(50, 54, 80);
    table.insert(u101, { v106, "Ambient", v106.Ambient });
    v106.Ambient = Color3_fromRGB_ret4;
    local v107 = Lighting;
    local Color3_fromRGB_ret5 = Color3.fromRGB(84, 90, 126);
    table.insert(u101, { v107, "OutdoorAmbient", v107.OutdoorAmbient });
    v107.OutdoorAmbient = Color3_fromRGB_ret5;
    local v108 = Lighting;
    table.insert(u101, { v108, "ExposureCompensation", v108.ExposureCompensation });
    v108.ExposureCompensation = 0.25;
    local v109 = Lighting;
    table.insert(u101, { v109, "Brightness", v109.Brightness });
    v109.Brightness = 2;

    for _, child in Lighting:GetChildren() do
        if child:IsA("Sky") then
            local v110 = child;

            for _, v in { "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp" } do
                table.insert(u101, { v110, v, v110[v] });
                v110[v] = "";
            end;

            table.insert(u101, { v110, "StarCount", v110.StarCount });
            v110.StarCount = 5000;
        elseif child:IsA("Atmosphere") then
            table.insert(u101, { child, "Density", child.Density });
            child.Density = 0.36;
            table.insert(u101, { child, "Offset", child.Offset });
            child.Offset = 0.2;
            local Color3_fromRGB_ret6 = Color3.fromRGB(24, 32, 66);
            table.insert(u101, { child, "Color", child.Color });
            child.Color = Color3_fromRGB_ret6;
            local Color3_fromRGB_ret7 = Color3.fromRGB(10, 12, 30);
            table.insert(u101, { child, "Decay", child.Decay });
            child.Decay = Color3_fromRGB_ret7;
            table.insert(u101, { child, "Glare", child.Glare });
            child.Glare = 0;
            table.insert(u101, { child, "Haze", child.Haze });
            child.Haze = 1.6;
        end;
    end;

    local u111 = {};
    local BloomEffect = Instance.new("BloomEffect");
    BloomEffect.Name = "EventIntroBloom";
    BloomEffect.Intensity = 0.6;
    BloomEffect.Size = 24;
    BloomEffect.Threshold = 1.3;
    BloomEffect.Parent = Lighting;
    table.insert(u111, BloomEffect);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "EventIntroGrade";
    ColorCorrectionEffect.Contrast = 0.12;
    ColorCorrectionEffect.Saturation = 0.12;
    ColorCorrectionEffect.Parent = Lighting;
    table.insert(u111, ColorCorrectionEffect);
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    DepthOfFieldEffect.Name = "EventIntroFocus";
    DepthOfFieldEffect.FarIntensity = 0.3;
    DepthOfFieldEffect.NearIntensity = 0;
    DepthOfFieldEffect.InFocusRadius = 14;
    DepthOfFieldEffect.FocusDistance = 20;
    DepthOfFieldEffect.Parent = Lighting;
    table.insert(u111, DepthOfFieldEffect);

    return function() -- Line: 554
        -- upvalues: u101 (copy), u111 (copy)
        for i = #u101, 1, -1 do
            local u112 = u101[i];
            pcall(function() -- Line: 557
                -- upvalues: u112 (copy)
                u112[1][u112[2]] = u112[3];
            end);
            local _ = i;
        end;

        for _, v in u111 do
            v:Destroy();
        end;
    end, ColorCorrectionEffect, DepthOfFieldEffect;
end;

local CharacterClone = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("CharacterClone"));

local function avatar(u113, p114) -- Line: 572
    -- upvalues: Players (copy), CharacterClone (copy)
    for i = 1, p114 do
        local success, result = pcall(function() -- Line: 574
            -- upvalues: u113 (copy), Players (ref)
            local AppliedDescription = u113:GetAppliedDescription();
            local v115 = Players:CreateHumanoidModelFromDescriptionAsync(AppliedDescription, Enum.HumanoidRigType.R6);
            AppliedDescription:Destroy();

            return v115;
        end);

        if success and CharacterClone.dressed(result) then
            return result;
        end;

        if success and result then
            result:Destroy();
        end;

        local v116;

        if i < p114 and u113.Parent then
            task.wait(CharacterClone.RETRY_SECONDS);
            v116 = i;
        else
            v116 = i;
        end;
    end;

    return nil;
end;

local u117 = {
    Football = {
        Run = { "RunAnim", true },
        Catch = { "CatchAnim", false },
        Spike = { "TouchdownAnim", false }
    },
    Futbol = {
        Run = { "RunAnim", true },
        Juggle = { "IntroAnim", false },
        JuggleLoop = { "IntroLoopAnim", true },
        StepOver = { "StepOverAnim", false },
        Slide = { "CelebrateAnim", false },
        SlideLoop = { "CelebrateLoopAnim", true }
    }
};

local function animation(p118) -- Line: 605
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p118;

    return Animation;
end;

local function athlete(p119, p120, p121, p122, p123, p124) -- Line: 612
    -- upvalues: Weapons (copy), CFrame_new_ret (copy), KnifeDisplayRig (copy), Color (copy), Color2 (copy), KnifeVisibility (copy), Color3_new_ret (copy), u117 (copy)
    local v125 = Weapons.Models:FindFirstChild(p121);
    local Model = Instance.new("Model");
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CFrame = CFrame.lookAt(CFrame_new_ret.Position + Vector3.new(p122, 3, 0), CFrame_new_ret.Position + Vector3.new(p122 + p123, 3, 0));
    Part.Parent = Model;
    Model.PrimaryPart = Part;
    local success, result = pcall(KnifeDisplayRig.create, p120, Model, v125);
    Model:Destroy();

    if not success then
        warn("Event intro: a player couldn\'t be dressed:", result);

        return nil;
    end;

    local model = result.model;
    model.Name = "Intro" .. p121;
    local v126 = model:FindFirstChild("Left Leg");
    result.lift = v126 and (result.root.Position.Y - (v126.Position.Y - v126.Size.Y / 2) or 3) or 3;
    result.team = p121;
    result.x = p122;
    result.facing = p123;
    result.color = p121 == "Football" and Color or Color2;

    for _, descendant in model:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CastShadow = true;
        end;
    end;

    if p121 == "Football" then
        KnifeVisibility.set(result.blade, true);
        KnifeVisibility.set(result.stowed, false);
    else
        KnifeVisibility.set(result.blade, false);
        KnifeVisibility.set(result.stowed, false);

        if result.ball then
            KnifeVisibility.set(result.ball, true);
        end;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = result.color:Lerp(Color3_new_ret, 0.35);
    Highlight.OutlineTransparency = 0.15;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = model;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = result.color:Lerp(Color3_new_ret, 0.2);
    PointLight.Range = 12;
    PointLight.Brightness = 1.6;
    PointLight.Parent = result.root;
    local Attachment = Instance.new("Attachment");
    Attachment.CFrame = CFrame.lookAt(Vector3.new(2, 3, -6), Vector3.new(0, 0.5, 0));
    Attachment.Parent = result.root;
    local SpotLight = Instance.new("SpotLight");
    SpotLight.Face = Enum.NormalId.Front;
    SpotLight.Angle = 45;
    SpotLight.Range = 16;
    SpotLight.Brightness = 1.3;
    SpotLight.Color = Color3.fromRGB(255, 240, 220);
    SpotLight.Parent = Attachment;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Position = Vector3.new(0, -2.8, 0.6);
    Attachment2.Parent = result.root;
    local v127 = {
        Texture = "rbxasset://textures/particles/smoke_main.dds",
        LightEmission = 0,
        Acceleration = Vector3.new(0, 4, 0),
        Color = ColorSequence.new(Color3.fromRGB(120, 160, 110), Color3.fromRGB(70, 90, 70)),
        Size = NumberSequence.new(0.8, 2.6),
        Transparency = NumberSequence.new(0.45, 1),
        Lifetime = NumberRange.new(0.35, 0.65),
        Speed = NumberRange.new(3, 6),
        SpreadAngle = Vector2.new(25, 25),
        EmissionDirection = Enum.NormalId.Back
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Rate = 0;
    ParticleEmitter.LightEmission = 1;

    for i, v in v127 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = Attachment2;
    result.dust = ParticleEmitter;
    model.Parent = p119.folder;
    result.clips = {};
    result.base = {};
    result.once = {};
    result.frozen = {};

    local function load(p128, p129, p130, p131) -- Line: 695
        -- upvalues: result (copy)
        if not p129 then
            return;
        end;

        local success2, result2 = pcall(result.animator.LoadAnimation, result.animator, p129);

        if success2 then
            result2.Looped = p130;
            result2.Priority = p131;
            result.clips[p128] = result2;
            result.once[p128] = not p130 or nil;

            if not p130 then
                result2:GetPropertyChangedSignal("Length"):Once(function() -- Line: 707
                    -- upvalues: result2 (copy)
                    result2.Looped = false;
                end);
            end;
        end;
    end;

    local Idle = p124.Idle;
    local Idle2 = Enum.AnimationPriority.Idle;

    if Idle then
        local success2, result2 = pcall(result.animator.LoadAnimation, result.animator, Idle);

        if success2 then
            result2.Looped = true;
            result2.Priority = Idle2;
            result.clips.Idle = result2;
            result.once.Idle = nil;
        end;
    end;

    for i, v in u117[p121] do
        local v132;

        if i == "Run" then
            v132 = Enum.AnimationPriority.Movement;
        else
            v132 = Enum.AnimationPriority.Action;
        end;

        load(i, p124[p121 .. i], v[2], v132);
    end;

    return result;
end;

local function perform(p133, p134, p135, p136) -- Line: 720
    local v137;

    if p133 then
        v137 = p133.clips[p134];
    else
        v137 = p133;
    end;

    if not v137 then
        return;
    end;

    for i, v in p133.clips do
        if i ~= p134 and (i ~= "Idle" and v.IsPlaying) then
            v:Stop(p135 or 0.15);
        end;
    end;

    p133.base[p134] = p136 or 1;
    p133.frozen[p134] = nil;
    local IsPlaying = v137.IsPlaying;
    v137:Play(p135 or 0.15, 1, (p136 or 1) * (p133.slow or 1));

    if IsPlaying then
        v137.TimePosition = 0;
    end;

    p133.current = p134;
end;

local function turn(p138, p139) -- Line: 740
    if p138 then
        local Position = p138.model:GetPivot().Position;
        p138.model:PivotTo(CFrame.lookAt(Position, Position + p139));
    end;
end;

local function pinBall(p140) -- Line: 748
    -- upvalues: CFrame_new_ret (copy)
    if not (p140 and (p140.ballOnFloor and (p140.ball and p140.rootMotor))) then
        return;
    end;

    local rootMotor = p140.rootMotor;
    local CFrame2 = p140.root.CFrame;
    local v141 = CFrame2.LookVector * Vector3.new(1, 0, 1);
    local Vector3_new_ret = Vector3.new(CFrame2.X, CFrame_new_ret.Y + p140.ball.Size.Y / 2, CFrame2.Z);
    local v142 = CFrame.new(Vector3_new_ret + (v141.Magnitude <= 0.01 and Vector3.new(0, 0, 1) or v141.Unit) * 2.4) * (CFrame2 - CFrame2.Position);
    rootMotor.Transform = rootMotor.C0:Inverse() * CFrame2:Inverse() * v142 * rootMotor.C1;
end;

local function place(p143, p144, p145) -- Line: 760
    -- upvalues: CFrame_new_ret (copy)
    p143.x = p144;
    p143.facing = p145 or p143.facing;
    local Vector3_new_ret = Vector3.new(CFrame_new_ret.Position.X + p144, CFrame_new_ret.Position.Y + p143.lift, CFrame_new_ret.Position.Z);
    p143.model:PivotTo(CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + Vector3.new(p143.facing, 0, 0)));
end;

local function tend(p146, p147) -- Line: 769
    if not p146 then
        return;
    end;

    if p146.slow ~= p147 then
        p146.slow = p147;

        for i, v in p146.clips do
            if v.IsPlaying and not p146.frozen[i] then
                v:AdjustSpeed((p146.base[i] or 1) * p147);
            end;
        end;
    end;

    for i, v in p146.clips do
        if p146.once[i] and (v.IsPlaying and not (p146.frozen[i] or (v.Length <= 0 or v.TimePosition < v.Length - 0.05))) then
            p146.frozen[i] = true;
            v:AdjustSpeed(0);
        end;
    end;

    if p146.rootMotor and p146.rest then
        local Transform = p146.rootMotor.Transform;

        if p146.ballOnFloor then
            return;
        end;

        if Transform.Position.Magnitude < 0.0001 then
            local v148 = select(2, Transform:ToAxisAngle());

            if math.abs(v148) < 0.001 then
                p146.rootMotor.Transform = p146.rest;
            end;
        end;
    end;
end;

local function frame(p149, p150) -- Line: 799
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;

    for i, v in p150 do
        Frame[i] = v;
    end;

    Frame.Parent = p149;

    return Frame;
end;

local function text(p151, p152, p153, p154, p155, p156) -- Line: 808
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = p152;
    TextLabel.FontFace = p153;
    TextLabel.TextColor3 = p154;
    TextLabel.TextScaled = true;
    TextLabel.AutoLocalize = false;

    for i, v in p156 do
        TextLabel[i] = v;
    end;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = p155;
    UITextSizeConstraint.Parent = TextLabel;
    TextLabel.Parent = p151;

    return TextLabel;
end;

local function outlined(p157, p158) -- Line: 825
    -- upvalues: Color3_new_ret2 (copy)
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_new_ret2;
    UIStroke.Thickness = p158;
    UIStroke.Transparency = p157.TextTransparency;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = p157;

    return p157;
end;

local function shade(p159, p160, p161, p162) -- Line: 834
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(p160, p161);
    UIGradient.Rotation = p162 or 90;
    UIGradient.Parent = p159;

    return UIGradient;
end;

local function tween(p163, p164, p165, p166, p167) -- Line: 841
    -- upvalues: TweenService (copy)
    local v168 = TweenService:Create(p163, TweenInfo.new(p164, p166 or Enum.EasingStyle.Quad, p167 or Enum.EasingDirection.Out), p165);
    v168:Play();

    return v168;
end;

local function teamTitle(p169, p170, p171, p172, p173) -- Line: 852
    -- upvalues: Color3_new_ret (copy), Color3_new_ret2 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Font_new_ret (copy)
    local v174 = {
        BackgroundTransparency = 1,
        Name = p170 .. "Title",
        AnchorPoint = Vector2.new(p173 and 0 or 1, 0.5),
        Position = UDim2.fromScale(p173 and -0.9 or 1.9, 0.66),
        Size = UDim2.fromScale(0.62, 0.24)
    };
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;

    for i, v in v174 do
        Frame[i] = v;
    end;

    Frame.Parent = p169;
    local v175 = {
        Name = "Slash",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.56),
        Size = UDim2.fromScale(1.25, 0.5),
        Rotation = p173 and -4 or 4,
        BackgroundColor3 = Color3_new_ret
    };
    local Frame2 = Instance.new("Frame");
    Frame2.BorderSizePixel = 0;

    for i, v in v175 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(p172:Lerp(Color3_new_ret, 0.15), p172:Lerp(Color3_new_ret2, 0.35));
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, p173 and 0.05 or 1), NumberSequenceKeypoint.new(0.5, 0.15), NumberSequenceKeypoint.new(1, p173 and 1 or 0.05) });
    UIGradient.Parent = Frame2;
    local v176 = p173 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right;
    local v177 = {
        Name = "Kicker",
        Position = UDim2.fromScale(0.03, 0),
        Size = UDim2.fromScale(0.94, 0.2),
        TextXAlignment = v176
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "TEAM";
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextScaled = true;
    TextLabel.AutoLocalize = false;

    for i, v in v177 do
        TextLabel[i] = v;
    end;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 40;
    UITextSizeConstraint.Parent = TextLabel;
    TextLabel.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_new_ret2;
    UIStroke.Thickness = 2;
    UIStroke.Transparency = TextLabel.TextTransparency;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = TextLabel;
    local v178 = {
        Name = "Name",
        Position = UDim2.fromScale(0.03, 0.14),
        Size = UDim2.fromScale(0.94, 0.72),
        TextXAlignment = v176
    };
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = p170;
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.TextColor3 = Color3_new_ret;
    TextLabel2.TextScaled = true;
    TextLabel2.AutoLocalize = false;

    for i, v in v178 do
        TextLabel2[i] = v;
    end;

    local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint2.MaxTextSize = 160;
    UITextSizeConstraint2.Parent = TextLabel2;
    TextLabel2.Parent = Frame;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3_new_ret2;
    UIStroke2.Thickness = 5;
    UIStroke2.Transparency = TextLabel2.TextTransparency;
    UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke2.Parent = TextLabel2;
    local v179, v180 = p172:Lerp(Color3_new_ret, 0.55);
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Color = ColorSequence.new(Color3_new_ret, v179);
    UIGradient2.Rotation = v180 or 90;
    UIGradient2.Parent = TextLabel2;
    local v181 = {
        Name = "Sport",
        Position = UDim2.fromScale(0.03, 0.84),
        Size = UDim2.fromScale(0.94, 0.16),
        TextXAlignment = v176
    };
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.Text = p171;
    TextLabel3.FontFace = Font_new_ret2;
    TextLabel3.TextColor3 = Color3_new_ret;
    TextLabel3.TextScaled = true;
    TextLabel3.AutoLocalize = false;

    for i, v in v181 do
        TextLabel3[i] = v;
    end;

    local UITextSizeConstraint3 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint3.MaxTextSize = 34;
    UITextSizeConstraint3.Parent = TextLabel3;
    TextLabel3.Parent = Frame;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = Color3_new_ret2;
    UIStroke3.Thickness = 2;
    UIStroke3.Transparency = TextLabel3.TextTransparency;
    UIStroke3.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke3.Parent = TextLabel3;

    return {
        holder = Frame,
        left = p173
    };
end;

local function slam(p182) -- Line: 898
    -- upvalues: TweenService (copy)
    local holder = p182.holder;
    local v183 = {
        Position = UDim2.fromScale(p182.left and 0.04 or 0.96, 0.66)
    };
    TweenService:Create(holder, TweenInfo.new(0.42, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v183):Play();
end;

local function clear(p184) -- Line: 901
    -- upvalues: TweenService (copy)
    local holder = p184.holder;
    local v185 = {
        Position = UDim2.fromScale(p184.left and -0.9 or 1.9, 0.66)
    };
    TweenService:Create(holder, TweenInfo.new(0.3, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out), v185):Play();
end;

local function pop(p186, p187) -- Line: 904
    -- upvalues: TweenService (copy)
    p186.Visible = true;
    local v188 = p186:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", p186);
    v188.Scale = 1.4;
    p186.TextTransparency = 1;
    TweenService:Create(p186, TweenInfo.new(p187 or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play();
    TweenService:Create(v188, TweenInfo.new(0.4, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    local v189 = p186:FindFirstChildOfClass("UIStroke");

    if v189 then
        v189.Transparency = 1;
        TweenService:Create(v189, TweenInfo.new(p187 or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
    end;
end;

local function fade(p190, p191) -- Line: 917
    -- upvalues: TweenService (copy)
    TweenService:Create(p190, TweenInfo.new(p191 or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1
    }):Play();
    local v192 = p190:FindFirstChildOfClass("UIStroke");

    if v192 then
        TweenService:Create(v192, TweenInfo.new(p191 or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end;
end;

local function buildGui() -- Line: 926
    -- upvalues: Presentation (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_new_ret (copy), Color3_new_ret2 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Font_new_ret (copy), Color (copy), Color2 (copy), teamTitle (copy), TeamEventConfig (copy), lines (copy), LocalPlayer (copy)
    local EventIntro = require(Presentation:WaitForChild("CutsceneScreen")).new("EventIntro", 1003);
    EventIntro:SetAttribute("CreatorCaptureExempt", true);
    EventIntro:SetAttribute("SelfManagedText", true);
    local v193 = {
        gui = EventIntro
    };

    for _, v in { "Left", "Right" } do
        local v194 = {
            BackgroundTransparency = 1,
            Name = v .. "Tint",
            Position = UDim2.fromScale(v == "Left" and 0 or 0.5, 0),
            Size = UDim2.fromScale(0.5, 1),
            BackgroundColor3 = v == "Left" and Color3_fromRGB_ret2 or Color3_fromRGB_ret3
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        local v195 = v;

        for i, v2 in v194 do
            Frame[i] = v2;
        end;

        Frame.Parent = EventIntro;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Transparency = NumberSequence.new(v195 == "Left" and 0.35 or 1, v195 == "Left" and 1 or 0.35);
        UIGradient.Parent = Frame;
        v193[v195] = Frame;
    end;

    local v196 = {
        Name = "Flash",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.5, 1.5),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;

    for i, v in v196 do
        Frame[i] = v;
    end;

    Frame.Parent = EventIntro;
    v193.flash = Frame;
    local v197 = {
        Name = "Top",
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.new(1.5, 0, 0.115, 200),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame2 = Instance.new("Frame");
    Frame2.BorderSizePixel = 0;

    for i, v in v197 do
        Frame2[i] = v;
    end;

    Frame2.Parent = EventIntro;
    v193.top = Frame2;
    local v198 = {
        Name = "Bottom",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.new(1.5, 0, 0.115, 200),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame3 = Instance.new("Frame");
    Frame3.BorderSizePixel = 0;

    for i, v in v198 do
        Frame3[i] = v;
    end;

    Frame3.Parent = EventIntro;
    v193.bottom = Frame3;
    local v199 = {
        Name = "Eyebrow",
        TextTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.42),
        Size = UDim2.fromScale(0.6, 0.05)
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "VALLEY RUN PRESENTS";
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextScaled = true;
    TextLabel.AutoLocalize = false;

    for i, v in v199 do
        TextLabel[i] = v;
    end;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 34;
    UITextSizeConstraint.Parent = TextLabel;
    TextLabel.Parent = EventIntro;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_new_ret2;
    UIStroke.Thickness = 2;
    UIStroke.Transparency = TextLabel.TextTransparency;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = TextLabel;
    v193.eyebrow = TextLabel;
    local v200 = {
        Name = "Tagline",
        TextTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.09)
    };
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = "THE RIVALRY OF THE YEAR";
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.TextColor3 = Color3_new_ret;
    TextLabel2.TextScaled = true;
    TextLabel2.AutoLocalize = false;

    for i, v in v200 do
        TextLabel2[i] = v;
    end;

    local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint2.MaxTextSize = 72;
    UITextSizeConstraint2.Parent = TextLabel2;
    TextLabel2.Parent = EventIntro;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3_new_ret2;
    UIStroke2.Thickness = 3;
    UIStroke2.Transparency = TextLabel2.TextTransparency;
    UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke2.Parent = TextLabel2;
    v193.tagline = TextLabel2;
    local v201 = {
        Name = "Question",
        TextTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.8),
        Size = UDim2.fromScale(0.8, 0.08)
    };
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.Text = "WHO RULES VALLEY RUN?";
    TextLabel3.FontFace = Font_new_ret;
    TextLabel3.TextColor3 = Color3_new_ret;
    TextLabel3.TextScaled = true;
    TextLabel3.AutoLocalize = false;

    for i, v in v201 do
        TextLabel3[i] = v;
    end;

    local UITextSizeConstraint3 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint3.MaxTextSize = 64;
    UITextSizeConstraint3.Parent = TextLabel3;
    TextLabel3.Parent = EventIntro;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = Color3_new_ret2;
    UIStroke3.Thickness = 3;
    UIStroke3.Transparency = TextLabel3.TextTransparency;
    UIStroke3.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke3.Parent = TextLabel3;
    v193.question = TextLabel3;

    local function call(p202, p203, p204) -- Line: 972
        -- upvalues: EventIntro (copy), Font_new_ret (ref), Color3_new_ret (ref), Color3_new_ret2 (ref)
        local v205 = {
            TextTransparency = 1,
            Name = p202,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.76),
            Size = UDim2.fromScale(0.8, 0.15)
        };
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.Text = p203;
        TextLabel4.FontFace = Font_new_ret;
        TextLabel4.TextColor3 = Color3_new_ret;
        TextLabel4.TextScaled = true;
        TextLabel4.AutoLocalize = false;

        for i, v in v205 do
            TextLabel4[i] = v;
        end;

        local UITextSizeConstraint4 = Instance.new("UITextSizeConstraint");
        UITextSizeConstraint4.MaxTextSize = 140;
        UITextSizeConstraint4.Parent = TextLabel4;
        TextLabel4.Parent = EventIntro;
        local UIStroke4 = Instance.new("UIStroke");
        UIStroke4.Color = Color3_new_ret2;
        UIStroke4.Thickness = 5;
        UIStroke4.Transparency = TextLabel4.TextTransparency;
        UIStroke4.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke4.Parent = TextLabel4;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Color = ColorSequence.new(Color3_new_ret, p204);
        UIGradient.Rotation = 90;
        UIGradient.Parent = TextLabel4;

        return TextLabel4;
    end;

    v193.touchdown = call("Touchdown", "TOUCHDOWN!", Color:Lerp(Color3_new_ret, 0.2));
    v193.golazo = call("Golazo", "GOLAZO!", Color2:Lerp(Color3_new_ret, 0.25));
    v193.football = teamTitle(EventIntro, TeamEventConfig.Team.Football.Name, "AMERICAN FOOTBALL", Color, true);
    v193.futbol = teamTitle(EventIntro, TeamEventConfig.Team.Futbol.Name, "SOCCER", Color2, false);
    local v206 = {
        Name = "Versus",
        BackgroundTransparency = 1,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.47),
        Size = UDim2.fromScale(0.3, 0.3),
        SizeConstraint = Enum.SizeConstraint.RelativeYY
    };
    local Frame4 = Instance.new("Frame");
    Frame4.BorderSizePixel = 0;

    for i, v in v206 do
        Frame4[i] = v;
    end;

    Frame4.Parent = EventIntro;
    v193.vsScale = Instance.new("UIScale", Frame4);
    v193.rays = Instance.new("ImageLabel");
    v193.rays.Name = "Rays";
    v193.rays.BackgroundTransparency = 1;
    v193.rays.Image = "rbxassetid://129028976496842";
    v193.rays.ImageColor3 = Color3_fromRGB_ret;
    v193.rays.ImageTransparency = 0.35;
    v193.rays.AnchorPoint = Vector2.new(0.5, 0.5);
    v193.rays.Position = UDim2.fromScale(0.5, 0.5);
    v193.rays.Size = UDim2.fromScale(3, 3);
    v193.rays.Parent = Frame4;
    local v207 = {
        Name = "Badge",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame5 = Instance.new("Frame");
    Frame5.BorderSizePixel = 0;

    for i, v in v207 do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame4;
    Instance.new("UICorner", Frame5).CornerRadius = UDim.new(1, 0);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 35;
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3_fromRGB_ret2:Lerp(Color3_new_ret, 0.15)),
        ColorSequenceKeypoint.new(0.48, Color3_fromRGB_ret2),
        ColorSequenceKeypoint.new(0.52, Color3_fromRGB_ret3),
        ColorSequenceKeypoint.new(1, Color3_fromRGB_ret3:Lerp(Color3_new_ret, 0.15))
    });
    UIGradient.Parent = Frame5;
    local UIStroke4 = Instance.new("UIStroke");
    UIStroke4.Color = Color3_fromRGB_ret;
    UIStroke4.Thickness = 7;
    UIStroke4.Parent = Frame5;
    local v208 = {
        Size = UDim2.fromScale(1, 1)
    };
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.Text = "VS";
    TextLabel4.FontFace = Font_new_ret;
    TextLabel4.TextColor3 = Color3_new_ret;
    TextLabel4.TextScaled = true;
    TextLabel4.AutoLocalize = false;

    for i, v in v208 do
        TextLabel4[i] = v;
    end;

    local UITextSizeConstraint4 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint4.MaxTextSize = 200;
    UITextSizeConstraint4.Parent = TextLabel4;
    TextLabel4.Parent = Frame5;
    local UIStroke5 = Instance.new("UIStroke");
    UIStroke5.Color = Color3_new_ret2;
    UIStroke5.Thickness = 5;
    UIStroke5.Transparency = TextLabel4.TextTransparency;
    UIStroke5.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke5.Parent = TextLabel4;
    v193.vs = Frame4;
    local v209 = {
        Name = "Card",
        BackgroundTransparency = 1,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.34),
        Size = UDim2.fromScale(0.9, 0.3)
    };
    local Frame6 = Instance.new("Frame");
    Frame6.BorderSizePixel = 0;

    for i, v in v209 do
        Frame6[i] = v;
    end;

    Frame6.Parent = EventIntro;
    v193.cardScale = Instance.new("UIScale", Frame6);

    local function word(p210, p211, p212, p213, p214) -- Line: 1035
        -- upvalues: Frame6 (copy), Font_new_ret (ref), Color3_new_ret (ref), Color3_new_ret2 (ref)
        local v215 = {
            AnchorPoint = Vector2.new(p214, 0),
            Position = UDim2.fromScale(p212, 0),
            Size = UDim2.fromScale(p213, 0.58),
            TextXAlignment = p214 == 1 and Enum.TextXAlignment.Right or (p214 == 0 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center)
        };
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.Text = p210;
        TextLabel5.FontFace = Font_new_ret;
        TextLabel5.TextColor3 = Color3_new_ret;
        TextLabel5.TextScaled = true;
        TextLabel5.AutoLocalize = false;

        for i, v in v215 do
            TextLabel5[i] = v;
        end;

        local UITextSizeConstraint5 = Instance.new("UITextSizeConstraint");
        UITextSizeConstraint5.MaxTextSize = 150;
        UITextSizeConstraint5.Parent = TextLabel5;
        TextLabel5.Parent = Frame6;
        local UIStroke6 = Instance.new("UIStroke");
        UIStroke6.Color = Color3_new_ret2;
        UIStroke6.Thickness = 5;
        UIStroke6.Transparency = TextLabel5.TextTransparency;
        UIStroke6.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke6.Parent = TextLabel5;
        local UIGradient2 = Instance.new("UIGradient");
        UIGradient2.Color = ColorSequence.new(Color3_new_ret, p211);
        UIGradient2.Rotation = 90;
        UIGradient2.Parent = TextLabel5;

        return TextLabel5;
    end;

    word(TeamEventConfig.Team.Football.Name, Color:Lerp(Color3_new_ret, 0.25), 0.445, 0.44, 1);
    word("vs", Color3_fromRGB_ret, 0.5, 0.09, 0.5);
    word(TeamEventConfig.Team.Futbol.Name, Color2:Lerp(Color3_new_ret, 0.3), 0.555, 0.44, 0);
    local v216, v217 = TeamEventConfig.window();
    local math_max_ret = math.max(v216 or 0, TeamEventConfig.StartsAt or 0);
    local os_date_ret = os.date("!*t", math_max_ret);
    local os_date_ret2 = os.date("!*t", v217 or TeamEventConfig.EndsAt);
    local v218 = {
        Position = UDim2.fromScale(0, 0.6),
        Size = UDim2.fromScale(1, 0.2)
    };
    local TextLabel5 = Instance.new("TextLabel");
    TextLabel5.BackgroundTransparency = 1;
    TextLabel5.Text = "TEAM EVENT  ·  PICK YOUR SIDE";
    TextLabel5.FontFace = Font_new_ret2;
    TextLabel5.TextColor3 = Color3_fromRGB_ret;
    TextLabel5.TextScaled = true;
    TextLabel5.AutoLocalize = false;
    local v219 = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };

    for i, v in v218 do
        TextLabel5[i] = v;
    end;

    local UITextSizeConstraint5 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint5.MaxTextSize = 52;
    UITextSizeConstraint5.Parent = TextLabel5;
    TextLabel5.Parent = Frame6;
    local UIStroke6 = Instance.new("UIStroke");
    UIStroke6.Color = Color3_new_ret2;
    UIStroke6.Thickness = 3;
    UIStroke6.Transparency = TextLabel5.TextTransparency;
    UIStroke6.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke6.Parent = TextLabel5;
    local v220 = ("%s %d – %s %d"):format(v219[os_date_ret.month], os_date_ret.day, v219[os_date_ret2.month], os_date_ret2.day);
    local v221 = {
        Position = UDim2.fromScale(0, 0.82),
        Size = UDim2.fromScale(1, 0.15)
    };
    local TextLabel6 = Instance.new("TextLabel");
    TextLabel6.BackgroundTransparency = 1;
    TextLabel6.Text = v220;
    TextLabel6.FontFace = Font_new_ret2;
    TextLabel6.TextColor3 = Color3_new_ret;
    TextLabel6.TextScaled = true;
    TextLabel6.AutoLocalize = false;

    for i, v in v221 do
        TextLabel6[i] = v;
    end;

    local UITextSizeConstraint6 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint6.MaxTextSize = 36;
    UITextSizeConstraint6.Parent = TextLabel6;
    TextLabel6.Parent = Frame6;
    local UIStroke7 = Instance.new("UIStroke");
    UIStroke7.Color = Color3_new_ret2;
    UIStroke7.Thickness = 2;
    UIStroke7.Transparency = TextLabel6.TextTransparency;
    UIStroke7.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke7.Parent = TextLabel6;
    v193.card = Frame6;
    local v222 = {
        Name = "Black",
        BackgroundTransparency = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.5, 1.5),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame7 = Instance.new("Frame");
    Frame7.BorderSizePixel = 0;

    for i, v in v222 do
        Frame7[i] = v;
    end;

    Frame7.Parent = EventIntro;
    v193.black = Frame7;
    local Font_new_ret3 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Medium, Enum.FontStyle.Italic);
    local v223 = {
        Name = "Typed",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.07)
    };
    local TextLabel7 = Instance.new("TextLabel");
    TextLabel7.BackgroundTransparency = 1;
    TextLabel7.Text = "";
    TextLabel7.FontFace = Font_new_ret3;
    TextLabel7.TextColor3 = Color3_new_ret;
    TextLabel7.TextScaled = true;
    TextLabel7.AutoLocalize = false;

    for i, v in v223 do
        TextLabel7[i] = v;
    end;

    local UITextSizeConstraint7 = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint7.MaxTextSize = 46;
    UITextSizeConstraint7.Parent = TextLabel7;
    TextLabel7.Parent = EventIntro;
    v193.typed = TextLabel7;
    v193.lines = lines();
    EventIntro.Parent = LocalPlayer:WaitForChild("PlayerGui");

    return v193;
end;

local function flash(p224, p225, p226) -- Line: 1074
    -- upvalues: TweenService (copy)
    p224.flash.BackgroundTransparency = 1 - p225;
    TweenService:Create(p224.flash, TweenInfo.new(p226 or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
end;

local function letterbox(p227, p228) -- Line: 1078
    p227.top.Position = UDim2.fromScale(0.5, 0.115 * p228);
    p227.bottom.Position = UDim2.fromScale(0.5, 1 - 0.115 * p228);
end;

local u229 = false;
local u230 = {
    speed = 1
};

local function play(u231, u232) -- Line: 1088
    -- upvalues: u229 (ref), RunService (copy), KnifeDisplayRig (copy), LocalPlayer (copy), TweenService (copy), u6 (copy), u5 (copy), buildGui (copy), CreatorVisibility (copy), SoundService (copy), Presentation (copy), buildStage (copy), collect (copy), nightfall (copy), athlete (copy), CFrame_new_ret (copy), perform (copy), u230 (copy), u2 (copy), pop (copy), fade (copy), slam (copy), clear (copy), burst (copy), place (copy), tend (copy), pinBall (copy)
    if u229 then
        return;
    end;

    u229 = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u233 = {
        shake = 0,
        shakeUntil = 0,
        connections = {},
        fired = {}
    };
    local Folder = Instance.new("Folder");
    Folder.Name = "EventIntroSet";
    local u234 = nil;
    local u235 = nil;
    local u236 = nil;
    local u237 = nil;
    local u238 = nil;
    local u239 = nil;
    local u240 = nil;
    local u241 = nil;
    local u242 = nil;
    local u243 = {
        workspace_CurrentCamera.CameraType,
        workspace_CurrentCamera.CameraSubject,
        workspace_CurrentCamera.FieldOfView,
        workspace_CurrentCamera.CFrame
    };
    local u244 = {};
    local u245 = false;

    local function cleanup() -- Line: 1106
        -- upvalues: u245 (ref), RunService (ref), u233 (copy), u244 (copy), KnifeDisplayRig (ref), u234 (ref), Folder (ref), u231 (copy), u236 (ref), workspace_CurrentCamera (copy), u243 (copy), LocalPlayer (ref), u239 (ref), u240 (ref), u241 (ref), u242 (ref), TweenService (ref), u235 (ref), u229 (ref)
        if u245 then
            return;
        end;

        u245 = true;
        RunService:UnbindFromRenderStep("EventIntro");

        for _, v in u233.connections do
            v:Disconnect();
        end;

        for _, v in u244 do
            for _, v2 in v.clips do
                v2:Stop(0);
                v2:Destroy();
            end;

            pcall(KnifeDisplayRig.destroy, {
                tracks = {},
                assets = {},
                model = v.model
            });
        end;

        if u234 then
            for _, v in ipairs(u234) do
                v:Destroy();
            end;
        end;

        Folder:Destroy();

        for _, v in u231.sounds do
            v:Stop();
        end;

        if u236 then
            u236();
        end;

        workspace_CurrentCamera.CameraType = u243[1] == Enum.CameraType.Scriptable and Enum.CameraType.Custom or u243[1];
        local v246 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
        workspace_CurrentCamera.CameraSubject = v246 or u243[2];
        workspace_CurrentCamera.FieldOfView = u243[3];
        workspace_CurrentCamera.CFrame = u243[4];

        if u239 then
            u239:destroy();
        end;

        if u240 then
            pcall(u240.Enable, u240);
        end;

        if u241 then
            local v247 = {
                Volume = u242
            };
            TweenService:Create(u241, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v247):Play();
        end;

        LocalPlayer:SetAttribute("MusicPaused", nil);

        if u235 then
            for _, child in u235.gui:GetChildren() do
                if child ~= u235.black and child:IsA("GuiObject") then
                    child.Visible = false;
                end;
            end;

            u235.black.BackgroundTransparency = 0;
            TweenService:Create(u235.black, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            task.delay(0.65, function() -- Line: 1159
                -- upvalues: u235 (ref)
                u235.gui:Destroy();
            end);
        end;

        LocalPlayer:SetAttribute("EventIntroActive", nil);
        u229 = false;
    end;

    local sounds = u231.sounds;

    local function cue(p248, p249) -- Line: 1167
        -- upvalues: sounds (copy)
        local v250 = sounds[p248];

        if v250 then
            v250.Volume = p249 or (v250:GetAttribute("Volume") or 0.6);
            v250.TimePosition = 0;
            v250:Play();
        end;

        return v250;
    end;

    local function once(p251, p252, p253, p254) -- Line: 1176
        -- upvalues: u233 (copy)
        if not u233.fired[p251] and p253 <= p252 then
            u233.fired[p251] = true;
            p254();
        end;
    end;

    local function coldOpen(p255) -- Line: 1184
        -- upvalues: u231 (copy), sounds (copy), TweenService (ref), u233 (copy), u6 (ref), u5 (ref), u235 (ref)
        local function v257() -- Line: 1185
            -- upvalues: u231 (ref), sounds (ref), TweenService (ref)
            local muffle = u231.muffle;
            muffle.LowGain = 3;
            muffle.MidGain = -6;
            muffle.HighGain = -16;
            local Crowd = sounds.Crowd;

            if Crowd then
                Crowd.Volume = 0;
                Crowd.TimePosition = 0;
                Crowd:Play();
            end;

            if Crowd then
                local v256 = {
                    Volume = Crowd:GetAttribute("Volume")
                };
                TweenService:Create(Crowd, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v256):Play();
            end;
        end;

        if not u233.fired.open and p255 >= 0 then
            u233.fired.open = true;
            v257();
        end;

        for i, v in u6 do
            local v258 = "thud" .. i;

            local function _() -- Line: 1194
                -- upvalues: i (copy), sounds (ref)
                local v259 = sounds[i % 2 == 0 and "Kick2" or "Kick"];

                if v259 then
                    v259.Volume = 1;
                    v259.TimePosition = 0;
                    v259:Play();
                end;
            end;

            if not u233.fired[v258] and v <= p255 then
                u233.fired[v258] = true;
                local v260 = sounds[i % 2 == 0 and "Kick2" or "Kick"];

                if v260 then
                    v260.Volume = 1;
                    v260.TimePosition = 0;
                    v260:Play();
                end;
            end;
        end;

        local v261 = "";

        for i, v in u5 do
            if v[1] <= p255 and p255 < v[3] then
                local v262 = u235.lines[i];
                local v263 = utf8.len(v262) or #v262;
                local math_floor_ret = math.floor((p255 - v[1]) * v[2]);
                local math_min_ret = math.min(v263, math_floor_ret);
                local v264 = utf8.offset(v262, math_min_ret + 1) or #v262 + 1;
                v261 = string.sub(v262, 1, v264 - 1) .. (math.floor(p255 * 3) % 2 == 0 and "_" or " ");
            end;
        end;

        if u235.typed.Text ~= v261 then
            u235.typed.Text = v261;
        end;
    end;

    local u265 = nil;
    local u266 = nil;
    local success, result = pcall(function() -- Line: 1212
        -- upvalues: LocalPlayer (ref), u235 (ref), buildGui (ref), u265 (ref), u266 (ref), RunService (ref), coldOpen (copy), u239 (ref), CreatorVisibility (ref), u240 (ref), SoundService (ref), u241 (ref), u242 (ref), TweenService (ref), Presentation (ref), Folder (ref), buildStage (ref), u234 (ref), collect (ref), u236 (ref), u237 (ref), u238 (ref), nightfall (ref), u231 (copy), u244 (copy), athlete (ref), workspace_CurrentCamera (copy)
        LocalPlayer:SetAttribute("EventIntroActive", true);
        u235 = buildGui();
        u265 = os.clock();
        u266 = RunService.RenderStepped:Connect(function() -- Line: 1216
            -- upvalues: coldOpen (ref), u265 (ref)
            local v267 = os.clock() - u265;
            coldOpen((math.min(v267, 6.6)));
        end);

        if LocalPlayer:GetAttribute("CreatorUIHidden") ~= true then
            u239 = CreatorVisibility.new(LocalPlayer);
            u239:setHidden(true);
        end;

        local success, result = pcall(function() -- Line: 1224
            -- upvalues: LocalPlayer (ref)
            return require(LocalPlayer:WaitForChild("PlayerScripts"):FindFirstChild("PlayerModule")):GetControls();
        end);

        if success and result then
            u240 = result;
            pcall(u240.Disable, u240);
        end;

        local GameAudioMixer = SoundService:FindFirstChild("GameAudioMixer");
        LocalPlayer:SetAttribute("MusicPaused", true);

        if GameAudioMixer then
            GameAudioMixer = GameAudioMixer:FindFirstChild("Music");
        end;

        u241 = GameAudioMixer;

        if u241 and u241:IsA("SoundGroup") then
            u242 = u241.Volume;
            TweenService:Create(u241, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
        else
            u241 = nil;
        end;

        task.wait();
        local EventIntroStadium = Presentation:FindFirstChild("EventIntroStadium");

        if EventIntroStadium then
            Folder:Destroy();
            Folder = EventIntroStadium:Clone();
            Folder.Name = "EventIntroSet";
        else
            buildStage(Folder);
        end;

        u234 = collect(Folder);
        task.wait();
        Folder.Parent = workspace;
        local v268, v269, v270 = nightfall();
        u236 = v268;
        u237 = v269;
        u238 = v270;
        task.wait();
        local templates = u231.templates;
        local v271 = templates.a and athlete(u234, templates.a, "Football", -34, 1, u231.animations);
        u244.a = v271;
        task.wait();
        local v272 = templates.b and athlete(u234, templates.b, "Futbol", 34, -1, u231.animations);
        u244.b = v272;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    end);

    if u266 then
        u266:Disconnect();
    end;

    if not success then
        warn("Event intro couldn\'t start:", result);
        cleanup();

        return;
    end;

    local a = u244.a;
    local b = u244.b;

    local function shake(p273, p274) -- Line: 1273
        -- upvalues: u233 (copy)
        u233.shake = p273;
        u233.shakeFor = p274;
        u233.shakeUntil = os.clock() + p274;
    end;

    if a then
        a.x = -34;
        a.facing = 1;
        local Vector3_new_ret = Vector3.new(CFrame_new_ret.Position.X + -34, CFrame_new_ret.Position.Y + a.lift, CFrame_new_ret.Position.Z);
        a.model:PivotTo(CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + Vector3.new(a.facing, 0, 0)));
        perform(a, "Idle", 0);
    end;

    if b then
        b.x = 34;
        b.facing = -1;
        local Vector3_new_ret = Vector3.new(CFrame_new_ret.Position.X + 34, CFrame_new_ret.Position.Y + b.lift, CFrame_new_ret.Position.Z);
        b.model:PivotTo(CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + Vector3.new(b.facing, 0, 0)));
        perform(b, "JuggleLoop", 0);

        if b.clips.Idle then
            b.clips.Idle:Play(0);
        end;
    end;

    if a and a.clips.Idle then
        a.clips.Idle:Play(0);
    end;

    local Y = CFrame_new_ret.Position.Y;

    local function spot(p275, p276) -- Line: 1294
        -- upvalues: CFrame_new_ret (ref)
        if p275 then
            return p275.model:GetPivot().Position;
        end;

        return CFrame_new_ret.Position + Vector3.new(p276, 3, 0);
    end;

    local function framed(p277, p278, p279) -- Line: 1298
        local CFrame_lookAt_ret = CFrame.lookAt(p277, p278);

        return CFrame.lookAt(p277, p278 - CFrame_lookAt_ret.RightVector * p279);
    end;

    local function shot(p280) -- Line: 1303
        -- upvalues: a (copy), CFrame_new_ret (ref), b (copy), Y (copy)
        local v281 = a;
        local v282;

        if v281 then
            v282 = v281.model:GetPivot().Position;
        else
            v282 = CFrame_new_ret.Position + Vector3.new(-34, 3, 0);
        end;

        local v283 = b;
        local v284;

        if v283 then
            v284 = v283.model:GetPivot().Position;
        else
            v284 = CFrame_new_ret.Position + Vector3.new(34, 3, 0);
        end;

        if p280 < 8.7 then
            local v285 = math.max(0, p280 - 6.8) / 1.8999999999999995;
            local v286 = CFrame_new_ret.Position + Vector3.new(-170, 80, -110);
            local v287 = CFrame_new_ret.Position + Vector3.new(-62, 7, -30);
            local v288 = CFrame_new_ret.Position + Vector3.new(0, 0, 0);
            local math_clamp_ret = math.clamp(v285, 0, 1);
            local v289 = v288:Lerp(v282 + Vector3.new(0, 1, 0), math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret));
            local CFrame_lookAt_ret = CFrame.lookAt(v286:Lerp(v287, 1 - (1 - math.clamp(v285, 0, 1)) ^ 3), v289);
            local math_clamp_ret2 = math.clamp(v285, 0, 1);

            return CFrame_lookAt_ret, 70 - 16 * (math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2));
        end;

        if p280 < 10.8 then
            local v290 = (p280 - 8.7) / 2.1000000000000014;
            local v291 = -60 + 95 * (1 - (1 - math.clamp(v290, 0, 1)) ^ 3);
            local math_rad_ret = math.rad(v291);
            local v292 = 14 - 3.5 * (1 - (1 - math.clamp(v290, 0, 1)) ^ 3);
            local v293 = math.cos(math_rad_ret) * v292;
            local v294 = math.sin(math_rad_ret) * v292;
            local v295 = v282 + Vector3.new(v293, -2 + 0.8 * v290, v294);
            local v296 = v282 + Vector3.new(0, 0.4, 0);
            local CFrame_lookAt_ret = CFrame.lookAt(v295, v296);

            return CFrame.lookAt(v295, v296 - CFrame_lookAt_ret.RightVector * 2.2), 40 - 4 * (1 - (1 - math.clamp(v290, 0, 1)) ^ 3);
        end;

        if p280 < 12.9 then
            local v297 = (p280 - 10.8) / 2.0999999999999996;
            local v298 = 60 - 95 * (1 - (1 - math.clamp(v297, 0, 1)) ^ 3);
            local math_rad_ret = math.rad(v298);
            local v299 = 14 - 3.5 * (1 - (1 - math.clamp(v297, 0, 1)) ^ 3);
            local v300 = -math.cos(math_rad_ret) * v299;
            local v301 = math.sin(math_rad_ret) * v299;
            local v302 = v284 + Vector3.new(v300, -2 + 0.8 * v297, v301);
            local v303 = v284 + Vector3.new(0, 1.1, 0);
            local CFrame_lookAt_ret = CFrame.lookAt(v302, v303);

            return CFrame.lookAt(v302, v303 - CFrame_lookAt_ret.RightVector * -2.2), 40 - 4 * (1 - (1 - math.clamp(v297, 0, 1)) ^ 3);
        end;

        if p280 >= 15.3 then
            if p280 >= 16.7 then
                if p280 < 17.6 then
                    local v304 = (p280 - 16.7) / 0.9000000000000021;
                    local v305 = v282 + Vector3.new(4.5 - 1 * v304, -1.6, 12 - 2 * v304);

                    return CFrame.lookAt(v305, v282 + Vector3.new(0, 0.9, 0)), 50 - 6 * v304;
                end;

                if p280 < 18.5 then
                    local v306 = (p280 - 17.6) / 0.8999999999999986;
                    local v307 = v284 + Vector3.new(-7.5 + 1 * v306, -1.8, 11 - 2 * v306);

                    return CFrame.lookAt(v307, v284 + Vector3.new(0, 0.2, 0)), 50 - 6 * v306;
                end;

                local v308 = (p280 - 18.5) / 5.199999999999999;
                local v309 = 2.5 + 15 * (1 - (1 - math.clamp(v308, 0, 1)) ^ 3);
                local v310 = 13 + 24 * (1 - (1 - math.clamp(v308, 0, 1)) ^ 3);
                local v311 = CFrame_new_ret.Position + Vector3.new(0, v309, v310);

                return CFrame.lookAt(v311, CFrame_new_ret.Position + Vector3.new(0, 3.5 + 3 * v308, 0)), 60;
            end;

            local v312 = (p280 - 15.3) / 1.3999999999999986;
            local math_rad_ret = math.rad(90 - 14 * v312);
            local v313 = CFrame_new_ret.Position + Vector3.new(0, 2.2 + 0.8 * v312, 0);
            local v314 = math.cos(math_rad_ret) * 10.5;
            local v315 = math.sin(math_rad_ret) * 10.5;
            local v316 = v313 + Vector3.new(v314, 0, v315);
            local v317 = 1 - (1 - (1 - math.clamp((p280 - 15.3) / 0.35, 0, 1)) ^ 3);

            return CFrame.lookAt(v316, CFrame_new_ret.Position + Vector3.new(0, 3.4, 0)), 58 - 22 * v317;
        end;

        local v318 = (p280 - 12.9) / 2.4000000000000004;
        local v319 = (v282 + v284) / 2;
        local math_clamp_ret = math.clamp(v318, 0, 1);
        local v320 = 50 - 6 * (math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret));
        local v321 = math.abs(v284.X - v282.X) + 10;
        local math_rad_ret = math.rad(v320 / 2);
        local v322 = v321 / (math.tan(math_rad_ret) * 2 * 1.5);
        local v323 = v319.X + math.sin(v318 * 2) * 2;
        local Vector3_new_ret = Vector3.new(v323, Y + 1.4 + v322 * 0.1, CFrame_new_ret.Position.Z + v322);

        return CFrame.lookAt(Vector3_new_ret, v319 + Vector3.new(0, 0.4, 0)), v320;
    end;

    local function slowAt(p324) -- Line: 1359
        if p324 < 14.5 then
            return 1;
        end;

        if p324 >= 15.3 then
            return p324 < 15.440000000000001 and 0 or (p324 < 16.7 and 0.28 or 1);
        end;

        local math_clamp_ret = math.clamp((p324 - 14.5) / 0.8000000000000007, 0, 1);

        return 1 - 0.8 * (math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret));
    end;

    local u325;

    if u265 then
        local v326 = os.clock() - u265;
        u325 = math.min(v326, 6.6);
    else
        u325 = 0;
    end;

    RunService:BindToRenderStep("EventIntro", Enum.RenderPriority.Camera.Value + 20, function(p327) -- Line: 1373
        -- upvalues: u230 (ref), u325 (ref), u232 (ref), cleanup (copy), u2 (ref), coldOpen (copy), u235 (ref), TweenService (ref), sounds (copy), u231 (copy), u233 (copy), pop (ref), fade (ref), perform (ref), a (copy), slam (ref), clear (ref), b (copy), burst (ref), u234 (ref), u237 (ref), place (ref), tend (ref), shot (copy), workspace_CurrentCamera (copy), u238 (ref), CFrame_new_ret (ref)
        local v328 = math.min(p327, 0.1) * u230.speed;

        if u230.seek then
            u325 = u230.seek;
            u230.seek = nil;
        end;

        u325 = u325 + v328;
        local v329 = u325;

        if u232 and u232 <= v329 then
            u230.speed = 0;
            u232 = nil;
        end;

        if v329 >= 23.7 then
            cleanup();

            return;
        end;

        local v330;

        if v329 < u2.slow then
            v330 = 1;
        elseif v329 < u2.vs then
            local math_clamp_ret = math.clamp((v329 - u2.slow) / (u2.vs - u2.slow), 0, 1);
            v330 = 1 - 0.8 * (math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret));
        else
            v330 = v329 < u2.vs + 0.14 and 0 or (v329 < u2.spike and 0.28 or 1);
        end;

        coldOpen(v329);

        local function v333() -- Line: 1393
            -- upvalues: u235 (ref), TweenService (ref), sounds (ref), u231 (ref)
            u235.typed.Visible = false;
            TweenService:Create(u235.black, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            local v331 = u235;
            v331.flash.BackgroundTransparency = 0.75;
            TweenService:Create(v331.flash, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = 0.7;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            TweenService:Create(u231.muffle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                LowGain = 0,
                MidGain = 0,
                HighGain = 0
            }):Play();
            local Music = sounds.Music;

            if Music then
                Music.Volume = 0;
                Music.TimePosition = 0;
                Music:Play();
            end;

            if Music then
                local v332 = {
                    Volume = Music:GetAttribute("Volume")
                };
                TweenService:Create(Music, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v332):Play();
            end;

            local CrowdBed = sounds.CrowdBed;

            if CrowdBed then
                CrowdBed.Volume = 0;
                CrowdBed.TimePosition = 0;
                CrowdBed:Play();
            end;

            if CrowdBed then
                TweenService:Create(CrowdBed, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Volume = 0.5
                }):Play();
            end;

            local CrowdCheer = sounds.CrowdCheer;

            if CrowdCheer then
                CrowdCheer.Volume = 0.5;
                CrowdCheer.TimePosition = 0;
                CrowdCheer:Play();
            end;
        end;

        if not u233.fired.reveal and v329 >= 6.8 then
            u233.fired.reveal = true;
            v333();
        end;

        local function _() -- Line: 1410
            -- upvalues: pop (ref), u235 (ref)
            pop(u235.eyebrow, 0.4);
        end;

        if not u233.fired.eyebrow and v329 >= 7.05 then
            u233.fired.eyebrow = true;
            pop(u235.eyebrow, 0.4);
        end;

        local function _() -- Line: 1413
            -- upvalues: pop (ref), u235 (ref)
            pop(u235.tagline, 0.3);
        end;

        if not u233.fired.tagline and v329 >= 7.45 then
            u233.fired.tagline = true;
            pop(u235.tagline, 0.3);
        end;

        local function _() -- Line: 1416
            -- upvalues: fade (ref), u235 (ref)
            fade(u235.eyebrow, 0.25);
            fade(u235.tagline, 0.25);
        end;

        if not u233.fired.taglineOut and v329 >= 8.399999999999999 then
            u233.fired.taglineOut = true;
            fade(u235.eyebrow, 0.25);
            fade(u235.tagline, 0.25);
        end;

        local function _() -- Line: 1420
            -- upvalues: sounds (ref), u235 (ref), TweenService (ref), perform (ref), a (ref)
            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = Whoosh:GetAttribute("Volume") or 0.6;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            local v334 = u235;
            v334.flash.BackgroundTransparency = 0.4;
            TweenService:Create(v334.flash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            perform(a, "Catch", 0.05, 0.85);
        end;

        if not u233.fired.football and v329 >= 8.7 then
            u233.fired.football = true;
            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = Whoosh:GetAttribute("Volume") or 0.6;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            local v335 = u235;
            v335.flash.BackgroundTransparency = 0.4;
            TweenService:Create(v335.flash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            perform(a, "Catch", 0.05, 0.85);
        end;

        local function _() -- Line: 1425
            -- upvalues: sounds (ref)
            local Clack = sounds.Clack;

            if Clack then
                Clack.Volume = 0.7;
                Clack.TimePosition = 0;
                Clack:Play();
            end;

            local CrowdSurge = sounds.CrowdSurge;

            if CrowdSurge then
                CrowdSurge.Volume = 0.35;
                CrowdSurge.TimePosition = 0;
                CrowdSurge:Play();
            end;
        end;

        if not u233.fired.catchHit and v329 >= 9.149999999999999 then
            u233.fired.catchHit = true;
            local Clack = sounds.Clack;

            if Clack then
                Clack.Volume = 0.7;
                Clack.TimePosition = 0;
                Clack:Play();
            end;

            local CrowdSurge = sounds.CrowdSurge;

            if CrowdSurge then
                CrowdSurge.Volume = 0.35;
                CrowdSurge.TimePosition = 0;
                CrowdSurge:Play();
            end;
        end;

        local function _() -- Line: 1429
            -- upvalues: sounds (ref), slam (ref), u235 (ref), u233 (ref)
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.6;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            local CrowdSurge = sounds.CrowdSurge;

            if CrowdSurge then
                CrowdSurge.Volume = 0.5;
                CrowdSurge.TimePosition = 0;
                CrowdSurge:Play();
            end;

            slam(u235.football);
            u233.shake = 0.9;
            u233.shakeFor = 0.35;
            u233.shakeUntil = os.clock() + 0.35;
        end;

        if not u233.fired.footballTitle and v329 >= 9 then
            u233.fired.footballTitle = true;
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.6;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            local CrowdSurge = sounds.CrowdSurge;

            if CrowdSurge then
                CrowdSurge.Volume = 0.5;
                CrowdSurge.TimePosition = 0;
                CrowdSurge:Play();
            end;

            slam(u235.football);
            u233.shake = 0.9;
            u233.shakeFor = 0.35;
            u233.shakeUntil = os.clock() + 0.35;
        end;

        local function _() -- Line: 1435
            -- upvalues: clear (ref), u235 (ref)
            clear(u235.football);
        end;

        if not u233.fired.footballOut and v329 >= 10.55 then
            u233.fired.footballOut = true;
            clear(u235.football);
        end;

        local function _() -- Line: 1438
            -- upvalues: sounds (ref), u235 (ref), TweenService (ref), perform (ref), b (ref)
            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = Whoosh:GetAttribute("Volume") or 0.6;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            local v336 = u235;
            v336.flash.BackgroundTransparency = 0.4;
            TweenService:Create(v336.flash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            perform(b, "Juggle", 0.05);
        end;

        if not u233.fired.futbol and v329 >= 10.8 then
            u233.fired.futbol = true;
            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = Whoosh:GetAttribute("Volume") or 0.6;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            local v337 = u235;
            v337.flash.BackgroundTransparency = 0.4;
            TweenService:Create(v337.flash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            perform(b, "Juggle", 0.05);
        end;

        local function _() -- Line: 1443
            -- upvalues: perform (ref), b (ref)
            perform(b, "JuggleLoop", 0.1);
        end;

        if not u233.fired.futbolLoop and v329 >= 12.3 then
            u233.fired.futbolLoop = true;
            perform(b, "JuggleLoop", 0.1);
        end;

        local function _() -- Line: 1446
            -- upvalues: sounds (ref), slam (ref), u235 (ref), u233 (ref)
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.6;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            local Pyro = sounds.Pyro;

            if Pyro then
                Pyro.Volume = 0.55;
                Pyro.TimePosition = 0;
                Pyro:Play();
            end;

            slam(u235.futbol);
            u233.shake = 0.9;
            u233.shakeFor = 0.35;
            u233.shakeUntil = os.clock() + 0.35;
        end;

        if not u233.fired.futbolTitle and v329 >= 11.1 then
            u233.fired.futbolTitle = true;
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.6;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            local Pyro = sounds.Pyro;

            if Pyro then
                Pyro.Volume = 0.55;
                Pyro.TimePosition = 0;
                Pyro:Play();
            end;

            slam(u235.futbol);
            u233.shake = 0.9;
            u233.shakeFor = 0.35;
            u233.shakeUntil = os.clock() + 0.35;
        end;

        if v329 >= 11 and (v329 < 12.6 and (u233.nextKick or 0) <= v329) then
            u233.kicks = (u233.kicks or 0) + 1;
            u233.nextKick = v329 + 0.5;
            local v338 = sounds[u233.kicks % 2 == 0 and "Kick2" or "Kick"];

            if v338 then
                v338.Volume = 0.55;
                v338.TimePosition = 0;
                v338:Play();
            end;
        end;

        local function _() -- Line: 1458
            -- upvalues: sounds (ref)
            local Riser = sounds.Riser;

            if Riser then
                Riser.Volume = Riser:GetAttribute("Volume") or 0.6;
                Riser.TimePosition = 0;
                Riser:Play();
            end;
        end;

        if not u233.fired.riser and v329 >= 11.25 then
            u233.fired.riser = true;
            local Riser = sounds.Riser;

            if Riser then
                Riser.Volume = Riser:GetAttribute("Volume") or 0.6;
                Riser.TimePosition = 0;
                Riser:Play();
            end;
        end;

        local function _() -- Line: 1461
            -- upvalues: clear (ref), u235 (ref)
            clear(u235.futbol);
        end;

        if not u233.fired.futbolOut and v329 >= 12.65 then
            u233.fired.futbolOut = true;
            clear(u235.futbol);
        end;

        local function v340() -- Line: 1464
            -- upvalues: sounds (ref), u235 (ref), TweenService (ref), perform (ref), a (ref), b (ref)
            local Whistle = sounds.Whistle;

            if Whistle then
                Whistle.Volume = 0.5;
                Whistle.TimePosition = 0;
                Whistle:Play();
            end;

            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = 0.5;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            local v339 = u235;
            v339.flash.BackgroundTransparency = 0.65;
            TweenService:Create(v339.flash, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            perform(a, "Run", 0.1);
            perform(b, "Run", 0.1);

            for _, v in { a, b } do
                v.dust.Rate = 40;
            end;
        end;

        if not u233.fired.charge and v329 >= 12.9 then
            u233.fired.charge = true;
            v340();
        end;

        local function _() -- Line: 1474
            -- upvalues: pop (ref), u235 (ref)
            pop(u235.question, 0.3);
        end;

        if not u233.fired.question and v329 >= 13.25 then
            u233.fired.question = true;
            pop(u235.question, 0.3);
        end;

        local function _() -- Line: 1477
            -- upvalues: fade (ref), u235 (ref)
            fade(u235.question, 0.25);
        end;

        if not u233.fired.questionOut and v329 >= 14.950000000000001 then
            u233.fired.questionOut = true;
            fade(u235.question, 0.25);
        end;

        local function v342() -- Line: 1480
            -- upvalues: sounds (ref), u235 (ref), TweenService (ref), u233 (ref), burst (ref), u234 (ref), a (ref), b (ref), perform (ref), u237 (ref)
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 1;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            local Clack = sounds.Clack;

            if Clack then
                Clack.Volume = 0.9;
                Clack.TimePosition = 0;
                Clack:Play();
            end;

            local Pyro = sounds.Pyro;

            if Pyro then
                Pyro.Volume = Pyro:GetAttribute("Volume") or 0.6;
                Pyro.TimePosition = 0;
                Pyro:Play();
            end;

            local CrowdSurge = sounds.CrowdSurge;

            if CrowdSurge then
                CrowdSurge.Volume = 0.6;
                CrowdSurge.TimePosition = 0;
                CrowdSurge:Play();
            end;

            local v341 = u235;
            v341.flash.BackgroundTransparency = 0.050000000000000044;
            TweenService:Create(v341.flash, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            u233.shake = 2.4;
            u233.shakeFor = 0.6;
            u233.shakeUntil = os.clock() + 0.6;
            burst(u234.pyro, 40);
            burst(u234.clash, 90);

            for _, v in { a, b } do
                v.dust.Rate = 0;
                v.dust:Emit(25);
            end;

            perform(a, "Catch", 0, 0.3);
            perform(b, "StepOver", 0, 0.3);
            u235.vs.Visible = true;
            u235.vsScale.Scale = 3.2;
            u235.vs.Rotation = -25;
            TweenService:Create(u235.vsScale, TweenInfo.new(0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            TweenService:Create(u235.vs, TweenInfo.new(0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Rotation = 0
            }):Play();
            u235.Left.BackgroundTransparency = 0;
            u235.Right.BackgroundTransparency = 0;
            u237.Contrast = 0.35;
            u237.Saturation = 0.4;
            TweenService:Create(u237, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Contrast = 0.12,
                Saturation = 0.12
            }):Play();
        end;

        if not u233.fired.vs and v329 >= 15.3 then
            u233.fired.vs = true;
            v342();
        end;

        local function v343() -- Line: 1506
            -- upvalues: u235 (ref), TweenService (ref)
            TweenService:Create(u235.vsScale, TweenInfo.new(0.28, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out), {
                Scale = 0
            }):Play();
            TweenService:Create(u235.Left, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            TweenService:Create(u235.Right, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end;

        if not u233.fired.vsOut and v329 >= 16.4 then
            u233.fired.vsOut = true;
            v343();
        end;

        local function v346() -- Line: 1511
            -- upvalues: sounds (ref), u235 (ref), TweenService (ref), a (ref), perform (ref), b (ref)
            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = 0.6;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            local CrowdCheer = sounds.CrowdCheer;

            if CrowdCheer then
                CrowdCheer.Volume = 0.45;
                CrowdCheer.TimePosition = 0;
                CrowdCheer:Play();
            end;

            local v344 = u235;
            v344.flash.BackgroundTransparency = 0.5;
            TweenService:Create(v344.flash, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            u235.vs.Visible = false;
            local v345 = a;

            if v345 then
                local Position = v345.model:GetPivot().Position;
                v345.model:PivotTo(CFrame.lookAt(Position, Position + Vector3.new(0.6, 0, 1)));
            end;

            perform(a, "Spike", 0.05);
            perform(b, "JuggleLoop", 0.1);
        end;

        if not u233.fired.spike and v329 >= 16.7 then
            u233.fired.spike = true;
            v346();
        end;

        local function _() -- Line: 1521
            -- upvalues: sounds (ref), u233 (ref), pop (ref), u235 (ref)
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.45;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            u233.shake = 1;
            u233.shakeFor = 0.3;
            u233.shakeUntil = os.clock() + 0.3;
            pop(u235.touchdown, 0.15);
        end;

        if not u233.fired.spikeHit and v329 >= 17.2 then
            u233.fired.spikeHit = true;
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.45;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            u233.shake = 1;
            u233.shakeFor = 0.3;
            u233.shakeUntil = os.clock() + 0.3;
            pop(u235.touchdown, 0.15);
        end;

        local function _() -- Line: 1526
            -- upvalues: fade (ref), u235 (ref)
            fade(u235.touchdown, 0.12);
        end;

        if not u233.fired.touchdownOut and v329 >= 17.48 then
            u233.fired.touchdownOut = true;
            fade(u235.touchdown, 0.12);
        end;

        local function v349() -- Line: 1529
            -- upvalues: sounds (ref), u235 (ref), TweenService (ref), b (ref), perform (ref), a (ref)
            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = 0.6;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            local v347 = u235;
            v347.flash.BackgroundTransparency = 0.5;
            TweenService:Create(v347.flash, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            local v348 = b;

            if v348 then
                local Position = v348.model:GetPivot().Position;
                v348.model:PivotTo(CFrame.lookAt(Position, Position + Vector3.new(-0.6, 0, 1)));
            end;

            local Kick = sounds.Kick;

            if Kick then
                Kick.Volume = 0.9;
                Kick.TimePosition = 0;
                Kick:Play();
            end;

            if b then
                b.ballOnFloor = true;
            end;

            perform(b, "Slide", 0.05);
            perform(a, "Idle", 0.2);
        end;

        if not u233.fired.goal and v329 >= 17.6 then
            u233.fired.goal = true;
            v349();
        end;

        local function _() -- Line: 1540
            -- upvalues: sounds (ref), u233 (ref), pop (ref), u235 (ref)
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.45;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            local Pyro = sounds.Pyro;

            if Pyro then
                Pyro.Volume = 0.5;
                Pyro.TimePosition = 0;
                Pyro:Play();
            end;

            u233.shake = 1;
            u233.shakeFor = 0.3;
            u233.shakeUntil = os.clock() + 0.3;
            pop(u235.golazo, 0.15);
        end;

        if not u233.fired.golazo and v329 >= 17.900000000000002 then
            u233.fired.golazo = true;
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.45;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            local Pyro = sounds.Pyro;

            if Pyro then
                Pyro.Volume = 0.5;
                Pyro.TimePosition = 0;
                Pyro:Play();
            end;

            u233.shake = 1;
            u233.shakeFor = 0.3;
            u233.shakeUntil = os.clock() + 0.3;
            pop(u235.golazo, 0.15);
        end;

        local function _() -- Line: 1546
            -- upvalues: fade (ref), u235 (ref)
            fade(u235.golazo, 0.12);
        end;

        if not u233.fired.golazoOut and v329 >= 18.38 then
            u233.fired.golazoOut = true;
            fade(u235.golazo, 0.12);
        end;

        local function _() -- Line: 1549
            -- upvalues: perform (ref), b (ref), burst (ref), u234 (ref)
            perform(b, "SlideLoop", 0.1);
            burst(u234.pyro, 25);
        end;

        if not u233.fired.goalLoop and v329 >= 18.32 then
            u233.fired.goalLoop = true;
            perform(b, "SlideLoop", 0.1);
            burst(u234.pyro, 25);
        end;

        local function v351() -- Line: 1553
            -- upvalues: sounds (ref), u235 (ref), TweenService (ref), a (ref), b (ref), perform (ref)
            local Whoosh = sounds.Whoosh;

            if Whoosh then
                Whoosh.Volume = 0.6;
                Whoosh.TimePosition = 0;
                Whoosh:Play();
            end;

            local v350 = u235;
            v350.flash.BackgroundTransparency = 0.55;
            TweenService:Create(v350.flash, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();

            for _, v in { a, b } do
                local Position = v.model:GetPivot().Position;
                v.model:PivotTo(CFrame.lookAt(Position, Position + Vector3.new(v.facing * 0.55, 0, 1)));
            end;

            perform(a, "Spike", 0.1);

            if b then
                b.ballOnFloor = nil;
            end;

            perform(b, "JuggleLoop", 0.1);
        end;

        if not u233.fired.finale and v329 >= 18.5 then
            u233.fired.finale = true;
            v351();
        end;

        if v329 >= 18.5 and (a and a.frozen.Spike) then
            if u233.respikeAt then
                if u233.respikeAt <= v329 then
                    u233.respikeAt = nil;
                    perform(a, "Spike", 0.1);
                end;
            else
                u233.respikeAt = v329 + 0.6;
            end;
        end;

        local function v352() -- Line: 1577
            -- upvalues: burst (ref), u234 (ref), sounds (ref), u235 (ref), TweenService (ref)
            burst(u234.fireworks, 70);
            burst(u234.pyro, 50);
            local Boom = sounds.Boom;

            if Boom then
                Boom.Volume = 0.5;
                Boom.TimePosition = 0;
                Boom:Play();
            end;

            u235.card.Visible = true;
            u235.cardScale.Scale = 1.5;
            TweenService:Create(u235.cardScale, TweenInfo.new(0.45, Enum.EasingStyle.Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end;

        if not u233.fired.card and v329 >= 18.6 then
            u233.fired.card = true;
            v352();
        end;

        local function _() -- Line: 1585
            -- upvalues: burst (ref), u234 (ref)
            burst(u234.fireworks, 50);
        end;

        if not u233.fired.fireworks2 and v329 >= 18.950000000000003 then
            u233.fired.fireworks2 = true;
            burst(u234.fireworks, 50);
        end;

        local function _() -- Line: 1588
            -- upvalues: burst (ref), u234 (ref)
            burst(u234.fireworks, 40);
        end;

        if not u233.fired.fireworks3 and v329 >= 19.25 then
            u233.fired.fireworks3 = true;
            burst(u234.fireworks, 40);
        end;

        local function v353() -- Line: 1591
            -- upvalues: sounds (ref), TweenService (ref)
            for _, v in sounds do
                if v.IsPlaying then
                    TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Volume = 0
                    }):Play();
                end;
            end;
        end;

        if not u233.fired.musicOut and v329 >= 22.7 then
            u233.fired.musicOut = true;
            v353();
        end;

        local function _() -- Line: 1598
            -- upvalues: u235 (ref), TweenService (ref)
            TweenService:Create(u235.black, TweenInfo.new(0.5, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out), {
                BackgroundTransparency = 0
            }):Play();
        end;

        if not u233.fired.fade and v329 >= 23.2 then
            u233.fired.fade = true;
            TweenService:Create(u235.black, TweenInfo.new(23.7 - u2.fade, Enum.EasingStyle.Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.In or Enum.EasingDirection.Out), {
                BackgroundTransparency = 0
            }):Play();
        end;

        if v329 >= 12.9 and v329 < 15.3 then
            for _, v in { a, b } do
                if v then
                    local v354 = -v.facing * 5.5;
                    local v355 = v.x + v.facing * 15 * v330 * v328;

                    if (v354 - v355) * v.facing >= 0 then
                        v354 = v355;
                    end;

                    place(v, v354);
                end;
            end;
        end;

        local v356 = u230.speed <= 0 and 0 or v330;
        tend(a, v356);
        tend(b, v356);

        for _, v in u234.sweeps do
            local v357 = v329 * 0.9 + v.phase;
            local tip = v.tip;
            local from = v.from;
            local v358 = math.sin(v357) * 140;
            local v359 = v.lean * (math.cos(v357 * 0.7) * 50 + 60);
            tip.WorldPosition = from + Vector3.new(v358, 320, v359);
        end;

        local v360, v361 = shot(v329);

        if os.clock() < u233.shakeUntil then
            local v362 = u233.shake * (u233.shakeUntil - os.clock()) / u233.shakeFor;
            local CFrame_Angles = CFrame.Angles;
            local v363 = (math.random() - 0.5) * v362;
            local math_rad_ret = math.rad(v363);
            local v364 = (math.random() - 0.5) * v362;
            local math_rad_ret2 = math.rad(v364);
            local v365 = (math.random() - 0.5) * v362 * 0.5;
            v360 = v360 * CFrame_Angles(math_rad_ret, math_rad_ret2, (math.rad(v365)));
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        workspace_CurrentCamera.CFrame = v360;
        workspace_CurrentCamera.FieldOfView = v361;
        local Position = v360.Position;
        local v366;

        if v329 < 10.8 then
            local v367 = a;

            if v367 then
                v366 = v367.model:GetPivot().Position;
            else
                v366 = CFrame_new_ret.Position + Vector3.new(-34, 3, 0);
            end;
        else
            local v368 = b;

            if v368 then
                v366 = v368.model:GetPivot().Position;
            else
                v366 = CFrame_new_ret.Position + Vector3.new(34, 3, 0);
            end;
        end;

        u238.FocusDistance = (Position - v366).Magnitude;
        local v369 = u235;
        local math_clamp_ret = math.clamp((v329 - 6.8 + 0.3) / 0.6, 0, 1);
        local math_clamp_ret2 = math.clamp((v329 - 23.2) / 0.5, 0, 1);
        local v370 = math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret) * (1 - math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2));
        v369.top.Position = UDim2.fromScale(0.5, 0.115 * v370);
        v369.bottom.Position = UDim2.fromScale(0.5, 1 - 0.115 * v370);
    end);
    table.insert(u233.connections, LocalPlayer.CharacterRemoving:Connect(cleanup));
    table.insert(u233.connections, RunService.PreSimulation:Connect(function() -- Line: 1636
        -- upvalues: pinBall (ref), b (copy)
        pinBall(b);
    end));
    local v371 = 0;

    while not u245 do
        task.wait(0.25);

        if u230.speed > 0 then
            v371 = v371 + 0.25;
        end;

        if v371 > 28.7 then
            cleanup();
        end;
    end;
end;

local function prepare() -- Line: 1653
    -- upvalues: SoundService (copy), u1 (copy), AnimationConfig (copy), u117 (copy), Weapons (copy), LocalPlayer (copy), avatar (copy), Players (copy), CharacterClone (copy), ChickenOrHero (copy)
    local v372 = {
        sounds = {},
        animations = {},
        templates = {}
    };
    local SoundGroup = Instance.new("SoundGroup");
    SoundGroup.Name = "EventIntroAmbience";
    SoundGroup.Volume = 1;
    SoundGroup.Parent = SoundService;
    v372.ambience = SoundGroup;
    v372.muffle = Instance.new("EqualizerSoundEffect");
    v372.muffle.Parent = SoundGroup;
    local v373 = {};

    for i, v in u1 do
        local Sound = Instance.new("Sound");
        Sound.Name = "EventIntro" .. i;
        Sound.SoundId = v[1];
        Sound:SetAttribute("Volume", v[2]);
        Sound.Volume = v[2];
        Sound.Looped = i == "Crowd";
        local v374;

        if v[3] then
            v374 = SoundGroup;
        else
            v374 = nil;
        end;

        Sound.SoundGroup = v374;
        Sound.Parent = SoundService;
        v372.sounds[i] = Sound;
        table.insert(v373, Sound);
    end;

    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("10_Football");
    end;

    for _, v in { "CrowdBed", "CrowdSurge", "CrowdCheer", "Whistle" } do
        local v375;

        if GameAudio then
            v375 = GameAudio:FindFirstChild(v);
        else
            v375 = GameAudio;
        end;

        if v375 and v375:IsA("Sound") then
            local v376 = v375:Clone();
            v376.Name = "EventIntro" .. v;
            v376.SoundGroup = nil;
            v376.Looped = v == "CrowdBed";
            v376:SetAttribute("Volume", v375.Volume);
            v376.Parent = SoundService;
            v372.sounds[v] = v376;
        end;
    end;

    local v377 = AnimationConfig.PublishedIds and AnimationConfig.PublishedIds.Idle;

    if v377 then
        local animations = v372.animations;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v377;
        animations.Idle = Animation;
        table.insert(v373, v372.animations.Idle);
    end;

    for i, v in u117 do
        local v378 = Weapons.Models:FindFirstChild(i);
        local v379 = i;

        for i2, v2 in v do
            local v380;

            if v378 then
                v380 = v378:GetAttribute(v2[1]);
            else
                v380 = v378;
            end;

            if type(v380) == "string" and v380 ~= "" then
                local animations = v372.animations;
                local Animation = Instance.new("Animation");
                Animation.AnimationId = v380;
                animations[v379 .. i2] = Animation;
                table.insert(v373, v372.animations[v379 .. i2]);
            end;
        end;
    end;

    local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid", 10);
    local v381 = os.clock() + 8;

    while not LocalPlayer:HasAppearanceLoaded() and os.clock() < v381 do
        task.wait(0.2);
    end;

    if Humanoid then
        Humanoid = avatar(Humanoid, 3);
    end;

    local v382 = {};
    local v383 = nil;

    for _, v in Players:GetPlayers() do
        local v384;

        if v == LocalPlayer then
            v384 = false;
        else
            v384 = v.Character and v.Character:FindFirstChildOfClass("Humanoid");
        end;

        if v384 then
            table.insert(v382, v384);
        end;
    end;

    if #v382 > 0 then
        local u385 = v382[math.random(1, #v382)];

        for i = 1, 1 do
            local v386;
            v386, v383 = pcall(function() -- Line: 574
                -- upvalues: u385 (copy), Players (ref)
                local AppliedDescription = u385:GetAppliedDescription();
                local v387 = Players:CreateHumanoidModelFromDescriptionAsync(AppliedDescription, Enum.HumanoidRigType.R6);
                AppliedDescription:Destroy();

                return v387;
            end);

            if v386 and CharacterClone.dressed(v383) then
                break;
            end;

            if v386 and v383 then
                v383:Destroy();
            end;

            local v388;

            if i < 1 and u385.Parent then
                task.wait(CharacterClone.RETRY_SECONDS);
                v388 = i;
            else
                v388 = i;
            end;
        end;

        v383 = nil;
    end;

    if not Humanoid then
        Humanoid = ChickenOrHero.Game:FindFirstChild("CrossyRoadChaserTemplate");

        if Humanoid then
            Humanoid = Humanoid:Clone();
        end;
    end;

    v372.templates.a = Humanoid;
    local templates = v372.templates;

    if v383 then
        Humanoid = v383;
    elseif Humanoid then
        Humanoid = Humanoid:Clone();
    end;

    templates.b = Humanoid;

    return v372;
end;

local function release(p389) -- Line: 1734
    for _, v in p389.sounds do
        v:Destroy();
    end;

    p389.ambience:Destroy();

    for _, v in p389.animations do
        v:Destroy();
    end;

    for _, v in p389.templates do
        v:Destroy();
    end;
end;

local u390 = nil;

if RunService:IsStudio() then
    local BindableFunction = Instance.new("BindableFunction");
    BindableFunction.Name = "EventIntroDebug";

    function BindableFunction.OnInvoke(p391, p392) -- Line: 1754
        -- upvalues: u230 (copy), u390 (ref), u229 (ref), play (copy)
        if p391 == "speed" and type(p392) == "number" then
            u230.speed = p392;
        elseif p391 == "seek" and type(p392) == "number" then
            u230.seek = p392;
        elseif p391 == "replay" and (u390 and not u229) then
            u230.speed = 1;
            task.spawn(play, u390, p392);
        end;

        return u229;
    end;

    BindableFunction.Parent = LocalPlayer;
end;

local u393 = {};
EventIntroRemote.OnClientEvent:Connect(function(...) -- Line: 1768
    -- upvalues: u393 (copy)
    table.insert(u393, table.pack(...));
end);

local function reply(p394, p395) -- Line: 1771
    -- upvalues: u393 (copy)
    local v396 = os.clock() + p395;

    while os.clock() < v396 do
        for i, v in u393 do
            if p394[v[1]] then
                table.remove(u393, i);

                return table.unpack(v, 1, v.n);
            end;
        end;

        task.wait(0.1);
    end;

    return nil;
end;

local function experienceEventLive() -- Line: 1787
    local SocialService = game:GetService("SocialService");
    local success, result = pcall(SocialService.GetExperienceEventAsync, SocialService, "6139363647861949201");

    if success and type(result) == "table" then
        local v397;

        if result.HasStarted == true then
            v397 = result.HasEnded ~= true;
        else
            v397 = false;
        end;

        return v397;
    end;

    warn("Event intro: couldn\'t read experience event " .. "6139363647861949201" .. ", so it won\'t play on its own: " .. tostring(result));

    return false;
end;

local function inLobby() -- Line: 1797
    -- upvalues: LocalPlayer (copy)
    local v398;

    if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and (LocalPlayer:GetAttribute("Spectating") ~= true and (LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true and (LocalPlayer:GetAttribute("MatchSummaryVisible") ~= true and (LocalPlayer:GetAttribute("AdminRefreshActive") ~= true and LocalPlayer:GetAttribute("AlbieTalking") ~= true))))) then
        v398 = (LocalPlayer:GetAttribute("GameRole") or "Lobby") == "Lobby";
    else
        v398 = false;
    end;

    return v398;
end;

local function root() -- Line: 1807
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    return Character;
end;

local Session = ChickenOrHero.Game:WaitForChild("Session");
local u399 = {
    Intermission = true,
    MapVote = true,
    Countdown = true
};

local function roundSoon() -- Line: 1814
    -- upvalues: u399 (copy), Session (copy)
    return u399[Session:GetAttribute("Phase")] == true;
end;

local function waitOutMatch() -- Line: 1818
    -- upvalues: LocalPlayer (copy), u399 (copy), Session (copy)
    local v400 = os.clock() + 1800;

    while LocalPlayer:GetAttribute("InMatch") ~= true and (u399[Session:GetAttribute("Phase")] == true and os.clock() < v400) do
        task.wait(0.5);
    end;

    while LocalPlayer:GetAttribute("InMatch") == true and os.clock() < v400 do
        task.wait(0.5);
    end;
end;

local function waitForMove() -- Line: 1828
    -- upvalues: inLobby (copy), LocalPlayer (copy)
    local v401, v402;
    local v403 = 0;

    while true do
        if v403 == 0 then
            v403 = -1;

            if inLobby() then
                v403 = 1;
                continue;
            end;

            v403 = 5;
            continue;
        elseif v403 == 1 then
            v403 = -1;
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character then
                v403 = 2;
                continue;
            end;

            task.wait(0.5);
            v403 = 4;
            continue;
        elseif v403 == 2 then
            v403 = -1;
            v401 = LocalPlayer.Character;

            if v401 then
                v401 = v401:FindFirstChild("HumanoidRootPart");
            end;

            v402 = v401.Position;
            v403 = 3;
            continue;
        elseif v403 == 3 then
            v403 = -1;
            local v404;

            if inLobby() then
                local Character = LocalPlayer.Character;

                if Character then
                    Character = Character:FindFirstChild("HumanoidRootPart");
                end;

                if Character == v401 and ((v401.Position - v402) * Vector3.new(1, 0, 1)).Magnitude < 3 then
                    v403 = 6;
                    continue;
                end;

                if inLobby() then
                    v404 = LocalPlayer.Character;

                    if v404 then
                        v404 = v404:FindFirstChild("HumanoidRootPart");
                    end;

                    if v404 == v401 then
                        task.wait(1.5);

                        if inLobby() then
                            return;
                        end;
                    end;
                end;
            elseif inLobby() then
                v404 = LocalPlayer.Character;

                if v404 then
                    v404 = v404:FindFirstChild("HumanoidRootPart");
                end;

                if v404 == v401 then
                    task.wait(1.5);

                    if inLobby() then
                        return;
                    end;
                end;
            end;

            v403 = 4;
            continue;
        elseif v403 == 4 then
            v403 = -1;
            v403 = 0;
            continue;
        elseif v403 == 5 then
            v403 = -1;
            task.wait(0.5);
            v403 = 0;
            continue;
        elseif v403 == 6 then
            v403 = -1;
            task.wait(0.2);
            v403 = 3;
            continue;
        else
            break;
        end;
    end;
end;

local u405 = false;
local u406 = nil;
local u407 = nil;

local function ready() -- Line: 1850
    -- upvalues: u406 (ref), u407 (ref), prepare (copy)
    if not (u406 or u407) then
        u407 = true;
        u406 = prepare();
    end;

    while not u406 do
        task.wait(0.1);
    end;

    return u406;
end;

local function show(p408) -- Line: 1862
    -- upvalues: u405 (ref), u229 (ref), ready (copy), EventIntroRemote (copy), reply (copy), LocalPlayer (copy), play (copy), RunService (copy), u390 (ref), release (copy)
    if u405 or u229 then
        return nil;
    end;

    local v409 = ready();

    if u405 or u229 then
        return nil;
    end;

    EventIntroRemote:FireServer("Ready", p408);
    local v410 = reply({
        Play = true,
        Later = true,
        Skip = true
    }, 15);

    if v410 ~= "Play" then
        if v410 == "Skip" and p408 == "signup" then
            u405 = true;
            LocalPlayer:SetAttribute("EventIntroUnseen", nil);
            release(v409);
        end;

        return v410;
    end;

    u405 = true;
    LocalPlayer:SetAttribute("EventIntroUnseen", nil);
    play(v409);
    EventIntroRemote:FireServer("Done");

    if RunService:IsStudio() then
        u390 = v409;

        return v410;
    end;

    release(v409);

    return v410;
end;

task.spawn(function() -- Line: 1890
    -- upvalues: LocalPlayer (copy), TeamEventConfig (copy), EventIntroRemote (copy), experienceEventLive (copy), reply (copy), show (copy), inLobby (copy), HudNavigation (copy), u405 (ref), ready (copy), waitForMove (copy), u399 (copy), Session (copy), waitOutMatch (copy)
    while LocalPlayer:GetAttribute("ClientReady") ~= true do
        LocalPlayer:GetAttributeChangedSignal("ClientReady"):Wait();
    end;

    local _, v411 = TeamEventConfig.window();

    if workspace:GetServerTimeNow() >= (v411 or TeamEventConfig.EndsAt) - 86400 then
        return;
    end;

    EventIntroRemote:FireServer("Check", (experienceEventLive()));
    local _, v412, v413 = reply({
        Needed = true
    }, 40);

    if v413 ~= true then
        return;
    end;

    LocalPlayer:SetAttribute("EventIntroUnseen", true);
    local u414 = nil;
    u414 = LocalPlayer:GetAttributeChangedSignal("EventIntroRequested"):Connect(function() -- Line: 1909
        -- upvalues: show (ref), inLobby (ref), HudNavigation (ref), u405 (ref), u414 (ref)
        task.spawn(function() -- Line: 1910
            -- upvalues: show (ref), inLobby (ref), HudNavigation (ref), u405 (ref), u414 (ref)
            if show("signup") == "Play" then
                task.wait(0.8);

                if inLobby() then
                    HudNavigation.activate("FootballEvent");
                end;
            end;

            if u405 and u414 then
                u414:Disconnect();
                u414 = nil;
            end;
        end);
    end);

    if v412 ~= true then
        return;
    end;

    ready();
    waitForMove();
    local v415 = false;

    while not u405 do
        if not v415 and u399[Session:GetAttribute("Phase")] == true then
            LocalPlayer:SetAttribute("EventIntroSkipsRecap", true);

            while u399[Session:GetAttribute("Phase")] == true and LocalPlayer:GetAttribute("InMatch") ~= true do
                task.wait(0.5);
            end;

            if LocalPlayer:GetAttribute("InMatch") == true then
                waitOutMatch();
                v415 = true;
            else
                LocalPlayer:SetAttribute("EventIntroSkipsRecap", nil);
            end;
        end;

        while not inLobby() do
            task.wait(0.25);
        end;

        if u405 then
            break;
        end;

        if v415 or u399[Session:GetAttribute("Phase")] ~= true then
            local v416 = show("auto");

            if v416 == "Play" then
                if v415 then
                    local v417 = os.clock() + 60;

                    while Session:GetAttribute("Phase") == "Intermission" and os.clock() < v417 do
                        task.wait(0.5);
                    end;
                end;

                LocalPlayer:SetAttribute("EventIntroSkipsRecap", nil);
                task.wait(0.8);

                if inLobby() and u399[Session:GetAttribute("Phase")] ~= true then
                    HudNavigation.activate("FootballEvent");
                end;

                break;
            end;

            if v416 ~= "Later" then
                break;
            end;

            LocalPlayer:SetAttribute("EventIntroSkipsRecap", true);
            waitOutMatch();
            task.wait(2);
            v415 = true;
        else
            task.wait(0.5);
        end;
    end;

    LocalPlayer:SetAttribute("EventIntroSkipsRecap", nil);
end);