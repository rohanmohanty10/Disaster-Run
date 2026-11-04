 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local FallenKingConfig = require(Game:WaitForChild("FallenKingConfig"));
local MapLocator = require(Game:WaitForChild("MapLocator"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(110, 255, 140);
local Color3_fromRGB_ret2 = Color3.fromRGB(40, 175, 85);
local Color3_fromRGB_ret3 = Color3.fromRGB(215, 255, 220);
local Color3_fromRGB_ret4 = Color3.fromRGB(240, 255, 240);
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_fromRGB_ret3), ColorSequenceKeypoint.new(0.5, Color3_fromRGB_ret), ColorSequenceKeypoint.new(1, Color3_fromRGB_ret2) });
local CFrame_fromMatrix_ret = CFrame.fromMatrix(Vector3.new(-1.286, -1.69, -0.049), Vector3.new(-0.011, 0, 1), Vector3.new(0.34, 0.94, 0.004));
local u1 = {
    Collected = { "rbxassetid://9120746721", 0.45, 2.4, 0.85, 1.25 },
    Charge = { "rbxassetid://9120746721", 0.55, 2, 1.25, 0.8 },
    Launch = { "rbxassetid://9120746721", 0.25, 2.9, 0.35, 1.8 },
    Erupt = { "rbxassetid://9125484367", 0.7, 0, 2.2, 0.9 }
};
local Folder = Instance.new("Folder");
Folder.Name = "FallenKingLocal";
Folder.Parent = workspace;

local function myRoot() -- Line: 65
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character and Character:IsA("BasePart") then
        return Character;
    end;

    return nil;
end;

local function plain(p2) -- Line: 70
    p2.Anchored = true;
    p2.CanCollide = false;
    p2.CanQuery = false;
    p2.CanTouch = false;
    p2.CastShadow = false;

    return p2;
end;

local function ball(p3, p4) -- Line: 75
    -- upvalues: Color3_fromRGB_ret (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Shape = Enum.PartType.Ball;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3_fromRGB_ret;
    Part.Size = Vector3.new(1, 1, 1) * p3;
    Part.Transparency = p4;

    return Part;
end;

local function sound(p5, p6) -- Line: 85
    -- upvalues: u1 (copy)
    local u7 = u1[p5];

    if not (u7 and (p6 and p6.Parent)) then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = u7[1];
    Sound.Volume = u7[2];
    Sound.PlaybackSpeed = u7[5];
    Sound.Parent = p6;

    local function go() -- Line: 95
        -- upvalues: Sound (copy), u7 (copy)
        if Sound.Parent then
            Sound.TimePosition = u7[3];
            Sound:Play();
        end;
    end;

    if Sound.IsLoaded then
        if Sound.Parent then
            Sound.TimePosition = u7[3];
            Sound:Play();
        end;
    else
        Sound.Loaded:Once(go);
    end;

    task.delay(u7[4] / u7[5] + 3, function() -- Line: 106
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
end;

local function burst(p8, p9) -- Line: 110
    -- upvalues: Folder (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p8);
    Part.Parent = Folder;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret3);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.35, 0.7);
    ParticleEmitter.Speed = NumberRange.new(5, 10);
    ParticleEmitter.Drag = 3;
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(p9);
    task.delay(1, function() -- Line: 129
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local u10 = nil;
local u11 = false;

local function lightLevel(p12) -- Line: 139
    -- upvalues: u10 (ref)
    if u10.level == p12 then
        return;
    end;

    u10.level = p12;

    for _, descendant in u10.model:GetDescendants() do
        local v13 = tonumber(descendant.Name);

        if v13 and (descendant:IsA("ParticleEmitter") or (descendant:IsA("Light") or (descendant:IsA("Beam") or descendant:IsA("Trail")))) then
            descendant.Enabled = v13 <= p12;
        end;
    end;
end;

local function hip() -- Line: 152
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("Torso") or Character:FindFirstChild("LowerTorso");
    end;

    if Character and Character:IsA("BasePart") then
        return Character.CFrame, Character.Size.X / 2;
    end;

    local Character2 = LocalPlayer.Character;

    if Character2 then
        Character2 = Character2:FindFirstChild("HumanoidRootPart");
    end;

    if not (Character2 and Character2:IsA("BasePart")) then
        Character2 = nil;
    end;

    if Character2 then
        Character2 = Character2.CFrame;
    end;

    return Character2, 1;
end;

local function ensureLantern() -- Line: 161
    -- upvalues: u10 (ref), ReplicatedStorage (copy), hip (copy), ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy), CFrame_fromMatrix_ret (copy), Folder (copy), lightLevel (copy), burst (copy)
    if u10 then
        return u10;
    end;

    local Lantern = ReplicatedStorage:FindFirstChild("Lantern");
    local v14, v15 = hip();

    if not (Lantern and v14) then
        return nil;
    end;

    local u16 = Lantern:Clone();
    local u17 = v15 / 1.2;
    pcall(function() -- Line: 172
        -- upvalues: u16 (copy), u17 (copy)
        u16:ScaleTo(u16:GetScale() * u17);
    end);
    local v18 = nil;

    for _, descendant in u16:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.CastShadow = false;

            if descendant.Name == "Part" and not v18 then
                v18 = descendant;
            end;
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Color = ColorSequence_new_ret;
            descendant.Enabled = false;
        elseif descendant:IsA("Light") then
            descendant.Color = Color3_fromRGB_ret;
            descendant.Enabled = false;
        end;
    end;

    local v19 = v18 or u16:FindFirstChildWhichIsA("BasePart", true);
    local v20 = CFrame_fromMatrix_ret.Rotation + CFrame_fromMatrix_ret.Position * u17;
    local _, v21 = u16:GetBoundingBox();
    local Position = (v20 * CFrame.new(0, v21.Y / 2, 0)).Position;
    u16:PivotTo(v14 * v20);
    u16.Parent = Folder;
    u10 = {
        level = -1,
        shakeUntil = 0,
        model = u16,
        glow = v19,
        rest = v20,
        top = Position,
        swing = Vector2.zero,
        swingV = Vector2.zero
    };
    lightLevel(0);
    burst(v19.Position, 12);

    return u10;
