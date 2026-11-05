  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 5
    -- upvalues: EffectsHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local v2 = EffectsHandler.GetEffect("EXPLOSION_DEATH_EFFECT");
    local v3 = EffectsHandler.GetEffect("KQ_PrimaryBombExplosion");

    if v2 and v3 then
        v3(TargetCharacter.HumanoidRootPart, 0, {
            SkinName = nil,
            AbilityName = nil
        });
        v2(TargetCharacter);
    end;
end;