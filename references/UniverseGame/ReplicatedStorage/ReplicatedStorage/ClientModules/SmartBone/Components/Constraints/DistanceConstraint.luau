  

 

local function SafeUnit(p1) -- Line: 1
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit;
end;

return function(p2, p3, p4) -- Line: 9
    debug.profilebegin("Distance Constraint");
    local v5 = p4.Bones[p2.ParentIndex];

    if v5 then
        local v6 = p3 - v5.Position;
        local v7 = v5.Position + (v6.Magnitude == 0 and Vector3.new(0, 0, 0) or v6.Unit) * p2.FreeLength;
        debug.profileend();

        return v7;
    end;

    debug.profileend();
end;