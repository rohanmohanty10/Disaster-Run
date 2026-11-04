 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PhysicsService = game:GetService("PhysicsService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local GearCatalog = require(ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearCatalog"));
local HauntConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("HauntConfig"));
local GearEvent = ChickenOrHero.Gear:WaitForChild("GearEvent");
local PiratesCall = GearCatalog.Items.PiratesCall;

if not PiratesCall then
    return;
end;

local Color3_fromRGB_ret = Color3.fromRGB(110, 230, 170);
local success, result = pcall(PhysicsService.IsCollisionGroupRegistered, PhysicsService, "CoHRagdoll");
local u1 = success and result and "CoHRagdoll" or "Default";
local Folder = Instance.new("Folder");
Folder.Name = "PiratesCall";
Folder.Parent = workspace;
local Model = Instance.new("Model");
Model.Name = "Crew";
local Highlight = Instance.new("Highlight");
Highlight.Adornee = Model;
Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
Highlight.FillColor = Color3_fromRGB_ret;
Highlight.OutlineColor = Color3_fromRGB_ret;
Highlight.FillTransparency = 0.75;
Highlight.OutlineTransparency = 0.1;
Highlight.Enabled = false;
Highlight.Parent = Model;
Model.Parent = Folder;
local Animation = Instance.new("Animation");
Animation.AnimationId = HauntConfig.Anims.SkeletonSummon;
local Animation2 = Instance.new("Animation");
Animation2.AnimationId = HauntConfig.Anims.SkeletonWalk;
local u2 = {};
local u3 = 0;
local u4 = nil;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;

local function refreshFilter() -- Line: 57
    -- upvalues: Folder (copy), Players (copy), RaycastParams_new_ret (copy)
    local v5 = { Folder };

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v5, v.Character);
        end;
    end;

    local ClientBots = workspace:FindFirstChild("ClientBots");

    if ClientBots then
        table.insert(v5, ClientBots);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v5;
end;

local function sound(p6, p7, p8) -- Line: 71
    local Sound = Instance.new("Sound");
    Sound.SoundId = p6;
    Sound.Volume = p8 or 0.7;
    Sound.PlaybackSpeed = 0.92 + math.random() * 0.16;
    Sound.RollOffMinDistance = 8;
    Sound.RollOffMaxDistance = 120;
    Sound.Parent = p7;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 80
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);

    return Sound;
end;

