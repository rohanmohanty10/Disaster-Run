 

 

local u1 = {};
local v2;

if game.GameId == 10768621983 then
    v2 = game.PlaceId == 130574217370467;
else
    v2 = false;
end;

u1.DevPlace = v2;
u1.EventName = "Void Blades";
u1.EndsAt = 1794686400;
u1.Families = {
    Kitsune = {
        Wheel = true,
        Tiers = { "Kitsune", "ImmortalKitsune", "DualImmortalKitsune" },
        Names = { "Kitsune", "Immortal Kitsune", "Dual Immortal Kitsune" },
        Costs = { 5, 5 }
    },
    Kusarigama = {
        Wheel = true,
        Tiers = { "Kusarigama", "VoidKusarigama", "DualVoidKusarigamas" },
        Names = { "Kusarigama", "Void Kusarigama", "Dual Void Kusarigamas" },
        Costs = { 5, 5 }
    }
};
u1.Order = { "Kitsune", "Kusarigama" };
u1.Fusion = {
    Output = "UltimateVoidBlades",
    Name = "Ultimate Void Blades",
    Limit = 1,
    Inputs = { "DualImmortalKitsune", "DualVoidKusarigamas" }
};
u1.StandIns = {
    Kitsune = "Moonfang",
    ImmortalKitsune = "SolarPhoenix",
    DualImmortalKitsune = "SolarPhoenix",
    Kusarigama = "StormTalon",
    VoidKusarigama = "VoidSovereign",
    DualVoidKusarigamas = "VoidSovereign",
    UltimateVoidBlades = "SolarPhoenix"
};
u1.StandInTints = {};
u1.Animations = {};
u1.DualWield = {
    DualImmortalKitsune = true,
    DualVoidKusarigamas = true,
    UltimateVoidBlades = true,
    EclipseFang = true,
    JackInTheBox = true
};
u1.LeftBlades = {
    UltimateVoidBlades = "DualImmortalKitsune"
};
u1.UltimateEmotes = {};
u1.MergeEventId = "2691076433090052674";
u1.TierNames = { "BASE", "UPGRADED", "DUAL", "ULTIMATE" };
u1.TierColors = {
    Color3.fromRGB(175, 185, 192),
    Color3.fromRGB(92, 173, 238),
    Color3.fromRGB(183, 123, 244),
    Color3.fromRGB(242, 191, 89)
};
u1.DebugNotice = "DEBUG: a stand-in knife showcases this feature.";
u1.UltimateLine = "★ %s crafted the %s!";
u1.Sounds = {
    Charge = "",
    Tracks = "",
    Burst = "",
    Fanfare = ""
};
local u3 = {};

for i, v in u1.Families do
    if type(v) == "table" and type(v.Tiers) == "table" then
        local v4 = i;

        for i2, v3 in v.Tiers do
            u3[v3] = {
                family = v4,
                tier = i2
            };
        end;
    end;
end;

function u1.tierOf(p5) -- Line: 111
    -- upvalues: u3 (copy)
    local v6 = type(p5) == "string" and u3[p5] or nil;

    if v6 then
        return v6.family, v6.tier;
    end;

    return nil;
end;

function u1.isFusion(p7) -- Line: 120
    -- upvalues: u1 (copy)
    local v8;

    if type(u1.Fusion) == "table" and p7 ~= nil then
        v8 = p7 == u1.Fusion.Output;
    else
        v8 = false;
    end;

    return v8;
end;

function u1.nameOf(p9) -- Line: 125
    -- upvalues: u1 (copy)
    if u1.isFusion(p9) then
        return u1.Fusion.Name;
    end;

    local v10, v11 = u1.tierOf(p9);

    return v10 and u1.Families[v10].Names[v11] or nil;
end;

function u1.recipe(p12) -- Line: 134
    -- upvalues: u1 (copy)
    local v13, v14 = u1.tierOf(p12);

    if not v13 or v14 < 2 then
        return nil;
    end;

    local v15 = u1.Families[v13];

    return v13, v14, v15.Tiers[v14 - 1], v15.Costs[v14 - 1];
end;

function u1.running(p16) -- Line: 144
    -- upvalues: u1 (copy)
    return type(u1.EndsAt) ~= "number" and true or p16 < u1.EndsAt;
end;

return u1;