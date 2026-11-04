 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("ContentProvider");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local CombineConfig = require(Weapons:WaitForChild("CombineConfig"));
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local KnifeIconCopy = require(Weapons:WaitForChild("KnifeIconCopy"));
local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local CombineScreen = require(Presentation:WaitForChild("CombineScreen"));
local v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("MapLocator")).interactables(10);
local MergeMachine = v1:WaitForChild("MergeMachine", 60);

if not MergeMachine then
    warn("MergeMachineClient: no MergeMachine in " .. v1:GetFullName() .. " after 60 s; waiting for it");
    MergeMachine = v1:WaitForChild("MergeMachine", (1 / 0));
end;

local Center = MergeMachine:WaitForChild("Center");
local ProximityPrompt = Center:WaitForChild("ProximityPrompt");
ProximityPrompt.ObjectText = "Combine Machine";
ProximityPrompt.ActionText = "Combine";
local Sign = MergeMachine:FindFirstChild("Sign");

if Sign and Sign:IsA("BillboardGui") then
    Sign.Enabled = false;
end;

local Base_Obsidian = MergeMachine:WaitForChild("Base_Obsidian");
local MergeFXLibrary = game.ReplicatedStorage:WaitForChild("MergeFXLibrary");
local LocalPlayer = Players.LocalPlayer;
local CFrame2 = Center.CFrame;
local u2 = Base_Obsidian.Size.X / 13.7132;
local Color3_fromRGB_ret = Color3.fromRGB(180, 65, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(115, 245, 255);
local Color3_fromRGB_ret3 = Color3.fromRGB(245, 230, 255);
local u3 = 3.1 * u2;
local u4 = 4.6 * u2;
local Folder = Instance.new("Folder");
Folder.Name = "MergeMachine_LocalFX";
Folder.Parent = workspace;

local function tween(p5, p6, p7, p8) -- Line: 74
    -- upvalues: TweenService (copy)
    local v9 = TweenService:Create(p5, TweenInfo.new(p6, p8 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p7);
    v9:Play();

    return v9;
end;

local function part(p10, p11, p12, p13) -- Line: 79
    -- upvalues: Color3_fromRGB_ret (copy), Folder (copy)
    local Part = Instance.new("Part");
    Part.Name = p10;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = p13 or Color3_fromRGB_ret;
    Part.Size = p12;
    Part.CFrame = p11;
    Part.CastShadow = false;
    Part.Parent = Folder;

    return Part;
end;

local Part = Instance.new("Part");
Part.Name = "Convergence";
Part.Anchored = true;
Part.CanCollide = false;
Part.CanTouch = false;
Part.CanQuery = false;
Part.Material = Enum.Material.Neon;
Part.Color = Color3_fromRGB_ret3 or Color3_fromRGB_ret;
Part.Size = Vector3.new(0.05, 0.05, 0.05);
Part.CFrame = CFrame2;
Part.CastShadow = false;
Part.Parent = Folder;
Part.Transparency = 1;
local Attachment = Instance.new("Attachment", Part);
local PointLight = Instance.new("PointLight", Part);
PointLight.Color = Color3_fromRGB_ret;
PointLight.Brightness = 0.5;
PointLight.Range = 15 * u2;
PointLight.Shadows = false;

local function emitter(p14, p15) -- Line: 90
    -- upvalues: MergeFXLibrary (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), u2 (copy)
    local v16 = MergeFXLibrary:FindFirstChild(p14);
    local v17 = v16 and v16:Clone() or Instance.new("ParticleEmitter");
    v17.Name = p14;
    v17.Enabled = false;
    v17.Rate = 0;
    v17.LightEmission = 1;
    v17.LightInfluence = 0;
    v17.Color = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret);
    v17.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.65, 0.15), NumberSequenceKeypoint.new(1, 1) });
    v17.Lifetime = NumberRange.new(0.35, 0.8);
    v17.Speed = NumberRange.new(4, 12);
    v17.SpreadAngle = Vector2.new(180, 180);
    v17.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15 * u2), NumberSequenceKeypoint.new(0.2, 0.45 * u2), NumberSequenceKeypoint.new(1, 0) });
    v17.Rotation = NumberRange.new(-180, 180);
    v17.RotSpeed = NumberRange.new(-90, 90);
    v17.Parent = p15;

    return v17;
end;

local u18 = emitter("Sparks", Attachment);
local u19 = emitter("Shine", Attachment);
u19.Speed = NumberRange.new(0);
u19.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.12, 8 * u2), NumberSequenceKeypoint.new(1, 0) });
u19.Lifetime = NumberRange.new(0.45, 0.7);
local u20 = emitter("Flash", Attachment);
u20.Speed = NumberRange.new(0);
u20.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, 15 * u2), NumberSequenceKeypoint.new(1, 0) });
u20.Lifetime = NumberRange.new(0.3, 0.5);
local u21 = emitter("Sparks", Attachment);
u21.Speed = NumberRange.new(0.4, 1.6);
u21.Lifetime = NumberRange.new(0.5, 1.2);
u21.Rate = 18;
u21.Enabled = true;
local u22 = {};

for i, v in {
    Charge = "rbxassetid://5696557721",
    Impact = "rbxassetid://118074575456339",
    Add = "rbxassetid://6435645749",
    Hum = "rbxassetid://6435646111"
} do
    local Sound = Instance.new("Sound");
    Sound.Name = i;
    Sound.SoundId = v;
    Sound.Volume = i == "Impact" and 0.5 or 0.26;
    Sound.RollOffMinDistance = 8;
    Sound.RollOffMaxDistance = 100;
    Sound.Parent = Part;
    u22[i] = Sound;
end;

u22.Hum.Looped = true;
u22.Hum.Volume = 0.06;

local function sound(p23, p24) -- Line: 119
    -- upvalues: u22 (copy)
    local v25 = u22[p23];
    v25.PlaybackSpeed = p24 or 1;
    v25.TimePosition = 0;
    v25:Play();
end;

local function ring(u26, u27, p28, u29) -- Line: 124
    -- upvalues: Folder (copy), Color3_fromRGB_ret (copy), RunService (copy), u2 (copy)
    local Folder2 = Instance.new("Folder");
    Folder2.Name = "Shockwave";
    Folder2.Parent = Folder;
    local u30 = {};

    for i = 1, 40 do
        local Part2 = Instance.new("Part");
        Part2.Name = "Arc";
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanTouch = false;
        Part2.CanQuery = false;
        Part2.Material = Enum.Material.Neon;
        Part2.Color = p28 or Color3_fromRGB_ret;
        Part2.Size = Vector3.new(0.07, 0.07, 1);
        Part2.CFrame = u26;
        Part2.CastShadow = false;
        Part2.Parent = Folder;
        Part2.Parent = Folder2;
        u30[i] = Part2;
        local _ = i;
    end;

    local os_clock_ret = os.clock();
    local u31 = nil;
    u31 = RunService.RenderStepped:Connect(function() -- Line: 131
        -- upvalues: os_clock_ret (copy), u29 (copy), u27 (copy), u30 (copy), u26 (copy), u2 (ref), Folder2 (copy), u31 (ref)
        local v32 = (os.clock() - os_clock_ret) / u29;
        local math_clamp_ret = math.clamp(v32, 0, 1);
        local v33 = u27 * ((1 - (1 - math_clamp_ret) ^ 3) * 0.85 + 0.15);

        for i, v in u30 do
            v.CFrame = u26 * CFrame.Angles(0, i / 40 * 3.141592653589793 * 2, 0) * CFrame.new(v33, 0, 0);
            v.Size = Vector3.new(0.11 * u2 * (1 - math_clamp_ret) + 0.01, 0.11 * u2 * (1 - math_clamp_ret) + 0.01, v33 * 3.141592653589793 * 2 / 40 * 1.12);
            v.Transparency = math_clamp_ret;
        end;

        if math_clamp_ret >= 1 or not Folder2.Parent then
            u31:Disconnect();
            Folder2:Destroy();
        end;
    end);
