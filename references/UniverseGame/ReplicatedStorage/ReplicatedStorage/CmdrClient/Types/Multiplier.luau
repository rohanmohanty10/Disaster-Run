  

 

return function(p1) -- Line: 1
    p1:RegisterType("multiplier", p1.Cmdr.Util.MakeEnumType(
        "Multiplier",
        { "WalkSpeedMultiplier", "CooldownMultiplier", "TimescaleMultiplier", "MeterGainMultiplier", "CooldownReduction", "DamageMultiplier", "DamageReceivalMultiplier", "HealMultiplier", "HealReceivalMultiplier", "StunMultiplier", "RegenMultiplier" }
    ));
end;