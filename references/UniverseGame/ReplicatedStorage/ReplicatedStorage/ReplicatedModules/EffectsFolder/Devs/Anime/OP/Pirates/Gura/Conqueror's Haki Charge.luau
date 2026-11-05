  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u2 = Random.new();
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Include;
u3.FilterDescendantsInstances = { workspace.Map };

return function(p4) -- Line: 15
    -- upvalues: u1 (copy), ParticleHandler (copy), u2 (copy), u3 (copy), TweenService (copy)
    local Character = p4.Character;
    local v5 = p4.Release / 60;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v6 = os.clock();
    local v7 = u1.Gura.HeadCharge:Clone();
    v7.Parent = Character;
    ParticleHandler.AttachTo(v7, {
        Part = Character.Head,
        Offset = CFrame.identity
    });
    local v8 = u1.Gura.GroundCharge:Clone();
    v8.Parent = Character;
    ParticleHandler.AttachTo(v8, {
        Part = HumanoidRootPart,
        Offset = CFrame.new(0, 10, 0)
    });
    local Model = Instance.new("Model");
    Model.Name = "Conqueror Haki Rocks";
    Model.Parent = workspace.Effects;
    task.delay(v5 + 3, Model.Destroy, Model);
    local v9 = os.clock();

    while true do
        if Character:GetAttribute("Timestopped") then
            task.wait(0.1);
        else
            local Position = HumanoidRootPart.Position;
            local v10 = u2:NextNumber(-50, 50);
            local v11 = Position + Vector3.new(v10, 0, u2:NextNumber(-50, 50));
            local v12 = workspace:Raycast(v11 + Vector3.new(0, 7.5, 0), Vector3.new(0, -60, 0), u3);

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
                Part.Size = Vector3.new(1, 1, 1) * u2:NextNumber(2.25, 4);
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;
                Part.Parent = Model;
                task.delay(v5, Part.Destroy, Part);

                for _, child in pairs(Instance2:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                local v15 = math.random(0, 360);
                math.rad(v15);
                local v16 = {
                    Size = Vector3.new(0, 0, 0)
                };
                local Position2 = Part.Position;
                local v17 = Part.Size.Magnitude * u2:NextNumber(5.5, 6);
                v16.Position = Position2 + Vector3.new(0, v17, 0);
                local v18 = math.random(500, 600);
                local v19 = math.random(500, 600);
                v16.Orientation = Vector3.new(v18, v19, math.random(500, 600));
                TweenService:Create(Part, TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), v16):Play();
            end;

            if os.clock() - v9 > 0.45 and os.clock() - v6 < v5 * 0.55 then
                v9 = os.clock();
                local Part = Instance.new("Part");
                Part.Transparency = 1;
                Part.Shape = "Ball";
                Part.Material = Enum.Material.ForceField;
                Part.Color = Color3.new(1, 1, 1);
                Part.Size = Vector3.new(27, 27, 27);
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CastShadow = false;
                Part.Position = Character.Head.Position;
                Part.Parent = workspace.Effects;
                task.delay(1.1, Part.Destroy, Part);
                TweenService:Create(Part, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    Size = Vector3.new(0, 0, 0),
                    Transparency = 0.5
                }):Play();
            end;

            task.wait(u2:NextNumber(0.03, 0.065));
        end;

        if not Character:IsDescendantOf(game) or os.clock() - v6 > v5 * 0.8 then
            task.delay(ParticleHandler.EnableParticles(v7, false), v7.Destroy, v7);
            task.delay(ParticleHandler.EnableParticles(v8, false), v8.Destroy, v8);

            return;
        end;
    end;
end;