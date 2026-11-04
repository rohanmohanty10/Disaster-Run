 
 

return function(p1: vector, p2: vector, p3: number, p4: number?) -- Line: 3
    local v5 = p4 or workspace.Gravity;
    local v6 = p2 - p1;
    local Vector3_new_ret = Vector3.new(v6.X, 0, v6.Z);
    local Unit = Vector3_new_ret.Unit;

    return Vector3_new_ret.Magnitude / ((p3 + math.sqrt(p3 ^ 2 - v6.Y * 2 * v5)) / v5) * Unit + p3 * Vector3.new(0, 1, 0);
end;