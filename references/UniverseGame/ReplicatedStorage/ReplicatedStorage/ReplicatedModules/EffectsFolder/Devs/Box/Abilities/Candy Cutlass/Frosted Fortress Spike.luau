  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    local Character = p1.Character;
    local Origin = p1.Origin;

    if Origin and typeof(Origin) ~= "CFrame" then
        return;
    end;

    local u2 = {
        AbilityName = "Candy Cutlass",
        SkinName = AssetHandler.GetAbilityData(Character).SkinName
    };
    local u3 = AssetHandler.CloneAsset("Particles/FrostedFortress/Spike", u2);
    u3.Root.CFrame = Origin * CFrame.new(0, -10, 0);
    u3.Parent = workspace.Effects;
    TweenService:Create(u3.Root, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        CFrame = u3.Root.CFrame * CFrame.new(0, 13.75, 0)
    }):Play();
    EffectsHandler.CallEffect("Emit Particle V3", {
        AutoSerialize = true,
        Origin = Origin,
        Particle = AssetHandler.GetAsset("Particles/FrostedFortress/SpikesSummon", u2)
    });
    task.delay(1, function(p4) -- Line: 31
        -- upvalues: TweenService (ref), u3 (copy), EffectsHandler (ref), Origin (copy), AssetHandler (ref), u2 (ref)
        TweenService:Create(u3.Root, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
            CFrame = u3.Root.CFrame * CFrame.new(0, -13.75, 0)
        }):Play();
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Origin = Origin,
            Particle = AssetHandler.GetAsset("Particles/FrostedFortress/SpikesSummon", u2)
        });
        task.delay(1, u3.Destroy, u3);
    end);
end;