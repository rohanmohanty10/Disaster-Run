 

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local u2 = {
    {
        weight = 4,

        make = function() -- Line: 17, Name: make
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1.1, 1.5, 1.1);
            Part.Material = Enum.Material.Neon;
            Part.Transparency = 0.25;
            local v1 = { Color3.fromRGB(90, 200, 255), Color3.fromRGB(180, 110, 255), Color3.fromRGB(80, 255, 200) };
            Part.Color = v1[math.random(1, #v1)];

            return Part;
        end
    },
    {
        weight = 4,

        make = function() -- Line: 29, Name: make
            local Part = Instance.new("Part");
            Part.Shape = Enum.PartType.Cylinder;
            Part.Size = Vector3.new(0.3, 1.7, 1.7);
            Part.Material = Enum.Material.Metal;
            Part.Color = Color3.fromRGB(255, 200, 40);
            Part.Reflectance = 0.2;

            return Part;
        end
    },
    {
        weight = 3,

        make = function() -- Line: 41, Name: make
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1.9, 0.08, 0.95);
            Part.Material = Enum.Material.SmoothPlastic;
            Part.Color = Color3.fromRGB(120, 200, 110);

            return Part;
        end
    },
    {
        weight = 2,

        make = function() -- Line: 51, Name: make
            local Part = Instance.new("Part");
            Part.Shape = Enum.PartType.Ball;
            Part.Size = Vector3.new(1, 1, 1);
            Part.Material = Enum.Material.Neon;
            Part.Color = Color3.fromRGB(90, 255, 110);
            Part.Transparency = 0.3;

            return Part;
        end
    }
};
local u3 = 0;
local v4 = {};

for _, v in u2 do
    u3 = u3 + v.weight;
end;

local function pick() -- Line: 67
    -- upvalues: u3 (ref), u2 (copy)
    local v5 = math.random() * u3;

    for _, v in u2 do
        v5 = v5 - v.weight;

        if v5 <= 0 then
            return v;
        end;
    end;

    return u2[1];
end;

