 
 

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

    rate = function(p2: table) -- Line: 18, Name: rate
        -- upvalues: script_OpenSkill (copy)
        local v3 = {};
        local v4 = {};
        local v5 = {};

        for i, v in p2 do
            local v6 = { table.clone(v.rating) };
            table.insert(v3, v6);
            table.insert(v4, v.score);
            v5[#v3] = i;
        end;

        local v7 = {};

        for i, v in script_OpenSkill.Rate(v3, {
            score = v4
        }) do
            local v8 = v5[i];
            local v9 = {
                mu = v[1][1],
                sigma = v[1][2]
            };
            local v10;

            if v9 then
                v10 = script_OpenSkill.Rating(v9.mu, v9.sigma);
            else
                v10 = script_OpenSkill.Rating();
            end;

            v7[v8] = v10;
        end;

        return v7;
    end,

    getELO = function(p11: table) -- Line: 46, Name: getELO
        local v12 = 200 / p11.sigma;
        local v13 = math.floor(v12 * (p11.mu - p11.sigma * 3 + 1500 / v12)) - 900;

        return math.max(v13, 0);
    end
};