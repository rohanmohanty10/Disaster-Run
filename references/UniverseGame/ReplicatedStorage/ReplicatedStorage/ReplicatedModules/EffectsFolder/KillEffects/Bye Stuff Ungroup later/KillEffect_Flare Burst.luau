  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Emit Particle V3", {
        AbilityName = "KillEffects",
        Path = "Flare Burst/Explosion",
        Origin = CFrame2
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });

    for _ = 1, 8 do
        local u2 = AssetHandler.CloneAsset("Flare Burst/Flare", {
            AbilityName = "KillEffects"
        });
        local Angles = CFrame.Angles;
        local v3 = math.random(-360, 360);
        local v4 = math.rad(v3);
        local v5 = math.random(-360, 360);
        local v6 = math.rad(v5);
        local v7 = math.random(-360, 360);
        u2.CFrame = CFrame2 * Angles(v4, v6, (math.rad(v7)));
        u2.CanCollide = false;
        u2.CanTouch = true;
        u2.Massless = true;
        u2.Anchored = false;
        u2.Parent = workspace.Effects;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(10000000, 1000, 100000);
        local v8 = u2.CFrame.LookVector * Vector3.new(1, 0.35, 1) * math.random(35, 50);
        local v9 = math.random(0, 25);
        BodyVelocity.Velocity = v8 + Vector3.new(0, v9, 0);
        BodyVelocity.Parent = u2;
        task.delay(0.12, BodyVelocity.Destroy, BodyVelocity);
        local u10 = nil;
        u10 = u2.Touched:Connect(function(p11) -- Line: 44
            -- upvalues: u10 (ref), ParticleHandler (ref), u2 (copy), TweenService (ref)
            if p11:IsDescendantOf(workspace.Map) then
                u10:Disconnect();
                u10 = nil;
                ParticleHandler.DestroyEmit(u2);
                ParticleHandler.EnableAllParticles(u2, false);
                TweenService:Create(u2, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end);
    end;

    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
end;