 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local GearCatalog = require(ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearCatalog"));
local PumpkinSmoke = require(ChickenOrHero.Gear:WaitForChild("PumpkinSmoke"));
local GearEvent = ChickenOrHero.Gear:WaitForChild("GearEvent");
local PumpkinBomb = GearCatalog.Items.PumpkinBomb;
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 145, 50)), ColorSequenceKeypoint.new(0.45, Color3.fromRGB(225, 95, 20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 45, 15)) });
local Color3_fromRGB_ret = Color3.fromRGB(255, 140, 40);
local IconImage = PumpkinBomb.IconImage;
local u1 = {};

local function sharePuffs() -- Line: 36
    -- upvalues: u1 (copy)
    local v2 = 0;

    for i in u1 do
        if i.Parent and i.Enabled then
            v2 = v2 + 1;
        else
            u1[i] = nil;
        end;
    end;

    local v3 = v2 <= 0 and 14 or math.clamp(20 / v2, 6, 14);

    for i in u1 do
        i.Rate = v3;
    end;
end;

local Folder = Instance.new("Folder");
Folder.Name = "PumpkinBombLocal";
Folder.Parent = workspace;

local function bare(p4) -- Line: 55
    p4.Anchored = true;
    p4.CanCollide = false;
    p4.CanQuery = false;
    p4.CanTouch = false;
    p4.CastShadow = false;
end;

local function kp(p5, p6) -- Line: 60
    return NumberSequenceKeypoint.new(p5, p6);
end;

local function sound(p7, p8, p9, p10) -- Line: 64
    -- upvalues: Debris (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = p7;
    Sound.Volume = p9;
    Sound.PlaybackSpeed = p10 or 1;
    Sound.RollOffMinDistance = 10;
    Sound.RollOffMaxDistance = 110;
    Sound.Parent = p8;
    Sound:Play();
    Debris:AddItem(Sound, 5);
end;

local function chunks(p11, p12) -- Line: 77
    -- upvalues: Color3_fromRGB_ret (copy), Folder (copy), TweenService (copy), Debris (copy)
    for i = 1, p12 do
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Material = Enum.Material.SmoothPlastic;
        Part.Color = Color3_fromRGB_ret:Lerp(Color3.fromRGB(200, 80, 20), math.random());
        Part.Size = Vector3.new(0.35, 0.2, 0.35) * (0.7 + math.random() * 0.6);
        Part.CFrame = CFrame.new(p11) * CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6);
        Part.Parent = Folder;
        local v13 = math.random() * 2 - 1;
        local v14 = 0.4 + math.random() * 0.8;
        local v15 = math.random() * 2 - 1;
        local Unit = Vector3.new(v13, v14, v15).Unit;
        TweenService:Create(Part, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            CFrame = Part.CFrame * CFrame.Angles(3, 2, 1) + Unit * (4 + math.random() * 3)
        }):Play();
        Debris:AddItem(Part, 0.6);
        local _ = i;
    end;
end;

