  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("ContentProvider");
local _ = Players.LocalPlayer;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.Types);
local Trove = require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local u1 = Random.new();
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;

local function _(p2, p3) -- Line: 28
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

return function(p4) -- Line: 39
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), RunService (copy)
    if not p4.Reference then
        return;
    end;

    local v5 = Trove.new();
    v5:AttachToInstance(p4.Reference);
    local u6 = AssetHandler.CloneAsset("Universal/Interaction/Lab/WormholeCharge");

    if not u6 then
        v5:Destroy();

        return;
    end;

    u6.Position = ParticleHandler.TranslateToPosition(p4.Origin);
    u6.Parent = workspace.Effects;
    ParticleHandler.EnableAllParticles(u6, true);
    local u7 = true;
    v5:Add(function() -- Line: 60
        -- upvalues: ParticleHandler (ref), u6 (ref), u7 (ref)
        ParticleHandler.EnableAllParticles(u6, false);
        ParticleHandler.DestroyByMaxLifetime(u6);
        u6 = nil;
        u7 = false;
    end);
    local v8 = ParticleHandler.TranslateToCFrame(p4.Origin);

    for _, child in p4.GeneratorModel:GetChildren() do
        if child.Name == "LaserStabilizer" then
            local Tip = child:FindFirstChild("Tip");

            if Tip then
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Universal/Interaction/Lab/LaserShoot",
                    RawPath = true,
                    Scale = 1.12,
                    ScaleLifetime = 1,
                    BypassRenderCap = true,
                    MaxRenderDistance = 500,
                    Origin = CFrame.lookAt(Tip.Position, v8.Position)
                });
            end;
        end;
    end;

    local Duration = p4.Duration;
    local v9 = 0;
    local v10 = 1;

    while v9 <= Duration and u7 do
        v9 = v9 + RunService.Heartbeat:Wait();
        local v11 = 1 - (1 - math.clamp(v9 / Duration, 0, 1)) ^ 2;
        local v12 = math.lerp(1, 15, v11) * (1 - 0.4 * math.noise(v9 * 6));
        ParticleHandler.ScaleParticle(u6, v12 / v10);
        v10 = v12;
    end;

    ParticleHandler.ScaleParticle(u6, 15 / v10);
    v5:Destroy();
    EffectsHandler.CallEffects({
        {
            Name = "Emit Particle V3",
            Data = {
                {
                    Path = "Universal/Interaction/Lab/WormholePulse",
                    RawPath = true,
                    Scale = 1.5,
                    ScaleLifetime = 1.1,
                    BypassRenderCap = true,
                    MaxRenderDistance = 1000,
                    Origin = v8
                }
            }
        },
        {
            Name = "Q_RADIAL",
            Data = {
                {
                    Distance = 270,
                    Origin = v8,
                    Effect = {
                        {
                            Effect = "Camera Shake",
                            Arguments = { { 10, 19, 0, 0.7, Vector3.new(0.4, 0.4, 0.4), Vector3.new(4, 1, 1), true } }
                        },
                        {
                            Effect = "InvertedLighting",
                            Arguments = { 0.2, 0.5 }
                        },
                        {
                            Effect = "TedBlur",
                            Arguments = { 20, 0.2 }
                        },
                        {
                            Effect = "TemporalEffect",
                            Arguments = { Color3.fromRGB(92, 179, 255), Color3.fromRGB(30, 59, 83), 0.25 }
                        },
                        {
                            Effect = "Bubble Distortion",
                            Arguments = {
                                {
                                    StartSize = Vector3.new(5, 5, 5),
                                    EndSize = Vector3.new(70, 70, 70),
                                    Transparency = 11,
                                    Time = 1.15,
                                    Origin = v8
                                }
                            }
                        }
                    }
                }
            }
        }
    });
end;