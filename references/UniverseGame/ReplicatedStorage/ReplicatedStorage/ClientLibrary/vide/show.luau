  

 

if not game then
    script = require("test/relative-string");
end;

local switch = require(script.Parent.switch);

return function(u1, p2, p3) -- Line: 5, Name: show
    -- upvalues: switch (copy)
    return switch(function() -- Line: 6, Name: truthy
        -- upvalues: u1 (copy)
        return u1() and true or false;
    end)({
        [true] = p2,
        [false] = p3
    });
end;