end;

local function stepLantern(p22, p23, p24) -- Line: 212
    -- upvalues: u10 (ref), hip (copy), lightLevel (copy), FallenKingConfig (copy)
    local v25 = u10;
    local v26 = hip();

    if not v26 then
        return;
    end;

    local v27 = v26 * CFrame.new(v25.top);
    local Position = v27.Position;
    local v28 = (not v25.last or p22 <= 0) and Vector3.new(0, 0, 0) or (Position - v25.last) / p22;
    v25.last = Position;
    local v29 = v27:VectorToObjectSpace(v28.Magnitude > 120 and Vector3.new(0, 0, 0) or v28);
    local Vector2_new_ret = Vector2.new(math.clamp(v29.Z * 0.035, -0.7, 0.7), (math.clamp(-v29.X * 0.035, -0.5, 0.5)));
    v25.swingV = v25.swingV + ((Vector2_new_ret - v25.swing) * 60 - v25.swingV * 7) * math.min(p22, 0.05);
    v25.swing = v25.swing + v25.swingV * math.min(p22, 0.05);
    local v30 = math.sin(p23 * 2.1) * 0.05;
    local v31;

    if p23 < v25.shakeUntil then
        v31 = CFrame.Angles((math.random() - 0.5) * 0.25, 0, (math.random() - 0.5) * 0.25);
    else
        v31 = CFrame.identity;
    end;

    v25.model:PivotTo(v27 * CFrame.Angles(v25.swing.X, 0, v25.swing.Y + v30) * v31 * CFrame.new(-v25.top) * v25.rest);
    lightLevel(v25.override or FallenKingConfig.level(p24));
end;

local function dropLantern() -- Line: 234
    -- upvalues: u10 (ref), TweenService (copy)
    local u32 = u10;
    u10 = nil;

    if not u32 then
        return;
    end;

    for _, descendant in u32.model:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            TweenService:Create(descendant, TweenInfo.new(0.35), {
                Transparency = 1
            }):Play();
        elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Light") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(0.4, function() -- Line: 247
        -- upvalues: u32 (copy)
        u32.model:Destroy();
    end);
end;

local u33 = {};
local u34 = {};

local function where(p35) -- Line: 258
    if typeof(p35) ~= "Instance" then
        return p35;
    end;

    if p35.Parent then
        return p35.Position;
    end;

    return nil;
end;

