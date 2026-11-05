  

 

return {
    TraitRarity = "Developer",
    Sussy = {
        Description = "+SUS% damage",
        HexPrefix = "Situational",
        HexDescription = "+SUS%^2 damage but you unsus every 5 seconds",
        TraitTypes = { "DamageTrait" },

        HexedCallback = function(p1, p2) -- Line: 10, Name: HexedCallback
            return {
                DamageBuff = p2 and 443556 or 0.5
            };
        end,

        TraitCallback = function(p3) -- Line: 15, Name: TraitCallback
            return 666;
        end
    },
    Instinct = {
        Description = "Have a 40% chance to dodge Attacks that do not inflict true damage while not using any moves, while below 100 meter and during moves the chance is reduced to 20%",
        HexPrefix = "Autonomous",
        HexDescription = "Have a 99% chance to dodge any Attack at 0 Meter while not moving or using moves, otherwise have a 75% chance to dodge any Attack, however you cannot dodge while sprinting or during any moves",

        HexedCallback = function(p4, p5, p6, p7) -- Line: 25, Name: HexedCallback
            local v8 = 75;

            if not p5 then
                local v9 = p6.GetMetadata(p7);
                p5 = v9.IsSprinting;
                print("IsSprinting:", (tostring(v9.IsSprinting)));

                if not p5 and (v9.MoveDirection.Magnitude == 0 and p6.GetMeter(p7) <= 0) then
                    v8 = 99;
                end;
            end;

            return {
                DodgeChance = p5 and 0 or v8
            };
        end,

        TraitCallback = function(p10, p11, p12, p13) -- Line: 39, Name: TraitCallback
            if p11 and p12.GetMeter(p13) >= p12.GetMeterFromLevel(p13, 4) then
                p11 = false;
            end;

            return {
                DodgeChance = p11 and 20 or 40
            };
        end
    },
    ["Air Marshal"] = {
        Description = "Hold [Space] with at least 25% meter when hitting someone with a low knockback move to start an aerial combo.\nGain +25% move speed and deal +25% more stun while an aerial combo is active. \nAerial combos end either when a move with high knockback is dealt or after a short amount of time.",
        HexPrefix = "Ascended",
        HexDescription = "A portion of damage and stun dealt in an aerial combo will chain onto nearby enemies.",
        TraitTypes = { "OnHitTrait" },

        HexedCallback = function(p14, p15) -- Line: 53, Name: HexedCallback
            return {
                TimescaleMultiplier = 1.25,
                StunMultiplier = 1.25
            };
        end,

        TraitCallback = function(p16) -- Line: 59, Name: TraitCallback
            return {
                TimescaleMultiplier = 1.25,
                StunMultiplier = 1.25
            };
        end
    }
};