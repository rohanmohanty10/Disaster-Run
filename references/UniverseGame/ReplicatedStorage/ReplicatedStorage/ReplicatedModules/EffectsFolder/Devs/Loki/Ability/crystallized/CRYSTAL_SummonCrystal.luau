  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local BoatTween = require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local u1 = Random.new();

local function RandomRange(p2) -- Line: 16
    -- upvalues: u1 (copy)
    return u1:NextNumber(-p2, p2);
end;

return function(u3) -- Line: 20
    -- upvalues: Trove (copy), BoatTween (copy), AssetHandler (copy), EffectsHandler (copy), ParticleHandler (copy), Fusion (copy), u1 (copy)
    local Origin = u3.Origin;
    local Radius = u3.Radius;
    local v4 = u3.Character or u3.Player;
    local v5 = u3.Amount or 13;
    local v6 = u3.Type or "Spike";
    local u7 = u3.CrystalScale or 1;
    local v8 = u3.DebrisScale or 1;
    local v9 = u3.RadiusScale or 1;
    local v10 = u3.CrystalOffset or CFrame.identity;
    local v11 = u3.UseCoil or false;
    local u12 = Trove.new();
    local u13 = u3.Lifetime or 2;

    local function Tween(p14, p15) -- Line: 36
        -- upvalues: u12 (copy), BoatTween (ref)
        u12:Add(BoatTween:Create(p14, p15)):Play();
    end;

    local v16 = u3.AbilityData or AssetHandler.GetAbilityData(v4);

    if v6 == "Spike" then
        EffectsHandler.CallEffect("Q_RADIAL", {
            Origin = Origin,
            Distance = Radius * 2,
            Effect = {
                {
                    Effect = "Camera Shake",
                    Arguments = { { 5.5, 13, 0, 0.5, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1) } }
                },
                {
                    Effect = "Vignette Gui",
                    Arguments = {
                        {
                            TweenTime = 0.1,
                            Blur = 8,
                            StartingColor = Color3.fromRGB(220, 220, 220),
                            EndingColor = Color3.fromRGB(220, 220, 220)
                        }
                    }
                }
            }
        });
        local v17 = AssetHandler.GetAsset("Particles/AxeReaver/Beam", v16);
        EffectsHandler.CallEffects({
            {
                Name = "Anubis_Slam",
                Data = {
                    {
                        Amount = 0,
                        Object = v17,
                        Origin = Origin * CFrame.new(0, 0.15 + v17.Size.Y / 2, 0),
                        Scale = u7,
                        Player = v4
                    }
                }
            },
            {
                Name = "CRYSTAL_Debris",
                Data = {
                    {
                        Origin = Origin,
                        Lifetime = u13 + 0.25,
                        Size = Vector3.new(2.35, 2.35, 2.35) * v8,
                        Radius = (Radius - 0.5) * v9,
                        Amount = v5
                    }
                }
            },
            {
                Name = "Emit Particle V3",
                Data = {
                    {
                        Path = "Particles/AxeReaver/Slam",
                        AutoSerialize = true,
                        Origin = Origin * CFrame.new(0, 2.5, 0),
                        Player = v4,
                        Scale = u7
                    }
                }
            },
            v11 and {
                Name = "Kars_Coil",
                Data = {
                    {
                        Amount = 3,
                        Enable = true,
                        Uniform = true,
                        Degree = 15,
                        Origin = Origin * v10,
                        Height = 1.5 * u7,
                        Radius = Radius / 2,
                        Duration = u13 / 10,
                        Trail = AssetHandler.GetAsset("Particles/Common/EnergyTrail", v16),
                        Player = v4
                    }
                }
            } or nil
        });
        local v18 = AssetHandler.GetAsset("Models/Crystals", v16):GetChildren();
        local u19 = u12:Clone(v18[math.random(1, #v18)]);
        task.delay(u13 * 2, function() -- Line: 146
            -- upvalues: u12 (copy)
            u12:Destroy();
        end);
        ParticleHandler.Unusualify(u19, {
            IncludeParts = true,
            Player = v4
        });
        u19.Size = u19.Size * u7;
        local u20 = Origin * v10;
        local v21 = Fusion.Value(20);
        local v22 = Fusion.Value(u20 * CFrame.new(0, -u19.ExtentsSize.Y / 2 - 2 * u7, 0));
        local v23 = Fusion.Spring(v22, v21, 0.6);
        Fusion.Hydrate(u19)({
            CFrame = v23,
            Parent = workspace.Effects
        });
        local v24 = v22:get();
        local Angles = CFrame.Angles;
        local v25 = u1:NextNumber(-4, 4);
        local v26 = math.rad(v25);
        local v27 = u1:NextNumber(-4, 4);
        local v28 = v24 * Angles(v26, 0, (math.rad(v27))) * CFrame.new(0, u19.ExtentsSize.Y - 1.5 * u7, 0);
        local Angles2 = CFrame.Angles;
        local v29 = u1:NextNumber(-90, 90);
        v22:set(v28 * Angles2(0, math.rad(v29), 0));
        task.delay(u13, function() -- Line: 165
            -- upvalues: u3 (copy), EffectsHandler (ref), u20 (ref), u13 (copy), u12 (copy), u19 (copy), u7 (copy), u1 (ref), BoatTween (ref)
            if u3.ReturnSound then
                EffectsHandler.CallEffect("Play Sound At", {
                    Object = u3.ReturnSound,
                    Origin = u20
                });
            end;

            task.delay(u13, function() -- Line: 173
                -- upvalues: u12 (ref)
                u12:Destroy();
            end);
            local v30 = {
                EasingStyle = "Smoother",
                EasingDirection = "InOut",
                StepType = "Heartbeat",
                Time = u13 / 1.5
            };
            local v31 = {};
            local v32 = u20 * CFrame.new(0, -u19.ExtentsSize.Y / 2 - 3 * u7, 0);
            local Angles3 = CFrame.Angles;
            local v33 = u1:NextNumber(-7, 7);
            local v34 = math.rad(v33);
            local v35 = u1:NextNumber(-35, 35);
            local v36 = math.rad(v35);
            local v37 = u1:NextNumber(-7, 7);
            v31.CFrame = v32 * Angles3(v34, v36, (math.rad(v37)));
            v30.Goal = v31;
            u12:Add(BoatTween:Create(u19, v30)):Play();
        end);

        if u3.Sound then
            EffectsHandler.CallEffect("Play Sound At", {
                Object = u3.Sound,
                Origin = u20
            });
        end;
    elseif v6 == "Pillar" then
        EffectsHandler.CallEffect("CRYSTAL_Debris", {
            SpawnSpeed = 1.75,
            Origin = Origin,
            Lifetime = u13,
            Size = Vector3.new(1.4, 1.4, 1.4) * v8,
            Radius = (Radius - 0.5) * v9,
            Amount = v5 * v9,
            Offset = CFrame.new(0, -4, 3.8)
        });
        local v38 = AssetHandler.GetAsset("Models/CrystalPillars", v16):GetChildren();
        local u39 = u12:Clone(v38[math.random(1, #v38)]);
        task.delay(u13 * 2, function() -- Line: 210
            -- upvalues: u12 (copy)
            u12:Destroy();
        end);
        ParticleHandler.Unusualify(u39, {
            IncludeParts = true,
            Player = v4
        });
        u39.Size = u39.Size / 2;
        u39.Size = u39.Size * u7;
        local u40 = Origin * v10;
        local v41 = Fusion.Value(30);
        local v42 = Fusion.Value(u40 * CFrame.new(0, -u39.ExtentsSize.Y / 2 - 2 * u7, 0));
        local v43 = Fusion.Spring(v42, v41, 0.6);
        Fusion.Hydrate(u39)({
            CFrame = v43,
            Parent = workspace.Effects
        });
        local v44 = v42:get();
        local Angles = CFrame.Angles;
        local v45 = (u3.Tilt and (u3.Tilt or 30) or 30) + u1:NextNumber(-4, 4);
        local v46 = math.rad(v45);
        local v47 = u1:NextNumber(-4, 4);
        local v48 = v44 * Angles(v46, 0, (math.rad(v47))) * CFrame.new(0, u39.ExtentsSize.Y - 1.5 * u7, 0);
        local Angles2 = CFrame.Angles;
        local v49 = u1:NextNumber(-90, 90);
        v42:set(v48 * Angles2(0, math.rad(v49), 0));
        local CallEffect = EffectsHandler.CallEffect;
        local v50 = {
            Path = "Particles/Common/PillarSummon",
            AutoSerialize = true,
            Origin = v42:get(),
            Player = v4,
            Scale = u7
        };
        v50.AbilityName = u3.AbilityData and v16.AbilityName;
        CallEffect("Emit Particle V3", v50);

        if u3.Sound then
            EffectsHandler.CallEffect("Play Sound At", {
                Object = u3.Sound,
                Origin = u40
            });
        end;

        task.delay(u13, function() -- Line: 246
            -- upvalues: u13 (copy), u12 (copy), u39 (copy), u40 (ref), u7 (copy), u1 (ref), BoatTween (ref)
            task.delay(u13, function() -- Line: 247
                -- upvalues: u12 (ref)
                u12:Destroy();
            end);
            local v51 = {
                EasingStyle = "Smoother",
                EasingDirection = "InOut",
                StepType = "Heartbeat",
                Time = u13 / 1.35
            };
            local v52 = {};
            local v53 = u40 * CFrame.new(0, -u39.ExtentsSize.Y / 2 - 3 * u7, 0);
            local Angles3 = CFrame.Angles;
            local v54 = u1:NextNumber(-7, 7);
            local v55 = math.rad(v54);
            local v56 = u1:NextNumber(-35, 35);
            local v57 = math.rad(v56);
            local v58 = u1:NextNumber(-7, 7);
            v52.CFrame = v53 * Angles3(v55, v57, (math.rad(v58)));
            v51.Goal = v52;
            u12:Add(BoatTween:Create(u39, v51)):Play();
        end);
    end;
end;