local function pour(p36, p37, p38) -- Line: 261
    -- upvalues: Folder (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret2 (copy), u33 (copy)
    local v39;

    if typeof(p36) == "Instance" then
        if p36.Parent then
            v39 = p36.Position;
        else
            v39 = nil;
        end;
    else
        v39 = p36;
    end;

    local v40 = p37();

    if not (v39 and v40) then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(v39);
    Part.Parent = Folder;
    local v41 = Part:Clone();
    v41.CFrame = CFrame.new(v40);
    v41.Parent = Folder;
    local Attachment = Instance.new("Attachment");
    local Attachment2 = Instance.new("Attachment");
    Attachment.Parent = Part;
    Attachment2.Parent = v41;
    local v42 = {};

    for _, v in {
        {
            1.6,
            0.5,
            0.35,
            Color3_fromRGB_ret
        },
        {
            0.4,
            0.14,
            0,
            Color3_fromRGB_ret4
        }
    } do
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = Attachment;
        Beam.Attachment1 = Attachment2;
        local v43 = v[2];
        Beam.Width0 = v[1];
        Beam.Width1 = v43;
        Beam.Color = ColorSequence.new(v[4], Color3_fromRGB_ret2);
        Beam.LightEmission = 1;
        Beam.LightInfluence = 0;
        Beam.FaceCamera = true;
        Beam.Segments = 20;
        Beam.CurveSize0 = 2;
        Beam.CurveSize1 = -1.2;
        Beam.Transparency = NumberSequence.new(1);
        Beam.Parent = v41;
        table.insert(v42, {
            beam = Beam,
            base = v[3]
        });
    end;

    u33[{
        next = 0,
        from = p36,
        to = p37,
        head = Part,
        tail = v41,
        beams = v42,
        ends = os.clock() + p38,
        born = os.clock(),
        last = v39
    }] = true;
end;

local function stepPours(p44) -- Line: 295
    -- upvalues: u33 (copy), Color3_fromRGB_ret (copy), Folder (copy), u34 (copy)
    for i in u33 do
        local from = i.from;

        if typeof(from) == "Instance" then
            if from.Parent then
                from = from.Position;
            else
                from = nil;
            end;
        end;

        local v45 = from or i.last;
        i.last = v45;
        local v46 = i.to();
        i.head.CFrame = CFrame.new(v45);

        if v46 then
            i.tail.CFrame = CFrame.new(v46);
        end;

        local math_clamp_ret = math.clamp((p44 - i.ends) / 0.3, 0, 1);
        local math_clamp_ret2 = math.clamp((p44 - i.born) / 0.12, 0, 1);
        local v47 = i;

        for _, v in i.beams do
            local v48 = v.base + (1 - v.base) * math.max(math_clamp_ret, 1 - math_clamp_ret2);
            v.beam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, (math.min(1, v48 + 0.25))), NumberSequenceKeypoint.new(0.5, v48), NumberSequenceKeypoint.new(1, (math.min(1, v48 + 0.15))) });
        end;

        if p44 < v47.ends and (v46 and v47.next <= p44) then
            v47.next = p44 + 0.035;
            local v49 = 0.3 + math.random() * 0.2;
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Shape = Enum.PartType.Ball;
            Part.Material = Enum.Material.Neon;
            Part.Color = Color3_fromRGB_ret;
            Part.Size = Vector3.new(1, 1, 1) * v49;
            Part.Transparency = 0.1;
            Part.CFrame = CFrame.new(v45);
            Part.Parent = Folder;
            u34[Part] = {
                born = p44,
                from = v45,
                to = v47.to,
                life = 0.3 + math.random() * 0.1,
                side = (math.random() - 0.5) * 2,
                size = Part.Size.X
            };
        end;

        if math_clamp_ret >= 1 then
            u33[v47] = nil;
            v47.head:Destroy();
            v47.tail:Destroy();
        end;
    end;

    for i, v in u34 do
        local v50 = (p44 - v.born) / v.life;
        local v51 = v.to();

        if v50 >= 1 or not v51 then
            u34[i] = nil;
            i:Destroy();
        else
            local v52 = v.from:Lerp(v51, v50 * v50);
            local v53 = (v51 - v.from) * Vector3.new(1, 0, 1);
            local v54 = v53.Magnitude <= 0.1 and Vector3.new(1, 0, 0) or v53.Unit:Cross(Vector3.new(0, 1, 0));
            local CFrame_new = CFrame.new;
            local v55 = v52 + v54 * v.side * math.sin(v50 * 3.141592653589793);
            local math_sin_ret = math.sin(v50 * 3.141592653589793);
            i.CFrame = CFrame_new(v55 + Vector3.new(0, math_sin_ret, 0));
            i.Size = Vector3.new(1, 1, 1) * v.size * (1 - 0.6 * v50);
            i.Transparency = 0.1 + 0.6 * v50;
        end;
    end;
