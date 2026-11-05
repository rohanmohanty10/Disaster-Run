  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u2 = Random.new();
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Whitelist;
u3.FilterDescendantsInstances = { workspace.Map };

local function Rand(p4, p5) -- Line: 17
    -- upvalues: u2 (copy)
    return u2:NextNumber(p4, p5);
end;

return function(p6, p7, p8, p9) -- Line: 21
    -- upvalues: u2 (copy), TweenService (copy), Rand (copy), u3 (copy), u1 (copy), ParticleHandler (copy)
    local CFrame2 = p6.CFrame;
    local v10;

    if p9 == nil then
        v10 = false;
    else
        v10 = p9.HSVData;
    end;

    local v11 = p6.SoundAttach:Clone();
    v11.WorldCFrame = CFrame2;
    v11.Parent = workspace.Terrain;
    v11:FindFirstChildOfClass("Sound"):Play();
    task.delay(6.5, v11.Destroy, v11);
    local u12 = {};
    p6.AncestryChanged:Connect(function(p13, p14) -- Line: 36
        -- upvalues: u12 (copy), CFrame2 (copy), u2 (ref), TweenService (ref)
        if not p14 then
            for i, v in next, u12 do
                i.Size = v;
                i.Anchored = false;
                local v15 = next;
                local v16, v17 = i:GetDescendants();

                for _, v2 in v15, v16, v17 do
                    if v2:IsA("ParticleEmitter") or v2:IsA("Trail") then
                        v2.Enabled = true;
                    end;
                end;

                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Velocity = (CFrame2.UpVector * u2:NextNumber(0.35, 1) + CFrame2.RightVector * u2:NextNumber(-1, 1) + CFrame2.LookVector * u2:NextNumber(-1, 1)) * u2:NextNumber(40, 47);
                BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000);
                BodyVelocity.Parent = i;
                task.delay(0.15, BodyVelocity.Destroy, BodyVelocity);
                task.delay(1.85, function() -- Line: 55
                    -- upvalues: TweenService (ref), i (copy)
                    TweenService:Create(i, TweenInfo.new(0.2), {
                        Transparency = 1
                    }):Play();
                    local v18 = next;
                    local v19, v20 = i:GetDescendants();

                    for _, v2 in v18, v19, v20 do
                        if v2:IsA("ParticleEmitter") or v2:IsA("Trail") then
                            v2.Enabled = false;
                        end;
                    end;

                    task.delay(0.2, i.Destroy, i);
                end);
            end;
        end;
    end);

    for i = 1, 15 do
        local v21 = workspace;
        local Position = CFrame2.Position;
        local v22 = u2:NextNumber(-1, 1);
        local v23 = u2:NextNumber(-1, 0.15);
        local v24 = v21:Raycast(Position, Vector3.new(v22, v23, Rand(-1, 1)) * 35, u3);

        if v24 then
            local v25 = u2:NextNumber(1.8, 2.95);
            local v26 = u2:NextNumber(1.8, 2.95);
            local v27 = Vector3.new(v25, v26, Rand(1.8, 2.95));
            local v28 = CFrame.new(v24.Position);
            local Angles = CFrame.Angles;
            local v29 = math.random(-180, 180);
            local v30 = math.rad(v29);
            local v31 = math.random(-180, 180);
            local v32 = math.rad(v31);
            local v33 = math.random(-180, 180);
            local u34 = v28 * Angles(v30, v32, (math.rad(v33)));
            local v35 = (u34.Position + CFrame2.Position) / 2;
            local v36 = math.random(-10, 10);
            local v37 = math.random(-10, 10);
            local u38 = v35 + Vector3.new(v36, v37, math.random(-10, 10));
            local u39 = (p8 and (u1.Sol:FindFirstChild(p8) and u1.Sol[p8]:FindFirstChild("Debris", true)) and u1.Sol[p8] or u1.Sol).Debris:Clone();
            u39.Material = v24.Instance.Material == Enum.Material.Plastic and Enum.Material.SmoothPlastic or v24.Instance.Material;
            u39.Size = v27;
            u39.CFrame = u34;
            u39.Anchored = true;
            u39.Color = v24.Instance.Color;

            if v10 ~= nil then
                ParticleHandler.Unusualify(u39, {
                    HSVData = v10
                });
            end;

            u39.Parent = workspace.Effects;
            task.delay(12, u39.Destroy, u39);
            task.spawn(function() -- Line: 90
                -- upvalues: u39 (copy), u34 (copy), u38 (copy), CFrame2 (copy), TweenService (ref), Rand (ref)
                for i2 = 1, 22 do
                    local v40 = i2 / 22;
                    u39.Position = (1 - v40) ^ 2 * u34.Position + 2 * (1 - v40) * v40 * u38 + v40 ^ 2 * CFrame2.Position;

                    if i2 == 11 then
                        TweenService:Create(u39, TweenInfo.new(Rand(0.44, 0.625)), {
                            Size = Vector3.new(0, 0, 0)
                        }):Play();
                    end;

                    task.wait();
                end;
            end);
            u12[u39] = v27;
        end;

        if i % 5 == 0 then
            local Part = Instance.new("Part");
            Part.Material = Enum.Material.ForceField;
            Part.Shape = "Ball";
            Part.Size = Vector3.new(10, 10, 10);
            Part.Transparency = 0.25;
            Part.CFrame = CFrame2;
            Part.Color = Color3.new(0, 0, 0);
            Part.CanCollide = false;
            Part.Anchored = true;
            Part.Parent = workspace.Effects;
            task.delay(p7 / 1.4, Part.Destroy, Part);
            TweenService:Create(Part, TweenInfo.new(p7 / 1.5), {
                Size = Vector3.new(0, 0, 0),
                Transparency = 1
            }):Play();
        end;

        local Position2 = CFrame2.Position;
        local v41 = u2:NextNumber(-20, 20);
        local v42 = u2:NextNumber(-20, 20);
        local u43 = Position2 + Vector3.new(v41, v42, Rand(-20, 20));
        local Position3 = CFrame2.Position;
        local v44 = u2:NextNumber(-20, 20);
        local v45 = u2:NextNumber(-20, 20);
        local u46 = Position3 + Vector3.new(v44, v45, Rand(-20, 20));
        local Position4 = CFrame2.Position;
        local v47 = u2:NextNumber(-20, 20);
        local v48 = u2:NextNumber(-20, 20);
        local u49 = Position4 + Vector3.new(v47, v48, Rand(-20, 20));
        local u50 = (p8 and (u1.Sol:FindFirstChild(p8) and u1.Sol[p8]:FindFirstChild("BlackHoleTrails", true)) and u1.Sol[p8] or u1.Sol).BlackHoleTrails["TrailPull" .. (i % 2 == 0 and "1" or "2")]:Clone();

        if v10 ~= nil then
            ParticleHandler.Unusualify(u50, {
                HSVData = v10
            });
        end;

        u50.Position = u43;
        u50.Parent = workspace.Effects;
        task.spawn(function() -- Line: 136
            -- upvalues: u50 (copy), u43 (copy), u46 (copy), u49 (copy), CFrame2 (copy)
            for i2 = 1, 22 do
                local v51 = i2 / 22;
                u50.Position = (1 - v51) ^ 3 * u43 + 3 * (1 - v51) ^ 2 * v51 * u46 + 3 * (1 - v51) * v51 ^ 2 * u49 + v51 ^ 3 * CFrame2.Position;
                task.wait();
            end;

            local v52 = next;
            local v53, v54 = u50:GetDescendants();

            for _, v in v52, v53, v54 do
                if v:IsA("Trail") or v:IsA("ParticleEmitter") then
                    v.Enabled = false;
                end;
            end;

            task.delay(1, u50.Destroy, u50);
        end);
        task.wait(p7 / 20);
    end;
end;