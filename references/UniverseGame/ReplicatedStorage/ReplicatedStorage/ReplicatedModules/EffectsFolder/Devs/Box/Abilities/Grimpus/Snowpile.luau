  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), TweenService (copy)
    local HumanoidRootPart = p1.Character.HumanoidRootPart;
    local u2 = AssetHandler.CloneAsset("Particles/WintryBlizzard/Snowpile", {
        AbilityName = "Grimpus"
    });
    u2.Size = Vector3.new();
    u2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3.6, 0);
    u2.Parent = workspace.Effects;
    TweenService:Create(u2, TweenInfo.new(0.25), {
        Size = Vector3.new(154, 3.3, 154)
    }):Play();
    task.delay(4.32, function() -- Line: 24
        -- upvalues: TweenService (ref), u2 (copy)
        TweenService:Create(u2, TweenInfo.new(0.25), {
            Transparency = 1
        }):Play();
        task.delay(0.3, u2.Destroy, u2);
    end);
end;