local function dirt(p9) -- Line: 86
    -- upvalues: Folder (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(4, 0.2, 4);
    Part.CFrame = CFrame.new(p9);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(74, 54, 38), Color3.fromRGB(40, 30, 24));
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 2.2) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1.2);
    ParticleEmitter.Speed = NumberRange.new(5, 11);
    ParticleEmitter.SpreadAngle = Vector2.new(65, 65);
    ParticleEmitter.Acceleration = Vector3.new(0, -14, 0);
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top;
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Part;
    Part.Parent = Folder;
    ParticleEmitter:Emit(22);
    task.delay(2.5, function() -- Line: 106
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local function refreshOutline() -- Line: 111
    -- upvalues: u2 (copy), Highlight (copy)
    local v10 = false;

    for _, v in u2 do
        if not v.broken then
            v10 = true;
            break;
        end;
    end;

    Highlight.Enabled = v10;
end;

local function remove(p11) -- Line: 122
    -- upvalues: u2 (copy), u3 (ref), u4 (ref), Highlight (copy)
    local v12 = u2[p11];

    if not v12 then
        return;
    end;

    u2[p11] = nil;
    u3 = u3 - 1;

    if v12.model.Parent then
        v12.model:Destroy();
    end;

    if u3 <= 0 and u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    local v13 = false;

    for _, v in u2 do
        if not v.broken then
            v13 = true;
            break;
        end;
    end;

    Highlight.Enabled = v13;
end;

local function shatter(u14, p15, p16) -- Line: 140
    -- upvalues: u2 (copy), Folder (copy), Highlight (copy), sound (copy), PiratesCall (copy), u1 (copy), TweenService (copy), u3 (ref), u4 (ref)
    local v17 = u2[u14];

    if not v17 or v17.broken then
        return;
    end;

    v17.broken = true;

    for _, v in v17.tracks do
        v:Stop(0);
    end;

    local model = v17.model;

    if typeof(p15) == "Vector3" then
        model:PivotTo(CFrame.lookAt(p15 + Vector3.new(0, 1, 0) * v17.lift, p15 + Vector3.new(0, 1, 0) * v17.lift + v17.direction));
    end;

    model.Parent = Folder;
    local v18 = false;

    for _, v in u2 do
        if not v.broken then
            v18 = true;
            break;
        end;
    end;

    Highlight.Enabled = v18;
    sound(PiratesCall.Sounds.Break, v17.root, 0.9);
    local v19 = typeof(p16) == "Vector3" and p16 and p16 or v17.direction;

    for _, child in model:GetChildren() do
        if child:IsA("MeshPart") and child.Transparency < 1 then
            for _, child2 in child:GetChildren() do
                if child2:IsA("WeldConstraint") then
                    child2:Destroy();
                end;
            end;
        end;
    end;

    for _, child in model:GetChildren() do
        if child:IsA("Humanoid") or child:IsA("BasePart") and (not child:IsA("MeshPart") or child.Transparency >= 1) then
            child:Destroy();
        end;
    end;

    for _, child in model:GetChildren() do
        if child:IsA("BasePart") then
            child.Anchored = false;
            child.Massless = false;
            child.CanCollide = true;
            child.CollisionGroup = u1;
            local v20 = v19 * math.random(8, 16);
            local math_random_ret = math.random(-6, 6);
            local math_random_ret2 = math.random(8, 15);
            child.AssemblyLinearVelocity = v20 + Vector3.new(math_random_ret, math_random_ret2, math.random(-6, 6));
            local math_random_ret3 = math.random(-9, 9);
            local math_random_ret4 = math.random(-9, 9);
            child.AssemblyAngularVelocity = Vector3.new(math_random_ret3, math_random_ret4, math.random(-9, 9));
        end;
    end;

    task.delay(1.4, function() -- Line: 182
        -- upvalues: model (copy), TweenService (ref), u14 (copy), u2 (ref), u3 (ref), u4 (ref), Highlight (ref)
        if not model.Parent then
            return;
        end;

        for _, descendant in model:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.8), {
                    Transparency = 1
                }):Play();
            end;
        end;

        task.delay(0.9, function() -- Line: 191
            -- upvalues: u14 (ref), u2 (ref), u3 (ref), u4 (ref), Highlight (ref)
            local v21 = u14;
            local v22 = u2[v21];

            if not v22 then
                return;
            end;

            u2[v21] = nil;
            u3 = u3 - 1;

            if v22.model.Parent then
                v22.model:Destroy();
            end;

            if u3 <= 0 and u4 then
                u4:Disconnect();
                u4 = nil;
            end;

            local v23 = false;

            for _, v in u2 do
                if not v.broken then
                    v23 = true;
                    break;
                end;
            end;

            Highlight.Enabled = v23;
        end);
    end);
end;

local function step(p24) -- Line: 197
    -- upvalues: u2 (copy), u3 (ref), u4 (ref), Highlight (copy), RaycastParams_new_ret (copy), PiratesCall (copy)
    local os_clock_ret = os.clock();

    for i, v in u2 do
        if not v.broken then
            if v.expires < os_clock_ret then
                local v25 = u2[i];

                if v25 then
                    u2[i] = nil;
                    u3 = u3 - 1;

                    if v25.model.Parent then
                        v25.model:Destroy();
                    end;

                    if u3 <= 0 and u4 then
                        u4:Disconnect();
                        u4 = nil;
                    end;

                    local v26 = false;

                    for _, v2 in u2 do
                        if not v2.broken then
                            v26 = true;
                            break;
                        end;
                    end;

                    Highlight.Enabled = v26;
                end;
            else
                local v27;

                if v.chargeAt and v.chargeAt <= os_clock_ret then
                    local v28 = v.position + v.direction * v.speed * p24;
                    local v29 = workspace:Raycast(v28 + Vector3.new(0, 3, 0), Vector3.new(-0, -6, -0), RaycastParams_new_ret);

                    if v29 then
                        v28 = Vector3.new(v28.X, v29.Position.Y, v28.Z);
                    end;

                    v.position = v28;
                    v27 = v.position;
                else
                    local math_clamp_ret = math.clamp((os_clock_ret - v.born) / PiratesCall.RiseSeconds, 0, 1);
                    v27 = v.position - Vector3.new(0, 4.6, 0) * (1 - math_clamp_ret) ^ 2;
                end;

                local v30 = v27 + Vector3.new(0, 1, 0) * v.lift;
                v.root.CFrame = CFrame.lookAt(v30, v30 + v.direction);
            end;
        end;
    end;
end;

