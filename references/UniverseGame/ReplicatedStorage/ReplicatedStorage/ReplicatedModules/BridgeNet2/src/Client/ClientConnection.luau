  

 

local ClientProcess = require(script.Parent.ClientProcess);
local v1 = {};
local u3 = {
    __index = v1,

    __tostring = function(p2) -- Line: 9, Name: __tostring
        return "ClientConnection";
    end
};

function v1.Disconnect(p4) -- Line: 13
    p4.Connected = nil;
    p4._disconnectCallback();
    table.clear(p4);
    setmetatable(p4, nil);
end;

return function(p5, p6) -- Line: 22
    -- upvalues: u3 (copy), ClientProcess (copy)
    local v7 = setmetatable({
        Connected = true,

        _disconnectCallback = function() -- Line: 26, Name: _disconnectCallback
        end
    }, u3);
    v7._disconnectCallback = ClientProcess.connect(p5, p6);

    return v7;
end;