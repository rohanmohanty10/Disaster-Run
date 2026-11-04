 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local FootDustConfig = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("FootDustConfig"));
local MovementProfiles = require(ChickenOrHero:WaitForChild("Movement"):WaitForChild("MovementProfiles"));
local u1 = {};
local u2 = 0;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;
pcall(function() -- Line: 9
    -- upvalues: RaycastParams_new_ret (copy)
    RaycastParams_new_ret.CollisionGroup = "CoHRunner";
end);
local u3 = {
    [Enum.Material.Grass] = true,
    [Enum.Material.Ground] = true,
    [Enum.Material.Sand] = true,
    [Enum.Material.Mud] = true,
    [Enum.Material.LeafyGrass] = true
};
local u4 = {
    Grass = true,
    Dirt = true,
    Sand = true
};

local function dusty(p5, p6) -- Line: 13
    -- upvalues: u4 (copy), u3 (copy)
    if p5:GetAttribute("FootDust") == true then
        return true;
    end;

    local Attribute = p5:GetAttribute("AudioSurface");

    if type(Attribute) == "string" and Attribute ~= "" then
        return u4[Attribute] == true;
    end;

    return u3[p6] == true and true or p5.Name == "Grass";
end;

local function create(p7, p8) -- Line: 23
    -- upvalues: FootDustConfig (copy)
    local v9 = {
        distance = 0,
        foot = 1,
        character = p7,
        root = p8,
        attachments = {},
        emitters = {}
    };

    for i = 1, 2 do
        local Attachment = Instance.new("Attachment");
        Attachment.Name = "CoHFootDust" .. i;
        Attachment.Parent = p8;
        local ParticleEmitter = Instance.new("ParticleEmitter");
        ParticleEmitter.Name = "Dust";
        ParticleEmitter.Texture = FootDustConfig.Texture;
        ParticleEmitter.Rate = 0;
        ParticleEmitter.Enabled = false;
        ParticleEmitter.Lifetime = NumberRange.new(0.2, 0.38);
        ParticleEmitter.Speed = NumberRange.new(0.8, 1.8);
        ParticleEmitter.SpreadAngle = Vector2.new(45, 45);
        ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.18), NumberSequenceKeypoint.new(0.5, 0.65), NumberSequenceKeypoint.new(1, 0.95) });
        ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.65), NumberSequenceKeypoint.new(0.25, 0.72), NumberSequenceKeypoint.new(1, 1) });
        ParticleEmitter.Rotation = NumberRange.new(0, 360);
        ParticleEmitter.RotSpeed = NumberRange.new(-40, 40);
        ParticleEmitter.Acceleration = Vector3.new(0, 0.8, 0);
        ParticleEmitter.Drag = 4;
        ParticleEmitter.LightInfluence = 0.8;
        ParticleEmitter.LightEmission = 0;
        ParticleEmitter.LockedToPart = false;
        ParticleEmitter.VelocityInheritance = 0;
        ParticleEmitter.Parent = Attachment;
        v9.attachments[i] = Attachment;
        v9.emitters[i] = ParticleEmitter;
        local _ = i;
    end;

    return v9;
end;

