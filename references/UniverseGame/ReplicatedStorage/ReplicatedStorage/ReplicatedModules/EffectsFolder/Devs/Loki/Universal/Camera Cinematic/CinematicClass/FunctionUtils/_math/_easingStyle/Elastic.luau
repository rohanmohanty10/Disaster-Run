  

 

local sin = math.sin;

return function(p1) -- Line: 6
    -- upvalues: sin (copy)
    return -(2 ^ (10 * (p1 - 1)) * sin((p1 - 1 - 0.075) * 6.283185307179586 / 0.3));
end;