  

 

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

return function(p1, p2) -- Line: 19
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local AbilityModel = p2.AbilityModel;

    if not AbilityModel then
        return;
    end;

    local DeltaControlBone = AbilityModel:FindFirstChild("DeltaControlBone", true);

    if not DeltaControlBone then
        return;
    end;

    local v3;

    if p2.Side == "Left" then
        v3 = "L";
    else
        local _ = p2.Side == "Right";
        v3 = "R";
    end;

    local v4 = DeltaControlBone:FindFirstChild((`DeltaArmBone.{v3}`)):FindFirstChild(`DeltaTriangleBone.{v3}.002`, true);

    if not v4 then
        return;
    end;

    local v5 = AssetHandler.GetAbilityData(p1);
    local v6 = os.clock();
    local v7 = ParticleHandler.GetUnusualHSVData({
        Character = p1
    });
    EffectsHandler.CallEffects({
        {
            Name = "Enable Particles",
            Data = {
                {
                    Enabled = true,
                    ParentToAttach = true,
                    Scale = 1,
                    Parent = v4,
                    ReferencePart = AssetHandler.GetAsset("Particles/LMB/Saw/Attach", v5),
                    Id = v6,
                    HSVShift = v7
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
                    Id = v6
                }
            }
        }
    });
end;