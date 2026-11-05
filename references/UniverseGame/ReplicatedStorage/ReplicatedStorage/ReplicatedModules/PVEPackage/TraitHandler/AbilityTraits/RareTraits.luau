  

 

return {
    TraitRarity = "Rare",
    Powerful = {
        Description = "+10% damage",
        TraitTypes = { "DamageTrait" },

        TraitCallback = function(p1) -- Line: 7, Name: TraitCallback
            return 1.1;
        end
    },
    Empathetic = {
        Description = "+10% healing",
        TraitTypes = { "HealTrait" },

        TraitCallback = function(p2) -- Line: 15, Name: TraitCallback
            return 1.1;
        end
    },
    Speedy = {
        Description = "+6% faster movement speed, +4% attack speed",
        TraitTypes = { "MovementTrait", "SequenceTrait" },

        TraitCallback = function(p3) -- Line: 23, Name: TraitCallback
            return {
                SpeedBuff = 1.06,
                SequenceSpeedBuff = 1.04
            };
        end
    },
    Resistant = {
        Description = "+10% damage resistance",
        TraitTypes = { "DefenseTrait" },

        TraitCallback = function(p4) -- Line: 34, Name: TraitCallback
            return 0.9;
        end
    },
    Arcane = {
        Description = "+8% meter gain",
        TraitTypes = { "MeterTrait" },

        TraitCallback = function(p5) -- Line: 42, Name: TraitCallback
            return {
                MeterGain = 1.08
            };
        end
    },
    Piercing = {
        Description = "10% damage is converted to true damage",
        TraitTypes = { "TrueDamageTrait" },

        TraitCallback = function(p6) -- Line: 52, Name: TraitCallback
            return 0.1;
        end
    },
    Lucky = {
        Description = "Gain 4% crit chance",
        TraitTypes = { "CritTrait" },

        TraitCallback = function(p7) -- Line: 60, Name: TraitCallback
            return Random.new():NextInteger(0, 100) <= 4;
        end
    },
    Productive = {
        Description = "Gain 6% faster cooldowns",
        TraitTypes = { "CooldownTrait" },

        TraitCallback = function(p8) -- Line: 68, Name: TraitCallback
            return 0.06;
        end
    },
    Tanky = {
        Description = "+10% base health",
        TraitTypes = { "HealthTrait" },

        TraitCallback = function(p9) -- Line: 76, Name: TraitCallback
            return 1.1;
        end
    },
    Poisonous = {
        Description = "Damage will be applied over time in return for 10% more damage",
        TraitTypes = { "DOTTrait" },

        TraitCallback = function(p10) -- Line: 84, Name: TraitCallback
            return 1.1;
        end
    },
    Vigilante = {
        Description = "2x recovery healing",
        TraitTypes = { "RecoveryTrait" },

        TraitCallback = function(p11) -- Line: 92, Name: TraitCallback
            return 2;
        end
    },
    Vital = {
        Description = "Gain passive flat healing scaled on meter",

        TraitCallback = function(p12, p13) -- Line: 99, Name: TraitCallback
            return 0.25 + p13 / 100 * 0.75;
        end
    },
    Pillowy = {
        Description = "Reduces knockback dealt by 10%",
        TraitTypes = { "KnockbackTrait" },

        TraitCallback = function(p14) -- Line: 107, Name: TraitCallback
            return 0.9;
        end
    }
};