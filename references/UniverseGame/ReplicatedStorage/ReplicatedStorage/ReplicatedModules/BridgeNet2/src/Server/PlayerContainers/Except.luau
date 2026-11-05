  

 

require(script.Parent.Parent.Parent.Types);
local Output = require(script.Parent.Parent.Parent.Utilities.Output);

return function(p1, ...) -- Line: 5
    -- upvalues: Output (copy)
    Output.warnAssert(select("#", ...) == 0, "incorrect number of arguments passed to player container");

    return {
        kind = "except",
        value = p1
    };
end;