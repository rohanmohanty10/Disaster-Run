  

 

local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 3
    -- upvalues: EffectsHandler (copy)
    local Object = p1.Object;
    local Player = p1.Player;
    local v2 = p1.Radius or 14;
    local v3 = p1.PlaySounds or true;

    if not (Object and Player) then
        return;
    end;

    local v4 = p1.Models or { Player.Character };
    local v5 = p1.Origin or Object.CFrame;
    local Asset = p1.Asset;
    local v6 = {
        Path = "Particles/Explosion",
        AutoSerialize = true,
        Origin = v5 * CFrame.new(0, -3.5, 0),
        PlaySounds = v3
    };

    if Asset then
        v6.Path = Asset.Name;
        v6.SkinName = Asset.SkinName;
        v6.AbilityName = Asset.AbilityName;
    else
        v6.AbilityName = "Dragon Knight";
        v6.SkinName = p1.SkinName;
        v6.Player = Player;
    end;

    EffectsHandler.CallEffect("Q_RADIAL", {
        Origin = v5,
        Distance = v2 + 15,
        Effect = {
            {
                Effect = "Impact Frame",
                Arguments = {
                    {
                        Time = 0.1,
                        Models = v4
                    }
                }
            },
            {
                Effect = "Camera Shake",
                Arguments = { { 6, 14, 0, 0.5, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1) } }
            }
        }
    });
    EffectsHandler.CallEffect("Emit Particle V3", v6);
    EffectsHandler.CallEffect("Flying Debris", {
        Lifetime = 4.5,
        Collision = true,
        Size = 3,
        Force = Vector3.new(32, 44.8, 32),
        TweenDelay = 0.9,
        Origin = v5,
        Tween = {
            Transparency = 1,
            Size = Vector3.new(0, 0, 0)
        }
    });
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 3.5,
        Amount = 22,
        Origin = v5 * CFrame.new(0, -2.5, 0),
        Radius = v2
    });
end;