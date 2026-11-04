 
 

local Random_new_ret = Random.new(tick() * math.random());
local u3 = {
    GetTotalWeight = function(p1: table) -- Line: 10, Name: GetTotalWeight
        local v2 = 0;

        for _, v in p1 do
            v2 = v2 + v.Weight;
        end;

        return v2;
    end
};

function u3.GetRandomValueFromWeights(p4: table) -- Line: 20
    -- upvalues: u3 (copy), Random_new_ret (copy)
    local v5 = Random_new_ret:NextNumber(0, (u3.GetTotalWeight(p4)));
    local v6 = 0;

    for _, v in p4 do
        if v6 <= v5 and v5 <= v6 + v.Weight then
            return v.Value;
        end;

        v6 = v6 + v.Weight;
    end;

    error("Random Value was outside weight ranges");
end;

function u3.GetPercentageWeights(p7: table) -- Line: 36
    -- upvalues: u3 (copy)
    local TotalWeight = u3.GetTotalWeight(p7);
    local v8 = {};

    for _, v in p7 do
        v8[v.Weight / TotalWeight] = v.Value;
    end;

    return v8;
end;

return u3;