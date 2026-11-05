  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 7
    -- upvalues: Players (copy), ReplicatedStorage (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local v3 = v2.Player or Players:GetPlayerFromCharacter(Character);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v4 = v2.Origin or HumanoidRootPart.CFrame;
    local v5 = v2.Offset or CFrame.identity;
    local v6 = v2.Radius or 8;
    local v7 = v2.Path or "Universal/Combat/Particles/Slam";
    local AbilityName = v2.AbilityName;
    local _ = v2.SkinName;
    local v8 = v2.Disable or {};
    local DebrisSize = v2.DebrisSize;
    local Lifetime = v2.Lifetime;
    local v9 = v2.ShakePreset or "Explosion";

    if typeof(v4) == "Vector3" then
        v4 = CFrame.new(v4);
    elseif typeof(v4) == "Instance" then
        v4 = v4.CFrame;
    end;

    if typeof(v5) == "Vector3" then
        v5 = CFrame.new(v5);
    end;

    local v10 = v4 * v5;
    local v11 = {};

    if not v8.CameraShake then
        table.insert(v11, {
            Name = "Q_RADIAL",
            Data = {
                {
                    Origin = v10,
                    Distance = v6 * 2,
                    Effect = {
                        {
                            Effect = "Camera Shake Preset",
                            Arguments = { v9 }
                        }
                    }
                }
            }
        });
    end;

    if not v8.Emit then
        local v12 = {
            Name = "Emit Particle V3",
            Data = {
                {
                    AutoSerialize = true,
                    Origin = v10 * CFrame.new(0, -3 + (v2.Additive or 0), 0),
                    Path = v7,
                    Player = v3,
                    Scale = v6 / 18,
                    RawPath = not (AbilityName and v2.Path)
                }
            }
        };
        table.insert(v11, v12);
    end;

    if not v8.FlyingDebris then
        local v13 = {
            Name = "DS_DEBRIS",
            Data = {
                {
                    Trail = v2.DebrisTrail or ReplicatedStorage["Client Assets"].Assets.Universal.Combat.Particles.RockTrail,
                    Player = v3,
                    Character = Character,
                    Amount = math.random(3, 7),
                    UpVelocity = NumberRange.new(25, 45),
                    SideVelocity = NumberRange.new(-40, 40),
                    Origin = v10 * CFrame.new(0, -(v2.Additive or 0), 0)
                }
            }
        };
        table.insert(v11, v13);
    end;

    if not v8.GroundDebris then
        table.insert(v11, {
            Name = "Rock Debris",
            Data = {
                {
                    Origin = v10,
                    Lifetime = Lifetime or 2,
                    Radius = v6,
                    Amount = v6 * 2,
                    Size = DebrisSize or Vector3.new(2.3, 2.3, 2.3)
                }
            }
        });
    end;

    EffectsHandler.CallEffects(v11);
end;