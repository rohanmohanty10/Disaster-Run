  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), EffectsHandler (copy), ParticleHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local u2 = ReplicatedStorage["Client Assets"].Universal.Meteor:Clone();
    u2.CFrame = CFrame.new((CFrame.new(HumanoidRootPart.Position) * CFrame.new(math.random(-150, 150), 400, math.random(-150, 150))).Position, HumanoidRootPart.Position);
    u2.Parent = workspace.Effects;
    u2.Burn:Play();
    local v3 = TweenService:Create(u2, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        CFrame = u2.CFrame * CFrame.new(0, 0, -(HumanoidRootPart.Position - u2.Position).Magnitude)
    });
    v3:Play();
    v3.Completed:Connect(function() -- Line: 24
        -- upvalues: u2 (copy), EffectsHandler (ref), HumanoidRootPart (copy), ReplicatedStorage (ref)
        u2.FallingDownVFX:Destroy();
        EffectsHandler.CallEffect("Rock Debris", {
            Size = Vector3.new(2.85, 2.85, 2.85),
            Lifetime = 4,
            Radius = 7.5,
            Amount = 8,
            Origin = HumanoidRootPart.CFrame
        });
        EffectsHandler.CallEffect("Emit Particle V3", {
            MaxRenderDistance = 1000000,
            Origin = CFrame.new(u2.Position - Vector3.new(0, u2.Size.Y / 2, 0)),
            Particle = ReplicatedStorage["Client Assets"].Universal.MeteorImpact
        });
        u2.Crash:Play();
        local v4 = u2;
        local CFrame2 = v4.CFrame;
        local Angles = CFrame.Angles;
        local v5 = math.random(-360, 360);
        local v6 = math.rad(v5);
        local v7 = math.random(-360, 360);
        local v8 = math.rad(v7);
        local v9 = math.random(-360, 360);
        v4.CFrame = CFrame2 * Angles(v6, v8, (math.rad(v9)));
    end);
    task.delay(4, function() -- Line: 48
        -- upvalues: TweenService (ref), u2 (copy), ParticleHandler (ref)
        TweenService:Create(u2, TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = u2.Size / 4,
            CFrame = u2.CFrame:ToWorldSpace(CFrame.new(0, -u2.Size.Y / 4, 0))
        }):Play();
        ParticleHandler.EnableParticles(u2, false);
        TweenService:Create(u2.Burn, TweenInfo.new(3, Enum.EasingStyle.Linear), {
            Volume = 0
        }):Play();
        task.delay(3, u2.Destroy, u2);
    end);
end;