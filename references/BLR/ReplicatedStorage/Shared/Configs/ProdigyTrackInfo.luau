  

local u1 = {
    IncreasePerTier = 25,
    Stages = { 5, 10, 25 }
};

function u1.GetGoalTarget(p2) -- Line: 12
    -- upvalues: u1 (copy)
    local v3 = u1.Stages[p2];

    if v3 then
        return v3;
    end;

    local v4 = #u1.Stages;

    return u1.Stages[v4] + u1.IncreasePerTier * (p2 - v4);
end;

return u1;