end;

local function lanternPoint() -- Line: 343
    -- upvalues: u10 (ref)
    return u10 and (u10.glow and (u10.glow.Parent and u10.glow.Position)) or nil;
end;

local u56 = {};

local function trailOn(p57, p58, p59, p60) -- Line: 352
    -- upvalues: Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy)
    local Attachment = Instance.new("Attachment");
    local Attachment2 = Instance.new("Attachment");
    local Vector3_new_ret = Vector3.new(0, p58, 0);
    local Vector3_new_ret2 = Vector3.new(0, -p58, 0);
    Attachment.Position = Vector3_new_ret;
    Attachment2.Position = Vector3_new_ret2;
    Attachment.Parent = p57;
    Attachment2.Parent = p57;
    local Trail = Instance.new("Trail");
    Trail.Attachment0 = Attachment;
    Trail.Attachment1 = Attachment2;
    Trail.Color = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret2);
    Trail.LightEmission = 1;
    Trail.LightInfluence = 0;
    Trail.FaceCamera = true;
    Trail.Lifetime = p59;
    Trail.WidthScale = NumberSequence.new(p60 or 1, 0);
    Trail.Transparency = NumberSequence.new(0.1, 1);
    Trail.Parent = p57;

    return Trail;
end;

local function lanternParticles(p61) -- Line: 369
    -- upvalues: ReplicatedStorage (copy), ColorSequence_new_ret (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy)
    local Lantern = ReplicatedStorage:FindFirstChild("Lantern");

    if Lantern then
        Lantern = Lantern:FindFirstChild("Part", true);
    end;

    for _, v in not Lantern and {} or Lantern:GetChildren() do
        if v:IsA("ParticleEmitter") then
            local v62 = v:Clone();
            v62.Color = ColorSequence_new_ret;
            v62.Enabled = true;
            v62.Parent = p61;
        end;
    end;

    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.22), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Transparency = NumberSequence.new(0.1, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.8, 1.4);
    ParticleEmitter.Rate = 14;
    ParticleEmitter.Speed = NumberRange.new(0.8, 2);
    ParticleEmitter.Acceleration = Vector3.new(0, 2.5, 0);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Parent = p61;
end;

local function icon(p63, p64) -- Line: 396
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "SoulIcon";
    BillboardGui.Size = UDim2.fromScale(p64, p64);
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 300;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Image = "rbxassetid://92036662316128";
    ImageLabel.Parent = BillboardGui;
    BillboardGui.Parent = p63;

    return BillboardGui, ImageLabel;
end;

local function addSoul(p65) -- Line: 410
    -- upvalues: u56 (copy), LocalPlayer (copy), lanternParticles (copy), Color3_fromRGB_ret (copy), icon (copy), Folder (copy), TweenService (copy), burst (copy)
    local Attribute = p65:GetAttribute("Body");

    if u56[p65.Name] or (typeof(Attribute) ~= "Vector3" or p65:GetAttribute("Victim") == LocalPlayer.UserId) then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Name = "SoulEssence";
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.9, 0.9, 0.9);
    lanternParticles(Part);
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret;
    PointLight.Range = 12;
    PointLight.Brightness = 2;
    PointLight.Parent = Part;
    local v66, v67 = icon(Part, 2.6);
    v67.ImageTransparency = 1;
    Part.CFrame = CFrame.new(Attribute + Vector3.new(0, 1.5, 0));
    Part.Parent = Folder;
    TweenService:Create(v67, TweenInfo.new(0.45), {
        ImageTransparency = 0
    }):Play();
    burst(Attribute + Vector3.new(0, 1.5, 0), 18);
    u56[p65.Name] = {
        config = p65,
        body = Attribute,
        phase = math.random() * 6,
        born = os.clock(),
        fx = Part,
        gui = v66,
        image = v67,
        light = PointLight,
        parts = { Part }
    };
end;

local function quench(p68) -- Line: 445
    for _, v in p68.parts do
        for _, child in v:GetChildren() do
            if child:IsA("ParticleEmitter") or (child:IsA("Light") or child:IsA("Trail")) then
                child.Enabled = false;
            end;
        end;
    end;
