  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(u1) -- Line: 6
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local TargetCharacter = u1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local v2 = AssetHandler.GetAsset(u1.Name .. "/Iceman", {
        AbilityName = "KillEffects"
    });
    local v3 = next;
    local v4, v5 = v2:GetChildren();

    for _, v in v3, v4, v5 do
        if v:IsA("Part") or TargetCharacter:FindFirstChild(v.Name) then
            local v6 = v:Clone();
            v6.Parent = TargetCharacter:FindFirstChild(v6.Name);
            ParticleHandler.AttachTo(v6, {
                Part = TargetCharacter:FindFirstChild(v6.Name)
            });
        end;
    end;

    task.delay(0.65, function(p7) -- Line: 24
        -- upvalues: EffectsHandler (ref), HumanoidRootPart (copy), u1 (copy), AssetHandler (ref), TargetCharacter (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Scale = 1.2,
            AbilityName = "KillEffects",
            Origin = HumanoidRootPart,
            Offset = CFrame.new(0, -2.8, 0),
            Path = u1.Name .. "/Frostbite"
        });
        task.spawn(EffectsHandler.CallEffect, "Play Sound At", {
            Object = AssetHandler.GetAsset(u1.Name .. "/KillEffectSound", {
                AbilityName = "KillEffects"
            }),
            Origin = CFrame.new(HumanoidRootPart.Position)
        });
        EffectsHandler.CallEffect("SK_VANISH", {
            AffectStands = true,
            Transparency = 1,
            Character = TargetCharacter,
            TweenInfo = { 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut }
        });
    end);
end;