local u28 = RunService.Heartbeat:Connect(function(p10) -- Line: 37
    -- upvalues: u2 (ref), FootDustConfig (copy), u1 (copy), Players (copy), RaycastParams_new_ret (copy), MovementProfiles (copy), create (copy), u4 (copy), u3 (copy)
    u2 = u2 + p10;

    if u2 < FootDustConfig.UpdateInterval then
        return;
    end;

    local math_min_ret = math.min(u2, 0.2);
    u2 = 0;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (FootDustConfig.Enabled and workspace_CurrentCamera) then
        for i in u1 do
            local v11 = u1[i];

            if v11 then
                for _, v in v11.attachments do
                    v:Destroy();
                end;

                u1[i] = nil;
            end;
        end;

        return;
    end;

    local v12 = {};
    local v13 = {};

    for _, v in Players:GetPlayers() do
        local Character = v.Character;
        local v14;

        if Character then
            v14 = Character:FindFirstChild("HumanoidRootPart");
        else
            v14 = Character;
        end;

        local v15;

        if Character then
            v15 = Character:FindFirstChildOfClass("Humanoid");
        else
            v15 = Character;
        end;

        if Character then
            table.insert(v12, Character);
        end;

        if v14 and v15 then
            local Magnitude = (v14.Position - workspace_CurrentCamera.CFrame.Position).Magnitude;

            if Magnitude <= FootDustConfig.MaxDistance then
                table.insert(v13, {
                    p = v,
                    c = Character,
                    root = v14,
                    h = v15,
                    distance = Magnitude
                });
            end;
        end;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v12;
    table.sort(v13, function(p16, p17) -- Line: 52
        return p16.distance < p17.distance;
    end);
    local v18 = {};

    for i, v in v13 do
        if FootDustConfig.MaxCharacters < i then
            break;
        end;

        local p = v.p;
        local c = v.c;
        local root = v.root;
        local h = v.h;
        v18[p] = true;
        local v19 = u1[p];

        if v19 and v19.character ~= c then
            local v20 = u1[p];

            if v20 then
                for _, v2 in v20.attachments do
                    v2:Destroy();
                end;

                u1[p] = nil;
            end;

            v19 = nil;
        end;

        local Magnitude = (root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude;
        local v21;

        if h.Health > 0 then
            v21 = not (root.Anchored or h.Sit or (h.PlatformStand or c:GetAttribute("MovementLocked") or (c:GetAttribute("TackleActive") or c:GetAttribute("Cloaked"))));

            if v21 then
                if h.FloorMaterial == Enum.Material.Air then
                    v21 = false;
                else
                    v21 = MovementProfiles.get(p:GetAttribute("GameRole"), p).MaxSpeed * FootDustConfig.MinSpeedRatio <= Magnitude;
                end;
            end;
        else
            v21 = false;
        end;

        if v21 then
            if not v19 then
                v19 = create(c, root);
                u1[p] = v19;
            end;

            v19.distance = v19.distance + Magnitude * math_min_ret;

            if v19.distance >= FootDustConfig.StepDistance then
                v19.distance = v19.distance % FootDustConfig.StepDistance;
                local v22 = c:FindFirstChild(v19.foot == 1 and "Left Leg" or "Right Leg") or c:FindFirstChild(v19.foot == 1 and "LeftFoot" or "RightFoot");
                local v23 = v22 and v22.Position or root.Position;
                local v24 = workspace:Raycast(Vector3.new(v23.X, root.Position.Y, v23.Z), Vector3.new(0, -6, 0), RaycastParams_new_ret);

                if v24 then
                    local Instance2 = v24.Instance;
                    local Material = v24.Material;
                    local v25;

                    if Instance2:GetAttribute("FootDust") == true then
                        v25 = true;
                    else
                        local Attribute = Instance2:GetAttribute("AudioSurface");

                        if type(Attribute) == "string" and Attribute ~= "" then
                            v25 = u4[Attribute] == true;
                        else
                            v25 = u3[Material] == true and true or Instance2.Name == "Grass";
                        end;
                    end;

                    if v25 and v24.Normal.Y > 0.5 then
                        local v26 = v24.Instance:IsA("BasePart") and v24.Instance.Color or Color3.fromRGB(135, 119, 86);
                        v19.attachments[v19.foot].WorldPosition = v24.Position + v24.Normal * 0.12;
                        v19.emitters[v19.foot].Color = ColorSequence.new(Color3.fromRGB(152, 133, 101):Lerp(v26, 0.25));
                        v19.emitters[v19.foot]:Emit(FootDustConfig.ParticlesPerStep);
                    end;
                end;

                v19.foot = 3 - v19.foot;
            end;
        elseif v19 then
            v19.distance = 0;
        end;
    end;

    for i in u1 do
        if not v18[i] then
            local v27 = u1[i];

            if v27 then
                for _, v in v27.attachments do
                    v:Destroy();
                end;

                u1[i] = nil;
            end;
        end;
    end;
end);
local u31 = Players.PlayerRemoving:Connect(function(p29) -- Line: 19, Name: remove
    -- upvalues: u1 (copy)
    local v30 = u1[p29];

    if v30 then
        for _, v in v30.attachments do
            v:Destroy();
        end;

        u1[p29] = nil;
    end;
end);
script.Destroying:Connect(function() -- Line: 83
    -- upvalues: u28 (copy), u31 (copy), u1 (copy)
    u28:Disconnect();
    u31:Disconnect();

    for i in u1 do
        local v32 = u1[i];

        if v32 then
            for _, v in v32.attachments do
                v:Destroy();
            end;

            u1[i] = nil;
        end;
    end;
end);