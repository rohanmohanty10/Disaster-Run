  

 

return function(p1) -- Line: 1
    p1.Util = {};
    p1.Util.Order = require(script:WaitForChild("Order"));
    p1.Util.Mapping = require(script:WaitForChild("Mapping"));
    p1.Util.Tooltip = require(script:WaitForChild("Tooltip"));

    for i, v in p1.Util.Mapping do
        p1.Util.Mapping[i:upper()] = v;
    end;
end;