end;

local function fadeSoul(u69) -- Line: 454
    -- upvalues: quench (copy), TweenService (copy)
    quench(u69);
    TweenService:Create(u69.image, TweenInfo.new(0.35), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(u69.gui, TweenInfo.new(0.35), {
        Size = UDim2.fromScale(0.78, 0.78)
    }):Play();
    task.delay(0.9, function() -- Line: 459
        -- upvalues: u69 (copy)
        for _, v in u69.parts do
            v:Destroy();
        end;
    end);
end;

local function removeSoul(p70) -- Line: 465
    -- upvalues: u56 (copy), fadeSoul (copy)
    local v71 = u56[p70];

    if not v71 or v71.claimed then
        return;
    end;

    u56[p70] = nil;
    fadeSoul(v71);
end;

local function collected(p72) -- Line: 474
    -- upvalues: u56 (copy), u11 (ref), ensureLantern (copy), pour (copy), lanternPoint (copy), burst (copy), sound (copy), quench (copy), u10 (ref), RunService (copy)
    local u73 = u56[p72];

    if not u73 or u73.claimed then
        return;
    end;

    u73.claimed = true;
    u56[p72] = nil;
    u11 = true;
    ensureLantern();
    local fx = u73.fx;
    pour(fx, lanternPoint, 0.45);
    burst(fx.Position, 18);
    sound("Collected", fx);
    quench(u73);
    local Position = fx.Position;
    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 491
        -- upvalues: fx (copy), os_clock_ret (copy), u10 (ref), Position (copy), u73 (copy), RunService (ref), burst (ref)
        while fx.Parent and os.clock() - os_clock_ret < 0.45 do
            local v74 = (os.clock() - os_clock_ret) / 0.45;
            local CFrame_new = CFrame.new;
            local v75 = Position:Lerp(u10 and (u10.glow and (u10.glow.Parent and u10.glow.Position)) or nil or Position, v74 * v74);
            local v76 = math.sin(v74 * 3.141592653589793) * 2;
            fx.CFrame = CFrame_new(v75 + Vector3.new(0, v76, 0));
            local v77 = 2.6 * (1 - 0.7 * v74);
            u73.gui.Size = UDim2.fromScale(v77, v77);
            RunService.RenderStepped:Wait();
        end;

        local v78 = u10 and (u10.glow and (u10.glow.Parent and u10.glow.Position)) or nil;

        if v78 then
            burst(v78, 20);
        end;

        u73.image.ImageTransparency = 1;
        task.delay(0.6, function() -- Line: 505
            -- upvalues: u73 (ref)
            for _, v in u73.parts do
                v:Destroy();
            end;
        end);
    end);
end;

local u79 = nil;
local u80 = nil;

local function percentText() -- Line: 518
    -- upvalues: Game (copy)
    return ("%.2f%%"):format((tonumber(Game:GetAttribute("FallenKingProgress")) or 0) * 100);
end;

local function stoneBody() -- Line: 523
    local FallenKingStone = workspace:FindFirstChild("FallenKingStone");

    if FallenKingStone then
        FallenKingStone = FallenKingStone:FindFirstChildWhichIsA("Model");
    end;

    if FallenKingStone and FallenKingStone:FindFirstChildWhichIsA("BasePart", true) then
        return FallenKingStone;
    end;

    return nil;
end;

local function overDeposit(p81) -- Line: 528
    return CFrame.new(p81.Position + Vector3.new(0, p81.Size.Y / 2 + 4, 0));
end;

