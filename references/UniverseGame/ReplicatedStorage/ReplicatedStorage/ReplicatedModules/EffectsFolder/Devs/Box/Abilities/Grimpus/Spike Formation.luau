  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    local Character = p1.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u2 = {
        AbilityName = "Grimpus"
    };

    for i = 1, 4 do
        local v3 = math.random(1, 2);
        local u4 = AssetHandler.CloneAsset("Models/Formation" .. v3, u2);
        local u5 = HumanoidRootPart.CFrame * CFrame.new(0, -15, i * -12.5);
        u4.CFrame = u5 * CFrame.Angles(0, 1.5707963267948966, 0);
        u4.Parent = workspace.Effects;
        TweenService:Create(u4, TweenInfo.new(0.15), {
            CFrame = u4.CFrame * CFrame.new(0, 15, 0)
        }):Play();
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Origin = u5 * CFrame.new(0, 15, 0),
            Particle = AssetHandler.GetAsset("Particles/SpikesSummon", u2)
        });
        EffectsHandler.CallEffect("Slam Effect", {
            Radius = 10,
            Character = Character,
            Origin = u5 * CFrame.new(0, 12.5, 0)
        });
        task.spawn(function() -- Line: 43
            -- upvalues: EffectsHandler (ref), AssetHandler (ref), u2 (copy), u5 (copy)
            EffectsHandler.CallEffect("Play Sound At", {
                Object = AssetHandler.GetAsset("Sounds/SpikeAppear", u2),
                Origin = u5 * CFrame.new(0, 15, 0)
            });
        end);
        task.delay(2, function() -- Line: 52
            -- upvalues: EffectsHandler (ref), u5 (copy), AssetHandler (ref), u2 (copy), TweenService (ref), u4 (copy)
            EffectsHandler.CallEffect("Emit Particle V3", {
                AutoSerialize = true,
                Origin = u5 * CFrame.new(0, 15, 0),
                Particle = AssetHandler.GetAsset("Particles/SpikesSummon", u2)
            });
            TweenService:Create(u4, TweenInfo.new(0.15), {
                CFrame = u4.CFrame * CFrame.new(0, -20, 0)
            }):Play();
            task.delay(0.25, u4.Destroy, u4);
        end);
        task.wait(0.05);
    end;
end;