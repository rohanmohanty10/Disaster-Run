 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PhysicsService = game:GetService("PhysicsService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local HauntConfig = require(Game:WaitForChild("HauntConfig"));
local CutsceneScreen = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("CutsceneScreen"));
local Session = Game:WaitForChild("Session");
local HauntMonsters = Game:WaitForChild("HauntMonsters", 120);
local HauntEvent = Game:WaitForChild("HauntEvent", 120);

if not (HauntMonsters and HauntEvent) then
    return;
end;

local Color3_fromRGB_ret = Color3.fromRGB(255, 140, 40);
local Color3_fromRGB_ret2 = Color3.fromRGB(176, 120, 255);
local Folder = Instance.new("Folder");
Folder.Name = "HauntRigs";
Folder.Parent = workspace;
local u1 = {};

local function on(p2, p3) -- Line: 28
    -- upvalues: u1 (copy)
    table.insert(u1, p2:Connect(p3));
end;

local function flat(p4) -- Line: 31
    return Vector3.new(p4.X, 0, p4.Z);
end;

local function unit(p5) -- Line: 34
    return p5.Magnitude > 0.01 and p5.Unit or Vector3.new(0, 0, 0);
end;

local success, result = pcall(PhysicsService.IsCollisionGroupRegistered, PhysicsService, "CoHRagdoll");
local u6 = success and result and "CoHRagdoll" or "Default";

local function animation(p7) -- Line: 43
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p7;

    return Animation;
end;

local Anims = HauntConfig.Anims;
local u8 = {};
local Idle = Anims.Idle;
local Animation = Instance.new("Animation");
Animation.AnimationId = Idle;
u8.Idle = Animation;
local v9 = {};
local ZombieWalk = Anims.ZombieWalk;
local Animation2 = Instance.new("Animation");
Animation2.AnimationId = ZombieWalk;
v9.Walk = Animation2;
local ZombieSummon = Anims.ZombieSummon;
local Animation3 = Instance.new("Animation");
Animation3.AnimationId = ZombieSummon;
v9.Summon = Animation3;
local ZombieBite = Anims.ZombieBite;
local Animation4 = Instance.new("Animation");
Animation4.AnimationId = ZombieBite;
v9.Attack = Animation4;
u8.Zombie = v9;
local v10 = {};
local SkeletonWalk = Anims.SkeletonWalk;
local Animation5 = Instance.new("Animation");
Animation5.AnimationId = SkeletonWalk;
v10.Walk = Animation5;
local SkeletonSummon = Anims.SkeletonSummon;
local Animation6 = Instance.new("Animation");
Animation6.AnimationId = SkeletonSummon;
v10.Summon = Animation6;
local SkeletonThrow = Anims.SkeletonThrow;
local Animation7 = Instance.new("Animation");
Animation7.AnimationId = SkeletonThrow;
v10.Attack = Animation7;
u8.Skeleton = v10;
local SoundService = game:GetService("SoundService");
local table_freeze_ret = table.freeze({
    ZombieGroan = "Voice",
    ZombieGroan2 = "Voice",
    ZombieGasp = "Voice",
    SkeletonRattle = "Voice",
    Rise = "Rise",
    ZombieBite = "Attack",
    SkeletonThrow = "Attack",
    Impact = "Attack",
    Downed = "Attack",
    SkeletonBreak = "Death",
    SkeletonBreak2 = "Death",
    ZombieDeath = "Death",
    KnifeStab = "Death"
});
local u11 = {
    Voice = {
        at = 2,
        gap = 2.5,
        range = 60,
        playing = 0,
        last = 0
    },
    Rise = {
        at = 3,
        gap = 0.3,
        range = 100,
        playing = 0,
        last = 0
    },
    Attack = {
        at = 3,
        gap = 0.25,
        range = 70,
        playing = 0,
        last = 0
    },
    Death = {
        at = 3,
        gap = 0.1,
        range = 100,
        playing = 0,
        last = 0
    }
};

