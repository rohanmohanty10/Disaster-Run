 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local GearCatalog = require(ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearCatalog"));
local u1 = GearCatalog.Items.SoulReap or {};
local LocalPlayer = Players.LocalPlayer;
local u2 = u1.GhostColor or Color3.fromRGB(90, 210, 255);
local Color3_fromRGB_ret = Color3.fromRGB(205, 245, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 90, 90);
local u3 = u1.Lines or { "You let me die." };
local u4 = {
    Pulse = { "rbxassetid://9125484367", 0.6, 0, 2.2, 1 },
    Taken = { "rbxassetid://9120746721", 2.4, 3.15, 0.85, 1 },
    Spent = { "rbxassetid://1837830328", 0.5, 0, 1.8, 1.1 }
};
local Folder = Instance.new("Folder");
Folder.Name = "SoulReapLocal";
Folder.Parent = workspace;
local u5 = u1.Range or 25;
local Color3_new_ret = Color3.new(0, 0, 0);
local u6 = false;
local ArmoryEvent = ChickenOrHero:WaitForChild("Weapons"):WaitForChild("ArmoryEvent");
ArmoryEvent.OnClientEvent:Connect(function(p7, p8) -- Line: 61
    -- upvalues: u6 (ref), GearCatalog (copy)
    if p7 == "State" and type(p8) == "table" then
        local v9;

        if type(p8.abilities) == "table" and p8.abilities.SoulReap == true then
            v9 = GearCatalog.equippedForRole(p8, "Runner") == "SoulReap";
        else
            v9 = false;
        end;

        u6 = v9;
    end;
end);
ArmoryEvent:FireServer("Get");

local function isReaper() -- Line: 70
    -- upvalues: u6 (ref), LocalPlayer (copy)
    return u6 or LocalPlayer:GetAttribute("StudioTestAbility") == "SoulReap";
end;

local function serverNow() -- Line: 77
    return workspace:GetServerTimeNow();
end;

local u10;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots == true then
    u10 = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory"));
else
    u10 = nil;
end;

local function characterOf(p11) -- Line: 86
    -- upvalues: Players (copy), u10 (copy)
    if type(p11) ~= "number" then
        return nil;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p11);

    if PlayerByUserId then
        return PlayerByUserId.Character;
    end;

    local v12 = u10 and u10.get(p11);

    if v12 and v12.Character then
        return v12.Character;
    end;

    local ClientBots = workspace:FindFirstChild("ClientBots");

    for _, v in not ClientBots and {} or ClientBots:GetDescendants() do
        if v:IsA("Model") and v:GetAttribute("BotUserId") == p11 then
            return v;
        end;
    end;

    return nil;
end;

local function rootOf(p13) -- Line: 106
    -- upvalues: characterOf (copy)
    local v14 = characterOf(p13);

    if v14 then
        v14 = v14:FindFirstChild("HumanoidRootPart");
    end;

    if v14 and v14:IsA("BasePart") then
        return v14;
    end;

    return nil;
end;

local function sound(p15, p16) -- Line: 112
    -- upvalues: u4 (copy)
    local u17 = u4[p15];

    if not (u17 and (p16 and p16.Parent)) then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = u17[1];
    Sound.Volume = u17[2];
    Sound.PlaybackSpeed = u17[5] or 1;
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
    Sound.RollOffMaxDistance = 120;
    Sound.Parent = p16;

    local function go() -- Line: 124
        -- upvalues: Sound (copy), u17 (copy)
        if Sound.Parent then
            Sound.TimePosition = u17[3];
            Sound:Play();
            task.delay(u17[4] / (u17[5] or 1), function() -- Line: 128
                -- upvalues: Sound (ref)
                Sound:Destroy();
            end);
        end;
    end;

    if Sound.IsLoaded then
        if Sound.Parent then
            Sound.TimePosition = u17[3];
            Sound:Play();
            task.delay(u17[4] / (u17[5] or 1), function() -- Line: 128
                -- upvalues: Sound (copy)
                Sound:Destroy();
            end);
        end;
    else
        Sound.Loaded:Once(go);
        task.delay(3, function() -- Line: 137
            -- upvalues: Sound (copy)
            if Sound.Parent and not Sound.IsPlaying then
                Sound:Destroy();
            end;
        end);
    end;
end;

local function notice(u18) -- Line: 144
    -- upvalues: ChickenOrHero (copy)
    task.spawn(function() -- Line: 145
        -- upvalues: ChickenOrHero (ref), u18 (copy)
        local success, result = pcall(function() -- Line: 146
            -- upvalues: ChickenOrHero (ref), u18 (ref)
            local v19;

            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                v19 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v19 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
            end;

            require(v19).show(u18);
        end);

        if not success then
            warn("SoulReapClient notice: " .. tostring(result));
        end;
    end);
end;

local u20 = { "LuaSourceContainer", "Sound", "BillboardGui", "SurfaceGui", "ParticleEmitter", "Trail", "Beam", "Light", "Constraint", "NoCollisionConstraint", "Highlight", "ForceField", "Tool", "Fire", "Smoke", "Sparkles", "ProximityPrompt", "ClickDetector", "Animator" };
local u21 = {
    HumanoidRootPart = true,
    Torso = true,
    Head = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true
};

local function droppable(p22) -- Line: 168
    -- upvalues: u20 (copy)
    if p22:IsA("RigidConstraint") then
        return false;
    end;

    for _, v in u20 do
        if p22:IsA(v) then
            return true;
        end;
    end;

    return false;
end;

local function blankRig() -- Line: 181
    local Model = Instance.new("Model");
    Instance.new("Humanoid").Parent = Model;
    local Part = Instance.new("Part");
    Part.Name = "HumanoidRootPart";
    Part.Size = Vector3.new(2, 2, 1);
    Part.Transparency = 1;
    Part.Parent = Model;
    Model.PrimaryPart = Part;

    for _, v in { { "Torso", Vector3.new(2, 2, 1), Vector3.new(0, 0, 0) }, { "Head", Vector3.new(2, 1, 1), Vector3.new(0, 1.5, 0) }, { "Left Arm", Vector3.new(1, 2, 1), Vector3.new(-1.5, 0, 0) }, { "Right Arm", Vector3.new(1, 2, 1), Vector3.new(1.5, 0, 0) }, { "Left Leg", Vector3.new(1, 2, 1), Vector3.new(-0.5, -2, 0) }, { "Right Leg", Vector3.new(1, 2, 1), Vector3.new(0.5, -2, 0) } } do
        local Part2 = Instance.new("Part");
        Part2.Name = v[1];
        Part2.Size = v[2];
        Part2.CFrame = CFrame.new(v[3]);

        if v[1] == "Head" then
            local SpecialMesh = Instance.new("SpecialMesh");
            SpecialMesh.MeshType = Enum.MeshType.Head;
            SpecialMesh.Scale = Vector3.new(1.25, 1.25, 1.25);
            SpecialMesh.Parent = Part2;
        end;

        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = Part;
        WeldConstraint.Part1 = Part2;
        WeldConstraint.Parent = Part2;
        Part2.Parent = Model;
    end;

    return Model;
