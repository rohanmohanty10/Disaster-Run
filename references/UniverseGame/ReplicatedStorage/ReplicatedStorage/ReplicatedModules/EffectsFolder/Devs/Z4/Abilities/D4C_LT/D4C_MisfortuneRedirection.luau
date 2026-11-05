  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local u1 = ReplicatedStorage["Client Assets"];
local u2 = Random.new();

local function OldEffect(p3) -- Line: 8
    -- upvalues: u1 (copy), u2 (copy), TweenService (copy)
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");
    local v4 = u1["D4C: Love Train"]["Love Train"]:Clone();
    v4.Parent = p3;
    v4.Ground.CFrame = HumanoidRootPart.CFrame;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Parent = v4.Ground;
    WeldConstraint.Part0 = v4.Ground;
    WeldConstraint.Part1 = HumanoidRootPart;
    local v5 = next;
    local v6, v7 = v4.Ground:GetDescendants();

    for _, v in v5, v6, v7 do
        if v:IsA("ParticleEmitter") and v:IsA("PointLight") then
            v.Enabled = true;
        end;
    end;

    for _ = 1, 15 do
        local v8 = u1["D4C: Love Train"].Beam:Clone();
        local Center = v8.Center;
        local v9 = CFrame.new(10, 0, 0);
        local Angles = CFrame.Angles;
        local v10 = u2:NextInteger(-360, 360);
        Center.CFrame = v9 * Angles(math.rad(v10), 0, 0) * CFrame.new(0, 0, u2:NextInteger(4, 6));
        v8.CFrame = HumanoidRootPart.CFrame;
        v8.Parent = p3["Love Train"];
        local AlignPosition = Instance.new("AlignPosition");
        AlignPosition.RigidityEnabled = false;
        AlignPosition.Responsiveness = 600;
        AlignPosition.MaxVelocity = 1000000;
        AlignPosition.Attachment0 = v8.Center;
        AlignPosition.Attachment1 = p3.Torso.WaistCenterAttachment;
        AlignPosition.Parent = v8;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 0, -1.5707963267948966);
        BodyGyro.P = 2000;
        BodyGyro.D = 600;
        BodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000);
        BodyGyro.Parent = v8;
    end;

    while p3.Parent and p3:GetAttribute("MisfortuneState") do
        task.wait(0.1);
    end;

    local v11 = next;
    local v12, v13 = v4:GetDescendants();

    for _, v in v11, v12, v13 do
        if v:IsA("ParticleEmitter") or (v:IsA("SurfaceLight") or v:IsA("PointLight")) then
            v.Enabled = false;
        elseif v:IsA("Beam") then
            TweenService:Create(v.Attachment1, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                Position = Vector3.new(12, 0, 0)
            }):Play();
        end;
    end;

    task.delay(2, v4.Destroy, v4);
end;

return function(p14) -- Line: 64
    -- upvalues: u1 (copy), RunService (copy), TweenService (copy)
    local HumanoidRootPart = p14:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u15 = u1["D4C: Love Train"]["Love Train"]:Clone();
    u15.Parent = p14;
    u15.Ground.CFrame = HumanoidRootPart.CFrame;
    local u16 = {};
    local u17 = 0;
    task.spawn(function() -- Line: 78
        -- upvalues: u15 (copy), RunService (ref), HumanoidRootPart (copy), u17 (ref), u16 (copy)
        for i = 1, 3 do
            local u18 = i * 2 + 2;
            local u19 = script.Trail:Clone();
            u19.Parent = u15;
            local v24 = RunService.Heartbeat:Connect(function(p20) -- Line: 86
                -- upvalues: HumanoidRootPart (ref), u17 (ref), u18 (copy), u19 (copy)
                local _ = HumanoidRootPart.Velocity.Magnitude > 5;
                u17 = (u17 + p20 * 3.141592653589793) % 6.283185307179586;
                local v21 = HumanoidRootPart.Position + Vector3.new(0, -3, 0);
                local v22 = math.cos(u17) * u18;
                local v23 = math.sin(u17) * u18;
                u19.Position = v21 + Vector3.new(v22, 0, v23);
            end);
            table.insert(u16, v24);
            task.wait(0.4);
        end;
    end);

    while p14.Parent and p14:GetAttribute("MisfortuneState") do
        task.wait(0.1);
    end;

    for _, v in u16 do
        v:Disconnect();
    end;

    local v25 = next;
    local v26, v27 = u15:GetDescendants();

    for _, v in v25, v26, v27 do
        if v:IsA("ParticleEmitter") or (v:IsA("SurfaceLight") or v:IsA("PointLight")) then
            v.Enabled = false;
        elseif v:IsA("Beam") then
            TweenService:Create(v.Attachment1, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                Position = Vector3.new(12, 0, 0)
            }):Play();
        end;
    end;

    task.delay(10, u15.Destroy, u15);
end;