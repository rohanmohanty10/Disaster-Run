  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
ReplicatedStorage:FindFirstChild("ReplicatedModules");
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(u1) -- Line: 10
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), RunService (copy)
    local TargetCharacter = u1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local u2 = TargetCharacter:FindFirstChild("Torso") or TargetCharacter:FindFirstChild("HumanoidRootPart");

    if not u2 then
        return;
    end;

    local u3 = AssetHandler.CloneAsset(u1.Name .. "/BatsRotate", {
        AbilityName = "KillEffects"
    });
    local u4 = 5;
    local u5 = 3;
    local u6 = 0;
    local u7 = 0;

    local function ToRevolutions(p8) -- Line: 29
        return 6.283185307179586 / p8;
    end;

    local function Quadratic(p9) -- Line: 33
        return p9 ^ 2;
    end;

    local function QuadLerp(p10, p11, p12) -- Line: 37
        return p10 + (p11 - p10) * p12 ^ 2;
    end;

    u3.Parent = workspace.Effects;
    local Position = u2.Position;
    local v13 = math.rad(u6);
    local v14 = math.cos(v13) * u4;
    local v15 = math.rad(u6);
    local v16 = math.sin(v15) * u4;
    u3.Position = Position + Vector3.new(v14, 0, v16);
    ParticleHandler.EnableAllParticles(u3, true);
    ParticleHandler.EnableAllParticles(TargetCharacter, false);

    local function OnEnd() -- Line: 47
        -- upvalues: ParticleHandler (ref), u3 (copy), EffectsHandler (ref), u2 (copy), u1 (copy)
        ParticleHandler.EnableAllParticles(u3, false);
        EffectsHandler.CallEffect("Emit Particle V3", {
            AbilityName = "KillEffects",
            Origin = u2,
            Offset = CFrame.new(0, 0, 0),
            Path = u1.Name .. "/BatSwarm"
        });
        task.delay(2, function() -- Line: 56
            -- upvalues: u3 (ref)
            u3:Destroy();
        end);
    end;

    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(u1.Name .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(u2.Position)
    });
    task.delay(0.15, EffectsHandler.CallEffect, "SK_VANISH", {
        AffectStands = true,
        Transparency = 1,
        Character = TargetCharacter,
        TweenInfo = { 2.075, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut }
    });
    local u17 = nil;
    u17 = RunService.Heartbeat:Connect(function(p18) -- Line: 74
        -- upvalues: TargetCharacter (copy), u2 (copy), u7 (ref), u17 (ref), OnEnd (copy), u6 (ref), u5 (ref), u4 (ref), u3 (copy)
        if not TargetCharacter.Parent or (not u2.Parent or u7 >= 2.25) then
            u17:Disconnect();
            OnEnd();
        end;

        u7 = u7 + p18;
        u6 = (u6 + 6.283185307179586 / u5 * p18 * 60) % 360;
        u4 = 5 + -4.85 * (u7 / 2.25) ^ 2;
        local v19 = 0.966643893412244;
        u5 = v19 + (0.5235987755982988 - v19) * (u7 / 2.25) ^ 2;
        local Position2 = u2.Position;
        local v20 = math.rad(u6);
        local v21 = math.cos(v20) * u4;
        local v22 = math.rad(u6);
        local v23 = math.sin(v22) * u4;
        u3.Position = Position2 + Vector3.new(v21, 0, v23);
    end);
end;