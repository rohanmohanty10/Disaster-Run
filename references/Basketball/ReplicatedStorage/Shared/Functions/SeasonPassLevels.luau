 
 

return function(p1: number) -- Line: 2, Name: calculateLevel
    local v2 = 30;
    local v3 = 0;

    while v2 <= p1 do
        p1 = p1 - v2;
        v2 = v2 + 5;
        v3 = v3 + 1;
    end;

    return v3, p1, v2;
end;