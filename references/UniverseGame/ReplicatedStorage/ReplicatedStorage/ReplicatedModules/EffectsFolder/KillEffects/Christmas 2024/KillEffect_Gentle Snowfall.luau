  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 7
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local v2 = HumanoidRootPart.Size.Y / 2;
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Gentle Snowfall/GlowGround",
        AbilityName = "KillEffects",
        EnableDuration = 3,
        Origin = HumanoidRootPart,
        Offset = CFrame.new(0, -TargetCharacter:GetExtentsSize().Y / 2 + 0.15, 0)
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Gentle Snowfall/FallingParticles",
        AbilityName = "KillEffects",
        EnableDuration = 3,
        Origin = HumanoidRootPart,
        Offset = CFrame.new(0, TargetCharacter:GetExtentsSize().Y * 2.5, 0)
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(p1.Name .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v3 = { "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" };
    local v4 = AssetHandler.GetAsset(p1.Name .. "/Dissolve", {
        AbilityName = "KillEffects"
    });

    for i = 1, #v3 do
        local v5 = TargetCharacter:FindFirstChild(v3[i]);

        if v5 then
            for _, child in v4:GetChildren() do
                local u6 = Instance.fromExisting(child);

                if v2 ~= 1 then
                    ParticleHandler.ScaleParticle(u6, v2);
                end;

                u6.Parent = v5;
                u6.Enabled = true;
                task.delay(0.9, function() -- Line: 56
                    -- upvalues: u6 (copy)
                    u6.Enabled = false;
                end);
            end;
        end;
    end;

    task.spawn(function() -- Line: 62
        -- upvalues: TargetCharacter (copy)
        local v7 = next;
        local v8, v9 = TargetCharacter:GetDescendants();

        for _, v in v7, v8, v9 do
            if v:IsA("Part") or (v:IsA("Decal") or v:IsA("Texture")) then
                game.TweenService:Create(v, TweenInfo.new(2.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
end;