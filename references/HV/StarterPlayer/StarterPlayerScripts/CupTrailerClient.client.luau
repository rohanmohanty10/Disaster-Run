 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
local ContentProvider = game:GetService("ContentProvider");

if game.PlaceId ~= 130574217370467 then
    return;
end;

local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local CreatorVisibility = require(Presentation:WaitForChild("CreatorVisibility"));
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local KnifeDisplayRig = require(Weapons:WaitForChild("KnifeDisplayRig"));
local KnifeVisibility = require(Weapons:WaitForChild("KnifeVisibility"));
local AnimationConfig = require(ChickenOrHero:WaitForChild("Animation"):WaitForChild("AnimationConfig"));
local EmoteCatalog = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local CharacterClone = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("CharacterClone"));
local CFrame_new_ret = CFrame.new(2400, 3000, 0);
local u1 = { 1544858, 11551976004, 2352633109, 3983340648, 3255222 };
local u2 = { "Moonfang", "StormTalon", "Bloodthorn", "VenomThorn", "IronFang", "Vowbreaker" };
local u3 = { "Floss", "DaBabyDance", "Laugh" };
local CFrame_new_ret2 = CFrame.new(0, -1.3, -0.6);
local Color3_fromRGB_ret = Color3.fromRGB(238, 242, 248);
local Color3_fromRGB_ret2 = Color3.fromRGB(226, 65, 47);
local Color3_fromRGB_ret3 = Color3.fromRGB(69, 211, 255);
local Color3_fromRGB_ret4 = Color3.fromRGB(242, 193, 78);
local Color3_fromRGB_ret5 = Color3.fromRGB(240, 196, 155);
local Color3_fromRGB_ret6 = Color3.fromRGB(16, 16, 24);
local Color3_new_ret = Color3.new(0, 0, 0);
local Color3_fromRGB_ret7 = Color3.fromRGB(201, 164, 106);
local u4 = { "e2412f", "3f7fd8", "f2c14e", "46b07a", "d8d8e2", "8a4fd0", "ff8a3d", "2b2f3d" };
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold);
local u5 = {
    Crowd = { "rbxassetid://9120974125", 0.45, true },
    Heart = { "rbxassetid://1839088414", 0.9 },
    Music = { "rbxassetid://1837460585", 0.55 },
    Goofy = { "rbxassetid://1845474339", 0.5 },
    Zip = { "rbxassetid://9120718689", 0.8, false, 1.35 },
    Stab = { "rbxassetid://9125484526", 0.4 },
    Hum = { "rbxassetid://9125566994", 0.45 },
    Clang = { "rbxassetid://9119072660", 0.9 },
    Shatter = { "rbxassetid://9114590297", 0.6 },
    Swish = { "rbxassetid://111254855668531", 0.6 },
    Hit = { "rbxassetid://9113570289", 0.9 },
    Caught = { "rbxassetid://17208353912", 0.6 },
    Gasp = { "rbxassetid://9120974378", 0.6 },
    Laugh = { "rbxassetid://9114011902", 0.7 },
    Rope = { "rbxassetid://9120718689", 0.8, false, 0.7 },
    Whoosh = { "rbxassetid://9120718689", 0.9, false, 0.55 },
    Drone = { "rbxassetid://9112795571", 0.6 },
    Boom = { "rbxassetid://9125484526", 1 },
    Sting = { "rbxassetid://9125484526", 0.8, false, 0.8 }
};
local u6 = { { 0, "Crowd", 24.4 }, { 0.3, "Heart", 2.2 }, { 3, "Music", 12.5 }, { 3, "Stab" }, { 3.95, "Zip" }, { 5, "Stab" }, { 5.95, "Zip" }, { 5.98, "Stab" }, { 7, "Stab" }, { 7.6, "Hum", 9.5 }, { 8.65, "Clang" }, { 9.46, "Shatter" }, { 10, "Stab" }, { 11.1, "Zip" }, { 12.1, "Zip" }, { 12.5, "Swish" }, { 13.88, "Hit" }, { 13.88, "Caught" }, { 13.9, "Gasp" }, { 14.65, "Swish" }, { 15, "Goofy", 18.6 }, { 15.6, "Laugh" }, { 17.55, "Rope" }, { 18.6, "Hit" }, { 19.5, "Whoosh" }, { 20.5, "Drone", 24.4 }, { 21.3, "Heart", 23.4 }, { 24.38, "Boom" }, { 26.8, "Sting" } };

local function clamp01(p7) -- Line: 119
    return math.clamp(p7, 0, 1);
end;

local function lerp(p8, p9, p10) -- Line: 122
    return p8 + (p9 - p8) * p10;
end;

local function ease(p11) -- Line: 125
    return 1 - (1 - math.clamp(p11, 0, 1)) ^ 3;
end;

local function easeIn(p12) -- Line: 129
    local math_clamp_ret = math.clamp(p12, 0, 1);

    return math_clamp_ret * math_clamp_ret;
end;

local function easeIO(p13) -- Line: 133
    local math_clamp_ret = math.clamp(p13, 0, 1);

    if math_clamp_ret < 0.5 then
        return 4 * math_clamp_ret ^ 3;
    end;

    return 1 - (-2 * math_clamp_ret + 2) ^ 3 / 2;
end;

local function seg(p14, p15, p16) -- Line: 137
    return math.clamp((p14 - p15) / (p16 - p15), 0, 1);
end;

local function bell(p17, p18, p19, p20) -- Line: 140
    if p17 < p19 then
        return math.clamp((p17 - p18) / (p19 - p18), 0, 1);
    end;

    return 1 - math.clamp((p17 - p19) / (p20 - p19), 0, 1);
end;

local function rnd(p21, p22) -- Line: 143
    local v23 = math.sin(p21 * 127.1 + (p22 or 0) * 311.7) * 43758.5453;

    return v23 - math.floor(v23);
end;

local function at(p24, p25, p26) -- Line: 148
    -- upvalues: CFrame_new_ret (copy)
    return CFrame_new_ret.Position + Vector3.new(p24, p25, -p26);
end;

local function A(p27, p28, p29) -- Line: 152
    -- upvalues: CFrame_new_ret (copy)
    return CFrame_new_ret.Position + Vector3.new(p27 * 2.8, p28 * 2.8, -((p29 - 12) * 2.8));
end;

local function pov(p30, p31, p32, p33, p34, p35, p36) -- Line: 157
    -- upvalues: CFrame_new_ret (copy)
    return CFrame.new(CFrame_new_ret.Position + Vector3.new(p30 * 2.8, p31 * 2.8, -((p32 - 12) * 2.8))) * CFrame.Angles(0, (p36 or 0) + math.atan((p33 or 0) / 620), 0) * CFrame.Angles(math.atan((p34 or 0) / 620), 0, 0) * CFrame.Angles(0, 0, p35 or 0);
end;

local function block(p37, p38, p39, p40, p41, p42) -- Line: 165
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = p38;
    Part.CFrame = p39;
    Part.Color = p40;
    Part.Material = p41 or Enum.Material.SmoothPlastic;
    Part.TopSurface = Enum.SurfaceType.Smooth;
    Part.BottomSurface = Enum.SurfaceType.Smooth;

    if p42 then
        for i, v in p42 do
            Part[i] = v;
        end;
    end;

    Part.Parent = p37;

    return Part;
end;

local function box(p43, p44, p45, p46, p47, p48, p49, p50, p51, p52) -- Line: 186
    -- upvalues: block (copy), CFrame_new_ret (copy)
    return block(p43, Vector3.new(p44, p45, p46), CFrame.new(CFrame_new_ret.Position + Vector3.new(p47, p48, -p49)), p50, p51, p52);
end;

local function surface(p53, p54, p55) -- Line: 190
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Face = p54;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = p55 or 20;
    SurfaceGui.LightInfluence = 0.6;
    SurfaceGui:SetAttribute("CreatorCaptureExempt", true);
    SurfaceGui.Parent = p53;

    return SurfaceGui;
end;

local function paint(p56, p57, p58, p59) -- Line: 200
    -- upvalues: Font_new_ret2 (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.Text = p57;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = p58;
    TextLabel.FontFace = p59 or Font_new_ret2;
    TextLabel.AutoLocalize = false;
    TextLabel.Parent = p56;

    return TextLabel;
end;

local function ring(p60, p61, p62, p63, p64) -- Line: 213
    -- upvalues: block (copy), CFrame_new_ret (copy)
    local table_create_ret = table.create(p61);

    for i = 1, p61 do
        table_create_ret[i] = block(p60, Vector3.new(1, p63, p63), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -200, -0)), p62, p64, {
            Shape = Enum.PartType.Cylinder
        });
        local _ = i;
    end;

    return table_create_ret;
end;

local function placeRing(p65, p66, p67) -- Line: 220
    local v68 = #p65;
    local v69 = p67 / 2;
    local v70 = 6.283185307179586 * v69 / v68 * 1.1;
    local table_create_ret = table.create(v68);

    for i, v in p65 do
        local v71 = (i - 0.5) / v68 * 3.141592653589793 * 2;

        if math.abs(v.Size.X - v70) > 0.01 then
            v.Size = Vector3.new(v70, v.Size.Y, v.Size.Z);
        end;

        local CFrame_fromMatrix = CFrame.fromMatrix;
        local v72 = math.cos(v71) * v69;
        local v73 = math.sin(v71) * v69;
        local Vector3_new_ret = Vector3.new(0, v72, v73);
        local v74 = -math.sin(v71);
        local math_cos_ret = math.cos(v71);
        table_create_ret[i] = p66 * CFrame_fromMatrix(Vector3_new_ret, Vector3.new(0, v74, math_cos_ret), Vector3.new(1, 0, 0));
    end;

    workspace:BulkMoveTo(p65, table_create_ret, Enum.BulkMoveMode.FireCFrameChanged);
end;

