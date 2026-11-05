  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 16
    -- upvalues: Trove (copy), u1 (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy), RunService (copy), EffectsHandler (copy)
    local v3 = p2 or {};
    local RootPart = v3.RootPart;
    local Origin = v3.Origin;
    local HSVData = v3.HSVData;
    local Player = v3.Player;
    local Duration = v3.Duration;
    local u4 = v3.Scalar or 1;
    local v5 = Origin or RootPart.CFrame;
    local u6 = v5 - v5.Position;
    local u7 = v5;
    local v8 = Trove.new();
    task.delay(Duration, v8.Destroy, v8);
    local u9 = {};
    local v10 = RaycastParams.new();
    v10.FilterType = Enum.RaycastFilterType.Include;
    v10.FilterDescendantsInstances = { workspace.Map };
    local v11 = workspace:Raycast(u7.Position, Vector3.new(0, -15, 0), v10);
    local v12 = 19 * u4;

    if v11 then
        local Instance2 = v11.Instance;
        local v13 = math.random(11, 14);

        for i = 1, v13 do
            local v14 = 6.283185307179586 / v13;
            local v15 = v14 * i + u1:NextNumber(-v14 * 0.8, v14 * 0.8);
            local v16 = u1:NextNumber(0, 360);
            local v17 = math.rad(v16);
            local v18 = u1:NextNumber(-1.25, 1.25) + 0.33;
            local v19 = u1:NextNumber(v12 * 0.9, v12 * 1.05);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = true;
            Part.CastShadow = false;
            Part.CollisionGroup = "Ghosted";
            Part.CanTouch = false;
            Part.Material = v11.Material;
            Part.Color = Instance2.Color;
            Part.CFrame = u7 * CFrame.new(math.cos(v15) * v19, v18, -math.sin(v15) * v19) * CFrame.Angles(v17, v17, v17);
            Part.Size = Vector3.new(1, 1, 1) * u1:NextNumber(0.4, 1.75) * u4;
            Part.BottomSurface = Enum.SurfaceType.Smooth;
            Part.TopSurface = Enum.SurfaceType.Smooth;
            Part.Parent = workspace.Effects;

            for _, child in pairs(Instance2:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child:Clone().Parent = Part;
                end;
            end;

            u9[Part] = {
                Angle = v15,
                Radius = v19,
                Height = v18
            };
        end;
    end;

    local u20 = AssetHandler.CloneAsset("Particles/IncalculableSpeed/Whirl", AssetHandler.GetAbilityData(Player));
    AssetHandler.ScaleAsset(u20, {
        Scale = u4
    });

    if Player or HSVData then
        ParticleHandler.Unusualify(u20, {
            HSVData = HSVData,
            Player = Player
        });
    end;

    u20.Parent = workspace.Effects;

    if RootPart then
        ParticleHandler.AttachTo(u20, {
            Part = RootPart
        });
    else
        u20.CFrame = u7;
    end;

    local u21 = AssetHandler.CloneAsset("Particles/IncalculableSpeed/GroundSpin", AssetHandler.GetAbilityData(Player));
    AssetHandler.ScaleAsset(u21, {
        Scale = u4
    });

    if Player or HSVData then
        ParticleHandler.Unusualify(u21, {
            HSVData = HSVData,
            Player = Player
        });
    end;

    u21.Parent = workspace.Effects;
    v8:Add(function() -- Line: 104
        -- upvalues: ParticleHandler (ref), u21 (copy), u20 (copy)
        ParticleHandler.EnableAllParticles(u21, false);
        ParticleHandler.DestroyEmit(u21);
        ParticleHandler.EnableAllParticles(u20, false);
        ParticleHandler.DestroyEmit(u20);
    end);
    local Model = Instance.new("Model");
    Model.Name = "Tornado Container";
    Model.Parent = workspace.Effects;
    task.spawn(function() -- Line: 116
        -- upvalues: Duration (copy), AssetHandler (ref), Player (copy), ParticleHandler (ref), HSVData (copy), u7 (ref), u4 (copy), Model (copy), TweenService (ref), RunService (ref), EffectsHandler (ref)
        for _ = 1, math.floor(Duration * 5) do
            local u22 = AssetHandler.CloneAsset("Particles/IncalculableSpeed/Ring", AssetHandler.GetAbilityData(Player));
            ParticleHandler.Unusualify(u22, {
                HSVData = HSVData,
                Player = Player
            });
            local Angles = CFrame.Angles;
            local v23 = math.random(0, 360);
            u22.CFrame = u7 * Angles(0, math.rad(v23), 0);
            AssetHandler.ScaleAsset(u22, {
                Scale = u4
            });
            u22.Parent = Model;
            task.delay(1, u22.Destroy, u22);
            local CFrame2 = u22.CFrame;

            for _, descendant in u22:GetDescendants() do
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(0.6), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;

            task.spawn(function() -- Line: 142
                -- upvalues: u22 (copy), CFrame2 (copy), RunService (ref)
                local v24 = os.clock();

                while u22.Parent do
                    local v25 = (os.clock() - v24) / 1;

                    if v25 >= 1 then
                        break;
                    end;

                    u22.CFrame = CFrame2 * CFrame.Angles(0, math.rad(1080 * (1 - (1 - v25) ^ 3)), 0);
                    RunService.Heartbeat:Wait();
                end;
            end);
            EffectsHandler.Wait(0.2);
        end;
    end);
    local u26 = u1:NextNumber(11.5, 13);
    local u27 = u26 * 0.7;
    v8:Connect(RunService.RenderStepped, function(p28) -- Line: 162
        -- upvalues: RootPart (copy), Origin (copy), u7 (ref), u6 (copy), u21 (copy), u27 (copy), u9 (copy), u26 (copy)
        if RootPart and not Origin then
            u7 = CFrame.new(RootPart.Position) * u6;
        end;

        if u21:IsDescendantOf(game) then
            u21.Position = u7.Position - Vector3.new(0, 2.5, 0);
            local v29 = u21;
            v29.Orientation = v29.Orientation + Vector3.new(0, u27 * p28 * 60, 0);
        end;

        for i, v in u9 do
            local v30 = u9[i];
            v30.Angle = v30.Angle + math.rad(u26 * p28 * 60);
            i.Position = (u7 * CFrame.new(math.cos(v.Angle) * v.Radius, v.Height, -math.sin(v.Angle) * v.Radius)).Position;
        end;
    end);
    v8:Add(function() -- Line: 179
        -- upvalues: EffectsHandler (ref), Model (copy), u9 (copy), u7 (ref), u1 (ref), TweenService (ref)
        EffectsHandler.CallEffect("FadeBeams", Model);
        task.delay(0.5, Model.Destroy, Model);

        for i, _ in u9 do
            i.Anchored = false;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000);
            BodyVelocity.Velocity = (Vector3.new(0, 1, 0)):Cross(i.Position - u7.Position).Unit * u1:NextNumber(50, 80);
            BodyVelocity.Parent = i;
            task.delay(0.03, BodyVelocity.Destroy, BodyVelocity);
            local v31 = TweenService:Create(i, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 1.5), {
                Size = Vector3.new(0, 0, 0)
            });
            v31:Play();
            v31.Completed:Connect(function() -- Line: 198
                -- upvalues: i (copy)
                i:Destroy();
            end);
        end;
    end);
end;