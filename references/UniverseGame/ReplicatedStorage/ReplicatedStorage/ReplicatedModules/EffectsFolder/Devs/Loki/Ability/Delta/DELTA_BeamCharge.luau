  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);

return function(p1, p2) -- Line: 18
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local AbilityModel = p2.AbilityModel;

    if not AbilityModel then
        return;
    end;

    local DeltaControlBone = AbilityModel:FindFirstChild("DeltaControlBone", true);

    if not DeltaControlBone then
        return;
    end;

    local v3 = DeltaControlBone:FindFirstChild("DeltaArmBone.L"):FindFirstChild("DeltaTriangleBone.L.002", true);

    if not v3 then
        return;
    end;

    local v4 = AssetHandler.GetAbilityData(p1);
    local v5 = os.clock();
    local v6 = ParticleHandler.GetUnusualHSVData({
        Character = p1
    });
    EffectsHandler.CallEffects({
        {
            Name = "Enable Particles",
            Data = {
                {
                    Enabled = true,
                    ParentToAttach = true,
                    Scale = 1.25,
                    Parent = v3,
                    ReferencePart = AssetHandler.GetAsset("Particles/Tri-Phase Beam/Charge/Attach", v4),
                    Id = v5,
                    HSVShift = v6
                }
            }
        }
    });

    while p2.Ref and p2.Ref.Parent do
        task.wait(0.03333333333333333);
    end;

    EffectsHandler.CallEffects({
        {
            Name = "Enable Particles",
            Data = {
                {
                    Enabled = false,
                    Id = v5
                }
            }
        }
    });
end;