end;

local u34 = Color3_fromRGB_ret;
local u35 = Color3_fromRGB_ret2;

local function burst(p36) -- Line: 145
    -- upvalues: u18 (copy), u19 (copy), Part (copy), u2 (copy), u35 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), Folder (copy), TweenService (copy), Debris (copy)
    u18:Emit(p36);
    u19:Emit(2);

    for i = 1, 16 do
        local v37 = math.random() - 0.5;
        local v38 = math.random() - 0.5;
        local v39 = math.random() - 0.5;
        local Unit = Vector3.new(v37, v38, v39).Unit;
        local CFrame_lookAt_ret = CFrame.lookAt(Part.Position, Part.Position + Unit);
        local Part2 = Instance.new("Part");
        Part2.Name = "ImpactStreak";
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanTouch = false;
        Part2.CanQuery = false;
        Part2.Material = Enum.Material.Neon;
        Part2.Color = i % 2 == 0 and u35 or Color3_fromRGB_ret3 or Color3_fromRGB_ret;
        Part2.Size = Vector3.new(0.05, 0.05, 1.3) * u2;
        Part2.CFrame = CFrame_lookAt_ret;
        Part2.CastShadow = false;
        Part2.Parent = Folder;
        local v40 = {
            Transparency = 1,
            Size = Vector3.new(0.015, 0.015, 0.1),
            CFrame = Part2.CFrame + Unit * (5 + math.random() * 5) * u2
        };
        TweenService:Create(Part2, TweenInfo.new(0.42, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v40):Play();
        Debris:AddItem(Part2, 0.5);
        local _ = i;
    end;
end;

local Part2 = Instance.new("Part");
Part2.Name = "EnergyCore";
Part2.Anchored = true;
Part2.CanCollide = false;
Part2.CanTouch = false;
Part2.CanQuery = false;
Part2.Material = Enum.Material.Neon;
Part2.Color = Color3_fromRGB_ret3 or Color3_fromRGB_ret;
Part2.Size = Vector3.new(0.1, 0.1, 0.1);
Part2.CFrame = CFrame2;
Part2.CastShadow = false;
Part2.Parent = Folder;
Part2.Shape = Enum.PartType.Ball;
Part2.Transparency = 1;
local Highlight = Instance.new("Highlight");
Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
Highlight.FillColor = Color3_fromRGB_ret;
Highlight.OutlineColor = Color3_fromRGB_ret3;
Highlight.FillTransparency = 1;
Highlight.OutlineTransparency = 0.7;
Highlight.Parent = Folder;
local BillboardGui = Instance.new("BillboardGui");
BillboardGui.Name = "MergeResult";
BillboardGui.Adornee = Part;
BillboardGui.Size = UDim2.fromScale(8 * u2, 2.6 * u2);
BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, u4 * 0.5 + 1.6 * u2, 0);
BillboardGui.AlwaysOnTop = true;
BillboardGui.LightInfluence = 0;
BillboardGui.MaxDistance = 90;
BillboardGui.Enabled = false;
BillboardGui:SetAttribute("SelfManagedText", true);
local UIScale = Instance.new("UIScale");
UIScale.Parent = BillboardGui;
local ImageLabel = Instance.new("ImageLabel");
ImageLabel.Name = "Glow";
ImageLabel.BackgroundTransparency = 1;
ImageLabel.Image = "rbxassetid://129028976496842";
ImageLabel.ImageTransparency = 0.35;
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
ImageLabel.Size = UDim2.fromScale(2.2, 2.2);
ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY;
ImageLabel.Parent = BillboardGui;

local function boardLabel(p41, p42, p43, p44, p45) -- Line: 173
    -- upvalues: BillboardGui (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p41;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel.Position = UDim2.fromScale(0.5, p42);
    TextLabel.Size = UDim2.fromScale(1, p43);
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", p44);
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.ZIndex = 2;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = p45;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = TextLabel;
    TextLabel.Parent = BillboardGui;

    return TextLabel;
end;

local u46 = boardLabel("Tier", 0, 0.36, Enum.FontWeight.Heavy, 0.13);
local Frame = Instance.new("Frame");
Frame.Name = "Line";
Frame.BorderSizePixel = 0;
Frame.AnchorPoint = Vector2.new(0.5, 0.5);
Frame.Position = UDim2.fromScale(0.5, 0.42);
Frame.Size = UDim2.fromScale(0.7, 0.035);
Frame.ZIndex = 2;
Frame.Parent = BillboardGui;
local UIGradient = Instance.new("UIGradient");
UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });
UIGradient.Parent = Frame;
local u47 = boardLabel("Knife", 0.47, 0.53, Enum.FontWeight.ExtraBold, 0.1);
local UIGradient2 = Instance.new("UIGradient");
UIGradient2.Parent = u47;
BillboardGui.Parent = Folder;
local u48 = nil;

