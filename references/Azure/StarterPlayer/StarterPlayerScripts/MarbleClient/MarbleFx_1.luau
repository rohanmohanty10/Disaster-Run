 
 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Config = require(ReplicatedStorage:WaitForChild("Marble"):WaitForChild("Config"));
local u1 = {};
local Folder = Instance.new("Folder");
Folder.Name = "MarbleFx";
Folder.Parent = workspace;

local function nearCamera(p2: vector) -- Line: 19
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v3;

    if workspace_CurrentCamera == nil then
        v3 = false;
    else
        v3 = (workspace_CurrentCamera.CFrame.Position - p2).Magnitude <= 400;
    end;

    return v3;
end;

local function anchorAt(p4: vector, p5: number) -- Line: 24
    -- upvalues: Folder (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p4);
    Part.Parent = Folder;
    Debris:AddItem(Part, p5);

    return Part;
end;

function u1.playSound(p6: string, p7: userdata, p8: number, p9: number?) -- Line: 38
    -- upvalues: Debris (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = p6;
    Sound.Volume = p8;
    Sound.PlaybackSpeed = p9 or 1;
    Sound.RollOffMinDistance = 10;
    Sound.RollOffMaxDistance = 250;
    Sound.Parent = p7;
    Sound:Play();
    Debris:AddItem(Sound, 4);

    return Sound;
end;

local function sparks(p10: userdata, p11: userdata, p12: number, p13: number) -- Line: 51
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p10;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = p11;
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(0.25, 0.6);
    ParticleEmitter.Speed = NumberRange.new(p13 * 0.5, p13);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 4;
    ParticleEmitter.Acceleration = Vector3.new(0, -30, 0);
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Attachment;
    ParticleEmitter:Emit(p12);
end;

local function ring(p14: vector, p15: vector, p16: number, p17, p18: number) -- Line: 70
    -- upvalues: Folder (copy), TweenService (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Shape = Enum.PartType.Cylinder;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = p17;
    Part.Transparency = 0.2;
    Part.Size = Vector3.new(0.15, 1, 1);
    Part.CFrame = CFrame.lookAt(p14, p14 + p15) * CFrame.Angles(0, 1.5707963267948966, 0);
    Part.Parent = Folder;
    TweenService:Create(Part, TweenInfo.new(p18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(0.15, p16, p16)
    }):Play();
    Debris:AddItem(Part, p18 + 0.1);
end;

local function flash(p19: userdata, p20, p21: number, p22: number, p23: number) -- Line: 92
    -- upvalues: TweenService (copy)
    local PointLight = Instance.new("PointLight");
    PointLight.Color = p20;
    PointLight.Brightness = p21;
    PointLight.Range = p22;
    PointLight.Parent = p19;
    TweenService:Create(PointLight, TweenInfo.new(p23), {
        Brightness = 0
    }):Play();
end;

local u24 = 0;
local u25 = 0;
local u26 = 0;
RunService:BindToRenderStep("MarbleCameraShake", Enum.RenderPriority.Camera.Value + 2, function(p27) -- Line: 106
    -- upvalues: u24 (ref), u26 (ref), u25 (ref)
    if u24 <= 0.001 then
        return;
    end;

    u26 = u26 + p27;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local v28 = math.noise(u26 * 25, 0.3, 0) * 2 * u24;
        local v29 = math.noise(0.7, u26 * 25, 0) * 2 * u24;
        workspace_CurrentCamera.CFrame = CFrame2 + CFrame2.RightVector * v28 + CFrame2.UpVector * v29;
    end;

    u24 = math.max(0, u24 - u25 * p27);
end);

function u1.shake(p30: number, p31: number) -- Line: 122
    -- upvalues: u24 (ref), u25 (ref)
    if u24 < p30 then
        u24 = p30;
        u25 = p30 / math.max(p31, 0.05);
    end;
end;

function u1.enter(p32: vector, p33, p34: number) -- Line: 130
    -- upvalues: Folder (copy), Debris (copy), u1 (copy), Config (copy), sparks (copy), ring (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v35;

    if workspace_CurrentCamera == nil then
        v35 = false;
    else
        v35 = (workspace_CurrentCamera.CFrame.Position - p32).Magnitude <= 400;
    end;

    if not v35 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p32);
    Part.Parent = Folder;
    Debris:AddItem(Part, 2);
    u1.playSound(Config.Sounds.Enter, Part, 0.7, 1.05);
    sparks(Part, ColorSequence.new(Color3.new(1, 1, 1), p33), 10, 10);
    ring(p32 - Vector3.new(0, p34 / 2 - 0.2, 0), Vector3.new(0, 1, 0), p34 * 1.6, p33, 0.3);
end;

function u1.exit(p36: vector, p37, p38: number) -- Line: 141
    -- upvalues: Folder (copy), Debris (copy), u1 (copy), Config (copy), sparks (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v39;

    if workspace_CurrentCamera == nil then
        v39 = false;
    else
        v39 = (workspace_CurrentCamera.CFrame.Position - p36).Magnitude <= 400;
    end;

    if not v39 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p36);
    Part.Parent = Folder;
    Debris:AddItem(Part, 3);
    u1.playSound(Config.Sounds.Exit, Part, 0.7, 0.85);
    sparks(Part, ColorSequence.new(p37), 14, 18);
    local v40 = p38 / 2;

    for i = 1, 8 do
        local Part2 = Instance.new("Part");
        local v41 = math.random(3, 7) / 10;
        local v42 = math.random(3, 7) / 10;
        Part2.Size = Vector3.new(v41, v42, 0.08);
        Part2.Material = Enum.Material.Glass;
        Part2.Color = p37;
        Part2.Transparency = 0.5;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CanTouch = false;
        Part2.CastShadow = false;
        local v43 = math.random() - 0.5;
        local v44 = math.random() * 0.8;
        local v45 = math.random() - 0.5;
        local Vector3_new_ret = Vector3.new(v43, v44, v45);
        local v46 = Vector3_new_ret.Magnitude <= 0.001 and Vector3.new(0, 1, 0) or Vector3_new_ret.Unit;
        Part2.CFrame = CFrame.new(p36 + v46 * v40 * 0.9) * CFrame.Angles(math.random() * 6, math.random() * 6, i);
        Part2.AssemblyLinearVelocity = v46 * math.random(18, 32) + Vector3.new(0, 12, 0);
        local math_random_ret = math.random(-12, 12);
        local math_random_ret2 = math.random(-12, 12);
        Part2.AssemblyAngularVelocity = Vector3.new(math_random_ret, math_random_ret2, math.random(-12, 12));
        Part2.Parent = Folder;
        TweenService:Create(Part2, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1
        }):Play();
        Debris:AddItem(Part2, 1);
        local _ = i;
    end;
end;

function u1.clash(p47: vector, p48: vector, p49: number, p50: string) -- Line: 171
    -- upvalues: Folder (copy), Debris (copy), sparks (copy), ring (copy), flash (copy), u1 (copy), Config (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v51;

    if workspace_CurrentCamera == nil then
        v51 = false;
    else
        v51 = (workspace_CurrentCamera.CFrame.Position - p47).Magnitude <= 400;
    end;

    if not v51 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p47);
    Part.Parent = Folder;
    Debris:AddItem(Part, 2);
    local v52 = p50 == "even";
    local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(120, 210, 255));

    if v52 then
        ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 240, 200), Color3.fromRGB(255, 120, 220));
    end;

    sparks(Part, ColorSequence_new_ret, math.floor(p49 * 40 + 18), p49 * 50 + 30);
    local v53;

    if v52 then
        v53 = Color3.fromRGB(255, 150, 230);
    else
        v53 = Color3.fromRGB(170, 230, 255);
    end;

    ring(p47, p48, p49 * 18 + 8, v53, 0.35);
    flash(Part, Color3.fromRGB(190, 235, 255), p49 * 6 + 4, p49 * 16 + 14, 0.3);
    u1.playSound(Config.Sounds.Clink, Part, p49 * 0.5 + 0.5, p49 * 0.3 + 0.9);
    u1.playSound(Config.Sounds.Clash, Part, p49 * 0.6 + 0.4, 1.15 - p49 * 0.3);
