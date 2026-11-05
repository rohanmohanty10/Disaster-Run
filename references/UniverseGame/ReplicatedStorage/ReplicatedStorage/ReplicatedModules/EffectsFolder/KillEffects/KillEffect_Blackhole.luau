  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
ReplicatedStorage:FindFirstChild("ReplicatedModules");
ReplicatedStorage:FindFirstChild("Client Assets");
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

local function Rand(p3, p4) -- Line: 19
    -- upvalues: u1 (copy)
    return u1:NextNumber(p3, p4);
end;

return function(p5) -- Line: 23
    -- upvalues: u1 (copy), AssetHandler (copy), TweenService (copy), EffectsHandler (copy), ParticleHandler (copy), Rand (copy), u2 (copy)
    local TargetCharacter = p5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local Position = HumanoidRootPart.Position;
    local v6 = u1:NextNumber(8, 12) * (math.random(1, 2) == 1 and 1 or -1);
    local v7 = u1:NextNumber(8, 12);
    local v8 = math.random(1, 2) == 1 and 1 or -1;
    local u9 = Position + Vector3.new(v6, 5, v7 * v8);
    local u10 = AssetHandler.CloneAsset("Blackhole/Blackhole", {
        AbilityName = "KillEffects"
    });
    u10.CFrame = CFrame.new(u9);
    u10.Parent = workspace.Effects;
    TweenService:Create(HumanoidRootPart, TweenInfo.new(2.25, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(u9) * CFrame.Angles(u1:NextNumber(0, 6.283185307179586), u1:NextNumber(0, 6.283185307179586), u1:NextNumber(0, 6.283185307179586))
    }):Play();
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(u9)
    });
    task.delay(1.35, function() -- Line: 45
        -- upvalues: TargetCharacter (copy), TweenService (ref)
        for _, descendant in TargetCharacter:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(1.2000000000000002, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();
            elseif descendant:IsA("Mesh") or descendant:IsA("SpecialMesh") then
                TweenService:Create(descendant, TweenInfo.new(1.2000000000000002, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Scale = Vector3.new(0, 0, 0)
                }):Play();
            end;
        end;
    end);
    task.delay(2.7, function() -- Line: 61
        -- upvalues: ParticleHandler (ref), u10 (copy), TweenService (ref)
        ParticleHandler.EnableAllParticles(u10, false);
        ParticleHandler.DestroyEmit(u10);
        TweenService:Create(u10, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);

    for i = 1, 15 do
        local v11 = workspace;
        local v12 = u1:NextNumber(-1, 1);
        local v13 = u1:NextNumber(-1, 0.15);
        local v14 = v11:Raycast(u9, Vector3.new(v12, v13, Rand(-1, 1)) * 35, u2);

        if v14 then
            local v15 = u1:NextNumber(1.8, 2.95);
            local v16 = u1:NextNumber(1.8, 2.95);
            local v17 = Vector3.new(v15, v16, Rand(1.8, 2.95));
            local v18 = CFrame.new(v14.Position);
            local Angles = CFrame.Angles;
            local v19 = math.random(-180, 180);
            local v20 = math.rad(v19);
            local v21 = math.random(-180, 180);
            local v22 = math.rad(v21);
            local v23 = math.random(-180, 180);
            local u24 = v18 * Angles(v20, v22, (math.rad(v23)));
            local v25 = (u24.Position + u9) / 2;
            local v26 = math.random(-10, 10);
            local v27 = math.random(-10, 10);
            local u28 = v25 + Vector3.new(v26, v27, math.random(-10, 10));
            local u29 = AssetHandler.CloneAsset("Blackhole/Debris", {
                AbilityName = "KillEffects"
            });
            u29.Material = v14.Instance.Material == Enum.Material.Plastic and Enum.Material.SmoothPlastic or v14.Instance.Material;
            u29.Size = v17;
            u29.CFrame = u24;
            u29.Anchored = true;
            u29.Color = v14.Instance.Color;
            u29.Parent = workspace.Effects;
            task.delay(12, u29.Destroy, u29);
            task.spawn(function() -- Line: 91
                -- upvalues: u29 (copy), u24 (copy), u28 (copy), u9 (copy), AssetHandler (ref), Rand (ref)
                for i2 = 1, 22 do
                    local v30 = i2 / 22;
                    u29.Position = (1 - v30) ^ 2 * u24.Position + 2 * (1 - v30) * v30 * u28 + v30 ^ 2 * u9;
                    local v31;

                    if i2 == 11 then
                        AssetHandler.ScaleAsset(u29, {
                            Scale = 0.01,
                            TweenInfo = TweenInfo.new(Rand(0.44, 0.625))
                        });
                        task.delay(1, function() -- Line: 100
                            -- upvalues: u29 (ref)
                            u29:Destroy();
                        end);
                        v31 = 0;
                    else
                        v31 = 0;
                    end;

                    repeat
                        v31 = v31 + task.wait();
                    until v31 >= 0.016666666666666666;
                end;
            end);
        end;

        if i % 5 == 0 then
            local Part = Instance.new("Part");
            Part.Material = Enum.Material.ForceField;
            Part.Shape = "Ball";
            Part.Size = Vector3.new(10, 10, 10);
            Part.Transparency = 0.25;
            Part.Position = u9;
            Part.Color = Color3.new(0, 0, 0);
            Part.CanCollide = false;
            Part.CastShadow = false;
            Part.Anchored = true;
            Part.Parent = workspace.Effects;
            task.delay(2.142857142857143, Part.Destroy, Part);
            TweenService:Create(Part, TweenInfo.new(2), {
                Size = Vector3.new(0, 0, 0),
                Transparency = 1
            }):Play();
        end;

        local v32 = u1:NextNumber(-20, 20);
        local v33 = u1:NextNumber(-20, 20);
        local u34 = u9 + Vector3.new(v32, v33, Rand(-20, 20));
        local v35 = u1:NextNumber(-20, 20);
        local v36 = u1:NextNumber(-20, 20);
        local u37 = u9 + Vector3.new(v35, v36, Rand(-20, 20));
        local v38 = u1:NextNumber(-20, 20);
        local v39 = u1:NextNumber(-20, 20);
        local u40 = u9 + Vector3.new(v38, v39, Rand(-20, 20));
        local u41 = AssetHandler.CloneAsset("Blackhole/Trail" .. math.random(1, 2), {
            AbilityName = "KillEffects"
        });
        u41.Position = u34;
        u41.Parent = workspace.Effects;
        task.spawn(function() -- Line: 140
            -- upvalues: u41 (copy), u34 (copy), u37 (copy), u40 (copy), u9 (copy), ParticleHandler (ref)
            for i2 = 1, 22 do
                local v42 = i2 / 22;
                u41.Position = (1 - v42) ^ 3 * u34 + 3 * (1 - v42) ^ 2 * v42 * u37 + 3 * (1 - v42) * v42 ^ 2 * u40 + v42 ^ 3 * u9;
                local v43 = 0;

                repeat
                    v43 = v43 + task.wait();
                until v43 >= 0.016666666666666666;
            end;

            ParticleHandler.EnableAllParticles(u41, false);
            ParticleHandler.DestroyEmit(u41);
        end);
        task.wait(0.15);
    end;
end;