local function smoke(p16, p17, p18) -- Line: 98
    -- upvalues: Players (copy), ColorSequence_new_ret (copy), kp (copy), IconImage (copy), Color3_fromRGB_ret (copy), Folder (copy), u1 (copy), sharePuffs (copy), PumpkinSmoke (copy), PumpkinBomb (copy), chunks (copy), Debris (copy), TweenService (copy)
    local position = p16.position;
    local v19 = Players.LocalPlayer:GetAttribute("GameRole") == p16.team;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Name = "PumpkinSmoke";
    Part.Transparency = 1;
    Part.Size = Vector3.new(p17 * 1.5, 4, p17 * 1.5);
    Part.CFrame = CFrame.new(position + Vector3.new(0, 2, 0));
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Box;
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume;
    ParticleEmitter.Color = ColorSequence_new_ret;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, p17 * 0.6), NumberSequenceKeypoint.new(0.3, p17 * 0.95), kp(1, p17 * 1.15) });
    local v20 = v19 and 0.4 or 0;
    ParticleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.1, v20),
        NumberSequenceKeypoint.new(0.85, v20 + 0.05),
        kp(1, 1)
    });
    ParticleEmitter.Lifetime = NumberRange.new(4, 5);
    ParticleEmitter.Rate = 14;
    ParticleEmitter.Speed = NumberRange.new(0.5, 2);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-25, 25);
    ParticleEmitter.Acceleration = Vector3.new(0, 0.6, 0);
    ParticleEmitter.Drag = 1.5;
    ParticleEmitter.LightInfluence = 0.75;
    ParticleEmitter.LightEmission = 0.05;
    ParticleEmitter.Parent = Part;
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Texture = IconImage;
    ParticleEmitter2.Shape = Enum.ParticleEmitterShape.Box;
    ParticleEmitter2.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume;
    ParticleEmitter2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(0.3, 1.5), kp(1, 1.1) });
    ParticleEmitter2.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.2, 0.1),
        NumberSequenceKeypoint.new(0.75, 0.25),
        kp(1, 1)
    });
    ParticleEmitter2.Lifetime = NumberRange.new(2, 3);
    ParticleEmitter2.Rate = 3;
    ParticleEmitter2.Speed = NumberRange.new(0.5, 1.5);
    ParticleEmitter2.SpreadAngle = Vector2.new(25, 25);
    ParticleEmitter2.EmissionDirection = Enum.NormalId.Top;
    ParticleEmitter2.Acceleration = Vector3.new(0, 1, 0);
    ParticleEmitter2.Rotation = NumberRange.new(-20, 20);
    ParticleEmitter2.RotSpeed = NumberRange.new(-30, 30);
    ParticleEmitter2.LightEmission = 0.3;
    ParticleEmitter2.LightInfluence = 0.4;
    ParticleEmitter2.ZOffset = 3;
    ParticleEmitter2.Parent = Part;
    local ParticleEmitter3 = Instance.new("ParticleEmitter");
    ParticleEmitter3.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter3.Shape = Enum.ParticleEmitterShape.Box;
    ParticleEmitter3.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume;
    ParticleEmitter3.Color = ColorSequence.new(Color3.fromRGB(255, 210, 120), Color3_fromRGB_ret);
    ParticleEmitter3.LightEmission = 1;
    ParticleEmitter3.Size = NumberSequence.new(0.3, 0);
    ParticleEmitter3.Lifetime = NumberRange.new(0.6, 1.2);
    ParticleEmitter3.Rate = 6;
    ParticleEmitter3.Speed = NumberRange.new(1, 3);
    ParticleEmitter3.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter3.Acceleration = Vector3.new(0, 2, 0);
    ParticleEmitter3.ZOffset = 2;
    ParticleEmitter3.Parent = Part;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret;
    PointLight.Range = p17;
    PointLight.Brightness = 1.6;
    PointLight.Shadows = false;
    PointLight.Parent = Part;
    Part.Parent = Folder;
    u1[ParticleEmitter] = true;
    sharePuffs();
    PumpkinSmoke.add(position, p17, PumpkinBomb.Height, p16.team, p18 + 3);
    ParticleEmitter:Emit(30);
    ParticleEmitter3:Emit(12);
    ParticleEmitter2:Emit(4);
    chunks(position, 10);

    if PumpkinBomb.Sounds then
        local Burst = PumpkinBomb.Sounds.Burst;
        local Sound = Instance.new("Sound");
        Sound.SoundId = Burst;
        Sound.Volume = 0.8;
        Sound.PlaybackSpeed = 1;
        Sound.RollOffMinDistance = 10;
        Sound.RollOffMaxDistance = 110;
        Sound.Parent = Part;
        Sound:Play();
        Debris:AddItem(Sound, 5);
        local Hiss = PumpkinBomb.Sounds.Hiss;
        local Sound2 = Instance.new("Sound");
        Sound2.SoundId = Hiss;
        Sound2.Volume = 0.5;
        Sound2.PlaybackSpeed = 0.85;
        Sound2.RollOffMinDistance = 10;
        Sound2.RollOffMaxDistance = 110;
        Sound2.Parent = Part;
        Sound2:Play();
        Debris:AddItem(Sound2, 5);
    end;

    TweenService:Create(PointLight, TweenInfo.new(0.6), {
        Brightness = 0.5
    }):Play();
    task.delay(p18, function() -- Line: 179
        -- upvalues: Part (copy), ParticleEmitter (copy), ParticleEmitter3 (copy), ParticleEmitter2 (copy), u1 (ref), sharePuffs (ref), TweenService (ref), PointLight (copy)
        if Part.Parent then
            ParticleEmitter.Enabled = false;
            ParticleEmitter3.Enabled = false;
            ParticleEmitter2.Enabled = false;
            u1[ParticleEmitter] = nil;
            sharePuffs();
            TweenService:Create(PointLight, TweenInfo.new(1.5), {
                Brightness = 0
            }):Play();
        end;
    end);
    Debris:AddItem(Part, p18 + 5.5);
end;

local u25 = GearEvent.OnClientEvent:Connect(function(p21, p22) -- Line: 192
    -- upvalues: smoke (copy), PumpkinBomb (copy)
    if p21 ~= "FX" or (type(p22) ~= "table" or (p22.kind ~= "PumpkinSmoke" or typeof(p22.position) ~= "Vector3")) then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera and (workspace_CurrentCamera.CFrame.Position - p22.position).Magnitude <= 220 then
        local v23 = tonumber(p22.radius) or PumpkinBomb.Radius;
        local math_clamp_ret = math.clamp(v23, 2, 20);
        local v24 = tonumber(p22.seconds) or PumpkinBomb.Duration;
        smoke(p22, math_clamp_ret, (math.clamp(v24, 0.5, 15)));
    end;
end);
script.Destroying:Connect(function() -- Line: 202
    -- upvalues: u25 (copy), Folder (copy)
    u25:Disconnect();
    Folder:Destroy();
end);