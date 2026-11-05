  

 

local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 3
    -- upvalues: EffectsHandler (copy)
    local Object = p1.Object;
    local Player = p1.Player;
    local v2 = p1.Radius or 15;

    if not (Object and Player) then
        return;
    end;

    local v3 = p1.Origin or Object.CFrame;
    EffectsHandler.CallEffect("Q_RADIAL", {
        Distance = 35,
        Effect = "Camera Shake",
        Origin = v3,
        Arguments = { { 6, 15, 0, 0.5, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1) } }
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Slam",
        AutoSerialize = true,
        AbilityName = "Dragon Knight",
        Origin = v3,
        Player = Player,
        SkinName = p1.SkinName
    });
    EffectsHandler.CallEffect("Flying Debris", {
        Lifetime = 4.5,
        Collision = true,
        Size = 2.5,
        Force = Vector3.new(32, 44.8, 32),
        TweenDelay = 0.9,
        Origin = v3,
        Tween = {
            Transparency = 1,
            Size = Vector3.new(0, 0, 0)
        }
    });
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 3.5,
        Amount = 22,
        Origin = v3 * CFrame.new(0, -2.5, 0),
        Radius = v2
    });
end;