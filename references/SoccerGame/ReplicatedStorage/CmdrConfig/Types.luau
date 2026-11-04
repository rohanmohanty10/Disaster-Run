  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlrStyles = require(game.ReplicatedStorage.Shared.PlrStyles);
local Flows = require(game.ReplicatedStorage.Shared.Flows);
local Gamepasses = require(game.ReplicatedStorage.Shared.Configs.Gamepasses);
local Cosmetics = require(game.ReplicatedStorage.Shared.Inventory.Cosmetics);
local Rarities = require(ReplicatedStorage.Shared.Rarities);
require(ReplicatedStorage.Shared.Inventory.BallSkins);
local StyleEventData = require(ReplicatedStorage.Shared.Configs.StyleEventData);
local u1 = {};

for _, v in PlrStyles do
    if v.Skins then
        for i, _ in v.Skins do
            u1[i] = true;
        end;
    end;
end;

return function(p2) -- Line: 21
    -- upvalues: PlrStyles (copy), Flows (copy), Cosmetics (copy), Rarities (copy), ReplicatedStorage (copy), u1 (copy), StyleEventData (copy), Gamepasses (copy)
    p2:RegisterType("styleSlotId", p2.Cmdr.Util.MakeEnumType("StyleSlotId", { "1", "2", "3", "4", "5", "6", "7", "8" }));
    p2:RegisterType("flowSlotId", p2.Cmdr.Util.MakeEnumType("FlowSlotId", { "1", "2", "3", "4", "5", "6", "7" }));
    p2:RegisterType("style", p2.Cmdr.Util.MakeEnumType("Style", p2.Cmdr.Util.DictionaryKeys(PlrStyles)));
    p2:RegisterType("flow", p2.Cmdr.Util.MakeEnumType("Flow", p2.Cmdr.Util.DictionaryKeys(Flows)));
    p2:RegisterType("cosmetic", p2.Cmdr.Util.MakeEnumType("Cosmetic", p2.Cmdr.Util.DictionaryKeys(Cosmetics)));
    p2:RegisterType("rarity", p2.Cmdr.Util.MakeEnumType("Rarity", p2.Cmdr.Util.DictionaryKeys(Rarities)));
    p2:RegisterType("event", p2.Cmdr.Util.MakeEnumType("Event", { "EgoGames", "LavinhoTiles", "UbersMatching" }));
    local v3 = {};

    for _, child in game.ReplicatedStorage.Assets.Customization.Cards:GetChildren() do
        table.insert(v3, child.Name);
    end;

    p2:RegisterType("card", p2.Cmdr.Util.MakeEnumType("Card", v3));
    local v4 = {};

    for i, _ in require(ReplicatedStorage.Shared.Inventory.GoalEffects) do
        table.insert(v4, i);
    end;

    p2:RegisterType("goal", p2.Cmdr.Util.MakeEnumType("Goal", v4));
    local v5 = {};

    for i, _ in require(game.ReplicatedStorage.Shared.Emotes.Emotes) do
        table.insert(v5, i);
    end;

    local v6 = {};

    for _, child in game.ReplicatedStorage.Assets.Customization.BallSkins:GetChildren() do
        table.insert(v6, child.Name);
    end;

    p2:RegisterType("ballSkin", p2.Cmdr.Util.MakeEnumType("BallSkin", v6));
    p2:RegisterType("emote", p2.Cmdr.Util.MakeEnumType("Emote", v5));
    local MVPCutscenes = game.ReplicatedStorage.Effects:FindFirstChild("MVPCutscenes");
    local v7 = {};

    if MVPCutscenes then
        for _, child in MVPCutscenes:GetChildren() do
            table.insert(v7, child.Name);
        end;
    end;

    p2:RegisterType("mvpCutscene", p2.Cmdr.Util.MakeEnumType("MVPCutscene", v7));
    p2:RegisterType("skin", p2.Cmdr.Util.MakeEnumType("Skin", p2.Cmdr.Util.DictionaryKeys(u1)));
    p2:RegisterType("itemType", p2.Cmdr.Util.MakeEnumType(
        "ItemType",
        { "styleSpins", "flowSpins", "luckyStyleSpins", "luckyFlowSpins", "styleSlot", "flowSlot" }
    ));
    local v8 = { "Normal", "Lucky" };

    if StyleEventData.Enabled then
        table.insert(v8, "Event");
    end;

    p2:RegisterType("spinType", p2.Cmdr.Util.MakeEnumType("SpinType", v8));
    p2:RegisterType("halloweenStyles", p2.Cmdr.Util.MakeEnumType(
        "HalloweenStyles",
        { "Blood Moon Rin", "Phantom Isagi", "Reaper Sae", "Demon Shidou", "Skeleton Nagi" }
    ));
    local v9 = { "luckyStyleSpins", "luckyFlowSpins" };

    if StyleEventData.Enabled then
        table.insert(v9, "eventSpins");
    end;

    p2:RegisterType("globalSpins", p2.Cmdr.Util.MakeEnumType("GlobalSpins", v9));
    p2:RegisterType("testScenario", p2.Cmdr.Util.MakeEnumType(
        "TestScenario",
        { "giftFail", "shutdown", "awktest", "maxflow", "noslots", "rmgp", "givewheelspin", "wheelrewards", "twostepsgrant", "seasonreset", "seasonday", "seasonhour", "seasonskip", "seasonset", "aikusnake" }
    ));
    local u10 = {
        min = 60,
        h = 3600,
        d = 86400,
        w = 604800,
        m = 2592000,
        y = 31536000
    };
    p2:RegisterType("banlength", {
        Transform = function(p11) -- Line: 133, Name: Transform
            return string.lower(p11);
        end,

        Validate = function(p12) -- Line: 136, Name: Validate
            -- upvalues: u10 (copy)
            if p12 == "perm" then
                return true;
            end;

            local string_match_ret, v13 = string.match(p12, "^(%d+)(%a+)$");

            if string_match_ret and (u10[v13] and tonumber(string_match_ret) > 0) then
                return true;
            end;

            return false, "Use perm or a number + unit: min, h, d, w, m (months), y. e.g. 30min, 12h, 7d, 2w, 1m";
        end,

        Autocomplete = function(p14) -- Line: 146, Name: Autocomplete
            return { "perm", "1d", "3d", "7d", "14d", "1m" };
        end,

        Parse = function(p15) -- Line: 149, Name: Parse
            -- upvalues: u10 (copy)
            if p15 == "perm" then
                return -1;
            end;

            local string_match_ret, v16 = string.match(p15, "^(%d+)(%a+)$");

            return tonumber(string_match_ret) * u10[v16];
        end
    });
    p2:RegisterType("gamepass", p2.Cmdr.Util.MakeEnumType("GamepassId", p2.Cmdr.Util.DictionaryKeys(Gamepasses)));
    p2:RegisterType("doorState", p2.Cmdr.Util.MakeEnumType("DoorState", { "1", "2", "3", "reset" }));
end;