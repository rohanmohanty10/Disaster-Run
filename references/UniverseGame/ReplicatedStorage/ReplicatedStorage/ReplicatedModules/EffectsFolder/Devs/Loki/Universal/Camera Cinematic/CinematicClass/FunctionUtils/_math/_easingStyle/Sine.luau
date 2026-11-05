  

 

local sin = math.sin;

return function(p1) -- Line: 4
    -- upvalues: sin (copy)
    return sin(p1 * 1.5707963267948966 - 1.5707963267948966) + 1;
end;