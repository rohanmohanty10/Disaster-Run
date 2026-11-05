  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local v2 = RaycastParams.new();
v2.FilterType = Enum.RaycastFilterType.Include;
v2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 20
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy), EffectsHandler (copy)
    local v4 = p3 or {};
    local Model = v4.Model;
    local Duration = v4.Duration;
    local Origin = v4.Origin;

    if not Model then
        return;
    end;

    local v5 = {
        AbilityName = "Veltryx"
    };
    local Attachment = Instance.new("Attachment");
    Attachment.Position = Vector3.new(0, -1, 0);
    Attachment.Parent = Model["Right Arm"];
    local v6 = AssetHandler.CloneAsset("Particles/Creation/Impact", v5);
    v6.Position = Origin;
    v6.Anchored = true;
    v6.Parent = workspace.Effects;
    ParticleHandler.EnableAllParticles(v6, true);
    local u7;

    if v6 then
        u7 = v6:FindFirstChildOfClass("Attachment");
    else
        u7 = v6;
    end;

    local v8 = AssetHandler.CloneAsset("Particles/Creation/Lightning", v5);
    v8.Parent = workspace.Effects;
    local v9 = AssetHandler.CloneAsset("Particles/Creation/Firing", v5);
    v9.CFrame = CFrame.new(Attachment.WorldPosition, v6.Position);
    v9.Parent = workspace.Effects;
    local v10 = os.clock();

    while Model:IsDescendantOf(game) and (v6:IsDescendantOf(game) and os.clock() - v10 <= Duration) do
        local Magnitude = (v6.Position - Model.PrimaryPart.Position).Magnitude;
        local v11 = Model.PrimaryPart.Position:Lerp(v6.Position, 0.5);
        v8.Size = Vector3.new(v8.Size.X, v8.Size.Y, Magnitude);
        v8.CFrame = CFrame.new(v11, v6.Position);
        v9.CFrame = CFrame.new(Attachment.WorldPosition, v6.Position);
        task.spawn(function() -- Line: 62
            -- upvalues: u1 (ref), Magnitude (copy), EffectsHandler (ref), Attachment (copy), u7 (copy)
            local v12 = u1:NextNumber(3, 6);
            local v13 = u1:NextNumber(0, 6);
            local v14 = math.random(1, 3) == 1 and 0 or v13;
            local v15 = u1:NextNumber(8, 10);
            local v16 = u1:NextNumber(1.3, 1.6);
            local v17 = { u1:NextNumber(-5, 5), u1:NextNumber(-5, 5) };
            local v18 = ColorSequence.new(Color3.fromRGB(105, 141, 192));
            local v19 = math.ceil(Magnitude * 0.25);
            local v20 = u1:NextNumber(0.05, 0.2) * 4;
            local v21 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                Color = v18,
                Curves = v17,
                Speed = v15,
                Length = v16,
                A1 = Attachment,
                A2 = u7,
                Size = v20,
                PartCount = v19
            });
            v21.Frequency = math.random(3, 10);
            v21.MinRadius = 0.8;
            v21.MaxRadius = v12;
            v21.AnimationSpeed = v14;
            v21.MinThicknessMultiplier = 0.95;
            v21.MaxThicknessMultiplier = 1;
        end);
        EffectsHandler.Wait(0.04);
    end;

    ParticleHandler.EnableAllParticles(v8, false);
    ParticleHandler.DestroyEmit(v8);
    ParticleHandler.EnableAllParticles(v9, false);
    ParticleHandler.DestroyEmit(v9);
    ParticleHandler.EnableAllParticles(v6, false);
    ParticleHandler.DestroyEmit(v6);
end;