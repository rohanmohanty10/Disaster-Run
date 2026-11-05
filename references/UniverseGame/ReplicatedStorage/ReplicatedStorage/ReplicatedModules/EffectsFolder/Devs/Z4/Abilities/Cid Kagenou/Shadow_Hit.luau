  

 

require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 3
    -- upvalues: EffectsHandler (copy)
    local v2 = p1 or {};
    local Target = v2.Target;

    if not Target then
        return;
    end;

    if not Target:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    if not v2.BypassIgnore then
        v2.HueShift = nil;
        v2.HSVShift = nil;
        v2.HSVData = nil;
    end;

    task.spawn(EffectsHandler.CallEffect, "HitEffect V3", v2);

    if math.random(1, 4) ~= 4 then
        return;
    end;

    task.spawn(EffectsHandler.CallEffect, "Blood Rays", {
        Part = Target.Torso,
        TrailRange = NumberRange.new(1, 3)
    });
end;