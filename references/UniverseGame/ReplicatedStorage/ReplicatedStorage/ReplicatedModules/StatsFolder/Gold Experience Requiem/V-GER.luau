  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = nil;
local u2 = nil;

if game:GetService("RunService"):IsServer() then
    Knit.OnStart():andThen(function() -- Line: 10
        -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy), u2 (ref)
        u1 = Knit.GetService("EffectService");
        u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    end);
end;

local u3 = {
    ApplyTo = "Target",
    Name = "Burn",
    Damage = 1,
    Overrides = {
        Lifetime = 3,
        Rate = 0.25
    }
};
local v4 = {
    Name = "Output",
    Arguments = {
        "FX",
        "UGER_Hit",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AbilityName = "Gold Experience Requiem",
            SkinName = nil,
            LookAt = "Attacker",
            Color = BrickColor.new("Light orange brown").Color,
            Material = Enum.Material.Neon
        }
    }
};

return {
    Inherit = {
        AbilityName = "Gold Experience Requiem",
        SkinName = "U-GER"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(176, 74, 23)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 129, 25)) }),
            Callbacks = {
                Summon = function(p5) -- Line: 58, Name: Summon
                    -- upvalues: u2 (ref)
                    if u2 then
                        u2.PlaySound(p5.Character, "FireAura");
                    end;
                end,

                Desummon = function(p6) -- Line: 63, Name: Desummon
                    -- upvalues: u2 (ref)
                    if u2 then
                        u2.StopSound(p6.Character, "FireAura");
                    end;
                end
            }
        },
        ["Debris Shot"] = {
            Homing = true,
            Debris = {
                Homing = true
            }
        },
        Reversal = {
            ReversalColor = BrickColor.new("Light orange brown").Color
        },
        Barrage = {
            Hit = {
                HitRemotes = { v4 }
            }
        },
        ["Kick Barrage"] = {
            Hit = {
                HitRemotes = { v4 }
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitRemotes = { v4 }
            },
            ["StandOff-LMB-1"] = {
                HitRemotes = { v4 }
            }
        },
        ["Consecutive Rushdown"] = {
            Startup = {
                HitRemotes = { v4 }
            },
            Punch = {
                HitRemotes = { v4 }
            }
        },
        ["Righteous Resolution"] = {
            StandKick = {
                HitRemotes = { v4 }
            },
            Barrage = {
                HitRemotes = { v4 }
            }
        }
    },
    Sounds = {
        FireAura = {
            SoundId = 158853971,
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 0.9,
            PlaybackRegionsEnabled = true,
            RollOffMaxDistance = 75,
            PlaybackRegion = NumberRange.new(0.3, 13.7),
            LoopRegion = NumberRange.new(0.3, 13.7)
        }
    },
    Metadata = {
        PostRig = function(p7) -- Line: 144, Name: PostRig
            -- upvalues: u2 (ref), u3 (copy)
            local Player = p7.Player;
            local Character = p7.Character;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local u8 = "VGERBUFFS" .. Player.Name;
            local u9 = false;

            if u2 then
                u2.AttackHook:Unhook("Inbound", u8);
            end;

            local u10 = nil;
            u10 = Character.AncestryChanged:Connect(function(p11, p12) -- Line: 160
                -- upvalues: u2 (ref), u8 (copy), u10 (ref)
                if not (p12 and p12:IsDescendantOf(game)) then
                    u2.AttackHook:Unhook("Inbound", u8);
                    u10:Disconnect();
                end;
            end);

            if u2 then
                u2.AttackHook:Hook("Inbound", u8, 125, function(p13) -- Line: 169
                    -- upvalues: Character (copy), u9 (ref), u3 (ref)
                    local Attacker = p13.Attacker;
                    local State = p13.State;
                    local Stats = p13.Stats;

                    if Attacker == Character and (p13.Target and (p13.Target ~= Attacker and (State.Success and (State.Continue and (Stats.Damage and not u9))))) then
                        if Stats.StatusEffects then
                            table.insert(Stats.StatusEffects, u3);
                        else
                            Stats.StatusEffects = { u3 };
                        end;

                        u9 = true;
                        task.delay(0.05, function() -- Line: 183
                            -- upvalues: u9 (ref)
                            u9 = false;
                        end);
                    end;

                    return true;
                end);
            end;
        end
    }
};