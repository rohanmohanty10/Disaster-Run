  

 

local u1 = {
    Assets = { 120671603129562, 14390885673, 14483486757, 13581931834, 14985369287, 133974475643327, 14945230343, 8484075959, 8241997040, 6897286580, 7467465684, 6856903206 },
    Bonuses = {
        [14390885673] = {
            UPointsMultiplier = 2
        },
        [14483486757] = {
            UPointsMultiplier = 2
        }
    },
    Limiteds = {
        [14945230343] = true
    }
};

function u1.GetAssets() -- Line: 41
    -- upvalues: u1 (copy)
    return u1.Assets;
end;

function u1.GetBonuses() -- Line: 45
    -- upvalues: u1 (copy)
    return u1.Bonuses;
end;

function u1.GetBonusesForAsset(p2) -- Line: 49
    -- upvalues: u1 (copy)
    return u1.Bonuses[p2];
end;

function u1.IsLimitedAsset(p3) -- Line: 53
    -- upvalues: u1 (copy)
    return u1.Limiteds[p3];
end;

return u1;