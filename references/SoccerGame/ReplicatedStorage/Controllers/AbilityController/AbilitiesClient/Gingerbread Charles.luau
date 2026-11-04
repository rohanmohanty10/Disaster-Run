  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    GingerbreadDribble = require(script.GingerbreadDribble),
    CookieStep = require(script.CookieStep),
    CookieCross = require(script.CookieCross),
    GingerbreadCannon = require(script.GingerbreadCannon),
    CookieDefense = require(script.Awakening.CookieDefense),
    MonsterBlast = require(script.Awakening.MonsterBlast)
};

return {
    meta = {},

    getKit = function(p2: boolean, p3: boolean) -- Line: 21, Name: getKit
        -- upvalues: AbilityUtils (copy), u1 (copy), interface (copy)
        local _, _, _, _ = AbilityUtils.getCharacter();
        local v4 = {
            [2] = {
                display = "Cookie Cross",
                fn = u1.CookieCross
            }
        };

        if interface.CookieStep then
            v4[1] = {
                display = "Cookie Step",
                fn = u1.CookieStep
            };
        else
            v4[1] = {
                display = "Gingerbread Dribble",
                fn = u1.GingerbreadDribble
            };
        end;

        v4[3] = {
            display = "Gingerbread Cannon",
            fn = u1.GingerbreadCannon
        };

        if p2 then
            v4[1] = {
                display = "Monster Blast",
                fn = u1.MonsterBlast
            };
            v4[3] = {
                display = "Cookie Defense",
                fn = u1.CookieDefense
            };
        end;

        for _, v in v4 do
            v.legacyId = v.display;
        end;

        return v4;
    end
};