local function sound(p12, p13, p14, p15) -- Line: 84
    -- upvalues: HauntConfig (copy), u11 (copy), table_freeze_ret (copy), SoundService (copy)
    local v16 = HauntConfig.Sounds[p12];

    if not v16 then
        return nil;
    end;

    local u17 = not p15 and u11[table_freeze_ret[p12]];

    if u17 then
        local os_clock_ret = os.clock();

        if u17.playing >= u17.at or os_clock_ret - u17.last < u17.gap then
            return nil;
        end;

        if p13 and (p13:IsA("BasePart") and (p13.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > u17.range) then
            return nil;
        end;

        u17.playing = u17.playing + 1;
        u17.last = os_clock_ret;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = v16[1];
    Sound.Volume = v16[2];
    Sound.PlaybackSpeed = p14 or 0.92 + math.random() * 0.16;
    Sound.RollOffMinDistance = 8;
    Sound.RollOffMaxDistance = not u17 and 140 or u17.range;

    if u17 then
        Sound.Destroying:Once(function() -- Line: 113
            -- upvalues: u17 (copy)
            local v18 = u17;
            v18.playing = v18.playing - 1;
        end);
    end;

    Sound.Parent = p13 or SoundService;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 119
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    task.delay(8, function() -- Line: 122
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);

    return Sound;
end;

local u19 = {
    Zombie = { "ZombieGroan", "ZombieGroan2", "ZombieGasp" },
    Skeleton = { "SkeletonRattle" }
};

local function dirt(p20) -- Line: 132
    -- upvalues: Folder (copy), sound (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(4, 0.2, 4);
    Part.CFrame = CFrame.new(p20);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(74, 54, 38), Color3.fromRGB(40, 30, 24));
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 2.4) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(0.7, 1.4);
    ParticleEmitter.Speed = NumberRange.new(5, 12);
    ParticleEmitter.SpreadAngle = Vector2.new(65, 65);
    ParticleEmitter.Acceleration = Vector3.new(0, -14, 0);
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-90, 90);
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top;
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Part;
    Part.Parent = Folder;
    ParticleEmitter:Emit(28);
    task.delay(0.35, function() -- Line: 153
        -- upvalues: ParticleEmitter (copy)
        if ParticleEmitter.Parent then
            ParticleEmitter:Emit(14);
        end;
    end);
    sound("Rise", Part);
    task.delay(3, function() -- Line: 159
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local u21 = {};
local u22 = {};
local Model = Instance.new("Model");
Model.Name = "Monsters";
local Highlight = Instance.new("Highlight");
Highlight.Name = "Outline";
Highlight.Adornee = Model;
Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
Highlight.FillColor = Color3_fromRGB_ret;
Highlight.OutlineColor = Color3_fromRGB_ret;
Highlight.FillTransparency = 0.9;
Highlight.OutlineTransparency = 0.1;
Highlight.Enabled = false;
Highlight.Parent = Model;
Model.Parent = Folder;

local function refreshOutline() -- Line: 186
    -- upvalues: u21 (copy), Highlight (copy)
    local v23 = false;

    for _, v in u21 do
        if not v.dead then
            v23 = true;
            break;
        end;
    end;

    Highlight.Enabled = v23;
end;

local function stopTracks(p24, p25) -- Line: 197
    for _, v in p24.tracks do
        if v.IsPlaying then
            v:Stop(p25 or 0.15);
        end;
    end;
end;

local function fadeAway(u26, p27, u28) -- Line: 205
    -- upvalues: TweenService (copy)
    task.delay(p27, function() -- Line: 206
        -- upvalues: u26 (copy), TweenService (ref), u28 (copy)
        if not u26.Parent then
            return;
        end;

        for _, descendant in u26:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                TweenService:Create(descendant, TweenInfo.new(u28), {
                    Transparency = 1
                }):Play();
            end;
        end;

        task.delay(u28 + 0.1, function() -- Line: 215
            -- upvalues: u26 (ref)
            u26:Destroy();
        end);
    end);
end;

local function die(p29) -- Line: 222
    -- upvalues: Folder (copy), u21 (copy), Highlight (copy), sound (copy), u6 (copy), TweenService (copy)
    p29.dead = true;

    for _, v in p29.tracks do
        if v.IsPlaying then
            v:Stop(0);
        end;
    end;

    p29.model.Parent = Folder;
    local v30 = false;

    for _, v in u21 do
        if not v.dead then
            v30 = true;
            break;
        end;
    end;

    Highlight.Enabled = v30;
    local model = p29.model;
    local Attribute = p29.value:GetAttribute("HitFrom");
    local v31;

    if typeof(Attribute) == "Vector3" then
        local v32 = p29.root.Position - Attribute;
        local Vector3_new_ret = Vector3.new(v32.X, 0, v32.Z);
        v31 = Vector3_new_ret.Magnitude > 0.01 and Vector3_new_ret.Unit or Vector3.new(0, 0, 0) or Vector3.new(0, 0, 0);
    else
        v31 = Vector3.new(0, 0, 0);
    end;

    sound(p29.kind == "Skeleton" and (math.random() < 0.5 and "SkeletonBreak" or "SkeletonBreak2") or "ZombieDeath", p29.root);

    if p29.kind == "Skeleton" then
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
            if child:IsA("BasePart") and (not child:IsA("MeshPart") or child.Transparency >= 1) then
                child:Destroy();
            elseif child:IsA("Humanoid") then
                child:Destroy();
            end;
        end;

        for _, child in model:GetChildren() do
            if child:IsA("BasePart") then
                child.Anchored = false;
                child.Massless = false;
                child.CanCollide = true;
                child.CollisionGroup = u6;
                local v33 = v31 * math.random(10, 20);
                local math_random_ret = math.random(-6, 6);
                local math_random_ret2 = math.random(10, 18);
                child.AssemblyLinearVelocity = v33 + Vector3.new(math_random_ret, math_random_ret2, math.random(-6, 6));
                local math_random_ret3 = math.random(-9, 9);
                local math_random_ret4 = math.random(-9, 9);
                child.AssemblyAngularVelocity = Vector3.new(math_random_ret3, math_random_ret4, math.random(-9, 9));
            end;
        end;
    else
        for _, descendant in model:GetDescendants() do
            if descendant:IsA("Motor6D") and (descendant.Part0 and (descendant.Part1 and descendant.Name ~= "RootJoint")) then
                local Attachment = Instance.new("Attachment");
                Attachment.CFrame = descendant.C0;
                Attachment.Parent = descendant.Part0;
                local Attachment2 = Instance.new("Attachment");
                Attachment2.CFrame = descendant.C1;
                Attachment2.Parent = descendant.Part1;
                local BallSocketConstraint = Instance.new("BallSocketConstraint");
                BallSocketConstraint.Attachment0 = Attachment;
                BallSocketConstraint.Attachment1 = Attachment2;
                BallSocketConstraint.LimitsEnabled = true;
                BallSocketConstraint.TwistLimitsEnabled = true;
                BallSocketConstraint.UpperAngle = 70;
                BallSocketConstraint.TwistLowerAngle = -45;
                BallSocketConstraint.TwistUpperAngle = 45;
                BallSocketConstraint.Parent = descendant.Part0;
                descendant:Destroy();
            end;
        end;

        local v34 = model:FindFirstChildOfClass("Humanoid");

        if v34 then
            v34:Destroy();
        end;

        p29.root:Destroy();

        for _, descendant in model:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CollisionGroup = u6;
                descendant.CanCollide = not descendant:IsA("MeshPart");
                descendant.Massless = descendant:IsA("MeshPart");
            end;
        end;

        local Torso = model:FindFirstChild("Torso");

        if Torso then
            Torso.AssemblyLinearVelocity = v31 * 18 + Vector3.new(0, 10, 0);
            Torso.AssemblyAngularVelocity = v31:Cross(Vector3.new(0, 1, 0)) * -6;
        end;
    end;

    local u35 = 1;
    task.delay(1.8, function() -- Line: 206
        -- upvalues: model (copy), TweenService (ref), u35 (copy)
        if not model.Parent then
            return;
        end;

        for _, descendant in model:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                TweenService:Create(descendant, TweenInfo.new(u35), {
                    Transparency = 1
                }):Play();
            end;
        end;

        task.delay(u35 + 0.1, function() -- Line: 215
            -- upvalues: model (ref)
            model:Destroy();
        end);
    end);
end;

local function onState(u36) -- Line: 300
    -- upvalues: die (copy), dirt (copy), sound (copy), u19 (copy)
    if u36.dead then
        return;
    end;

    local Attribute = u36.value:GetAttribute("State");

    if Attribute == u36.state then
        return;
    end;

    u36.state = Attribute;

    if Attribute == "Dead" then
        die(u36);

        return;
    end;

    if Attribute ~= "Summon" then
        if Attribute == "Bite" or Attribute == "Throw" then
            u36.tracks.walk:Stop(0.1);
            u36.tracks.attack:Play(0.05);

            if Attribute == "Bite" then
                sound("ZombieBite", u36.root);

                return;
            end;
        else
            u36.tracks.summon:Stop(0.25);
        end;

        return;
    end;

    u36.tracks.walk:Stop(0);
    u36.tracks.summon:Play(0);
    u36.rise = os.clock();
    dirt(u36.pos - Vector3.new(0, 3, 0));
    task.delay(0.5, function() -- Line: 317
        -- upvalues: u36 (copy), sound (ref), u19 (ref)
        if not u36.dead and u36.root.Parent then
            sound(u19[u36.kind][math.random(1, #u19[u36.kind])], u36.root);
        end;
    end);
end;

local function build(p37) -- Line: 333
    -- upvalues: u21 (copy), ReplicatedStorage (copy), u8 (copy), Model (copy), u22 (copy), onState (copy), Highlight (copy)
    if u21[p37] then
        return;
    end;

    local Attribute = p37:GetAttribute("Kind");
    local v38;

    if type(Attribute) == "string" then
        v38 = ReplicatedStorage:FindFirstChild(Attribute);
    else
        v38 = false;
    end;

    if not (v38 and u8[Attribute]) then
        return;
    end;

    local v39 = v38:Clone();

    for _, descendant in v39:GetDescendants() do
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

    local HumanoidRootPart = v39:FindFirstChild("HumanoidRootPart");
    local v40 = v39:FindFirstChildOfClass("Humanoid");

    if not (HumanoidRootPart and v40) then
        v39:Destroy();

        return;
    end;

    HumanoidRootPart.Anchored = true;
    v39.PrimaryPart = HumanoidRootPart;
    v40.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v40.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    local v41 = p37:GetAttribute("P") or Vector3.new(0, 0, 0);
    local v42 = p37:GetAttribute("Yaw") or 0;
    HumanoidRootPart.CFrame = CFrame.new(v41) * CFrame.Angles(0, v42, 0);
    v39.Name = p37.Name;
    v39.Parent = Model;
    local v43 = v40:FindFirstChildOfClass("Animator") or Instance.new("Animator", v40);
    local v44 = u8[Attribute];
    local u45 = {
        value = p37,
        kind = Attribute,
        model = v39,
        root = HumanoidRootPart,
        pos = v41,
        yaw = v42,
        tracks = {
            idle = v43:LoadAnimation(u8.Idle),
            walk = v43:LoadAnimation(v44.Walk),
            summon = v43:LoadAnimation(v44.Summon),
            attack = v43:LoadAnimation(v44.Attack)
        }
    };
    u45.tracks.idle.Looped = true;
    u45.tracks.walk.Looped = true;
    u45.tracks.summon.Looped = false;
    u45.tracks.attack.Looped = false;
    u45.tracks.idle:Play(0);
    u45.nextVoice = os.clock() + 3 + math.random() * 4;
    u21[p37] = u45;
    u22[p37:GetAttribute("Id")] = u45;
    u45.stateConnection = p37:GetAttributeChangedSignal("State"):Connect(function() -- Line: 389
        -- upvalues: onState (ref), u45 (copy)
        onState(u45);
    end);
    onState(u45);
    local v46 = false;

    for _, v in u21 do
        if not v.dead then
            v46 = true;
            break;
        end;
    end;

    Highlight.Enabled = v46;
end;

table.insert(u1, HauntMonsters.ChildAdded:Connect(build));
table.insert(u1, HauntMonsters.ChildRemoved:Connect(function(p47) -- Line: 396, Name: unbuild
    -- upvalues: u21 (copy), u22 (copy), Folder (copy), TweenService (copy), Highlight (copy)
    local v48 = u21[p47];

    if not v48 then
        return;
    end;

    u21[p47] = nil;

    if u22[p47:GetAttribute("Id")] == v48 then
        u22[p47:GetAttribute("Id")] = nil;
    end;

    v48.stateConnection:Disconnect();

    if not v48.dead then
        for _, v in v48.tracks do
            if v.IsPlaying then
                v:Stop(0.2);
            end;
        end;

        v48.model.Parent = Folder;
        local model = v48.model;
        local u49 = 0.6;
        task.delay(0, function() -- Line: 206
            -- upvalues: model (copy), TweenService (ref), u49 (copy)
            if not model.Parent then
                return;
            end;

            for _, descendant in model:GetDescendants() do
                if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                    TweenService:Create(descendant, TweenInfo.new(u49), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            task.delay(u49 + 0.1, function() -- Line: 215
                -- upvalues: model (ref)
                model:Destroy();
            end);
        end);
    end;

    local v50 = false;

    for _, v in u21 do
        if not v.dead then
            v50 = true;
            break;
        end;
    end;

    Highlight.Enabled = v50;
end));

for _, child in HauntMonsters:GetChildren() do
    build(child);
end;

local u51 = {};

local function undress(p52) -- Line: 426
    -- upvalues: u51 (copy)
    local v53 = u51[p52];

    if not v53 then
        return;
    end;

    u51[p52] = nil;

    for _, v in v53.meshes do
        v[1]:Destroy();
    end;

    for _, descendant in p52:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = 0;
        end;
    end;
end;

local function dress(p54, p55) -- Line: 442
    -- upvalues: undress (copy), ReplicatedStorage (copy), Folder (copy), u51 (copy)
    undress(p54);
    local v56 = ReplicatedStorage:FindFirstChild(p55);

    if not v56 then
        return;
    end;

    local v57 = {
        meshes = {}
    };

    for _, child in v56:GetChildren() do
        if child:IsA("MeshPart") and child.Transparency < 1 then
            local v58 = child:FindFirstChildOfClass("WeldConstraint");

            if v58 then
                if v58.Part0 == child then
                    v58 = v58.Part1;
                else
                    v58 = v58.Part0;
                end;
            end;

            local v59;

            if v58 then
                v59 = p54:FindFirstChild(v58.Name);
            else
                v59 = v58;
            end;

            if v59 and v59:IsA("BasePart") then
                local v60 = child:Clone();
                v60:ClearAllChildren();
                v60.Anchored = true;
                v60.CanCollide = false;
                v60.CanQuery = false;
                v60.CanTouch = false;
                v60.Parent = Folder;
                local meshes = v57.meshes;
                local v61 = { v60, v59, v58.CFrame:ToObjectSpace(child.CFrame) };
                table.insert(meshes, v61);
            end;
        end;
    end;

    u51[p54] = v57;
end;

local function watchCharacter(u62) -- Line: 466
    -- upvalues: dress (copy), undress (copy)
    local function refresh() -- Line: 467
        -- upvalues: u62 (copy), dress (ref), undress (ref)
        local Attribute = u62:GetAttribute("HauntForm");

        if type(Attribute) == "string" then
            dress(u62, Attribute);

            return;
        end;

        undress(u62);
    end;

    u62:GetAttributeChangedSignal("HauntForm"):Connect(refresh);

    if u62:GetAttribute("HauntForm") then
        local Attribute = u62:GetAttribute("HauntForm");

        if type(Attribute) == "string" then
            dress(u62, Attribute);

            return;
        end;

        undress(u62);
    end;
end;

table.insert(u1, Players.PlayerAdded:Connect(function(p63) -- Line: 480, Name: watchPlayer
    -- upvalues: watchCharacter (copy), u1 (copy)
    table.insert(u1, p63.CharacterAdded:Connect(watchCharacter));

    if p63.Character then
        watchCharacter(p63.Character);
    end;
end));

for _, v in Players:GetPlayers() do
    table.insert(u1, v.CharacterAdded:Connect(watchCharacter));

    if v.Character then
        watchCharacter(v.Character);
    end;
end;

table.insert(u1, RunService.RenderStepped:Connect(function(p64) -- Line: 494
    -- upvalues: u21 (copy), u19 (copy), sound (copy), u51 (copy), undress (copy)
    local v65 = 1 - math.exp(-12 * p64);

    for i, v in u21 do
        if not v.dead and v.root.Parent then
            local Attribute = i:GetAttribute("P");
            local Attribute2 = i:GetAttribute("Yaw");

            if typeof(Attribute) == "Vector3" and type(Attribute2) == "number" then
                local Magnitude = (Attribute - v.pos).Magnitude;

                if Magnitude <= 30 then
                    Attribute = v.pos:Lerp(Attribute, v65);
                end;

                v.pos = Attribute;
                v.yaw = v.yaw + ((Attribute2 - v.yaw + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v65;
                local v66;

                if v.rise then
                    local v67 = (os.clock() - v.rise) / 1.3;
                    local math_clamp_ret = math.clamp(v67, 0, 1);
                    v66 = (1 - math_clamp_ret) * 4.6 * (1 - math_clamp_ret);

                    if math_clamp_ret >= 1 then
                        v.rise = nil;
                    end;
                else
                    v66 = 0;
                end;

                v.root.CFrame = CFrame.new(v.pos - Vector3.new(0, v66, 0)) * CFrame.Angles(0, v.yaw, 0);

                if os.clock() >= v.nextVoice then
                    v.nextVoice = os.clock() + 8 + math.random() * 7;
                    local v68 = u19[v.kind];
                    sound(v68[math.random(1, #v68)], v.root);
                end;

                local v69 = not (v.summonUntil and os.clock() < v.summonUntil and true or (v.tracks.summon.IsPlaying or v.tracks.attack.IsPlaying)) and Magnitude > 0.35;

                if v69 and not v.tracks.walk.IsPlaying then
                    v.tracks.walk:Play(0.2);
                elseif not v69 and v.tracks.walk.IsPlaying then
                    v.tracks.walk:Stop(0.25);
                end;
            end;
        end;
    end;

    for i, v in u51 do
        if i.Parent then
            for _, v2 in v.meshes do
                local v70 = v2[1];
                local v71 = v2[2];
                local v72 = v2[3];

                if v71.Parent then
                    v70.CFrame = v71.CFrame * v72;
                end;
            end;

            for _, descendant in i:GetDescendants() do
                if descendant:IsA("BasePart") and descendant.LocalTransparencyModifier < 1 then
                    descendant.LocalTransparencyModifier = 1;
                end;
            end;
        else
            undress(i);
        end;
    end;
end));
local u73;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots then
    u73 = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
else
    u73 = nil;
end;

local Color3_fromRGB_ret3 = Color3.fromRGB(235, 40, 50);
local Color3_new_ret = Color3.new(1, 1, 1);
local u74 = { Color3.fromRGB(125, 180, 60), Color3.fromRGB(60, 95, 30) };
local u75 = { Color3.fromRGB(240, 235, 220), Color3.fromRGB(175, 168, 148) };
local u76 = { Color3.fromRGB(255, 70, 70), Color3_fromRGB_ret2 };

local function characterOf(p77) -- Line: 563
    -- upvalues: Players (copy), u73 (copy)
    if type(p77) ~= "number" then
        return nil;
    end;

    local v78;

    if p77 > 0 then
        v78 = Players:GetPlayerByUserId(p77);
    else
        v78 = false;
    end;

    if v78 then
        return v78.Character;
    end;

    local v79 = u73 and u73.resolve(p77);

    return v79 and v79.Character or nil;
end;

local function flashModel(p80, p81, p82) -- Line: 576
    -- upvalues: Folder (copy), TweenService (copy)
    if typeof(p80) ~= "Instance" or not p80.Parent then
        return;
    end;

    local Highlight2 = Instance.new("Highlight");
    Highlight2.Adornee = p80;
    Highlight2.FillColor = p81;
    Highlight2.OutlineColor = p81;
    Highlight2.FillTransparency = 0.15;
    Highlight2.OutlineTransparency = 0;
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.Parent = Folder;
    TweenService:Create(Highlight2, TweenInfo.new(p82), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    task.delay(p82 + 0.05, function() -- Line: 587
        -- upvalues: Highlight2 (copy)
        Highlight2:Destroy();
    end);
end;

local function burst(p83, p84, p85, p86) -- Line: 593
    -- upvalues: Folder (copy)
    if typeof(p83) ~= "Vector3" then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p83);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Color = ColorSequence.new(p84[1], p84[2]);
    ParticleEmitter.LightEmission = 0.15;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 0.1) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0.2), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(0.35, 0.75);
    ParticleEmitter.Speed = NumberRange.new(p86 * 0.5, p86);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Acceleration = Vector3.new(0, -40, 0);
    ParticleEmitter.Drag = 2;
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-220, 220);
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Part;
    Part.Parent = Folder;
    ParticleEmitter:Emit(p85);
    task.delay(1.2, function() -- Line: 622
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local function soundAt(p87, p88) -- Line: 628
    -- upvalues: Folder (copy), sound (copy)
    if typeof(p88) ~= "Vector3" then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p88);
    Part.Parent = Folder;

    if sound(p87, Part) then
        task.delay(4, function() -- Line: 642
            -- upvalues: Part (copy)
            Part:Destroy();
        end);

        return;
    end;

    Part:Destroy();
end;

local u89 = 0;
RunService:BindToRenderStep("HauntShake", Enum.RenderPriority.Camera.Value + 1, function(p90) -- Line: 649
    -- upvalues: u89 (ref)
    if u89 < 0.0005 then
        u89 = 0;

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.Angles((math.random() - 0.5) * u89, (math.random() - 0.5) * u89, (math.random() - 0.5) * u89 * 0.5);
    end;

    u89 = u89 * math.exp(-14 * p90);
end);

local function kick(p91) -- Line: 664
    -- upvalues: u89 (ref)
    u89 = math.max(u89, p91);
end;

local u92 = {};

local function throwHead(p93, u94, u95, u96, p97, u98) -- Line: 672
    -- upvalues: u22 (copy), Folder (copy), sound (copy), u92 (copy), RunService (copy), TweenService (copy)
    if typeof(u94) ~= "Vector3" or (typeof(u95) ~= "Vector3" or (type(u96) ~= "number" or type(p97) ~= "number")) then
        return;
    end;

    local u99 = u22[p93];
    local u100;

    if u99 then
        u100 = u99.model:FindFirstChild("Skeleton Head One");
    else
        u100 = u99;
    end;

    local u101;

    if u100 then
        u101 = u100:Clone();
        u101:ClearAllChildren();
        u100.Transparency = 1;
        task.delay(1.4, function() -- Line: 684
            -- upvalues: u100 (copy), u99 (copy)
            if u100.Parent and not u99.dead then
                u100.Transparency = 0;
            end;
        end);
    else
        u101 = Instance.new("Part");
        u101.Shape = Enum.PartType.Ball;
        u101.Size = Vector3.new(1.2, 1.2, 1.2);
        u101.Color = Color3.fromRGB(230, 225, 210);
    end;

    u101.Anchored = true;
    u101.CanCollide = false;
    u101.CanQuery = false;
    u101.CanTouch = false;
    u101.Parent = Folder;
    sound("SkeletonThrow", u101);
    local u102 = p97 / u96;
    local os_clock_ret = os.clock();
    local u103 = {
        part = u101
    };

    if type(u98) == "number" then
        u92[u98] = u103;
    end;

    u103.connection = RunService.RenderStepped:Connect(function() -- Line: 704
        -- upvalues: os_clock_ret (copy), u102 (copy), u101 (ref), u103 (copy), u98 (copy), u92 (ref), TweenService (ref), u94 (copy), u95 (copy), u96 (copy)
        local v104 = os.clock() - os_clock_ret;

        if u102 > v104 and u101.Parent then
            u101.CFrame = CFrame.new(u94 + u95 * u96 * v104) * CFrame.Angles(v104 * 14, v104 * 9, 0);

            return;
        end;

        u103.connection:Disconnect();

        if type(u98) == "number" and u92[u98] == u103 then
            u92[u98] = nil;
        end;

        TweenService:Create(u101, TweenInfo.new(0.3), {
            Transparency = 1
        }):Play();
        task.delay(0.35, function() -- Line: 712
            -- upvalues: u101 (ref)
            u101:Destroy();
        end);
    end);
end;

local function stopHead(p105, p106) -- Line: 722
    -- upvalues: u92 (copy), burst (copy), u75 (copy), soundAt (copy)
    local v107 = u92[p105];

    if v107 then
        u92[p105] = nil;
        v107.connection:Disconnect();
        v107.part:Destroy();
    end;

    if typeof(p106) == "Vector3" then
        burst(p106, u75, 16, 16);
        soundAt("SkeletonBreak2", p106);
    end;
end;

local function text(p108, p109, p110, p111, p112, p113) -- Line: 738
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p109;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.new(0.5, 0, p113, 0);
    TextLabel.Size = UDim2.new(0.9, 0, 0, p111 + 8);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = p110;
    TextLabel.TextSize = p111;
    TextLabel.Font = Enum.Font.GothamBlack;
    TextLabel.TextColor3 = p112;
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.TextStrokeTransparency = 0.2;
    TextLabel.TextTransparency = 1;
    TextLabel.TextStrokeTransparency = 1;
    TextLabel.TextWrapped = true;
    TextLabel.Parent = p108;

    return TextLabel;
end;

local u114 = false;

local function cutscene(p115) -- Line: 760
    -- upvalues: u114 (ref), LocalPlayer (copy), u21 (copy), CutsceneScreen (copy), text (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), sound (copy), TweenService (copy)
    if u114 or type(p115) ~= "number" then
        return;
    end;

    if LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("Spectating") ~= true then
        return;
    end;

    u114 = true;
    task.wait();
    local v116 = {};

    for _, v in u21 do
        if not v.dead then
            table.insert(v116, v);
        end;
    end;

    if #v116 == 0 then
        u114 = false;

        return;
    end;

    local v117 = v116[math.random(1, #v116)];
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CameraType = workspace_CurrentCamera.CameraType;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local HauntCutscene = CutsceneScreen.new("HauntCutscene", 60);
    HauntCutscene:SetAttribute("SelfManagedText", true);
    local v118 = {};

    for i, v in { 0, 1 } do
        local Frame = Instance.new("Frame");
        Frame.BackgroundColor3 = Color3.new(0, 0, 0);
        Frame.BorderSizePixel = 0;
        Frame.AnchorPoint = Vector2.new(0, v);
        Frame.Size = UDim2.fromScale(1, 0.13);
        Frame.Position = UDim2.fromScale(0, v == 0 and -0.13 or 1.13);
        Frame.Parent = HauntCutscene;
        v118[i] = Frame;
    end;

    local v119 = text(HauntCutscene, "Title", "THE DEAD RISE", 46, Color3_fromRGB_ret, 0.24);
    local v120 = text(HauntCutscene, "Subtitle", "Zombies and skeletons haunt this round. Two hits and you\'re down. Chasers can strike them!", 18, Color3_fromRGB_ret2, 0.31);
    HauntCutscene.Parent = LocalPlayer:WaitForChild("PlayerGui");
    sound("Sting", nil, 1);
    local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    TweenService:Create(v118[1], TweenInfo_new_ret, {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    TweenService:Create(v118[2], TweenInfo_new_ret, {
        Position = UDim2.fromScale(0, 1)
    }):Play();

    for _, v in { v119, v120 } do
        TweenService:Create(v, TweenInfo.new(0.4), {
            TextTransparency = 0,
            TextStrokeTransparency = 0.2
        }):Play();
    end;

    local pos = v117.pos;
    local v121 = -math.sin(v117.yaw);
    local v122 = -math.cos(v117.yaw);
    local Vector3_new_ret = Vector3.new(v121, 0, v122);
    local v123 = Vector3_new_ret:Cross(Vector3.new(0, 1, 0));
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local math_min_ret = math.min(0.6, p115 * 0.2);
    local math_max_ret = math.max(1, p115 - 0.3 - math_min_ret);
    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = CFrame.lookAt(pos + Vector3_new_ret * 9 + v123 * 3 + Vector3.new(0, 0.5, 0), pos + Vector3.new(0, 0.6, 0))
    }):Play();
    task.wait(0.3);
    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(math_max_ret, Enum.EasingStyle.Sine), {
        CFrame = CFrame.lookAt(pos + Vector3_new_ret * 6.5 + v123 * 2 + Vector3.new(0, 1.4, 0), pos + Vector3.new(0, 1.3, 0))
    }):Play();
    task.wait(math_max_ret);
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if LocalPlayer:GetAttribute("Spectating") ~= true and Character then
        CFrame2 = CFrame.lookAt(Character.Position - Character.CFrame.LookVector * 12 + Vector3.new(0, 6, 0), Character.Position);
    end;

    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(math_min_ret, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        CFrame = CFrame2
    }):Play();

    for _, v in { v119, v120 } do
        TweenService:Create(v, TweenInfo.new(math_min_ret), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
    end;

    TweenService:Create(v118[1], TweenInfo.new(math_min_ret), {
        Position = UDim2.fromScale(0, -0.13)
    }):Play();
    TweenService:Create(v118[2], TweenInfo.new(math_min_ret), {
        Position = UDim2.fromScale(0, 1.13)
    }):Play();
    task.wait(math_min_ret);

    if CameraType == Enum.CameraType.Scriptable then
        CameraType = Enum.CameraType.Custom;
    end;

    workspace_CurrentCamera.CameraType = CameraType;
    HauntCutscene:Destroy();
    u114 = false;
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "HauntHud";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 20;
ScreenGui.IgnoreGuiInset = true;
ScreenGui:SetAttribute("SelfManagedText", true);

local function phone() -- Line: 851
    local v124 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720);

    return v124.X < 700 and true or v124.Y < 500;
end;

local Color3_fromRGB_ret4 = Color3.fromRGB(255, 125, 25);
local Color3_fromRGB_ret5 = Color3.fromRGB(255, 95, 30);
local u125 = {};
local u126 = {};

for _, v in {
    { UDim2.fromScale(1, 0.3), UDim2.fromScale(0, 0), 90 },
    { UDim2.fromScale(1, 0.3), UDim2.fromScale(0, 0.7), -90 },
    { UDim2.fromScale(0.2, 1), UDim2.fromScale(0, 0), 0 },
    { UDim2.fromScale(0.2, 1), UDim2.fromScale(0.8, 0), 180 }
} do
    local Frame = Instance.new("Frame");
    Frame.Name = "Edge";
    local v127 = v[2];
    Frame.Size = v[1];
    Frame.Position = v127;
    Frame.BackgroundColor3 = Color3_fromRGB_ret4;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = v[3];
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
    UIGradient.Parent = Frame;
    Frame.Parent = ScreenGui;
    table.insert(u125, Frame);
end;

local function setEdges(p128, p129) -- Line: 883
    -- upvalues: u126 (copy), u125 (copy), TweenService (copy)
    for _, v in u126 do
        v:Cancel();
    end;

    table.clear(u126);

    for _, v in u125 do
        if p129 then
            local v130 = TweenService:Create(v, TweenInfo.new(p129, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = p128
            });
            table.insert(u126, v130);
            v130:Play();
        else
            v.BackgroundTransparency = p128;
        end;
    end;
end;

local u131 = 0;

local function label(p132, p133, p134, p135) -- Line: 902
    -- upvalues: ScreenGui (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p132;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = p135;
    TextLabel.Size = UDim2.fromOffset(640, p133 + 14);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.GothamBlack;
    TextLabel.TextSize = p133;
    TextLabel.TextColor3 = p134;
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.TextStrokeTransparency = 1;
    TextLabel.TextTransparency = 1;
    TextLabel.TextWrapped = true;
    local UIScale = Instance.new("UIScale");
    UIScale.Parent = TextLabel;
    TextLabel.Parent = ScreenGui;

    return TextLabel, UIScale;
end;

local u136 = label("Hits", 18, Color3_fromRGB_ret, UDim2.new(0.5, 0, 1, -128));
u136.Font = Enum.Font.GothamBold;
u136.Visible = false;
u136.AnchorPoint = Vector2.new(0.5, 1);
local GuiService = game:GetService("GuiService");

local function placeCounter() -- Line: 930
    -- upvalues: ChickenOrHero (copy), LocalPlayer (copy), GuiService (copy), u136 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v137 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize.Y or 720;
    local v138 = nil;
    local EquipmentHudLayoutLegacy = ChickenOrHero:WaitForChild("Presentation"):FindFirstChild("EquipmentHudLayoutLegacy");

    if EquipmentHudLayoutLegacy then
        local success2, result2 = pcall(require, EquipmentHudLayoutLegacy);

        if success2 then
            if type(result2) == "table" then
                success2 = result2.rowTop and result2.rowTop();
            else
                success2 = false;
            end;
        end;

        if type(success2) == "number" then
            v138 = success2 - 6;
        end;
    end;

    if not v138 then
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

        if PlayerGui then
            PlayerGui = PlayerGui:FindFirstChild("HUD");
        end;

        local v139;

        if PlayerGui then
            v139 = PlayerGui:FindFirstChild("MainFrame");
        else
            v139 = PlayerGui;
        end;

        if v139 then
            v139 = v139:FindFirstChild("BarMainFrame");
        end;

        if v139 and (v139:IsA("GuiObject") and v139.AbsoluteSize.Y > 0) then
            local v140 = (not PlayerGui:IsA("ScreenGui") or PlayerGui.IgnoreGuiInset) and 0 or GuiService:GetGuiInset().Y;
            v138 = v139.AbsolutePosition.Y + v140 - 10;
        else
            v138 = v137 - 210;
        end;
    end;

    u136.Position = UDim2.new(0.5, 0, 0, (math.max(60, v138)));
end;

local u141 = 0;
table.insert(u1, RunService.Heartbeat:Connect(function(p142) -- Line: 957
    -- upvalues: u141 (ref), u136 (copy), placeCounter (copy)
    u141 = u141 + p142;

    if u141 >= 0.5 then
        u141 = 0;

        if u136.Visible then
            placeCounter();
        end;
    end;
end));
local u143, u144 = label("Marker", 46, Color3_new_ret, UDim2.fromScale(0.5, 0.5));
u143.Text = "✕";
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");

local function fit() -- Line: 970
    -- upvalues: u136 (copy), u143 (copy)
    local v145 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720);
    local v146 = v145.X < 700 and true or v145.Y < 500;
    u136.TextSize = v146 and 14 or 18;
    u143.TextSize = v146 and 34 or 46;
    u136.Size = UDim2.fromOffset(v146 and 360 or 560, v146 and 40 or 48);
end;

local v147 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720);
local v148 = v147.X < 700 and true or v147.Y < 500;
u136.TextSize = v148 and 14 or 18;
u143.TextSize = v148 and 34 or 46;
u136.Size = UDim2.fromOffset(v148 and 360 or 560, v148 and 40 or 48);

if workspace.CurrentCamera then
    local PropertyChangedSignal = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize");
    table.insert(u1, PropertyChangedSignal:Connect(fit));
end;

local Font_fromEnum_ret = Font.fromEnum(Enum.Font.Creepster);

local function pop(p149, p150, p151) -- Line: 984
    -- upvalues: Font_fromEnum_ret (copy), ScreenGui (copy), TweenService (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Popup";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_fromEnum_ret;
    TextLabel.Text = p149;
    TextLabel.TextColor3 = p150;
    TextLabel.TextScaled = true;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.3);
    TextLabel.Size = UDim2.fromScale(0.5, 0.07);
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.new(0, 0, 0);
    UIStroke.Thickness = 0.08;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = TextLabel;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 1.5;
    UIScale.Parent = TextLabel;
    TextLabel.Parent = ScreenGui;
    TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    task.delay(p151, function() -- Line: 1006
        -- upvalues: TweenService (ref), TextLabel (copy), UIStroke (copy)
        TweenService:Create(TextLabel, TweenInfo.new(0.4), {
            TextTransparency = 1,
            Position = UDim2.fromScale(0.5, 0.25)
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.4), {
            Transparency = 1
        }):Play();
        task.delay(0.45, function() -- Line: 1009
            -- upvalues: TextLabel (ref)
            TextLabel:Destroy();
        end);
    end);
end;

local function hitmarker() -- Line: 1016
    -- upvalues: u143 (copy), u144 (copy), TweenService (copy)
    u143.TextTransparency = 0;
    u143.TextStrokeTransparency = 0.3;
    u144.Scale = 1.7;
    TweenService:Create(u144, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    TweenService:Create(u143, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
end;

local function restVignette() -- Line: 1027
    -- upvalues: LocalPlayer (copy)
    return (LocalPlayer:GetAttribute("HauntHits") or 0) > 0 and LocalPlayer:GetAttribute("InMatch") == true and 0.8 or 1;
end;

local function refreshCounter() -- Line: 1034
    -- upvalues: LocalPlayer (copy), u136 (copy), Color3_fromRGB_ret2 (copy), placeCounter (copy), u131 (ref), u126 (copy), u125 (copy)
    local v152 = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("HauntForm");

    if type(v152) == "string" then
        u136.Text = "You\'re a " .. string.upper(v152) .. "! Your strikes wound Runners. A Chaser can strike you back.";
        u136.TextColor3 = Color3_fromRGB_ret2;
        u136.TextTransparency = 0;
        u136.TextStrokeTransparency = 0.25;
        placeCounter();
    end;

    local v153;

    if LocalPlayer:GetAttribute("InMatch") == true then
        v153 = type(v152) == "string";
    else
        v153 = false;
    end;

    u136.Visible = v153;

    if u131 <= os.clock() then
        local v154 = (LocalPlayer:GetAttribute("HauntHits") or 0) > 0 and LocalPlayer:GetAttribute("InMatch") == true and 0.8 or 1;

        for _, v in u126 do
            v:Cancel();
        end;

        table.clear(u126);

        for _, v in u125 do
            v.BackgroundTransparency = v154;
        end;
    end;
end;

local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("HauntHits");
table.insert(u1, AttributeChangedSignal:Connect(refreshCounter));
local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("HauntForm");
table.insert(u1, AttributeChangedSignal2:Connect(refreshCounter));
local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u1, AttributeChangedSignal3:Connect(refreshCounter));
local AttributeChangedSignal4 = Session:GetAttributeChangedSignal("HauntActive");
table.insert(u1, AttributeChangedSignal4:Connect(refreshCounter));
refreshCounter();

local function onHit(p155, p156, p157, p158, p159) -- Line: 1055
    -- upvalues: Players (copy), u73 (copy), flashModel (copy), Color3_fromRGB_ret3 (copy), burst (copy), u76 (copy), sound (copy), LocalPlayer (copy), u126 (copy), u125 (copy), setEdges (copy), u131 (ref), u89 (ref), pop (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret2 (copy), HauntConfig (copy), Color3_fromRGB_ret (copy), refreshCounter (copy)
    local v160;

    if type(p155) == "number" then
        local v161;

        if p155 > 0 then
            v161 = Players:GetPlayerByUserId(p155);
        else
            v161 = false;
        end;

        if v161 then
            v160 = v161.Character;
        else
            local v162 = u73 and u73.resolve(p155);
            v160 = v162 and v162.Character or nil;
        end;
    else
        v160 = nil;
    end;

    if v160 then
        v160 = v160:FindFirstChild("HumanoidRootPart");
    end;

    if v160 then
        flashModel(v160, Color3_fromRGB_ret3, 0.35);
    end;

    if v160 then
        burst(v160.Position + Vector3.new(0, 0.5, 0), u76, 16, 18);
        sound(p159 and "Downed" or "Impact", v160, nil, p155 == LocalPlayer.UserId);
    end;

    if p155 ~= LocalPlayer.UserId then
        return;
    end;

    for _, v in u126 do
        v:Cancel();
    end;

    table.clear(u126);

    for _, v in u125 do
        v.BackgroundTransparency = 0.05;
    end;

    setEdges((LocalPlayer:GetAttribute("HauntHits") or 0) > 0 and LocalPlayer:GetAttribute("InMatch") == true and 0.8 or 1, 0.9);
    u131 = os.clock() + 0.95;
    task.delay(1, function() -- Line: 1071
        -- upvalues: u131 (ref), LocalPlayer (ref), u126 (ref), u125 (ref)
        if u131 <= os.clock() then
            local v163 = (LocalPlayer:GetAttribute("HauntHits") or 0) > 0 and LocalPlayer:GetAttribute("InMatch") == true and 0.8 or 1;

            for _, v in u126 do
                v:Cancel();
            end;

            table.clear(u126);

            for _, v in u125 do
                v.BackgroundTransparency = v163;
            end;
        end;
    end);
    u89 = math.max(u89, p159 and 0.1 or 0.055);

    if p159 then
        pop("DOWNED!", Color3_fromRGB_ret5, 1.4);
        task.delay(0.35, function() -- Line: 1080
            -- upvalues: LocalPlayer (ref), pop (ref), Color3_fromRGB_ret2 (ref)
            local v164 = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("HauntForm");

            if type(v164) == "string" then
                pop("YOU TURNED INTO A " .. string.upper(v164) .. "!", Color3_fromRGB_ret2, 2);
            end;
        end);
    else
        pop("HIT!  " .. tostring(p156) .. " / " .. HauntConfig.HitsToDown, Color3_fromRGB_ret, 0.9);
    end;

    refreshCounter();
end;

local function onKill(p165, p166, p167, p168) -- Line: 1093
    -- upvalues: u22 (copy), flashModel (copy), Color3_new_ret (copy), burst (copy), u75 (copy), u74 (copy), soundAt (copy), LocalPlayer (copy), sound (copy), hitmarker (copy), pop (copy), Color3_fromRGB_ret (copy), u89 (ref)
    local v169 = u22[p165];

    if typeof(p168) ~= "Vector3" then
        if v169 then
            p168 = v169.pos;
        else
            p168 = nil;
        end;
    end;

    if v169 then
        flashModel(v169.model, Color3_new_ret, 0.25);
    end;

    if p168 then
        local v170;

        if p167 == "Skeleton" then
            v170 = u75;
        else
            v170 = u74;
        end;

        burst(p168 + Vector3.new(0, 0.8, 0), v170, 28, 24);

        if p167 ~= "Skeleton" then
            soundAt("KnifeStab", p168);
        end;
    end;

    if p166 == LocalPlayer.UserId then
        sound("KillConfirm", nil, 1);
        hitmarker();
        pop(p167 == "Skeleton" and "SKELETON SMASHED!" or "ZOMBIE SLAIN!", Color3_fromRGB_ret, 0.9);
        u89 = math.max(u89, 0.025);
    end;
end;

local Icon = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("CandyCorn")).Icon;
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);

local function onCandy(p171, p172, p173) -- Line: 1117
    -- upvalues: LocalPlayer (copy), Icon (copy), Font_new_ret (copy), TweenService (copy)
    if typeof(p173) ~= "Vector3" or type(p172) ~= "number" then
        return;
    end;

    local v174 = p171 == LocalPlayer.UserId;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "HauntCandy";
    Attachment.WorldPosition = p173 + Vector3.new(0, 3, 0);
    Attachment.Parent = workspace.Terrain;
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "Candy";
    BillboardGui.Adornee = Attachment;
    BillboardGui.AlwaysOnTop = v174;
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 120;
    local v175;

    if v174 then
        v175 = UDim2.fromScale(5, 2.4);
    else
        v175 = UDim2.fromScale(3.2, 1.5);
    end;

    BillboardGui.Size = v175;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = Icon;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Size = UDim2.fromScale(0.42, 1);
    ImageLabel.Parent = BillboardGui;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AnchorPoint = Vector2.new(1, 0);
    TextLabel.Position = UDim2.fromScale(1, 0);
    TextLabel.Size = UDim2.fromScale(0.58, 1);
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 214, 120);
    TextLabel.TextStrokeTransparency = 0.1;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "+" .. math.floor(p172);
    TextLabel.Parent = BillboardGui;
    BillboardGui.Parent = Attachment;
    local TweenInfo_new_ret = TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    TweenService:Create(BillboardGui, TweenInfo_new_ret, {
        StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
    }):Play();
    TweenService:Create(ImageLabel, TweenInfo_new_ret, {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(TextLabel, TweenInfo_new_ret, {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
    task.delay(1.35, function() -- Line: 1156
        -- upvalues: Attachment (copy)
        Attachment:Destroy();
    end);
end;

local function onRestore(p176, p177) -- Line: 1162
    -- upvalues: Players (copy), u73 (copy), flashModel (copy), Color3_fromRGB_ret (copy), burst (copy), u75 (copy), LocalPlayer (copy), pop (copy), sound (copy), hitmarker (copy)
    local v178;

    if type(p176) == "number" then
        local v179;

        if p176 > 0 then
            v179 = Players:GetPlayerByUserId(p176);
        else
            v179 = false;
        end;

        if v179 then
            v178 = v179.Character;
        else
            local v180 = u73 and u73.resolve(p176);
            v178 = v180 and v180.Character or nil;
        end;
    else
        v178 = nil;
    end;

    if v178 then
        v178 = v178:FindFirstChild("HumanoidRootPart");
    end;

    if v178 then
        flashModel(v178, Color3_fromRGB_ret, 0.5);
    end;

    if v178 then
        burst(v178.Position, u75, 18, 16);
    end;

    if p176 == LocalPlayer.UserId then
        pop("YOU\'RE A CHASER AGAIN!", Color3_fromRGB_ret, 1.6);
    end;

    if p177 == LocalPlayer.UserId then
        sound("KillConfirm", nil, 1);
        hitmarker();
        pop("TURNED BACK!", Color3_fromRGB_ret, 0.9);
    end;
end;

table.insert(u1, HauntEvent.OnClientEvent:Connect(function(p181, p182, p183, p184, p185, p186, p187) -- Line: 1181
    -- upvalues: cutscene (copy), throwHead (copy), stopHead (copy), onHit (copy), onKill (copy), onRestore (copy), onCandy (copy)
    if p181 == "Cutscene" then
        task.spawn(cutscene, p182);

        return;
    end;

    if p181 == "Head" then
        throwHead(p182, p183, p184, p185, p186, p187);

        return;
    end;

    if p181 == "HeadStop" then
        stopHead(p182, p183);

        return;
    end;

    if p181 == "Hit" then
        onHit(p182, p183, p184, p185, p186);

        return;
    end;

    if p181 == "Kill" then
        onKill(p182, p183, p184, p185);

        return;
    end;

    if p181 == "Restore" then
        onRestore(p182, p183);

        return;
    end;

    if p181 == "Candy" then
        onCandy(p182, p183, p184);
    end;
end));
script.Destroying:Connect(function() -- Line: 1199
    -- upvalues: RunService (copy), u1 (copy), u92 (copy), u51 (copy), undress (copy), Folder (copy), ScreenGui (copy)
    RunService:UnbindFromRenderStep("HauntShake");

    for _, v in u1 do
        v:Disconnect();
    end;

    for _, v in u92 do
        v.connection:Disconnect();
    end;

    for i in u51 do
        undress(i);
    end;

    Folder:Destroy();
    ScreenGui:Destroy();
end);