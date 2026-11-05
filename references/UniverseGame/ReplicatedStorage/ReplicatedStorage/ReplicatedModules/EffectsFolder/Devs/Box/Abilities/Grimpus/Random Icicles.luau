  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), TweenService (copy)
    local HumanoidRootPart = p1.Character.HumanoidRootPart;
    local u2 = {
        AbilityName = "Grimpus"
    };
    local u3 = AssetHandler.CloneAsset("Models/Spike" .. math.random(1, 3), u2);
    u3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -15, 0);
    u3.Parent = workspace.Effects;
    EffectsHandler.CallEffect("Emit Particle V3", {
        AutoSerialize = true,
        Origin = HumanoidRootPart.CFrame,
        Particle = AssetHandler.GetAsset("Particles/SpikesSummon", u2)
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset("Sounds/IcicleAppear", u2),
        Origin = HumanoidRootPart.CFrame
    });
    TweenService:Create(u3, TweenInfo.new(0.25), {
        CFrame = u3.CFrame * CFrame.new(0, 17.28, 0)
    }):Play();
    task.delay(1.5, function() -- Line: 33
        -- upvalues: EffectsHandler (ref), u3 (copy), AssetHandler (ref), u2 (copy), TweenService (ref)
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Origin = u3.CFrame,
            Particle = AssetHandler.GetAsset("Particles/SpikesSummon", u2)
        });
        TweenService:Create(u3, TweenInfo.new(0.25), {
            CFrame = u3.CFrame * CFrame.new(0, -17.28, 0)
        }):Play();
        task.delay(0.35, u3.Destroy, u3);
    end);
end;