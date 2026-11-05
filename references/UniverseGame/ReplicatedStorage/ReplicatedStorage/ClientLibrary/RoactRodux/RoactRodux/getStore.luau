  

 

local storeKey = require(script.Parent.storeKey);

return function(p1) -- Line: 3, Name: getStore
    -- upvalues: storeKey (copy)
    return p1._context[storeKey];
end;