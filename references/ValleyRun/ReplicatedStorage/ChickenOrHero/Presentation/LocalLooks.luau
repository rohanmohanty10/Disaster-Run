 

 

local u1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});
local u3 = setmetatable({}, {
    __mode = "k"
});

function u1.set(p4, p5, p6) -- Line: 14
    -- upvalues: u2 (copy)
    local v7 = u2[p4];

    if not v7 then
        v7 = {};
        u2[p4] = v7;
    end;

    v7[p5] = p6;
end;

function u1.clear(p8) -- Line: 22
    -- upvalues: u2 (copy)
    u2[p8] = nil;
end;

function u1.has(p9, p10) -- Line: 26
    -- upvalues: u2 (copy)
    local v11 = u2[p9];
    local v12;

    if v11 == nil then
        v12 = false;
    else
        v12 = v11[p10] ~= nil;
    end;

    return v12;
end;

function u1.unset(p13, p14) -- Line: 31
    -- upvalues: u2 (copy)
    local v15 = u2[p13];

    if v15 then
        v15[p14] = nil;

        if next(v15) == nil then
            u2[p13] = nil;
        end;
    end;
end;

function u1.get(p16, p17) -- Line: 41
    -- upvalues: u2 (copy)
    local v18 = u2[p16];

    if v18 then
        v18 = v18[p17];
    end;

    if v18 == nil then
        return p16[p17];
    end;

    return v18;
end;

function u1.hold(p19, p20, p21, p22) -- Line: 52
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    local v23 = u3[p19];

    if not v23 then
        v23 = {};
        u3[p19] = v23;
    end;

    local v24 = v23[p20];

    if not v24 then
        v24 = setmetatable({}, {
            __mode = "k"
        });
        v23[p20] = v24;
    end;

    if not u1.has(p19, p20) then
        local v25 = p19[p20];

        if p22 then
            v25 = p22(v25);
        end;

        u1.set(p19, p20, v25);
    end;

    v24[p21] = true;

    return u2[p19][p20];
end;

function u1.release(p26, p27, p28) -- Line: 75
    -- upvalues: u3 (copy), u1 (copy)
    local v29 = u3[p26];
    local v30;

    if v29 then
        v30 = v29[p27];
    else
        v30 = v29;
    end;

    if v30 then
        v30[p28] = nil;

        if next(v30) ~= nil then
            return false, u1.get(p26, p27);
        end;

        v29[p27] = nil;

        if next(v29) == nil then
            u3[p26] = nil;
        end;
    end;

    local v31 = u1.get(p26, p27);
    u1.unset(p26, p27);

    return true, v31;
end;

return u1;