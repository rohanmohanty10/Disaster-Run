  

local RunService = game:GetService("RunService");
local useSignal = require(script.Parent.useSignal);

return function(u1: function, p2: table?) -- Line: 6, Name: useHeartbeat
    -- upvalues: useSignal (copy), RunService (copy)
    useSignal(RunService.Heartbeat, function(p3) -- Line: 7
        -- upvalues: u1 (copy)
        debug.profilebegin("RELICSxyz - useHeartbeat");
        u1(p3);
        debug.profileend();
    end);
end;