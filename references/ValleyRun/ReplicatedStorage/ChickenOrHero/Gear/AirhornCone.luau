 

 

local u1 = {
    Range = 14,
    MaxHeight = 6
};

function u1.contains(p2, p3, p4, p5) -- Line: 3
    -- upvalues: u1 (copy)
    local v6 = p4 - p2;
    local Vector3_new_ret = Vector3.new(v6.X, 0, v6.Z);
    local v7;

    if math.abs(v6.Y) <= u1.MaxHeight then
        v7 = Vector3_new_ret.Magnitude <= u1.Range + (p5 or 0);
    else
        v7 = false;
    end;

    return v7;
end;

return table.freeze(u1);