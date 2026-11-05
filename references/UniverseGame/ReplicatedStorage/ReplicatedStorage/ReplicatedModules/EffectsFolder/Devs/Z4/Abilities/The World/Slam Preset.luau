  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1, p2, p3, p4) -- Line: 10
    -- upvalues: TableUtil (copy), EffectsHandler (copy)
    local v5 = {
        FlyingDebris = true,
        Particle = "Universal/Combat/Particles/Slam"
    };

    if p4 then
        v5 = TableUtil.Reconcile(p4, v5) or v5;
    end;

    EffectsHandler.CallEffect("Q_RADIAL", {
        Distance = 40,
        Origin = p1,
        Effect = { {
                Effect = "Camera Shake",
                Arguments = { { 5, 12.5, 0, 0.35, Vector3.new(0.25, 0.25, 0.25), Vector3.new(3, 2, 1) } }
            } }
    });

    if not v5.FlyingDebris then
        EffectsHandler.CallEffect("Flying Debris", {
            Lifetime = 2.5,
            Collision = true,
            Size = 1.5,
            Force = Vector3.new(32, 44.8, 32),
            TweenDelay = 0.9,
            Origin = p1,
            Tween = {
                Transparency = 1,
                Size = Vector3.new(0, 0, 0)
            }
        });
    end;

    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 2.5,
        Amount = 15,
        Origin = p1,
        Radius = p2 or 11
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        RawPath = true,
        Path = "Universal/Combat/Particles/Slam",
        AutoSerialize = true,
        Origin = p1 * CFrame.new(0, -3, 0),
        Scale = p3 or 0.6
    });
end;