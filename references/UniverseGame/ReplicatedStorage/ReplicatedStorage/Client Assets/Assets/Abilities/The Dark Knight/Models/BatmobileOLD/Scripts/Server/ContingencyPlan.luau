  

 

local Players = game:GetService("Players");
local Parent = script.Parent.Parent.Parent;
local Chassis = Parent.Chassis;
local _ = Parent.Engine;
local Constants = require(script.Parent.Parent.Constants);
local playRandomSound = require(script.Parent.Parent.Client.FX.playRandomSound);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 18
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("TagService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
    u3 = u2.GetMiddleware("CombatService");
end);
local u4 = Chassis.CollisionSounds:GetChildren();

return function(p5) -- Line: 27
    -- upvalues: Parent (copy), Constants (copy), Players (copy), Chassis (copy), u3 (ref), playRandomSound (copy), u4 (copy)
    local v6 = Parent:GetAttribute(Constants.CAR_OWNER_ATTRIBUTE);
    local v7;

    if v6 then
        v7 = Players:GetPlayerByUserId(v6).Character;
    else
        v7 = nil;
    end;

    if v7 ~= p5 then
        u3.Attack({
            Attacker = v7,
            Target = p5,
            Stats = {
                Damage = 100,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Stun = {
                    Time = 2
                },
                Ragdoll = {
                    Time = 2
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Shock",
                                LookAt = "Attacker",
                                IgnoreUnusuals = true
                            } }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 16515783771,
                        Volume = 0.5
                    }
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Time = 0.15,
                    Velocity = Vector3.new(0, 40, 0),
                    Speed = Chassis.AssemblyLinearVelocity.Magnitude
                }
            }
        }):andThen(function(p8) -- Line: 83
            -- upvalues: playRandomSound (ref), u4 (ref), Chassis (ref)
            if p8.State.Success and p8.State.Continue then
                playRandomSound(u4, Chassis, 2);
            end;
        end);
    end;
end;