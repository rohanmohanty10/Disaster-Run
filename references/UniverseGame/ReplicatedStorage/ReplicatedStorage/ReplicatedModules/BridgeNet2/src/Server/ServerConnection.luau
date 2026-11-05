  

 

local ServerProcess = require(script.Parent.ServerProcess);
local v1 = {};
local u3 = {
    __index = v1,

    __tostring = function(p2) -- Line: 10, Name: __tostring
        return "ServerConnection";
    end
};

function v1.Disconnect(p4) -- Line: 14
    p4.Connected = nil;
    p4._disconnectCallback();
    table.clear(p4);
    setmetatable(p4, nil);
end;

return function(p5, p6) -- Line: 23
    -- upvalues: u3 (copy), ServerProcess (copy)
    local v7 = setmetatable({
        Connected = true,

        _disconnectCallback = function() -- Line: 27, Name: _disconnectCallback
        end
    }, u3);
    v7._disconnectCallback = ServerProcess.connect(p5, p6);

    return v7;
end;