local function build(p31, p32, p33) -- Line: 224
    -- upvalues: ReplicatedStorage (copy), u2 (copy), PiratesCall (copy), Model (copy), Animation (copy), Animation2 (copy), u3 (ref), dirt (copy), sound (copy), Highlight (copy), u4 (ref), refreshFilter (copy), RunService (copy), step (copy)
    local Skeleton = ReplicatedStorage:FindFirstChild("Skeleton");

    if not (Skeleton and (not u2[p31.id] and typeof(p31.position) == "Vector3")) then
        return;
    end;

    local v34 = Skeleton:Clone();

    for _, descendant in v34:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Anchored = false;
            descendant.Massless = true;
        end;
    end;

    local HumanoidRootPart = v34:FindFirstChild("HumanoidRootPart");
    local v35 = v34:FindFirstChildOfClass("Humanoid");

    if not (HumanoidRootPart and v35) then
        v34:Destroy();

        return;
    end;

    HumanoidRootPart.Anchored = true;
    v34.PrimaryPart = HumanoidRootPart;
    v35.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v35.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    local v36 = v34:FindFirstChild("Left Leg");
    local v37 = not v36 and 3 or HumanoidRootPart.Position.Y - (v36.Position.Y - v36.Size.Y / 2);
    local os_clock_ret = os.clock();
    local v38 = {
        model = v34,
        root = HumanoidRootPart,
        position = p31.position,
        direction = p32,
        lift = v37,
        born = os_clock_ret,
        speed = PiratesCall.Speed,
        expires = os_clock_ret + (p33 or PiratesCall.RiseSeconds) + PiratesCall.ChargeSeconds + 2
    };
    HumanoidRootPart.CFrame = CFrame.lookAt(p31.position + Vector3.new(0, 1, 0) * (v37 - 4.6), p31.position + Vector3.new(0, 1, 0) * (v37 - 4.6) + p32);
    v34.Name = p31.id;
    v34.Parent = Model;
    local v39 = v35:FindFirstChildOfClass("Animator") or Instance.new("Animator", v35);
    v38.tracks = {
        summon = v39:LoadAnimation(Animation),
        walk = v39:LoadAnimation(Animation2)
    };
    v38.tracks.summon.Looped = false;
    v38.tracks.walk.Looped = true;
    v38.tracks.summon:Play(0);
    u2[p31.id] = v38;
    u3 = u3 + 1;
    dirt(p31.position);
    sound(PiratesCall.Sounds.Call, HumanoidRootPart, 0.6);
    local v40 = false;

    for _, v in u2 do
        if not v.broken then
            v40 = true;
            break;
        end;
    end;

    Highlight.Enabled = v40;

    if not u4 then
        refreshFilter();
        u4 = RunService.RenderStepped:Connect(step);
    end;
end;

GearEvent.OnClientEvent:Connect(function(p41, p42) -- Line: 280
    -- upvalues: build (copy), u2 (copy), PiratesCall (copy), shatter (copy), sound (copy), HauntConfig (copy)
    if p41 ~= "FX" or type(p42) ~= "table" then
        return;
    end;

    local kind = p42.kind;

    if kind == "PiratesCall" then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if type(p42.crew) ~= "table" or (typeof(p42.position) ~= "Vector3" or workspace_CurrentCamera and (workspace_CurrentCamera.CFrame.Position - p42.position).Magnitude > 260) then
            return;
        end;

        local v43 = typeof(p42.direction) == "Vector3" and (p42.direction or Vector3.new(0, 0, 1)) or Vector3.new(0, 0, 1);

        for _, v in p42.crew do
            if type(v) == "table" and type(v.id) == "string" then
                build(v, v43, p42.rise);
            end;
        end;

        return;
    end;

    if kind ~= "PirateCharge" then
        if kind == "PirateBreak" then
            shatter(p42.id, p42.position, p42.direction);

            return;
        end;

        if kind == "PirateHit" then
            local character = p42.character;
            local v44;

            if typeof(character) == "Instance" then
                v44 = character:FindFirstChild("HumanoidRootPart");
            else
                v44 = false;
            end;

            if v44 then
                sound(HauntConfig.Sounds.Impact[1], v44, 0.9);
            end;
        end;

        return;
    end;

    local v45 = u2[p42.id];

    if not (v45 and (not v45.broken and typeof(p42.direction) == "Vector3")) then
        return;
    end;

    v45.direction = p42.direction;
    v45.speed = tonumber(p42.speed) or PiratesCall.Speed;
    local v46 = workspace:GetServerTimeNow() - (tonumber(p42.serverTime) or 0);
    local math_clamp_ret = math.clamp(v46, 0, 0.3);
    local v47;

    if typeof(p42.position) == "Vector3" then
        v47 = p42.position + v45.direction * v45.speed * math_clamp_ret;
    else
        v47 = nil;
    end;

    if v45.chargeAt then
        if v47 then
            v45.position = v45.position:Lerp(v47, 0.5);
        end;

        return;
    end;

    if v47 then
        v45.position = v47;
    end;

    v45.chargeAt = os.clock();
    v45.tracks.summon:Stop(0.1);
    v45.tracks.walk:Play(0.1);
    v45.tracks.walk:AdjustSpeed(1.8);
end);