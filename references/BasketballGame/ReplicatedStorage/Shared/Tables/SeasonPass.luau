 
 

local function itemGiver(u1: string, u2: string) -- Line: 1
    return function(p3: userdata, p4: number, p5: any) -- Line: 2
        -- upvalues: u1 (copy), u2 (copy)
        local Inventory = p5.Players[p3.Name].Customization.Inventory;

        if table.find(Inventory[u1], u2) then
            p5:ChangePlrValue(p3, "SeasonPass Currency", p5.Players[p3.Name].SeasonPass.Currency + 100);

            return;
        end;

        table.insert(Inventory[u1], u2);
        p5:ChangePlrValue(p3, `Customization Inventory {u1}`, Inventory[u1]);
    end;
end;

local v6 = {};
local v7 = {
    Icon = "",
    Emote = "Playing Violin",
    DisplayName = "Playing Violin Emote"
};
local u8 = "Emotes";
local u9 = "Playing Violin";

function v7.Giver(p10: userdata, p11: number, p12: any) -- Line: 2
    -- upvalues: u8 (copy), u9 (copy)
    local Inventory = p12.Players[p10.Name].Customization.Inventory;

    if table.find(Inventory[u8], u9) then
        p12:ChangePlrValue(p10, "SeasonPass Currency", p12.Players[p10.Name].SeasonPass.Currency + 100);

        return;
    end;

    table.insert(Inventory[u8], u9);
    p12:ChangePlrValue(p10, `Customization Inventory {u8}`, Inventory[u8]);
end;

v6.PlayingViolinEmote = v7;
local v13 = {
    Icon = "",
    Emote = "Playing Guitar",
    DisplayName = "Playing Guitar Emote"
};
local u14 = "Emotes";
local u15 = "Playing Guitar";

function v13.Giver(p16: userdata, p17: number, p18: any) -- Line: 2
    -- upvalues: u14 (copy), u15 (copy)
    local Inventory = p18.Players[p16.Name].Customization.Inventory;

    if table.find(Inventory[u14], u15) then
        p18:ChangePlrValue(p16, "SeasonPass Currency", p18.Players[p16.Name].SeasonPass.Currency + 100);

        return;
    end;

    table.insert(Inventory[u14], u15);
    p18:ChangePlrValue(p16, `Customization Inventory {u14}`, Inventory[u14]);
end;

v6.PlayingGuitarEmote = v13;
local v19 = {
    Icon = "rbxassetid://80379180396955",
    DisplayName = "Playing Piano Goal Effect"
};
local u20 = "GoalEffects";
local u21 = "Playing Piano";

function v19.Giver(p22: userdata, p23: number, p24: any) -- Line: 2
    -- upvalues: u20 (copy), u21 (copy)
    local Inventory = p24.Players[p22.Name].Customization.Inventory;

    if table.find(Inventory[u20], u21) then
        p24:ChangePlrValue(p22, "SeasonPass Currency", p24.Players[p22.Name].SeasonPass.Currency + 100);

        return;
    end;

    table.insert(Inventory[u20], u21);
    p24:ChangePlrValue(p22, `Customization Inventory {u20}`, Inventory[u20]);
end;

v6.PlayingPianoGoalEffect = v19;
local v25 = {
    Icon = "rbxassetid://133990231388406",
    DisplayName = "Playing Guitar Goal Effect"
};
local u26 = "GoalEffects";
local u27 = "Playing Guitar";

function v25.Giver(p28: userdata, p29: number, p30: any) -- Line: 2
    -- upvalues: u26 (copy), u27 (copy)
    local Inventory = p30.Players[p28.Name].Customization.Inventory;

    if table.find(Inventory[u26], u27) then
        p30:ChangePlrValue(p28, "SeasonPass Currency", p30.Players[p28.Name].SeasonPass.Currency + 100);

        return;
    end;

    table.insert(Inventory[u26], u27);
    p30:ChangePlrValue(p28, `Customization Inventory {u26}`, Inventory[u26]);
end;