end;

local u23 = {
    {
        "RootJoint",
        "HumanoidRootPart",
        "HumanoidRootPart",
        "Torso",
        CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
        CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
    },
    {
        "Neck",
        "Torso",
        "Torso",
        "Head",
        CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
        CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
    },
    {
        "Right Shoulder",
        "Torso",
        "Torso",
        "Right Arm",
        CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
        CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
    },
    {
        "Left Shoulder",
        "Torso",
        "Torso",
        "Left Arm",
        CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    },
    {
        "Right Hip",
        "Torso",
        "Torso",
        "Right Leg",
        CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
        CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
    },
    {
        "Left Hip",
        "Torso",
        "Torso",
        "Left Leg",
        CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    }
};

local function rejoin(p24) -- Line: 226
    -- upvalues: u23 (copy)
    local v25 = {};

    for _, descendant in p24:GetDescendants() do
        if descendant:IsA("JointInstance") and (descendant.Enabled and (descendant.Part0 and descendant.Part1)) then
            v25[descendant.Part0.Name .. "|" .. descendant.Part1.Name] = true;
            v25[descendant.Part1.Name .. "|" .. descendant.Part0.Name] = true;
        end;
    end;

    local v26 = 0;

    for _, v in u23 do
        local v27 = p24:FindFirstChild(v[2]);
        local v28 = p24:FindFirstChild(v[3]);
        local v29 = p24:FindFirstChild(v[4]);

        if v27 and (v28 and (v29 and (v28:IsA("BasePart") and (v29:IsA("BasePart") and not v25[v[3] .. "|" .. v[4]])))) then
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Name = v[1];
            local v30 = v[5];
            local v31 = v[6];
            Motor6D.Part0 = v28;
            Motor6D.Part1 = v29;
            Motor6D.C0 = v30;
            Motor6D.C1 = v31;
            Motor6D.Parent = v27;
            v26 = v26 + 1;
        end;
    end;

    return v26;
end;

local function repose(p32, p33) -- Line: 248
    local v34 = {};

    for _, descendant in p32:GetDescendants() do
        if descendant:IsA("JointInstance") and (descendant.Enabled and (descendant.Part0 and descendant.Part1)) then
            table.insert(v34, descendant);
        elseif descendant:IsA("RigidConstraint") and (descendant.Enabled and (descendant.Attachment0 and descendant.Attachment1)) then
            table.insert(v34, descendant);
        end;
    end;

    local v35 = true;
    local v36 = {
        [p33] = true
    };

    while v35 and #v34 > 0 do
        v35 = false;

        for i = #v34, 1, -1 do
            local v37 = v34[i];
            local v38, v39, v40, v41;

            if v37:IsA("RigidConstraint") then
                v38 = v37.Attachment0.Parent;
                v39 = v37.Attachment1.Parent;
                v40 = v37.Attachment0.CFrame;
                v41 = v37.Attachment1.CFrame;
            else
                v38 = v37.Part0;
                v39 = v37.Part1;
                v40 = v37.C0;
                v41 = v37.C1;
            end;

            local v42 = v38 and v38:IsA("BasePart") and v38:IsDescendantOf(p32);
            local v43 = v39 and v39:IsA("BasePart") and v39:IsDescendantOf(p32);
            local v44;

            if v42 and (v43 and not (v36[v38] and v36[v39])) then
                if v36[v38] then
                    v39.CFrame = v38.CFrame * v40 * v41:Inverse();
                    v36[v39] = true;
                    table.remove(v34, i);
                    v44 = i;
                    v35 = true;
                elseif v36[v39] then
                    v38.CFrame = v39.CFrame * v41 * v40:Inverse();
                    v36[v38] = true;
                    table.remove(v34, i);
                    v44 = i;
                    v35 = true;
                else
                    v44 = i;
                end;
            else
                table.remove(v34, i);
                v44 = i;
            end;
        end;
    end;
end;

local function weldLoose(p45, p46) -- Line: 288
    local u47 = {};

    local function link(p48, p49) -- Line: 290
        -- upvalues: u47 (copy)
        if p48 and (p49 and (p48:IsA("BasePart") and p49:IsA("BasePart"))) then
            u47[p48] = u47[p48] or {};
            table.insert(u47[p48], p49);
            u47[p49] = u47[p49] or {};
            table.insert(u47[p49], p48);
        end;
    end;

    for _, descendant in p45:GetDescendants() do
        if (descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) and descendant.Enabled then
            link(descendant.Part0, descendant.Part1);
        elseif descendant:IsA("RigidConstraint") and (descendant.Enabled and (descendant.Attachment0 and descendant.Attachment1)) then
            link(descendant.Attachment0.Parent, descendant.Attachment1.Parent);
        end;
    end;

    local v50 = { p46 };
    local v51 = {
        [p46] = true
    };

    while #v50 > 0 do
        for _, v in u47[table.remove(v50)] or {} do
            if not v51[v] then
                v51[v] = true;
                table.insert(v50, v);
            end;
        end;
    end;

    local v52 = p45:FindFirstChild("Torso") or p45:FindFirstChild("UpperTorso");

    if not (v52 and v51[v52]) then
        v52 = p46;
    end;

    local v53 = 0;

    for _, descendant in p45:GetDescendants() do
        if descendant:IsA("BasePart") and not v51[descendant] then
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v52;
            WeldConstraint.Part1 = descendant;
            WeldConstraint.Parent = descendant;
            v53 = v53 + 1;
        end;
    end;

    return v53;
end;

