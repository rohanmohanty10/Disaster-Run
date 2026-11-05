  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);
local LightningBolt = require(ReplicatedStorage.ClientModules.LightningBolt);
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
AssetHandler.GetAsset("Particles/VoltExplosion/Meshes", {
    AbilityName = "Sternritter A: Antithesis"
});

return function(p1) -- Line: 12
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), TweenService (copy), LightningBolt (copy)
    local u2 = AssetHandler.CloneAsset("Particles/VoltExplosion/Explode", {
        AbilityName = "Sternritter A: Antithesis"
    });
    u2.CFrame = p1;
    u2.Parent = workspace.Effects;
    local v3 = {};

    for _, descendant in pairs(u2:GetDescendants()) do
        if descendant:IsA("Beam") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(1);
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.35,
                EasingStyle = "EntranceExpressive",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = Transparency
                }
            });
            table.insert(v3, descendant);
        end;
    end;

    AssetHandler.ScaleAsset(u2, {
        Scale = 60,
        TweenInfo = { 0.35 }
    });
    task.delay(0.4, AssetHandler.ScaleAsset, u2, {
        Scale = 1.25,
        TweenInfo = { 1.6 }
    });
    task.delay(1, function() -- Line: 50
        -- upvalues: TweenService (ref), u2 (copy), EffectsHandler (ref)
        TweenService:Create(u2, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            Transparency = 1
        }):Play();

        for _, descendant in pairs(u2:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                EffectsHandler.CallEffect("Boat Tween", descendant, {
                    Time = 0.35,
                    EasingStyle = "EntranceExpressive",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = {
                        Transparency = NumberSequence.new(1)
                    }
                });
            end;
        end;

        task.delay(0.8, u2.Destroy, u2);
    end);
    task.spawn(function() -- Line: 74
        -- upvalues: EffectsHandler (ref), u2 (copy), TweenService (ref)
        for _ = 1, 4 do
            EffectsHandler.Wait(0.15);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CastShadow = false;
            Part.Size = Vector3.new(20, 20, 20);
            Part.Position = u2.Position;
            Part.Color = Color3.fromRGB(76, 94, 255);
            Part.Material = Enum.Material.ForceField;
            Part.Shape = Enum.PartType.Ball;
            Part.Parent = workspace.Effects;
            TweenService:Create(Part, TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = Vector3.new(88.88889, 88.88889, 88.88889),
                Transparency = 1
            }):Play();
            task.delay(0.5, Part.Destroy, Part);
        end;
    end);
    task.spawn(function() -- Line: 116
        -- upvalues: u2 (copy), LightningBolt (ref), EffectsHandler (ref)
        for _ = 1, 30 do
            local Attachment = Instance.new("Attachment");
            Attachment.WorldCFrame = u2.CFrame * CFrame.new(math.random(-45, 45), math.random(10, 40), math.random(-45, 45));
            Attachment.Parent = workspace.Terrain;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.Parent = u2;
            local v4 = LightningBolt.new(Attachment2, Attachment, 22);
            v4.PulseSpeed = 4.25;
            v4.PulseLength = 0.7;
            v4.Thickness = 0.85;
            v4.MinThicknessMultiplier = 0.65;
            v4.MaxThicknessMultiplier = 1;
            v4.AnimationSpeed = 6.25;
            v4.MaxRadius = 10;
            v4.MinTransparency = 0;
            v4.MaxTransparency = 1;
            v4.ContractFrom = 1;
            v4.Color = Color3.fromRGB(110, 153, 202);
            EffectsHandler.Wait(0.04);
        end;
    end);
end;