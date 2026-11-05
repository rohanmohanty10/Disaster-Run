  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local u1 = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
Random.new();

return function(p2) -- Line: 9
    -- upvalues: EffectsHandler (copy), u1 (copy), TweenService (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Origin = HumanoidRootPart.CFrame,
        Particle = u1.NPCs.Breaker
    });

    for _ = 1, 5 do
        task.wait(0.055);
        local Part = Instance.new("Part");
        Part.Transparency = 0.9;
        Part.Shape = "Ball";
        Part.Material = Enum.Material.Neon;
        Part.Color = Color3.new(0.956863, 0.0509804, 0.909804);
        Part.Size = Vector3.new(0, 0, 0);
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.Position = p2.Head.Position;
        Part.Parent = workspace.Effects;
        task.delay(0.2, Part.Destroy, Part);
        TweenService:Create(Part, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(60, 60, 60),
            Transparency = 1
        }):Play();
    end;
end;