function v4.start(u6) -- Line: 78
    -- upvalues: Players (copy), u3 (ref), u2 (copy), RunService (copy)
    local Folder = Instance.new("Folder");
    Folder.Name = "TrollLootRain";
    Folder.Parent = workspace;
    local u7 = {};
    local u8 = {};
    local u9 = {};
    local u10 = 0;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.IgnoreWater = true;
    local u11 = nil;
    local u12 = 0;

    local function centre() -- Line: 92
        -- upvalues: Players (ref)
        local Character = Players.LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        return Character and Character.Position or workspace.CurrentCamera.Focus.Position;
    end;

    local function spawnDrop(p13) -- Line: 98
        -- upvalues: Folder (copy), Players (ref), RaycastParams_new_ret (copy), u3 (ref), u2 (ref), u7 (copy)
        local v14 = math.random() * 3.141592653589793 * 2;
        local math_random_ret = math.random();
        local v15 = math.sqrt(math_random_ret) * 70;
        local v16 = math.cos(v14) * v15;
        local v17 = 55 + math.random() * 25;
        local v18 = math.sin(v14) * v15;
        local v19 = p13 + Vector3.new(v16, v17, v18);
        local v20 = { Folder };

        for _, v in Players:GetPlayers() do
            if v.Character then
                table.insert(v20, v.Character);
            end;
        end;

        RaycastParams_new_ret.FilterDescendantsInstances = v20;
        local v21 = workspace:Raycast(v19, Vector3.new(0, -175, 0), RaycastParams_new_ret);
        local v22 = math.random() * u3;
        local v23;

        for _, v in u2 do
            v22 = v22 - v.weight;

            if v22 <= 0 then
                v23 = v;
                break;
            end;
        end;

        v23 = u2[1];
        local v24 = v23.make();
        v24.Anchored = true;
        v24.CanCollide = false;
        v24.CanQuery = false;
        v24.CanTouch = false;
        v24.CastShadow = false;
        v24.CFrame = CFrame.new(v19);
        v24.Parent = Folder;
        local v25 = {
            age = 0,
            part = v24,
            position = v19,
            floor = v21 and v21.Position.Y + 0.4 or v19.Y - 55 - 120,
            speed = 30 + math.random() * 22,
            spin = CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6),
            rate = (math.random() - 0.5) * 8
        };
        table.insert(u7, v25);
    end;

    local function pop(p26) -- Line: 128
        -- upvalues: u12 (ref), u6 (copy)
        p26.part:Destroy();

        if u12 < 3 then
            u12 = u12 + 1;
            local v27 = u6.sound("09_Collectibles/GemCollect", nil, 0.25);
            task.delay(0.12, function() -- Line: 133
                -- upvalues: u12 (ref)
                u12 = u12 - 1;
            end);

            if v27 then
                v27.PlaybackSpeed = 0.9 + math.random() * 0.3;
            end;
        end;
    end;

    RunService.RenderStepped:Connect(function(p28) -- Line: 142
        -- upvalues: u6 (copy), Players (ref), u10 (ref), u7 (copy), spawnDrop (copy), u11 (ref), Folder (copy), u8 (copy), u9 (copy), pop (copy)
        local Attribute = u6.state:GetAttribute("LootRainUntil");
        local v29;

        if type(Attribute) == "number" then
            v29 = workspace:GetServerTimeNow() < Attribute;
        else
            v29 = false;
        end;

        local Character = Players.LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        local v30 = Character and Character.Position or workspace.CurrentCamera.Focus.Position;

        if v29 then
            u10 = u10 + 26 * p28;

            while u10 >= 1 and #u7 < 140 do
                u10 = u10 - 1;
                spawnDrop(v30);
            end;

            u10 = math.min(u10, 3);

            if not u11 then
                u11 = Instance.new("Part");
                u11.Name = "Sparkles";
                u11.Anchored = true;
                u11.CanCollide = false;
                u11.CanQuery = false;
                u11.CanTouch = false;
                u11.Transparency = 1;
                u11.Size = Vector3.new(112, 1, 112);
                local ParticleEmitter = Instance.new("ParticleEmitter");
                ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
                ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 230, 120), Color3.fromRGB(120, 255, 150));
                ParticleEmitter.LightEmission = 1;
                ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0) });
                ParticleEmitter.Lifetime = NumberRange.new(2, 3.5);
                ParticleEmitter.Speed = NumberRange.new(10, 18);
                ParticleEmitter.Rate = 60;
                ParticleEmitter.EmissionDirection = Enum.NormalId.Bottom;
                ParticleEmitter.Parent = u11;
                u11.Parent = Folder;
            end;

            u11.CFrame = CFrame.new(v30 + Vector3.new(0, 33, 0));
        elseif u11 then
            u11:Destroy();
            u11 = nil;
            u10 = 0;
        end;

        if #u7 == 0 then
            return;
        end;

        table.clear(u8);
        table.clear(u9);

        for i = #u7, 1, -1 do
            local v31 = u7[i];
            v31.age = v31.age + p28;
            local v32 = v31.position.Y - v31.speed * p28;
            local v33;

            if v32 <= v31.floor or v31.age > 6 then
                table.remove(u7, i);
                pop(v31);
                v33 = i;
            else
                v31.position = Vector3.new(v31.position.X, v32, v31.position.Z);
                v31.spin = v31.spin * CFrame.Angles(v31.rate * p28, v31.rate * p28 * 0.7, 0);
                table.insert(u8, v31.part);
                local v34 = CFrame.new(v31.position) * v31.spin;
                table.insert(u9, v34);
                v33 = i;
            end;
        end;

        if #u8 > 0 then
            workspace:BulkMoveTo(u8, u9, Enum.BulkMoveMode.FireCFrameChanged);
        end;
    end);
end;

return v4;