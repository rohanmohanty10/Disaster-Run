  

local Constants = require(script.Parent.Constants);
local u9 = {
    score = function(p1, p2) -- Line: 4, Name: score
        return p1 < p2 and 0 or (p2 < p1 and 1 or 0.5);
    end,

    rankings = function(p3, p4) -- Line: 13, Name: rankings
        local v5 = p4 or {};
        local v6 = {};

        for i in ipairs(p3) do
            table.insert(v6, v5[i] or i);
        end;

        local v7 = {};
        local v8 = 1;

        for i = 1, #v6 do
            if i > 1 then
                if v6[i - 1] < v6[i] then
                    v8 = i;
                end;
            end;

            v7[i] = v8;
            local _ = i;
        end;

        for i, _ in ipairs(v7) do
            v7[i] = v7[i] - 1;
        end;

        return v7;
    end
};

function u9.teamRating(p10, p11) -- Line: 33
    -- upvalues: u9 (copy)
    local v12 = u9.rankings(p10, p11.rank);
    local v13 = {};

    for i, v in ipairs(p10) do
        local v14 = 0;
        local v15 = 0;

        for _, v2 in ipairs(v) do
            v14 = v14 + v2.mu;
            v15 = v15 + v2.sigma ^ 2;
        end;

        table.insert(v13, {
            v14,
            v15,
            v,
            v12[i]
        });
    end;

    return v13;
end;

function u9.ladderPairs(p16) -- Line: 47
    local v17 = #p16;

    if v17 == 0 then
        return { {} };
    end;

    local v18 = {};
    table.move(p16, 1, v17 - 1, 2, v18);
    local v19 = {};
    table.move(p16, 2, v17, 1, v19);
    local v20 = {};

    for i = 1, v17 do
        local v21;

        if v18[i] then
            table.insert(v20, { v18[i], v19[i] });
            v21 = i;
        else
            table.insert(v20, { v19[i] });
            v21 = i;
        end;
    end;

    return v20;
end;

function u9.permutations(p22) -- Line: 67
    local v23 = #p22 + 1;
    local v24 = {
        { unpack(p22) }
    };
    local v25 = {};

    for i = 1, v23 - 1 do
        table.insert(v25, 1);
        local _ = i;
    end;

    local v26 = 1;

    while v26 < v23 do
        if v25[v26] < v26 then
            if v26 % 2 == 1 then
                local v27 = p22[v26];
                p22[v26] = p22[1];
                p22[1] = v27;
            else
                local v28 = v25[v26];
                local v29 = p22[v26];
                p22[v26] = p22[v28];
                p22[v28] = v29;
            end;

            local v30 = { unpack(p22) };
            table.insert(v24, v30);
            v25[v26] = v25[v26] + 1;
            v26 = 1;
        else
            v25[v26] = 1;
            v26 = v26 + 1;
        end;
    end;

    return v24;
end;

function u9.c(p31, p32) -- Line: 94
    -- upvalues: Constants (copy)
    local v33 = Constants.betaSq(p32);
    local v34 = 0;

    for _, v in ipairs(p31) do
        v34 = v34 + (v[2] + v33);
    end;

    return math.sqrt(v34);
end;

function u9.sumQ(p35, p36) -- Line: 103
    local v37 = {};

    for _, v in ipairs(p35) do
        local v38 = v;
        local v39 = 0;

        for _, v2 in ipairs(p35) do
            if v2[4] >= v38[4] then
                v39 = v39 + math.exp(v2[1] / p36);
            end;
        end;

        table.insert(v37, v39);
    end;

    return v37;
end;

function u9.a(p40) -- Line: 117
    local v41 = {};

    for _, v in ipairs(p40) do
        local v42 = v;
        local v43 = {};

        for _, v2 in ipairs(p40) do
            if v42[4] == v2[4] then
                table.insert(v43, v2);
            end;
        end;

        table.insert(v41, #v43);
    end;

    return v41;
end;

function u9.gamma(p44, p45, p46) -- Line: 137
    if p46 and p46.gamma then
        return p46.gamma(p44, p45, p46);
    end;

    return math.sqrt(p45) / p44;
end;

function u9.unwind(p47: table, p48: table) -- Line: 145
    local v49 = {};
    local v50 = {};
    local v51 = {};
    local v52 = {};

    for i = 1, #p48 do
        local v53 = (1 / 0);
        local v54 = nil;

        for i2, v in ipairs(p48) do
            if not table.find(v49, i2) and v < v53 then
                v54 = i2;
                v53 = v;
            end;
        end;

        table.insert(v49, v54);
        v50[v54] = i;
    end;

    for i, v in ipairs(p47) do
        v51[v50[i]] = v;
        v52[v50[i]] = i;
    end;

    return v51, v52;
end;

return u9;