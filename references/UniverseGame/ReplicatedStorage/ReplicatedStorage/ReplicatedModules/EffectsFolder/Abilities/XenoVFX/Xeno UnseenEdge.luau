  

 

local _ = game.ReplicatedStorage["Client Assets"];
game:GetService("TweenService");
local wait = task.wait;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4) -- Line: 14
    -- upvalues: AssetHandler (copy), u1 (copy), wait (copy)
    if not (p2 and p2:IsDescendantOf(workspace)) then
        return;
    end;

    AssetHandler.GetAsset("ShadowOrb", p4);
    local v5 = AssetHandler.GetAsset("ShadowOrbExplode", p4);
    local v6 = Random.new();

    for _ = 1, p3 do
        local v7 = CFrame.new(v6:NextNumber(-2, 2), v6:NextNumber(-2, 2), v6:NextNumber(-2, 2));
        u1({
            Origin = p2.CFrame * v7,
            Particle = v5
        });
        wait(0.16666666666666666);
    end;
end;