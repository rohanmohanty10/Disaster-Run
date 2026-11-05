  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;
local u2 = Random.new();

local function Rng(p3, p4) -- Line: 27
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local _ = Players.LocalPlayer;

return function(p5, p6) -- Line: 33
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy)
    if not p5.Parent then
        return;
    end;

    local Targets = p6.Targets;

    if not (p6 and p6.Targets) then
        return;
    end;

    for i = 1, #p6.Targets do
        local v7 = Targets[i]:FindFirstChild("HumanoidRootPart") or Targets[i].PrimaryPart;
        local v8 = p5:FindFirstChild("HumanoidRootPart") or p5.PrimaryPart;
        local Magnitude = (ParticleHandler.TranslateToPosition(v7) - ParticleHandler.TranslateToPosition(v8)).Magnitude;
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Disrupt/Siphon",
            Scale = 1,
            Origin = CFrame.lookAt(v7.Position, v8.Position),
            Character = p5
        });
        task.spawn(EffectsHandler.CallEffect, "Path Bezier", p5, {
            EffectPath = "Particles/Disrupt/SiphonTrail",
            Amount = 1,
            Origin = v7,
            Goal = v8,
            CurveRadius = Magnitude / 3,
            SpreadAngle = NumberRange.new(-90, 90),
            EasingStyle = Enum.EasingStyle.Sine,
            EasingDirection = Enum.EasingDirection.Out,
            Lifetime = Magnitude / 60 / (p6.Speed or 1)
        });
    end;
end;