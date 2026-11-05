  

 

local u1 = { {
        ApplyTo = "Target",
        Name = "Flaming",
        Damage = 10,
        Lifetime = 4,
        Rate = 1,
        Override = true
    }, {
        ApplyTo = "Target",
        Name = "Mangle"
    }, {
        ApplyTo = "Target",
        Name = "LesserInversion",
        Damage = 20
    }, {
        ApplyTo = "Target",
        Name = "Freeze"
    }, {
        ApplyTo = "Target",
        Name = "Zipper",
        Damage = 2
    } };

return {
    TraitRarity = "Mythic",
    Godly = {
        Description = "+50% damage, +25% damage resistance. The Finisher Rush Attack has a random status effect.",
        HexPrefix = "Egotistic",
        HexDescription = "+50% damage, +25% damage resistance. The Finisher Rush Attack has a random status effect. Gain additional +30% damage and +15% damage resistance to Npcs",
        TraitTypes = { "DamageTrait", "DefenseTrait" },

        HexedCallback = function(p2, p3) -- Line: 88, Name: HexedCallback
            -- upvalues: u1 (copy)
            return {
                StatusEffects = u1,
                NpcDamageBuffBonus = 0.3,
                NpcDamageResistanceBonus = 0.15,
                DamageBuff = 1.5,
                DamageResistance = 0.75
            };
        end,

        TraitCallback = function(p4) -- Line: 101, Name: TraitCallback
            -- upvalues: u1 (copy)
            return {
                DamageBuff = 1.5,
                DamageResistance = 0.75,
                StatusEffects = u1
            };
        end
    },
    Temporal = {
        Description = "Slow down targets in a range near you depending on your heat.",
        HexPrefix = "FTL",
        HexDescription = "Slow down targets in a range near you depending on your heat. Gain 15% Movement Speed and Move Speed.",
        TraitTypes = { "MeterTrait", "NoMeterGainOnHit" },

        HexedCallback = function(p5) -- Line: 116, Name: HexedCallback
            return {
                MaxSlowdown = 0.7,
                MinSlowdown = 0.9,
                MeterGain = 1,
                MeterScaling = 1,
                PersonalTimescaleMultiplier = 1.15
            };
        end,

        TraitCallback = function(p6) -- Line: 125, Name: TraitCallback
            return {
                MaxSlowdown = 0.7,
                MinSlowdown = 0.9,
                MeterGain = 1,
                MeterScaling = 1
            };
        end
    },
    RCT = {
        Description = "-15% health pool, Gain passive % healing scaled on meter. Meter constantly drains, and no meter is gained when damaged.",
        HexPrefix = "Automatic",
        HexDescription = "-30% health pool, Gain massive passive % healing scaled on meter. Meter constantly drains ridiculously fast, and no meter is gained when damaged.",
        TraitTypes = { "HealthTrait", "NoMeterGainOnHit" },

        HexedCallback = function(p7, p8) -- Line: 142, Name: HexedCallback
            return typeof(p8) == "Instance" and {
                HealthBuff = 0.7
            } or {
                HealthGain = (1.5 + (p8 or 0) / 100 * 6) * 0.8 * 0.65,
                MeterDrain = 9,
                HealthBuff = 0.7
            };
        end,

        TraitCallback = function(p9, p10) -- Line: 158, Name: TraitCallback
            return typeof(p10) == "Instance" and {
                HealthBuff = 0.85
            } or {
                HealthGain = (0.75 + (p10 or 0) / 100 * 3) * 0.8 * 0.65,
                MeterDrain = 4.199999999999999,
                HealthBuff = 0.85
            };
        end
    },
    Spiritual = {
        Description = "All meter costs are reduced by 50%, +50% meter regen. Meter scales with damage and resistance",
        HexPrefix = "Mastered",
        HexDescription = "Teleport to the nearest player when doing a rush attack if you have meter. Damage output and reduction equivalent to meter. Higher meter charge rate than usual.",
        TraitTypes = { "MeterTrait", "DefenseTrait", "DamageTrait", "NoMeterGainOnHit" },

        HexedCallback = function(p11, p12) -- Line: 180, Name: HexedCallback
            local v13 = math.min(p12 or 0, 100);

            return {
                MeterGain = 1.5,
                MeterLoss = 0.5,
                Range = 20,
                Cooldown = 4,
                DamageBuff = 0.4 + 1.45 * (v13 / 100),
                DamageResistance = 1.8 - 1.16 * (v13 / 100)
            };
        end,

        TraitCallback = function(p14, p15) -- Line: 193, Name: TraitCallback
            local v16 = math.min(p15 or 0, 100);

            return {
                MeterGain = 1.5,
                MeterLoss = 0.5,
                Range = 12,
                Cooldown = 6,
                DamageBuff = 1 + 0.25 * (v16 / 100),
                DamageResistance = 1 - 0.16 * (v16 / 100)
            };
        end
    },
    Ryoiki = {
        Description = "Excess meter above 100 is converted into a shield (up to 50% max HP). Shield is removed after 15 seconds of inactivity. Shield conversion rate scales with Defense. You can resist timestops.",
        HexPrefix = "Overcharged",
        HexDescription = "Excess meter above 100 is converted into a shield (up to 100% max HP) with increased conversion rate. Shield is removed after 30 seconds of inactivity. Shield conversion rate scales with Defense. You can resist timestops for longer.",
        TraitTypes = { "MeterTrait", "NoMeterGainOnHit" },

        HexedCallback = function(p17) -- Line: 210, Name: HexedCallback
            return {
                Hexed = true,
                MaxShieldPercent = 1,
                BaseConversionRate = 2,
                MeterGain = 1,
                MeterLoss = 1,
                TimestopResist = 3,
                ShieldRemoval = 30
            };
        end,

        TraitCallback = function(p18) -- Line: 221, Name: TraitCallback
            return {
                MaxShieldPercent = 0.5,
                BaseConversionRate = 1,
                MeterGain = 1,
                MeterLoss = 1,
                TimestopResist = 1.5,
                ShieldRemoval = 15
            };
        end
    },
    Adaptation = {
        Description = "You will adapt to attacks done to you and grow resistent to them over time. (7.5% added resistance per attack, up to 75% total resistance per attack, 1.5 second cooldown per adaptation)",
        HexPrefix = "Unbound",
        HexDescription = "You adapt twice as much to attacks and the adaptation cooldown is halved, but you adapt only up to 60%.",

        HexedCallback = function(p19) -- Line: 236, Name: HexedCallback
            return {
                Hexed = true,
                Cooldown = 0.75,
                AdaptRate = 0.15,
                MaxAdaptation = 0.6
            };
        end,

        TraitCallback = function(p20) -- Line: 244, Name: TraitCallback
            return {
                Cooldown = 1.5,
                AdaptRate = 0.075,
                MaxAdaptation = 0.75
            };
        end
    }
};