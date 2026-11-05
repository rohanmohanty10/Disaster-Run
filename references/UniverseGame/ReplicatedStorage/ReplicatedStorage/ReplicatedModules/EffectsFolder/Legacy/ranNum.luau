  

 

local u1 = Random.new();

return function(p2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;