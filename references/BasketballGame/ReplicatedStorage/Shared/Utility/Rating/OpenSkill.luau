 
 

local u1 = {
    Settings = {
        DefaultModel = "PlackettLuce"
    }
};
local script_Constants = require(script.Constants);
local script_Statistics = require(script.Statistics);
local script_Util = require(script.Util);
local script_Models = require(script.Models);

function u1.Ordinal(p2: table, p3: any) -- Line: 53
    -- upvalues: script_Constants (copy)
    return p2.mu - script_Constants.z(p3 or {}) * p2.sigma;
end;

function u1.Rating(p4: number?, p5: number?, p6: any) -- Line: 58
    -- upvalues: script_Constants (copy)
    local v7 = p6 or {};
    local v8 = {};

    for i, v in next, v7 do
        v8[i] = v;
    end;

    v8.mu = p4;

    return {
        mu = p4 or script_Constants.mu(v7),
        sigma = p5 or script_Constants.sigma(v8)
    };
end;

function u1.Rate(p9: table, p10: any) -- Line: 71
    -- upvalues: script_Models (copy), u1 (copy), script_Util (copy)
    local v11 = p10 or {};
    local v12 = script_Models[v11.model or u1.Settings.DefaultModel];

    if v11.rank == nil and v11.score == nil then
        local v13 = v12(p9, v11);

        for i, v in ipairs(v13) do
            local v14 = i;

            for i2, v2 in ipairs(v) do
                p9[v14][i2].mu = v2[1];
                p9[v14][i2].sigma = v2[2];
            end;
        end;

        return v13;
    end;

    local rank = v11.rank;

    if not rank then
        rank = {};

        for i, v in ipairs(v11.score) do
            rank[i] = -v;
        end;
    end;

    local v15, v16 = script_Util.unwind(p9, rank);
    local v17 = {};

    for i, v in next, v11 do
        v17[i] = v;
    end;

    table.sort(rank);
    v17.rank = rank;
    local v18 = v12(v15, v17);
    local v19 = script_Util.unwind(v18, v16);

    for i, v in ipairs(v19) do
        local v20 = i;

        for i2, v2 in ipairs(v) do
            p9[v20][i2].mu = v2[1];
            p9[v20][i2].sigma = v2[2];
        end;
    end;

    return v19;
end;

function u1.WinProbability(p21: table, p22: any) -- Line: 109
    -- upvalues: script_Util (copy), script_Constants (copy), script_Statistics (copy)
    local v23 = p22 or {};
    local v24 = script_Util.teamRating(p21, v23);
    local v25 = script_Constants.betaSq(v23);
    local v26 = #p21;
    local v27 = v26 * (v26 - 1) / 2;
    local v28 = {};

    for i, v in ipairs(v24) do
        local v29 = v;
        local v30 = i;
        local v31 = 0;

        for i2, v2 in ipairs(v24) do
            if v30 ~= i2 then
                v31 = v31 + script_Statistics.phiMajor((v29[1] - v2[1]) / math.sqrt(v26 * v25 + v29[2] ^ 2 + v2[2] ^ 2));
            end;
        end;

        table.insert(v28, v31 / v27);
    end;

    return v28;
end;

function u1.DrawProbability(p32: table, p33: any) -- Line: 129
    -- upvalues: script_Util (copy), script_Constants (copy), script_Statistics (copy)
    local v34 = p33 or {};
    local v35 = script_Util.teamRating(p32, v34);
    local v36 = script_Constants.betaSq(v34);
    local v37 = script_Constants.beta(v34);
    local v38 = #p32;

    if v38 ~= 0 then
        if v38 == 1 then
            return 1;
        end;

        local v39 = 0;

        for _, v in ipairs(p32) do
            v39 = v39 + #v;
        end;

        local v40 = math.sqrt(v39) * v37 * script_Statistics.phiMajorInverse((1 / v38 + 1) / 2);
        local v41 = 0;

        for i, v in ipairs(v35) do
            local v42 = v;
            local v43 = i;

            for i2, v2 in ipairs(v35) do
                if v43 ~= i2 then
                    local math_sqrt_ret = math.sqrt(v38 * v36 + v42[2] ^ 2 + v2[2] ^ 2);
                    v41 = v41 + (script_Statistics.phiMajor((v40 - v42[1] + v2[1]) / math_sqrt_ret) - script_Statistics.phiMajor((v42[1] - v2[1] - v40) / math_sqrt_ret));
                end;
            end;
        end;

        return math.abs(v41) / (v38 * (v38 - 1) / (v38 > 2 and 1 or 2));
    end;
end;

return u1;