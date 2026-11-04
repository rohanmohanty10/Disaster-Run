  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    BunnyHopTrap = require(script.BunnyHopTrap),
    BunnyHopTrapShot = require(script.BunnyHopTrapShot),
    EggShuffle = require(script.EggShuffle),
    HatSteal = require(script.HatSteal),
    CarrotGrab = require(script.Awakening.CarrotGrab),
    EasterTikiTaka = require(script.Awakening.EasterTikiTaka)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 21, Name: getKit
        -- upvalues: AbilityUtils (copy), interface (copy), u1 (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v4 = {};

        if interface.TrapShot then
            v4[1] = {
                display = "Bunny Hop Trap Shot",
                fn = u1.BunnyHopTrapShot
            };
        else
            v4[1] = {
                display = "Bunny Hop Trap",
                fn = u1.BunnyHopTrap
            };
        end;

        if Character.Values.HasBall.Value then
            v4[2] = {
                display = "Egg Shuffle",
                fn = u1.EggShuffle
            };
        else
            v4[2] = {
                display = "Hat Steal",
                legacyFn = u1.HatSteal
            };
        end;

        if p2 then
            v4[1] = {
                display = "Carrot Grab",
                fn = u1.CarrotGrab
            };
            v4[2] = {
                display = "Easter Tiki Taka",
                fn = u1.EasterTikiTaka
            };
        end;

        for _, v in v4 do
            v.legacyId = v.display;
        end;

        return v4;
    end
};