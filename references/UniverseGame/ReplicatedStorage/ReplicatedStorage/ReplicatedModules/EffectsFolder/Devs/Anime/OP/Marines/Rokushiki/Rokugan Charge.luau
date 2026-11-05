  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
local u3 = Random.new();

return function(p4) -- Line: 21
    -- upvalues: u1 (ref), u3 (copy), u2 (copy), TweenService (copy)
    local v5 = p4 or {};
    local Character = v5.Character;
    local Duration = v5.Duration;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1.CallEffect("Mesh Emit", {
        Effect = "Rokugan Windup",
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -9, 0),
        Extra = Duration
    });
    task.spawn(function() -- Line: 41
        -- upvalues: Character (copy), u1 (ref), Duration (copy)
        for _, v in { "Left Arm", "Right Arm" } do
            u1.CallEffect("Bezier Trails", {
                Path = "Particles/Rokugan/Trails",
                Lifetime = 0.08,
                Amplitude = 2,
                Delay = 0.012,
                Character = Character,
                RelativePart = Character[v],
                Offset = CFrame.new(0, -1, 0),
                Amount = math.ceil(Duration / 0.025)
            });
        end;
    end);
    local v6 = os.clock();
    local v7 = os.clock() - 0.26;
    local v8 = { Color3.fromRGB(240, 117, 213), Color3.fromRGB(21, 142, 255) };
    local v9 = 1;

    while true do
        local Position = HumanoidRootPart.Position;
        local v10 = u3:NextNumber(-12, 12);
        local v11 = Position + Vector3.new(v10, 0, u3:NextNumber(-12, 12));
        local v12 = workspace:Raycast(v11 + Vector3.new(0, 7.5, 0), Vector3.new(0, -15, 0), u2);

        if v12 then
            local Instance2 = v12.Instance;
            local v13 = math.random(0, 360);
            local v14 = math.rad(v13);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.Material = v12.Material;
            Part.Color = Instance2.Color;
            Part.CFrame = CFrame.new(v12.Position) * CFrame.Angles(v14, v14, v14);
            Part.Size = Vector3.new(1, 1, 1) * u3:NextNumber(1.3, 1.7);
            Part.BottomSurface = Enum.SurfaceType.Smooth;
            Part.TopSurface = Enum.SurfaceType.Smooth;
            Part.Parent = workspace.Effects;
            task.delay(1, Part.Destroy, Part);

            for _, child in pairs(Instance2:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child:Clone().Parent = Part;
                end;
            end;

            local v15 = math.random(0, 360);
            math.rad(v15);
            local v16 = {};
            local Position2 = Part.Position;
            local v17 = Part.Size.Magnitude * u3:NextNumber(3, 4.35);
            v16.Position = Position2 + Vector3.new(0, v17, 0);
            local v18 = math.random(150, 275);
            local v19 = math.random(150, 275);
            v16.Orientation = Vector3.new(v18, v19, math.random(150, 275));
            local v20 = u3:NextNumber(0.3, 0.5);
            TweenService:Create(Part, TweenInfo.new(v20 * 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, v20 * 0.5), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
            TweenService:Create(Part, TweenInfo.new(v20, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), v16):Play();
        end;

        if os.clock() - v7 > 0.25 then
            v7 = os.clock();
            local Part = Instance.new("Part");
            Part.Transparency = 1;
            Part.Shape = "Ball";
            Part.Material = Enum.Material.Neon;
            Part.Color = v8[v9];
            Part.Size = Vector3.new(18, 18, 18);
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CastShadow = false;
            Part.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -4);
            Part.Parent = workspace.Effects;
            task.delay(1.1, Part.Destroy, Part);
            TweenService:Create(Part, TweenInfo.new(0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = Vector3.new(0, 0, 0),
                Transparency = 0.6
            }):Play();
            v9 = v9 + 1;

            if v9 > 2 then
                v9 = 1;
            end;
        end;

        u1.Wait(u3:NextNumber(0.025, 0.04));

        if not HumanoidRootPart:IsDescendantOf(game) or Duration <= os.clock() - v6 then
            return;
        end;
    end;
end;