local function ghostFrom(u54) -- Line: 333
    -- upvalues: blankRig (copy), u20 (copy), u21 (copy), u2 (copy), rejoin (copy), repose (copy), weldLoose (copy)
    local v55;

    if u54 then
        local Archivable = u54.Archivable;
        u54.Archivable = true;
        local success, result = pcall(function() -- Line: 338
            -- upvalues: u54 (copy)
            return u54:Clone();
        end);
        u54.Archivable = Archivable;
        v55 = success and result and result or nil;
    else
        v55 = nil;
    end;

    if not (v55 and v55:FindFirstChild("HumanoidRootPart")) then
        if v55 then
            v55:Destroy();
        end;

        v55 = blankRig();
    end;

    v55.Name = "SoulGhost";

    for _, descendant in v55:GetDescendants() do
        if descendant.Parent then
            local v56, v57;

            if descendant:IsA("RigidConstraint") then
                v56 = descendant;
                v57 = false;
            else
                v56 = descendant;
                v57 = false;

                for _, v in u20 do
                    if v56:IsA(v) then
                        v57 = true;
                        break;
                    end;
                end;
            end;

            if v57 then
                v56:Destroy();
            end;
        end;
    end;

    for _, child in v55:GetChildren() do
        if child:IsA("Model") or child:IsA("Folder") then
            child:Destroy();
        end;
    end;

    if v55:FindFirstChild("Torso") then
        for _, descendant in v55:GetDescendants() do
            if (descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) and (descendant.Part0 and (descendant.Part1 and (descendant.Part0.Parent == v55 and (descendant.Part1.Parent == v55 and (u21[descendant.Part0.Name] and u21[descendant.Part1.Name]))))) then
                descendant:Destroy();
            end;
        end;
    end;

    for _, descendant in v55:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CastShadow = false;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.Anchored = false;
            descendant.LocalTransparencyModifier = 0;
            descendant.Transparency = descendant.Name == "HumanoidRootPart" and 1 or 0.35;
        elseif descendant:IsA("Decal") then
            descendant.Transparency = 0.35;
        elseif descendant:IsA("Motor6D") then
            descendant.Enabled = true;
            descendant.Transform = CFrame.identity;
        end;
    end;

    local v58 = v55:FindFirstChildOfClass("Humanoid");

    if v58 then
        v58.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        v58.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
        v58.BreakJointsOnDeath = false;
        v58.RequiresNeck = false;
        v58.PlatformStand = true;
        Instance.new("Animator").Parent = v58;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = "SoulGlow";
    Highlight.FillColor = u2;
    Highlight.FillTransparency = 0.8;
    Highlight.OutlineColor = u2;
    Highlight.OutlineTransparency = 0.15;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = v55;
    local HumanoidRootPart = v55:FindFirstChild("HumanoidRootPart");
    HumanoidRootPart.Anchored = true;
    v55.PrimaryPart = HumanoidRootPart;
    local v59 = rejoin(v55);
    local _, v60 = HumanoidRootPart.CFrame:ToEulerAnglesYXZ();
    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, v60, 0);
    repose(v55, HumanoidRootPart);
    local v61 = weldLoose(v55, HumanoidRootPart);

    if v59 <= 0 then
        local _ = v61 > 0;
    end;

    local v62 = v55:FindFirstChild("Torso") or (v55:FindFirstChild("UpperTorso") or HumanoidRootPart);
    local PointLight = Instance.new("PointLight");
    PointLight.Color = u2;
    PointLight.Brightness = 0.6;
    PointLight.Range = 8;
    PointLight.Shadows = false;
    PointLight.Parent = v62;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(u2, Color3.new(1, 1, 1));
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.18), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(0.8, 1.4);
    ParticleEmitter.Speed = NumberRange.new(0.4, 1.2);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Acceleration = Vector3.new(0, 1.2, 0);
    ParticleEmitter.Rate = 6;
    ParticleEmitter.Parent = v62;

    return v55, HumanoidRootPart;
end;

local function buildGhost(p63) -- Line: 451
    -- upvalues: characterOf (copy), ghostFrom (copy)
    local v64 = characterOf(p63);
    local v65, v66 = ghostFrom(v64);

    return v65, v66, v64 == nil;
end;

local function animate(p67, p68) -- Line: 456
    if type(p68) ~= "string" or p68 == "" then
        return nil;
    end;

    local v69 = p67:FindFirstChildOfClass("Humanoid");

    if not v69 then
        return nil;
    end;

    local u70 = v69:FindFirstChildOfClass("Animator") or Instance.new("Animator", v69);
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p68;
    local success, result = pcall(function() -- Line: 467
        -- upvalues: u70 (copy), Animation (copy)
        return u70:LoadAnimation(Animation);
    end);

    if not (success and result) then
        return nil;
    end;

    result.Looped = true;
    result:Play(0.2);

    return result;
end;

local function fadeIn(p71, p72) -- Line: 478
    -- upvalues: TweenService (copy)
    for _, descendant in p71:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" or descendant:IsA("Decal") then
            descendant.Transparency = 1;
            TweenService:Create(descendant, TweenInfo.new(p72), {
                Transparency = 0.35
            }):Play();
        elseif descendant:IsA("Highlight") then
            local FillTransparency = descendant.FillTransparency;
            local OutlineTransparency = descendant.OutlineTransparency;
            descendant.FillTransparency = 1;
            descendant.OutlineTransparency = 1;
            TweenService:Create(descendant, TweenInfo.new(p72), {
                FillTransparency = FillTransparency,
                OutlineTransparency = OutlineTransparency
            }):Play();
        end;
    end;
end;

