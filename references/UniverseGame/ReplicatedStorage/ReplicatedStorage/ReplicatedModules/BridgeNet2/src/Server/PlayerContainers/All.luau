  

 

require(script.Parent.Parent.Parent.Types);
local Output = require(script.Parent.Parent.Parent.Utilities.Output);
local u1 = {
    kind = "all",
    value = nil
};
table.freeze(u1);

return function(...) -- Line: 10
    -- upvalues: Output (copy), u1 (copy)
    Output.warnAssert(select("#", ...) == 0, "incorrect number of arguments passed to player container");

    return u1;
end;