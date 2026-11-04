 

 

local SkinCatalog = require(script.Parent.Parent.Weapons.SkinCatalog);
local u1 = {
    IntroSeconds = 3,
    SpinSeconds = 10,
    ResultSeconds = 6,
    MaxAmount = 1000000,
    EventSeconds = 90
};

function u1.validPrize(p2) -- Line: 4
    -- upvalues: SkinCatalog (copy), u1 (copy)
    if type(p2) ~= "table" then
        return false;
    end;

    if p2.kind == "Dagger" then
        local v3;

        if type(p2.skin) == "string" then
            v3 = SkinCatalog.get(p2.skin) ~= nil;
        else
            v3 = false;
        end;

        return v3;
    end;

    local v4;

    if (p2.kind == "Coins" or (p2.kind == "Gems" or p2.kind == "XP")) and (type(p2.amount) == "number" and (p2.amount == p2.amount and (p2.amount % 1 == 0 and p2.amount >= 1))) then
        v4 = p2.amount <= u1.MaxAmount;
    else
        v4 = false;
    end;

    return v4;
end;

function u1.key(p5) -- Line: 10
    return p5.kind .. ":" .. tostring(p5.skin or p5.amount);
end;

function u1.label(p6) -- Line: 11
    -- upvalues: SkinCatalog (copy)
    return p6.kind == "Dagger" and SkinCatalog.get(p6.skin).Name or tostring(p6.amount) .. " " .. p6.kind:upper();
end;

function u1.validEvent(p7, p8, p9) -- Line: 12
    -- upvalues: u1 (copy)
    local v10;

    if type(p7) == "table" and (p7.version == 1 and (p7.author == p8 and (type(p7.id) == "string" and (#p7.id == 36 and (type(p7.issuedAt) == "number" and (p7.issuedAt == p7.issuedAt and (p7.issuedAt <= p9 + 5 and p9 - p7.issuedAt < u1.EventSeconds))))))) then
        v10 = u1.validPrize(p7.prize);
    else
        v10 = false;
    end;

    return v10;
end;

function u1.choose(p11, p12) -- Line: 17
    return #p11 > 0 and p11[p12:NextInteger(1, #p11)] or nil;
end;

return table.freeze(u1);