local function buildGym(u75) -- Line: 238
    -- upvalues: CFrame_new_ret (copy), block (copy), Color3_fromRGB_ret4 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), placeRing (copy), ring (copy), u4 (copy), Color3_fromRGB_ret5 (copy)
    local Color3_fromRGB_ret8 = Color3.fromRGB(201, 138, 75);
    local WoodPlanks = Enum.Material.WoodPlanks;
    local CFrame_new_ret3 = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -0.5, -0));
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = Vector3.new(67.2, 1, 112);
    Part.CFrame = CFrame_new_ret3;
    Part.Color = Color3_fromRGB_ret8;
    Part.Material = WoodPlanks or Enum.Material.SmoothPlastic;
    Part.TopSurface = Enum.SurfaceType.Smooth;
    Part.BottomSurface = Enum.SurfaceType.Smooth;
    Part.Parent = u75;
    local Color3_fromRGB_ret9 = Color3.fromRGB(245, 244, 238);

    local function stripe(p76, p77, p78, p79) -- Line: 242
        -- upvalues: u75 (copy), Color3_fromRGB_ret9 (copy), CFrame_new_ret (ref)
        local Vector3_new_ret = Vector3.new(p76, 0.05, p77);
        local CFrame_new_ret4 = CFrame.new(CFrame_new_ret.Position + Vector3.new(p78, 0.03, -p79));
        local Part2 = Instance.new("Part");
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CanTouch = false;
        Part2.CastShadow = false;
        Part2.Size = Vector3_new_ret;
        Part2.CFrame = CFrame_new_ret4;
        Part2.Color = Color3_fromRGB_ret9;
        Part2.Material = Enum.Material.SmoothPlastic;
        Part2.TopSurface = Enum.SurfaceType.Smooth;
        Part2.BottomSurface = Enum.SurfaceType.Smooth;
        Part2.Parent = u75;
    end;

    local CFrame_new_ret4 = CFrame.new(CFrame_new_ret.Position + Vector3.new(-25.2, 0.03, -0));
    local Part2 = Instance.new("Part");
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;
    Part2.Size = Vector3.new(0.3, 0.05, 86.8);
    Part2.CFrame = CFrame_new_ret4;
    Part2.Color = Color3_fromRGB_ret9;
    Part2.Material = Enum.Material.SmoothPlastic;
    Part2.TopSurface = Enum.SurfaceType.Smooth;
    Part2.BottomSurface = Enum.SurfaceType.Smooth;
    Part2.Parent = u75;
    local CFrame_new_ret5 = CFrame.new(CFrame_new_ret.Position + Vector3.new(25.2, 0.03, -0));
    local Part3 = Instance.new("Part");
    Part3.Anchored = true;
    Part3.CanCollide = false;
    Part3.CanQuery = false;
    Part3.CanTouch = false;
    Part3.CastShadow = false;
    Part3.Size = Vector3.new(0.3, 0.05, 86.8);
    Part3.CFrame = CFrame_new_ret5;
    Part3.Color = Color3_fromRGB_ret9;
    Part3.Material = Enum.Material.SmoothPlastic;
    Part3.TopSurface = Enum.SurfaceType.Smooth;
    Part3.BottomSurface = Enum.SurfaceType.Smooth;
    Part3.Parent = u75;
    local CFrame_new_ret6 = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 0.03, 43.4));
    local Part4 = Instance.new("Part");
    Part4.Anchored = true;
    Part4.CanCollide = false;
    Part4.CanQuery = false;
    Part4.CanTouch = false;
    Part4.CastShadow = false;
    Part4.Size = Vector3.new(50.7, 0.05, 0.3);
    Part4.CFrame = CFrame_new_ret6;
    Part4.Color = Color3_fromRGB_ret9;
    Part4.Material = Enum.Material.SmoothPlastic;
    Part4.TopSurface = Enum.SurfaceType.Smooth;
    Part4.BottomSurface = Enum.SurfaceType.Smooth;
    Part4.Parent = u75;
    local CFrame_new_ret7 = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 0.03, -43.4));
    local Part5 = Instance.new("Part");
    Part5.Anchored = true;
    Part5.CanCollide = false;
    Part5.CanQuery = false;
    Part5.CanTouch = false;
    Part5.CastShadow = false;
    Part5.Size = Vector3.new(50.7, 0.05, 0.3);
    Part5.CFrame = CFrame_new_ret7;
    Part5.Color = Color3_fromRGB_ret9;
    Part5.Material = Enum.Material.SmoothPlastic;
    Part5.TopSurface = Enum.SurfaceType.Smooth;
    Part5.BottomSurface = Enum.SurfaceType.Smooth;
    Part5.Parent = u75;
    local CFrame_new_ret8 = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 0.03, -0));
    local Part6 = Instance.new("Part");
    Part6.Anchored = true;
    Part6.CanCollide = false;
    Part6.CanQuery = false;
    Part6.CanTouch = false;
    Part6.CastShadow = false;
    Part6.Size = Vector3.new(50.7, 0.05, 0.3);
    Part6.CFrame = CFrame_new_ret8;
    Part6.Color = Color3_fromRGB_ret9;
    Part6.Material = Enum.Material.SmoothPlastic;
    Part6.TopSurface = Enum.SurfaceType.Smooth;
    Part6.BottomSurface = Enum.SurfaceType.Smooth;
    Part6.Parent = u75;
    local v80 = {
        crowd = {},
        parts = {},
        rests = {}
    };

    for _, v in { -1, 1 } do
        local Color3_fromRGB_ret10 = Color3.fromRGB(170, 58, 40);
        block(u75, Vector3.new(14, 0.04, 16.8), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 0.02, -(v * 35))), Color3_fromRGB_ret10, nil, {
            Transparency = 0.45
        });
        local CFrame_new_ret9 = CFrame.new(CFrame_new_ret.Position + Vector3.new(-7, 0.03, -(v * 35)));
        local Part7 = Instance.new("Part");
        Part7.Anchored = true;
        Part7.CanCollide = false;
        Part7.CanQuery = false;
        Part7.CanTouch = false;
        Part7.CastShadow = false;
        Part7.Size = Vector3.new(0.3, 0.05, 16.8);
        Part7.CFrame = CFrame_new_ret9;
        Part7.Color = Color3_fromRGB_ret9;
        Part7.Material = Enum.Material.SmoothPlastic;
        Part7.TopSurface = Enum.SurfaceType.Smooth;
        Part7.BottomSurface = Enum.SurfaceType.Smooth;
        Part7.Parent = u75;
        local CFrame_new_ret10 = CFrame.new(CFrame_new_ret.Position + Vector3.new(7, 0.03, -(v * 35)));
        local Part8 = Instance.new("Part");
        Part8.Anchored = true;
        Part8.CanCollide = false;
        Part8.CanQuery = false;
        Part8.CanTouch = false;
        Part8.CastShadow = false;
        Part8.Size = Vector3.new(0.3, 0.05, 16.8);
        Part8.CFrame = CFrame_new_ret10;
        Part8.Color = Color3_fromRGB_ret9;
        Part8.Material = Enum.Material.SmoothPlastic;
        Part8.TopSurface = Enum.SurfaceType.Smooth;
        Part8.BottomSurface = Enum.SurfaceType.Smooth;
        Part8.Parent = u75;
        local CFrame_new_ret11 = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 0.03, -(v * 26.6)));
        local Part9 = Instance.new("Part");
        Part9.Anchored = true;
        Part9.CanCollide = false;
        Part9.CanQuery = false;
        Part9.CanTouch = false;
        Part9.CastShadow = false;
        Part9.Size = Vector3.new(14.3, 0.05, 0.3);
        Part9.CFrame = CFrame_new_ret11;
        Part9.Color = Color3_fromRGB_ret9;
        Part9.Material = Enum.Material.SmoothPlastic;
        Part9.TopSurface = Enum.SurfaceType.Smooth;
        Part9.BottomSurface = Enum.SurfaceType.Smooth;
        Part9.Parent = u75;
    end;

    for i = 0, 27 do
        local v81 = i / 28 * 3.141592653589793 * 2;
        local CFrame_new = CFrame.new;
        local v82 = math.cos(v81) * 6.2;
        local v83 = math.sin(v81) * 6.2;
        local v84 = CFrame_new(CFrame_new_ret.Position + Vector3.new(v82, 0.03, -v83)) * CFrame.Angles(0, v81 + 1.5707963267948966, 0);
        local Part7 = Instance.new("Part");
        Part7.Anchored = true;
        Part7.CanCollide = false;
        Part7.CanQuery = false;
        Part7.CanTouch = false;
        Part7.CastShadow = false;
        Part7.Size = Vector3.new(1.45, 0.05, 0.3);
        Part7.CFrame = v84;
        Part7.Color = Color3_fromRGB_ret9;
        Part7.Material = Enum.Material.SmoothPlastic;
        Part7.TopSurface = Enum.SurfaceType.Smooth;
        Part7.BottomSurface = Enum.SurfaceType.Smooth;
        Part7.Parent = u75;
        local _ = i;
    end;

    local v85 = block(u75, Vector3.new(11, 0.04, 11), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 0.02, -0)), Color3_fromRGB_ret9, nil, {
        Transparency = 1
    });
    local Top = Enum.NormalId.Top;
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Face = Top;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = 30;
    SurfaceGui.LightInfluence = 0.6;
    SurfaceGui:SetAttribute("CreatorCaptureExempt", true);
    SurfaceGui.Parent = v85;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.Text = "HV";
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3_fromRGB_ret4;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.AutoLocalize = false;
    TextLabel.Parent = SurfaceGui;
    task.wait();

    for _, v in { -1, 1 } do
        local v86;

        if v < 0 then
            v86 = Color3.fromRGB(210, 195, 165);
        else
            v86 = Color3.fromRGB(203, 187, 156);
        end;

        local CFrame_new_ret9 = CFrame.new(CFrame_new_ret.Position + Vector3.new(v * 34.1, 12.6, -0));
        local Part7 = Instance.new("Part");
        Part7.Anchored = true;
        Part7.CanCollide = false;
        Part7.CanQuery = false;
        Part7.CanTouch = false;
        Part7.CastShadow = false;
        Part7.Size = Vector3.new(1, 25.2, 112);
        Part7.CFrame = CFrame_new_ret9;
        Part7.Color = v86;
        Part7.Material = Enum.Material.SmoothPlastic;
        Part7.TopSurface = Enum.SurfaceType.Smooth;
        Part7.BottomSurface = Enum.SurfaceType.Smooth;
        Part7.Parent = u75;
        local Color3_fromRGB_ret10, v87, v88 = Color3.fromRGB(40, 94, 90);
        block(u75, Vector3.new(0.2, 3.9, 112), CFrame.new(CFrame_new_ret.Position + Vector3.new(v * 33.55, 1.95, -0)), Color3_fromRGB_ret10, v87, v88);
        local Color3_fromRGB_ret11, v89, v90 = Color3.fromRGB(230, 216, 188);
        block(u75, Vector3.new(67.2, 25.2, 1), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 12.6, -(v * 56.5))), Color3_fromRGB_ret11, v89, v90);
        local Color3_fromRGB_ret12, v91, v92 = Color3.fromRGB(46, 107, 103);
        block(u75, Vector3.new(67.2, 3.9, 0.2), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 1.95, -(v * 55.95))), Color3_fromRGB_ret12, v91, v92);
        local v93 = v;

        for _, v2 in { -36, -18, 0, 18, 36 } do
            local Color3_fromRGB_ret13, v94, v95 = Color3.fromRGB(169, 220, 239);
            block(u75, Vector3.new(0.2, 5.6, 9.8), CFrame.new(CFrame_new_ret.Position + Vector3.new(v93 * 33.5, 19.6, -v2)), Color3_fromRGB_ret13, v94, v95);
        end;
    end;

    local Color3_fromRGB_ret10, v96, v97 = Color3.fromRGB(39, 43, 54);
    block(u75, Vector3.new(67.2, 1, 112), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 25.7, -0)), Color3_fromRGB_ret10, v96, v97);

    for i = -50.4, 50.4, 11.2 do
        local Color3_fromRGB_ret11, v98, v99 = Color3.fromRGB(59, 64, 79);
        block(u75, Vector3.new(67.2, 1.2, 0.8), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 24.6, -i)), Color3_fromRGB_ret11, v98, v99);
        local _ = i;
    end;

    for _, v in { -46.2, -30.8, -15.4, 0, 15.4, 30.8, 46.2 } do
        local v100 = v;

        for _, v2 in { -16.8, 0, 16.8 } do
            local Color3_fromRGB_ret11 = Color3.fromRGB(255, 246, 216);
            local Neon = Enum.Material.Neon;
            local CFrame_new_ret9 = CFrame.new(CFrame_new_ret.Position + Vector3.new(v2, 24.1, -v100));
            local Part7 = Instance.new("Part");
            Part7.Anchored = true;
            Part7.CanCollide = false;
            Part7.CanQuery = false;
            Part7.CanTouch = false;
            Part7.CastShadow = false;
            Part7.Size = Vector3.new(4.5, 0.3, 1.7);
            Part7.CFrame = CFrame_new_ret9;
            Part7.Color = Color3_fromRGB_ret11;
            Part7.Material = Neon or Enum.Material.SmoothPlastic;
            Part7.TopSurface = Enum.SurfaceType.Smooth;
            Part7.BottomSurface = Enum.SurfaceType.Smooth;
            Part7.Parent = u75;
        end;
    end;

    for _, v in { -1, 1 } do
        local v101;

        if v > 0 then
            v101 = Enum.NormalId.Back;
        else
            v101 = Enum.NormalId.Front;
        end;

        local v102 = v;

        for _, v2 in {
            { -26.6, Color3_fromRGB_ret2 },
            { -18.2, Color3_fromRGB_ret4 },
            { 18.2, Color3_fromRGB_ret3 },
            { 26.6, Color3_fromRGB_ret2 }
        } do
            local v103 = v2[2];
            local CFrame_new_ret9 = CFrame.new(CFrame_new_ret.Position + Vector3.new(v2[1], 20.4, -(v102 * 55.8)));
            local Part7 = Instance.new("Part");
            Part7.Anchored = true;
            Part7.CanCollide = false;
            Part7.CanQuery = false;
            Part7.CanTouch = false;
            Part7.CastShadow = false;
            Part7.Size = Vector3.new(3.4, 4.2, 0.2);
            Part7.CFrame = CFrame_new_ret9;
            Part7.Color = v103;
            Part7.Material = Enum.Material.SmoothPlastic;
            Part7.TopSurface = Enum.SurfaceType.Smooth;
            Part7.BottomSurface = Enum.SurfaceType.Smooth;
            Part7.Parent = u75;
            local v104 = CFrame.new(CFrame_new_ret.Position + Vector3.new(v2[1], 18.3, -(v102 * 55.8))) * CFrame.Angles(0, 0, 0.7853981633974483);
            local v105 = v2[2];
            local Part8 = Instance.new("Part");
            Part8.Anchored = true;
            Part8.CanCollide = false;
            Part8.CanQuery = false;
            Part8.CanTouch = false;
            Part8.CastShadow = false;
            Part8.Size = Vector3.new(2.4, 2.4, 0.2);
            Part8.CFrame = v104;
            Part8.Color = v105;
            Part8.Material = Enum.Material.SmoothPlastic;
            Part8.TopSurface = Enum.SurfaceType.Smooth;
            Part8.BottomSurface = Enum.SurfaceType.Smooth;
            Part8.Parent = u75;
        end;

        local Color3_fromRGB_ret11, v106, v107 = Color3.fromRGB(123, 22, 34);
        local v108 = block(u75, Vector3.new(17.9, 4.8, 0.3), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 19.2, -(v102 * 55.7))), Color3_fromRGB_ret11, v106, v107);
        local SurfaceGui2 = Instance.new("SurfaceGui");
        SurfaceGui2.Face = v101;
        SurfaceGui2.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
        SurfaceGui2.PixelsPerStud = 24;
        SurfaceGui2.LightInfluence = 0.6;
        SurfaceGui2:SetAttribute("CreatorCaptureExempt", true);
        SurfaceGui2.Parent = v108;
        local Frame = Instance.new("Frame");
        Frame.BackgroundTransparency = 1;
        Frame.Size = UDim2.fromScale(1, 1);
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3_fromRGB_ret4;
        UIStroke.Thickness = 6;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = Frame;
        Frame.Parent = SurfaceGui2;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.Size = UDim2.fromScale(1, 1);
        TextLabel2.Text = v102 > 0 and "VALLEY RUN" or "VALLEY RUN CUP";
        TextLabel2.TextScaled = true;
        TextLabel2.TextColor3 = Color3_fromRGB_ret4;
        TextLabel2.FontFace = Font_new_ret2;
        TextLabel2.AutoLocalize = false;
        TextLabel2.Parent = SurfaceGui2;
        local Color3_fromRGB_ret12, v109, v110 = Color3.fromRGB(244, 244, 244);
        local v111 = block(u75, Vector3.new(5, 3.1, 0.25), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 9.65, -(v102 * 40))), Color3_fromRGB_ret12, v109, v110);
        local Frame2 = Instance.new("Frame");
        Frame2.AnchorPoint = Vector2.new(0.5, 1);
        Frame2.Position = UDim2.fromScale(0.5, 0.86);
        Frame2.Size = UDim2.fromScale(0.34, 0.42);
        Frame2.BackgroundTransparency = 1;
        local UIStroke2 = Instance.new("UIStroke");
        UIStroke2.Color = Color3.fromRGB(208, 58, 42);
        UIStroke2.Thickness = 5;
        UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke2.Parent = Frame2;
        local SurfaceGui3 = Instance.new("SurfaceGui");
        SurfaceGui3.Face = v101;
        SurfaceGui3.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
        SurfaceGui3.PixelsPerStud = 24;
        SurfaceGui3.LightInfluence = 0.6;
        SurfaceGui3:SetAttribute("CreatorCaptureExempt", true);
        SurfaceGui3.Parent = v111;
        Frame2.Parent = SurfaceGui3;
        placeRing(ring(u75, 16, Color3.fromRGB(255, 106, 31), 0.16), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 8.5, -(v102 * 38.4))) * CFrame.Angles(0, 0, 1.5707963267948966), 2.6);
        local Color3_fromRGB_ret13, v112, v113 = Color3.fromRGB(52, 56, 66);
        block(u75, Vector3.new(0.5, 13.8, 0.5), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, 18.1, -(v102 * 40.4))), Color3_fromRGB_ret13, v112, v113);
    end;

    task.wait();

    for _, v in { -1, 1 } do
        local v114 = v;

        for i = 0, 5 do
            local v115 = v114 * (i * 1.18 + 26.3 + 0.59);
            local v116 = (i + 1) * 1.18;
            local Color3_fromRGB_ret11, v117, v118 = Color3.fromRGB(110, 74, 42);
            block(u75, Vector3.new(1.18, v116, 84), CFrame.new(CFrame_new_ret.Position + Vector3.new(v115, v116 / 2, -0)), Color3_fromRGB_ret11, v117, v118);
            local Color3_fromRGB_ret12, v119, v120 = Color3.fromRGB(164, 115, 63);
            block(u75, Vector3.new(1.2, 0.2, 84), CFrame.new(CFrame_new_ret.Position + Vector3.new(v115, v116 + 0.1, -0)), Color3_fromRGB_ret12, v119, v120);
            local v121 = i;

            for i2 = -40, 40, 4.2 do
                local v122 = math.sin((v121 * 31 + i2 + v114 * 7) * 127.1 + 0) * 43758.5453;
                local v123;

                if v122 - math.floor(v122) >= 0.18 then
                    local v124 = math.sin(i2 * 127.1 + (v121 or 0) * 311.7) * 43758.5453;
                    local v125 = i2 + (v124 - math.floor(v124)) * 0.8;
                    local v126 = CFrame_new_ret.Position + Vector3.new(v115, v116 + 0.2, -v125);
                    local CFrame_lookAt_ret = CFrame.lookAt(v126, v126 + Vector3.new(-v114, 0, 0));
                    local Color3_fromHex = Color3.fromHex;
                    local v127 = math.sin(i2 * 7 * 127.1 + (v121 + v114 or 0) * 311.7) * 43758.5453;
                    local v128 = (v127 - math.floor(v127)) * #u4;
                    local v129 = Color3_fromHex(u4[math.floor(v128) + 1]);
                    local v130 = {
                        base = CFrame_lookAt_ret
                    };
                    local v131 = math.sin(v121 * 127.1 + (i2 or 0) * 311.7) * 43758.5453;
                    v130.phase = (v131 - math.floor(v131)) * 6;
                    v130.parts = {};
                    v123 = i2;

                    for i3, v2 in {
                        { Vector3.new(1.6, 1.8, 0.9), CFrame.new(0, 0.9, 0), v129 },
                        { Vector3.new(1.05, 1.05, 1.05), CFrame.new(0, 2.35, 0), Color3_fromRGB_ret5 },
                        { Vector3.new(0.42, 1.5, 0.42), CFrame.new(-1.02, 1.05, 0), v129 },
                        { Vector3.new(0.42, 1.5, 0.42), CFrame.new(1.02, 1.05, 0), v129 }
                    } do
                        local v132 = v2[1];
                        local v133 = CFrame_lookAt_ret * v2[2];
                        local v134 = v2[3];
                        local Part7 = Instance.new("Part");
                        Part7.Anchored = true;
                        Part7.CanCollide = false;
                        Part7.CanQuery = false;
                        Part7.CanTouch = false;
                        Part7.CastShadow = false;
                        Part7.Size = v132;
                        Part7.CFrame = v133;
                        Part7.Color = v134;
                        Part7.Material = Enum.Material.SmoothPlastic;
                        Part7.TopSurface = Enum.SurfaceType.Smooth;
                        Part7.BottomSurface = Enum.SurfaceType.Smooth;
                        Part7.Parent = u75;
                        v130.parts[i3] = Part7;
                        table.insert(v80.parts, Part7);
                        table.insert(v80.rests, CFrame_lookAt_ret * v2[2]);
                    end;

                    table.insert(v80.crowd, v130);
                else
                    v123 = i2;
                end;
            end;
        end;

        task.wait();
    end;

    v80.frames = table.create(#v80.parts);

    return v80;
end;

local u135 = { CFrame.new(-1.05, 2.9, 0), CFrame.new(1.05, 2.9, 0) };

local function cheer(p136, p137, p138) -- Line: 355
    -- upvalues: u135 (copy)
    local frames = p136.frames;
    local v139 = 0;

    for _, v in p136.crowd do
        local math_sin_ret = math.sin(p137 * 9 + v.phase);
        local v140 = p138 * math.abs(math_sin_ret) * 0.92;
        local v141 = v.base + Vector3.new(0, v140, 0);
        frames[v139 + 1] = v141 * CFrame.new(0, 0.9, 0);
        frames[v139 + 2] = v141 * CFrame.new(0, 2.35, 0);

        if p138 > 0.6 then
            frames[v139 + 3] = v141 * u135[1];
            frames[v139 + 4] = v141 * u135[2];
        else
            frames[v139 + 3] = v141 * CFrame.new(-1.02, 1.05, 0);
            frames[v139 + 4] = v141 * CFrame.new(1.02, 1.05, 0);
        end;

        v139 = v139 + 4;
    end;

    workspace:BulkMoveTo(p136.parts, frames, Enum.BulkMoveMode.FireCFrameChanged);
end;

local function dressed(p142) -- Line: 377
    -- upvalues: Players (copy), CharacterClone (copy)
    local success, result = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, p142, Enum.HumanoidRigType.R6);

    if success and (result and CharacterClone.dressed(result)) then
        return result;
    end;

    if success and result then
        result:Destroy();
    end;

    return nil;