local function fadeOut(u73, u74, p75) -- Line: 490
    -- upvalues: TweenService (copy), RunService (copy)
    if not (u73 and u73.Parent) then
        return;
    end;

    for _, descendant in u73:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
            TweenService:Create(descendant, TweenInfo.new(u74), {
                Transparency = 1
            }):Play();
        elseif descendant:IsA("Decal") then
            TweenService:Create(descendant, TweenInfo.new(u74), {
                Transparency = 1
            }):Play();
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("PointLight") then
            TweenService:Create(descendant, TweenInfo.new(u74), {
                Brightness = 0
            }):Play();
        elseif descendant:IsA("Highlight") then
            TweenService:Create(descendant, TweenInfo.new(u74), {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
        end;
    end;

    if p75 then
        local os_clock_ret = os.clock();
        local Scale = u73:GetScale();
        task.spawn(function() -- Line: 509
            -- upvalues: u73 (copy), os_clock_ret (copy), u74 (copy), Scale (copy), RunService (ref)
            while u73.Parent and os.clock() - os_clock_ret < u74 do
                pcall(function() -- Line: 511
                    -- upvalues: u73 (ref), Scale (ref), os_clock_ret (ref), u74 (ref)
                    u73:ScaleTo(Scale * (1 + 0.3 * (os.clock() - os_clock_ret) / u74));
                end);
                RunService.RenderStepped:Wait();
            end;
        end);
    end;

    task.delay(u74 + 0.05, function() -- Line: 518
        -- upvalues: u73 (copy)
        u73:Destroy();
    end);
end;

local function burst(p76, p77) -- Line: 522
    -- upvalues: Folder (copy), u2 (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p76);
    Part.Parent = Folder;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(u2, Color3.new(1, 1, 1));
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 0.8);
    ParticleEmitter.Speed = NumberRange.new(6, 12);
    ParticleEmitter.Drag = 3;
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(p77 or 24);
    task.delay(1, function() -- Line: 542
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local u78 = {};

local function dress(p79) -- Line: 553
    -- upvalues: characterOf (copy), ghostFrom (copy), Folder (copy), animate (copy), u1 (copy), fadeIn (copy)
    local v80 = characterOf((p79.config:GetAttribute("Victim")));
    local u81, v82 = ghostFrom(v80);
    pcall(function() -- Line: 555
        -- upvalues: u81 (copy)
        u81:ScaleTo(0.6);
    end);
    local v83 = p79.config:GetAttribute("Body") or Vector3.new(0, 0, 0);
    u81:PivotTo(CFrame.new(v83 + Vector3.new(0, 3.2, 0)));
    u81.Parent = Folder;
    p79.model = u81;
    p79.root = v82;
    p79.blank = v80 == nil;
    p79.track = animate(u81, u1.FloatAnimation);
    fadeIn(u81, 0.5);
end;

local function shade(p84, p85) -- Line: 567
    -- upvalues: Color3_new_ret (copy), u2 (copy)
    if p84.far == p85 or not p84.model then
        return;
    end;

    p84.far = p85;

    for _, descendant in p84.model:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" or descendant:IsA("Decal") then
            descendant.Transparency = p85 and 0.75 or 0.35;
        elseif descendant:IsA("Highlight") then
            local v86;

            if p85 then
                v86 = Color3_new_ret;
            else
                v86 = u2;
            end;

            descendant.FillColor = v86;
            local v87;

            if p85 then
                v87 = Color3_new_ret;
            else
                v87 = u2;
            end;

            descendant.OutlineColor = v87;
            descendant.FillTransparency = p85 and 0.35 or 0.8;
            descendant.OutlineTransparency = p85 and 0.4 or 0.15;
        elseif descendant:IsA("PointLight") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = not p85;
        end;
    end;
end;

local u88 = {};
local u89 = {};

local function startStream(p90, p91, p92) -- Line: 609
    -- upvalues: characterOf (copy), Folder (copy), u2 (copy), u88 (copy), burst (copy), sound (copy)
    if p90.stream then
        return;
    end;

    local v93 = p90.model:FindFirstChild("Torso") or (p90.model:FindFirstChild("UpperTorso") or p90.root);
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "SoulStream";
    Attachment.Parent = v93;
    local Part = Instance.new("Part");
    Part.Name = "SoulStreamEnd";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.2, 0.2, 0.2);
    local v94;

    if p92 then
        v94 = p92;
    else
        v94 = characterOf(p91);

        if v94 then
            v94 = v94:FindFirstChild("HumanoidRootPart");
        end;

        if not (v94 and v94:IsA("BasePart")) then
            v94 = nil;
        end;
    end;

    local v95;

    if v94 then
        v95 = v94.Position;
    else
        v95 = v93.Position;
    end;

    Part.CFrame = CFrame.new(v95);
    Part.Parent = Folder;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = Part;
    local v96 = {};

    for _, v in {
        {
            1.8,
            0.6,
            0.35,
            u2
        },
        {
            0.45,
            0.16,
            0,
            Color3.new(1, 1, 1)
        }
    } do
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = Attachment;
        Beam.Attachment1 = Attachment2;
        local v97 = v[2];
        Beam.Width0 = v[1];
        Beam.Width1 = v97;
        Beam.Color = ColorSequence.new(v[4], u2);
        Beam.LightEmission = 1;
        Beam.LightInfluence = 0;
        Beam.FaceCamera = true;
        Beam.Segments = 24;
        Beam.CurveSize0 = 2.5;
        Beam.CurveSize1 = -1.5;
        Beam.Transparency = NumberSequence.new(1);
        Beam.Parent = Part;
        table.insert(v96, {
            beam = Beam,
            base = v[3]
        });
    end;

    local v98 = {
        next = 0,
        soul = p90,
        takerId = p91,
        goal = p92,
        anchor = v93,
        a0 = Attachment,
        tail = Part,
        beams = v96,
        born = os.clock()
    };
    p90.stream = v98;
    u88[v98] = true;
    burst(v93.Position, 16);

    if v94 then
        sound("Taken", v94);
    end;
end;

local function stopStream(p99, p100) -- Line: 651
    -- upvalues: Color3_fromRGB_ret2 (copy), u2 (copy)
    if not p99 or p99.stopping then
        return;
    end;

    p99.stopping = os.clock();
    p99.lost = p100 == true;

    for _, v in p99.beams do
        local v101;

        if p100 then
            v101 = Color3_fromRGB_ret2;
        else
            v101 = u2;
        end;

        v.beam.Color = ColorSequence.new(v101);
    end;
end;

local u102 = {};

local function parse(p103) -- Line: 707
    local v104 = {};

    for i in string.gmatch(type(p103) == "string" and p103 and p103 or "", "[^,]+") do
        local v105 = tonumber(i);
        table.insert(v104, v105);
    end;

    return v104;
end;

local function say(u106, u107) -- Line: 714
    -- upvalues: u3 (copy), Color3_fromRGB_ret (copy), TweenService (copy)
    local u108 = u3[math.random(1, #u3)];
    local v109 = u107.model:FindFirstChild("Head") or u107.root;
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "SoulLine";
    BillboardGui.Adornee = v109;
    BillboardGui.Size = UDim2.fromScale(9, 1.5);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 2.4, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 90;
    BillboardGui.Parent = u107.model;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.Font = Enum.Font.SpecialElite;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextStrokeColor3 = Color3.fromRGB(4, 14, 26);
    TextLabel.TextStrokeTransparency = 0.15;
    TextLabel.Text = "";
    TextLabel.Parent = BillboardGui;
    u106.talking = u107;
    task.spawn(function() -- Line: 737
        -- upvalues: BillboardGui (copy), u108 (copy), TextLabel (copy), TweenService (ref), u106 (copy), u107 (copy)
        local v110 = 0;

        while BillboardGui.Parent and v110 < #u108 do
            v110 = v110 + 1;
            TextLabel.Text = string.sub(u108, 1, v110);
            task.wait(0.08333333333333333);
        end;

        task.wait(2.6);

        if BillboardGui.Parent then
            TweenService:Create(TextLabel, TweenInfo.new(0.5), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            task.wait(0.55);
            BillboardGui:Destroy();
        end;

        if u106.talking == u107 then
            u106.talking = nil;
        end;
    end);
end;

local function refreshLine(p111) -- Line: 755
    -- upvalues: u102 (copy), parse (copy), burst (copy), sound (copy), fadeOut (copy), characterOf (copy), ghostFrom (copy), Folder (copy), fadeIn (copy), animate (copy), u1 (copy)
    local v112 = u102[p111];
    local v113 = parse(p111:GetAttribute("SoulReapFrom"));

    if #v113 == 0 and not v112 then
        return;
    end;

    if not v112 then
        v112 = {
            ids = {},
            ghosts = {},
            trail = {}
        };
        u102[p111] = v112;
    end;

    while #v112.ghosts > #v113 do
        local table_remove_ret = table.remove(v112.ghosts);

        if v112.talking == table_remove_ret then
            v112.talking = nil;
        end;

        burst(table_remove_ret.root.Position, 20);
        sound("Spent", table_remove_ret.root);
        fadeOut(table_remove_ret.model, 0.5, true);
    end;

    for i = #v112.ghosts + 1, #v113 do
        local v114 = characterOf(v113[i]);
        local u115, v116 = ghostFrom(v114);
        local _ = v114 == nil;
        pcall(function() -- Line: 778
            -- upvalues: u115 (copy)
            u115:ScaleTo(0.8);
        end);
        local v117 = p111.Character and p111.Character:FindFirstChild("HumanoidRootPart");
        local v118;

        if v117 then
            v118 = v117.Position - v117.CFrame.LookVector * ((i - 1) * 4.5 + 6);
        else
            v118 = v116.Position;
        end;

        u115:PivotTo(CFrame.new(v118));
        u115.Parent = Folder;
        fadeIn(u115, 0.5);
        local ghosts = v112.ghosts;
        local v119 = {
            model = u115,
            root = v116,
            id = v113[i],
            pos = v118,
            phase = math.random() * 6,
            nextLine = os.clock() + 2 + i * 1.5 + math.random() * 3,
            track = animate(u115, u1.FollowAnimation)
        };
        table.insert(ghosts, v119);
        local _ = i;
    end;

    v112.ids = v113;

    if #v113 == 0 then
        u102[p111] = nil;
    end;
end;

local function along(p120, p121, p122, p123) -- Line: 802
    for i = #p120, 1, -1 do
        local v124 = p120[i];
        local Magnitude = (p121 - v124).Magnitude;

        if p123 <= Magnitude then
            return p121:Lerp(v124, p123 / math.max(Magnitude, 0.001));
        end;

        p123 = p123 - Magnitude;
        p121 = v124;
        local _ = i;
    end;

    return p121 + p122 * p123;
end;

local function pulse(u125, u126, u127, u128) -- Line: 821
    -- upvalues: characterOf (copy), u2 (copy), Folder (copy), sound (copy), RunService (copy)
    local v129;

    if u128 then
        v129 = u128;
    else
        v129 = characterOf(u125);

        if v129 then
            v129 = v129:FindFirstChild("HumanoidRootPart");
        end;

        if not (v129 and v129:IsA("BasePart")) then
            v129 = nil;
        end;
    end;

    if v129 then
        u126 = v129.Position;
    end;

    local Part = Instance.new("Part");
    Part.Name = "SoulPulse";
    Part.Shape = Enum.PartType.Ball;
    Part.Material = Enum.Material.ForceField;
    Part.Color = u2;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = Vector3.new(2, 2, 2);
    Part.CFrame = CFrame.new(u126);
    Part.Parent = Folder;
    local Part2 = Instance.new("Part");
    Part2.Name = "SoulPulseRing";
    Part2.Transparency = 1;
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.CanTouch = false;
    Part2.Size = Vector3.new(2, 0.05, 2);
    Part2.CFrame = CFrame.new(u126);
    Part2.Parent = Folder;
    local u130 = {};

    for _, v in { Enum.NormalId.Top, Enum.NormalId.Bottom } do
        local SurfaceGui = Instance.new("SurfaceGui");
        SurfaceGui.Face = v;
        SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
        SurfaceGui.PixelsPerStud = 20;
        SurfaceGui.LightInfluence = 0;
        SurfaceGui.Brightness = 1.6;
        SurfaceGui.Parent = Part2;
        local Frame = Instance.new("Frame");
        Frame.Size = UDim2.fromScale(1, 1);
        Frame.BackgroundTransparency = 1;
        Frame.Parent = SurfaceGui;
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0.5, 0);
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = u2;
        UIStroke.Thickness = 7;
        UIStroke.Parent = Frame;
        table.insert(u130, UIStroke);
    end;

    local PointLight = Instance.new("PointLight");
    PointLight.Color = u2;
    PointLight.Brightness = 4;
    PointLight.Range = 16;
    PointLight.Shadows = false;
    PointLight.Parent = Part;

    if v129 then
        sound("Pulse", v129);
    end;

    local os_clock_ret = os.clock();
    local u131 = nil;
    u131 = RunService.RenderStepped:Connect(function() -- Line: 874
        -- upvalues: os_clock_ret (copy), u128 (copy), u125 (copy), characterOf (ref), u126 (copy), u127 (copy), Part (copy), Part2 (copy), u130 (copy), PointLight (copy), u131 (ref)
        local v132 = os.clock() - os_clock_ret;
        local v133 = u128;

        if not v133 then
            v133 = characterOf(u125);

            if v133 then
                v133 = v133:FindFirstChild("HumanoidRootPart");
            end;

            if not (v133 and v133:IsA("BasePart")) then
                v133 = nil;
            end;
        end;

        local v134;

        if v133 then
            v134 = v133.Position;
        else
            v134 = u126;
        end;

        local math_clamp_ret = math.clamp(v132 / 0.45, 0, 1);
        local math_max_ret = math.max(2, (1 - (1 - math_clamp_ret) ^ 3) * u127 * 2);
        local math_clamp_ret2 = math.clamp((v132 - 0.27) / 0.3, 0, 1);
        Part.Size = Vector3.new(1, 1, 1) * math_max_ret;
        Part.CFrame = CFrame.new(v134);
        Part.Transparency = math_clamp_ret2 * 0.85 + 0.15;
        Part2.Size = Vector3.new(math_max_ret, 0.05, math_max_ret);
        Part2.CFrame = CFrame.new(v134);

        for _, v in u130 do
            v.Transparency = math_clamp_ret2;
        end;

        PointLight.Brightness = (1 - math_clamp_ret) * 4;

        if v132 >= 0.5700000000000001 then
            u131:Disconnect();
            Part:Destroy();
            Part2:Destroy();
        end;
    end);
end;

RunService.RenderStepped:Connect(function(p135) -- Line: 1018
    -- upvalues: u78 (copy), characterOf (copy), dress (copy), u6 (ref), LocalPlayer (copy), shade (copy), u5 (copy), startStream (copy), u88 (copy), u2 (copy), Folder (copy), u89 (copy), u102 (copy), along (copy), say (copy)
    local os_clock_ret = os.clock();
    workspace:GetServerTimeNow();

    for _, v in u78 do
        local config = v.config;

        if v.blank and (not v.stream and v.nextDress <= os_clock_ret) then
            v.nextDress = os_clock_ret + 0.5;

            if characterOf(config:GetAttribute("Victim")) then
                v.model:Destroy();
                dress(v);
                v.far = nil;
                v.dressedAt = os_clock_ret;
            end;
        end;

        if os_clock_ret - (v.dressedAt or v.born) > 0.55 then
            local v136 = (u6 or LocalPlayer:GetAttribute("StudioTestAbility") == "SoulReap") and not v.stream;
            local v137 = v136 and LocalPlayer.Character or nil;

            if v137 then
                v137 = v137:FindFirstChild("HumanoidRootPart");
            end;

            local Attribute = config:GetAttribute("Body");
            local v138;

            if v137 == nil then
                v138 = false;
            else
                v138 = v137:IsA("BasePart");

                if v138 then
                    if typeof(Attribute) == "Vector3" then
                        v138 = u5 < (v137.Position - Attribute).Magnitude;
                    else
                        v138 = false;
                    end;
                end;
            end;

            shade(v, v138);
        end;

        local v139 = config:GetAttribute("Body") or v.root.Position;
        local drift = v.drift;
        v.yaw = v.yaw + p135 * 0.5 * math.sin(os_clock_ret * 0.15 + drift.Z);
        local CFrame_Angles_ret = CFrame.Angles(math.sin(os_clock_ret * 0.37 + drift.X) * 0.3490658503988659, 0, math.sin(os_clock_ret * 0.29 + drift.Y) * 0.3490658503988659);
        local v140 = math.sin(os_clock_ret * 1.6 + v.phase) * 0.25;
        v.root.CFrame = CFrame.new(v139 + Vector3.new(0, v140 + 3.2, 0)) * CFrame.Angles(0, v.yaw, 0) * CFrame_Angles_ret;
        local Attribute = config:GetAttribute("TakeBy");

        if Attribute and (not v.stream and type(Attribute) == "number") then
            startStream(v, Attribute);
        end;
    end;

    for i in u88 do
        local goal = i.goal;

        if not goal then
            goal = characterOf(i.takerId);

            if goal then
                goal = goal:FindFirstChild("HumanoidRootPart");
            end;

            if not (goal and goal:IsA("BasePart")) then
                goal = nil;
            end;
        end;

        if goal then
            i.tail.CFrame = CFrame.new(goal.Position);
        end;

        local v141;

        if i.anchor.Parent then
            v141 = i.anchor.Position;
        else
            v141 = i.last;
        end;

        i.last = v141;
        local v142 = not i.stopping and 0 or math.clamp((os_clock_ret - i.stopping) / 0.3, 0, 1);
        local math_clamp_ret = math.clamp((os_clock_ret - i.born) / 0.12, 0, 1);
        local v143 = i;

        for _, v in i.beams do
            local v144 = v.base + (1 - v.base) * math.max(v142, 1 - math_clamp_ret);
            v.beam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, (math.min(1, v144 + 0.25))), NumberSequenceKeypoint.new(0.5, v144), NumberSequenceKeypoint.new(1, (math.min(1, v144 + 0.15))) });
        end;

        if not v143.stopping and (v141 and (goal and v143.next <= os_clock_ret)) then
            v143.next = os_clock_ret + 0.035;
            local Part = Instance.new("Part");
            Part.Shape = Enum.PartType.Ball;
            Part.Material = Enum.Material.Neon;
            Part.Color = u2;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Size = Vector3.new(1, 1, 1) * (0.35 + math.random() * 0.25);
            Part.CFrame = CFrame.new(v141);
            Part.Parent = Folder;
            u89[Part] = {
                born = os_clock_ret,
                from = v141,
                takerId = v143.takerId,
                goal = v143.goal,
                life = 0.32 + math.random() * 0.1,
                side = (math.random() - 0.5) * 2.4,
                size = Part.Size.X
            };
        end;

        if v142 >= 1 then
            u88[v143] = nil;
            v143.tail:Destroy();
            v143.a0:Destroy();
        end;
    end;

    for i, v in u89 do
        local v145 = (os_clock_ret - v.born) / v.life;
        local goal = v.goal;

        if not goal then
            goal = characterOf(v.takerId);

            if goal then
                goal = goal:FindFirstChild("HumanoidRootPart");
            end;

            if not (goal and goal:IsA("BasePart")) then
                goal = nil;
            end;
        end;

        if v145 >= 1 or not goal then
            u89[i] = nil;
            i:Destroy();
        else
            local Position = goal.Position;
            local v146 = v.from:Lerp(Position, v145 * v145);
            local v147 = (Position - v.from) * Vector3.new(1, 0, 1);
            local v148 = v147.Magnitude <= 0.1 and Vector3.new(1, 0, 0) or v147.Unit:Cross(Vector3.new(0, 1, 0));
            local CFrame_new = CFrame.new;
            local v149 = v146 + v148 * v.side * math.sin(v145 * 3.141592653589793);
            local v150 = math.sin(v145 * 3.141592653589793) * 1.2;
            i.CFrame = CFrame_new(v149 + Vector3.new(0, v150, 0));
            i.Size = Vector3.new(1, 1, 1) * v.size * (1 - 0.6 * v145);
            i.Transparency = 0.1 + 0.6 * v145;
        end;
    end;

    for i, v in u102 do
        local v151 = i.Parent and i.Character;

        if v151 then
            v151 = v151:FindFirstChild("HumanoidRootPart");
        end;

        if v151 then
            local trail = v.trail;
            local v152 = trail[#trail];
            local v153 = -v151.CFrame.LookVector;
            local Vector3_new_ret = Vector3.new(v153.X, 0, v153.Z);
            local v154 = Vector3_new_ret.Magnitude <= 0.01 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit;
            local v155;

            if v152 and (v151.Position - v152).Magnitude > 25 then
                table.clear(trail);
                v155 = v;
                v152 = nil;

                for i2, v2 in v.ghosts do
                    v2.pos = v151.Position + v154 * (6 + (i2 - 1) * 4.5) + Vector3.new(0, 0.4, 0);
                end;
            else
                v155 = v;
            end;

            if not v152 or (v151.Position - v152).Magnitude >= 0.6 then
                table.insert(trail, v151.Position);

                if #trail > 160 then
                    table.remove(trail, 1);
                end;
            end;

            local Position = v151.Position;
            local v156 = 1 - math.exp(-p135 * 6);

            for i2, v2 in v155.ghosts do
                local v157 = along(trail, v151.Position, v154, 6 + (i2 - 1) * 4.5);
                local v158 = math.sin(os_clock_ret * 2 + v2.phase) * 0.3;
                local Vector3_new_ret2 = Vector3.new(v157.X, v157.Y + 0.4 + v158, v157.Z);
                v2.pos = v2.pos:Lerp(Vector3_new_ret2, v156);
                local Vector3_new_ret3 = Vector3.new(Position.X - v2.pos.X, 0, Position.Z - v2.pos.Z);
                local v159;

                if Vector3_new_ret3.Magnitude > 0.1 then
                    v159 = CFrame.lookAt(v2.pos, v2.pos + Vector3_new_ret3);
                else
                    v159 = CFrame.new(v2.pos) * v2.root.CFrame.Rotation;
                end;

                v2.root.CFrame = v159 * CFrame.Angles(0, 0, math.sin(os_clock_ret * 1.3 + v2.phase) * 0.06981317007977318);
                Position = v2.pos;

                if not v155.talking and v2.nextLine <= os_clock_ret then
                    v2.nextLine = os_clock_ret + 8 + math.random() * 7;
                    say(v155, v2);
                end;
            end;
        end;
    end;
end);

local function watchPlayer(u160) -- Line: 1153
    -- upvalues: refreshLine (copy)
    u160:GetAttributeChangedSignal("SoulReapFrom"):Connect(function() -- Line: 1154
        -- upvalues: refreshLine (ref), u160 (copy)
        refreshLine(u160);
    end);
    refreshLine(u160);
end;

Players.PlayerAdded:Connect(watchPlayer);

local function collect() -- Line: 901
    -- upvalues: u1 (copy), LocalPlayer (copy)
    local CollectAnimation = u1.CollectAnimation;
    local u161 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if u161 then
        u161 = u161:FindFirstChildOfClass("Animator");
    end;

    if type(CollectAnimation) ~= "string" or (CollectAnimation == "" or not u161) then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = CollectAnimation;
    local success, result = pcall(function() -- Line: 910
        -- upvalues: u161 (copy), Animation (copy)
        return u161:LoadAnimation(Animation);
    end);

    if success and result then
        result.Looped = false;
        result.Priority = Enum.AnimationPriority.Action;
        result:Play(0.1);
    end;
end;

local function flyToReaper(p162, u163) -- Line: 674
    -- upvalues: u78 (copy), startStream (copy), characterOf (copy), RunService (copy), burst (copy), stopStream (copy), fadeOut (copy)
    local u164 = u78[p162];

    if not u164 then
        return;
    end;

    u78[p162] = nil;
    u164.claimed = true;
    startStream(u164, u163);
    local model = u164.model;
    local root = u164.root;
    local Position = root.Position;
    local Rotation = root.CFrame.Rotation;
    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 686
        -- upvalues: model (copy), os_clock_ret (copy), u163 (copy), characterOf (ref), Position (copy), root (copy), Rotation (copy), RunService (ref), burst (ref), stopStream (ref), u164 (copy), fadeOut (ref)
        while model.Parent and os.clock() - os_clock_ret < 0.45 do
            local v165 = (os.clock() - os_clock_ret) / 0.45;
            local v166 = characterOf(u163);

            if v166 then
                v166 = v166:FindFirstChild("HumanoidRootPart");
            end;

            if not (v166 and v166:IsA("BasePart")) then
                v166 = nil;
            end;

            local v167;

            if v166 then
                v167 = v166.Position;
            else
                v167 = Position;
            end;

            local CFrame_new = CFrame.new;
            local v168 = Position:Lerp(v167, v165 * v165);
            local v169 = math.sin(v165 * 3.141592653589793) * 3;
            root.CFrame = CFrame_new(v168 + Vector3.new(0, v169, 0)) * Rotation;
            RunService.RenderStepped:Wait();
        end;

        local v170 = characterOf(u163);

        if v170 then
            v170 = v170:FindFirstChild("HumanoidRootPart");
        end;

        if not (v170 and v170:IsA("BasePart")) then
            v170 = nil;
        end;

        if v170 then
            burst(v170.Position, 18);
        end;

        stopStream(u164.stream, false);
        fadeOut(model, 0.2, false);
    end);
