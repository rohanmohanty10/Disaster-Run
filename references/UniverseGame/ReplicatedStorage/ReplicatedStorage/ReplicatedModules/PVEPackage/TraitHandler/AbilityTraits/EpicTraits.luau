  

 

return {
    TraitRarity = "Epic",
    Buff = {
        Description = "+15% damage",
        TraitTypes = { "DamageTrait" },

        TraitCallback = function(p1) -- Line: 7, Name: TraitCallback
            return 1.15;
        end
    },
    ["Buso Haki"] = {
        Description = "+15% damage and incoming blocked damage reduced by 25%",
        TraitTypes = { "DamageTrait" },

        TraitCallback = function(p2) -- Line: 15, Name: TraitCallback
            return 1.15;
        end
    },
    Protector = {
        Description = "+20% healing",
        TraitTypes = { "HealTrait" },

        TraitCallback = function(p3) -- Line: 23, Name: TraitCallback
            return 1.2;
        end
    },
    Sonic = {
        Description = "+8% faster movement speed, +6% attack speed",
        TraitTypes = { "MovementTrait", "SequenceTrait" },

        TraitCallback = function(p4) -- Line: 31, Name: TraitCallback
            return {
                SpeedBuff = 1.08,
                SequenceSpeedBuff = 1.06
            };
        end
    },
    Armored = {
        Description = "+16% damage resistance",
        TraitTypes = { "DefenseTrait" },

        TraitCallback = function(p5) -- Line: 42, Name: TraitCallback
            return 0.84;
        end
    },
    Enchanted = {
        Description = "+15% meter gain",
        TraitTypes = { "MeterTrait" },

        TraitCallback = function(p6) -- Line: 50, Name: TraitCallback
            return {
                MeterGain = 1.15
            };
        end
    },
    Assassin = {
        Description = "The higher the enemy health, the greater your damage output",
        TraitTypes = { "DamageTrait" },

        TraitCallback = function(p7, p8) -- Line: 60, Name: TraitCallback
            return 1 + p8.Health / p8.MaxHealth * 0.3;
        end
    },
    Favored = {
        Description = "Gain 8% crit chance",
        TraitTypes = { "CritTrait" },

        TraitCallback = function(p9) -- Line: 68, Name: TraitCallback
            return Random.new():NextInteger(0, 100) <= 8;
        end
    },
    Lethal = {
        Description = "15% damage is converted to true damage",
        TraitTypes = { "TrueDamageTrait" },

        TraitCallback = function(p10) -- Line: 76, Name: TraitCallback
            return 0.15;
        end
    },
    Workhorse = {
        Description = "Gain 8% faster cooldowns",
        TraitTypes = { "CooldownTrait" },

        TraitCallback = function(p11) -- Line: 84, Name: TraitCallback
            return 0.08;
        end
    },
    Bombastic = {
        Description = "Attacks have a 10% chance to create explosions",
        Cooldown = 1,
        TraitTypes = { "OnHitTrait" },
        AttackStats = {
            Damage = 10,
            Block = {
                PerfectBlockable = false
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 12,
                Offset = CFrame.identity
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/QuadBombFinish",
                            LookAt = "Attacker",
                            AbilityName = "Killer Queen",
                            HueShift = false
                        } }
                } }
        },

        TraitCallback = function(p12, p13) -- Line: 120, Name: TraitCallback
            local v14 = p13 or 1;

            if v14 == 0 then
                return false;
            end;

            return 10 * v14 >= Random.new():NextInteger(0, 100);
        end
    },
    Toxic = {
        Description = "Damage will be applied over time in return for 15% more damage",
        TraitTypes = { "DOTTrait" },

        TraitCallback = function(p15) -- Line: 134, Name: TraitCallback
            return 1.15;
        end
    },
    Steadfast = {
        Description = "Blocked attacks always deal 0 damage. 25% chance for guard break to not happen.",

        TraitCallback = function(p16) -- Line: 141, Name: TraitCallback
        end
    },
    Bypassing = {
        Description = "Allows attacks to bypass intangible effects up to Ragdoll level, but removes any stun effect from the attack. Has a 15 second cooldown after use.",

        TraitCallback = function(p17) -- Line: 148, Name: TraitCallback
        end
    },
    Flaming = {
        Description = "Attacks have a 50% chance to inflict flames",
        TraitTypes = { "OnHitTrait" },
        AttackStats = {
            Block = {
                PerfectBlockable = false
            },
            HitRemotes = {
                {
                    Name = "Output",
                    Arguments = {
                        "FX",
                        "HitEffect V3",
                        {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "DawnHit",
                            LookAt = "Attacker",
                            AbilityName = "Dawn",
                            HueShift = false,
                            PathFolder = game:GetService("ReplicatedStorage"):WaitForChild("Client Assets", 15)
                        }
                    }
                }
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Flaming",
                    Damage = 1.5,
                    Lifetime = 4,
                    Rate = 1,
                    Override = true
                } }
        },

        TraitCallback = function(p18, p19) -- Line: 188, Name: TraitCallback
            local v20 = p19 or 1;

            if v20 == 0 then
                return false;
            end;

            return 50 * v20 >= Random.new():NextInteger(0, 100);
        end
    },
    Spicy = {
        Description = "Reduces knockback dealt by 15%",
        TraitTypes = { "KnockbackTrait" },

        TraitCallback = function(p21) -- Line: 202, Name: TraitCallback
            return 0.85;
        end
    },
    Frostbite = {
        Description = "Rush Attack have a 10% chance to freeze targets. Freezing a target will put Frostbite on cooldown for 5 seconds.",
        TraitTypes = { "OnHitTrait" },

        TraitCallback = function(p22) -- Line: 210, Name: TraitCallback
            return Random.new():NextInteger(1, 100) <= 10;
        end
    },
    Shielding = {
        Description = "Healing reduced by 25%. Gain said 25% of healing as shield.",
        TraitTypes = { "ShieldTrait" },

        TraitCallback = function(p23) -- Line: 220, Name: TraitCallback
            return {
                ShieldCoefficient = 0.25,
                HealCoefficient = 0.75
            };
        end
    }
};