local function showBoard(p49, p50, p51) -- Line: 191
    -- upvalues: u46 (copy), CombineConfig (copy), u47 (copy), UIGradient2 (copy), Frame (copy), ImageLabel (copy), BillboardGui (copy), u48 (ref), UIScale (copy), TweenService (copy)
    u46.Text = CombineConfig.TierNames[p50] or "";
    u46.TextColor3 = p51;
    u47.Text = CombineConfig.nameOf(p49) or p49;
    local v52 = p51:Lerp(Color3.new(1, 1, 1), 0.55);
    local Color3_new_ret = Color3.new(1, 1, 1);
    UIGradient2.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, v52),
        ColorSequenceKeypoint.new(0.42, v52),
        ColorSequenceKeypoint.new(0.5, Color3_new_ret),
        ColorSequenceKeypoint.new(0.58, v52),
        ColorSequenceKeypoint.new(1, v52)
    });
    Frame.BackgroundColor3 = p51;
    ImageLabel.ImageColor3 = p51;
    BillboardGui.Enabled = true;

    if u48 then
        u48:Cancel();
    end;

    UIScale.Scale = 0.2;
    u48 = TweenService:Create(UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
    u48:Play();
end;

local function hideBoard() -- Line: 202
    -- upvalues: BillboardGui (copy), u48 (ref), TweenService (copy), UIScale (copy)
    if not BillboardGui.Enabled then
        return;
    end;

    if u48 then
        u48:Cancel();
    end;

    u48 = TweenService:Create(UIScale, TweenInfo.new(0.15), {
        Scale = 0
    });
    u48.Completed:Once(function(p53) -- Line: 206
        -- upvalues: BillboardGui (ref)
        if p53 == Enum.PlaybackState.Completed then
            BillboardGui.Enabled = false;
        end;
    end);
    u48:Play();
end;

local function summonKnife(u54, u55) -- Line: 210
    -- upvalues: Folder (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u2 (copy), emitter (copy), Debris (copy), TweenService (copy), RunService (copy)
    local Folder2 = Instance.new("Folder");
    Folder2.Name = "KnifeSummonRift";
    Folder2.Parent = Folder;
    local u56 = {};

    for i = 1, 3 do
        u56[i] = {};
        local v57 = i;

        for i2 = 1, 20 do
            local CFrame3 = u54.CFrame;
            local Part3 = Instance.new("Part");
            Part3.Name = "CrescentSlash";
            Part3.Anchored = true;
            Part3.CanCollide = false;
            Part3.CanTouch = false;
            Part3.CanQuery = false;
            Part3.Material = Enum.Material.Neon;
            Part3.Color = v57 == 1 and Color3_fromRGB_ret3 or (v57 == 2 and Color3_fromRGB_ret2 or Color3_fromRGB_ret) or Color3_fromRGB_ret;
            Part3.Size = Vector3.new(0.05, 0.05, 0.05);
            Part3.CFrame = CFrame3;
            Part3.CastShadow = false;
            Part3.Parent = Folder;
            Part3.Parent = Folder2;
            u56[v57][i2] = Part3;
            local _ = i2;
        end;
    end;

    local CFrame3 = u54.CFrame;
    local Part3 = Instance.new("Part");
    Part3.Name = "RiftSlit";
    Part3.Anchored = true;
    Part3.CanCollide = false;
    Part3.CanTouch = false;
    Part3.CanQuery = false;
    Part3.Material = Enum.Material.Neon;
    Part3.Color = Color3_fromRGB_ret3 or Color3_fromRGB_ret;
    Part3.Size = Vector3.new(0.07, 3.2, 0.05) * u2;
    Part3.CFrame = CFrame3;
    Part3.CastShadow = false;
    Part3.Parent = Folder;
    Part3.Parent = Folder2;
    local u58 = {};

    for i = 1, 10 do
        local CFrame4 = u54.CFrame;
        local Part4 = Instance.new("Part");
        Part4.Name = "InwardShard";
        Part4.Anchored = true;
        Part4.CanCollide = false;
        Part4.CanTouch = false;
        Part4.CanQuery = false;
        Part4.Material = Enum.Material.Neon;
        Part4.Color = i % 2 == 0 and Color3_fromRGB_ret2 or Color3_fromRGB_ret or Color3_fromRGB_ret;
        Part4.Size = Vector3.new(0.08, 0.25, 0.08) * u2;
        Part4.CFrame = CFrame4;
        Part4.CastShadow = false;
        Part4.Parent = Folder;
        Part4.Parent = Folder2;
        u58[i] = Part4;
        local _ = i;
    end;

    local Attachment2 = Instance.new("Attachment", u54);
    local v59 = emitter("Sparks", Attachment2);
    v59.Speed = NumberRange.new(3, 7);
    v59.Lifetime = NumberRange.new(0.2, 0.5);
    v59:Emit(20);
    Debris:AddItem(Attachment2, 1);
    local Highlight2 = Instance.new("Highlight");
    Highlight2.Adornee = u54;
    Highlight2.FillColor = Color3_fromRGB_ret3;
    Highlight2.OutlineColor = Color3_fromRGB_ret2;
    Highlight2.FillTransparency = 0.2;
    Highlight2.OutlineTransparency = 0;
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.Parent = Folder2;
    TweenService:Create(Highlight2, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    local os_clock_ret = os.clock();
    local u60 = nil;
    u60 = RunService.RenderStepped:Connect(function() -- Line: 232
        -- upvalues: Folder2 (copy), u54 (copy), u60 (ref), os_clock_ret (copy), u2 (ref), u56 (copy), u55 (copy), Part3 (copy), u58 (copy)
        if not (Folder2.Parent and u54.Parent) then
            u60:Disconnect();
            Folder2:Destroy();

            return;
        end;

        local v61 = (os.clock() - os_clock_ret) / 0.8;
        local math_clamp_ret = math.clamp(v61, 0, 1);
        local CFrame_lookAt_ret = CFrame.lookAt(u54.Position, workspace.CurrentCamera.CFrame.Position);
        local math_clamp_ret2 = math.clamp((math_clamp_ret - 0.4) / 0.6, 0, 1);
        local v62 = u2 * ((1 - math_clamp_ret) ^ 0.65 * 1.6 + 0.25);

        for i, v in u56 do
            local v63 = math_clamp_ret * (7 + i * 2) * (i == 2 and -1 or 1) + u55 + i * 2.1;
            local v64 = i;

            for i2, v2 in v do
                local v65 = (i2 - 1) / 20;
                local v66 = v63 + v65 * 3.141592653589793 * 1.25;
                local v67 = v62 * (0.72 + v64 * 0.16);
                local v68 = math.cos(v66) * v67;
                local v69 = math.sin(v66) * v67;
                local Vector3_new_ret = Vector3.new(v68, v69, v64 * 0.035);
                local v70 = math.cos(v66 + 0.2) * v67;
                local v71 = math.sin(v66 + 0.2) * v67;
                local Vector3_new_ret2 = Vector3.new(v70, v71, v64 * 0.035);
                v2.CFrame = CFrame_lookAt_ret * CFrame.lookAt((Vector3_new_ret + Vector3_new_ret2) / 2, Vector3_new_ret2);
                local v72 = u2 * (math.sin(v65 * 3.141592653589793) * 0.16 + 0.025) * (1 - math_clamp_ret * 0.75);
                v2.Size = Vector3.new(v72, v72 * 0.6, (Vector3_new_ret2 - Vector3_new_ret).Magnitude * 1.1);
                v2.Transparency = math_clamp_ret2;
            end;
        end;

        Part3.CFrame = CFrame_lookAt_ret * CFrame.Angles(0, 0, math_clamp_ret * 0.7 + -0.4);
        local v73 = math.sin(math_clamp_ret * 3.141592653589793) * 0.13 + 0.06;
        Part3.Size = Vector3.new(v73, (1 - math_clamp_ret) * 3.5 + 0.01, 0.025) * u2;
        Part3.Transparency = math.clamp(math_clamp_ret * 1.8, 0, 1);

        for i, v in u58 do
            local v74 = i / 10 * 3.141592653589793 * 2 + math_clamp_ret * 2;
            local v75 = u2 * ((1 - math_clamp_ret) ^ 2 * 3.1 + 0.1);
            v.CFrame = CFrame_lookAt_ret * CFrame.new(math.cos(v74) * v75, math.sin(v74) * v75, 0) * CFrame.Angles(0, 0, v74 + math_clamp_ret * 6);
            v.Transparency = math_clamp_ret2;
        end;

        if math_clamp_ret >= 1 then
            u60:Disconnect();
            Folder2:Destroy();
        end;
    end);
end;

local function crossing(p76, p77) -- Line: 278
    local Attribute = p76:GetAttribute("IconCross");

    return typeof(Attribute) == "Vector3" and Attribute and Attribute or p77;
end;

local function restOf(p78, p79, p80) -- Line: 283
    local Attribute = p78:GetAttribute("ThumbAxis");
    local Attribute2 = p78:GetAttribute("ThumbNormal");
    local v81, v82;

    if typeof(Attribute) == "Vector3" and (typeof(Attribute2) == "Vector3" and Attribute.Magnitude > 0.5) then
        v81 = Attribute.Unit;
        local Unit = (Attribute2 - v81 * Attribute2:Dot(v81)).Unit;
        v82 = CFrame.fromMatrix(Vector3.new(0, 0, 0), v81, Unit:Cross(v81), Unit):Inverse();

        if p80 then
            return v81, CFrame.Angles(0, 0, 1.5707963267948966) * v82;
        end;
    else
        if p79.X >= p79.Y and p79.X >= p79.Z then
            return Vector3.new(1, 0, 0), p80 and CFrame.Angles(0, 0, 1.5707963267948966) or CFrame.identity;
        end;

        if p79.Y >= p79.Z then
            return Vector3.new(0, 1, 0), p80 and CFrame.identity or CFrame.Angles(0, 0, -1.5707963267948966);
        end;

        v82 = p80 and CFrame.Angles(-1.5707963267948966, 0, 0) or CFrame.Angles(0, 1.5707963267948966, 0);
        v81 = Vector3.new(0, 0, 1);
    end;

    return v81, v82;
end;

local function hold(p83, p84, p85) -- Line: 301
    for _, v in p84 do
        local IconWeld = v:FindFirstChild("IconWeld");
        local v86 = v:FindFirstChildWhichIsA("SpecialMesh");
        local v87 = {
            part = v,
            weld = IconWeld,
            size = v.Size * p85,
            offset = IconWeld.C0,
            k = p85,
            mesh = v86
        };

        if v86 then
            v86 = v86.Scale * p85;
        end;

        v87.meshScale = v86;
        table.insert(p83, v87);
    end;
end;

local function blade(p88, p89, p90) -- Line: 308
    -- upvalues: SkinCatalog (copy), CombineConfig (copy), Weapons (copy), KnifeIconCopy (copy), restOf (copy), hold (copy)
    local v91 = SkinCatalog.get(p88);
    local v92 = CombineConfig.tierOf(p88);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        if v91 then
            local v93 = Models:FindFirstChild(v91.Model);

            if v93 then
                v92 = v93;
            elseif v92 then
                v92 = Models:FindFirstChild(CombineConfig.Families[v92].Tiers[1]);
            end;
        else
            v92 = v91;
        end;
    else
        v92 = Models;
    end;

    local v94;

    if v92 then
        v94 = v92:FindFirstChild("Blade") or v92:FindFirstChildWhichIsA("BasePart", true);
    else
        v94 = v92;
    end;

    if not v94 then
        return nil;
    end;

    local v95, v96, v97, v98 = KnifeIconCopy.new(v94);
    v95.Name = p88;
    v95.CastShadow = false;
    local Size = v95.Size;
    local v99 = p89 / math.max(v97.X, v97.Y, v97.Z);
    local v100, v101 = restOf(v92, Size, p90);
    local v102 = {};
    hold(v102, v96, v99);
    local v103 = v95:FindFirstChildWhichIsA("SpecialMesh");
    local v104 = {
        part = v95,
        skin = p88,
        size = Size * v99,
        mesh = v103
    };

    if v103 then
        v103 = v103.Scale * v99;
    end;

    v104.meshScale = v103;
    v104.axis = v100;
    v104.rest = v101 * CFrame.new(-v98 * v99);
    v104.pieces = v102;
    v104.k = v99;
    local v105 = KnifeIconCopy.twinSource(v92);
    local v106;

    if v105 then
        v106 = v105:FindFirstChild("Blade");
    else
        v106 = v105;
    end;

    if v106 and (v106:IsA("BasePart") and v94:IsA("BasePart")) then
        local v107, v108, v109, v110 = KnifeIconCopy.new(v106);
        local v111 = p89 / math.max(v109.X, v109.Y, v109.Z);
        local _, v112 = restOf(v105, v107.Size, p90);
        local v113 = CFrame.Angles(0, 0, 0.5235987755982988) * v101;
        local CFrame_new = CFrame.new;
        local Attribute = v94:GetAttribute("IconCross");
        local v114 = v113 * CFrame_new(-(typeof(Attribute) == "Vector3" and Attribute and Attribute or v98) * v99);
        local v115 = CFrame.Angles(0, 0, -0.5235987755982988) * CFrame.Angles(0, 3.141592653589793, 0) * v112;
        local CFrame_new2 = CFrame.new;
        local Attribute2 = v106:GetAttribute("IconCross");
        local v116 = v115 * CFrame_new2(-(typeof(Attribute2) == "Vector3" and Attribute2 and Attribute2 or v110) * v111);
        local v117 = Vector3.new(1, 1, 1) * (1 / 0);
        local v118 = Vector3.new(-1, -1, -1) * (1 / 0);

        for _, v in {
            {
                v114,
                v97,
                v98,
                v99
            },
            {
                v116,
                v109,
                v110,
                v111
            }
        } do
            local v119 = v;

            for i = -1, 1, 2 do
                local v120 = i;

                for i2 = -1, 1, 2 do
                    local v121 = i2;

                    for i3 = -1, 1, 2 do
                        local v122 = v119[1] * ((v119[3] + v119[2] / 2 * Vector3.new(v120, v121, i3)) * v119[4]);
                        v117 = v117:Min(v122);
                        v118 = v118:Max(v122);
                        local _ = i3;
                    end;
                end;
            end;
        end;

        v104.rest = CFrame.new(-(v117 + v118) / 2) * v114;
        v107.Name = "LeftBlade";
        v107.CastShadow = false;
        v107.Anchored = false;
        v107.Massless = true;
        local Weld = Instance.new("Weld");
        Weld.Name = "IconWeld";
        Weld.Part0 = v95;
        Weld.Part1 = v107;
        Weld.Parent = v107;
        v107.Parent = v95;
        local v123 = v107:FindFirstChildWhichIsA("SpecialMesh");
        local v124 = {
            k = 1,
            part = v107,
            weld = Weld,
            size = v107.Size * v111,
            offset = v114:Inverse() * v116,
            mesh = v123
        };

        if v123 then
            v123 = v123.Scale * v111;
        end;

        v124.meshScale = v123;
        table.insert(v102, v124);
        hold(v102, v108, v111);
    end;

    return v104;
end;

local function resize(p125, p126) -- Line: 352
    local math_max_ret = math.max(p126, 0.01);
    p125.part.Size = p125.size * math_max_ret;

    if p125.mesh then
        p125.mesh.Scale = p125.meshScale * math_max_ret;
    end;

    for _, v in p125.pieces do
        v.part.Size = v.size * math_max_ret;

        if v.mesh then
            v.mesh.Scale = v.meshScale * math_max_ret;
        end;

        v.weld.C0 = v.offset.Rotation + v.offset.Position * (v.k * math_max_ret);
    end;
end;

local function fade(p127, p128) -- Line: 363
    p127.part.Transparency = p128;

    for _, v in p127.pieces do
        v.part.Transparency = p128;
    end;
end;

local function tierColor(p129) -- Line: 367
    -- upvalues: CombineConfig (copy)
    local _, v130 = CombineConfig.tierOf(p129);
    local v131 = CombineConfig.isFusion(p129) and #CombineConfig.TierColors or v130;

    return CombineConfig.TierColors[math.clamp(v131 or 1, 1, #CombineConfig.TierColors)];
end;

local u132 = {};
local u133 = { 3.3, 4.1, 4.6, 3.7, 4.35 };
local u134 = {
    CFrame.Angles(0.28, 0, 0.15),
    CFrame.Angles(-0.6, 0.7, -0.3),
    CFrame.Angles(0.8, -0.6, 0.35),
    CFrame.Angles(-0.25, 1.4, 0.65),
    CFrame.Angles(0.4, -1, 0.8)
};

local function addSlot(p135, p136) -- Line: 377
    -- upvalues: blade (copy), u3 (copy), resize (copy), Part (copy), Folder (copy), u35 (ref), u34 (ref), Color3_fromRGB_ret3 (copy), Attachment (copy), u132 (copy), u22 (copy), summonKnife (copy)
    local v137 = blade(p136, u3, false);

    if not v137 then
        return false;
    end;

    local part2 = v137.part;
    resize(v137, 0.03);
    part2.CFrame = CFrame.new(Part.Position);
    part2.Parent = Folder;
    local Attachment2 = Instance.new("Attachment", part2);
    Attachment2.Position = v137.axis * (-u3 * 0.42);
    local Attachment3 = Instance.new("Attachment", part2);
    Attachment3.Position = v137.axis * (u3 * 0.42);
    local Trail = Instance.new("Trail", part2);
    Trail.Attachment0 = Attachment2;
    Trail.Attachment1 = Attachment3;
    Trail.Lifetime = 0.22;
    Trail.MinLength = 0.04;
    Trail.LightEmission = 1;
    Trail.FaceCamera = true;
    Trail.Color = ColorSequence.new(p135 % 2 == 0 and u35 or u34, Color3_fromRGB_ret3);
    Trail.Transparency = NumberSequence.new(0.25, 1);
    Trail.WidthScale = NumberSequence.new(0.25, 0);
    local Attachment4 = Instance.new("Attachment", part2);
    local Beam = Instance.new("Beam", part2);
    Beam.Attachment0 = Attachment4;
    Beam.Attachment1 = Attachment;
    Beam.FaceCamera = true;
    Beam.Segments = 16;
    Beam.Width0 = 0.08;
    Beam.Width1 = 0.025;
    Beam.LightEmission = 1;
    Beam.Color = ColorSequence.new(u34, Color3_fromRGB_ret3);
    Beam.Transparency = NumberSequence.new(0.3);
    Beam.Enabled = false;
    local PointLight2 = Instance.new("PointLight", part2);
    PointLight2.Color = p135 % 2 == 0 and u35 or u34;
    PointLight2.Range = 4;
    PointLight2.Brightness = 0.6;
    v137.beam = Beam;
    v137.trail = Trail;
    v137.born = os.clock();
    u132[p135] = v137;
    local v138 = u22.Add:Clone();
    v138.Volume = 0.04;
    v138.PlaybackSpeed = 0.9 + p135 * 0.09;
    v138.RollOffMode = Enum.RollOffMode.InverseTapered;
    v138.RollOffMaxDistance = 40;
    v138.Parent = part2;
    v138:Play();
    summonKnife(part2, p135);

    return true;
end;

local function dropSlot(p139) -- Line: 398
    -- upvalues: u132 (copy), TweenService (copy), Debris (copy)
    local v140 = u132[p139];
    u132[p139] = nil;

    if v140 then
        v140.trail.Enabled = false;
        v140.beam.Enabled = false;
        local v141 = {
            Transparency = 1,
            Size = v140.part.Size * 0.05
        };
        TweenService:Create(v140.part, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v141):Play();

        for _, v in v140.pieces do
            local v142 = {
                Transparency = 1,
                Size = v.part.Size * 0.05
            };
            TweenService:Create(v.part, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v142):Play();
        end;

        Debris:AddItem(v140.part, 0.3);
    end;
end;

local function clearSlots() -- Line: 408
    -- upvalues: u132 (copy)
    for i, v in u132 do
        v.part:Destroy();
        u132[i] = nil;
    end;
end;

local function setTint(p143, p144) -- Line: 412
    -- upvalues: u34 (ref), u35 (ref), u21 (copy), Color3_fromRGB_ret3 (copy), u18 (copy), u132 (copy)
    u34 = p143;
    u35 = p144;
    u21.Color = ColorSequence.new(Color3_fromRGB_ret3, p143);
    u18.Color = ColorSequence.new(Color3_fromRGB_ret3, p143);

    for i, v in u132 do
        v.beam.Color = ColorSequence.new(p143, Color3_fromRGB_ret3);
        v.trail.Color = ColorSequence.new(i % 2 == 0 and p144 and p144 or p143, Color3_fromRGB_ret3);
    end;
end;

local u145 = nil;
local u146 = nil;

local function look(p147) -- Line: 427
    -- upvalues: u145 (ref), CombineConfig (copy), u146 (ref), Highlight (copy)
    local skin = u145.skin;
    local _, v148 = CombineConfig.tierOf(skin);
    local v149 = CombineConfig.isFusion(skin) and #CombineConfig.TierColors or v148;
    local v150 = CombineConfig.TierColors[math.clamp(v149 or 1, 1, #CombineConfig.TierColors)];

    if u146 then
        u146:Cancel();
        u146 = nil;
    end;

    u145.ghost = p147;
    local v151 = u145;
    local v152 = p147 and 0.55 or 0;
    v151.part.Transparency = v152;

    for _, v in v151.pieces do
        v.part.Transparency = v152;
    end;

    Highlight.FillColor = v150;
    Highlight.OutlineColor = v150;
    Highlight.FillTransparency = p147 and 0.6 or 1;
    Highlight.OutlineTransparency = p147 and 0.25 or 0.35;
end;

local function showInMiddle(p153, p154) -- Line: 435
    -- upvalues: u145 (ref), CombineConfig (copy), u146 (ref), Highlight (copy), blade (copy), u4 (copy), CFrame2 (copy), Folder (copy)
    if u145 and u145.skin == p153 then
        if u145.ghost ~= p154 then
            local skin = u145.skin;
            local _, v155 = CombineConfig.tierOf(skin);
            local v156 = CombineConfig.isFusion(skin) and #CombineConfig.TierColors or v155;
            local v157 = CombineConfig.TierColors[math.clamp(v156 or 1, 1, #CombineConfig.TierColors)];

            if u146 then
                u146:Cancel();
                u146 = nil;
            end;

            u145.ghost = p154;
            local v158 = u145;
            local v159 = p154 and 0.55 or 0;
            v158.part.Transparency = v159;

            for _, v in v158.pieces do
                v.part.Transparency = v159;
            end;

            Highlight.FillColor = v157;
            Highlight.OutlineColor = v157;
            Highlight.FillTransparency = p154 and 0.6 or 1;
            Highlight.OutlineTransparency = p154 and 0.25 or 0.35;
        end;

        return;
    end;

    if u145 then
        u145.part:Destroy();
        u145 = nil;
        Highlight.Adornee = nil;
    end;

    if p153 then
        p153 = blade(p153, u4, true);
    end;

    if not p153 then
        return;
    end;

    p153.part.CFrame = CFrame2 * p153.rest;
    p153.part.Parent = Folder;
    u145 = p153;
    Highlight.Adornee = p153.part;
    local skin = u145.skin;
    local _, v160 = CombineConfig.tierOf(skin);
    local v161 = CombineConfig.isFusion(skin) and #CombineConfig.TierColors or v160;
    local v162 = CombineConfig.TierColors[math.clamp(v161 or 1, 1, #CombineConfig.TierColors)];

    if u146 then
        u146:Cancel();
        u146 = nil;
    end;

    u145.ghost = p154;
    local v163 = u145;
    local v164 = p154 and 0.55 or 0;
    v163.part.Transparency = v164;

    for _, v in v163.pieces do
        v.part.Transparency = v164;
    end;

    Highlight.FillColor = v162;
    Highlight.OutlineColor = v162;
    Highlight.FillTransparency = p154 and 0.6 or 1;
    Highlight.OutlineTransparency = p154 and 0.25 or 0.35;
end;

local function dropMiddle() -- Line: 449
    -- upvalues: u145 (ref), Highlight (copy), u146 (ref), TweenService (copy), Debris (copy)
    if not u145 then
        return;
    end;

    local v165 = u145;
    u145 = nil;
    Highlight.Adornee = nil;

    if u146 then
        u146:Cancel();
        u146 = nil;
    end;

    local v166 = {
        Transparency = 1,
        Size = v165.part.Size * 0.05
    };
    TweenService:Create(v165.part, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v166):Play();

    for _, v in v165.pieces do
        local v167 = {
            Transparency = 1,
            Size = v.part.Size * 0.05
        };
        TweenService:Create(v.part, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v167):Play();
    end;

    Debris:AddItem(v165.part, 0.3);
end;

local u168 = {};
local u169 = nil;
local u170 = nil;
local u171 = setmetatable({}, {
    __mode = "k"
});
local u172 = false;

local function held() -- Line: 468
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("SpinWheelOpen") == true and true or LocalPlayer:GetAttribute("SpinSummaryOpen") == true;
end;

local function refreshKnives() -- Line: 471
    -- upvalues: LocalPlayer (copy), u172 (ref), u168 (ref), u169 (ref), CombineScreen (copy)
    if LocalPlayer:GetAttribute("SpinWheelOpen") == true and true or LocalPlayer:GetAttribute("SpinSummaryOpen") == true then
        u172 = true;

        return;
    end;

    u172 = false;
    local v173, v174 = CombineScreen.floating(5);
    u168 = v173;
    u169 = v174;
end;

local function released() -- Line: 476
    -- upvalues: u172 (ref), LocalPlayer (copy), u168 (ref), u169 (ref), CombineScreen (copy)
    if not (u172 and (LocalPlayer:GetAttribute("SpinWheelOpen") ~= true and LocalPlayer:GetAttribute("SpinSummaryOpen") ~= true)) then
        return;
    end;

    task.delay(0.5, function() -- Line: 478
        -- upvalues: u172 (ref), LocalPlayer (ref), u168 (ref), u169 (ref), CombineScreen (ref)
        if u172 and (LocalPlayer:GetAttribute("SpinWheelOpen") ~= true and LocalPlayer:GetAttribute("SpinSummaryOpen") ~= true) then
            if LocalPlayer:GetAttribute("SpinWheelOpen") == true and true or LocalPlayer:GetAttribute("SpinSummaryOpen") == true then
                u172 = true;

                return;
            end;

            u172 = false;
            local v175, v176 = CombineScreen.floating(5);
            u168 = v175;
            u169 = v176;
        end;
    end);
end;

LocalPlayer:GetAttributeChangedSignal("SpinWheelOpen"):Connect(released);
LocalPlayer:GetAttributeChangedSignal("SpinSummaryOpen"):Connect(released);
CombineScreen.listen(function(p177, p178) -- Line: 482
    -- upvalues: LocalPlayer (copy), u172 (ref), u168 (ref), u169 (ref), CombineScreen (copy), u171 (copy), u170 (ref), u132 (copy), dropSlot (copy), Color3_fromRGB_ret (copy), setTint (copy)
    if p177 ~= "Knives" then
        if p177 == "Start" and (type(p178) == "table" and not u171[p178.result]) then
            u171[p178.result] = true;
            u170 = {
                info = p178,
                started = os.clock(),
                knives = type(p178.inputs) == "table" and (table.move(p178.inputs, 1, math.min(5, #p178.inputs), 1, {}) or {}) or {}
            };

            for i = 1, 5 do
                local v179;

                if u132[i] and u132[i].skin ~= u170.knives[i] then
                    dropSlot(i);
                    v179 = i;
                else
                    v179 = i;
                end;
            end;

            local v180 = typeof(p178.color) == "Color3" and p178.color or Color3_fromRGB_ret;
            setTint(v180, v180:Lerp(Color3.new(1, 1, 1), 0.45));
        end;

        return;
    end;

    if LocalPlayer:GetAttribute("SpinWheelOpen") == true and true or LocalPlayer:GetAttribute("SpinSummaryOpen") == true then
        u172 = true;

        return;
    end;

    u172 = false;
    local v181, v182 = CombineScreen.floating(5);
    u168 = v181;
    u169 = v182;
end);

if LocalPlayer:GetAttribute("SpinWheelOpen") == true and true or LocalPlayer:GetAttribute("SpinSummaryOpen") == true then
    u172 = true;
else
    u172 = false;
    local v183, v184 = CombineScreen.floating(5);
    u168 = v183;
    u169 = v184;
end;

local u185 = {};

for _, v in { "Left", "Right" } do
    local CFrame3 = MergeMachine:WaitForChild("Arch_Foot_" .. v).CFrame;
    local v186 = v;

    for _, v2 in v == "Left" and ({ "Arch_Left", "Arch_PanelFrame_00", "Glow_Arch_00" } or { "Arch_Right", "Arch_PanelFrame_01", "Arch_PanelFrame_02", "Arch_PanelFrame_03", "Glow_Arch_01", "Glow_Arch_02", "Glow_Arch_03" }) or { "Arch_Right", "Arch_PanelFrame_01", "Arch_PanelFrame_02", "Arch_PanelFrame_03", "Glow_Arch_01", "Glow_Arch_02", "Glow_Arch_03" } do
        local v187 = MergeMachine:WaitForChild(v2);
        local v188 = {
            part = v187,
            pivot = CFrame3,
            relative = CFrame3:ToObjectSpace(v187.CFrame),
            sign = v186 == "Left" and 1 or -1
        };
        table.insert(u185, v188);
    end;
end;

local CombineEvent = Weapons:WaitForChild("CombineEvent");

local function locked() -- Line: 511
    -- upvalues: CombineEvent (copy)
    return CombineEvent:GetAttribute("MergeEventLive") ~= true;
end;

local function promptShown() -- Line: 514
    -- upvalues: ProximityPrompt (copy), LocalPlayer (copy)
    ProximityPrompt.ObjectText = "Combine Machine";
    ProximityPrompt.ActionText = "Combine";
    local v189;

    if LocalPlayer:GetAttribute("CombineOpen") == true then
        v189 = false;
    else
        v189 = LocalPlayer:GetAttribute("InMatch") ~= true;
    end;

    ProximityPrompt.Enabled = v189;
end;

LocalPlayer:GetAttributeChangedSignal("CombineOpen"):Connect(promptShown);
LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(promptShown);
ProximityPrompt.ObjectText = "Combine Machine";
ProximityPrompt.ActionText = "Combine";
local v190;

if LocalPlayer:GetAttribute("CombineOpen") == true then
    v190 = false;
else
    v190 = LocalPlayer:GetAttribute("InMatch") ~= true;
end;

ProximityPrompt.Enabled = v190;
ProximityPrompt.Triggered:Connect(function(p191) -- Line: 521
    -- upvalues: LocalPlayer (copy), CombineEvent (copy), CombineScreen (copy), HudNavigation (copy)
    if p191 ~= LocalPlayer then
        return;
    end;

    if CombineEvent:GetAttribute("MergeEventLive") ~= true then
        CombineScreen.notice(CombineScreen.UNAVAILABLE);

        return;
    end;

    HudNavigation.activate("Combine");
end);
local u192 = false;
local u193 = false;
local u194 = "";
local u195 = 0;
local u196 = 0;
local u197 = 0;
local u198 = 0;
local u199 = 0;
local u200 = 0;
local u201 = -1;
local u202 = nil;
local u203 = true;
local u204 = false;

local function refreshAway() -- Line: 534
    -- upvalues: u204 (ref), LocalPlayer (copy), u21 (copy), u198 (ref), u192 (ref)
    u204 = LocalPlayer:GetAttribute("InMatch") == true and true or LocalPlayer:GetAttribute("Spectating") == true;
    u21.Enabled = not u204;

    if u204 then
        u198 = 0;
        u192 = false;
    end;
end;

local function setPhase(p205) -- Line: 539
    -- upvalues: u194 (ref), u195 (ref), MergeMachine (ref), Part2 (copy), u22 (copy), hideBoard (copy), setTint (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u198 (ref), burst (copy), ring (copy), CFrame2 (copy), u2 (copy), u35 (ref), u170 (ref), u132 (copy), u20 (copy), u203 (ref), u34 (ref), Color3_fromRGB_ret3 (copy), Folder (copy), TweenService (copy), Debris (copy)
    if u194 == p205 then
        return;
    end;

    local os_clock_ret = os.clock();
    u194 = p205;
    u195 = os_clock_ret;
    MergeMachine:SetAttribute("PhaseStarted", workspace:GetServerTimeNow());
    MergeMachine:SetAttribute("MergePhase", p205);

    if u194 == "Collecting" or u194 == "Gathering" then
        Part2.Transparency = 1;
        u22.Charge:Stop();
        u22.Hum:Stop();
        hideBoard();

        if u194 == "Collecting" then
            setTint(Color3_fromRGB_ret, Color3_fromRGB_ret2);
        end;
    else
        if u194 == "Charging" then
            local Charge = u22.Charge;
            Charge.PlaybackSpeed = 1;
            Charge.TimePosition = 0;
            Charge:Play();
            local Hum = u22.Hum;
            Hum.PlaybackSpeed = 1;
            Hum.TimePosition = 0;
            Hum:Play();
            u198 = 0.08;
            burst(35);

            return;
        end;

        if u194 == "Collapse" then
            local Charge = u22.Charge;
            Charge.PlaybackSpeed = 1.4;
            Charge.TimePosition = 0;
            Charge:Play();
            u198 = 0.18;
            ring(CFrame2, 7 * u2, u35, 0.6);

            return;
        end;

        if u194 == "Reveal" then
            u170.burst = u195;
            u22.Hum:Stop();
            u22.Charge:Stop();
            local Impact = u22.Impact;
            Impact.PlaybackSpeed = 0.9;
            Impact.TimePosition = 0;
            Impact:Play();

            for i, v in u132 do
                v.part:Destroy();
                u132[i] = nil;
            end;

            burst(140);
            u20:Emit(2);
            u198 = 0.55;

            for i = 1, 3 do
                task.delay((i - 1) * 0.13, function() -- Line: 560
                    -- upvalues: u203 (ref), ring (ref), CFrame2 (ref), i (copy), u2 (ref), u35 (ref), u34 (ref)
                    if u203 then
                        ring(CFrame2 * CFrame.Angles(i * 0.4, 0, i * 0.55), (i * 2 + 6) * u2, i == 2 and u35 or u34, 0.85);
                    end;
                end);
                local _ = i;
            end;

            local Part3 = Instance.new("Part");
            Part3.Name = "FinalShockSphere";
            Part3.Anchored = true;
            Part3.CanCollide = false;
            Part3.CanTouch = false;
            Part3.CanQuery = false;
            Part3.Material = Enum.Material.Neon;
            Part3.Color = Color3_fromRGB_ret3 or Color3_fromRGB_ret;
            Part3.Size = Vector3.new(0.3, 0.3, 0.3);
            Part3.CFrame = CFrame2;
            Part3.CastShadow = false;
            Part3.Parent = Folder;
            Part3.Shape = Enum.PartType.Ball;
            Part3.Transparency = 0.35;
            local v206 = {
                Transparency = 1,
                Size = Vector3.new(15, 15, 15) * u2
            };
            TweenService:Create(Part3, TweenInfo.new(0.48, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v206):Play();
            Debris:AddItem(Part3, 0.55);
        end;
    end;
end;

local function appear() -- Line: 566
    -- upvalues: u170 (ref), showInMiddle (copy), Highlight (copy), Color3_fromRGB_ret3 (copy), u146 (ref), TweenService (copy), showBoard (copy), u34 (ref)
    u170.appeared = true;
    showInMiddle(u170.info.output, false);
    Highlight.FillColor = Color3_fromRGB_ret3;
    Highlight.FillTransparency = 0.1;
    Highlight.OutlineTransparency = 0;
    local v207 = TweenService:Create(Highlight, TweenInfo.new(2.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 0.35
    });
    v207:Play();
    u146 = v207;
    showBoard(u170.info.output, u170.info.tier, u34);
end;

setPhase("Collecting");
LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(refreshAway);
LocalPlayer:GetAttributeChangedSignal("Spectating"):Connect(refreshAway);
u204 = LocalPlayer:GetAttribute("InMatch") == true and true or LocalPlayer:GetAttribute("Spectating") == true;
u21.Enabled = not u204;

if u204 then
    u198 = 0;
    u192 = false;
end;

local u208 = nil;
u208 = RunService.RenderStepped:Connect(function(p209) -- Line: 578
    -- upvalues: MergeMachine (ref), u203 (ref), u208 (ref), Folder (copy), RunService (copy), u204 (ref), u170 (ref), u132 (copy), setPhase (copy), LocalPlayer (copy), CFrame2 (copy), u192 (ref), u2 (copy), u193 (ref), u202 (ref), u194 (ref), u195 (ref), CombineEvent (copy), u168 (ref), dropSlot (copy), u196 (ref), addSlot (copy), u201 (ref), u185 (copy), showInMiddle (copy), appear (copy), dropMiddle (copy), u169 (ref), u200 (ref), u145 (ref), resize (copy), Part (copy), PointLight (copy), Color3_fromRGB_ret3 (copy), u34 (ref), u21 (copy), Part2 (copy), u197 (ref), ring (copy), BillboardGui (copy), ImageLabel (copy), UIGradient2 (copy), u199 (ref), u133 (copy), u134 (copy), u18 (copy), u22 (copy), u198 (ref)
    if not MergeMachine.Parent then
        u203 = false;
        u208:Disconnect();
        Folder:Destroy();
        RunService:UnbindFromRenderStep("MergeForgeRemoveShake");
        RunService:UnbindFromRenderStep("MergeForgeShake");

        return;
    end;

    if u204 then
        if u170 then
            for i, v in u132 do
                v.part:Destroy();
                u132[i] = nil;
            end;

            u170 = nil;
            setPhase("Collecting");
        end;

        return;
    end;

    local os_clock_ret = os.clock();
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v210 = Character and (Character.Position - CFrame2.Position).Magnitude or (1 / 0);
    u192 = v210 < 48 * u2;
    u193 = v210 < (u193 and 26 or 20);
    local v211 = u170 and (os_clock_ret - u170.started or 0) or 0;

    if u170 then
        local info = u170.info;

        if LocalPlayer:GetAttribute("CombineOpen") == true then
            u202 = nil;
        else
            u202 = u202 or os_clock_ret;
        end;

        if info.converge <= v211 then
            if u194 == "Reveal" or u194 == "Complete" then
                if u194 == "Reveal" and os_clock_ret - u195 >= 1 then
                    setPhase("Complete");
                end;
            else
                setPhase("Reveal");
            end;

            if u194 == "Complete" and (info.done <= v211 and (u202 and os_clock_ret - u202 >= 5)) then
                u170 = nil;
                setPhase("Collecting");
            end;
        elseif info.charge <= v211 then
            setPhase("Collapse");
        elseif info.gather <= v211 then
            setPhase("Charging");
        else
            setPhase("Gathering");
        end;
    end;

    local v212 = u170 and u170.info;
    local v213 = u170 and u170.knives or (u193 and CombineEvent:GetAttribute("MergeEventLive") == true and (u168 or {}) or {});

    if not u170 then
        for i = 1, 5 do
            local v214;

            if u132[i] and u132[i].skin ~= v213[i] then
                dropSlot(i);
                v214 = i;
            else
                v214 = i;
            end;
        end;
    end;

    if not (u170 and (u194 ~= "Gathering" and u194 ~= "Charging")) and (u170 and 0.08 or 0.25) <= os_clock_ret - u196 then
        for i = 1, 5 do
            if v213[i] and not u132[i] then
                if addSlot(i, v213[i]) then
                    u196 = os_clock_ret;
                end;

                break;
            end;

            local _ = i;
        end;
    end;

    local v215 = u194 == "Charging" and true or u194 == "Collapse";
    local v216 = v215 and (math.clamp((v211 - v212.gather) / (v212.converge - v212.gather), 0, 1) or 0) or 0;
    local v217 = u194 == "Collapse" and (math.clamp((v211 - v212.charge) / (v212.converge - v212.charge), 0, 1) or 0) or 0;
    local v218;

    if u170 and u170.burst then
        v218 = os_clock_ret - u170.burst or nil;
    else
        v218 = nil;
    end;

    local v219 = v216 * 0.7 + v217 * 0.3;

    if v218 then
        v219 = math.max(0, 1 - v218 / 1.2);
    end;

    if v219 ~= u201 then
        u201 = v219;

        for _, v in u185 do
            v.part.CFrame = v.pivot * CFrame.Angles(0, 0, v.sign * 0.10471975511965978 * v219) * v.relative;
        end;
    end;

    if u170 then
        if u170.appeared then
            showInMiddle(v212.output, false);
        elseif v218 and v218 >= 0.25 then
            appear();
        else
            dropMiddle();
        end;
    else
        local v220;

        if CombineEvent:GetAttribute("MergeEventLive") ~= true then
            v220 = nil;
        else
            v220 = u169 or nil;
        end;

        showInMiddle(v220, true);
    end;

    local v221, v222, v223;

    if v218 then
        local math_min_ret = math.min(v218 / 1, 1);
        v221 = (math.sin(math_min_ret * 3.141592653589793) * 0.7 + math_min_ret * 0.25 * math.sin(v218 * 1.6)) * u2;
        v222 = math.exp(-v218 * 1.3) * 17 + 0.8;
        v223 = CFrame.Angles(math_min_ret * 0.1 * math.sin(v218 * 1.2), 0, math_min_ret * 0.07 * math.sin(v218 * 0.9));
    else
        v221 = math.sin(os_clock_ret * 1.6) * 0.12 * u2;
        v222 = 0.35 + 17.65 * v216 ^ 2;
        v223 = CFrame.identity;
    end;

    u200 = (u200 + p209 * v222) % 6.283185307179586;
    local v224 = CFrame2.Position + Vector3.new(0, v221, 0);

    if u145 then
        u145.part.CFrame = CFrame.new(v224) * v223 * CFrame.Angles(0, u200, 0) * u145.rest;
        local v225 = v218 and (math.clamp((v218 - 0.25) / 0.35, 0, 1) or 1) or 1;
        resize(u145, v225 < 1 and 1 + 2.70158 * (v225 - 1) ^ 3 + 1.70158 * (v225 - 1) ^ 2 or 1);

        if u145.ghost then
            local v226 = u145;
            local v227 = 0.55 - 0.3 * v216;
            v226.part.Transparency = v227;

            for _, v in v226.pieces do
                v.part.Transparency = v227;
            end;
        end;
    end;

    Part.CFrame = CFrame.new(v224);
    PointLight.Brightness = 0.65 + v216 * 4 + v217 * 7 + (v218 and (math.exp(-v218 * 2) * 12 or 0) or 0);
    PointLight.Color = v218 and (v218 < 0.4 and Color3_fromRGB_ret3) or u34;
    u21.Rate = CombineEvent:GetAttribute("MergeEventLive") ~= true and 0 or (u194 == "Complete" and 12 or 18 + v216 * 65);
    Part2.CFrame = CFrame.new(v224);

    if v215 then
        Part2.Transparency = 0.45 - 0.22 * v216;
        Part2.Size = Vector3.new(1, 1, 1) * u2 * (0.3 + v216 * 0.8 + v217 * 1.8);

        if os_clock_ret - u197 > (u194 == "Collapse" and 0.2 or 0.6 - 0.3 * v216) then
            u197 = os_clock_ret;
            ring(CFrame2 * CFrame.Angles(0.2 * v211, 0, 0.4), (3 + v216 * 3) * u2, u34, 0.55);
        end;
    else
        Part2.Transparency = 1;
    end;

    if BillboardGui.Enabled then
        ImageLabel.Rotation = (ImageLabel.Rotation + p209 * 25) % 360;
        UIGradient2.Offset = Vector2.new(os_clock_ret * 0.55 % 2.4 - 1.2, 0);
    end;

    u199 = u199 + p209 * (v215 and (2 + 19 * v216 ^ 2 or 0) or 0);

    for i, v in u132 do
        local part2 = v.part;
        local v228 = os_clock_ret * (0.52 + i * 0.105) + i * 3.141592653589793 * 2 / 5 + u199;
        local v229;

        if u194 == "Collapse" then
            local v230 = v212.tracks - v212.charge;
            v229 = math.clamp((v211 - v212.charge - (i - 1) * v230 * 0.06) / (v230 * 0.75), 0, 1);
        else
            v229 = 0;
        end;

        local v231 = u133[i] * u2 * (1 + 0.13 * v216) * (1 - v229) ^ 1.5;
        local v232 = u134[i];
        local v233 = math.cos(v228) * v231;
        local v234 = math.sin(os_clock_ret * 1.1 + i) * 0.35 * u2 * (1 - v229);
        local v235 = math.sin(v228) * v231 * 0.72;
        local v236 = v232:VectorToWorldSpace((Vector3.new(v233, v234, v235)));
        part2.CFrame = CFrame.new(v224 + v236) * CFrame.Angles(math.sin(v228) * 0.2, v228 + i, math.sin(v228 * 0.7 + i) * 0.55) * v.rest;
        resize(v, math.min(1, (os_clock_ret - v.born) * 3) * (1 - v229 * 0.97));
        local v237 = v229 > 0.97 and 1 or 0;
        v.part.Transparency = v237;
        local v238 = i;
        local v239 = v;

        for _, v2 in v.pieces do
            v2.part.Transparency = v237;
        end;

        local v240;

        if v215 then
            v240 = v229 < 0.97;
        else
            v240 = v215;
        end;

        v239.beam.Enabled = v240;
        v239.beam.Width0 = (0.055 + v216 * 0.1 + v217 * 0.1) * u2;
        v239.beam.CurveSize0 = math.sin(os_clock_ret * 6 + v238) * (0.5 + v216) * u2;
        v239.beam.CurveSize1 = -v239.beam.CurveSize0;
        v239.trail.Lifetime = 0.18 + v216 * 0.22;

        if v229 >= 0.97 and not v239.absorbed then
            v239.absorbed = true;
            u18:Emit(25);
            local Add = u22.Add;
            Add.PlaybackSpeed = 1.3 + v238 * 0.08 or 1;
            Add.TimePosition = 0;
            Add:Play();
            u198 = 0.2;
        end;
    end;

    u198 = math.max(0, u198 - p209 * 0.55);
end);
local CFrame_identity = CFrame.identity;
RunService:BindToRenderStep("MergeForgeRemoveShake", Enum.RenderPriority.Camera.Value - 1, function() -- Line: 708
    -- upvalues: CFrame_identity (ref)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera and workspace_CurrentCamera.CameraType == Enum.CameraType.Custom then
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame_identity:Inverse();
    end;

    CFrame_identity = CFrame.identity;
end);
RunService:BindToRenderStep("MergeForgeShake", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 713
    -- upvalues: u203 (ref), u192 (ref), u198 (ref), CFrame_identity (ref)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if u203 and (u192 and (workspace_CurrentCamera and (workspace_CurrentCamera.CameraType == Enum.CameraType.Custom and u198 > 0))) then
        CFrame_identity = CFrame.new((math.random() - 0.5) * u198, (math.random() - 0.5) * u198, 0) * CFrame.Angles(0, 0, (math.random() - 0.5) * u198 * 0.015);
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame_identity;
    end;
end);