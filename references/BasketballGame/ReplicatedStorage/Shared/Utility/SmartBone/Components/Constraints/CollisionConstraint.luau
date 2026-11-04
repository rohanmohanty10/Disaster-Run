 
 

return function(p1, p2, p3) -- Line: 1
    debug.profilebegin("Collision Constraint");
    local v4 = {};
    local v5 = {};

    for _, v in p3 do
        local Collisions = v:GetCollisions(p2, p1.Radius);

        if #Collisions > 0 then
            table.insert(v4, v:GetObject());
        end;

        for _, v2 in Collisions do
            table.insert(v5, v2);
        end;
    end;

    for _, v in v5 do
        p2 = v.ClosestPoint + v.Normal * p1.Radius;
    end;

    p1.CollisionsData = v5;
    p1.CollisionHits = v4;
    debug.profileend();

    return p2;
end;