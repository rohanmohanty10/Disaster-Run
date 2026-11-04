 

 

local permissions = require(game.ReplicatedStorage.permissions);
local u1 = {
    [2447122302] = true,
    [4166416054] = true,
    [5077795305] = true
};
local u2 = {
    enabled = false,
    SWAP_TEXT = "🖐️😤",
    HACKER_TEXT = "wow hacker"
};

function u2.is_enabled() -- Line: 18
    -- upvalues: u2 (copy)
    return u2.enabled == true;
end;

function u2.set(p3: boolean) -- Line: 22
    -- upvalues: u2 (copy)
    u2.enabled = p3 == true;
    shared.nowl = u2.enabled;
end;

function u2.is_excluded(p4: number?) -- Line: 27
    -- upvalues: u1 (copy)
    local v5;

    if typeof(p4) == "number" then
        v5 = u1[p4] == true;
    else
        v5 = false;
    end;

    return v5;
end;

function u2.bypasses(p6: number?) -- Line: 32
    -- upvalues: u2 (copy), permissions (copy)
    if not u2.is_enabled() or u2.is_excluded(p6) then
        return true;
    end;

    if typeof(p6) ~= "number" then
        return false;
    end;

    local PlayerByUserId = game.Players:GetPlayerByUserId(p6);
    local v7;

    if PlayerByUserId == nil then
        v7 = false;
    else
        v7 = permissions(PlayerByUserId).scripter;
    end;

    return v7;
end;

function u2.blocks(p8: any, p9: number?) -- Line: 46
    -- upvalues: u2 (copy)
    if u2.is_enabled() and typeof(p8) == "table" then
        return not u2.is_excluded(p9);
    end;

    return false;
end;

return u2;