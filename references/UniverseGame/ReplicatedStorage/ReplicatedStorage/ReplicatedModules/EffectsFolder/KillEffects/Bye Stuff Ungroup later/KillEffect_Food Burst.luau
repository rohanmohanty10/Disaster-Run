  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.Wait(0.2);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Food Burst/Burst",
        AbilityName = "KillEffects",
        Origin = CFrame2
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v3 = AssetHandler.GetAsset("Food Burst/Foods", {
        AbilityName = "KillEffects"
    }):GetChildren();

    for _ = 1, 12 do
        local u4 = v3[math.random(1, #v3)]:Clone();
        local Angles = CFrame.Angles;
        local v5 = math.random(-360, 360);
        local v6 = math.rad(v5);
        local v7 = math.random(-360, 360);
        local v8 = math.rad(v7);
        local v9 = math.random(-360, 360);
        u4.CFrame = CFrame2 * Angles(v6, v8, (math.rad(v9)));
        u4.CanCollide = true;
        u4.Massless = true;
        u4.Anchored = false;
        u4.CollisionGroup = "Ghosted";
        u4.Parent = workspace.Effects;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(10000000, 10000, 100000);
        local v10 = u4.CFrame.LookVector * math.random(20, 30);
        local v11 = math.random(0, 20);
        BodyVelocity.Velocity = v10 + Vector3.new(0, v11, 0);
        BodyVelocity.Parent = u4;
        task.delay(0.12, BodyVelocity.Destroy, BodyVelocity);
        local v12 = TweenService:Create(u4, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 2.5), {
            Transparency = 1
        });
        v12:Play();
        v12.Completed:Connect(function() -- Line: 57
            -- upvalues: u4 (copy)
            u4:Destroy();
        end);
    end;

    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
end;