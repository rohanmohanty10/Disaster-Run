  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local ClientAssets = PathShortcuts.ClientAssets;

return function(p1, p2) -- Line: 11
    -- upvalues: ParticleHandler (copy), ClientAssets (copy), TweenService (copy), EffectsHandler (copy)
    if not p1 then
        return;
    end;

    local v3 = p2 or 1;
    local HumanoidRootPart = p1.HumanoidRootPart;
    local Model = Instance.new("Model");
    Model.Name = "Kuro Triple Slash";
    Model.Parent = workspace.Effects;
    task.delay(0.25 / v3, function() -- Line: 23
        -- upvalues: ParticleHandler (ref), Model (copy)
        task.delay(ParticleHandler.EnableParticles(Model, false) or 1, Model.Destroy, Model);
    end);

    for i = 1, 3 do
        local v4 = HumanoidRootPart.CFrame * CFrame.new(i * 5 + -10, 0, 0);
        local v5 = ClientAssets.Kuro.Slash:Clone();
        v5.CFrame = v4 * CFrame.new(0, 1, 0) * CFrame.Angles(3.141592653589793, 0, 1.5707963267948966);
        v5.Parent = Model;
        local v6 = ClientAssets.Kuro.GroundImpact:Clone();
        v6.CFrame = v4 * CFrame.new(0, -4, -10);
        v6.Parent = Model;
        TweenService:Create(v5, TweenInfo.new(0.25 / v3, Enum.EasingStyle.Linear), {
            CFrame = v5.CFrame * CFrame.Angles(0, -3.141592653589793, 0)
        }):Play();
        EffectsHandler.CallEffect("Emit Particle V3", {
            Origin = v6.CFrame * CFrame.new(0, 0.8, 0),
            Particle = ClientAssets.Kuro.Strike
        });
        ParticleHandler.Emit(v6.B, ParticleHandler.GenerateEmitInfo(v6.B));
        ParticleHandler.EnableParticles(v6.A, true);
        EffectsHandler.CallEffect("FadeBeams", v5);
    end;
end;