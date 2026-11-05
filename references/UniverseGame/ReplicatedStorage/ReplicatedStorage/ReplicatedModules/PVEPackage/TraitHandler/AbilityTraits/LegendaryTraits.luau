  

 

return {
    TraitRarity = "Legendary",
    Prime = {
        Description = "+20% damage, +20% damage resistance",
        HexPrefix = "Overconfident",
        HexDescription = "+20% damage, +20% damage resistance. Gain additional +15% damage and +7.5% damage resistance to Npcs",
        TraitTypes = { "DamageTrait", "DefenseTrait" },

        HexedCallback = function(p1, p2) -- Line: 9, Name: HexedCallback
            return {
                DamageBuff = 1.2,
                DamageResistance = 0.8,
                NpcDamageBuffBonus = 0.15,
                NpcDamageResistanceBonus = 0.075
            };
        end,

        TraitCallback = function(p3) -- Line: 17, Name: TraitCallback
            return {
                DamageBuff = 1.2,
                DamageResistance = 0.8
            };
        end
    },
    Angelic = {
        Description = "+50% healing. Pose will heal nearby players.",
        HexPrefix = "Fallen",
        HexDescription = "+120% healing. You cannot be healed, and your damage output is reduced by 30%. While you have meter, \"Pose\" will heal nearby players.",
        TraitTypes = { "HealTrait", "DamageTrait", "HealReceivedTrait", "DefenseTrait" },

        HexedCallback = function(p4) -- Line: 30, Name: HexedCallback
            return {
                HealBuff = 2.2,
                DamageBuff = 0.7,
                HealReceivedBuff = 0,
                DamageResistance = 1
            };
        end,

        TraitCallback = function(p5) -- Line: 38, Name: TraitCallback
            return {
                HealBuff = 1.5,
                DamageBuff = 1,
                HealReceivedBuff = 1,
                DamageResistance = 1
            };
        end
    },
    Solar = {
        Description = "+25% faster movement speed, +15% attack speed. Perfect block window doubled",
        HexPrefix = "Icarus",
        HexDescription = "30% faster movement speed, 20% move/sequence speed, +0.25s perfect block window increase.",
        TraitTypes = { "MovementTrait", "SequenceTrait" },

        HexedCallback = function(p6, p7) -- Line: 53, Name: HexedCallback
            return {
                SpeedBuff = 1.3,
                SequenceSpeedBuff = 1.2
            };
        end,

        TraitCallback = function(p8) -- Line: 59, Name: TraitCallback
            return {
                SpeedBuff = 1.25,
                SequenceSpeedBuff = 1.15
            };
        end
    },
    Cursed = {
        Description = "The lower your current health, the greater your damage output",
        HexPrefix = "Undying",
        HexDescription = "Max health is reduced by 50%, in return the damage output is doubled",
        TraitTypes = { "DamageTrait", "HealthTrait" },

        HexedCallback = function(p9, p10) -- Line: 72, Name: HexedCallback
            return {
                HealthBuff = 0.5,
                DamageBuff = 1 + (p10.MaxHealth - p10.Health) / p10.MaxHealth * 1
            };
        end,

        TraitCallback = function(p11, p12) -- Line: 79, Name: TraitCallback
            return 1 + (p12.MaxHealth - p12.Health) / p12.MaxHealth * 0.5;
        end
    },
    Vampiric = {
        Description = "Gain 10% lifesteal",
        HexPrefix = "Ancient",
        HexDescription = "Gain 15% lifesteal. Additionally 5% of damage taken is considered healing",
        TraitTypes = { "LifestealTrait" },

        HexedCallback = function(p13) -- Line: 89, Name: HexedCallback
            return {
                Lifesteal = 0.15,
                HealConversion = 0.05
            };
        end,

        TraitCallback = function(p14) -- Line: 96, Name: TraitCallback
            return {
                Lifesteal = 0.1
            };
        end
    },
    Gluttonous = {
        Description = "All meter costs are reduced by 30%, +15% meter regen. Meter scales with damage and resistance",
        HexPrefix = "Festering",
        HexDescription = "All meter costs reduced by 50%, gain faster meter charging. Damage output and resistance buffs based on meter at a wider cap than usual.",
        TraitTypes = { "MeterTrait", "DefenseTrait", "DamageTrait" },

        HexedCallback = function(p15, p16, p17) -- Line: 108, Name: HexedCallback
            local v18 = math.min(p16 or 0, 100);

            return {
                MeterGain = 1.175,
                MeterLoss = 0.5,
                DamageBuff = 0.8 + 0.4 * (v18 / 100),
                DamageResistance = 1.25 - 0.625 * (v18 / 100)
            };
        end,

        TraitCallback = function(p19, p20) -- Line: 130, Name: TraitCallback
            local v21 = math.min(p20 or 0, 100);

            return {
                MeterGain = 1.15,
                MeterLoss = 0.7,
                DamageBuff = 1 + 0.1 * (v21 / 100),
                DamageResistance = 1 - 0.25 * (v21 / 100)
            };
        end
    },
    Voided = {
        Description = "Attacks have a 15% chance to spawn blackholes",
        HexPrefix = "Abyssal",
        HexDescription = "Attacks have a 25% chance to spawn blackholes. Black holes have a 20% chance to deal AOE damage to everyone excluding the attacker.",
        TraitTypes = { "OnHitTrait" },
        AttackStats = {
            Damage = 5,
            Block = {
                PerfectBlockable = false
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 8,
                CanQueryCaster = true,
                Offset = CFrame.identity
            }
        },

        HexedCallback = function(p22, p23) -- Line: 158, Name: HexedCallback
            local v24 = p23 or 1;

            if v24 == 0 then
                return false;
            end;

            return 25 * v24 >= Random.new():NextInteger(0, 100);
        end,

        TraitCallback = function(p25, p26) -- Line: 167, Name: TraitCallback
            local v27 = p26 or 1;

            if v27 == 0 then
                return false;
            end;

            return 15 * v27 >= Random.new():NextInteger(0, 100);
        end
    },
    Gambler = {
        Description = "Gain 30% crit chance",
        HexPrefix = "Idle Death",
        HexDescription = "+30% crit dmg. Gain 15% bonus crit chance based on meter. All meter moves will drain the entire meter bar. Crits will refill meter to max. When critting there is a 10% chance for enemies to be enraged gaining 0-50% dmg buff and 0-300% movement speed buff.",
        TraitTypes = { "CritTrait" },

        HexedCallback = function(p28, p29) -- Line: 183, Name: HexedCallback
            local v30 = math.min(p29 or 0, 100);

            return {
                IsCrit = Random.new():NextInteger(0, 100) <= 15 + 15 * v30 / 100,
                Infamous = Random.new():NextInteger(0, 100) <= 10
            };
        end,

        TraitCallback = function(p31) -- Line: 190, Name: TraitCallback
            return Random.new():NextInteger(0, 100) <= 30;
        end
    },
    Overflowing = {
        Description = "Cooldowns lowered by 15%",
        HexPrefix = "Torrential",
        HexDescription = "Cooldowns lowered by 25%",
        TraitTypes = { "CooldownTrait" },

        HexedCallback = function(p32) -- Line: 200, Name: HexedCallback
            return 0.25;
        end,

        TraitCallback = function(p33) -- Line: 203, Name: TraitCallback
            return 0.15;
        end
    },
    Deferred = {
        Description = "Deal 30% more damage in the form of damage over time",
        HexPrefix = "Fractured",
        HexDescription = "Deal 40% more damage in the form of damage over time, with a 20% chance for each tick of damage over time to crit.",
        TraitTypes = { "DOTTrait" },

        HexedCallback = function(p34) -- Line: 213, Name: HexedCallback
            return 1.4;
        end,

        TraitCallback = function(p35) -- Line: 216, Name: TraitCallback
            return 1.3;
        end
    },
    True = {
        Description = "+25% bonus true damage",
        HexPrefix = "Vitriolic",
        HexDescription = "+40% bonus true damage",
        TraitTypes = { "TrueDamageTrait" },

        HexedCallback = function(p36) -- Line: 226, Name: HexedCallback
            return {
                TrueDamageBonus = 0.4
            };
        end,

        TraitCallback = function(p37) -- Line: 231, Name: TraitCallback
            return 0.25;
        end
    },
    Cultivation = {
        Description = "Gain a random stat point every 1 minute, capped at 100 for each stat category. Upon death, all points in all stats will be reset.",
        HexPrefix = "Soul Reaping",
        HexDescription = "Every 1 minute, gain random stats, capped at 250 for each category. Upon death, all points in all stats will be reset.",

        HexedCallback = function(p38) -- Line: 240, Name: HexedCallback
            return {
                Attack = 250,
                Defense = 250,
                Health = 250,
                Special = 250
            };
        end,

        TraitCallback = function(p39) -- Line: 249, Name: TraitCallback
            return {
                Attack = 100,
                Defense = 100,
                Health = 100,
                Special = 100
            };
        end
    },
    Economic = {
        Description = "Gain UCoins when defeating NPCs based on their max health",
        HexPrefix = "Greedy",
        HexDescription = "Gain twice the UCoins when defeating NPCs based on their max health",

        HexedCallback = function(p40) -- Line: 263, Name: HexedCallback
        end,

        TraitCallback = function(p41) -- Line: 266, Name: TraitCallback
        end
    }
};