end;

local function own() -- Line: 388
    -- upvalues: LocalPlayer (copy), Players (copy), CharacterClone (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    for i = 1, 3 do
        if Character then
            local success, result = pcall(Character.GetAppliedDescription, Character);

            if success and result then
                local success2, result2 = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, result, Enum.HumanoidRigType.R6);

                if not (success2 and (result2 and CharacterClone.dressed(result2))) then
                    if success2 and result2 then
                        result2:Destroy();
                        result2 = nil;
                    else
                        result2 = nil;
                    end;
                end;

                result:Destroy();

                if result2 then
                    return result2;
                end;
            end;
        end;

        local v143;

        if i < 3 then
            task.wait(CharacterClone.RETRY_SECONDS);
            v143 = i;
        else
            v143 = i;
        end;
    end;

    return nil;
end;

local function looks(p144) -- Line: 409
    -- upvalues: LocalPlayer (copy), Players (copy), CharacterClone (copy), u1 (copy)
    local u145 = {};
    local v146 = {
        [LocalPlayer.UserId] = true
    };
    local u147 = 0;

    local function make(u148) -- Line: 411
        -- upvalues: u147 (ref), Players (ref), CharacterClone (ref), u145 (copy)
        u147 = u147 + 1;
        task.spawn(function() -- Line: 413
            -- upvalues: u148 (copy), Players (ref), CharacterClone (ref), u145 (ref), u147 (ref)
            local success, result = pcall(u148);

            if success and result then
                local success2, result2 = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, result, Enum.HumanoidRigType.R6);

                if not (success2 and (result2 and CharacterClone.dressed(result2))) then
                    if success2 and result2 then
                        result2:Destroy();
                        result2 = nil;
                    else
                        result2 = nil;
                    end;
                end;

                result:Destroy();

                if result2 then
                    table.insert(u145, result2);
                end;
            end;

            u147 = u147 - 1;
        end);
    end;

    for _, v in Players:GetPlayers() do
        local u149;

        if v == LocalPlayer then
            u149 = false;
        else
            u149 = v.Character and v.Character:FindFirstChildOfClass("Humanoid");
        end;

        if u149 and (not v146[v.UserId] and u147 < p144) then
            v146[v.UserId] = true;

            local function u150() -- Line: 429
                -- upvalues: u149 (copy)
                return u149:GetAppliedDescription();
            end;

            u147 = u147 + 1;
            task.spawn(function() -- Line: 413
                -- upvalues: u150 (copy), Players (ref), CharacterClone (ref), u145 (copy), u147 (ref)
                local success, result = pcall(u150);

                if success and result then
                    local success2, result2 = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, result, Enum.HumanoidRigType.R6);

                    if not (success2 and (result2 and CharacterClone.dressed(result2))) then
                        if success2 and result2 then
                            result2:Destroy();
                            result2 = nil;
                        else
                            result2 = nil;
                        end;
                    end;

                    result:Destroy();

                    if result2 then
                        table.insert(u145, result2);
                    end;
                end;

                u147 = u147 - 1;
            end);
        end;
    end;

    for _, v in u1 do
        if not v146[v] and u147 < p144 then
            v146[v] = true;

            local function u151() -- Line: 437
                -- upvalues: Players (ref), v (copy)
                return Players:GetHumanoidDescriptionFromUserIdAsync(v);
            end;

            u147 = u147 + 1;
            task.spawn(function() -- Line: 413
                -- upvalues: u151 (copy), Players (ref), CharacterClone (ref), u145 (copy), u147 (ref)
                local success, result = pcall(u151);

                if success and result then
                    local success2, result2 = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, result, Enum.HumanoidRigType.R6);

                    if not (success2 and (result2 and CharacterClone.dressed(result2))) then
                        if success2 and result2 then
                            result2:Destroy();
                            result2 = nil;
                        else
                            result2 = nil;
                        end;
                    end;

                    result:Destroy();

                    if result2 then
                        table.insert(u145, result2);
                    end;
                end;

                u147 = u147 - 1;
            end);
        end;
    end;

    local v152 = os.clock() + 12;

    while u147 > 0 and os.clock() < v152 do
        task.wait(0.1);
    end;

    return u145;
end;

local u153 = {
    Idle = true,
    Walk = true,
    Run = true,
    DaggerHold = true
};

local function animation(p154, p155) -- Line: 450
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p155;
    table.insert(p154.assets, Animation);
    local success, result = pcall(p154.animator.LoadAnimation, p154.animator, Animation);

    return success and result and result or nil;
end;

local function actor(p156, p157, p158, p159, p160) -- Line: 459
    -- upvalues: CFrame_new_ret (copy), Weapons (copy), KnifeDisplayRig (copy), KnifeVisibility (copy), AnimationConfig (copy), u153 (copy), EmoteCatalog (copy)
    local Model = Instance.new("Model");
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CFrame = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -200, -0));
    Part.Parent = Model;
    Model.PrimaryPart = Part;

    if p158 then
        p158 = Weapons.Models:FindFirstChild(p158);
    end;

    local success, result = pcall(KnifeDisplayRig.create, p157, Model, p158);

    if not success and p158 then
        success, result = pcall(KnifeDisplayRig.create, p157, Model, Weapons.Models:FindFirstChild("BaseDagger"));
    end;

    Model:Destroy();

    if not success then
        warn("Cup trailer: a player couldn\'t be dressed:", result);

        return nil;
    end;

    local model = result.model;
    model.Name = "CupTrailerActor";
    local v161 = model:FindFirstChild("Left Leg");
    result.lift = v161 and (result.root.Position.Y - (v161.Position.Y - v161.Size.Y / 2) or 3) or 3;

    if result.stowed then
        KnifeVisibility.set(result.stowed, false);
    end;

    if result.blade then
        KnifeVisibility.set(result.blade, false);
    end;

    result.showBlade = false;

    if p159 then
        local Highlight = Instance.new("Highlight");
        Highlight.FillTransparency = 1;
        Highlight.OutlineColor = p159;
        Highlight.OutlineTransparency = 0.1;
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.Parent = model;
        result.outline = Highlight;
    end;

    model.Parent = p156;
    result.clips = {};

    for _, v in { "Idle", "Walk", "Run", "DaggerHold", "DaggerStab", "DaggerWindup" } do
        local u162 = AnimationConfig.PublishedIds[v];

        if u162 then
            local Animation = Instance.new("Animation");
            Animation.AnimationId = u162;
            table.insert(result.assets, Animation);
            local success2, result2 = pcall(result.animator.LoadAnimation, result.animator, Animation);
            u162 = success2 and result2 and result2 or nil;
        end;

        if u162 then
            local u163 = u153[v] == true;
            u162.Looped = u163;
            local v164;

            if v == "DaggerHold" then
                v164 = Enum.AnimationPriority.Action;
            elseif v == "Idle" then
                v164 = Enum.AnimationPriority.Idle;
            elseif u163 then
                v164 = Enum.AnimationPriority.Movement;
            else
                v164 = Enum.AnimationPriority.Action2;
            end;

            u162.Priority = v164;
            u162:GetPropertyChangedSignal("Length"):Once(function() -- Line: 510
                -- upvalues: u162 (copy), u163 (copy)
                u162.Looped = u163;
            end);
            result.clips[v] = u162;
        end;
    end;

    for _, v in p160 or {} do
        local v165 = EmoteCatalog.assetId(v);

        if v165 then
            local Animation = Instance.new("Animation");
            Animation.AnimationId = v165;
            table.insert(result.assets, Animation);
            local success2, result2 = pcall(result.animator.LoadAnimation, result.animator, Animation);
            v165 = success2 and result2 and result2 or nil;
        end;

        if v165 then
            v165.Looped = true;
            v165.Priority = Enum.AnimationPriority.Action4;
            result.clips["Emote:" .. v] = v165;
        end;
    end;

    return result;
end;

local function gait(p166, p167, p168) -- Line: 528
    if not p166 then
        return;
    end;

    for i, v in p166.clips do
        if i == "Idle" or (i == "Walk" or (i == "Run" or string.sub(i, 1, 6) == "Emote:")) then
            if i == p167 then
                if v.IsPlaying then
                    if math.abs(v.Speed - (p168 or 1)) > 0.01 then
                        v:AdjustSpeed(p168 or 1);
                    end;
                else
                    v:Play(0.15, 1, p168 or 1);
                end;
            elseif v.IsPlaying then
                v:Stop(0.15);
            end;
        end;
    end;
end;

local function hold(p169, p170) -- Line: 547
    -- upvalues: KnifeVisibility (copy)
    if not p169 then
        return;
    end;

    local DaggerHold = p169.clips.DaggerHold;

    if DaggerHold and p170 ~= DaggerHold.IsPlaying then
        if p170 then
            DaggerHold:Play(0.15);
        else
            DaggerHold:Stop(0.15);
        end;
    end;

    if p169.blade and p169.showBlade ~= p170 then
        p169.showBlade = p170;
        KnifeVisibility.set(p169.blade, p170);
    end;
end;

local function swing(p171, p172, p173) -- Line: 564
    if p171 then
        p171 = p171.clips[p172];
    end;

    if p171 then
        p171:Play(0.05, 1, p173 or 1);
        p171.TimePosition = 0;
    end;
end;

local function frame(p174, p175) -- Line: 573
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;

    for i, v in p175 do
        Frame[i] = v;
    end;

    Frame.Parent = p174;

    return Frame;
end;

local function text(p176, p177, p178, p179, p180, p181) -- Line: 582
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = p177;
    TextLabel.FontFace = p178;
    TextLabel.TextColor3 = p179;
    TextLabel.TextSize = p180;
    TextLabel.AutoLocalize = false;

    for i, v in p181 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p176;

    return TextLabel;
end;

local function stroke(p182, p183, p184) -- Line: 596
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p183;
    UIStroke.Thickness = p184;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = p182;

    return UIStroke;
end;

local function fade(p185, p186, p187, p188) -- Line: 604
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Transparency = NumberSequence.new(p186, p187);
    UIGradient.Rotation = p188 or 0;
    UIGradient.Parent = p185;

    return UIGradient;
end;

