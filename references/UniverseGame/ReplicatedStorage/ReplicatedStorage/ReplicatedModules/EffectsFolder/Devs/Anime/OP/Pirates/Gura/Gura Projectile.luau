  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
Random.new();

return function(u3) -- Line: 16
    -- upvalues: u1 (copy), TweenService (copy), ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), u2 (copy)
    local Start = u3.Start;
    local End = u3.End;
    local Duration = u3.Duration;
    local Offset = u3.Offset;
    local u4 = u1.Gura.Quake:Clone();
    u4.CFrame = CFrame.new(Start.Position, End.Position);
    u4.Parent = workspace.Effects;
    local u5 = TweenInfo.new(Duration * 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    u4.Transparency = 1;
    u4.Outline.Transparency = 1;
    TweenService:Create(u4, u5, {
        Transparency = 0
    }):Play();
    TweenService:Create(u4.Outline, u5, {
        Transparency = 0
    }):Play();
    task.delay(Duration + 2, u4.Destroy, u4);
    TweenService:Create(u4, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
        CFrame = End * CFrame.new(0, 0, u4.Size.Z / 4)
    }):Play();
    task.delay(Duration * 0.85, function() -- Line: 39
        -- upvalues: TweenService (ref), u4 (copy), u5 (copy), ParticleHandler (ref)
        TweenService:Create(u4, u5, {
            Transparency = 1
        }):Play();
        TweenService:Create(u4.Outline, u5, {
            Transparency = 1
        }):Play();
        ParticleHandler.EnableParticles(u4, false);

        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0, function() -- Line: 49
        -- upvalues: u4 (copy), u1 (ref), TweenService (ref), AssetHandler (ref), ParticleHandler (ref), EffectsHandler (ref), Duration (copy)
        for i = 1, 3 do
            local CFrame2 = u4.CFrame;
            local v6 = u1.Gura.ProjectileShockwaves:Clone();
            v6:SetPrimaryPartCFrame(CFrame2);
            v6.Parent = workspace.Effects;
            local v7 = i / 3 + 1;

            for _, child in ipairs(v6:GetChildren()) do
                TweenService:Create(child, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1,
                    Size = child.Size * v7 * 3
                }):Play();
            end;

            task.delay(0.4, v6.Destroy, v6);
            local v8 = u1.Gura.QuakeSmash:Clone();
            v8.CFrame = CFrame2;
            v8.Parent = workspace.Effects;
            AssetHandler.ScaleAsset(v8, {
                Scale = v7
            });
            ParticleHandler.Emit(v8, ParticleHandler.GenerateEmitInfo(v8));
            ParticleHandler.DestroyEmit(v8);
            EffectsHandler.CallEffect("Flying Debris", {
                Lifetime = 4,
                Collision = true,
                Size = 3.2,
                TweenDelay = 3,
                Origin = CFrame2 * CFrame.new(0, -6.5, 0),
                Tween = {
                    Size = Vector3.new(0, 0, 0)
                }
            });
            task.wait(Duration / 4);
        end;
    end);
    local Unit = (End.Position - Start.Position).Unit;
    local Magnitude = (End.Position - Start.Position).Magnitude;
    local v9 = math.ceil(Magnitude / 5.5);
    local v10 = Duration / v9 * 0.75;
    EffectsHandler.CallEffect("Rock Trail", {
        Size = 5.5,
        DurationOffset = 0.1,
        Down = true,
        Origin = Start * CFrame.new(0, -5, 0),
        LookVector = Unit,
        Offset = Offset,
        Distance = Magnitude,
        Amount = v9,
        Duration = Duration,
        SpawnDelay = v10
    });
    local v11 = math.ceil(3.141592653589793 * Offset / 6);
    local v12 = 0;

    for i = 1, v11 do
        v12 = v12 + 1.5707963267948966 / v11;

        for i2 = 1, i == v11 and 1 or 2 do
            local v13 = math.sin(v12) * Offset;
            local v14 = math.cos(v12) * Offset;

            if i2 % 2 == 0 then
                v14 = -v14 or v14;
            end;

            local v15 = End * CFrame.new(v14, 0, -v13);
            local v16 = workspace:Raycast(v15.Position, Vector3.new(0, -15, 0), u2);

            if v16 then
                local Instance2 = v16.Instance;
                local v17 = math.random(-360, 360);
                local Part = Instance.new("Part");
                Part.Parent = workspace.Effects;
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanTouch = false;
                Part.Material = v16.Material;
                Part.Color = Instance2.Color;
                Part.CFrame = CFrame.new(v16.Position) * CFrame.Angles(v17, v17, v17);
                Part.Size = Vector3.new(5.5, 5.5, 5.5);
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;

                for _, child in pairs(Instance2:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                local u18 = {
                    Size = Vector3.new(0, 0, 0),
                    Position = Part.Position + Vector3.new(0, -Part.Size.Magnitude, 0)
                };
                task.delay(i * 0.1 + v9 * 0.1, function() -- Line: 154
                    -- upvalues: u3 (copy), Duration (copy), TweenService (ref), Part (copy), u18 (copy)
                    local v19 = TweenService:Create(Part, u3.Info or TweenInfo.new(Duration, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), u18);
                    v19:Play();
                    v19.Completed:Connect(function() -- Line: 158
                        -- upvalues: Part (ref)
                        task.defer(Part.Destroy, Part);
                    end);
                end);
            end;
        end;

        task.wait(v10 / 2);
    end;
end;