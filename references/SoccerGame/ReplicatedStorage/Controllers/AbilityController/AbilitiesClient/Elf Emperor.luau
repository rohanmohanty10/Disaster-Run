  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    ElfImpact = require(script.ElfImpact),
    HelperDribble = require(script.HelperDribble),
    ElfVolley = require(script.ElfVolley),
    ElfEmperorDribble = require(script.ElfDribble),
    ElfschussImpact = require(script.Awakening.ElfschussImpact),
    EmperorsCatapult = require(script.Awakening.EmperorsCatapult)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 21, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy)
        local _, _, _, v4 = AbilityUtils.getCharacter();
        local v5 = {
            {
                display = "Elf Impact",
                fn = u1.ElfImpact
            }
        };

        if v4.HasBall.Value then
            v5[2] = {
                display = "Helper Dribble",
                fn = u1.HelperDribble
            };
        else
            v5[2] = {
                display = "Elf Emperor Volley",
                fn = u1.ElfVolley
            };
        end;

        v5[3] = {
            display = "Elf Emperor Dribble",
            fn = u1.ElfEmperorDribble
        };

        if p2 then
            v5[1] = {
                display = "Elfschuss Impact",
                fn = u1.ElfschussImpact
            };
            v5[2] = {
                display = "Emperors Catapult",
                fn = u1.EmperorsCatapult
            };
            v5[3] = {
                display = "Elf Emperor Dribble",
                fn = u1.ElfEmperorDribble
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};