  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local AbilityUtils2 = require(ReplicatedStorage.Shared.AbilityUtils);
local PlayerData = ClientGlobals.PlayerData;
local u1 = {
    Kablamo = require(script.Kablamo),
    DragonHeader = require(script.DragonHeader),
    DemonDrive = require(script.DemonDrive),
    BigBangDrive = require(script.BigBang)
};
local u2 = {
    DemonShot = require(script.NEL.DemonShot),
    DragonicVolley = require(script.NEL.DragonicVolley),
    DragonDrive = require(script.NEL.DragonDrive),
    DemonicRush = require(script.NEL.DemonicRush),
    DragonHeader = require(script.NEL.DragonHeader),
    UnstoppableHeader = require(script.NEL.Awakening.UnstoppableDemonHeader),
    UnstoppableDemon = require(script.Awakening.UnstoppableDemonShot)
};

return {
    meta = {},

    getKit = function(p3: boolean, p4: boolean) -- Line: 33, Name: getKit
        -- upvalues: AbilityUtils (copy), PlayerData (copy), countStyleMastery (copy), u1 (copy), AbilityUtils2 (copy), Players (copy), u2 (copy), interface (copy)
        local Character, _, _, _ = AbilityUtils.getCharacter();
        local v5, v6;

        if p4 and PlayerData.Data then
            v5 = countStyleMastery(PlayerData.Data, "Shidou");
            v6 = PlayerData.Data.DisabledMasteryLevels.Shidou;
        else
            v5 = 0;
            v6 = {};
        end;

        local v7 = {
            {
                display = "Kablamo",
                legacyFn = u1.Kablamo
            }
        };

        if Character.Values.HasBall.Value then
            v7[2] = {
                display = "Dragon Header",
                legacyFn = u1.DragonHeader
            };
        else
            v7[2] = {
                display = "Demon Drive",
                legacyFn = u1.DemonDrive
            };
        end;

        if v5 >= 1 and not v6[1] then
            if AbilityUtils2.rules.grounded(Players.LocalPlayer, false) then
                v7[1] = {
                    display = "Dragonic Volley",
                    fn = u2.DragonicVolley
                };
            else
                v7[1] = {
                    display = "Dragon Drive",
                    fn = u2.DragonDrive
                };
            end;
        end;

        if v5 >= 2 and not v6[2] then
            if interface.DragonHeader then
                v7[2] = {
                    display = "Dragon Header",
                    fn = u2.DragonHeader
                };
            else
                v7[2] = {
                    display = "Demonic Rush",
                    legacyFn = u2.DemonicRush
                };
            end;
        end;

        if v5 >= 3 and not v6[3] then
            v7[3] = {
                display = "Demon Shot",
                fn = u2.DemonShot
            };
        end;

        if p3 then
            if v5 >= 4 and (not v6[4] and p3) then
                v7[1] = {
                    display = "Unstoppable Demon Header",
                    fn = u2.UnstoppableHeader
                };

                if interface.DragonHeader then
                    v7[2] = {
                        display = "Dragon Header",
                        fn = u2.DragonHeader
                    };
                else
                    v7[2] = {
                        display = "Demonic Rush",
                        legacyFn = u2.DemonicRush
                    };
                end;

                v7[3] = {
                    display = "Big Bang Drive",
                    fn = u1.BigBangDrive
                };
            else
                v7[1] = {
                    display = "Unstoppable Demon",
                    fn = u2.UnstoppableDemon
                };

                if Character.Values.HasBall.Value then
                    v7[2] = {
                        display = "Dragon Header",
                        legacyFn = u1.DragonHeader
                    };
                else
                    v7[2] = {
                        display = "Demon Drive",
                        legacyFn = u1.DemonDrive
                    };
                end;

                v7[3] = {
                    display = "Big Bang Drive",
                    fn = u1.BigBangDrive
                };
            end;
        end;

        for _, v in v7 do
            v.legacyId = v.display;
        end;

        return v7;
    end
};