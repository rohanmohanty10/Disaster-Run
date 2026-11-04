  

local script_OpenSkill = require(script.OpenSkill);

return {
    default = script_OpenSkill.Rating(),

    getRating = function(p1: table?) -- Line: 10, Name: getRating
        -- upvalues: script_OpenSkill (copy)
        if p1 then
            return script_OpenSkill.Rating(p1.mu, p1.sigma);
        end;

        return script_OpenSkill.Rating();
    end,

    rate = function(p2: table, p3: table) -- Line: 18, Name: rate
        -- upvalues: script_OpenSkill (copy)
        local v4 = {};

        for i, v in script_OpenSkill.Rate(p2, {
            score = p3
        }) do
            v4[i] = {};
            local v5 = i;

            for i2, v2 in v do
                local v6 = v4[v5];
                local v7 = {
                    mu = v2[1],
                    sigma = v2[2]
                };
                local v8;

                if v7 then
                    v8 = script_OpenSkill.Rating(v7.mu, v7.sigma);
                else
                    v8 = script_OpenSkill.Rating();
                end;

                v6[i2] = v8;
            end;
        end;

        return v4;
    end,

    getEGO = function(p9: table) -- Line: 41, Name: getEGO
        local v10 = 333.3333333333333 / p9.sigma;

        return math.floor(v10 * (p9.mu - p9.sigma * 3 + 100 / v10));
    end
};