local function buildGui() -- Line: 613
    -- upvalues: Presentation (copy), Color3_fromRGB_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret2 (copy), text (copy), Font_new_ret (copy), Color3_fromRGB_ret6 (copy), Font_new_ret3 (copy), Font_new_ret2 (copy), LocalPlayer (copy)
    local CupTrailer = require(Presentation:WaitForChild("CutsceneScreen")).new("CupTrailer", 1004);
    CupTrailer:SetAttribute("CreatorCaptureExempt", true);
    CupTrailer:SetAttribute("SelfManagedText", true);
    local v189 = {
        Name = "Canvas",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(1280, 720)
    };
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;
    local u190 = {
        gui = CupTrailer
    };

    for i, v in v189 do
        Frame[i] = v;
    end;

    Frame.Parent = CupTrailer;
    u190.canvas = Frame;
    u190.scale = Instance.new("UIScale");
    u190.scale.Parent = Frame;

    local function cover(p191, p192, p193) -- Line: 628
        -- upvalues: Frame (copy)
        local v194 = {
            BackgroundTransparency = 1,
            Name = p191,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(640, 360),
            Size = UDim2.fromOffset(4000, 4000),
            BackgroundColor3 = p193,
            ZIndex = p192
        };
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;

        for i, v in v194 do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;

        return Frame2;
    end;

    u190.dark = cover("Dark", 1, Color3.fromRGB(29, 32, 41));
    u190.red = cover("Red", 2, Color3.fromRGB(200, 20, 20));
    local v195 = {
        Name = "Shadow",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Position = UDim2.fromOffset(-400, 0),
        Size = UDim2.fromOffset(2080, 330),
        BackgroundColor3 = Color3.fromRGB(20, 8, 12)
    };
    local Frame2 = Instance.new("Frame");
    Frame2.BorderSizePixel = 0;

    for i, v in v195 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    u190.shadow = Frame2;
    local shadow = u190.shadow;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Transparency = NumberSequence.new(0.08, 1);
    UIGradient.Rotation = 90;
    UIGradient.Parent = shadow;
    u190.lines = {};

    for i = 1, 90 do
        local lines = u190.lines;
        local v196 = {
            Name = "Line",
            Visible = false,
            ZIndex = 3,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3_fromRGB_ret
        };
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        local v197 = i;

        for i2, v in v196 do
            Frame3[i2] = v;
        end;

        Frame3.Parent = Frame;
        lines[v197] = Frame3;
        local v198 = u190.lines[v197];
        local UIGradient2 = Instance.new("UIGradient");
        UIGradient2.Transparency = NumberSequence.new(1, 0);
        UIGradient2.Rotation = 0;
        UIGradient2.Parent = v198;
    end;

    u190.streaks = {};

    for i = 1, 60 do
        local streaks = u190.streaks;
        local v199 = {
            Name = "Streak",
            Visible = false,
            ZIndex = 3,
            BackgroundColor3 = Color3_fromRGB_ret
        };
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;

        for i2, v in v199 do
            Frame3[i2] = v;
        end;

        Frame3.Parent = Frame;
        streaks[i] = Frame3;
    end;

    local v200 = {
        Name = "Ring",
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5)
    };
    local Frame3 = Instance.new("Frame");
    Frame3.BorderSizePixel = 0;

    for i, v in v200 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    u190.ring = Frame3;
    Instance.new("UICorner", u190.ring).CornerRadius = UDim.new(1, 0);
    local ring2 = u190.ring;
    local Color3_fromRGB_ret8 = Color3.fromRGB(191, 242, 255);
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret8;
    UIStroke.Thickness = 7;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = ring2;
    u190.ringStroke = UIStroke;
    u190.flash = cover("Flash", 5, Color3_fromRGB_ret);

    for _, v in { { 0, 0, 1280, 260, 90 }, { 0, 460, 1280, 260, 270 }, { 0, 0, 300, 720, 0 }, { 980, 0, 300, 720, 180 } } do
        local v201 = {
            Name = "Vignette",
            ZIndex = 6,
            Position = UDim2.fromOffset(v[1], v[2]),
            Size = UDim2.fromOffset(v[3], v[4]),
            BackgroundColor3 = Color3_new_ret
        };
        local Frame4 = Instance.new("Frame");
        Frame4.BorderSizePixel = 0;

        for i, v2 in v201 do
            Frame4[i] = v2;
        end;

        Frame4.Parent = Frame;
        local v202 = v[5];
        local UIGradient2 = Instance.new("UIGradient");
        UIGradient2.Transparency = NumberSequence.new(0.55, 1);
        UIGradient2.Rotation = v202 or 0;
        UIGradient2.Parent = Frame4;
    end;

    u190.words = {};

    for _, v in {
        { "Shk1", "SHK!", Color3_fromRGB_ret },
        { "Shk2", "SHK!", Color3_fromRGB_ret },
        { "Clang", "CLANG!", Color3_fromRGB_ret4 },
        { "Caught", "CAUGHT!", Color3_fromRGB_ret2 },
        { "Snag", "SNAG!", Color3_fromRGB_ret2 }
    } do
        local v203 = text(Frame, v[2], Font_new_ret, v[3], 100, {
            TextScaled = true,
            Visible = false,
            ZIndex = 7,
            Name = v[1],
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromOffset(600, 100)
        });
        local words = u190.words;
        local v204 = v[1];
        local v205 = {
            label = v203
        };
        local UIStroke2 = Instance.new("UIStroke");
        UIStroke2.Color = Color3_fromRGB_ret6;
        UIStroke2.Thickness = 10;
        UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke2.Parent = v203;
        v205.stroke = UIStroke2;
        words[v204] = v205;
    end;

    local v206 = {
        Name = "Glint",
        BackgroundTransparency = 1,
        Rotation = 45,
        Visible = false,
        ZIndex = 7,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(70, 70)
    };
    local Frame4 = Instance.new("Frame");
    Frame4.BorderSizePixel = 0;

    for i, v in v206 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame;
    u190.glint = Frame4;
    local glint = u190.glint;
    local v207 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.07, 1),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame5 = Instance.new("Frame");
    Frame5.BorderSizePixel = 0;

    for i, v in v207 do
        Frame5[i] = v;
    end;

    Frame5.Parent = glint;
    local glint2 = u190.glint;
    local v208 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 0.07),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame6 = Instance.new("Frame");
    Frame6.BorderSizePixel = 0;

    for i, v in v208 do
        Frame6[i] = v;
    end;

    Frame6.Parent = glint2;
    u190.glintScale = Instance.new("UIScale");
    u190.glintScale.Parent = u190.glint;
    local v209 = {
        Name = "Runners",
        BackgroundTransparency = 0.45,
        ZIndex = 8,
        Position = UDim2.fromOffset(28, 58),
        Size = UDim2.fromOffset(250, 36),
        BackgroundColor3 = Color3.fromRGB(10, 12, 20)
    };
    local Frame7 = Instance.new("Frame");
    Frame7.BorderSizePixel = 0;

    for i, v in v209 do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame;
    u190.hud = Frame7;
    u190.hudText = text(u190.hud, "RUNNERS LEFT: 2", Font_new_ret3, Color3_fromRGB_ret, 18, {
        Position = UDim2.fromOffset(16, 0),
        Size = UDim2.new(1, -16, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left
    });
    local v210 = {
        Name = "Top",
        ZIndex = 9,
        Position = UDim2.fromOffset(-1000, -1000),
        Size = UDim2.fromOffset(3280, 1040),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame8 = Instance.new("Frame");
    Frame8.BorderSizePixel = 0;

    for i, v in v210 do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame;
    local v211 = {
        Name = "Bottom",
        ZIndex = 9,
        Position = UDim2.fromOffset(-1000, 680),
        Size = UDim2.fromOffset(3280, 1040),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame9 = Instance.new("Frame");
    Frame9.BorderSizePixel = 0;

    for i, v in v211 do
        Frame9[i] = v;
    end;

    Frame9.Parent = Frame;
    u190.black = cover("Black", 10, Color3_new_ret);
    u190.black.BackgroundTransparency = 0;
    u190.title = {};

    for _, v in {
        {
            "VALLEY RUN",
            Font_new_ret2,
            Color3_fromRGB_ret,
            110,
            280
        },
        {
            "CUP",
            Font_new_ret2,
            Color3_fromRGB_ret4,
            130,
            385
        },
        {
            "NOV 7 – DEC 5",
            Font_new_ret3,
            Color3_fromRGB_ret,
            34,
            490
        },
        {
            "QUALIFIERS OPEN NOV 7",
            Font_new_ret3,
            Color3_fromRGB_ret4,
            22,
            545
        }
    } do
        local title = u190.title;
        local v212 = text(Frame, v[1], v[2], v[3], v[4], {
            Name = "Title",
            TextScaled = true,
            TextTransparency = 1,
            ZIndex = 11,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(640, v[5]),
            Size = UDim2.fromOffset(1200, v[4])
        });
        table.insert(title, v212);
    end;

    CupTrailer.Parent = LocalPlayer:WaitForChild("PlayerGui");
    local AbsoluteSize = CupTrailer.AbsoluteSize;
    u190.scale.Scale = math.max(AbsoluteSize.X / 1280, AbsoluteSize.Y / 720);
    u190.fitting = CupTrailer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 696, Name: fit
        -- upvalues: CupTrailer (copy), u190 (copy)
        local AbsoluteSize2 = CupTrailer.AbsoluteSize;
        u190.scale.Scale = math.max(AbsoluteSize2.X / 1280, AbsoluteSize2.Y / 720);
    end);

    return u190;
end;

local function speedLines(p213, p214, p215, p216, p217, p218) -- Line: 706
    -- upvalues: Color3_fromRGB_ret (copy)
    local math_floor_ret = math.floor(90 * p214);
    local math_floor_ret2 = math.floor(p215 * 12);

    if p213.linesKey == math_floor_ret2 .. ":" .. math_floor_ret .. ":" .. tostring(p216) then
        return;
    end;

    p213.linesKey = math_floor_ret2 .. ":" .. math_floor_ret .. ":" .. tostring(p216);

    for i, v in p213.lines do
        if i <= math_floor_ret then
            local v219 = math.sin(i * 127.1 + (math_floor_ret2 or 0) * 311.7) * 43758.5453;
            local v220 = (v219 - math.floor(v219)) * 3.141592653589793 * 2;
            local v221 = math.sin((i + 9) * 127.1 + (math_floor_ret2 or 0) * 311.7) * 43758.5453;
            local v222 = (p218 or 300) + (v221 - math.floor(v221)) * 260;
            local v223 = (v222 + 1100) / 2;
            v.Position = UDim2.fromOffset(640 + math.cos(v220) * v223, 360 + math.sin(v220) * v223);
            local UDim2_fromOffset = UDim2.fromOffset;
            local v224 = math.sin((i + 3) * 127.1 + (math_floor_ret2 or 0) * 311.7) * 43758.5453;
            v.Size = UDim2_fromOffset(1100 - v222, 4 + (v224 - math.floor(v224)) * 14);
            v.Rotation = math.deg(v220);
            v.BackgroundColor3 = p216 or Color3_fromRGB_ret;
            v.BackgroundTransparency = 1 - (p217 or 0.75);
            v.Visible = true;
        else
            v.Visible = false;
        end;
    end;
end;

local function streaks(p225, p226, p227) -- Line: 729
    local math_floor_ret = math.floor(60 * p226);
    local math_floor_ret2 = math.floor(p227 * 24);

    if p225.streaksKey == math_floor_ret2 .. ":" .. math_floor_ret then
        return;
    end;

    p225.streaksKey = math_floor_ret2 .. ":" .. math_floor_ret;

    for i, v in p225.streaks do
        if i <= math_floor_ret then
            local UDim2_fromOffset = UDim2.fromOffset;
            local v228 = math.sin((i + 5) * 127.1 + (math_floor_ret2 or 0) * 311.7) * 43758.5453;
            local v229 = (v228 - math.floor(v228)) * 1280 - 200;
            local v230 = math.sin(i * 127.1 + (math_floor_ret2 or 0) * 311.7) * 43758.5453;
            v.Position = UDim2_fromOffset(v229, (v230 - math.floor(v230)) * 720);
            local UDim2_fromOffset2 = UDim2.fromOffset;
            local v231 = math.sin((i + 2) * 127.1 + (math_floor_ret2 or 0) * 311.7) * 43758.5453;
            local v232 = 200 + (v231 - math.floor(v231)) * 700;
            local v233 = math.sin((i + 1) * 127.1 + (math_floor_ret2 or 0) * 311.7) * 43758.5453;
            v.Size = UDim2_fromOffset2(v232, 1 + (v233 - math.floor(v233)) * 3);
            local v234 = math.sin((i + 7) * 127.1 + (math_floor_ret2 or 0) * 311.7) * 43758.5453;
            v.BackgroundTransparency = 1 - (0.2 + (v234 - math.floor(v234)) * 0.5) * 0.5;
            v.Visible = true;
        else
            v.Visible = false;
        end;
    end;
end;

local function word(p235, p236, p237, p238, p239, p240, p241) -- Line: 748
    local v242 = p235.words[p236];
    v242.label.Visible = true;
    v242.label.Position = UDim2.fromOffset(p237, p238);
    v242.label.Size = UDim2.fromOffset(p239 * p241 * 6, p239 * p241);
    v242.label.Rotation = math.deg(p240);
    v242.stroke.Thickness = p239 * p241 * 0.1;
    v242.shown = true;
end;

local u243 = false;
local u244 = {
    speed = 1
};

local function play(p245) -- Line: 761
    -- upvalues: u243 (ref), RunService (copy), LocalPlayer (copy), TweenService (copy), buildGui (copy), CreatorVisibility (copy), SoundService (copy), own (copy), looks (copy), u2 (copy), buildGym (copy), ChickenOrHero (copy), actor (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), u3 (copy), Color3_fromRGB_ret (copy), CFrame_new_ret (copy), block (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret7 (copy), ring (copy), Color3_fromRGB_ret6 (copy), text (copy), Font_new_ret (copy), Lighting (copy), u5 (copy), ContentProvider (copy), u6 (copy), CFrame_new_ret2 (copy), gait (copy), hold (copy), pov (copy), speedLines (ref), word (copy), KnifeVisibility (copy), streaks (ref), cheer (copy), placeRing (copy), u244 (copy)
    if u243 then
        return;
    end;

    u243 = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u246 = {
        workspace_CurrentCamera.CameraType,
        workspace_CurrentCamera.CameraSubject,
        workspace_CurrentCamera.FieldOfView,
        workspace_CurrentCamera.CFrame
    };
    local u247 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = "CupTrailerSet";
    local u248 = nil;
    local u249 = nil;
    local u250 = nil;
    local u251 = nil;
    local u252 = nil;
    local u253 = nil;
    local u254 = {};
    local u255 = false;

    local function cleanup() -- Line: 774
        -- upvalues: u255 (ref), RunService (ref), u247 (copy), u254 (copy), Folder (copy), u253 (ref), workspace_CurrentCamera (copy), u246 (copy), LocalPlayer (ref), u249 (ref), u250 (ref), u251 (ref), TweenService (ref), u252 (ref), u248 (ref), u243 (ref)
        if u255 then
            return;
        end;

        u255 = true;
        RunService:UnbindFromRenderStep("CupTrailer");

        for _, v in u247 do
            v:Disconnect();
        end;

        table.clear(u247);

        for _, v in u254 do
            v:Destroy();
        end;

        table.clear(u254);
        Folder:Destroy();

        if u253 then
            for _, v in u253 do
                v:Destroy();
            end;
        end;

        workspace_CurrentCamera.CameraType = u246[1] == Enum.CameraType.Scriptable and Enum.CameraType.Custom or u246[1];
        local v256 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
        workspace_CurrentCamera.CameraSubject = v256 or u246[2];
        workspace_CurrentCamera.FieldOfView = u246[3];
        workspace_CurrentCamera.CFrame = u246[4];

        if u249 then
            u249:destroy();
        end;

        if u250 then
            pcall(u250.Enable, u250);
        end;

        if u251 then
            TweenService:Create(u251, TweenInfo.new(1.2), {
                Volume = u252
            }):Play();
        end;

        LocalPlayer:SetAttribute("MusicPaused", nil);

        if u248 then
            u248.fitting:Disconnect();

            for _, child in u248.canvas:GetChildren() do
                if child ~= u248.black and child:IsA("GuiObject") then
                    child.Visible = false;
                end;
            end;

            u248.black.BackgroundTransparency = 0;
            TweenService:Create(u248.black, TweenInfo.new(0.6), {
                BackgroundTransparency = 1
            }):Play();
            local gui = u248.gui;
            task.delay(0.65, function() -- Line: 820
                -- upvalues: gui (copy)
                gui:Destroy();
            end);
        end;

        LocalPlayer:SetAttribute("CupTrailerActive", nil);
        u243 = false;
    end;

    table.insert(u247, LocalPlayer.CharacterRemoving:Connect(cleanup));
    local u257 = nil;
    local u258 = nil;
    local u259 = {};
    local u260 = {};
    local success, result = pcall(function() -- Line: 830
        -- upvalues: LocalPlayer (ref), u248 (ref), buildGui (ref), u249 (ref), CreatorVisibility (ref), u250 (ref), SoundService (ref), u251 (ref), u252 (ref), TweenService (ref), own (ref), looks (ref), u2 (ref), u257 (ref), buildGym (ref), Folder (copy), ChickenOrHero (ref), u258 (ref), actor (ref), u259 (copy), Color3_fromRGB_ret3 (ref), Color3_fromRGB_ret2 (ref), u3 (ref), Color3_fromRGB_ret (ref), CFrame_new_ret (ref), u260 (copy), block (ref), Color3_fromRGB_ret4 (ref), Color3_fromRGB_ret7 (ref), ring (ref), Color3_fromRGB_ret6 (ref), text (ref), Font_new_ret (ref), u253 (ref), Lighting (ref), u5 (ref), u254 (copy), ContentProvider (ref), workspace_CurrentCamera (copy)
        LocalPlayer:SetAttribute("CupTrailerActive", true);
        u248 = buildGui();

        if LocalPlayer:GetAttribute("CreatorUIHidden") ~= true then
            u249 = CreatorVisibility.new(LocalPlayer);
            u249:setHidden(true);
        end;

        local success, result = pcall(function() -- Line: 837
            -- upvalues: LocalPlayer (ref)
            return require(LocalPlayer:WaitForChild("PlayerScripts"):FindFirstChild("PlayerModule")):GetControls();
        end);

        if success and result then
            u250 = result;
            pcall(u250.Disable, u250);
        end;

        local GameAudioMixer = SoundService:FindFirstChild("GameAudioMixer");
        LocalPlayer:SetAttribute("MusicPaused", true);
        local v261 = GameAudioMixer and GameAudioMixer:FindFirstChild("Music");
        u251 = v261;

        if u251 and u251:IsA("SoundGroup") then
            u252 = u251.Volume;
            TweenService:Create(u251, TweenInfo.new(0.5), {
                Volume = 0
            }):Play();
        else
            u251 = nil;
        end;

        local u262 = nil;
        local u263 = nil;
        local u264 = 2;
        task.spawn(function() -- Line: 858
            -- upvalues: u262 (ref), own (ref), u264 (ref)
            u262 = own();
            u264 = u264 - 1;
        end);
        task.spawn(function() -- Line: 862
            -- upvalues: u263 (ref), looks (ref), u2 (ref), u264 (ref)
            u263 = looks(#u2);
            u264 = u264 - 1;
        end);
        u257 = buildGym(Folder);
        Folder.Parent = workspace;
        local v265 = os.clock() + 15;

        while u264 > 0 and os.clock() < v265 do
            task.wait(0.1);
        end;

        u263 = u263 or {};
        local CrossyRoadChaserTemplate = ChickenOrHero.Game:FindFirstChild("CrossyRoadChaserTemplate");

        if not u262 then
            if CrossyRoadChaserTemplate then
                CrossyRoadChaserTemplate = CrossyRoadChaserTemplate:Clone();
            end;

            u262 = CrossyRoadChaserTemplate;
        end;

        if #u263 == 0 and u262 then
            table.insert(u263, u262:Clone());
        end;

        if u262 then
            u258 = actor(Folder, u262, nil, nil);
        end;

        if u258 then
            for _, descendant in u258.model:GetDescendants() do
                if descendant:IsA("BasePart") and (descendant.Name ~= "Left Arm" and descendant.Name ~= "Right Arm") or descendant:IsA("Decal") then
                    descendant.Transparency = 1;
                end;
            end;

            local Torso = u258.model:FindFirstChild("Torso");
            local v266 = {};
            local v267;

            if Torso then
                v267 = Torso:FindFirstChild("Right Shoulder");
            else
                v267 = Torso;
            end;

            if Torso then
                Torso = Torso:FindFirstChild("Left Shoulder");
            end;

            v266[1], v266[2] = v267, Torso;
            u258.shoulders = v266;
        end;

        local v268 = { 1, 2, 3, 4, 2, 3 };

        for i, v in u2 do
            local v269;

            if i == 5 then
                v269 = Color3_fromRGB_ret3;
            else
                v269 = Color3_fromRGB_ret2;
            end;

            local v270;

            if i == 4 and true or i == 5 then
                v270 = u3;
            else
                v270 = nil;
            end;

            u259[i] = actor(Folder, u263[(v268[i] - 1) % #u263 + 1], v, v269, v270);
            task.wait();
        end;

        for _, v in u263 do
            v:Destroy();
        end;

        if u262 then
            u262:Destroy();
        end;

        local function flyer(p271, p272) -- Line: 909
            -- upvalues: Color3_fromRGB_ret (ref), CFrame_new_ret (ref), Folder (ref)
            if p271 then
                p271 = p271.blade;
            end;

            if not p271 then
                return nil;
            end;

            local v273 = p271:Clone();

            for _, descendant in v273:GetDescendants() do
                if descendant:IsA("JointInstance") or (descendant:IsA("Constraint") or descendant:IsA("LuaSourceContainer")) then
                    descendant:Destroy();
                end;
            end;

            v273.Name = p272;
            v273.Anchored = true;
            v273.CanCollide = false;
            v273.CanQuery = false;
            v273.CanTouch = false;
            v273.Transparency = 0;
            v273.LocalTransparencyModifier = 0;
            local Size = v273.Size;
            local math_max_ret = math.max(Size.X, Size.Y, Size.Z);
            v273:SetAttribute("Align", math_max_ret == Size.X and 1 or (math_max_ret == Size.Y and 2 or 3));
            local Attachment = Instance.new("Attachment");
            local Attachment2 = Instance.new("Attachment");
            local v274 = math_max_ret == Size.X and Vector3.new(1, 0, 0) or (math_max_ret == Size.Y and Vector3.new(0, 1, 0) or Vector3.new(0, 0, 1));
            Attachment.Position = v274 * math_max_ret * 0.45;
            Attachment2.Position = -v274 * math_max_ret * 0.45;
            Attachment.Parent = v273;
            Attachment2.Parent = v273;
            local Trail = Instance.new("Trail");
            Trail.Attachment0 = Attachment;
            Trail.Attachment1 = Attachment2;
            Trail.Lifetime = 0.12;
            Trail.Color = ColorSequence.new(Color3_fromRGB_ret);
            Trail.Transparency = NumberSequence.new(0.35, 1);
            Trail.LightEmission = 0.6;
            Trail.FaceCamera = true;
            Trail.Enabled = false;
            Trail.Parent = v273;
            v273.CFrame = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -200, -0));
            v273.Parent = Folder;

            return {
                part = v273,
                trail = Trail,
                base = Size
            };
        end;

        u260.K1 = flyer(u259[2], "Knife1");
        u260.K2 = flyer(u259[1], "Knife2");
        u260.K3 = flyer(u259[2], "Knife3");
        u260.K4 = flyer(u259[2], "Knife4");
        u260.K5 = flyer(u259[3], "Knife5");
        u260.Plunge = flyer(u259[6], "Plunge");
        local OneHitShield = ChickenOrHero.Gear.Assets:FindFirstChild("OneHitShield");

        if OneHitShield then
            OneHitShield = OneHitShield:FindFirstChildWhichIsA("BasePart");
        end;

        if OneHitShield then
            local v275 = OneHitShield:Clone();
            v275.Anchored = true;
            v275.CanCollide = false;
            v275.CanQuery = false;
            v275.CanTouch = false;
            v275.CastShadow = false;
            v275.CFrame = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -200, -0));
            v275.Parent = Folder;
            u260.Shield = {
                part = v275
            };
        end;

        u260.Shards = {};

        for i = 1, 14 do
            u260.Shards[i] = block(Folder, Vector3.new(0.12, 0.7, 0.9), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -200, -0)), Color3.fromRGB(191, 242, 255), Enum.Material.Neon, {
                Shape = Enum.PartType.Wedge
            });
            local _ = i;
        end;

        local function burst(p276) -- Line: 974
            -- upvalues: block (ref), Folder (ref), CFrame_new_ret (ref), Color3_fromRGB_ret (ref)
            local v277 = block(Folder, Vector3.new(1, 1, 1), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -200, -0)), Color3_fromRGB_ret, nil, {
                Transparency = 1
            });
            local ParticleEmitter = Instance.new("ParticleEmitter");
            ParticleEmitter.Rate = 0;
            ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
            ParticleEmitter.Color = ColorSequence.new(p276);
            ParticleEmitter.LightEmission = 1;
            ParticleEmitter.Size = NumberSequence.new(0.5, 0);
            ParticleEmitter.Lifetime = NumberRange.new(0.25, 0.5);
            ParticleEmitter.Speed = NumberRange.new(18, 34);
            ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
            ParticleEmitter.Drag = 4;
            ParticleEmitter.Parent = v277;

            return {
                part = v277,
                emitter = ParticleEmitter
            };
        end;

        u260.Sparks = burst(Color3_fromRGB_ret4);
        u260.Tag = burst(Color3_fromRGB_ret2);
        u260.Loop = block(Folder, Vector3.new(0.6, 6, 6), CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -200, -0)), Color3_fromRGB_ret7, nil, {
            Transparency = 1
        });
        u260.LoopParts = ring(Folder, 22, Color3_fromRGB_ret7, 0.32, Enum.Material.Fabric);
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = u260.Loop;
        u260.Knot = Attachment;
        u260.Thrower = block(Folder, Vector3.new(1, 1, 1), CFrame.new(CFrame_new_ret.Position + Vector3.new(28, 5.04, 14)), Color3_fromRGB_ret, nil, {
            Transparency = 1
        });
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Parent = u260.Thrower;
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = Attachment;
        Beam.Attachment1 = Attachment2;
        Beam.Color = ColorSequence.new(Color3_fromRGB_ret7);
        Beam.Width0 = 0.35;
        Beam.Width1 = 0.35;
        Beam.Segments = 12;
        Beam.FaceCamera = true;
        Beam.LightInfluence = 1;
        Beam.Enabled = false;
        Beam.Parent = u260.Loop;
        u260.Rope = Beam;

        for i, v in {
            [4] = "EZ",
            [5] = "LOL"
        } do
            local v278 = u259[i];
            local v279;

            if v278 then
                v279 = v278.model:FindFirstChild("Head");
            else
                v279 = v278;
            end;

            if v279 then
                local BillboardGui = Instance.new("BillboardGui");
                BillboardGui.Size = UDim2.fromScale(7, 7);
                BillboardGui.StudsOffset = Vector3.new(0, 3.2, 0);
                BillboardGui.LightInfluence = 0;
                BillboardGui.Enabled = false;
                BillboardGui:SetAttribute("CreatorCaptureExempt", true);
                local v280 = {
                    Name = "Bubble",
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.42),
                    Size = UDim2.fromScale(0.62, 0.3),
                    BackgroundColor3 = Color3.new(1, 1, 1)
                };
                local Frame = Instance.new("Frame");
                Frame.BorderSizePixel = 0;

                for i2, v2 in v280 do
                    Frame[i2] = v2;
                end;

                Frame.Parent = BillboardGui;
                local UIStroke = Instance.new("UIStroke");
                UIStroke.Color = Color3_fromRGB_ret6;
                UIStroke.Thickness = 3;
                UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
                UIStroke.Parent = Frame;
                UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                text(Frame, v, Font_new_ret, Color3_fromRGB_ret2, 40, {
                    TextScaled = true,
                    Size = UDim2.fromScale(1, 1)
                });
                local v281 = {
                    Rotation = 35,
                    ZIndex = 0,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.3, 1.05),
                    Size = UDim2.fromScale(0.16, 0.3),
                    BackgroundColor3 = Color3.new(1, 1, 1)
                };
                local Frame2 = Instance.new("Frame");
                Frame2.BorderSizePixel = 0;

                for i2, v2 in v281 do
                    Frame2[i2] = v2;
                end;

                Frame2.Parent = Frame;
                local UIStroke2 = Instance.new("UIStroke");
                UIStroke2.Color = Color3_fromRGB_ret6;
                UIStroke2.Thickness = 3;
                UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
                UIStroke2.Parent = Frame2;
                UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                v278.bubble = Frame;
                v278.notes = {};

                for i2 = 1, 3 do
                    local v282;

                    if i2 % 2 == 0 then
                        v282 = Color3_fromRGB_ret4;
                    else
                        v282 = Color3_fromRGB_ret3;
                    end;

                    v278.notes[i2] = text(BillboardGui, i2 == 2 and "♫" or "♪", Font_new_ret, v282, 40, {
                        TextScaled = true,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.fromScale(0.22, 0.22)
                    });
                    local v283 = v278.notes[i2];
                    local UIStroke3 = Instance.new("UIStroke");
                    UIStroke3.Color = Color3_fromRGB_ret6;
                    UIStroke3.Thickness = 2;
                    UIStroke3.LineJoinMode = Enum.LineJoinMode.Round;
                    UIStroke3.Parent = v283;
                    local _ = i2;
                end;

                BillboardGui.Parent = v279;
                v278.board = BillboardGui;
            end;
        end;

        local v284 = u259[6];
        local v285;

        if v284 then
            v285 = v284.model:FindFirstChild("Head");
        else
            v285 = v284;
        end;

        if v285 then
            local v286 = block(v284.model, Vector3.new(1.3, 1.3, 0.05), v285.CFrame * CFrame.new(0, 0, -0.66), Color3_fromRGB_ret, nil, {
                Transparency = 1,
                Anchored = false,
                Massless = true
            });
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v285;
            WeldConstraint.Part1 = v286;
            WeldConstraint.Parent = v286;
            local Front = Enum.NormalId.Front;
            local SurfaceGui = Instance.new("SurfaceGui");
            SurfaceGui.Face = Front;
            SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
            SurfaceGui.PixelsPerStud = 100;
            SurfaceGui.LightInfluence = 0.6;
            SurfaceGui:SetAttribute("CreatorCaptureExempt", true);
            SurfaceGui.Parent = v286;
            SurfaceGui.LightInfluence = 0;
            SurfaceGui.Brightness = 3;

            for _, v in { -1, 1 } do
                local v287 = {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5 + v * 0.2, 0.5),
                    Size = UDim2.fromScale(0.26, 0.06),
                    Rotation = v * 12,
                    BackgroundColor3 = Color3.fromRGB(255, 59, 48)
                };
                local Frame = Instance.new("Frame");
                Frame.BorderSizePixel = 0;

                for i, v2 in v287 do
                    Frame[i] = v2;
                end;

                Frame.Parent = SurfaceGui;
            end;

            local v288 = {
                Rotation = -2,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.76),
                Size = UDim2.fromScale(0.46, 0.1),
                BackgroundColor3 = Color3_fromRGB_ret6
            };
            local Frame = Instance.new("Frame");
            Frame.BorderSizePixel = 0;

            for i, v in v288 do
                Frame[i] = v;
            end;

            Frame.Parent = SurfaceGui;

            for i = 0, 6 do
                local v289 = {
                    Position = UDim2.fromScale(i * 0.135 + 0.04, 0.12),
                    Size = UDim2.fromScale(0.09, 0.38),
                    BackgroundColor3 = Color3.new(1, 1, 1)
                };
                local Frame2 = Instance.new("Frame");
                Frame2.BorderSizePixel = 0;
                local _ = i;

                for i2, v in v289 do
                    Frame2[i2] = v;
                end;

                Frame2.Parent = Frame;
            end;

            local PointLight = Instance.new("PointLight");
            PointLight.Color = Color3.fromRGB(255, 42, 42);
            PointLight.Range = 5;
            PointLight.Brightness = 2;
            PointLight.Parent = v286;
            v284.eye = v286;
        end;

        u253 = {};
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "CupTrailerImpact";
        ColorCorrectionEffect.Saturation = -1;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Brightness = 0.08;
        ColorCorrectionEffect.Enabled = false;
        ColorCorrectionEffect.Parent = Lighting;
        u253.impact = ColorCorrectionEffect;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Name = "CupTrailerBlur";
        BlurEffect.Size = 0;
        BlurEffect.Parent = Lighting;
        u253.blur = BlurEffect;
        local u290 = {};

        for i, v in u5 do
            local Sound = Instance.new("Sound");
            Sound.Name = "CupTrailer" .. i;
            Sound.SoundId = v[1];
            Sound.Volume = v[2];
            Sound.Looped = v[3] == true;
            Sound.PlaybackSpeed = v[4] or 1;
            Sound:SetAttribute("Volume", v[2]);
            Sound.Parent = SoundService;
            u254[i] = Sound;
            table.insert(u290, Sound);
        end;

        local u291 = false;
        task.spawn(function() -- Line: 1099
            -- upvalues: ContentProvider (ref), u290 (copy), u291 (ref)
            pcall(ContentProvider.PreloadAsync, ContentProvider, u290);
            u291 = true;
        end);
        local v292 = os.clock() + 6;

        while not u291 and os.clock() < v292 do
            task.wait(0.1);
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    end);

    if not success then
        warn("Cup trailer couldn\'t start:", result);
        cleanup();

        return;
    end;

    local u293 = u259[1];
    local u294 = u259[2];
    local u295 = u259[3];
    local u296 = u259[4];
    local u297 = u259[5];
    local u298 = u259[6];
    local u299 = {};
    local u300 = {};
    local u301 = {};
    local os_clock_ret = os.clock();
    local math_clamp_ret = math.clamp(p245 or 0, 0, 29.9);
    local u302 = nil;

    local function at_(p303, p304, p305) -- Line: 1121
        -- upvalues: u299 (copy), math_clamp_ret (ref)
        if not u299[p303] and p304 <= math_clamp_ret then
            u299[p303] = true;

            if math_clamp_ret - p304 < 0.4 then
                p305();
            end;
        end;
    end;

    local function syncSounds() -- Line: 1130
        -- upvalues: u254 (copy), u6 (ref), math_clamp_ret (ref), u299 (copy)
        for _, v in u254 do
            v:Stop();
        end;

        for i, v in u6 do
            if math_clamp_ret >= v[1] then
                u299["cue" .. i] = true;
                local v306 = u254[v[2]];

                if v[3] and (math_clamp_ret < v[3] and v306) then
                    v306.TimePosition = (math_clamp_ret - v[1]) * v306.PlaybackSpeed;
                    v306:Play();
                end;
            end;
        end;
    end;

    local function soundCues() -- Line: 1145
        -- upvalues: u6 (ref), u254 (copy), u299 (copy), math_clamp_ret (ref)
        for i, v in u6 do
            local u307 = u254[v[2]];

            if u307 then
                local v308 = "cue" .. i;
                local v309 = v[1];

                local function _() -- Line: 1149
                    -- upvalues: u307 (copy)
                    u307.TimePosition = 0;
                    u307:Play();
                end;

                if not u299[v308] and v309 <= math_clamp_ret then
                    u299[v308] = true;

                    if math_clamp_ret - v309 < 0.4 then
                        u307.TimePosition = 0;
                        u307:Play();
                    end;
                end;

                if v[3] and (math_clamp_ret >= v[3] and (u307.IsPlaying and not u299["stop" .. i])) then
                    u299["stop" .. i] = true;
                    u307:Stop();
                end;
            end;
        end;
    end;

    local CFrame_new_ret3 = CFrame.new(CFrame_new_ret.Position + Vector3.new(0, -200, -0));

    local function use(p310) -- Line: 1161
        -- upvalues: u300 (copy)
        if p310 then
            u300[p310] = true;
        end;
    end;

    local function stand(p311, p312, p313, p314) -- Line: 1167
        -- upvalues: u300 (copy), u301 (copy), CFrame_new_ret (ref)
        if not p311 then
            return;
        end;

        u300[p311] = true;
        u301[p311] = nil;
        local v315 = CFrame_new_ret.Position + Vector3.new(p312 * 2.8, 0, -((p313 - 12) * 2.8)) + Vector3.new(0, p311.lift, 0);
        local Vector3_new_ret = Vector3.new(p314.X, v315.Y, p314.Z);
        local model = p311.model;
        local v316;

        if (Vector3_new_ret - v315).Magnitude > 0.01 then
            v316 = CFrame.lookAt(v315, Vector3_new_ret);
        else
            v316 = CFrame.new(v315);
        end;

        model:PivotTo(v316);
    end;

    local function knife(p317, p318, p319, p320, p321) -- Line: 1177
        -- upvalues: u300 (copy)
        if not p317 then
            return;
        end;

        u300[p317] = true;
        local part = p317.part;
        local Attribute = part:GetAttribute("Align");
        local v322;

        if Attribute == 1 then
            v322 = CFrame.Angles(0, 1.5707963267948966, 0);
        elseif Attribute == 2 then
            v322 = CFrame.Angles(-1.5707963267948966, 0, 0);
        else
            v322 = CFrame.identity;
        end;

        local v323 = p319.Magnitude <= 0.001 and Vector3.new(0, 0, 1) or p319.Unit;

        if part:IsA("MeshPart") then
            local v324 = p317.base * (p321 or 1);

            if part.Size ~= v324 then
                part.Size = v324;
            end;
        end;

        part.CFrame = CFrame.lookAt(p318, p318 + v323) * CFrame.Angles(0, 0, p320) * v322;

        if p317.wasShown then
            p317.trail.Enabled = true;
        end;

        p317.shown = true;
    end;

    local function arms(p325, p326, p327, p328) -- Line: 1200
        -- upvalues: u258 (ref), u300 (copy), u301 (copy), CFrame_new_ret2 (ref), math_clamp_ret (ref)
        if not u258 then
            return;
        end;

        u300[u258] = true;
        u301[u258] = nil;
        u258.model:PivotTo(p325 * CFrame_new_ret2);

        for i, v in u258.shoulders do
            if v then
                local v329 = i == 1 and 1 or -1;
                local v330;

                if p326 > 0 then
                    v330 = math.sin(math_clamp_ret * 14 + (v329 > 0 and 3.141592653589793 or 0)) * p326;
                else
                    v330 = math.sin(math_clamp_ret * 2 + v329) * 0.05;
                end;

                local v331 = 1.42 + v330 * 0.35;
                local v332 = v331 + (1.75 - v331) * p327 + p328 * math.sin(math_clamp_ret * 31 + v329) * 0.6;
                local v333 = 0.1 + 0.35 * p327 + p328 * math.cos(math_clamp_ret * 27 + v329) * 0.5;
                v.Transform = CFrame.Angles(0, v329 * v333, 0) * CFrame.Angles(0, 0, v329 * v332);
            end;
        end;
    end;

    local function projected(p334) -- Line: 1217
        -- upvalues: workspace_CurrentCamera (copy), u248 (ref)
        local v335, v336 = workspace_CurrentCamera:WorldToViewportPoint(p334);
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        local Scale = u248.scale.Scale;

        if v336 then
            v336 = v335.Z > 0;
        end;

        return 640 + (v335.X - ViewportSize.X / 2) / Scale, 360 + (v335.Y - ViewportSize.Y / 2) / Scale, v336;
    end;

    local function chasersFacing(p337, p338, p339, p340, p341) -- Line: 1226
        -- upvalues: u293 (copy), u294 (copy), u295 (copy), stand (copy), gait (ref), hold (ref)
        for i, v in { u293, u294, u295 } do
            stand(v, (i - 2) * 3, p337, p341.Position);
            gait(v, p338, p339);
            hold(v, p340);
        end;
    end;

    local u436 = {
        { 0, 3, function(p342) -- Line: 1235
                -- upvalues: pov (ref), math_clamp_ret (ref), chasersFacing (copy), arms (copy)
                local v343 = pov(0, math.sin(math_clamp_ret * 2) * 0.02 + 1.6, 2, 0, 0, math.sin(math_clamp_ret * 1.3) * 0.012);
                chasersFacing(22, "Idle", 1, true, v343);
                arms(v343, 0, 0, 0);

                return v343, 0.25, 2;
            end },
        { 3, 5, function(p344) -- Line: 1242
                -- upvalues: pov (ref), chasersFacing (copy), u294 (copy), u299 (copy), math_clamp_ret (ref), knife (copy), u260 (copy), CFrame_new_ret (ref), speedLines (ref), u248 (ref), arms (copy), word (ref)
                local math_clamp_ret2 = math.clamp((p344 - 0.32) / 0.15999999999999998, 0, 1);
                local v345 = 1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3;
                local v346;

                if p344 < 0.45 then
                    v346 = math.clamp((p344 - 0.32) / 0.13, 0, 1);
                else
                    v346 = 1 - math.clamp((p344 - 0.45) / 0.45, 0, 1);
                end;

                local v347 = pov(-1.8 * v345, 1.6, 2, 120 * v345, 0, 0.24 * v346);
                chasersFacing(22 + -3 * p344, "Walk", 0.45, true, v347);

                local function _() -- Line: 1246
                    -- upvalues: u294 (ref)
                    local v348 = u294;

                    if v348 then
                        v348 = v348.clips.DaggerStab;
                    end;

                    if v348 then
                        v348:Play(0.05, 1, 1.3);
                        v348.TimePosition = 0;
                    end;
                end;

                if not u299.throw1 and math_clamp_ret >= 2.85 then
                    u299.throw1 = true;

                    if math_clamp_ret - 2.85 < 0.4 then
                        local v349 = u294;

                        if v349 then
                            v349 = v349.clips.DaggerStab;
                        end;

                        if v349 then
                            v349:Play(0.05, 1, 1.3);
                            v349.TimePosition = 0;
                        end;
                    end;
                end;

                local math_clamp_ret3 = math.clamp((p344 - 0) / 0.62, 0, 1);

                if math_clamp_ret3 < 1 then
                    local K1 = u260.K1;
                    local math_clamp_ret4 = math.clamp(math_clamp_ret3, 0, 1);
                    knife(K1, CFrame_new_ret.Position + Vector3.new((0 + 0.35 * math_clamp_ret3) * 2.8, (1.8 + -0.25 * math_clamp_ret3) * 2.8, -((21.5 + -20.3 * (math_clamp_ret4 * math_clamp_ret4) - 12) * 2.8)), CFrame_new_ret.Position + Vector3.new(0.98, 4.34, 30.24) - (CFrame_new_ret.Position + Vector3.new(0, 5.04, -26.6)), math_clamp_ret * 14);
                end;

                local v350;

                if p344 < 0.48 then
                    v350 = math.clamp((p344 - 0.35) / 0.13, 0, 1);
                else
                    v350 = 1 - math.clamp((p344 - 0.48) / 0.27, 0, 1);
                end;

                speedLines(u248, v350, math_clamp_ret);
                arms(v347, 0.6, 0, 0);

                if p344 > 0.48 then
                    word(u248, "Shk1", 1000, 250, 110, -0.15, 1 + 0.3 * (1 - math.clamp((p344 - 0.48) / 0.12, 0, 1)));
                end;

                return v347, 0.4, 2;
            end },
        { 5, 7, function(p351) -- Line: 1261
                -- upvalues: pov (ref), chasersFacing (copy), u293 (copy), u299 (copy), math_clamp_ret (ref), knife (copy), u260 (copy), CFrame_new_ret (ref), speedLines (ref), u248 (ref), arms (copy), word (ref)
                local math_clamp_ret2 = math.clamp((p351 - 0.32) / 0.15999999999999998, 0, 1);
                local v352 = 1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3;
                local v353;

                if p351 < 0.45 then
                    v353 = math.clamp((p351 - 0.32) / 0.13, 0, 1);
                else
                    v353 = 1 - math.clamp((p351 - 0.45) / 0.45, 0, 1);
                end;

                local v354 = pov(-1.8 + 3.2 * v352, 1.6, 2, 120 + -260 * v352, 0, -0.26 * v353);
                chasersFacing(19 + -3 * p351, "Walk", 0.45, true, v354);

                local function _() -- Line: 1265
                    -- upvalues: u293 (ref)
                    local v355 = u293;

                    if v355 then
                        v355 = v355.clips.DaggerStab;
                    end;

                    if v355 then
                        v355:Play(0.05, 1, 1.3);
                        v355.TimePosition = 0;
                    end;
                end;

                if not u299.throw2 and math_clamp_ret >= 4.85 then
                    u299.throw2 = true;

                    if math_clamp_ret - 4.85 < 0.4 then
                        local v356 = u293;

                        if v356 then
                            v356 = v356.clips.DaggerStab;
                        end;

                        if v356 then
                            v356:Play(0.05, 1, 1.3);
                            v356.TimePosition = 0;
                        end;
                    end;
                end;

                local math_clamp_ret3 = math.clamp((p351 - 0) / 0.62, 0, 1);

                if math_clamp_ret3 < 1 then
                    local K2 = u260.K2;
                    local math_clamp_ret4 = math.clamp(math_clamp_ret3, 0, 1);
                    knife(K2, CFrame_new_ret.Position + Vector3.new((-3 + 1.4 * math_clamp_ret3) * 2.8, (1.8 + -0.19999999999999996 * math_clamp_ret3) * 2.8, -((15.5 + -14.3 * (math_clamp_ret4 * math_clamp_ret4) - 12) * 2.8)), CFrame_new_ret.Position + Vector3.new(-4.48, 4.48, 30.24) - (CFrame_new_ret.Position + Vector3.new(-8.4, 5.04, -9.8)), -math_clamp_ret * 14);
                end;

                local v357;

                if p351 < 0.48 then
                    v357 = math.clamp((p351 - 0.35) / 0.13, 0, 1);
                else
                    v357 = 1 - math.clamp((p351 - 0.48) / 0.27, 0, 1);
                end;

                speedLines(u248, v357, math_clamp_ret);
                arms(v354, 0.6, 0, 0);

                if p351 > 0.5 then
                    word(u248, "Shk2", 280, 260, 110, 0.15, 1 + 0.3 * (1 - math.clamp((p351 - 0.5) / 0.12, 0, 1)));
                end;

                local v358;

                if p351 > 0.47 then
                    v358 = p351 < 0.52;
                else
                    v358 = false;
                end;

                return v354, 0.5, 2, v358;
            end },
        { 7, 10, function(p359) -- Line: 1281
                -- upvalues: pov (ref), stand (copy), u293 (copy), gait (ref), KnifeVisibility (ref), u295 (copy), u294 (copy), hold (ref), u299 (copy), math_clamp_ret (ref), knife (copy), u260 (copy), CFrame_new_ret (ref), arms (copy), u300 (copy), u248 (ref), word (ref)
                local v360;

                if p359 < 0.57 then
                    v360 = math.clamp((p359 - 0.55) / 0.019999999999999907, 0, 1);
                else
                    v360 = 1 - math.clamp((p359 - 0.57) / 0.18000000000000005, 0, 1);
                end;

                local v361 = v360 * 14;
                local v362 = 1.4 + -0.8999999999999999 * (1 - (1 - math.clamp(p359, 0, 1)) ^ 3);
                local v363 = -140 + 140 * (1 - (1 - math.clamp(p359, 0, 1)) ^ 3) + math.sin(p359 * 300) * v361;
                local v364 = math.cos(p359 * 260) * v361;
                local v365 = math.sin(p359 * 40) * 0.04;
                local v366;

                if p359 < 0.57 then
                    v366 = math.clamp((p359 - 0.55) / 0.019999999999999907, 0, 1);
                else
                    v366 = 1 - math.clamp((p359 - 0.57) / 0.18000000000000005, 0, 1);
                end;

                local v367 = pov(v362, 1.6, 2, v363, v364, v365 * v366 + 0.02);
                local math_clamp_ret2 = math.clamp((p359 - 0) / 0.45, 0, 1);
                local v368 = 17 + -11 * (1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3);
                stand(u293, -3, 16 + -3 * p359, v367.Position);
                gait(u293, "Walk", 0.45);
                local v369 = u293;

                if v369 then
                    local DaggerHold = v369.clips.DaggerHold;

                    if DaggerHold and DaggerHold.IsPlaying ~= true then
                        DaggerHold:Play(0.15);
                    end;

                    if v369.blade and v369.showBlade ~= true then
                        v369.showBlade = true;
                        KnifeVisibility.set(v369.blade, true);
                    end;
                end;

                stand(u295, 3, 16 + -3 * p359, v367.Position);
                gait(u295, "Walk", 0.45);
                local v370 = u295;

                if v370 then
                    local DaggerHold = v370.clips.DaggerHold;

                    if DaggerHold and DaggerHold.IsPlaying ~= true then
                        DaggerHold:Play(0.15);
                    end;

                    if v370.blade and v370.showBlade ~= true then
                        v370.showBlade = true;
                        KnifeVisibility.set(v370.blade, true);
                    end;
                end;

                stand(u294, 1.2, v368, v367.Position);
                gait(u294, p359 < 0.45 and "Run" or "Idle", 1.1);
                hold(u294, p359 < 0.42);

                local function _() -- Line: 1301
                    -- upvalues: u294 (ref)
                    local v371 = u294;

                    if v371 then
                        v371 = v371.clips.DaggerStab;
                    end;

                    if v371 then
                        v371:Play(0.05, 1, 1.4);
                        v371.TimePosition = 0;
                    end;
                end;

                if not u299.throw3 and math_clamp_ret >= 8.2 then
                    u299.throw3 = true;

                    if math_clamp_ret - 8.2 < 0.4 then
                        local v372 = u294;

                        if v372 then
                            v372 = v372.clips.DaggerStab;
                        end;

                        if v372 then
                            v372:Play(0.05, 1, 1.4);
                            v372.TimePosition = 0;
                        end;
                    end;
                end;

                local math_clamp_ret3 = math.clamp((p359 - 0.42) / 0.13000000000000006, 0, 1);
                local v373 = p359 >= 0.55;

                if p359 > 0.42 and not v373 then
                    local v374 = v368 - 0.3;
                    knife(u260.K3, CFrame_new_ret.Position + Vector3.new((1.4 + -0.8999999999999999 * math_clamp_ret3) * 2.8, (1.8 + -0.19999999999999996 * math_clamp_ret3) * 2.8, -((v374 + (3.2 - v374) * math_clamp_ret3 - 12) * 2.8)), CFrame_new_ret.Position + Vector3.new(1.4, 4.48, 24.64) - (CFrame_new_ret.Position + Vector3.new(3.9199999999999995, 5.04, -((v368 - 0.3 - 12) * 2.8))), math_clamp_ret * 18);
                elseif v373 and p359 < 0.85 then
                    local math_clamp_ret4 = math.clamp((p359 - 0.55) / 0.29999999999999993, 0, 1);
                    knife(u260.K3, CFrame_new_ret.Position + Vector3.new((0.5 + 3 * math_clamp_ret4) * 2.8, (1.6 + 4.4 * math_clamp_ret4) * 2.8, -((3.2 + 3.8 * math_clamp_ret4 - 12) * 2.8)), CFrame_new_ret.Position + Vector3.new(9.8, 16.8, 14) - (CFrame_new_ret.Position + Vector3.new(1.4, 4.48, 24.64)), math_clamp_ret * 22);
                end;

                local math_clamp_ret4 = math.clamp((p359 - 0.2) / 0.15999999999999998, 0, 1);
                local v375 = 1 - (1 - math.clamp(math_clamp_ret4, 0, 1)) ^ 3;
                arms(v367, 0.3 * (1 - v375), v375, 0);
                local math_clamp_ret5 = math.clamp((p359 - 0.3) / 0.12, 0, 1);
                local v376 = 1 - (1 - math.clamp(math_clamp_ret5, 0, 1)) ^ 3;
                local v377 = math.clamp((p359 - 0.3) / 0.12, 0, 1) * (1 - math.clamp((p359 - 0.88) / 0.12, 0, 1));
                local v378;

                if p359 > 0.82 then
                    local math_clamp_ret6 = math.clamp((p359 - 0.82) / 0.18000000000000005, 0, 1);
                    v378 = 1 - (1 - math.clamp(math_clamp_ret6, 0, 1)) ^ 3;
                else
                    v378 = 0;
                end;

                local v379 = v367 * CFrame.new(0, -0.25, -3.6);

                if u260.Shield and (p359 > 0.3 and p359 < 0.82) then
                    u300[u260.Shield] = true;
                    u260.Shield.part.Size = Vector3.new(1, 1, 1) * (0.6 + 2.5 * v376);
                    u260.Shield.part.CFrame = v379;
                    u260.Shield.part.Transparency = 1 - v377;
                end;

                if p359 > 0.3 and p359 < 0.82 then
                    u248.ring.Visible = true;
                    local v380 = 80 + 210 * v376;
                    u248.ring.Position = UDim2.fromOffset(640, 400);
                    u248.ring.Size = UDim2.fromOffset(v380 * 2, v380 * 2);
                    u248.ringStroke.Transparency = 1 - v377;
                end;

                if v378 > 0 then
                    for i, v in u260.Shards do
                        u300[v] = true;
                        local v381 = math.sin(i * 127.1 + 935.0999999999999) * 43758.5453;
                        local v382 = (v381 - math.floor(v381)) * 3.141592653589793 * 2;
                        local math_cos_ret = math.cos(v382);
                        local math_sin_ret = math.sin(v382);
                        local Vector3_new_ret = Vector3.new(math_cos_ret, math_sin_ret, 0);
                        local v383 = math.sin(i * 127.1 + 1246.8) * 43758.5453;
                        local v384 = Vector3_new_ret * (1.2 + v378 * (6 + (v383 - math.floor(v383)) * 6)) + Vector3.new(0, -v378 * v378 * 5, 0.5 * v378);
                        local v385 = v379 * CFrame.new(v384);
                        local CFrame_Angles = CFrame.Angles;
                        local v386 = math.sin(i * 127.1 + 1558.5) * 43758.5453;
                        v.CFrame = v385 * CFrame_Angles(v378 * 9 * (v386 - math.floor(v386)), v378 * 7, v382);
                        v.Transparency = v378;
                    end;
                end;

                local function _() -- Line: 1343
                    -- upvalues: u260 (ref), CFrame_new_ret (ref)
                    u260.Sparks.part.CFrame = CFrame.new(CFrame_new_ret.Position + Vector3.new(1.4, 4.48, 24.64));
                    u260.Sparks.emitter:Emit(45);
                end;

                if not u299.sparks and math_clamp_ret >= 8.65 then
                    u299.sparks = true;

                    if math_clamp_ret - 8.65 < 0.4 then
                        u260.Sparks.part.CFrame = CFrame.new(CFrame_new_ret.Position + Vector3.new(1.4, 4.48, 24.64));
                        u260.Sparks.emitter:Emit(45);
                    end;
                end;

                if v373 and p359 < 0.85 then
                    word(u248, "Clang", 640, 170, 150, -0.06, 1 + 0.35 * (1 - math.clamp((p359 - 0.55) / 0.09999999999999998, 0, 1)));
                end;

                local v387;

                if p359 > 0.55 then
                    v387 = p359 < 0.6;
                else
                    v387 = false;
                end;

                return v367, 0.7, 2, v387;
            end },
        { 10, 12.5, function(p388) -- Line: 1353
                -- upvalues: pov (ref), math_clamp_ret (ref), u293 (copy), u294 (copy), u295 (copy), stand (copy), gait (ref), KnifeVisibility (ref), u299 (copy), knife (copy), u260 (copy), CFrame_new_ret (ref), speedLines (ref), u248 (ref), arms (copy)
                local v389 = math.sin(p388 * 3.141592653589793 * 2) * 1.7;
                local v390 = 2 + 3.5 * p388;
                local math_sin_ret = math.sin(math_clamp_ret * 7);
                local v391 = pov(v389, math.abs(math_sin_ret) * 0.08 + 1.6, v390, -v389 * 60, 0, -math.cos(p388 * 3.141592653589793 * 2) * 0.18);

                for i, v in { u293, u294, u295 } do
                    stand(v, ({ -4, -0.5, 3 })[i], 18 + -5 * p388, v391.Position);
                    gait(v, "Walk", 0.55);

                    if v then
                        local DaggerHold = v.clips.DaggerHold;

                        if DaggerHold and DaggerHold.IsPlaying ~= true then
                            DaggerHold:Play(0.15);
                        end;

                        if v.blade and v.showBlade ~= true then
                            v.showBlade = true;
                            KnifeVisibility.set(v.blade, true);
                        end;
                    end;
                end;

                local function _() -- Line: 1362
                    -- upvalues: u294 (ref)
                    local v392 = u294;

                    if v392 then
                        v392 = v392.clips.DaggerStab;
                    end;

                    if v392 then
                        v392:Play(0.05, 1, 1.3);
                        v392.TimePosition = 0;
                    end;
                end;

                if not u299.throw4 and math_clamp_ret >= 10.05 then
                    u299.throw4 = true;

                    if math_clamp_ret - 10.05 < 0.4 then
                        local v393 = u294;

                        if v393 then
                            v393 = v393.clips.DaggerStab;
                        end;

                        if v393 then
                            v393:Play(0.05, 1, 1.3);
                            v393.TimePosition = 0;
                        end;
                    end;
                end;

                local function _() -- Line: 1365
                    -- upvalues: u295 (ref)
                    local v394 = u295;

                    if v394 then
                        v394 = v394.clips.DaggerStab;
                    end;

                    if v394 then
                        v394:Play(0.05, 1, 1.3);
                        v394.TimePosition = 0;
                    end;
                end;

                if not u299.throw5 and math_clamp_ret >= 11.05 then
                    u299.throw5 = true;

                    if math_clamp_ret - 11.05 < 0.4 then
                        local v395 = u295;

                        if v395 then
                            v395 = v395.clips.DaggerStab;
                        end;

                        if v395 then
                            v395:Play(0.05, 1, 1.3);
                            v395.TimePosition = 0;
                        end;
                    end;
                end;

                local math_clamp_ret2 = math.clamp((p388 - 0.05) / 0.4, 0, 1);
                local math_clamp_ret3 = math.clamp((p388 - 0.45) / 0.39999999999999997, 0, 1);

                if math_clamp_ret2 > 0 and math_clamp_ret2 < 1 then
                    local K4 = u260.K4;
                    local math_clamp_ret4 = math.clamp(math_clamp_ret2, 0, 1);
                    knife(K4, CFrame_new_ret.Position + Vector3.new((-0.5 + 0.5 * math_clamp_ret2) * 2.8, (1.8 + -0.19999999999999996 * math_clamp_ret2) * 2.8, -((15 + (v390 - 0.5 - 15) * (math_clamp_ret4 * math_clamp_ret4) - 12) * 2.8)), CFrame_new_ret.Position + Vector3.new(0, 4.4799999999999995, -((v390 - 12) * 2.8)) - (CFrame_new_ret.Position + Vector3.new(-1.4, 5.04, -8.4)), math_clamp_ret * 16);
                end;

                if math_clamp_ret3 > 0 and math_clamp_ret3 < 1 then
                    local K5 = u260.K5;
                    local math_clamp_ret4 = math.clamp(math_clamp_ret3, 0, 1);
                    knife(K5, CFrame_new_ret.Position + Vector3.new((3 + -3 * math_clamp_ret3) * 2.8, (1.8 + -0.19999999999999996 * math_clamp_ret3) * 2.8, -((14 + (v390 - 0.5 - 14) * (math_clamp_ret4 * math_clamp_ret4) - 12) * 2.8)), CFrame_new_ret.Position + Vector3.new(0, 4.4799999999999995, -((v390 - 12) * 2.8)) - (CFrame_new_ret.Position + Vector3.new(8.4, 5.04, -5.6)), -math_clamp_ret * 16);
                end;

                speedLines(u248, 0.85, math_clamp_ret, nil, nil, 260);
                arms(v391, 1, 0, 0);

                return v391, 0.85, 2;
            end },
        { 12.5, 15, function(p396) -- Line: 1380
                -- upvalues: pov (ref), math_clamp_ret (ref), stand (copy), u293 (copy), gait (ref), KnifeVisibility (ref), u295 (copy), u297 (copy), hold (ref), u296 (copy), CFrame_new_ret (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret3 (ref), u299 (copy), u260 (copy), workspace_CurrentCamera (copy), u248 (ref), word (ref), arms (copy), streaks (ref), u253 (ref), u302 (ref)
                local math_clamp_ret2 = math.clamp((p396 - 0) / 0.16, 0, 1);
                local v397 = 1 - (1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3);
                local math_clamp_ret3 = math.clamp((p396 - 0.86) / 0.14, 0, 1);
                local math_clamp_ret4 = math.clamp(math_clamp_ret3, 0, 1);
                local v398 = math_clamp_ret4 * math_clamp_ret4;
                local v399 = pov(-0.4, math.sin(math_clamp_ret * 6) * 0.04 + 1.6, 5, 0, 0, -0.05, 3.141592653589793 - 1.2217304763960306 * v397 + 1.2217304763960306 * v398);
                local math_clamp_ret5 = math.clamp((p396 - 0.08) / 0.47000000000000003, 0, 1);
                local v400 = 1 - (1 - math.clamp(math_clamp_ret5, 0, 1)) ^ 3;
                local v401 = p396 >= 0.55;
                local math_clamp_ret6 = math.clamp((p396 - 0.55) / 0.29999999999999993, 0, 1);
                local v402 = -3.4 + 2.8 * v400 + math_clamp_ret6 * 0.4;
                local v403 = 19 + -5.5 * v400 - math_clamp_ret6 * 0.6;

                local function behind(p404) -- Line: 1389
                    return 5 - (p404 - 5) * 0.75;
                end;

                stand(u293, 2.5, -6.25, v399.Position);
                gait(u293, "Idle");
                local v405 = u293;

                if v405 then
                    local DaggerHold = v405.clips.DaggerHold;

                    if DaggerHold and DaggerHold.IsPlaying ~= true then
                        DaggerHold:Play(0.15);
                    end;

                    if v405.blade and v405.showBlade ~= true then
                        v405.showBlade = true;
                        KnifeVisibility.set(v405.blade, true);
                    end;
                end;

                stand(u295, 4.2, -7, v399.Position);
                gait(u295, "Idle");
                local v406 = u295;

                if v406 then
                    local DaggerHold = v406.clips.DaggerHold;

                    if DaggerHold and DaggerHold.IsPlaying ~= true then
                        DaggerHold:Play(0.15);
                    end;

                    if v406.blade and v406.showBlade ~= true then
                        v406.showBlade = true;
                        KnifeVisibility.set(v406.blade, true);
                    end;
                end;

                stand(u297, v402, 5 - (v403 - 5) * 0.75, v399.Position);
                gait(u297, v401 and "Idle" or "Run", 0.9);
                local v407;

                if v401 then
                    v407 = p396 > 0.6;
                else
                    v407 = v401;
                end;

                hold(u297, v407);
                stand(u296, -6.5 + (v402 - 1.3 - -6.5) * v400, 5 - (22 + (v403 + 0.5 - 22) * v400 - 5) * 0.75, CFrame_new_ret.Position + Vector3.new(v402 * 2.8, 0, -((5 - (v403 - 5) * 0.75 - 12) * 2.8)));
                gait(u296, v401 and "Idle" or "Run", 1);
                local v408 = u296;

                if v408 then
                    local DaggerHold = v408.clips.DaggerHold;

                    if DaggerHold and DaggerHold.IsPlaying ~= true then
                        DaggerHold:Play(0.15);
                    end;

                    if v408.blade and v408.showBlade ~= true then
                        v408.showBlade = true;
                        KnifeVisibility.set(v408.blade, true);
                    end;
                end;

                if u297 and u297.outline and u297.outline.OutlineColor == Color3_fromRGB_ret2 ~= v401 then
                    local v409;

                    if v401 then
                        v409 = Color3_fromRGB_ret2;
                    else
                        v409 = Color3_fromRGB_ret3;
                    end;

                    u297.outline.OutlineColor = v409;
                end;

                local function _() -- Line: 1407
                    -- upvalues: u296 (ref)
                    local v410 = u296;

                    if v410 then
                        v410 = v410.clips.DaggerStab;
                    end;

                    if v410 then
                        v410:Play(0.05, 1, 1.3);
                        v410.TimePosition = 0;
                    end;
                end;

                if not u299.tag and math_clamp_ret >= 13.8 then
                    u299.tag = true;

                    if math_clamp_ret - 13.8 < 0.4 then
                        local v411 = u296;

                        if v411 then
                            v411 = v411.clips.DaggerStab;
                        end;

                        if v411 then
                            v411:Play(0.05, 1, 1.3);
                            v411.TimePosition = 0;
                        end;
                    end;
                end;

                local function _() -- Line: 1410
                    -- upvalues: u297 (ref), u260 (ref)
                    if u297 then
                        u260.Tag.part.CFrame = u297.root.CFrame;
                        u260.Tag.emitter:Emit(40);
                    end;
                end;

                if not u299.flip and math_clamp_ret >= 13.875 then
                    u299.flip = true;

                    if math_clamp_ret - 13.875 < 0.4 and u297 then
                        u260.Tag.part.CFrame = u297.root.CFrame;
                        u260.Tag.emitter:Emit(40);
                    end;
                end;

                if v401 and (p396 < 0.9 and u297) then
                    local v412, v413 = workspace_CurrentCamera:WorldToViewportPoint(u297.root.Position + Vector3.new(0, 3.2, 0));
                    local ViewportSize = workspace_CurrentCamera.ViewportSize;
                    local Scale = u248.scale.Scale;
                    local v414 = 640 + (v412.X - ViewportSize.X / 2) / Scale;
                    local v415 = 360 + (v412.Y - ViewportSize.Y / 2) / Scale;

                    if v413 then
                        v413 = v412.Z > 0;
                    end;

                    if v413 then
                        word(u248, "Caught", v414, v415 - 40, 110, 0.08, 1 + 0.35 * (1 - math.clamp((p396 - 0.55) / 0.10999999999999999, 0, 1)));
                    end;
                end;

                arms(v399, 0.15, 0, 0);
                streaks(u248, v397 + v398, math_clamp_ret);
                u248.dark.BackgroundTransparency = 1 - 0.7 * (v397 + v398);
                u253.blur.Size = 18 * (v397 + v398);
                u302 = v401;
                local v416;

                if p396 > 0.55 then
                    v416 = p396 < 0.58;
                else
                    v416 = false;
                end;

                return v399, 1, v401 and 1 or 2, v416;
            end },
        { 15, 17.5, function(p417) -- Line: 1430
                -- upvalues: pov (ref), math_clamp_ret (ref)
                local math_clamp_ret2 = math.clamp((p417 - 0) / 0.14, 0, 1);
                local v418 = 1 - (1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3);

                return pov(0, math.sin(math_clamp_ret * 2) * 0.02 + 1.6, 5.5, 0, 0, math.sin(math_clamp_ret * 1.5) * 0.02, -1.2217304763960306 * v418), 1, 1, false, v418;
            end },
        { 17.5, 19.5, function(p419) -- Line: 1436
                -- upvalues: pov (ref), u300 (copy), u260 (copy), streaks (ref), u248 (ref), math_clamp_ret (ref), speedLines (ref), word (ref)
                local math_clamp_ret2 = math.clamp((p419 - 0.55) / 0.16999999999999993, 0, 1);
                local v420 = 1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3;
                local v421 = pov(0 + 2.4 * v420, 1.6, 5.5 + -0.7000000000000002 * v420, 0 + 260 * v420, -110 * v420, -0.38 * v420 + 0.02);
                local math_clamp_ret3 = math.clamp((p419 - 0) / 0.5, 0, 1);

                if p419 < 0.55 then
                    local math_clamp_ret4 = math.clamp((p419 - 0.5) / 0.050000000000000044, 0, 1);
                    local v422 = 1500 + -860 * (1 - (1 - math.clamp(math_clamp_ret3, 0, 1)) ^ 3);
                    local v423 = 120 + 260 * (1 - (1 - math.clamp(math_clamp_ret3, 0, 1)) ^ 3);
                    local math_clamp_ret5 = math.clamp(math_clamp_ret3, 0, 1);
                    local v424 = (Vector3.new((v422 - 640) / 694.4000000000001, -(v423 - 360) / 694.4000000000001, -1) * (1874.8800000000003 / (60 + 700 * (math_clamp_ret5 * math_clamp_ret5)))):Lerp(Vector3.new(0, -0.55, 0.1), math_clamp_ret4);
                    u300[u260.Loop] = true;
                    u260.Loop.Size = Vector3.new(0.6, 6, 6);
                    u260.Knot.Position = Vector3.new(0, -2.7, 0);
                    u260.Loop.CFrame = v421 * CFrame.new(v424) * CFrame.Angles(math.rad(33 + -33 * math_clamp_ret4), 0, -0.2 * (1 - math_clamp_ret4)) * CFrame.Angles(0, 0, 1.5707963267948966);
                    u260.Rope.CurveSize0 = 3;
                    streaks(u248, 0.4 * math_clamp_ret3, math_clamp_ret);
                else
                    u300[u260.Loop] = true;
                    local v425 = 6 + -2.4 * math.clamp((p419 - 0.55) / 0.06999999999999995, 0, 1);
                    u260.Loop.Size = Vector3.new(0.6, v425, v425);
                    u260.Knot.Position = Vector3.new(0, -v425 * 0.45, 0);
                    u260.Loop.CFrame = v421 * CFrame.new(0, -0.55, 0.1) * CFrame.Angles(0, 0, 1.5707963267948966);
                    u260.Rope.CurveSize0 = 3 + -3 * v420;
                    u248.red.BackgroundTransparency = 1 - 0.3 * (1 - math.clamp((p419 - 0.7) / 0.30000000000000004, 0, 1));
                    speedLines(u248, 1 - math.clamp((p419 - 0.7) / 0.30000000000000004, 0, 1), math_clamp_ret);
                    word(u248, "Snag", 700, 220, 150, -0.1, 1 + 0.4 * (1 - math.clamp((p419 - 0.55) / 0.10999999999999999, 0, 1)));
                end;

                u260.Rope.Enabled = true;
                local v426;

                if p419 > 0.55 then
                    v426 = p419 < 0.6;
                else
                    v426 = false;
                end;

                return v421, 1, 1, v426, 0, v420;
            end },
        { 19.5, 20.5, function(p427) -- Line: 1469
                -- upvalues: CFrame_new_ret (ref), u253 (ref), streaks (ref), u248 (ref), math_clamp_ret (ref)
                local math_clamp_ret2 = math.clamp(p427, 0, 1);
                local v428;

                if math_clamp_ret2 < 0.5 then
                    v428 = 4 * math_clamp_ret2 ^ 3;
                else
                    v428 = 1 - (-2 * math_clamp_ret2 + 2) ^ 3 / 2;
                end;

                local v429 = CFrame.new(CFrame_new_ret.Position + Vector3.new(6.72, 4.48, 20.16)) * CFrame.Angles(0, 0.39707944522498234 + -1.967875772019879 * v428, 0) * CFrame.Angles(0, 0, -0.38 * (1 - p427));
                local math_min_ret = math.min(1, p427 + 0.02);
                local math_clamp_ret3 = math.clamp(math_min_ret, 0, 1);
                local v430;

                if math_clamp_ret3 < 0.5 then
                    v430 = 4 * math_clamp_ret3 ^ 3;
                else
                    v430 = 1 - (-2 * math_clamp_ret3 + 2) ^ 3 / 2;
                end;

                local v431 = math.abs(v430 - v428) / 0.02;
                u253.blur.Size = math.min(28, v431 * 12);
                streaks(u248, 1, math_clamp_ret);
                u248.dark.BackgroundColor3 = Color3.fromRGB(10, 6, 10);
                u248.dark.BackgroundTransparency = 1 - 0.6 * math.clamp((p427 - 0.75) / 0.25, 0, 1);

                return v429, 1, nil;
            end },
        { 20.5, 23.5, function(p432) -- Line: 1481
                return nil, 0.9, nil, false, p432;
            end },
        { 23.5, 26, function(p433) -- Line: 1485
                local v434;

                if p433 > 0.35 then
                    v434 = p433 < 0.42;
                else
                    v434 = false;
                end;

                return nil, 0.9, nil, v434, 1, p433;
            end },
        { 26, 30, function(p435) -- Line: 1489
                -- upvalues: u248 (ref)
                u248.black.BackgroundTransparency = 0;
                local math_clamp_ret2 = math.clamp((p435 - 0.1) / 0.19999999999999998, 0, 1);
                u248.title[1].TextTransparency = 1 - math_clamp_ret2;
                u248.title[2].TextTransparency = 1 - math_clamp_ret2;
                u248.title[3].TextTransparency = 1 - math.clamp((p435 - 0.5) / 0.15000000000000002, 0, 1);
                u248.title[4].TextTransparency = 1 - math.clamp((p435 - 0.65) / 0.15000000000000002, 0, 1);

                return nil, 0, nil;
            end }
    };

    local function showboat(p437, p438) -- Line: 1500
        -- upvalues: u293 (copy), u294 (copy), u295 (copy), stand (copy), gait (ref), KnifeVisibility (ref), math_clamp_ret (ref), u296 (copy), u297 (copy), u3 (ref), Color3_fromRGB_ret2 (ref), arms (copy)
        for i, v in { u293, u294, u295 } do
            stand(v, ({ -4.5, -2.6, 3.6 })[i], 17, p437.Position);
            gait(v, "Idle");

            if v then
                local DaggerHold = v.clips.DaggerHold;

                if DaggerHold and DaggerHold.IsPlaying ~= true then
                    DaggerHold:Play(0.15);
                end;

                if v.blade and v.showBlade ~= true then
                    v.showBlade = true;
                    KnifeVisibility.set(v.blade, true);
                end;
            end;
        end;

        local v439 = math.floor(math_clamp_ret / 0.46875) / 2;
        local v440 = math.floor(v439) % 3;

        for i, v in { u296, u297 } do
            if v then
                stand(v, i == 1 and -1.5 or 1.5, 12.5, p437.Position);
                gait(v, "Emote:" .. u3[v440 + 1]);

                if v then
                    local DaggerHold = v.clips.DaggerHold;

                    if DaggerHold and DaggerHold.IsPlaying ~= false then
                        DaggerHold:Stop(0.15);
                    end;

                    if v.blade and v.showBlade ~= false then
                        v.showBlade = false;
                        KnifeVisibility.set(v.blade, false);
                    end;
                end;

                if v.outline and v.outline.OutlineColor ~= Color3_fromRGB_ret2 then
                    v.outline.OutlineColor = Color3_fromRGB_ret2;
                end;

                if v.board then
                    v.board.Enabled = true;
                    v.bubble.Visible = v440 == 2;
                    local v441 = i;

                    for i2, v2 in v.notes do
                        local v442 = (math_clamp_ret * 0.8 + i2 / 3 + (v441 == 2 and 0.5 or 0)) % 1;
                        v2.Position = UDim2.fromScale(0.5 + (v441 == 1 and -1 or 1) * (0.28 + i2 * 0.05) + math.sin(v442 * 6 + i2) * 0.05, 0.75 - v442 * 0.6);
                        v2.TextTransparency = v442;
                    end;
                end;
            end;
        end;

        arms(p437, p438 > 0 and 0 or 0.1, 0, p438);
    end;

    local u443 = CFrame.new(CFrame_new_ret.Position + Vector3.new(6.72, 4.48, 20.16)) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(0, 0, 0.04);

    local function face(p444, p445, p446) -- Line: 1532
        -- upvalues: u443 (copy), u298 (copy), u300 (copy), CFrame_new_ret (ref), gait (ref), hold (ref), u299 (copy), math_clamp_ret (ref), u260 (copy), knife (copy), workspace_CurrentCamera (copy), u248 (ref), speedLines (ref)
        local v447 = u443;

        if u298 then
            local Position = (v447 * CFrame.new(0, -1.45, -2.7)).Position;
            u300[u298] = true;
            local Vector3_new_ret = Vector3.new(Position.X, CFrame_new_ret.Y + u298.lift, Position.Z);
            u298.model:PivotTo(CFrame.lookAt(Vector3_new_ret, (Vector3.new(v447.Position.X, Vector3_new_ret.Y, v447.Position.Z))));
            gait(u298, "Idle");
            hold(u298, p445 == nil and true or p445 <= 0.02);

            local function _() -- Line: 1541
                -- upvalues: u298 (ref)
                local v448 = u298;

                if v448 then
                    v448 = v448.clips.DaggerWindup;
                end;

                if v448 then
                    v448:Play(0.05, 1, 1);
                    v448.TimePosition = 0;
                end;
            end;

            if not u299.windup and math_clamp_ret >= 20.4 then
                u299.windup = true;

                if math_clamp_ret - 20.4 < 0.4 then
                    local v449 = u298;

                    if v449 then
                        v449 = v449.clips.DaggerWindup;
                    end;

                    if v449 then
                        v449:Play(0.05, 1, 1);
                        v449.TimePosition = 0;
                    end;
                end;
            end;

            local DaggerWindup = u298.clips.DaggerWindup;

            if DaggerWindup and (DaggerWindup.IsPlaying and (DaggerWindup.Length > 0 and (DaggerWindup.TimePosition >= DaggerWindup.Length - 0.05 and DaggerWindup.Speed ~= 0))) then
                DaggerWindup:AdjustSpeed(0);
            end;

            if p445 then
                local function _() -- Line: 1549
                    -- upvalues: DaggerWindup (copy), u298 (ref)
                    if DaggerWindup then
                        DaggerWindup:Stop(0.05);
                    end;

                    local v450 = u298;

                    if v450 then
                        v450 = v450.clips.DaggerStab;
                    end;

                    if v450 then
                        v450:Play(0.05, 1, 1.2);
                        v450.TimePosition = 0;
                    end;
                end;

                if not u299.plunge and math_clamp_ret >= 23.45 then
                    u299.plunge = true;

                    if math_clamp_ret - 23.45 < 0.4 then
                        if DaggerWindup then
                            DaggerWindup:Stop(0.05);
                        end;

                        local v451 = u298;

                        if v451 then
                            v451 = v451.clips.DaggerStab;
                        end;

                        if v451 then
                            v451:Play(0.05, 1, 1.2);
                            v451.TimePosition = 0;
                        end;
                    end;
                end;

                local math_clamp_ret2 = math.clamp((p445 - 0) / 0.35, 0, 1);

                if math_clamp_ret2 > 0 and (math_clamp_ret2 < 1 and u260.Plunge) then
                    local v452;

                    if u298.blade then
                        v452 = u298.blade.Position;
                    else
                        v452 = u298.root.Position;
                    end;

                    local Position2 = (v447 * CFrame.new(0, 0, -0.4)).Position;
                    local Plunge = u260.Plunge;
                    local v453 = v452:Lerp(Position2, 1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3);
                    local math_clamp_ret3 = math.clamp(math_clamp_ret2, 0, 1);
                    knife(Plunge, v453, Position2 - v452, -0.05, 1 + 2.5 * (math_clamp_ret3 * math_clamp_ret3));
                end;
            end;

            local v454;

            if p445 or p446 then
                v454 = 0;
            elseif p444 < 0.7 then
                v454 = math.clamp((p444 - 0.6) / 0.09999999999999998, 0, 1);
            else
                v454 = 1 - math.clamp((p444 - 0.7) / 0.10000000000000009, 0, 1);
            end;

            if v454 > 0 and u298.eye then
                local v455, v456 = workspace_CurrentCamera:WorldToViewportPoint((u298.eye.CFrame * CFrame.new(0.26, 0, 0)).Position);
                local ViewportSize = workspace_CurrentCamera.ViewportSize;
                local Scale = u248.scale.Scale;
                local v457 = 640 + (v455.X - ViewportSize.X / 2) / Scale;
                local v458 = 360 + (v455.Y - ViewportSize.Y / 2) / Scale;

                if v456 then
                    v456 = v455.Z > 0;
                end;

                u248.glint.Visible = v456;
                u248.glint.Position = UDim2.fromOffset(v457, v458);
                u248.glintScale.Scale = v454;
            end;
        end;

        if p446 then
            return v447;
        end;

        speedLines(u248, 1, math_clamp_ret, Color3.fromRGB(255, 74, 61), 0.55, 330);
        u248.shadow.BackgroundTransparency = 0.35;

        if p445 then
            local black = u248.black;
            local math_clamp_ret2 = math.clamp((p445 - 0.42) / 0.5800000000000001, 0, 1);
            black.BackgroundTransparency = 1 - (1 - (1 - math.clamp(math_clamp_ret2, 0, 1)) ^ 3);
        end;

        return v447;
    end;

    local function render() -- Line: 1582
        -- upvalues: u300 (copy), u248 (ref), u260 (copy), u253 (ref), u436 (ref), math_clamp_ret (ref), streaks (ref), showboat (copy), face (copy), u443 (copy), workspace_CurrentCamera (copy), u257 (ref), cheer (ref), u254 (copy), os_clock_ret (ref), u259 (copy), u301 (copy), CFrame_new_ret3 (copy), u258 (ref), placeRing (ref), soundCues (copy)
        table.clear(u300);

        for _, v in u248.words do
            v.shown = false;
        end;

        for _, v in u260 do
            if type(v) == "table" and v.trail then
                v.wasShown = v.shown;
                v.shown = false;
            end;
        end;

        u248.ring.Visible = false;
        u248.glint.Visible = false;
        u248.dark.BackgroundTransparency = 1;
        u248.dark.BackgroundColor3 = Color3.fromRGB(29, 32, 41);
        u248.red.BackgroundTransparency = 1;
        u248.shadow.BackgroundTransparency = 1;
        u260.Rope.Enabled = false;
        u253.blur.Size = 0;
        local v459 = u436[#u436];

        for _, v in u436 do
            if math_clamp_ret >= v[1] and math_clamp_ret < v[2] then
                v459 = v;
                break;
            end;
        end;

        local v460, v461, v462, v463, v464, v465 = v459[3]((math_clamp_ret - v459[1]) / (v459[2] - v459[1]));
        local v466 = 55;

        if v459 == u436[7] or v459 == u436[8] then
            if v459 == u436[7] then
                streaks(u248, v464, math_clamp_ret);
                u248.dark.BackgroundTransparency = 1 - 0.7 * v464;
                u253.blur.Size = 18 * v464;
            end;

            showboat(v460, v465 or 0);
        elseif v459 == u436[10] then
            v460 = face(v464, nil);
            v466 = 55 / (1 + 0.1 * v464);
        elseif v459 == u436[11] then
            v460 = face(1, v465);
            v466 = 49.99999999999999;
        elseif v459 == u436[12] then
            v460 = u443;
        end;

        if v459 == u436[9] then
            face(0, nil, true);
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        workspace_CurrentCamera.CFrame = v460;
        workspace_CurrentCamera.FieldOfView = v466;

        if u257 then
            cheer(u257, math_clamp_ret, v461);
        end;

        local Crowd = u254.Crowd;

        if Crowd then
            Crowd.Volume = Crowd:GetAttribute("Volume") * (0.55 + 0.45 * v461);
        end;

        u248.hud.Visible = v462 ~= nil;

        if v462 then
            local v467 = "RUNNERS LEFT: " .. v462;

            if u248.hudText.Text ~= v467 then
                u248.hudText.Text = v467;
            end;
        end;

        u253.impact.Enabled = v463 == true;
        u248.flash.BackgroundTransparency = v463 == true and 0.65 or 1;

        if v459 ~= u436[12] then
            for _, v in u248.title do
                v.TextTransparency = 1;
            end;

            if v459 ~= u436[11] then
                local black = u248.black;
                local v468 = (os.clock() - os_clock_ret - 0) / 0.4;
                black.BackgroundTransparency = math.clamp(v468, 0, 1);
            end;
        end;

        if not u248.linesDrawn then
            for _, v in u248.lines do
                v.Visible = false;
            end;

            u248.linesKey = nil;
        end;

        u248.linesDrawn = false;

        if not u248.streaksDrawn then
            for _, v in u248.streaks do
                v.Visible = false;
            end;

            u248.streaksKey = nil;
        end;

        u248.streaksDrawn = false;

        for _, v in u248.words do
            if not v.shown then
                v.label.Visible = false;
            end;
        end;

        for _, v in u259 do
            if not (u300[v] or u301[v]) then
                u301[v] = true;
                v.model:PivotTo(CFrame_new_ret3);

                if v.board then
                    v.board.Enabled = false;
                end;
            end;
        end;

        if u258 and not (u300[u258] or u301[u258]) then
            u301[u258] = true;
            u258.model:PivotTo(CFrame_new_ret3);
        end;

        for _, v in u260 do
            if type(v) == "table" and (v.trail and (not v.shown and v.wasShown)) then
                v.trail.Enabled = false;
                v.part.CFrame = CFrame_new_ret3;
            end;
        end;

        if u260.Shield and not u300[u260.Shield] then
            u260.Shield.part.CFrame = CFrame_new_ret3;
        end;

        for _, v in u260.Shards do
            if not u300[v] then
                v.CFrame = CFrame_new_ret3;
            end;
        end;

        if u300[u260.Loop] then
            placeRing(u260.LoopParts, u260.Loop.CFrame, u260.Loop.Size.Y);
            u301.loop = nil;
        elseif not u301.loop then
            u301.loop = true;
            u260.Loop.CFrame = CFrame_new_ret3;
            placeRing(u260.LoopParts, CFrame_new_ret3, 6);
        end;

        soundCues();
    end;

    local u469 = speedLines;
    local u470 = streaks;

    speedLines = function(...) -- Line: 1720
        -- upvalues: u248 (ref), u469 (copy)
        u248.linesDrawn = true;
        u469(...);
    end;

    streaks = function(...) -- Line: 1724
        -- upvalues: u248 (ref), u470 (copy)
        u248.streaksDrawn = true;
        u470(...);
    end;

    syncSounds();
    os_clock_ret = os.clock();
    RunService:BindToRenderStep("CupTrailer", Enum.RenderPriority.Camera.Value + 1, function(p471) -- Line: 1731
        -- upvalues: u244 (ref), math_clamp_ret (ref), u299 (copy), syncSounds (copy), cleanup (copy), render (copy)
        if u244.seek then
            math_clamp_ret = math.clamp(u244.seek, 0, 29.99);
            u244.seek = nil;
            table.clear(u299);
            syncSounds();
        end;

        math_clamp_ret = math_clamp_ret + math.min(p471, 0.1) * u244.speed;

        if math_clamp_ret >= 30 then
            cleanup();

            return;
        end;

        local success2, result2 = pcall(render);

        if not success2 then
            warn("Cup trailer stopped:", result2);
            cleanup();
        end;
    end);
    u244.stop = cleanup;

    while not u255 do
        task.wait(0.25);
    end;

    speedLines = u469;
    streaks = u470;
    u244.stop = nil;
end;

LocalPlayer:GetAttributeChangedSignal("CupTrailerRequested"):Connect(function() -- Line: 1759
    -- upvalues: u243 (ref), u244 (copy), play (copy), LocalPlayer (copy)
    if not u243 then
        u244.speed = 1;
        task.spawn(play, tonumber(LocalPlayer:GetAttribute("CupTrailerFrom")) or 0);
    end;
end);

if RunService:IsStudio() then
    local BindableFunction = Instance.new("BindableFunction");
    BindableFunction.Name = "CupTrailerDebug";

    function BindableFunction.OnInvoke(p472, p473) -- Line: 1768
        -- upvalues: u243 (ref), u244 (copy), play (copy)
        if p472 == "play" and not u243 then
            u244.speed = 1;
            task.spawn(play, tonumber(p473) or 0);
        elseif p472 == "seek" and type(p473) == "number" then
            u244.seek = p473;
        elseif p472 == "speed" and type(p473) == "number" then
            u244.speed = p473;
        elseif p472 == "stop" and u244.stop then
            u244.stop();
        end;

        return u243;
    end;

    BindableFunction.Parent = LocalPlayer;
end;