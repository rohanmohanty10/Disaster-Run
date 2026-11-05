  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local SoundGroups = require(ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local u1 = {};

for _, child in pairs(workspace.Map:GetChildren()) do
    if child:FindFirstChild("Collisions") then
        table.insert(u1, child.Collisions);
    end;
end;

local function RayCastOnMap(p2, p3, p4) -- Line: 16
    -- upvalues: u1 (copy)
    local v5 = RaycastParams.new();
    v5.FilterDescendantsInstances = u1;
    v5.FilterType = Enum.RaycastFilterType.Whitelist;
    local v6 = workspace:Raycast(p2, p3, v5);

    if p4 then
        return v6;
    end;

    if v6 then
        return v6.Position;
    end;

    return p2;
end;

return function(u7) -- Line: 30
    -- upvalues: ReplicatedStorage (copy), Debris (copy), CollectionService (copy), TweenService (copy), SoundGroups (copy), u1 (copy)
    local u8 = Random.new();
    local v9 = ReplicatedStorage;
    local u10 = Debris;
    u7.PrimaryPart.Anchored = true;

    local function ranNum(p11, p12) -- Line: 37
        -- upvalues: u8 (copy)
        return u8:NextNumber(p11, p12);
    end;

    local u13 = CollectionService;

    local function wait(p14) -- Line: 41
        -- upvalues: u13 (copy), u7 (copy)
        local wait = task.wait;
        local v15 = 0;
        local v16 = p14 or 0;

        while true do
            v15 = v15 + wait();

            if u13:HasTag(u7, "Timestopped") then
                repeat
                    u13:GetInstanceRemovedSignal("Timestopped"):Wait();
                until not u13:HasTag(u7, "Timestopped");
            end;

            if v16 <= v15 then
                return v15;
            end;
        end;
    end;

    local u17 = {};
    local u18 = {};
    local u19 = {};
    local u20 = {};
    local u22 = {
        Timestop = workspace.Mechanics.TimeStopped:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 62
            -- upvalues: u13 (copy), u7 (copy), u19 (copy), u17 (copy), u20 (copy), u18 (copy)
            local v21 = tick();

            if workspace.Mechanics.TimeStopped.Value == true then
                repeat
                    u13:GetInstanceAddedSignal("Timestopped"):Wait();
                until u13:HasTag(u7, "Timestopped") or tick() - v21 > 1;
            else
                repeat
                    u13:GetInstanceRemovedSignal("Timestopped"):Wait();
                until not u13:HasTag(u7, "Timestopped") or tick() - v21 > 1;
            end;

            local Value = workspace.Mechanics.TimeStopped.Value;

            for i, v in pairs(u19) do
                i:AdjustSpeed(Value and 0 or v);
            end;

            for _, v in pairs(u17) do
                if Value then
                    v:Pause();
                else
                    v:Play();
                end;
            end;

            for _, v in pairs(u20) do
                if v.IsPlaying == true and Value then
                    v:Pause();
                end;

                if v.IsPaused and not Value then
                    v:Resume();
                end;
            end;

            for _, v in pairs(u18) do
                v.TimeScale = Value and 0 or 1;
            end;
        end)
    };

    local function tween(p23, p24, p25) -- Line: 99
        -- upvalues: TweenService (ref), u17 (copy)
        local u26 = TweenService:Create(p23, p24, p25);
        table.insert(u17, u26);
        u26:Play();
        local u27 = nil;
        u27 = u26.Completed:Connect(function() -- Line: 104
            -- upvalues: u26 (copy), u27 (ref)
            u26:Destroy();
            u27:Disconnect();
        end);
    end;

    local rad = math.rad;
    Random.new();

    local function Angles(p28, p29, p30) -- Line: 119
        -- upvalues: rad (copy)
        return CFrame.Angles(rad(p28), rad(p29), (rad(p30)));
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://7229553443";
    local u31 = u7.Humanoid:LoadAnimation(Animation);
    u31:Play();
    u31:GetMarkerReachedSignal("stop"):Connect(function() -- Line: 127
        -- upvalues: u31 (ref), u19 (copy)
        u31:AdjustSpeed(0);
        u19[u31] = 0;
    end);
    u19[u31] = 1;
    local Sound = Instance.new("Sound", u7.PrimaryPart);
    SoundGroups:AssignSoundTag(Sound);
    Sound.SoundId = "rbxassetid://17400024604";
    Sound:Play();
    Sound.Volume = 5;
    table.insert(u20, Sound);
    local u32 = {};

    local function createFunkyCylinders(p33, p34, p35, p36, p37, p38) -- Line: 141
        -- upvalues: u8 (copy), rad (copy), tween (copy), u32 (copy), wait (copy)
        local v39 = p34 or CFrame.new();
        local v40 = p35 or CFrame.new();
        local v41 = nil;

        for _ = 1, p37 do
            local v42;

            if p36 then
                v42 = p36;
            else
                local v43 = u8:NextNumber(0, 360);
                local v44 = u8:NextNumber(0, 360);
                local v45 = u8:NextNumber(0, 360);
                v42 = CFrame.Angles(rad(v43), rad(v44), (rad(v45)));
            end;

            if type(v42) == "table" then
                local v46 = {};

                for i, v in pairs(v42) do
                    if type(v) == "table" then
                        v46[i] = u8:NextNumber(v[1], v[2]);
                    else
                        v46[i] = v;
                    end;
                end;

                local v47 = v46[2];
                local v48 = v46[3];
                v42 = CFrame.Angles(rad(v46[1]), rad(v47), (rad(v48)));
            end;

            local Part = Instance.new("Part");
            Part.Color = Color3.new(1, 0.5, 0.5);
            Part.Material = Enum.Material.Neon;
            Part.CanCollide = false;
            Part.Shape = Enum.PartType.Cylinder;
            Part.Size = Vector3.new(0, 0.1, 0.1);
            Part.Transparency = 0.2;
            v41 = v41 == nil and v40 and v40 or v41 * v40;
            local ManualWeld = Instance.new("ManualWeld", p33);
            ManualWeld.Part0 = p33;
            ManualWeld.Part1 = Part;
            ManualWeld.C1 = ManualWeld.C1 * (v39 * v41 * v42);
            Part.Parent = workspace.Effects;
            tween(Part, TweenInfo.new(0.2), {
                Size = Vector3.new(7, 0.2, 0.2),
                Transparency = 1
            });
            table.insert(u32, Part);
            wait(p38);
        end;
    end;

    for _, child in pairs(u7:GetChildren()) do
        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
            local v49 = v9["Client Assets"].Boss.Dio.Shine.Attachment.Shine:Clone();
            v49.Parent = child;
            v49.Enabled = true;
            u10:AddItem(v49, 3.6);
            table.insert(u18, v49);
        end;
    end;

    local PointLight = Instance.new("PointLight", u7.Torso);
    PointLight.Color = Color3.new(1, 0.5, 0.5);
    PointLight.Range = 0;
    tween(PointLight, TweenInfo.new(1), {
        Range = 15
    });
    wait(2);
    coroutine.wrap(createFunkyCylinders)(u7.Head, nil, nil, nil, 6, 0.1);
    wait(0.5);
    coroutine.wrap(createFunkyCylinders)(u7.Torso, CFrame.new(0, -1.5, 0), CFrame.new(0, 0.25, 0), { { -15, 15 }, { 35, 145 }, { -15, 15 } }, 10, 0.1);
    wait(0.5);
    coroutine.wrap(createFunkyCylinders)(u7["Left Leg"], CFrame.new(0, -1, 0), CFrame.new(0, 0.5, 0), nil, 6, 0.1);
    wait(0.6);
    tween(PointLight, TweenInfo.new(1), {
        Range = 30,
        Brightness = 0
    });
    u10:AddItem(PointLight, 1);
    local v50 = v9["Client Assets"].Boss.Dio.EXPLOSION.splode:Clone();
    v50.Parent = u7.Torso;

    for _, child in pairs(v50:GetChildren()) do
        table.insert(u18, child);
        child:Emit(child.Rate);
        u10:AddItem(child, child.Lifetime.Max);
    end;

    for _, v in pairs(u32) do
        tween(v, TweenInfo.new(0.5), {
            Size = Vector3.new(15, 0, 0),
            Transparency = 1
        });
        u10:AddItem(v, 0.5);
    end;

    local u51 = {};

    for i = 1, 4 do
        local v52 = v9["Client Assets"][i % 2 == 0 and "Blood" or "Blood2"]:FindFirstChildWhichIsA("Attachment"):Clone();
        v52.Parent = u7.Torso;
        v52.Position = i < 2 and Vector3.new(-1, -1, 0) or Vector3.new(-1, 0.5, 0);
        v52.Orientation = i < 2 and Vector3.new(-90, 0, 0) or Vector3.new(0, 90, 0);

        for _, child in pairs(v52:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
                table.insert(u51, child);
                table.insert(u18, child);
            end;
        end;
    end;

    local u53 = u7:Clone();
    u53.Parent = workspace.Effects;
    local v54 = u53["Left Leg"];
    local v55 = u53["Left Arm"];
    local v56 = {
        [v54] = true,
        [v55] = true
    };

    for _, child in pairs(v54:GetChildren()) do
        if child:IsA("Weld") then
            v56[child.Part1] = true;
        end;
    end;

    for _, child in pairs(v55:GetChildren()) do
        if child:IsA("Weld") then
            v56[child.Part1] = true;
        end;
    end;

    for _, descendant in pairs(u53:GetDescendants()) do
        if (descendant:IsA("BasePart") or (descendant:IsA("BaseScript") or descendant:IsA("ParticleEmitter"))) and not v56[descendant] then
            descendant:Destroy();
        end;
    end;

    for _, descendant in pairs(u7:GetDescendants()) do
        if descendant:IsA("Weld") and (descendant:IsDescendantOf(u7["Left Leg"]) or descendant:IsDescendantOf(u7["Left Arm"])) then
            descendant.Part1.Transparency = 1;
        end;
    end;

    v54.CanCollide = true;
    v55.CanCollide = true;
    v54.Velocity = u7.Torso.CFrame.UpVector * -5 + u7.Torso.CFrame.LookVector * 5;
    v55.Velocity = u7.Torso.CFrame.UpVector * -5 + u7.Torso.CFrame.RightVector * -5;
    wait(2);
    local u57 = {};

    for _ = 1, 3 do
        local v58 = v9["Client Assets"].Boss.Dio.FIRE:Clone();
        v58.Position = u7.Torso.Position;
        v58.Parent = workspace.Effects;

        for _, descendant in pairs(v58:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                table.insert(u18, descendant);
            end;
        end;

        table.insert(u57, v58);
    end;

    task.delay(6, function() -- Line: 273
        -- upvalues: u51 (copy), u10 (copy), u7 (copy), tween (copy), u53 (copy), wait (copy), u57 (copy), u22 (copy)
        for _, v in pairs(u51) do
            v.Enabled = false;
            u10:AddItem(v, v.Lifetime.Max);
        end;

        for _, descendant in pairs(u7:GetDescendants()) do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                tween(descendant, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Transparency = 1
                });
            end;
        end;

        for _, descendant in pairs(u53:GetDescendants()) do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                tween(descendant, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Transparency = 1
                });
            end;
        end;

        u10:AddItem(u53, 3);
        wait(3);

        for _, v in pairs(u57) do
            for _, descendant in pairs(v:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    u10:AddItem(descendant, descendant.Lifetime.Max);
                end;
            end;

            u10:AddItem(v, 5);
        end;

        wait(2);
        u22.Timestop:Disconnect();
    end);

    for i = 1, 2 do
        local Part = Instance.new("Part");
        Part.Name = "blood";
        Part.Anchored = true;
        Part.Color = Color3.new(0.6, 0, 0);
        Part.CanCollide = false;
        local v59 = i == 1 and (u7.Torso.CFrame * CFrame.new(-1, 0.5, 0)).Position + Vector3.new(0, 1, 0) or (u7.Torso.CFrame * CFrame.new(-1, -1, 0)).Position + Vector3.new(0, 1, 0);
        local v60 = RaycastParams.new();
        v60.FilterDescendantsInstances = u1;
        v60.FilterType = Enum.RaycastFilterType.Whitelist;
        local v61 = workspace:Raycast(v59, Vector3.new(0, -10, 0), v60);

        if v61 then
            v59 = v61.Position;
        end;

        Part.Position = v59;
        Part.Material = Enum.Material.Glass;
        Part.Orientation = Part.Orientation + Vector3.new(0, 0, 90);
        Part.Size = Vector3.new(0, 0, 0);
        Part.Shape = "Cylinder";
        Part.Parent = workspace.Effects;

        if workspace:FindFirstChild("1v1Mode") then
            game:GetService("PhysicsService"):SetPartCollisionGroup(Part, "Map");
        else
            game:GetService("PhysicsService"):SetPartCollisionGroup(Part, "FX");
        end;

        local v62 = TweenInfo.new(u8:NextNumber(7, 10), Enum.EasingStyle.Exponential);
        local v63 = {};
        local v64 = u8:NextNumber(4, 8);
        v63.Size = Vector3.new(0, v64, ranNum(4, 8));
        tween(Part, v62, v63);
        task.delay(15, function() -- Line: 322
            -- upvalues: u8 (copy), tween (copy), Part (copy), wait (copy), u10 (copy)
            local v65 = u8:NextNumber(7, 10);
            tween(Part, TweenInfo.new(v65, Enum.EasingStyle.Exponential), {
                Size = Vector3.new(0, 0, 0)
            });
            wait(v65);
            u10:AddItem(Part, v65);
        end);
    end;
end;