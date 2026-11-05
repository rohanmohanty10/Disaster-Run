  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);
local u2 = Random.new();

return function(p3) -- Line: 17
    -- upvalues: AssetHandler (copy), u1 (ref), ParticleHandler (copy), TweenService (copy), u2 (copy)
    local v4 = p3 or {};
    local Character = v4.Character;
    local Duration = v4.Duration;
    local v5 = AssetHandler.GetAbilityData(Character);
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1.CallEffect("Mesh Emit", {
        Effect = "Rokugan Release",
        Origin = HumanoidRootPart.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
    });
    local Model = Instance.new("Model");
    Model.Name = `{Character.Name}'s Rokugan`;
    Model.Parent = workspace.Effects;
    local u6 = AssetHandler.CloneAsset("Particles/Rokugan/Rokugan", v5);
    ParticleHandler.Unusualify(u6, {
        Character = Character
    });
    u6.CFrame = HumanoidRootPart.CFrame;
    u6.Parent = Model;
    local v7 = u6:FindFirstChildOfClass("Weld") or u6:FindFirstChildOfClass("ManualWeld");

    if v7 then
        local C1 = v7.C1;
        v7.C1 = CFrame.identity;
        local v8 = TweenService:Create(v7, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            C1 = C1
        });
        v8:Play();
        v8.Completed:Connect(function() -- Line: 57
        end);
    end;

    ParticleHandler.EnableAllParticles(u6, true);
    u1.CallEffect("FadeBeams", u6, {
        FadeIn = true
    });
    task.spawn(function() -- Line: 69
        -- upvalues: u6 (copy), Duration (copy), u2 (ref), Model (copy), HumanoidRootPart (copy), u1 (ref)
        local v9 = os.clock();
        local v10 = false;

        while u6:IsDescendantOf(game) and os.clock() - v9 <= Duration do
            local v11 = u2:NextNumber(0.15, 0.22);

            if v10 then
                v11 = v11 * -0.3;
            end;

            Model:ScaleTo(1 + v11);
            u6.CFrame = HumanoidRootPart.CFrame;
            u1.Wait(0.05);
            v10 = not v10;
        end;
    end);
    task.delay(Duration, function() -- Line: 87
        -- upvalues: u6 (copy), ParticleHandler (ref), u1 (ref), Character (copy), HumanoidRootPart (copy), Model (copy), AssetHandler (ref), TweenService (ref)
        task.delay(4, u6.Destroy, u6);
        ParticleHandler.EnableParticles(u6, false);
        u1.CallEffect("FadeBeams", u6, {
            Time = 0.1875
        });
        u1.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Path = "Particles/Rokugan/Appear",
            Scale = 0.4,
            Character = Character,
            Origin = HumanoidRootPart
        });
        u1.CallEffect("Mesh Emit", {
            Effect = "Rokugan Release",
            Origin = HumanoidRootPart.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
        });
        Model:ScaleTo(1);
        AssetHandler.ScaleAsset(u6, {
            Scale = 4,
            TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        });
        TweenService:Create(u6, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, 10)
        }):Play();

        for i = 0, 29 do
            local v12 = i / 29;
            local v13 = HumanoidRootPart.CFrame:Lerp(HumanoidRootPart.CFrame * CFrame.new(0, 0, -47), v12);
            u1.CallEffect("Rock Trail", {
                Distance = 1.6206896551724137,
                Amount = 1,
                Duration = 2.5,
                Down = true,
                Origin = v13,
                LookVector = HumanoidRootPart.CFrame.LookVector,
                Offset = math.lerp(2.3, 12, v12),
                Size = math.lerp(0.5, 8, v12),
                DurationOffset = i * 0.05
            });
        end;
    end);
    u1.CallEffect("Mesh Emit", {
        Effect = "Rokugan Meshes",
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, 0, -25),
        Extra = Duration
    });
end;