end;

local function showcase(p171, u172, p173, u174) -- Line: 930
    -- upvalues: characterOf (copy), u78 (copy), pulse (copy), shade (copy), ghostFrom (copy), Folder (copy), fadeIn (copy), animate (copy), u1 (copy), RunService (copy), fadeOut (copy), startStream (copy), burst (copy), stopStream (copy), say (copy)
    local u175 = p171:FindFirstChild("HumanoidRootPart") or p171.PrimaryPart;
    local v176;

    if typeof(u174) == "Vector3" then
        v176 = nil;
    else
        local v177 = characterOf(u172);
        v176 = v177 and v177:FindFirstChild("HumanoidRootPart");

        if not (v176 and v176:IsA("BasePart")) then
            v176 = nil;
        end;
    end;

    local u178;

    if type(p173) == "string" then
        u178 = u78[p173] or nil;
    else
        u178 = nil;
    end;

    if u178 and not u178.model then
        u178 = nil;
    end;

    if not (u175 and (u175:IsA("BasePart") and (v176 or (u178 or typeof(u174) == "Vector3")))) then
        return;
    end;

    pulse(0, u175.Position, 10, u175);
    local u179, u180;

    if u178 then
        u78[p173] = nil;
        u178.claimed = true;
        shade(u178, false);
        u179 = u178.model;
        u180 = u178.root;
        u174 = u180.Position - Vector3.new(0, 3.2, 0);
    else
        local v181 = characterOf(u172);
        local v182, v183 = ghostFrom(v181);
        local _ = v181 == nil;
        u179 = v182;
        u180 = v183;
        pcall(function() -- Line: 951
            -- upvalues: u179 (ref)
            u179:ScaleTo(0.6);
        end);

        if v176 then
            u174 = v176.Position;
        end;

        u179:PivotTo(CFrame.new(u174));
        u179.Parent = Folder;
        fadeIn(u179, 0.35);
        animate(u179, u1.FloatAnimation);
    end;

    local u184 = {
        model = u179,
        root = u180
    };
    task.spawn(function() -- Line: 961
        -- upvalues: u178 (ref), u179 (ref), u180 (ref), u174 (ref), RunService (ref), u175 (copy), fadeOut (ref), startStream (ref), u184 (copy), burst (ref), stopStream (ref), u172 (copy), characterOf (ref), ghostFrom (ref), Folder (ref), fadeIn (ref), animate (ref), u1 (ref), say (ref)
        local os_clock_ret = os.clock();

        while not (u178 or (not u179.Parent or os.clock() - os_clock_ret >= 0.5)) do
            local v185 = (os.clock() - os_clock_ret) / 0.5;
            u180.CFrame = CFrame.new(u174 + Vector3.new(0, 3.2 * v185, 0));
            RunService.RenderStepped:Wait();
        end;

        if not (u179.Parent and u175.Parent) then
            if u179.Parent then
                fadeOut(u179, 0.3, false);
            end;

            return;
        end;

        startStream(u184, 0, u175);
        task.wait(0.35);
        local Position = u180.Position;
        local os_clock_ret2 = os.clock();

        while u179.Parent and (u175.Parent and os.clock() - os_clock_ret2 < 0.45) do
            local v186 = (os.clock() - os_clock_ret2) / 0.45;
            local CFrame_new = CFrame.new;
            local v187 = Position:Lerp(u175.Position, v186 * v186);
            local v188 = math.sin(v186 * 3.141592653589793) * 3;
            u180.CFrame = CFrame_new(v187 + Vector3.new(0, v188, 0));
            RunService.RenderStepped:Wait();
        end;

        burst(u175.Position, 18);
        stopStream(u184.stream, false);
        fadeOut(u179, 0.2, false);

        if not u175.Parent then
            return;
        end;

        local v189 = characterOf(u172);
        local u190, v191 = ghostFrom(v189);
        local _ = v189 == nil;
        pcall(function() -- Line: 993
            -- upvalues: u190 (copy)
            u190:ScaleTo(0.8);
        end);
        local v192 = u175.CFrame.LookVector * Vector3.new(1, 0, 1);
        local v193 = v192.Magnitude <= 0.01 and Vector3.new(0, 0, 1) or v192.Unit;
        local v194 = u175.Position - v193 * 6 + Vector3.new(0, 0.4, 0);
        local CFrame_lookAt_ret = CFrame.lookAt(v194, v194 + v193);
        u190:PivotTo(CFrame_lookAt_ret);
        u190.Parent = Folder;
        fadeIn(u190, 0.5);
        animate(u190, u1.FollowAnimation);
        say({}, {
            model = u190,
            root = v191
        });
        local os_clock_ret3 = os.clock();
        local v195 = math.random() * 6;

        while u190.Parent and os.clock() - os_clock_ret3 < 5 do
            local v196 = (os.clock() - os_clock_ret3) * 2 + v195;
            local v197 = math.sin(v196) * 0.3;
            v191.CFrame = CFrame_lookAt_ret + Vector3.new(0, v197, 0);
            RunService.RenderStepped:Wait();
        end;

        fadeOut(u190, 0.6, true);
    end);
