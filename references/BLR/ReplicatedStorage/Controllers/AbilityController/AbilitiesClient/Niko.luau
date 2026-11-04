  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    Watchtower = require(script.WatchTower),
    Extermination = require(script.Extermination),
    BodyCore = require(script.BodyCore),
    TrapTower = require(script.TrapTower),
    TacticalOneTwo = require(script.TacticalOneTwo)
};
local u2 = {
    NikoExtermination = require(script.Awakening.NikoExtermination),
    NikoInterceptingTrap = require(script.Awakening.NikoInterceptingTrap),
    NikoCuttingEdge = require(script.Awakening.NikoCuttingEdge)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 27, Name: getKit
        -- upvalues: AbilityUtils (copy), interface (copy), u1 (copy), LocalPlayer (copy), u2 (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v5 = {};

        if interface.Extermination then
            v5[1] = {
                display = "Extermination",
                fn = u1.Extermination
            };
        else
            v5[1] = {
                display = "Watchtower",
                legacyFn = u1.Watchtower
            };
        end;

        if AbilityUtils.rules.grounded(LocalPlayer, false) then
            v5[2] = {
                display = "Body Core",
                fn = u1.BodyCore
            };
        else
            v5[2] = {
                display = "Trap Tower",
                fn = u1.TrapTower
            };
        end;

        v5[3] = {
            display = "Tactical One-Two",
            legacyFn = u1.TacticalOneTwo
        };

        if p3 then
            v5[1] = {
                display = "Extermination",
                fn = u2.NikoExtermination
            };
            v5[2] = {
                display = "Cutting Edge",
                fn = u2.NikoCuttingEdge
            };
            v5[3] = {
                display = "Intercepting Trap",
                fn = u2.NikoInterceptingTrap
            };
        end;

        for _, v in v5 do
            v.legacyId = v.display;
        end;

        return v5;
    end
};