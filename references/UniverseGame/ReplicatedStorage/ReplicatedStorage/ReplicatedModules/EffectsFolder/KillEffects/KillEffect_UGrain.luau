  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(p2) -- Line: 10
    -- upvalues: AssetHandler (copy), u1 (copy), EffectsHandler (copy), TweenService (copy)
    local TargetCharacter = p2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local CFrame2 = TargetCharacter:FindFirstChild("HumanoidRootPart").CFrame;
    local u3 = AssetHandler.CloneAsset("A-Train/Model", {
        AbilityName = "KillEffects"
    });
    local PrimaryPart = u3.PrimaryPart;
    local new = CFrame.new;
    local Position = CFrame2.Position;
    local v4 = u1:NextNumber(15, 20) * (math.random(1, 2) == 1 and -1 or 1);
    local v5 = u1:NextNumber(15, 20);
    local v6 = math.random(1, 2) == 1 and -1 or 1;
    PrimaryPart.CFrame = new(Position + Vector3.new(v4, 0, v5 * v6), CFrame2.Position);
    u3.Parent = workspace.Effects;
    u3.Humanoid.Animator:LoadAnimation(AssetHandler.GetAsset("A-Train/Animation", {
        AbilityName = "KillEffects"
    })):Play(0);
    local PrimaryPart2 = u3.PrimaryPart;
    PrimaryPart2.Voiceline:Play();
    task.delay(0.31666666666666665, function() -- Line: 26
        -- upvalues: PrimaryPart2 (copy), EffectsHandler (ref), AssetHandler (ref), TweenService (ref), u3 (copy), CFrame2 (copy), TargetCharacter (copy)
        PrimaryPart2.SFX:Play();
        task.delay(0.3333333333333333, PrimaryPart2.AfterVoiceline.Play, PrimaryPart2.AfterVoiceline);
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Pull",
            AbilityName = "UGrain Dev",
            AutoSerialize = true,
            Origin = PrimaryPart2.CFrame * CFrame.new(0, 3.25, -11.5) * CFrame.Angles(0, 3.141592653589793, 0)
        });
        EffectsHandler.CallEffect("Kars_Coil", {
            Amount = 3,
            Height = 2,
            Radius = 20,
            Duration = 0.4,
            Origin = PrimaryPart2.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0),
            Degree = Vector2.new(5, 7.25),
            Trail = AssetHandler.GetAsset("Particles/CoilTrail", {
                AbilityName = "UGrain Dev"
            })
        });
        local v7 = PrimaryPart2.Position + PrimaryPart2.CFrame.LookVector * 40;
        TweenService:Create(PrimaryPart2, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            CFrame = PrimaryPart2.CFrame * CFrame.new(0, 0, -40)
        }):Play();
        EffectsHandler.CallEffect("Rock Trail", {
            Offset = 8,
            Size = 2,
            Duration = 1,
            DurationOffset = 0.1,
            Down = true,
            Origin = PrimaryPart2.CFrame,
            LookVector = (v7 - PrimaryPart2.Position).Unit,
            Distance = (v7 - PrimaryPart2.Position).Magnitude,
            Amount = math.ceil((v7 - PrimaryPart2.Position).Magnitude / 2.35)
        });
        task.spawn(EffectsHandler.CallEffect, "MIH_AFTERIMAGES", u3, true, {
            Distance = false,
            Time = 0.025,
            Transparency = 0.5
        });
        task.delay(0.2, EffectsHandler.CallEffect, "MIH_AFTERIMAGES", u3, false);
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Lunge",
            AbilityName = "UGrain Dev",
            AutoSerialize = true,
            Origin = PrimaryPart2.CFrame
        });
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Release",
            AbilityName = "UGrain Dev",
            AutoSerialize = true,
            Origin = PrimaryPart2.CFrame
        });
        EffectsHandler.CallEffect("A-Train Dash", {
            Character = u3,
            Start = PrimaryPart2.CFrame,
            End = CFrame.new(v7, v7 + PrimaryPart2.CFrame.LookVector)
        });
        EffectsHandler.CallEffect("SK_VANISH", {
            Transparency = 1,
            Character = u3,
            TweenInfo = { 1 }
        });
        task.delay(1, u3.Destroy, u3);
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/BloodBurst",
            AbilityName = "UGrain Dev",
            AutoSerialize = true,
            PlaySounds = true,
            Origin = CFrame2
        });
        EffectsHandler.CallEffect("Blood Rays", {
            SpeedScale = 1.85,
            Origin = CFrame2,
            TrailRange = NumberRange.new(15, 20)
        });

        for _, child in TargetCharacter:GetChildren() do
            if child:IsA("BasePart") then
                child.CFrame = child.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(10000000, 1000, 100000);
                BodyVelocity.Velocity = child.CFrame.LookVector * math.random(20, 30);
                BodyVelocity.Parent = child;
                task.delay(math.random(25, 42) / 100, BodyVelocity.Destroy, BodyVelocity);
                child.CollisionGroup = "Ghosted";
                child.CanCollide = true;
                TweenService:Create(child, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 5), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();

                for _, child2 in AssetHandler.GetAsset("Particles/LimbBlood", {
                    AbilityName = "UGrain Dev"
                }):GetChildren() do
                    child2:Clone().Parent = child;
                end;

                task.delay(5, function() -- Line: 138
                    -- upvalues: child (copy)
                    for _, descendant in child:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                            descendant.Enabled = false;
                        end;
                    end;
                end);
            end;
        end;
    end);
end;