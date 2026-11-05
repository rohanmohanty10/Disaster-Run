  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Petal = _G.Petal;
Petal("New");
Petal("Util");
local u1 = Petal("Extensions");

return function(p2) -- Line: 12
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), u1 (copy), ParticleHandler (copy), RunService (copy)
    local TargetCharacter = p2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    EffectsHandler.CallEffect("Emit Particle V3", {
        AbilityName = "KillEffects",
        Origin = HumanoidRootPart,
        Offset = CFrame.new(0, -TargetCharacter:GetExtentsSize().Y / 2 + 0.2, 0),
        Path = p2.Name .. "/AuroraFrost"
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(p2.Name .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.delay(0.1, EffectsHandler.CallEffect, "SK_VANISH", {
        AffectStands = true,
        Transparency = 1,
        Character = TargetCharacter
    });

    for i = 1, 5 do
        local u3 = AssetHandler.CloneAsset(p2.Name .. "/AuroraTrail", {
            AbilityName = "KillEffects"
        });
        u3.Parent = workspace.Effects;
        local v4 = 1.2566370614359172 * i;
        local Position = HumanoidRootPart.Position;
        local v5 = math.cos(v4) * 2;
        local v6 = math.sin(v4) * 2;
        local Unit = (Position + Vector3.new(v5, 0, v6) - HumanoidRootPart.Position).Unit;
        local u7 = u1.Rng(0.7, 1.5);
        local u8 = 0;
        local u9 = u1.Rng(30, 40);
        task.defer(function() -- Line: 46
            -- upvalues: ParticleHandler (ref), u3 (copy)
            ParticleHandler.EnableAllParticles(u3, true);
        end);
        task.spawn(function() -- Line: 50
            -- upvalues: u8 (ref), u7 (copy), RunService (ref), i (copy), u3 (copy), HumanoidRootPart (copy), Unit (copy), u9 (copy), ParticleHandler (ref)
            while u8 < u7 do
                u8 = u8 + RunService.Heartbeat:Wait();
                local v10 = math.noise((os.clock() * 0.5 + i) * 2);
                local v11 = math.noise((os.clock() * 0.3 + i * 2) * 2);
                local v12 = math.noise((os.clock() * 0.5 - i) * 2);
                u3.Position = HumanoidRootPart.Position + Unit * u9 * (u8 / u7) + Vector3.new(v10 * 22, v11 * 6, v12 * 22);
            end;

            ParticleHandler.EnableParticles(u3, false);
            task.delay(0.5, function() -- Line: 63
                -- upvalues: ParticleHandler (ref), u3 (ref)
                ParticleHandler.EnableAllParticles(u3, false);
                task.delay(3, function() -- Line: 65
                    -- upvalues: u3 (ref)
                    u3:Destroy();
                end);
            end);
        end);
    end;
end;