local function buildBoard(p82) -- Line: 531
    -- upvalues: Folder (copy), Color3_fromRGB_ret3 (copy), u80 (ref), Game (copy), Color3_fromRGB_ret (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Name = "FallenKingBoard";
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = p82;
    Part.Parent = Folder;
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Size = UDim2.fromScale(9, 2.8);
    BillboardGui.MaxDistance = 140;
    BillboardGui.LightInfluence = 0;
    BillboardGui.Parent = Part;

    local function label(p83, p84, p85, p86) -- Line: 544
        -- upvalues: BillboardGui (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Position = UDim2.fromScale(0, p84);
        TextLabel.Size = UDim2.fromScale(1, p85);
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
        TextLabel.TextScaled = true;
        TextLabel.TextColor3 = p86;
        TextLabel.TextStrokeColor3 = Color3.fromRGB(8, 40, 16);
        TextLabel.TextStrokeTransparency = 0.2;
        TextLabel.Text = p83;
        TextLabel.Parent = BillboardGui;

        return TextLabel;
    end;

    label("THE FALLEN KING AWAKENS", 0, 0.32, Color3_fromRGB_ret3);
    u80 = {
        anchor = Part,
        value = label(("%.2f%%"):format((tonumber(Game:GetAttribute("FallenKingProgress")) or 0) * 100), 0.34, 0.66, Color3_fromRGB_ret)
    };
end;

local function refreshCauldron() -- Line: 561
    -- upvalues: u80 (ref), Game (copy)
    if u80 then
        u80.value.Text = ("%.2f%%"):format((tonumber(Game:GetAttribute("FallenKingProgress")) or 0) * 100);
    end;
end;

task.spawn(function() -- Line: 567
    -- upvalues: FallenKingConfig (copy), Game (copy), MapLocator (copy), u79 (ref), u80 (ref), buildBoard (copy)
    while true do
        if FallenKingConfig.active() then
            local v87;

            if Game:GetAttribute("FallenKingLiveWon") == true then
                local FallenKingStone = workspace:FindFirstChild("FallenKingStone");

                if FallenKingStone then
                    FallenKingStone = FallenKingStone:FindFirstChildWhichIsA("Model");
                end;

                if not (FallenKingStone and FallenKingStone:FindFirstChildWhichIsA("BasePart", true)) then
                    FallenKingStone = nil;
                end;

                v87 = FallenKingStone or nil;
            else
                v87 = nil;
            end;

            local v88;

            if v87 then
                v88 = nil;
            else
                v88 = MapLocator.interactable("Deposit") or nil;
            end;

            local v89 = nil;

            if v87 then
                local BoundingBox, v90 = v87:GetBoundingBox();
                u79 = BoundingBox.Position;
                v89 = CFrame.new(BoundingBox.Position + Vector3.new(0, v90.Y / 2 + 7.5, 0));
            elseif v88 and v88:IsA("BasePart") then
                u79 = v88;
                v89 = CFrame.new(v88.Position + Vector3.new(0, v88.Size.Y / 2 + 4, 0));
            end;

            if v89 then
                if u80 then
                    u80.anchor.CFrame = v89;
                else
                    buildBoard(v89);
                end;
            end;
        elseif u80 then
            u80.anchor:Destroy();
            u80 = nil;
        end;

        task.wait(2);
    end;
end);

local function launchSoul(u91, u92) -- Line: 599
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), icon (copy), trailOn (copy), Folder (copy), RunService (copy), burst (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Shape = Enum.PartType.Ball;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3_fromRGB_ret;
    Part.Size = Vector3.new(0.5, 0.5, 0.5);
    Part.Transparency = 1;
    Part.Color = Color3_fromRGB_ret3;
    local _, u93 = icon(Part, 1.3);
    trailOn(Part, 0.2, 0.35, 1.4);
    Part.CFrame = CFrame.new(u91);
    Part.Parent = Folder;
    local v94 = 5 + math.random() * 3;
    local v95 = math.random() - 0.5;
    local v96 = math.random() - 0.5;
    local v97 = Vector3.new(v95, 0, v96) * 4;
    local u98 = (u91 + u92) / 2 + Vector3.new(0, v94, 0) + v97;
    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 610
        -- upvalues: os_clock_ret (copy), u91 (copy), u98 (copy), Part (copy), u92 (copy), RunService (ref), burst (ref), u93 (copy)
        while os.clock() - os_clock_ret < 0.55 do
            local v99 = (os.clock() - os_clock_ret) / 0.55;
            local v100 = u91:Lerp(u98, v99);
            Part.CFrame = CFrame.new(v100:Lerp(u98:Lerp(u92, v99), v99));
            RunService.RenderStepped:Wait();
        end;

        burst(u92, 8);
        u93.ImageTransparency = 1;
        task.delay(0.4, function() -- Line: 619
            -- upvalues: Part (ref)
            Part:Destroy();
        end);
    end);
end;

local function erupt(p101, p102) -- Line: 625
    -- upvalues: Folder (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), TweenService (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), lanternParticles (copy), burst (copy), sound (copy)
    local u103 = {};

    local function piece(p104) -- Line: 627
        -- upvalues: Folder (ref), u103 (copy)
        p104.Parent = Folder;
        table.insert(u103, p104);

        return p104;
    end;

    local CFrame_Angles_ret = CFrame.Angles(0, 0, 1.5707963267948966);

    for _, v in {
        { 3.2, 0.25, Color3_fromRGB_ret },
        { 1.2, 0, Color3_fromRGB_ret4 }
    } do
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Parent = Folder;
        table.insert(u103, Part);
        Part.Shape = Enum.PartType.Cylinder;
        Part.Material = Enum.Material.Neon;
        Part.Color = v[3];
        Part.Transparency = v[2];
        Part.Size = Vector3.new(0.5, v[1], v[1]);
        Part.CFrame = CFrame.new(p101) * CFrame_Angles_ret;
        TweenService:Create(Part, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(22, v[1], v[1]),
            CFrame = CFrame.new(p101 + Vector3.new(0, 11, 0)) * CFrame_Angles_ret
        }):Play();
        task.delay(0.3, function() -- Line: 645
            -- upvalues: TweenService (ref), Part (copy)
            TweenService:Create(Part, TweenInfo.new(0.8), {
                Transparency = 1,
                Size = Vector3.new(26, 0.2, 0.2)
            }):Play();
        end);
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Parent = Folder;
    table.insert(u103, Part);
    Part.Shape = Enum.PartType.Cylinder;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3_fromRGB_ret2;
    Part.Transparency = 0.2;
    Part.Size = Vector3.new(0.15, 2, 2);
    Part.CFrame = CFrame.new(p101) * CFrame_Angles_ret;
    TweenService:Create(Part, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.15, 24, 24),
        Transparency = 1
    }):Play();
    local Part2 = Instance.new("Part");
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.CastShadow = false;
    Part2.Parent = Folder;
    table.insert(u103, Part2);
    Part2.Transparency = 1;
    Part2.Size = Vector3.new(1, 1, 1);
    Part2.CFrame = CFrame.new(p101 + Vector3.new(0, 3, 0));
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret;
    PointLight.Range = 32;
    PointLight.Brightness = 8;
    PointLight.Parent = Part2;
    TweenService:Create(PointLight, TweenInfo.new(1), {
        Brightness = 0
    }):Play();
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.8, 1.4);
    ParticleEmitter.Speed = NumberRange.new(8, 16);
    ParticleEmitter.SpreadAngle = Vector2.new(25, 25);
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top;
    ParticleEmitter.Drag = 1.5;
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Part2;
    ParticleEmitter:Emit(60);
    lanternParticles(Part2);
    task.delay(0.8, function() -- Line: 682
        -- upvalues: Part2 (copy)
        for _, child in Part2:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;
    end);
    burst(p101, 50);
    sound("Erupt", Part2);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Size = UDim2.fromOffset(220, 50);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 3, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.Parent = Part2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
    TextLabel.TextSize = 34;
    TextLabel.TextColor3 = Color3_fromRGB_ret3;
    TextLabel.TextStrokeColor3 = Color3.fromRGB(8, 40, 16);
    TextLabel.TextStrokeTransparency = 0.1;
    TextLabel.Text = p102 == 1 and "+1 SOUL" or ("+%d SOULS"):format(p102);
    TextLabel.Parent = BillboardGui;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 0.3;
    UIScale.Parent = BillboardGui;
    TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    TweenService:Create(BillboardGui, TweenInfo.new(1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        StudsOffsetWorldSpace = Vector3.new(0, 7, 0)
    }):Play();
    task.delay(1.1, function() -- Line: 713
        -- upvalues: TweenService (ref), TextLabel (copy)
        TweenService:Create(TextLabel, TweenInfo.new(0.6), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
    end);
    task.delay(2.4, function() -- Line: 716
        -- upvalues: u103 (copy)
        for _, v in u103 do
            v:Destroy();
        end;
    end);
end;

local function offered(u105) -- Line: 723
    -- upvalues: u79 (ref), u10 (ref), FallenKingConfig (copy), sound (copy), launchSoul (copy), erupt (copy)
    local u106 = u79;

    if typeof(u106) == "Instance" then
        if u106.Parent then
            u106 = u106.Position;
        else
            u106 = nil;
        end;
    end;

    local u107 = u10;

    if not (u107 and u106) then
        return;
    end;

    u107.override = #FallenKingConfig.LanternLevels;
    u107.shakeUntil = os.clock() + 0.5 + 0.25;
    sound("Charge", u107.glow);
    local math_clamp_ret = math.clamp(u105, 1, 10);
    task.delay(0.5, function() -- Line: 733
        -- upvalues: math_clamp_ret (copy), u10 (ref), launchSoul (ref), u106 (copy), sound (ref), u107 (copy)
        for i = 1, math_clamp_ret do
            local v108 = u10 and (u10.glow and (u10.glow.Parent and u10.glow.Position)) or nil;

            if v108 then
                launchSoul(v108, u106);
                sound("Launch", u107.glow);
            end;

            task.wait(0.09);
            local _ = i;
        end;
    end);
    task.delay((math_clamp_ret - 1) * 0.09 + 0.5 + 0.55, function() -- Line: 743
        -- upvalues: erupt (ref), u106 (copy), u105 (copy), u10 (ref), u107 (copy)
        erupt(u106, u105);

        if u10 == u107 then
            u107.override = nil;
        end;
    end);
end;

local FallenKingEvent = Game:WaitForChild("FallenKingEvent", 30);

if FallenKingEvent then
    FallenKingEvent.OnClientEvent:Connect(function(p109, p110) -- Line: 756
        -- upvalues: collected (copy), offered (copy), ChickenOrHero (copy)
        if p109 == "Collected" and type(p110) == "string" then
            collected(p110);

            return;
        end;

        if p109 == "Offered" and type(p110) == "number" then
            offered(p110);

            return;
        end;

        if p109 == "Reward" and type(p110) == "table" then
            for _, v in p110 do
                if type(v) == "string" then
                    task.spawn(function() -- Line: 765
                        -- upvalues: ChickenOrHero (ref), v (copy)
                        local success, result = pcall(function() -- Line: 766
                            -- upvalues: ChickenOrHero (ref), v (ref)
                            local v111;

                            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                                v111 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
                            else
                                v111 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
                            end;

                            require(v111).show("THE FALLEN KING: " .. v);
                        end);

                        if not success then
                            warn("FallenKingClient reward toast: " .. tostring(result));
                        end;
                    end);
                end;
            end;
        end;
    end);
end;

local FallenKingSouls = Game:WaitForChild("FallenKingSouls", 30);

if FallenKingSouls then
    FallenKingSouls.ChildAdded:Connect(addSoul);
    FallenKingSouls.ChildRemoved:Connect(function(p112) -- Line: 785
        -- upvalues: removeSoul (copy)
        task.delay(0.15, removeSoul, p112.Name);
    end);

    for _, child in FallenKingSouls:GetChildren() do
        addSoul(child);
    end;
end;

Game:GetAttributeChangedSignal("FallenKingProgress"):Connect(refreshCauldron);
RunService.RenderStepped:Connect(function(p113) -- Line: 795
    -- upvalues: u56 (copy), LocalPlayer (copy), u11 (ref), FallenKingConfig (copy), ensureLantern (copy), stepLantern (copy), u10 (ref), dropLantern (copy), stepPours (copy)
    local os_clock_ret = os.clock();

    for _, v in u56 do
        local phase = v.phase;
        local fx = v.fx;
        local CFrame_new = CFrame.new;
        local v114 = v.body + Vector3.new(0, 1.5, 0);
        local v115 = math.sin(os_clock_ret * 1.6 + phase) * 0.3;
        fx.CFrame = CFrame_new(v114 + Vector3.new(0, v115, 0));

        if os_clock_ret - v.born > 0.45 then
            local v116 = (math.sin(os_clock_ret * 5 + phase) * 0.06 + 1) * 2.6;
            v.gui.Size = UDim2.fromScale(v116, v116);
        end;

        v.image.Rotation = math.sin(os_clock_ret * 1.3 + phase) * 8;
        v.light.Brightness = math.sin(os_clock_ret * 9 + phase) * 0.35 + 1.7 + math.sin(os_clock_ret * 23 + phase) * 0.2;
    end;

    local v117 = tonumber(LocalPlayer:GetAttribute("FallenKingCarried")) or 0;

    if v117 > 0 then
        u11 = true;
    end;

    if u11 and (FallenKingConfig.active() and LocalPlayer:GetAttribute("CutsceneActive") ~= true) then
        if ensureLantern() then
            stepLantern(p113, os_clock_ret, v117);
        end;
    elseif u10 then
        dropLantern();
    end;

    stepPours(os_clock_ret);
end);