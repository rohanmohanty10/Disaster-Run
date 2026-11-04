  

local Util = require(script.Parent.Parent.Util);
local Constants = require(script.Parent.Parent.Constants);

return function(p1, p2) -- Line: 4
    -- upvalues: Constants (copy), Util (copy)
    local v3 = p2 or {};
    local v4 = Constants.epsilon(v3);
    local v5 = Util.teamRating(p1, v3);
    local v6 = Util.c(v5, v3);
    local v7 = Util.sumQ(v5, v6);
    local v8 = Util.a(v5);
    local v9 = {};

    for i, v in ipairs(v5) do
        local v10, v11, v12, v13 = unpack(v);
        local math_exp_ret = math.exp(v10 / v6);
        local v14 = i;
        local v15 = 0;
        local v16 = 0;

        for i2, v2 in ipairs(v5) do
            if v2[4] <= v13 then
                local v17 = math_exp_ret / v7[i2];

                if v14 == i2 then
                    v15 = v15 + (1 - v17) / v8[i2];
                else
                    v15 = v15 + -v17 / v8[i2];
                end;

                v16 = v16 + v17 * (1 - v17) / v8[i2];
            end;
        end;

        local v18 = Util.gamma(v6, v11, v3);
        local v19 = v15 * (v11 / v6);
        local v20 = v18 * v16 * (v11 / v6 ^ 2);
        local v21 = {};

        for _, v2 in ipairs(v12) do
            local v22 = {};
            local v23 = v2.mu + v2.sigma ^ 2 / v11 * v19;
            local sigma = v2.sigma;
            local math_max_ret = math.max(1 - v2.sigma ^ 2 / v11 * v20, v4);
            v22[1], v22[2] = v23, sigma * math.sqrt(math_max_ret);
            table.insert(v21, v22);
        end;

        v9[v14] = v21;
    end;

    return v9;
end;