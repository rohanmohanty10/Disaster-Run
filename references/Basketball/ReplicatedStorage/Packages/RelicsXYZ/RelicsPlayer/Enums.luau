 
 

local v1 = {
    WindowTab = {
        Play = 0,
        Browse = 1,
        Favorites = 2,
        Auras = 3,
        Upgrades = 4,
        Settings = 5,
        Upsell = 6
    },
    WindowState = {
        Full = 0,
        Compact = 1,
        Minimized = 2,
        Hidden = 3
    },
    UserStatus = {
        Freemium = 0,
        TryBeforeBuy = 1,
        TrialExpired = 2,
        BoomboxPurchased = 3
    }
};
local u2 = {};

for _, v in pairs(v1) do
    u2[v] = {};
    local v3 = v;

    for i, v2 in pairs(v) do
        u2[v3][v2] = i;
    end;
end;

function v1.GetName(p4: any, p5: number) -- Line: 64
    -- upvalues: u2 (copy)
    local v6 = u2[p4];

    return v6 and v6[p5] or nil;
end;

return table.freeze(v1);