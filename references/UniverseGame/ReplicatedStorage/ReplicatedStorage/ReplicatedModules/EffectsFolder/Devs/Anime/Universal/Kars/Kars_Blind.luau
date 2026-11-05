  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();

return function(p1, p2) -- Line: 9
    -- upvalues: AssetHandler (copy), EffectsHandler (copy)
    if not p1 then
        return;
    end;

    local v3 = AssetHandler.GetAbilityData(p1);
    local HumanoidRootPart = p1.HumanoidRootPart;
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Blind/FloorSmoke",
        AutoSerialize = true,
        Character = p1,
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0),
        AbilityName = v3.AbilityName,
        SkinName = v3.SkinName
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Blind/Emit",
        AutoSerialize = true,
        Character = p1,
        Origin = HumanoidRootPart.CFrame,
        AbilityName = v3.AbilityName,
        SkinName = v3.SkinName
    });
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 1,
        Size = Vector3.new(2.7, 2.7, 2.7),
        Amount = 21,
        Origin = HumanoidRootPart.CFrame,
        Radius = p2
    });

    for _ = 1, math.random(6, 8) do
        if not p1:IsDescendantOf(game) then
            break;
        end;

        local Part = Instance.new("Part");
        Part.Shape = "Ball";
        Part.Material = Enum.Material.ForceField;
        Part.Color = Color3.new(1, 1, 1);
        Part.Size = Vector3.new(0, 0, 0);
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.Position = HumanoidRootPart.Position;
        Part.Parent = workspace.Effects;
        task.delay(0.1, Part.Destroy, Part);
        game.TweenService:Create(Part, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(37, 37, 37),
            Transparency = 1
        }):Play();
        task.wait(0.1);
    end;
end;