end;

function u1.impact(p54: vector, p55: vector, p56: number) -- Line: 188
    -- upvalues: Folder (copy), Debris (copy), sparks (copy), ring (copy), u1 (copy), Config (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v57;

    if workspace_CurrentCamera == nil then
        v57 = false;
    else
        v57 = (workspace_CurrentCamera.CFrame.Position - p54).Magnitude <= 400;
    end;

    if not v57 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p54);
    Part.Parent = Folder;
    Debris:AddItem(Part, 2);
    sparks(Part, ColorSequence.new(Color3.fromRGB(220, 240, 255)), math.floor(p56 * 20 + 8), p56 * 30 + 18);
    ring(p54, p55, p56 * 8 + 5, Color3.fromRGB(200, 235, 255), 0.25);
    u1.playSound(Config.Sounds.Impact, Part, p56 * 0.5 + 0.35, 1.1 - p56 * 0.25);
end;

function u1.dashCharge(p58: userdata) -- Line: 200
    -- upvalues: Config (copy)
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "MarbleDashCharge";
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.new(1, 1, 1), Config.DashColor);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(0.25, 0.35);
    ParticleEmitter.Speed = NumberRange.new(8, 11);
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Sphere;
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface;
    ParticleEmitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward;
    ParticleEmitter.Rate = 20;
    ParticleEmitter.Parent = p58;

    return ParticleEmitter;
end;

function u1.dash(p59: vector, p60: vector, p61: number, p62: userdata?) -- Line: 220
    -- upvalues: Folder (copy), Debris (copy), ring (copy), Config (copy), sparks (copy), u1 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v63;

    if workspace_CurrentCamera == nil then
        v63 = false;
    else
        v63 = (workspace_CurrentCamera.CFrame.Position - p59).Magnitude <= 400;
    end;

    if not v63 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    Part.CFrame = CFrame.new(p59);
    Part.Parent = Folder;
    Debris:AddItem(Part, 2.5);
    ring(p59 - p60 * 2, p60, p61 * 9 + 7, Config.DashColor, 0.3);
    sparks(Part, ColorSequence.new(Color3.new(1, 1, 1), Config.DashColor), math.floor(p61 * 18 + 8), p61 * 24 + 16);
    u1.playSound(Config.Sounds.Dash, p62 or Part, p61 * 0.35 + 0.45, 1.15 - p61 * 0.2);
end;

return u1;