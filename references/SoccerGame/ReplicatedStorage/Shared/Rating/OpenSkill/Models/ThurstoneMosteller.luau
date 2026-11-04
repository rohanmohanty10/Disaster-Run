  

local Util = require(script.Parent.Parent.Util);
local Constants = require(script.Parent.Parent.Constants);
local Statistics = require(script.Parent.Parent.Statistics);

return function(p1, p2) -- Line: 5
    -- upvalues: Constants (copy), Util (copy), Statistics (copy)
    local v3 = p2 or {};
    local v4 = Constants.betaSq(v3) * 2;
    local v5 = Constants.epsilon(v3);
    local v6 = Util.teamRating(p1, v3);
    local v7 = {};

    for i, v in ipairs(v6) do
        local v8, v9, v10, v11 = unpack(v);
        local v12 = i;
        local v13 = 0;
        local v14 = 0;

        for i2, v2 in ipairs(v6) do
            local v15, v16, _, v17 = unpack(v2);

            if v12 ~= i2 then
                local math_sqrt_ret = math.sqrt(v9 + v16 + v4);
                local v18 = (v8 - v15) / math_sqrt_ret;
                local v19 = v9 / math_sqrt_ret;
                local v20 = Util.gamma(math_sqrt_ret, v9);

                if v11 < v17 then
                    v13 = v13 + v19 * Statistics.v(v18, v5 / math_sqrt_ret);
                    v14 = v14 + v20 * v19 / math_sqrt_ret * Statistics.w(v18, v5 / math_sqrt_ret);
                elseif v17 < v11 then
                    v13 = v13 + -v19 * Statistics.v(-v18, v5 / math_sqrt_ret);
                    v14 = v14 + v20 * v19 / math_sqrt_ret * Statistics.w(-v18, v5 / math_sqrt_ret);
                else
                    v13 = v13 + v19 * Statistics.vt(v18, v5 / math_sqrt_ret);
                    v14 = v14 + v20 * v19 / math_sqrt_ret * Statistics.wt(v18, v5 / math_sqrt_ret);
                end;
            end;
        end;

        local v21 = {};

        for _, v2 in ipairs(v10) do
            local v22 = {};
            local v23 = v2.mu + v2.sigma ^ 2 / v9 * v13;
            local sigma = v2.sigma;
            local math_max_ret = math.max(1 - v2.sigma ^ 2 / v9 * v14, v5);
            v22[1], v22[2] = v23, sigma * math.sqrt(math_max_ret);
            table.insert(v21, v22);
        end;

        v7[v12] = v21;
    end;

    return v7;
end;