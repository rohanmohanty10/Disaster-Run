  

 

return {
    TraitRarity = "Common",
    Strong = {
        Description = "+5% damage",
        TraitTypes = { "DamageTrait" },

        TraitCallback = function(p1) -- Line: 7, Name: TraitCallback
            return 1.05;
        end
    },
    Kind = {
        Description = "+5% healing",
        TraitTypes = { "HealTrait" },

        TraitCallback = function(p2) -- Line: 15, Name: TraitCallback
            return 1.05;
        end
    },
    Swift = {
        Description = "+6% movement speed",
        TraitTypes = { "MovementTrait" },

        TraitCallback = function(p3) -- Line: 23, Name: TraitCallback
            return 1.06;
        end
    },
    Fortified = {
        Description = "+8% damage resistance",
        TraitTypes = { "DefenseTrait" },

        TraitCallback = function(p4) -- Line: 31, Name: TraitCallback
            return 0.92;
        end
    },
    Menacing = {
        Description = "Posing restores 0.5% max hp per second",

        TraitCallback = function(p5) -- Line: 38, Name: TraitCallback
            return 0.005;
        end
    },
    Fortunate = {
        Description = "Gain 2% crit chance",
        TraitTypes = { "CritTrait" },

        TraitCallback = function(p6) -- Line: 46, Name: TraitCallback
            return Random.new():NextInteger(0, 100) <= 2;
        end
    },
    Hasty = {
        Description = "Gain 4% faster cooldowns",
        TraitTypes = { "CooldownTrait" },

        TraitCallback = function(p7) -- Line: 54, Name: TraitCallback
            return 0.04;
        end
    },
    Healthy = {
        Description = "+5% base health",
        TraitTypes = { "HealthTrait" },

        TraitCallback = function(p8) -- Line: 62, Name: TraitCallback
            return 1.05;
        end
    },
    Sharp = {
        Description = "5% damage is converted to true damage",
        TraitTypes = { "TrueDamageTrait" },

        TraitCallback = function(p9) -- Line: 70, Name: TraitCallback
            return 0.05;
        end
    },
    Sickly = {
        Description = "Damage will be applied over time in return for 5% more damage",
        TraitTypes = { "DOTTrait" },

        TraitCallback = function(p10) -- Line: 78, Name: TraitCallback
            return 1.05;
        end
    }
};