end;

local function addSoul(p198) -- Line: 585
    -- upvalues: u78 (copy), dress (copy)
    if u78[p198.Name] then
        return;
    end;

    local v199 = {
        config = p198,
        born = os.clock(),
        yaw = math.random() * 3.141592653589793 * 2
    };
    local v200 = math.random() * 6;
    local v201 = math.random() * 6;
    local v202 = math.random() * 6;
    v199.drift = Vector3.new(v200, v201, v202);
    v199.phase = math.random() * 6;
    v199.nextDress = os.clock() + 0.5;
    dress(v199);
    u78[p198.Name] = v199;
end;

local function dropSoul(p203) -- Line: 661
    -- upvalues: u78 (copy), stopStream (copy), fadeOut (copy)
    local v204 = u78[p203];

    if not v204 then
        return;
    end;

    u78[p203] = nil;

    if v204.claimed then
        return;
    end;

    stopStream(v204.stream, true);
    fadeOut(v204.model, 0.4, false);
end;

for _, v in Players:GetPlayers() do
    task.spawn(watchPlayer, v);
end;

Players.PlayerRemoving:Connect(function(p205) -- Line: 1163
    -- upvalues: u102 (copy)
    local v206 = u102[p205];
    u102[p205] = nil;

    for _, v in v206 and v206.ghosts or {} do
        v.model:Destroy();
    end;
end);

