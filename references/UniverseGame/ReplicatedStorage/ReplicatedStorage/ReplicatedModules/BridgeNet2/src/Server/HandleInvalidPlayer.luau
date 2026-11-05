  

 

local Output = require(script.Parent.Parent.Utilities.Output);

return function(p1) -- Line: 8
    -- upvalues: Output (copy)
    Output.warn(string.format("Player %*:%* sent an invalid packet. Likely exploiter- or something interacted with the internal BridgeNet API.", p1.Name, p1.UserId));
end;