v6.PlayingGuitarGoalEffect = v25;
v6.Currency = {
    Icon = "rbxassetid://110678824077456",
    DisplayName = "Keys",

    Giver = function(p31: userdata, p32: number, p33: any) -- Line: 47, Name: Giver
        p33:ChangePlrValue(p31, "SeasonPass Currency", p33.Players[p31.Name].SeasonPass.Currency + p32);
    end
};
v6.Money = {
    Icon = "rbxassetid://120199213702338",
    DisplayName = "$",

    Giver = function(p34: userdata, p35: number, p36: any) -- Line: 54, Name: Giver
        p36:ChangePlrValue(p34, "Money", p36.Players[p34.Name].Money + p35);
    end
};
v6.LuckySpins = {
    Icon = "rbxassetid://111333169806568",
    DisplayName = "Lucky Spins",

    Giver = function(p37: userdata, p38: number, p39: any) -- Line: 61, Name: Giver
        p39:ChangePlrValue(p37, "LuckySpins", p39.Players[p37.Name].LuckySpins + p38);
    end
};
v6.LuckyZoneSpins = {
    Icon = "rbxassetid://71537410313776",
    DisplayName = "Lucky Zone Spins",

    Giver = function(p40: userdata, p41: number, p42: any) -- Line: 68, Name: Giver
        p42:ChangePlrValue(p40, "ZoneLuckySpins", p42.Players[p40.Name].ZoneLuckySpins + p41);
    end
};
v6.Placeholder = {
    Icon = "rbxassetid://6055294192",
    DisplayName = "Placeholder Item",

    Giver = function() -- Line: 75, Name: Giver
    end
};
v6.None = {
    Icon = "",
    DisplayName = "",

    Giver = function() -- Line: 80, Name: Giver
    end
};
local v43 = { { "Currency", 25 }, { "Currency", 25 }, { "Currency", 25 }, { "Currency", 30 }, { "Currency", 30 }, { "Currency", 30 }, { "Currency", 35 }, { "Money", 35000 }, { "Currency", 35 }, { "LuckySpins", 1 }, { "Currency", 40 }, { "Currency", 40 }, { "Money", 45000 }, { "Currency", 45 }, { "LuckySpins", 1 }, { "Currency", 45 }, { "Money", 45000 }, { "Currency", 45 }, { "Currency", 45 }, { "Currency", 50 }, { "Currency", 50 }, { "LuckyZoneSpins", 2 }, { "Currency", 50 }, { "Currency", 55 }, { "Currency", 60 }, { "Money", 65000 }, { "Currency", 65 }, { "Currency", 65 }, { "Currency", 70 }, { "LuckyZoneSpins", 3 } };
local v44 = { { "PlayingViolinEmote", 1 }, { "Currency", 50 }, { "Currency", 50 }, { "Currency", 55 }, { "Currency", 55 }, { "Money", 60000 }, { "Currency", 60 }, { "LuckySpins", 5 }, { "Currency", 60 }, { "Currency", 65 }, { "Currency", 65 }, { "Money", 70000 }, { "Currency", 70 }, { "Money", 70000 }, { "Currency", 70 }, { "Currency", 70 }, { "Currency", 75 }, { "PlayingGuitarEmote", 1 }, { "Currency", 75 }, { "Currency", 75 }, { "Currency", 80 }, { "LuckyZoneSpins", 6 }, { "Currency", 90 }, { "Currency", 95 }, { "Currency", 100 }, { "Currency", 100 }, { "Currency", 105 }, { "Money", 120000 }, { "Currency", 120 }, { "PlayingPianoGoalEffect", 1 } };
local v45 = { { "Currency", 25 }, { "Currency", 25 }, { "Currency", 30 }, { "Currency", 30 }, { "Currency", 35 }, { "Currency", 35 }, { "Currency", 40 }, { "Currency", 40 }, { "Currency", 45 }, { "Currency", 45 }, { "Currency", 50 }, { "Currency", 50 }, { "Currency", 55 }, { "Currency", 55 }, { "Currency", 60 }, { "Currency", 60 }, { "Currency", 65 }, { "Currency", 65 }, { "Currency", 70 }, { "Currency", 70 }, { "Currency", 75 }, { "Currency", 75 }, { "Currency", 80 }, { "Currency", 80 }, { "Currency", 85 }, { "Currency", 85 }, { "Currency", 90 }, { "Currency", 90 }, { "Currency", 95 }, { "Currency", 100 } };
local v46 = { { "Currency", 50 }, { "Currency", 55 }, { "Currency", 60 }, { "Currency", 65 }, { "Currency", 70 }, { "Currency", 75 }, { "Currency", 80 }, { "Currency", 85 }, { "Currency", 90 }, { "Currency", 95 }, { "Currency", 100 }, { "Currency", 105 }, { "Currency", 110 }, { "Currency", 115 }, { "Currency", 120 }, { "Currency", 125 }, { "Currency", 130 }, { "Currency", 135 }, { "Currency", 140 }, { "Currency", 145 }, { "Currency", 150 }, { "Currency", 155 }, { "Currency", 160 }, { "Currency", 170 }, { "Currency", 175 }, { "Currency", 180 }, { "Currency", 185 }, { "Currency", 190 }, { "Currency", 195 }, { "Currency", 200 } };
assert(#v43 == #v44, "track length mismatch");
assert(#v43 == #v45, "track length mismatch");
assert(#v44 == #v46, "track length mismatch");

return {
    MaxRebirths = 5,
    FreeTrack = v43,
    PaidTrack = v44,
    FreeRebirthTrack = v45,
    PaidRebirthTrack = v46,
    Items = v6,
    RebirthItem = { "PlayingGuitarGoalEffect", 1 },
    RewardCount = #v43
};