local function waitFor(p207, p208) -- Line: 1171
    local v209 = p207:WaitForChild(p208, 60);

    if not v209 then
        warn("SoulReapClient: Game." .. p208 .. " never arrived after 60 s; waiting for it");
        v209 = p207:WaitForChild(p208);
    end;

    return v209;
end;

task.spawn(function() -- Line: 1179
    -- upvalues: Game (copy), addSoul (copy), u78 (copy), dropSoul (copy)
    local v210 = Game;
    local SoulReapSouls = v210:WaitForChild("SoulReapSouls", 60);

    if not SoulReapSouls then
        warn("SoulReapClient: Game.SoulReapSouls never arrived after 60 s; waiting for it");
        SoulReapSouls = v210:WaitForChild("SoulReapSouls");
    end;

    SoulReapSouls.ChildAdded:Connect(function(u211) -- Line: 1181
        -- upvalues: addSoul (ref), u78 (ref)
        task.defer(function() -- Line: 1183
            -- upvalues: addSoul (ref), u211 (copy), u78 (ref)
            local _, _ = pcall(addSoul, u211);
            local _ = u78[u211.Name];
        end);
    end);
    SoulReapSouls.ChildRemoved:Connect(function(p212) -- Line: 1189
        -- upvalues: dropSoul (ref)
        task.delay(0.15, dropSoul, p212.Name);
    end);

    for _, child in SoulReapSouls:GetChildren() do
        task.spawn(addSoul, child);
    end;
end);
task.spawn(function() -- Line: 1197
    -- upvalues: Game (copy), pulse (copy), LocalPlayer (copy), collect (copy), flyToReaper (copy), u78 (copy), stopStream (copy), ChickenOrHero (copy), showcase (copy)
    local v213 = Game;
    local SoulReapEvent = v213:WaitForChild("SoulReapEvent", 60);

    if not SoulReapEvent then
        warn("SoulReapClient: Game.SoulReapEvent never arrived after 60 s; waiting for it");
        SoulReapEvent = v213:WaitForChild("SoulReapEvent");
    end;

    SoulReapEvent.OnClientEvent:Connect(function(p214, p215, p216, p217) -- Line: 1199
        -- upvalues: pulse (ref), LocalPlayer (ref), collect (ref), flyToReaper (ref), u78 (ref), stopStream (ref), ChickenOrHero (ref), showcase (ref)
        if p214 == "Pulse" and (type(p215) == "number" and (typeof(p216) == "Vector3" and type(p217) == "number")) then
            pulse(p215, p216, p217);

            if p215 == LocalPlayer.UserId then
                collect();
            end;
        else
            if p214 == "Taken" and (type(p215) == "string" and type(p216) == "number") then
                flyToReaper(p215, p216);

                return;
            end;

            if p214 == "Lost" and type(p215) == "string" then
                local v218 = u78[p215];

                if v218 then
                    stopStream(v218.stream, true);
                    v218.stream = nil;

                    if p216 == LocalPlayer.UserId then
                        local u219 = p217 == "Range" and "You left the souls behind." or "Soul lost.";
                        task.spawn(function() -- Line: 145
                            -- upvalues: ChickenOrHero (ref), u219 (copy)
                            local success, result = pcall(function() -- Line: 146
                                -- upvalues: ChickenOrHero (ref), u219 (ref)
                                local v220;

                                if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                                    v220 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
                                else
                                    v220 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
                                end;

                                require(v220).show(u219);
                            end);

                            if not success then
                                warn("SoulReapClient notice: " .. tostring(result));
                            end;
                        end);
                    end;
                end;
            else
                if p214 == "Showcase" and (typeof(p215) == "Instance" and (p215:IsA("Model") and type(p216) == "number")) then
                    showcase(p215, p216, p217);

                    return;
                end;

                if p214 == "None" then
                    local u221 = "No souls nearby.";
                    task.spawn(function() -- Line: 145
                        -- upvalues: ChickenOrHero (ref), u221 (copy)
                        local success, result = pcall(function() -- Line: 146
                            -- upvalues: ChickenOrHero (ref), u221 (ref)
                            local v222;

                            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                                v222 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
                            else
                                v222 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
                            end;

                            require(v222).show(u221);
                        end);

                        if not success then
                            warn("SoulReapClient notice: " .. tostring(result));
                        end;
                    end);
                end;
            end;
        end;
    end);
end);
local BindableEvent = Instance.new("BindableEvent");
BindableEvent.Name = "SoulReapDemo";
BindableEvent.Event:Connect(function(p223, p224, p225) -- Line: 1227
    -- upvalues: showcase (copy)
    if typeof(p223) == "Instance" and (p223:IsA("Model") and (typeof(p224) == "Vector3" and type(p225) == "number")) then
        showcase(p223, p225, nil, p224);
    end;
end);
BindableEvent.Parent = script;